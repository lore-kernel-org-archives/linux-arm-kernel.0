From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:43:45 +0530
Subject: [PATCH 7/7] ARM: Exynos: move mct driver to drivers/clocksource
In-Reply-To: <1361175225-19282-1-git-send-email-thomas.abraham@linaro.org>
References: <1361175225-19282-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361175225-19282-8-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the multi core timer (mct) driver to from mach-exynos to
drivers/clocksource and update the Kconfig and makefiles.

Cc: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/mach-exynos/Kconfig                       |    6 ------
 arch/arm/mach-exynos/Makefile                      |    2 --
 drivers/clocksource/Kconfig                        |    5 +++++
 drivers/clocksource/Makefile                       |    1 +
 .../mct.c => drivers/clocksource/exynos_mct.c      |    0
 6 files changed, 7 insertions(+), 9 deletions(-)
 rename arch/arm/mach-exynos/mct.c => drivers/clocksource/exynos_mct.c (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8b72d23..8234697 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1622,7 +1622,7 @@ config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP
 	default y
-	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
+	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !CLKSRC_EXYNOS_MCT)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index e0ce082..6961ac7 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -80,12 +80,6 @@ config SOC_EXYNOS5440
 	help
 	  Enable EXYNOS5440 SoC support
 
-config EXYNOS4_MCT
-	bool
-	default y
-	help
-	  Use MCT (Multi Core Timer) as kernel timers
-
 config EXYNOS_DEV_DMA
 	bool
 	help
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 7e53a3a..5141963 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -26,8 +26,6 @@ obj-$(CONFIG_ARCH_EXYNOS)	+= pmu.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 
-obj-$(CONFIG_EXYNOS4_MCT)	+= mct.o
-
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 
 obj-$(CONFIG_ARCH_EXYNOS)	+= exynos-smc.o
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a32b7a9..84bf4de 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -61,3 +61,8 @@ config CLKSRC_ARM_GENERIC
 	def_bool y if ARM64
 	help
 	  This option enables support for the ARM generic timer.
+
+config CLKSRC_EXYNOS_MCT
+	def_bool y if ARCH_EXYNOS
+	help
+	  Support for Multi Core Timer controller on Exynos SoCs.
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index a33f792..248a856 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -17,5 +17,6 @@ obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
 obj-$(CONFIG_SUNXI_TIMER)	+= sunxi_timer.o
+obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
 
 obj-$(CONFIG_CLKSRC_ARM_GENERIC)	+= arm_generic.o
diff --git a/arch/arm/mach-exynos/mct.c b/drivers/clocksource/exynos_mct.c
similarity index 100%
rename from arch/arm/mach-exynos/mct.c
rename to drivers/clocksource/exynos_mct.c
-- 
1.7.5.4
