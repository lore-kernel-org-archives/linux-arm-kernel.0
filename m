From: thomas.ab@samsung.com (Thomas Abraham)
Date: Tue, 17 Jun 2014 20:55:26 +0530
Subject: [PATCH v6 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
Message-ID: <1403018733-4187-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v5:
- Configuration data for cpu clock block is embedded with the code. The cpu clock
  logic can later to extended to obtain this data from DT.
- Excluded the support for Exynos4x12 SoC since the work on boost OPP bindings is
  still incomplete.
- Included cpufreq support for Exynos5420 SoC.
- Many other minor changes (and so dropped Ack's for some of the patches in v5)

This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
drivers and enables the use of cpufreq-cpu0 driver for these platforms. This
series also enabled cpufreq support for Exynos5420 using arm_big_little cpufreq
driver.

Thomas Abraham (6):
  clk: samsung: add infrastructure to register cpu clocks
  clk: samsung: register exynos5420 apll/kpll configuration data
  clk: exynos: use cpu-clock provider type to represent arm clock
  ARM: dts: Exynos: add cpu nodes, opp and cpu clock configuration data
  ARM: Exynos: switch to using generic cpufreq driver for exynos4210/5250
  cpufreq: exynos: remove exynos4210/5250 specific cpufreq driver support

 arch/arm/boot/dts/exynos4210-origen.dts         |    6 +
 arch/arm/boot/dts/exynos4210-trats.dts          |    6 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    6 +
 arch/arm/boot/dts/exynos4210.dtsi               |   27 ++
 arch/arm/boot/dts/exynos5250-arndale.dts        |    6 +
 arch/arm/boot/dts/exynos5250-cros-common.dtsi   |    6 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    6 +
 arch/arm/boot/dts/exynos5250.dtsi               |   23 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |    6 +
 arch/arm/boot/dts/exynos5420.dtsi               |   32 ++
 arch/arm/mach-exynos/exynos.c                   |   15 +-
 drivers/clk/samsung/Makefile                    |    2 +-
 drivers/clk/samsung/clk-cpu.c                   |  577 +++++++++++++++++++++++
 drivers/clk/samsung/clk-exynos4.c               |   25 +-
 drivers/clk/samsung/clk-exynos5250.c            |   16 +-
 drivers/clk/samsung/clk-exynos5420.c            |   59 ++-
 drivers/clk/samsung/clk.h                       |    5 +
 drivers/cpufreq/Kconfig.arm                     |   22 -
 drivers/cpufreq/Makefile                        |    2 -
 drivers/cpufreq/exynos4210-cpufreq.c            |  184 --------
 drivers/cpufreq/exynos5250-cpufreq.c            |  210 ---------
 include/dt-bindings/clock/exynos5250.h          |    1 +
 include/dt-bindings/clock/exynos5420.h          |    2 +
 23 files changed, 802 insertions(+), 442 deletions(-)
 create mode 100644 drivers/clk/samsung/clk-cpu.c
 delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c

-- 
1.7.9.5
