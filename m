From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 10 Oct 2011 23:45:34 +0530
Subject: [PATCH v6 06/10] ARM: EXYNOS4: Limit usage of pl330 device instance to
	non-dt build
In-Reply-To: <1318270538-30450-6-git-send-email-thomas.abraham@linaro.org>
References: <1318270538-30450-1-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-2-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-3-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-4-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-5-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-6-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1318270538-30450-7-git-send-email-thomas.abraham@linaro.org>
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
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-exynos4/Kconfig  |   10 ++++++++++
 arch/arm/mach-exynos4/Makefile |    3 ++-
 arch/arm/mach-exynos4/dma.c    |    4 ++++
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index dd660eb..0c5888a 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -35,6 +35,11 @@ config EXYNOS4_MCT
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
@@ -158,6 +163,7 @@ config MACH_SMDKV310
 	select EXYNOS4_DEV_PD
 	select SAMSUNG_DEV_PWM
 	select EXYNOS4_DEV_SYSMMU
+	select EXYNOS4_DEV_DMA
 	select EXYNOS4_SETUP_FIMD0
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_KEYPAD
@@ -176,6 +182,7 @@ config MACH_ARMLEX4210
 	select S3C_DEV_HSMMC3
 	select EXYNOS4_DEV_AHCI
 	select EXYNOS4_DEV_SYSMMU
+	select EXYNOS4_DEV_DMA
 	select EXYNOS4_SETUP_SDHCI
 	help
 	  Machine support for Samsung ARMLEX4210 based on EXYNOS4210
@@ -201,6 +208,7 @@ config MACH_UNIVERSAL_C210
 	select S5P_DEV_ONENAND
 	select S5P_DEV_TV
 	select EXYNOS4_DEV_PD
+	select EXYNOS4_DEV_DMA
 	select EXYNOS4_SETUP_FIMD0
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_I2C3
@@ -227,6 +235,7 @@ config MACH_NURI
 	select S5P_DEV_MFC
 	select S5P_DEV_USB_EHCI
 	select EXYNOS4_DEV_PD
+	select EXYNOS4_DEV_DMA
 	select EXYNOS4_SETUP_FIMD0
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_I2C3
@@ -253,6 +262,7 @@ config MACH_ORIGEN
 	select S5P_DEV_I2C_HDMIPHY
 	select S5P_DEV_TV
 	select S5P_DEV_USB_EHCI
+	select EXYNOS4_DEV_DMA
 	select EXYNOS4_DEV_PD
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index c47aae3..8066538 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -13,7 +13,7 @@ obj-				:=
 # Core support for EXYNOS4 system
 
 obj-$(CONFIG_ARCH_EXYNOS4)	+= cpu.o init.o clock.o irq-combiner.o
-obj-$(CONFIG_ARCH_EXYNOS4)	+= setup-i2c0.o irq-eint.o dma.o pmu.o
+obj-$(CONFIG_ARCH_EXYNOS4)	+= setup-i2c0.o irq-eint.o pmu.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
 obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
 obj-$(CONFIG_PM)		+= pm.o
@@ -44,6 +44,7 @@ obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-ahci.o
 obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
 obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
 obj-$(CONFIG_EXYNOS4_DEV_DWMCI)	+= dev-dwmci.o
+obj-$(CONFIG_EXYNOS4_DEV_DMA)		+= dma.o
 
 obj-$(CONFIG_EXYNOS4_SETUP_FIMC)	+= setup-fimc.o
 obj-$(CONFIG_EXYNOS4_SETUP_FIMD0)	+= setup-fimd0.o
diff --git a/arch/arm/mach-exynos4/dma.c b/arch/arm/mach-exynos4/dma.c
index c3c0d17..921d31d 100644
--- a/arch/arm/mach-exynos4/dma.c
+++ b/arch/arm/mach-exynos4/dma.c
@@ -24,6 +24,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl330.h>
+#include <linux/of.h>
 
 #include <asm/irq.h>
 #include <plat/devs.h>
@@ -138,6 +139,9 @@ struct amba_device exynos4_device_pdma1 = {
 
 static int __init exynos4_dma_init(void)
 {
+	if (of_have_populated_dt())
+		return 0;
+
 	dma_cap_set(DMA_SLAVE, exynos4_pdma0_pdata.cap_mask);
 	dma_cap_set(DMA_CYCLIC, exynos4_pdma0_pdata.cap_mask);
 	amba_device_register(&exynos4_device_pdma0, &iomem_resource);
-- 
1.6.6.rc2
