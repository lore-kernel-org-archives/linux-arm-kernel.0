From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 29 Aug 2016 16:48:11 -0500
Subject: [PATCH v8 0/9] Enable PMUs in ACPI systems
Message-ID: <1472507300-9844-1-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v8:
Rebase to 4.8rc4
Assorted minor comment/hunk placement/etc tweaks per Punit Agrawal

v7:
Rebase to 4.8rc3
Remove cpu affinity sysfs entry. While providing a CPU mask for
ARMv8 PMU's is really helpful in big/little environments, reworking
the PMU code to support the cpumask attribute for !arm64 PMUs is out
of the scope of this patch set.
Fix CPU miscount problem where an alloc failure followed by successfully
allocating the structure can result in under counting the CPUs associated
with the PMU. This bug was created in v6 with the conversion to a linked
list.
Remove initial platform device creation code by Mark Salter, and re-squash
multiple platform device creation code together with helper routines.
Other minor tweakage.

v6:
Added cpu affinity sysfs entry
Converted pmu_types array, to linked list
Restrict use of the armv8_pmu_probe_table to ACPI systems
Rename MADT parsing routines in smp.c
Convert sysfs PMU name to use index rather than partnum
Remove pr_devel statements
Other Minor cleanups
Add Partial Ack-by Will Deacon

v5:
Remove list of CPU types for ACPI systems. We now match a generic
event list, and use the PMCIED[01] to select events which exist on
the given PMU. This avoids the need to update the kernel every time
a new CPU is released.
Update the maintainers list to include the new file.

v4:
Correct build issues with ARM (!ARM64) kernels.
Add ThunderX to list of PMU types.

v3:
Enable ARM performance monitoring units on ACPI/arm64 machines.

This patch expands and reworks the patches published by Mark Salter
in order to clean up a few of the previous review comments, as well as
add support for newer CPUs and big/little configurations.

Jeremy Linton (7):
  arm64: pmu: Probe default hw/cache counters
  arm64: pmu: Hoist pmu platform device name
  arm64: Rename the common MADT parse routine
  arm: arm64: Add routine to determine cpuid of other cpus
  arm: arm64: pmu: Assign platform PMU CPU affinity
  arm64: pmu: Detect and enable multiple PMUs in an ACPI system
  MAINTAINERS: Tweak ARM PMU maintainers

Mark Salter (2):
  arm64: pmu: add fallback probe table
  arm64: pmu: Cache PMU interrupt numbers from MADT parse

 MAINTAINERS                      |   3 +-
 arch/arm/include/asm/cputype.h   |   2 +
 arch/arm64/include/asm/cputype.h |   3 +
 arch/arm64/kernel/perf_event.c   |  58 ++++++++++-
 arch/arm64/kernel/smp.c          |  18 ++--
 drivers/perf/Kconfig             |   4 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/arm_pmu.c           |  71 +++++++++++--
 drivers/perf/arm_pmu_acpi.c      | 218 +++++++++++++++++++++++++++++++++++++++
 include/linux/perf/arm_pmu.h     |   9 ++
 10 files changed, 364 insertions(+), 23 deletions(-)
 create mode 100644 drivers/perf/arm_pmu_acpi.c

-- 
2.5.5
