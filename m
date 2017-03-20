From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Mar 2017 15:25:47 +0000
Subject: [PATCH 00/17] clocksource/arch_timer: Errara workaround
 infrastructure rework
In-Reply-To: <20170320150752.GK31213@leverpostej>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
 <20170320150752.GK31213@leverpostej>
Message-ID: <29778c14-f737-568e-c3ea-b73d97d6c057@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/17 15:07, Mark Rutland wrote:
> On Mon, Mar 06, 2017 at 11:26:05AM +0000, Marc Zyngier wrote:
>> It has recently become obvious that a number of arm64 systems have
>> been blessed with a set of timers that are slightly less than perfect,
>> and require a bit of hand-holding. We already have a bunch of
>> errata-specific code to deal with this, but as we're adding more
>> potential detection methods (DT, ACPI, capability), things are getting
>> a bit out of hands.
>>
>> Instead of adding more ad-hoc fixes to an already difficult code base,
>> let's give ourselves a bit of an infrastructure that can deal with
>> this and hide most of the uggliness behind frendly accessors.
> 
>>  Documentation/arm64/silicon-errata.txt |   1 +
>>  arch/arm64/include/asm/arch_timer.h    |  44 ++-
>>  arch/arm64/include/asm/cpucaps.h       |   3 +-
>>  arch/arm64/include/asm/cputype.h       |   2 +
>>  arch/arm64/include/asm/esr.h           |   2 +
>>  arch/arm64/kernel/cpu_errata.c         |  15 +
>>  arch/arm64/kernel/cpufeature.c         |  13 +-
>>  arch/arm64/kernel/traps.c              |  14 +
>>  drivers/clocksource/Kconfig            |  11 +
>>  drivers/clocksource/arm_arch_timer.c   | 529 +++++++++++++++++++++++----------
>>  10 files changed, 465 insertions(+), 169 deletions(-)
> 
> Largely this looks ok.
> 
> What's the plan for merging this?
> 
> If you can respin this, I can see about collating this with the ACPI
> GTDT patches, but I'm not sure what to do about the arch/arm64/ parts.

If Will/Catalin agree with the arm64-specific patches (which I can
probably move to the beginning of the series), we can have a shared
branch that gets merged via both the arm64 and clocksource trees.

Or we get everything merged via arm64, which wouldn't be that bad either
given that this code (and the GTDT patches) only targets arm64. We'd
need Daniel's Ack though.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
