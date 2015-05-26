From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 17:23:33 +0100
Subject: [PATCH 0/7] ARM: perf: rework core into library
Message-ID: <1432657420-887-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series refactors the ARM perf code, splitting out the various
PMU architecture variants and refactoring the core into a reusable
library that may be shared with arm64 in future. These patches alone
should not result in any functional change, though due to header file
changes a small amount of platform code needs to be updated.

This series applies atop of the series titled "ARM: perf: heterogeneous
PMU support", previously posted to lakml [1].

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/343144.html

Mark Rutland (7):
  arm: perf: kill off unused pm callbacks
  arm: perf: share arm_pmu_device_probe
  arm: perf: factor out xscale pmu driver
  arm: perf: factor out armv6 pmu driver
  arm: perf: factor out armv7 pmu driver
  arm: perf: unify perf_event{,_cpu}.c
  arm: perf: factor arm_pmu core out to drivers

 arch/arm/Kconfig                                   |   8 +-
 arch/arm/kernel/Makefile                           |   3 +-
 arch/arm/kernel/perf_event_cpu.c                   | 422 ---------------------
 arch/arm/kernel/perf_event_v6.c                    |  49 ++-
 arch/arm/kernel/perf_event_v7.c                    |  77 ++--
 arch/arm/kernel/perf_event_xscale.c                |  32 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |   2 +-
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/perf/Kconfig                               |  14 +
 drivers/perf/Makefile                              |   1 +
 .../kernel/perf_event.c => drivers/perf/arm_pmu.c  | 375 ++++++++++++++++--
 .../asm/pmu.h => include/linux/perf/arm_pmu.h      |  22 +-
 13 files changed, 466 insertions(+), 542 deletions(-)
 delete mode 100644 arch/arm/kernel/perf_event_cpu.c
 create mode 100644 drivers/perf/Kconfig
 create mode 100644 drivers/perf/Makefile
 rename arch/arm/kernel/perf_event.c => drivers/perf/arm_pmu.c (64%)
 rename arch/arm/include/asm/pmu.h => include/linux/perf/arm_pmu.h (84%)

-- 
1.9.1
