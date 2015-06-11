From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Jun 2015 17:44:13 +0100
Subject: [PATCHv2 0/7] arm64: perf: heterogeneous PMU support
Message-ID: <1434041060-16378-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series reworks the 32-bit ARM perf code into a library, and migrates
the arm64 perf code over to it, gaining support for heterogeneous PMUs. Support
is then added for Cortex-A53 and Cortex-A57 as used in Juno systems.

Previously the librification [1] and arm64 migration [2] were separate series,
but as the bulk of the librification has now been queued [3] and the remianing
work is mostly tirivial.

The first six patches apply atop of Will's perf/updates branch [3]. The final
patch must be applied atop of Liviu's for-upstream/juno-dts branch due to some
recent rework of the Juno dts files.

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

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/346538.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/346555.html
[3] https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/log/?h=perf/updates
[4] http://linux-arm.org/git?p=linux-ld.git;a=shortlog;h=refs/heads/for-upstream/juno-dts

Mark Rutland (7):
  arm: perf: factor arm_pmu core out to drivers
  arm64: perf: factor out callchain code
  arm64: perf: move to shared arm_pmu framework
  arm64: perf: condense event number maps
  arm64: perf: add Cortex-A53 support
  arm64: perf: add Cortex-A57 support
  arm64: dts: juno: describe PMUs separately

 Documentation/devicetree/bindings/arm/pmu.txt      |    2 +
 MAINTAINERS                                        |    6 +-
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
 arch/arm64/kernel/perf_event.c                     | 1587 --------------------
 arch/arm64/kernel/perf_event_pmuv3.c               |  684 +++++++++
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/perf/Kconfig                               |   14 +
 drivers/perf/Makefile                              |    1 +
 .../kernel/perf_event.c => drivers/perf/arm_pmu.c  |    2 +-
 .../asm/pmu.h => include/linux/perf/arm_pmu.h      |    4 +-
 23 files changed, 941 insertions(+), 1710 deletions(-)
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
