From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  6 Apr 2017 19:29:07 +0100
Subject: [PATCHv2 00/16] arm_pmu: ACPI support
Message-ID: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series implements ACPI support in the ARM PMU code. It borrows some code
from Jeremy's series [1], but takes a different approach to probing and
association, using the usual hotplug state machine, minimising external changes
required, and simplifying the relationship with the common arm_pmu code.

The first few patches are preparatory cleanup/refactoring, with the latter half
of the series being specific to ACPI support.

The series is based on Will's perf/updates branch [2]. I've pushed the whole
series out to the arm/perf/acpi branch [3] of my kernel.org repo.

Due to the innards of the hotplug callback framework, it's not entirely
safe to register a PMU in a hotplug callback. Due to this, we can only
associated hotplugged CPUs with a PMU if a matching CPU was around at
probe time. A similar restriction already applies to DT systems. We may
be able to relax this with some future work.

I've given this some testing on a Juno platform (using SPIs). To see that IRQs
are correctly associated, I've tested with the following:

  $ taskset -c ${SOME_CPU_HERE} perf record \
    -e armv8_pmuv3_0/cpu_cycles/ \
    -e armv8_pmuv3_1/cpu_cycles/ \
    cat /proc/interrupts
 
I've also booted with nr_cpus temporarily capped (passing maxcpus=) to test the
association logic. This has also been tested in a VM using PPIs; I do not have
access to a host machine which itself uses PPIs.

Since v1 [4]:
* Fix up ACPI bits per Lorenzo's request
* Accumulate tags
* Check presence of PMUv3

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/482397.html
[2] git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git perf/updates
[3] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm/perf/acpi
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/492897.html

Mark Rutland (16):
  drivers/perf: arm_pmu: remove pointless PMU disabling
  drivers/perf: arm_pmu: define armpmu_init_fn
  drivers/perf: arm_pmu: fold init into alloc
  drivers/perf: arm_pmu: factor out pmu registration
  drivers/perf: arm_pmu: simplify cpu_pmu_request_irqs()
  drivers/perf: arm_pmu: handle no platform_device
  drivers/perf: arm_pmu: rename irq request/free functions
  drivers/perf: arm_pmu: split cpu-local irq request/free
  drivers/perf: arm_pmu: move irq request/free into probe
  drivers/perf: arm_pmu: split out platform device probe logic
  arm64: add function to get a cpu's MADT GICC table
  arm64: parking: kill acpi_set_mailbox_entry()
  arm64: parking: fix type endianness
  drivers/perf: arm_pmu: add ACPI framework
  arm64: pmuv3: handle !PMUv3 when probing
  arm64: pmuv3: use arm_pmu ACPI framework

 arch/arm64/include/asm/acpi.h             |   7 +-
 arch/arm64/kernel/acpi_parking_protocol.c |  44 ++--
 arch/arm64/kernel/perf_event.c            | 111 ++++++---
 arch/arm64/kernel/smp.c                   |  19 +-
 drivers/perf/Kconfig                      |   4 +
 drivers/perf/Makefile                     |   3 +-
 drivers/perf/arm_pmu.c                    | 387 ++++++++----------------------
 drivers/perf/arm_pmu_acpi.c               | 240 ++++++++++++++++++
 drivers/perf/arm_pmu_platform.c           | 235 ++++++++++++++++++
 include/linux/cpuhotplug.h                |   1 +
 include/linux/perf/arm_pmu.h              |  22 +-
 11 files changed, 704 insertions(+), 369 deletions(-)
 create mode 100644 drivers/perf/arm_pmu_acpi.c
 create mode 100644 drivers/perf/arm_pmu_platform.c

-- 
1.9.1
