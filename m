From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 28 Jan 2016 09:35:22 +0900
Subject: [PATCH v4 1/3] clk: samsung: Enable COMPILE_TEST for Samsung clocks
In-Reply-To: <1453941324-15742-1-git-send-email-k.kozlowski@samsung.com>
References: <1453941324-15742-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1453941324-15742-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the COMPILE_TEST to get build coverage of some of Samsung clock
controller drivers. Still some of them will be built only if
appropriate SoC is chosen (like SOC_EXYNOS4415 or ARCH_S3C64XX).

Anyway in case of COMPILE_TEST the Samsung clocks would show up in main
drivers section because they are not inside the "Common Clock Framework"
menu item. Move them under the "Common Clock Framework".

This changes the logic of selecting Samsung clocks from specific
architectures. Now the COMMON_CLK should be selected before selecting
specific clock (like S3C2410_COMMON_CLK or COMMON_CLK_SAMSUNG).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes since v3:
1. Rebase on next-20160127 (s3c64xx became multiplatform)

Changes since v2:
1. New patch.
---
 arch/arm/mach-exynos/Kconfig  | 1 +
 arch/arm/mach-s3c24xx/Kconfig | 8 ++++++++
 arch/arm/mach-s3c64xx/Kconfig | 1 +
 arch/arm/mach-s5pv210/Kconfig | 1 +
 arch/arm64/Kconfig.platforms  | 1 +
 drivers/clk/Kconfig           | 2 +-
 drivers/clk/samsung/Kconfig   | 9 ++++-----
 7 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index aeadd2aa12cf..b166ffc28f5c 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -15,6 +15,7 @@ menuconfig ARCH_EXYNOS
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_GIC
+	select COMMON_CLK
 	select COMMON_CLK_SAMSUNG
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index ef68ecb27396..5f02f1fa970d 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -28,6 +28,7 @@ config CPU_S3C2410
 	bool "SAMSUNG S3C2410"
 	default y
 	select CPU_ARM920T
+	select COMMON_CLK
 	select S3C2410_COMMON_CLK
 	select ARM_S3C2410_CPUFREQ if ARM_S3C24XX_CPUFREQ
 	select S3C2410_PM if PM
@@ -54,6 +55,7 @@ config CPU_S3C2416
 config CPU_S3C2440
 	bool "SAMSUNG S3C2440"
 	select CPU_ARM920T
+	select COMMON_CLK
 	select S3C2410_COMMON_CLK
 	select S3C2410_PM if PM_SLEEP
 	help
@@ -62,6 +64,7 @@ config CPU_S3C2440
 config CPU_S3C2442
 	bool "SAMSUNG S3C2442"
 	select CPU_ARM920T
+	select COMMON_CLK
 	select S3C2410_COMMON_CLK
 	select S3C2410_PM if PM_SLEEP
 	help
@@ -196,6 +199,7 @@ config ARCH_BAST
 	bool "Simtec Electronics BAST (EB2410ITX)"
 	select ISA
 	select MACH_BAST_IDE
+	select COMMON_CLK
 	select S3C2410_COMMON_DCLK
 	select S3C2410_IOTIMING if ARM_S3C2410_CPUFREQ
 	select S3C24XX_SIMTEC_NOR
@@ -273,6 +277,7 @@ config MACH_TCT_HAMMER
 config MACH_VR1000
 	bool "Thorcom VR1000"
 	select MACH_BAST_IDE
+	select COMMON_CLK
 	select S3C2410_COMMON_DCLK
 	select S3C24XX_SIMTEC_NOR
 	select S3C24XX_SIMTEC_PM if PM
@@ -443,6 +448,7 @@ comment "S3C2440 Boards"
 config MACH_ANUBIS
 	bool "Simtec Electronics ANUBIS"
 	select HAVE_PATA_PLATFORM
+	select COMMON_CLK
 	select S3C2410_COMMON_DCLK
 	select S3C2440_XTAL_12000000
 	select S3C24XX_SIMTEC_PM if PM
@@ -482,6 +488,7 @@ config MACH_NEXCODER_2440
 
 config MACH_OSIRIS
 	bool "Simtec IM2440D20 (OSIRIS) module"
+	select COMMON_CLK
 	select S3C2410_COMMON_DCLK
 	select S3C2410_IOTIMING if ARM_S3C2440_CPUFREQ
 	select S3C2440_XTAL_12000000
@@ -553,6 +560,7 @@ config MACH_RX1950
 	bool "HP iPAQ rx1950"
 	select I2C
 	select PM_H1940 if PM
+	select COMMON_CLK
 	select S3C2410_COMMON_DCLK
 	select S3C2410_IOTIMING if ARM_S3C2440_CPUFREQ
 	select S3C2440_XTAL_16934400
diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index e5c1888fc67b..a898d813b2bb 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -9,6 +9,7 @@ menuconfig ARCH_S3C64XX
 	select ARM_AMBA
 	select ARM_VIC
 	select CLKSRC_SAMSUNG_PWM
+	select COMMON_CLK
 	select COMMON_CLK_SAMSUNG
 	select GPIO_SAMSUNG if ATAGS
 	select HAVE_S3C2410_I2C if I2C
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 13bc9820ff22..5f19f1423f75 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -14,6 +14,7 @@ config ARCH_S5PV210
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_VIC
 	select CLKSRC_SAMSUNG_PWM
+	select COMMON_CLK
 	select COMMON_CLK_SAMSUNG
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 8a0952275291..83ac9316a432 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -21,6 +21,7 @@ config ARCH_EXYNOS
 config ARCH_EXYNOS7
 	bool "ARMv8 based Samsung Exynos7"
 	select ARCH_EXYNOS
+	select COMMON_CLK
 	select COMMON_CLK_SAMSUNG
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index eca8e019e005..5ab9480989e6 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -202,11 +202,11 @@ config COMMON_CLK_CDCE706
 
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
+source "drivers/clk/samsung/Kconfig"
 source "drivers/clk/qcom/Kconfig"
 
 endmenu
 
 source "drivers/clk/mvebu/Kconfig"
 
-source "drivers/clk/samsung/Kconfig"
 source "drivers/clk/tegra/Kconfig"
diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
index 84196ecdaa12..dd6093a33f84 100644
--- a/drivers/clk/samsung/Kconfig
+++ b/drivers/clk/samsung/Kconfig
@@ -1,9 +1,8 @@
 config COMMON_CLK_SAMSUNG
-	bool
-	select COMMON_CLK
+	bool "Samsung Exynos clock controller support" if COMPILE_TEST
 
 config S3C2410_COMMON_CLK
-	bool
+	bool "Samsung S3C2410 clock controller support" if COMPILE_TEST
 	select COMMON_CLK_SAMSUNG
 	help
 	  Build the s3c2410 clock driver based on the common clock framework.
@@ -17,10 +16,10 @@ config S3C2410_COMMON_DCLK
 	  framework.
 
 config S3C2412_COMMON_CLK
-	bool
+	bool "Samsung S3C2412 clock controller support" if COMPILE_TEST
 	select COMMON_CLK_SAMSUNG
 
 config S3C2443_COMMON_CLK
-	bool
+	bool "Samsung S3C2443 clock controller support" if COMPILE_TEST
 	select COMMON_CLK_SAMSUNG
 
-- 
1.9.1
