From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 19 Apr 2016 13:30:08 +0100
Subject: [PATCH v4 0/5] ACPI / processor_idle: Add ACPI v6.0 LPI support
Message-ID: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
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

Code is also available @[4]

Regards,
Sudeep

[1] http://marc.info/?l=linux-acpi&m=143871041601132&w=2
[2] http://marc.info/?l=linux-acpi&m=144241209800788&w=2
[3] http://marc.info/?l=linux-acpi&m=144906557814813&w=2
[4] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git for_review/arm64_lpi

Sudeep Holla (5):
  ACPI / processor_idle: introduce ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE
  ACPI / processor_idle: Add support for Low Power Idle(LPI) states
  drivers: psci: refactor psci_cpu_init_idle in preparation for ACPI LPI support
  arm64: add support for ACPI Low Power Idle(LPI)
  ACPI : enable ACPI_PROCESSOR_IDLE on ARM64

 arch/arm64/Kconfig              |   1 +
 arch/arm64/kernel/acpi.c        |  34 +++
 arch/ia64/Kconfig               |   1 +
 arch/x86/Kconfig                |   1 +
 drivers/acpi/Kconfig            |   5 +-
 drivers/acpi/bus.c              |  11 +-
 drivers/acpi/processor_driver.c |   2 +-
 drivers/acpi/processor_idle.c   | 511 ++++++++++++++++++++++++++++++++++------
 drivers/firmware/psci.c         |  63 ++++-
 include/acpi/processor.h        |  28 ++-
 include/linux/acpi.h            |   4 +
 11 files changed, 566 insertions(+), 95 deletions(-)

--
1.9.1
