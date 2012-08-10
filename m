From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Aug 2012 18:36:26 +0100
Subject: [PATCH 0/9] ARM perf updates for 3.7
Message-ID: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series contains the ARM perf updates I'd like to push for 3.7
Most of the code is cleanup in preparation for big.LITTLE PMU support,
where we will need to support different types of CPU PMU on the same SoC.

The PMU probing has changed so that we try to identify the PMU using its
DT binding before falling back to probing the current core. The unused
PMU registration mechanism is also removed and platforms registering
the device have been updated accordingly.

Given that this touches a few platforms, I anticipate sending it via
arm-soc.

All feedback welcome,

Will


Jon Hunter (1):
  ARM: PMU: Add runtime PM Support

Sudeep KarkadaNagesha (2):
  ARM: pmu: remove arm_pmu_type enumeration
  ARM: perf: move irq registration into pmu implementation

Will Deacon (6):
  ARM: perf: add devicetree bindings for 11MPcore, A5, A7 and A15 PMUs
  ARM: pmu: remove unused reservation mechanism
  ARM: perf: remove mysterious compiler barrier
  ARM: perf: probe devicetree in preference to current CPU
  ARM: perf: prepare for moving CPU PMU code into separate file
  ARM: perf: move CPU-specific PMU handling code into separate file

 Documentation/devicetree/bindings/arm/pmu.txt |    4 +
 MAINTAINERS                                   |    1 -
 arch/arm/Kconfig                              |    8 +-
 arch/arm/include/asm/perf_event.h             |    9 +-
 arch/arm/include/asm/pmu.h                    |   77 ++----
 arch/arm/kernel/Makefile                      |    3 +-
 arch/arm/kernel/perf_event.c                  |  347 ++++---------------------
 arch/arm/kernel/perf_event_cpu.c              |  295 +++++++++++++++++++++
 arch/arm/kernel/perf_event_v6.c               |   12 +-
 arch/arm/kernel/perf_event_v7.c               |   32 ++--
 arch/arm/kernel/perf_event_xscale.c           |   10 +-
 arch/arm/kernel/pmu.c                         |   36 ---
 arch/arm/mach-bcmring/arch.c                  |    3 +-
 arch/arm/mach-omap2/devices.c                 |    3 +-
 arch/arm/mach-pxa/devices.c                   |    3 +-
 arch/arm/mach-realview/realview_eb.c          |    3 +-
 arch/arm/mach-realview/realview_pb1176.c      |    3 +-
 arch/arm/mach-realview/realview_pb11mp.c      |    3 +-
 arch/arm/mach-realview/realview_pba8.c        |    3 +-
 arch/arm/mach-realview/realview_pbx.c         |    3 +-
 arch/arm/mach-tegra/devices.c                 |    3 +-
 arch/arm/mach-ux500/cpu-db8500.c              |    3 +-
 arch/arm/mach-vexpress/ct-ca9x4.c             |    3 +-
 arch/arm/plat-iop/pmu.c                       |    3 +-
 arch/arm/plat-samsung/devs.c                  |    3 +-
 25 files changed, 424 insertions(+), 449 deletions(-)
 create mode 100644 arch/arm/kernel/perf_event_cpu.c
 delete mode 100644 arch/arm/kernel/pmu.c

-- 
1.7.4.1
