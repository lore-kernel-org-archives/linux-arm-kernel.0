From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  2 Oct 2015 10:55:02 +0100
Subject: [PATCHv4 0/6] arm64: perf: heterogeneous PMU support
Message-ID: <1443779708-26789-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series moves the arm64 code over to the librified perf code now used
by 32-bit arm, in the process gaining support for heterogeneous PMUs. Tailored
support is then added for Cortex-A53 and Cortex-A57 as used in Juno systems.

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

Since v2 [1]:
* Rebase to v4.2-rc1
* Split MAINTAINERS changes
* Add arm64 perf code to MAINTAINERS entry
Since v3 [2]
* Drop patches which made it for v4.3-rc1
* Don't bother with pmuv3 renaming

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/350109.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354287.html

Mark Rutland (6):
  arm64: perf: move to shared arm_pmu framework
  arm64: perf: add Cortex-A53 support
  arm64: perf: add Cortex-A57 support
  arm64: dts: juno: describe PMUs separately
  MAINTAINERS: update ARM PMU profiling and debugging for arm64
  MAINTAINERS: add myself as arm perf reviewer

 Documentation/devicetree/bindings/arm/pmu.txt |    2 +
 MAINTAINERS                                   |    9 +-
 arch/arm64/Kconfig                            |    8 +-
 arch/arm64/boot/dts/arm/juno-r1.dts           |   18 +-
 arch/arm64/boot/dts/arm/juno.dts              |   18 +-
 arch/arm64/include/asm/pmu.h                  |   83 --
 arch/arm64/kernel/perf_event.c                | 1068 +++++--------------------
 drivers/perf/Kconfig                          |    2 +-
 8 files changed, 241 insertions(+), 967 deletions(-)
 delete mode 100644 arch/arm64/include/asm/pmu.h

-- 
1.9.1
