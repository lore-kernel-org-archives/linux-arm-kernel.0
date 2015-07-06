From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  6 Jul 2015 12:23:52 +0100
Subject: [PATCHv3 0/9] arm64: perf: heterogeneous PMU support
Message-ID: <1436181842-19402-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series reworks the 32-bit ARM perf code into a library, and
migrates the arm64 perf code over to it, gaining support for
heterogeneous PMUs. Support is then added for Cortex-A53 and Cortex-A57
as used in Juno systems.

Previously the librification [1] and arm64 migration [2] were separate
series, but as the bulk of the librification made it for v4.2-rc1 the
remaining work is mostly trivial.

With this series applied, perf can be used to monitor 64-bit systems with
heterogeneous PMUs in an identical fashion to 32-bit systems, e.g.

$ perf stat -e armv8_cortex_a53/config=0x11/ -e armv8_cortex_a57/config=0x11/ ./a.out 

 Performance counter stats for './a.out':

         185250238 armv8_cortex_a53/config=0x11/                                    [55.34%]
         225006550 armv8_cortex_a57/config=0x11/                                    [43.96%]

       0.213953840 seconds time elapsed

$ perf stat -e cycles ./a.out 

 Performance counter stats for './a.out':

         830917902 cycles                    [64.60%]

       1.023141420 seconds time elapsed

Since v2 [3]:
* Rebase to v4.2-rc1
* Split MAINTAINERS changes
* Add arm64 perf code to MAINTAINERS entry

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/346538.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/346555.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/350109.html

Mark Rutland (9):
  arm: perf: factor arm_pmu core out to drivers
  arm64: perf: factor out callchain code
  arm64: perf: move to shared arm_pmu framework
  arm64: perf: condense event number maps
  arm64: perf: add Cortex-A53 support
  arm64: perf: add Cortex-A57 support
  arm64: dts: juno: describe PMUs separately
  MAINTAINERS: update ARM PMU profiling and debugging for arm64
  MAINTAINERS: add myself as arm perf reviewer

 Documentation/devicetree/bindings/arm/pmu.txt      |    2 +
 MAINTAINERS                                        |   11 +-
 arch/arm/Kconfig                                   |    8 +-
 arch/arm/kernel/Makefile                           |    3 +-
 arch/arm/kernel/perf_event_v6.c                    |    2 +-
 arch/arm/kernel/perf_event_v7.c                    |    2 +-
 arch/arm/kernel/perf_event_xscale.c                |    2 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |    2 +-
 arch/arm64/Kconfig                                 |    8 +-
 arch/arm64/boot/dts/arm/juno-r1.dts                |   18 +-
 arch/arm64/boot/dts/arm/juno.dts                   |   18 +-
 arch/arm64/include/asm/perf_event.h                |    2 +-
 arch/arm64/include/asm/pmu.h                       |   83 -
 arch/arm64/kernel/Makefile                         |    4 +-
 arch/arm64/kernel/perf_callchain.c                 |  196 +++
 arch/arm64/kernel/perf_event.c                     | 1594 --------------------
 arch/arm64/kernel/perf_event_pmuv3.c               |  684 +++++++++
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/perf/Kconfig                               |   14 +
 drivers/perf/Makefile                              |    1 +
 .../kernel/perf_event.c => drivers/perf/arm_pmu.c  |    2 +-
 .../asm/pmu.h => include/linux/perf/arm_pmu.h      |    4 +-
 23 files changed, 944 insertions(+), 1719 deletions(-)
 delete mode 100644 arch/arm64/include/asm/pmu.h
 create mode 100644 arch/arm64/kernel/perf_callchain.c
 delete mode 100644 arch/arm64/kernel/perf_event.c
 create mode 100644 arch/arm64/kernel/perf_event_pmuv3.c
 create mode 100644 drivers/perf/Kconfig
 create mode 100644 drivers/perf/Makefile
 rename arch/arm/kernel/perf_event.c => drivers/perf/arm_pmu.c (99%)
 rename arch/arm/include/asm/pmu.h => include/linux/perf/arm_pmu.h (98%)

-- 
1.9.1
