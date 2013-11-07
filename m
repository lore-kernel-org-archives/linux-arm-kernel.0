From: v.tyrtov@samsung.com (Vyacheslav Tyrtov)
Date: Thu, 07 Nov 2013 12:12:45 +0400
Subject: [PATCH v3 0/4] Exynos 5410 Dual cluster support
Message-ID: <1383811969-32712-1-git-send-email-v.tyrtov@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series of patches represent support of Exynos 5410 SoC

The Exynos 5410 is the first Samsung SoC based on bigLITTLE architecture
Patches allow all 8 CPU cores (4 x A7 and 4 x A15) to run at the same time

Patches add new platform description, support of clock controller,
dual cluster support and device tree for Exynos 5410

Has been build on v3.12.
Has been tested on Exynos 5410 reference board (exynos_defconfig).

Thanks,
        Vyacheslav.


Changelog:

v3:
	In drivers/clk/samsung/clk-exynos5410.c
1. Fixed rate clock "samsung,clock-oscclk" removed.
	In arch/arm/boot/dts/exynos5410.dtsi
1. In mct node clock CLK_FIN_PLL replaced with generic fixed rate oscclk.
	In arch/arm/boot/dts/exynos5410-smdk5410.dts
1. Fixed rate oscclk clock added.
	In arch/arm/mach-exynos/edcs.c
1. Added write memory barrier in exynos_core_power_control function.
2. __raw_readl/__raw_writel replaced with readl_relaxed/writel_relaxed.
3. #define added for some magic constants.
4. Disabled the GIC CPU interface in exynos_power_down function.

v2:
	In drivers/clk/samsung/clk-exynos5410.c
1. Clock driver converted to use preprocessor macros instead of enums.
   Clock IDs now defined in include/dt-bindings/clock/exynos5410.h.
2. Unused spinlock removed.
3. Function exynos5410_clk_init defined as static.
   Struct exynos5410_fixed_rate_ext_clks defined as static.
   Struct exynos5410_mux_clks defined as static.
   Struct exynos5410_div_clks defined as static.
   Struct exynos5410_gate_clks defined as static.
4. Removed aliases.
5. Pll's magic register offsets defined as preprocessor macros.
6. Redundant check of device_node pointer removed.
	
	In arch/arm/boot/dts/exynos5410.dtsi
1. dwmmcX nodes renamed to mmc.
   dwmmc_X renamed to mmc_X.
   dwmmc status="disabled" field added.
   fifo-depth field moved from arch/arm/boot/dts/exynos5410-smdk5410.dts
2. Blank lines added where necessary.
3. cpu@ suffixes corrected.
4. edcs node removed.
5. Hexadecimal characters case corrected.
6. Clock IDs replaced with preprocessor macros.
	
	In arch/arm/boot/dts/exynos5410-smdk5410.dts
1. status = "okay" field added to mmc nodes.
	
	In arch/arm/mach-exynos/edcs.c
1. "kfs_" prefix replaced with "edcs_"
2. EDCS_CPUS_PER_CLUSTER and EDCS_CLUSTERS defined instead of MCPM's values.
3. Cache handling sequence borrowed from arch/arm/mach-vexpress/tc2_pm.c
4. mcpm_sync_init() call added.
5. power management functions reworked.
	
	Other
1. Documentation/devicetree/bindings/clock/exynos5410-clock.txt corrected.
2. Removed smdk5410_defconfig. Instead SOC_EXYNOS5410 now selects MCPM and
   ARM_CCI in arch/arm/mach-exynos/Kconfig.
3. edcs_status driver removed.


Tarek Dakhran (4):
  ARM: EXYNOS: Add support for EXYNOS5410 SoC
  clk: exynos5410: register clocks using common clock framework
  ARM: EXYNOS: add Exynos Dual Cluster Support
  ARM: dts: Add initial device tree support for EXYNOS5410

 .../devicetree/bindings/clock/exynos5410-clock.txt |  37 +++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |  65 +++++
 arch/arm/boot/dts/exynos5410.dtsi                  | 209 ++++++++++++++++
 arch/arm/mach-exynos/Kconfig                       |  12 +
 arch/arm/mach-exynos/Makefile                      |   2 +
 arch/arm/mach-exynos/common.c                      |  18 ++
 arch/arm/mach-exynos/edcs.c                        | 278 +++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/map.h            |   1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |   1 +
 arch/arm/plat-samsung/include/plat/cpu.h           |   8 +
 drivers/clk/samsung/Makefile                       |   1 +
 drivers/clk/samsung/clk-exynos5410.c               | 239 ++++++++++++++++++
 include/dt-bindings/clock/exynos5410.h             | 175 +++++++++++++
 14 files changed, 1047 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos5410-clock.txt
 create mode 100644 arch/arm/boot/dts/exynos5410-smdk5410.dts
 create mode 100644 arch/arm/boot/dts/exynos5410.dtsi
 create mode 100644 arch/arm/mach-exynos/edcs.c
 create mode 100644 drivers/clk/samsung/clk-exynos5410.c
 create mode 100644 include/dt-bindings/clock/exynos5410.h

-- 
1.8.1.5
