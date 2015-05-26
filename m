From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 17:31:10 +0100
Subject: [PATCH 0/6] arm64: perf: heterogeneous PMU support
Message-ID: <1432657876-1362-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series reworks the arm64 perf code, migrating it to the
shared PMU library and implementing CPU-specific PMU bindings. In doing
so the arm64 perf backend gains support for heterogeneous PMUs.

This series is based on both "ARM: perf: heterogeneous PMU support" [1], and
"ARM: perf: rework core into library" [2], applied sequentially.

The features and limitations laid out in [1] also apply to the arm64
implementation, as demonstrated by sample runs on Juno with the series applied:

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

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/343144.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/346538.html

Mark Rutland (6):
  arm64: perf: factor out callchain code
  arm64: perf: move to shared arm_pmu framework
  arm64: perf: condense event number maps
  arm64: perf: add Cortex-A53 support
  arm64: perf: add Cortex-A57 support
  arm64: dts: juno: describe PMUs separately

 Documentation/devicetree/bindings/arm/pmu.txt |    2 +
 arch/arm64/Kconfig                            |    8 +-
 arch/arm64/boot/dts/arm/juno.dts              |   18 +-
 arch/arm64/include/asm/perf_event.h           |    2 +-
 arch/arm64/include/asm/pmu.h                  |   83 --
 arch/arm64/kernel/Makefile                    |    4 +-
 arch/arm64/kernel/perf_callchain.c            |  196 +++
 arch/arm64/kernel/perf_event.c                | 1592 -------------------------
 arch/arm64/kernel/perf_event_pmuv3.c          |  684 +++++++++++
 drivers/perf/Kconfig                          |    2 +-
 10 files changed, 899 insertions(+), 1692 deletions(-)
 delete mode 100644 arch/arm64/include/asm/pmu.h
 create mode 100644 arch/arm64/kernel/perf_callchain.c
 delete mode 100644 arch/arm64/kernel/perf_event.c
 create mode 100644 arch/arm64/kernel/perf_event_pmuv3.c

-- 
1.9.1
