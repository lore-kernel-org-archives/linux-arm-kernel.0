From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 19 Mar 2014 15:55:03 +0530
Subject: [PATCH Resend 1/3] ARM: EXYNOS: Consolidate Kconfig entries
Message-ID: <1395224705-2935-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of repeating the Kconfig entries for every SoC, move them under
ARCH_EXYNOS4 and 5 and move the entries common to both 4 and 5 under
ARCH_EXYNOS. Also, since the individual SoCs do not have any specific
machine/platform code, keep them as boolean symbols instead of user
selectable and select them from Exynos4 and 5 config symbols. Individual
SoC symbols can be removed eventually once the driver Kconfig dependencies
on these symbols are removed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Tomasz Figa <t.figa@samsung.com>
---
This is a resend of the series rebased on top of latest linux-next and
Tomasz Figa's PM consolidation series 1 and 2.
---
 arch/arm/Kconfig             |   10 +++++
 arch/arm/mach-exynos/Kconfig |   89 +++++++++++-------------------------------
 2 files changed, 33 insertions(+), 66 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index afc751f750b9..e2428a18f2a6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -821,18 +821,28 @@ config ARCH_S5PV210
 
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
 	select COMMON_CLK
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
 	select USE_OF
 	help
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index fc8bf18e222d..9398bab87a76 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -14,90 +14,32 @@ menu "SAMSUNG EXYNOS SoCs Support"
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
+	select SOC_EXYNOS4212
+	select SOC_EXYNOS4412
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
-	help
-	  Samsung EXYNOS5 (Cortex-A15) SoC based systems
-
-comment "EXYNOS SoCs"
-
-config CPU_EXYNOS4210
-	bool "SAMSUNG EXYNOS4210"
-	default y
-	depends on ARCH_EXYNOS4
-	select ARCH_HAS_BANDGAP
-	select ARM_CPU_SUSPEND if PM_SLEEP
-	select PINCTRL_EXYNOS
-	select SAMSUNG_DMADEV
-	help
-	  Enable EXYNOS4210 CPU support
-
-config SOC_EXYNOS4212
-	bool "SAMSUNG EXYNOS4212"
 	default y
-	depends on ARCH_EXYNOS4
-	select ARCH_HAS_BANDGAP
-	select PINCTRL_EXYNOS
-	select SAMSUNG_DMADEV
+	select SOC_EXYNOS5250
+	select SOC_EXYNOS5420
 	help
-	  Enable EXYNOS4212 SoC support
+	  Samsung EXYNOS5 (Cortex-A15/A7) SoC based systems
 
-config SOC_EXYNOS4412
-	bool "SAMSUNG EXYNOS4412"
-	default y
-	depends on ARCH_EXYNOS4
-	select ARCH_HAS_BANDGAP
-	select PINCTRL_EXYNOS
-	select SAMSUNG_DMADEV
-	help
-	  Enable EXYNOS4412 SoC support
-
-config SOC_EXYNOS5250
-	bool "SAMSUNG EXYNOS5250"
-	default y
-	depends on ARCH_EXYNOS5
-	select ARCH_HAS_BANDGAP
-	select PINCTRL_EXYNOS
-	select PM_GENERIC_DOMAINS if PM_RUNTIME
-	select S5P_DEV_MFC
-	select SAMSUNG_DMADEV
-	help
-	  Enable EXYNOS5250 SoC support
-
-config SOC_EXYNOS5420
-	bool "SAMSUNG EXYNOS5420"
-	default y
-	depends on ARCH_EXYNOS5
-	select PM_GENERIC_DOMAINS if PM_RUNTIME
-	help
-	  Enable EXYNOS5420 SoC support
+comment "EXYNOS SoCs"
 
 config SOC_EXYNOS5440
 	bool "SAMSUNG EXYNOS5440"
 	default y
 	depends on ARCH_EXYNOS5
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
-	select ARCH_HAS_BANDGAP
 	select ARCH_HAS_OPP
 	select HAVE_ARM_ARCH_TIMER
 	select AUTO_ZRELADDR
@@ -110,4 +52,19 @@ config SOC_EXYNOS5440
 
 endmenu
 
+config CPU_EXYNOS4210
+	bool
+
+config SOC_EXYNOS4212
+	bool
+
+config SOC_EXYNOS4412
+	bool
+
+config SOC_EXYNOS5250
+	bool
+
+config SOC_EXYNOS5420
+	bool
+
 endif
-- 
1.7.9.5
