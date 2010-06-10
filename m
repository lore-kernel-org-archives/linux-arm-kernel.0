From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 10 Jun 2010 18:21:50 +0900
Subject: [PATCH 1/2] ARM: SAMSUNG: Add device definition for HSMMC3
In-Reply-To: <1276161711-17523-1-git-send-email-kgene.kim@samsung.com>
References: <1276161711-17523-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1276161711-17523-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Hyuk <hyuk1.lee@samsung.com>

This patch adds hsmmc3 device definition in plat-samsung. Because now S5PV210
can support 4 hsmmc, and that can be used in further Samsung SoCs.

Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/Kconfig              |    5 ++
 arch/arm/plat-samsung/Makefile             |    1 +
 arch/arm/plat-samsung/dev-hsmmc3.c         |   72 ++++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h  |    1 +
 arch/arm/plat-samsung/include/plat/sdhci.h |   15 ++++++
 5 files changed, 94 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/dev-hsmmc3.c

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 2753fb3..8efb012 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -160,6 +160,11 @@ config S3C_DEV_HSMMC2
 	help
 	  Compile in platform device definitions for HSMMC channel 2
 
+config S3C_DEV_HSMMC3
+	bool
+	help
+	  Compile in platform device definitions for HSMMC channel 3
+
 config S3C_DEV_HWMON
 	bool
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index b1d82cc..c9abae5 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_S3C_ADC)	+= adc.o
 obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
 obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
 obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
+obj-$(CONFIG_S3C_DEV_HSMMC3)	+= dev-hsmmc3.o
 obj-$(CONFIG_S3C_DEV_HWMON)	+= dev-hwmon.o
 obj-y				+= dev-i2c0.o
 obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c b/arch/arm/plat-samsung/dev-hsmmc3.c
new file mode 100644
index 0000000..05d5ea4
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-hsmmc3.c
@@ -0,0 +1,72 @@
+/* linux/arch/arm/plat-samsung/dev-hsmmc3.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Copyright (c) 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * Based on arch/arm/plat-samsung/dev-hsmmc1.c
+ *
+ * S3C series device definition for hsmmc device 3
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mmc/host.h>
+
+#include <mach/map.h>
+#include <plat/sdhci.h>
+#include <plat/devs.h>
+
+#define S3C_SZ_HSMMC	(0x1000)
+
+static struct resource s3c_hsmmc3_resource[] = {
+	[0] = {
+		.start = S3C_PA_HSMMC3,
+		.end   = S3C_PA_HSMMC3 + S3C_SZ_HSMMC - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_MMC3,
+		.end   = IRQ_MMC3,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static u64 s3c_device_hsmmc3_dmamask = 0xffffffffUL;
+
+struct s3c_sdhci_platdata s3c_hsmmc3_def_platdata = {
+	.max_width	= 4,
+	.host_caps	= (MMC_CAP_4_BIT_DATA |
+			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+};
+
+struct platform_device s3c_device_hsmmc3 = {
+	.name		= "s3c-sdhci",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(s3c_hsmmc3_resource),
+	.resource	= s3c_hsmmc3_resource,
+	.dev		= {
+		.dma_mask		= &s3c_device_hsmmc3_dmamask,
+		.coherent_dma_mask	= 0xffffffffUL,
+		.platform_data		= &s3c_hsmmc3_def_platdata,
+	},
+};
+
+void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata *pd)
+{
+	struct s3c_sdhci_platdata *set = &s3c_hsmmc3_def_platdata;
+
+	set->max_width = pd->max_width;
+
+	if (pd->cfg_gpio)
+		set->cfg_gpio = pd->cfg_gpio;
+	if (pd->cfg_card)
+		set->cfg_card = pd->cfg_card;
+}
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index e6144e4..7842acd 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -54,6 +54,7 @@ extern struct platform_device s3c_device_hwmon;
 extern struct platform_device s3c_device_hsmmc0;
 extern struct platform_device s3c_device_hsmmc1;
 extern struct platform_device s3c_device_hsmmc2;
+extern struct platform_device s3c_device_hsmmc3;
 
 extern struct platform_device s3c_device_spi0;
 extern struct platform_device s3c_device_spi1;
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 98ebd50..1314ffa 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -58,6 +58,7 @@ struct s3c_sdhci_platdata {
 extern void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd);
 extern void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd);
 extern void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd);
+extern void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata *pd);
 
 /* Default platform data, exported so that per-cpu initialisation can
  * set the correct one when there are more than one cpu type selected.
@@ -66,6 +67,7 @@ extern void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd);
 extern struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata;
 extern struct s3c_sdhci_platdata s3c_hsmmc1_def_platdata;
 extern struct s3c_sdhci_platdata s3c_hsmmc2_def_platdata;
+extern struct s3c_sdhci_platdata s3c_hsmmc3_def_platdata;
 
 /* Helper function availablity */
 
@@ -78,6 +80,7 @@ extern void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 extern void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
 extern void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
+extern void s5pv210_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
 
 /* S3C6400 SDHCI setup */
 
@@ -264,10 +267,22 @@ static inline void s5pv210_default_sdhci2(void)
 static inline void s5pv210_default_sdhci2(void) { }
 #endif /* CONFIG_S3C_DEV_HSMMC2 */
 
+#ifdef CONFIG_S3C_DEV_HSMMC3
+static inline void s5pv210_default_sdhci3(void)
+{
+	s3c_hsmmc3_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
+	s3c_hsmmc3_def_platdata.cfg_gpio = s5pv210_setup_sdhci3_cfg_gpio;
+	s3c_hsmmc3_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
+}
+#else
+static inline void s5pv210_default_sdhci3(void) { }
+#endif /* CONFIG_S3C_DEV_HSMMC3 */
+
 #else
 static inline void s5pv210_default_sdhci0(void) { }
 static inline void s5pv210_default_sdhci1(void) { }
 static inline void s5pv210_default_sdhci2(void) { }
+static inline void s5pv210_default_sdhci3(void) { }
 #endif /* CONFIG_S5PC100_SETUP_SDHCI */
 
 
-- 
1.6.2.5
