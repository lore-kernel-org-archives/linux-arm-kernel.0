From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  6 Mar 2017 11:26:05 +0000
Subject: [PATCH 00/17] clocksource/arch_timer: Errara workaround
 infrastructure rework
Message-ID: <20170306112622.13853-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It has recently become obvious that a number of arm64 systems have
been blessed with a set of timers that are slightly less than perfect,
and require a bit of hand-holding. We already have a bunch of
errata-specific code to deal with this, but as we're adding more
potential detection methods (DT, ACPI, capability), things are getting
a bit out of hands.

Instead of adding more ad-hoc fixes to an already difficult code base,
let's give ourselves a bit of an infrastructure that can deal with
this and hide most of the uggliness behind frendly accessors.

The series is structured as such:

- The first half of the series rework the existing workarounds,
  allowing errata to be matched using a given detection method

- Another patch allows a workaround to affect a subset of the CPUs,
  and not the whole system

- Another set of patches allow the virtual counter to be trapped when
  accessed from userspace (something that affects the current set of
  broken platform, and that is not worked around yet)

- We then work around a Cortex-A73 erratum, whose counter can return a
  wrong value if read while crossing a 32bit boundary

- Finally, we add some ACPI-specific workarounds for HiSilicon
  platforms that have the HISILICON_ERRATUM_161010101 defect.

Note that so far, we only deal with arm64. Once the infrastructure is
agreed upon, we can look at generalizing it (to some extent) to 32bit
ARM (typical use case would be a 32bit guest running on an affected
host).

Thanks,

	M.

Marc Zyngier (17):
  arm64: arch_timer: Add infrastructure for multiple erratum detection
    methods
  arm64: arch_timer: Add erratum handler for globally defined capability
  arm64: Allow checking of a CPU-local erratum
  arm64: arch_timer: Add erratum handler for CPU-specific capability
  arm64: arch_timer: Move arch_timer_reg_read/write around
  arm64: arch_timer: Get rid of erratum_workaround_set_sne
  arm64: arch_timer: Rework the set_next_event workarounds
  arm64: arch_timer: Make workaround methods optional
  arm64: arch_timer: Allows a CPU-specific erratum to only affect a
    subset of CPUs
  arm64: Add CNTVCT_EL0 trap handler
  arm64: arch_timer: Move clocksource_counter and co around
  arm64: arch_timer: Enable CNTVCT_EL0 trap if workaround is enabled
  arm64: cpu_errata: Allow an erratum to be match for all revisions of a
    core
  arm64: Define Cortex-A73 MIDR
  arm64: arch_timer: Workaround for Cortex-A73 erratum 858921
  arm64: arch_timer: Allow erratum matching with ACPI OEM information
  arm64: arch_timer: Add HISILICON_ERRATUM_161010101 ACPI matching data

 Documentation/arm64/silicon-errata.txt |   1 +
 arch/arm64/include/asm/arch_timer.h    |  44 ++-
 arch/arm64/include/asm/cpucaps.h       |   3 +-
 arch/arm64/include/asm/cputype.h       |   2 +
 arch/arm64/include/asm/esr.h           |   2 +
 arch/arm64/kernel/cpu_errata.c         |  15 +
 arch/arm64/kernel/cpufeature.c         |  13 +-
 arch/arm64/kernel/traps.c              |  14 +
 drivers/clocksource/Kconfig            |  11 +
 drivers/clocksource/arm_arch_timer.c   | 529 +++++++++++++++++++++++----------
 10 files changed, 465 insertions(+), 169 deletions(-)

-- 
2.11.0
