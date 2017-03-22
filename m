From: dingtianhong@huawei.com (Ding Tianhong)
Date: Wed, 22 Mar 2017 21:56:04 +0800
Subject: [PATCH v2 00/18] clocksource/arch_timer: Errata workaround
 infrastructure rework
In-Reply-To: <20170320174829.28182-1-marc.zyngier@arm.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
Message-ID: <ae4efcb5-bd0a-5ee2-3fa1-41874b7dc85e@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Ding Tianhong <dingtianhong@huawei.com>

On 2017/3/21 1:48, Marc Zyngier wrote:
> It has recently become obvious that a number of arm64 systems have
> been blessed with a set of timers that are slightly less than perfect,
> and require a bit of hand-holding. We already have a bunch of
> errata-specific code to deal with this, but as we're adding more
> potential detection methods (DT, ACPI, capability), things are getting
> a bit out of hands.
> 
> Instead of adding more ad-hoc fixes to an already difficult code base,
> let's give ourselves a bit of an infrastructure that can deal with
> this and hide most of the uggliness behind frendly accessors.
> 
> The series is structured as such:
> 
> - A bunch of arm64 specific patches that allow the rest of the
>   workaround infrastructure to be built upon (such as being able to
>   trap userspace access to the virtual counter). These are now
>   separate in order to allow the creation of a shared branch between
>   the arm64 and clocksource trees.
> 
> - The following patches rework the existing workarounds, allowing
>   errata to be matched using a given detection method
> 
> - Another patch allows a workaround to affect a subset of the CPUs,
>   and not the whole system
> 
> - We then work around a Cortex-A73 erratum, whose counter can return a
>   wrong value if read while crossing a 32bit boundary
> 
> - Finally, we add some ACPI-specific workarounds for HiSilicon
>   platforms that have the HISILICON_ERRATUM_161010101 defect.
> 
> Note that so far, we only deal with arm64. Once the infrastructure is
> agreed upon, we can look at generalizing it (to some extent) to 32bit
> ARM (typical use case would be a 32bit guest running on an affected
> host).
> 
> * From v1:
>   - Addressed Hanjun and Mark review comments
>   - Moved arm64 specific patches to the beginning of the series,
>     leaving the clocksource patches at the end, resulting in an extra
>     patch.
>   - Added RBs, TBs, and Acks.
> 
> Marc Zyngier (18):
>   arm64: Allow checking of a CPU-local erratum
>   arm64: Add CNTVCT_EL0 trap handler
>   arm64: Define Cortex-A73 MIDR
>   arm64: cpu_errata: Allow an erratum to be match for all revisions of a
>     core
>   arm64: cpu_errata: Add capability to advertise Cortex-A73 erratum
>     858921
>   arm64: arch_timer: Add infrastructure for multiple erratum detection
>     methods
>   arm64: arch_timer: Add erratum handler for globally defined capability
>   arm64: arch_timer: Add erratum handler for CPU-specific capability
>   arm64: arch_timer: Move arch_timer_reg_read/write around
>   arm64: arch_timer: Get rid of erratum_workaround_set_sne
>   arm64: arch_timer: Rework the set_next_event workarounds
>   arm64: arch_timer: Make workaround methods optional
>   arm64: arch_timer: Allows a CPU-specific erratum to only affect a
>     subset of CPUs
>   arm64: arch_timer: Move clocksource_counter and co around
>   arm64: arch_timer: Enable CNTVCT_EL0 trap if workaround is enabled
>   arm64: arch_timer: Workaround for Cortex-A73 erratum 858921
>   arm64: arch_timer: Allow erratum matching with ACPI OEM information
>   arm64: arch_timer: Add HISILICON_ERRATUM_161010101 ACPI matching data
> 
>  Documentation/arm64/silicon-errata.txt |   1 +
>  arch/arm64/include/asm/arch_timer.h    |  44 ++-
>  arch/arm64/include/asm/cpucaps.h       |   3 +-
>  arch/arm64/include/asm/cputype.h       |   2 +
>  arch/arm64/include/asm/esr.h           |   2 +
>  arch/arm64/kernel/cpu_errata.c         |  15 +
>  arch/arm64/kernel/cpufeature.c         |  13 +-
>  arch/arm64/kernel/traps.c              |  14 +
>  drivers/clocksource/Kconfig            |  11 +
>  drivers/clocksource/arm_arch_timer.c   | 535 +++++++++++++++++++++++----------
>  10 files changed, 471 insertions(+), 169 deletions(-)
> 
