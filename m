From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu,  7 Jul 2016 18:10:45 +0100
Subject: [PATCH v8 0/6] ACPI / processor_idle: Add ACPI v6.0 LPI support
Message-ID: <1467911451-24731-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI 6.0 introduced LPI(Low Power Idle) states that provides an alternate
method to describe processor idle states. It extends the specification
to allow the expression of idle states like C-states selectable by the
OSPM when a processor goes idle, but may affect more than one processor,
and may affect other system components.

LPI extensions leverages the processor container device(again introduced
in ACPI 6.0) allowing to express which parts of the system are affected
by a given LPI state. It defines the local power states for each node
in a hierarchical processor topology. The OSPM can use _LPI object to
select a local power state for each level of processor hierarchy in the
system. They used to produce a composite power state request that is
presented to the platform by the OSPM.

Since multiple processors affect the idle state for any non-leaf hierarchy
node, coordination of idle state requests between the processors is
required. ACPI supports two different coordination schemes: Platform
coordinated and  OS initiated.

This series aims at providing basic and initial support for platform
coordinated LPI states.

v7[7]->v8:
	- Replaced HAVE_GENERIC_CPUIDLE_ENTER with CPU_IDLE_ENTER_WRAPPED
	  macro, which is more cleaner and definately less confusing :)
	  (Thanks to Rafael for the suggestion)

v6[6]->v7:
	- Removed cpuidle-arm.h and introduced HAVE_GENERIC_CPUIDLE_ENTER
	  and move the common code to cpuidle_generic_enter{,_state}
	- Factored out common code between psci_{dt,acpi}_cpu_init_idle

v5[5]->v6:
	- Added support for autopromotable state by not flattening them
	- Moved arm_enter_idle_state to cpuidle-arm.h as it can be reused
	  in ARM64 backend for ACPI LPI
	- Other review comments(mainly for ARM64 from Lorenzo)
	- Dropped support for skipping PM notifier as it needs to be fixed
	  in GICv3 code(will be done separately)

v4[4]->v5:
	- Addressed all the comments from Rafael
	- Added support for retention mode(Prashant)
	- Handled acpi_processor_get_power_info return value correctly(Vikas)
	- Dropped __init from arm_cpuidle_init
	- Merged psci prepartory patch into arm64 lpi support

v3[3]->v4:
	- Dropped the preparatory patches that are merged already
	- Added ARM64 arch specific callback implementations
	- Addressed most of the review comments from Rafael

v2[2]->v3:
        - rebased against v4.4-rc3
        - fixed couple of issues reported by Prashanth and review comments
          from Ashwin

v1[1]->v2[2]:
        - Fixed support for ACPI0010 processor container
        - moved sleep state code out of processor_idle

Code is also available @[8]

Regards,
Sudeep

[1] http://marc.info/?l=linux-acpi&m=143871041601132&w=2
[2] http://marc.info/?l=linux-acpi&m=144241209800788&w=2
[3] http://marc.info/?l=linux-acpi&m=144906557814813&w=2
[4] http://marc.info/?l=linux-acpi&m=146106902731359&w=2
[5] http://marc.info/?l=linux-acpi&m=146298107608349&w=2
[6] http://marc.info/?l=linux-acpi&m=146591573516602&w=2
[7] http://marc.info/?l=linux-acpi&m=146712226917361&w=2
[8] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git for_review/arm64_lpi

Sudeep Holla (6):
  ACPI / processor_idle: introduce ACPI_PROCESSOR_CSTATE
  ACPI / processor_idle: Add support for Low Power Idle(LPI) states
  arm64: cpuidle: drop __init section marker to arm_cpuidle_init
  cpuidle: introduce CPU_IDLE_ENTER_WRAPPED macro for ARM{32,64}
  arm64: add support for ACPI Low Power Idle(LPI)
  ACPI : enable ACPI_PROCESSOR_IDLE on ARM64

 arch/arm64/kernel/cpuidle.c     |  20 +-
 drivers/acpi/Kconfig            |   6 +-
 drivers/acpi/bus.c              |  14 +-
 drivers/acpi/processor_driver.c |   2 +-
 drivers/acpi/processor_idle.c   | 544 ++++++++++++++++++++++++++++++++++------
 drivers/cpuidle/cpuidle-arm.c   |  26 +-
 drivers/firmware/psci.c         | 122 +++++++--
 include/acpi/processor.h        |  26 +-
 include/linux/acpi.h            |   4 +
 include/linux/cpuidle.h         |  18 ++
 10 files changed, 652 insertions(+), 130 deletions(-)

--
2.7.4
