From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 21 May 2014 12:22:47 +0530
Subject: [PATCH 1/3] ARM: EXYNOS: Consolidate Kconfig entries
In-Reply-To: <1400655169-21683-1-git-send-email-sachin.kamat@linaro.org>
References: <1400655169-21683-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1400655169-21683-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of repeating the Kconfig entries for every SoC, move them under
ARCH_EXYNOS4 and 5 and move the entries common to both 4 and 5 under
ARCH_EXYNOS.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/Kconfig             |   10 ++++++++++
 arch/arm/mach-exynos/Kconfig |   45 ++++--------------------------------------
 2 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5e91e40c1d22..666b59b58ab0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -831,18 +831,28 @@ config ARCH_S5PV210
 
 config ARCH_EXYNOS
 	bool "Samsung EXYNOS"
+	select ARCH_HAS_BANDGAP
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SPARSEMEM_ENABLE
+	select ARM_AMBA
 	select ARM_GIC
+	select CLKSRC_OF
 	select COMMON_CLK_SAMSUNG
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
+	select HAVE_ARM_SCU if SMP
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
+	select HAVE_SMP
 	select NEED_MACH_MEMORY_H
+	select PINCTRL
+	select PINCTRL_EXYNOS
+	select PM_GENERIC_DOMAINS if PM_RUNTIME
+	select S5P_DEV_MFC
+	select SAMSUNG_DMADEV
 	select SPARSE_IRQ
 	select SRAM
 	select USE_OF
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 1602abce6ec0..138070e42aa9 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -14,30 +14,20 @@ menu "SAMSUNG EXYNOS SoCs Support"
 config ARCH_EXYNOS4
 	bool "SAMSUNG EXYNOS4"
 	default y
-	select ARM_AMBA
-	select CLKSRC_OF
+	select ARM_CPU_SUSPEND if PM_SLEEP
 	select CLKSRC_SAMSUNG_PWM if CPU_EXYNOS4210
 	select CPU_EXYNOS4210
 	select GIC_NON_BANKED
 	select KEYBOARD_SAMSUNG if INPUT_KEYBOARD
-	select HAVE_ARM_SCU if SMP
-	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
-	select PINCTRL
-	select PM_GENERIC_DOMAINS if PM_RUNTIME
-	select S5P_DEV_MFC
 	help
-	  Samsung EXYNOS4 SoCs based systems
+	  Samsung EXYNOS4 (Cortex-A9) SoC based systems
 
 config ARCH_EXYNOS5
 	bool "SAMSUNG EXYNOS5"
-	select ARM_AMBA
-	select CLKSRC_OF
-	select HAVE_ARM_SCU if SMP
-	select HAVE_SMP
-	select PINCTRL
+	default y
 	help
-	  Samsung EXYNOS5 (Cortex-A15) SoC based systems
+	  Samsung EXYNOS5 (Cortex-A15/A7) SoC based systems
 
 comment "EXYNOS SoCs"
 
@@ -45,59 +35,32 @@ config CPU_EXYNOS4210
 	bool "SAMSUNG EXYNOS4210"
 	default y
 	depends on ARCH_EXYNOS4
-	select ARCH_HAS_BANDGAP
-	select ARM_CPU_SUSPEND if PM_SLEEP
-	select PINCTRL_EXYNOS
-	select SAMSUNG_DMADEV
-	help
-	  Enable EXYNOS4210 CPU support
 
 config SOC_EXYNOS4212
 	bool "SAMSUNG EXYNOS4212"
 	default y
 	depends on ARCH_EXYNOS4
-	select ARCH_HAS_BANDGAP
-	select PINCTRL_EXYNOS
-	select SAMSUNG_DMADEV
-	help
-	  Enable EXYNOS4212 SoC support
 
 config SOC_EXYNOS4412
 	bool "SAMSUNG EXYNOS4412"
 	default y
 	depends on ARCH_EXYNOS4
-	select ARCH_HAS_BANDGAP
-	select PINCTRL_EXYNOS
-	select SAMSUNG_DMADEV
-	help
-	  Enable EXYNOS4412 SoC support
 
 config SOC_EXYNOS5250
 	bool "SAMSUNG EXYNOS5250"
 	default y
 	depends on ARCH_EXYNOS5
-	select ARCH_HAS_BANDGAP
-	select PINCTRL_EXYNOS
-	select PM_GENERIC_DOMAINS if PM_RUNTIME
-	select S5P_DEV_MFC
-	select SAMSUNG_DMADEV
-	help
-	  Enable EXYNOS5250 SoC support
 
 config SOC_EXYNOS5420
 	bool "SAMSUNG EXYNOS5420"
 	default y
 	depends on ARCH_EXYNOS5
-	select PM_GENERIC_DOMAINS if PM_RUNTIME
-	help
-	  Enable EXYNOS5420 SoC support
 
 config SOC_EXYNOS5440
 	bool "SAMSUNG EXYNOS5440"
 	default y
 	depends on ARCH_EXYNOS5
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
-	select ARCH_HAS_BANDGAP
 	select ARCH_HAS_OPP
 	select HAVE_ARM_ARCH_TIMER
 	select AUTO_ZRELADDR
-- 
1.7.9.5
