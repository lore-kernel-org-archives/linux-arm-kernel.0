From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 12 Sep 2011 23:59:25 +0530
Subject: [PATCH v3 6/6] ARM: EXYNOS4: Limit usage of pl330 device instance to
	non-dt build
In-Reply-To: <1315852165-32402-6-git-send-email-thomas.abraham@linaro.org>
References: <1315852165-32402-1-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-2-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-3-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-4-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-5-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-6-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1315852165-32402-7-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pl330 device instances and associated platform data is required only
for non-device-tree builds. With device tree enabled, the data about the
platform is obtained from the device tree. For images that include both
dt and non-dt platforms, an addditional check is added to ensure that
static amba device registrations is applicable to only non-dt platforms.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos4/Kconfig  |   10 ++++++++++
 arch/arm/mach-exynos4/Makefile |    3 ++-
 arch/arm/mach-exynos4/dma.c    |    6 ++++++
 3 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index d4d401c..679ba48 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -21,6 +21,11 @@ config EXYNOS4_MCT
 	help
 	  Use MCT (Multi Core Timer) as kernel timers
 
+config EXYNOS4_DEV_DMA
+	bool
+	help
+	  Compile in amba device definitions for DMA controller
+
 config EXYNOS4_DEV_AHCI
 	bool
 	help
@@ -129,6 +134,7 @@ config MACH_SMDKC210
 	select EXYNOS4_SETUP_FIMD0
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_SDHCI
+	select EXYNOS4_DEV_DMA
 	help
 	  Machine support for Samsung SMDKC210
 
@@ -153,6 +159,7 @@ config MACH_SMDKV310
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_KEYPAD
 	select EXYNOS4_SETUP_SDHCI
+	select EXYNOS4_DEV_DMA
 	help
 	  Machine support for Samsung SMDKV310
 
@@ -191,6 +198,7 @@ config MACH_UNIVERSAL_C210
 	select EXYNOS4_SETUP_I2C3
 	select EXYNOS4_SETUP_I2C5
 	select EXYNOS4_SETUP_SDHCI
+	select EXYNOS4_DEV_DMA
 	help
 	  Machine support for Samsung Mobile Universal S5PC210 Reference
 	  Board.
@@ -215,6 +223,7 @@ config MACH_NURI
 	select EXYNOS4_SETUP_USB_PHY
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_ADC
+	select EXYNOS4_DEV_DMA
 	help
 	  Machine support for Samsung Mobile NURI Board.
 
@@ -222,6 +231,7 @@ config MACH_EXYNOS4_DT
 	bool "Samsung Exynos4 Machine using device tree"
 	select CPU_EXYNOS4210
 	select USE_OF
+	select ARM_AMBA
 	help
 	  Machine support for Samsung Exynos4 machine with device tree enabled.
 
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index d2bf5bf..a2f33dc 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -13,7 +13,8 @@ obj-				:=
 # Core support for EXYNOS4 system
 
 obj-$(CONFIG_CPU_EXYNOS4210)	+= cpu.o init.o clock.o irq-combiner.o
-obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o irq-eint.o dma.o pmu.o
+obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o irq-eint.o pmu.o
+obj-$(CONFIG_EXYNOS4_DEV_DMA)	+= dma.o
 obj-$(CONFIG_PM)		+= pm.o sleep.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
diff --git a/arch/arm/mach-exynos4/dma.c b/arch/arm/mach-exynos4/dma.c
index c3c0d17..3203a31 100644
--- a/arch/arm/mach-exynos4/dma.c
+++ b/arch/arm/mach-exynos4/dma.c
@@ -24,6 +24,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl330.h>
+#include <linux/of.h>
 
 #include <asm/irq.h>
 #include <plat/devs.h>
@@ -138,6 +139,11 @@ struct amba_device exynos4_device_pdma1 = {
 
 static int __init exynos4_dma_init(void)
 {
+#ifdef CONFIG_OF
+	if (of_have_populated_dt())
+		return 0;
+#endif
+
 	dma_cap_set(DMA_SLAVE, exynos4_pdma0_pdata.cap_mask);
 	dma_cap_set(DMA_CYCLIC, exynos4_pdma0_pdata.cap_mask);
 	amba_device_register(&exynos4_device_pdma0, &iomem_resource);
-- 
1.6.6.rc2
