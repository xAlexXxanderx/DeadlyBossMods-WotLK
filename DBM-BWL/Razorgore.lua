local mod	= DBM:NewMod("Razorgore", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(12435)
mod:SetMinSyncRevision(168)
mod:RegisterCombat("yell", L.YellPull)--Will fail if msg find isn't used, msg match won't find yell since a line break is omitted
mod:SetWipeTime(45)--guesswork

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnConflagration		= mod:NewTargetAnnounce(23023)

local timerConflagration	= mod:NewTargetTimer(10, 23023)
local timerAddsSpawn		= mod:NewTimer(47, "TimerAddsSpawn", 19879)--Only for start of adds, not adds after the adds heh.

function mod:OnCombatStart(delay)
	timerAddsSpawn:Start()
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(23023) and args:IsDestTypePlayer() then
		warnConflagration:Show(args.destName)
		timerConflagration:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(23023) then
		timerConflagration:Start(args.destName)
	end
end