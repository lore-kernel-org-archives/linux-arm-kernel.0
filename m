From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  3 Dec 2010 18:39:44 +0900
Subject: [PATCH V2 2/2] ARM: S5PV310: Add support Power Domain
In-Reply-To: <1291369184-31460-1-git-send-email-kgene.kim@samsung.com>
References: <1291369184-31460-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1291369184-31460-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch adds support Power Domain for S5PV310 and S5PC210.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/Kconfig                 |    7 ++
 arch/arm/mach-s5pv310/Makefile                |    2 +
 arch/arm/mach-s5pv310/cpu.c                   |    5 +
 arch/arm/mach-s5pv310/dev-pd.c                |  139 +++++++++++++++++++++++++
 arch/arm/mach-s5pv310/include/mach/map.h      |    2 +
 arch/arm/mach-s5pv310/include/mach/regs-pmu.h |   30 ++++++
 arch/arm/mach-s5pv310/mach-smdkc210.c         |    8 ++
 arch/arm/mach-s5pv310/mach-smdkv310.c         |    8 ++
 arch/arm/plat-s5p/include/plat/map-s5p.h      |    1 +
 arch/arm/plat-samsung/include/plat/devs.h     |    2 +
 10 files changed, 204 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/dev-pd.c
 create mode 100644 arch/arm/mach-s5pv310/include/mach/regs-pmu.h

diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index d64efe0..2558f2f 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -15,6 +15,11 @@ config CPU_S5PV310
 	help
 	  Enable S5PV310 CPU support
 
+config S5PV310_DEV_PD
+	bool
+	help
+	  Compile in platform device definitions for Power Domain
+
 config S5PV310_SETUP_I2C1
 	bool
 	help
@@ -74,6 +79,7 @@ config MACH_SMDKC210
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
+	select S5PV310_DEV_PD
 	select S5PV310_SETUP_SDHCI
 	help
 	  Machine support for Samsung SMDKC210
@@ -102,6 +108,7 @@ config MACH_SMDKV310
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
+	select S5PV310_DEV_PD
 	select S5PV310_SETUP_SDHCI
 	help
 	  Machine support for Samsung SMDKV310
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
index 61e3cb6..74cde8a 100644
--- a/arch/arm/mach-s5pv310/Makefile
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -27,6 +27,8 @@ obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
 
 # device support
 
+obj-$(CONFIG_S5PV310_DEV_PD)		+= dev-pd.o
+
 obj-y += dev-audio.o
 obj-$(CONFIG_S5PV310_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5PV310_SETUP_I2C2)	+= setup-i2c2.o
diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
index b2a37d0..7b6e066 100644
--- a/arch/arm/mach-s5pv310/cpu.c
+++ b/arch/arm/mach-s5pv310/cpu.c
@@ -43,6 +43,11 @@ static struct map_desc s5pv310_iodesc[] __initdata = {
 		.length		= SZ_128K,
 		.type		= MT_DEVICE,
 	}, {
+		.virtual	= (unsigned long)S5P_VA_PMU,
+		.pfn		= __phys_to_pfn(S5PV310_PA_PMU),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
+	}, {
 		.virtual	= (unsigned long)S5P_VA_COMBINER_BASE,
 		.pfn		= __phys_to_pfn(S5PV310_PA_COMBINER),
 		.length		= SZ_4K,
diff --git a/arch/arm/mach-s5pv310/dev-pd.c b/arch/arm/mach-s5pv310/dev-pd.c
new file mode 100644
index 0000000..58a50c2
--- /dev/null
+++ b/arch/arm/mach-s5pv310/dev-pd.c
@@ -0,0 +1,139 @@
+/* linux/arch/arm/mach-s5pv310/dev-pd.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5PV310 - Power Domain support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+
+#include <mach/regs-pmu.h>
+
+#include <plat/pd.h>
+
+static int s5pv310_pd_enable(struct device *dev)
+{
+	struct samsung_pd_info *pdata =  dev->platform_data;
+	u32 timeout;
+
+	__raw_writel(S5P_INT_LOCAL_PWR_EN, pdata->base);
+
+	/* Wait max 1ms */
+	timeout = 10;
+	while ((__raw_readl(pdata->base + 0x4) & S5P_INT_LOCAL_PWR_EN)
+		!= S5P_INT_LOCAL_PWR_EN) {
+		if (timeout == 0) {
+			printk(KERN_ERR "Power domain %s enable failed.\n",
+				dev_name(dev));
+			return -ETIMEDOUT;
+		}
+		timeout--;
+		udelay(100);
+	}
+
+	return 0;
+}
+
+static int s5pv310_pd_disable(struct device *dev)
+{
+	struct samsung_pd_info *pdata =  dev->platform_data;
+	u32 timeout;
+
+	__raw_writel(0, pdata->base);
+
+	/* Wait max 1ms */
+	timeout = 10;
+	while (__raw_readl(pdata->base + 0x4) & S5P_INT_LOCAL_PWR_EN) {
+		if (timeout == 0) {
+			printk(KERN_ERR "Power domain %s disable failed.\n",
+				dev_name(dev));
+			return -ETIMEDOUT;
+		}
+		timeout--;
+		udelay(100);
+	}
+
+	return 0;
+}
+
+struct platform_device s5pv310_device_pd[] = {
+	{
+		.name		= "samsung-pd",
+		.id		= 0,
+		.dev = {
+			.platform_data = &(struct samsung_pd_info) {
+				.enable		= s5pv310_pd_enable,
+				.disable	= s5pv310_pd_disable,
+				.base		= S5P_PMU_MFC_CONF,
+			},
+		},
+	}, {
+		.name		= "samsung-pd",
+		.id		= 1,
+		.dev = {
+			.platform_data = &(struct samsung_pd_info) {
+				.enable		= s5pv310_pd_enable,
+				.disable	= s5pv310_pd_disable,
+				.base		= S5P_PMU_G3D_CONF,
+			},
+		},
+	}, {
+		.name		= "samsung-pd",
+		.id		= 2,
+		.dev = {
+			.platform_data = &(struct samsung_pd_info) {
+				.enable		= s5pv310_pd_enable,
+				.disable	= s5pv310_pd_disable,
+				.base		= S5P_PMU_LCD0_CONF,
+			},
+		},
+	}, {
+		.name		= "samsung-pd",
+		.id		= 3,
+		.dev = {
+			.platform_data = &(struct samsung_pd_info) {
+				.enable		= s5pv310_pd_enable,
+				.disable	= s5pv310_pd_disable,
+				.base		= S5P_PMU_LCD1_CONF,
+			},
+		},
+	}, {
+		.name		= "samsung-pd",
+		.id		= 4,
+		.dev = {
+			.platform_data = &(struct samsung_pd_info) {
+				.enable		= s5pv310_pd_enable,
+				.disable	= s5pv310_pd_disable,
+				.base		= S5P_PMU_TV_CONF,
+			},
+		},
+	}, {
+		.name		= "samsung-pd",
+		.id		= 5,
+		.dev = {
+			.platform_data = &(struct samsung_pd_info) {
+				.enable		= s5pv310_pd_enable,
+				.disable	= s5pv310_pd_disable,
+				.base		= S5P_PMU_CAM_CONF,
+			},
+		},
+	}, {
+		.name		= "samsung-pd",
+		.id		= 6,
+		.dev = {
+			.platform_data = &(struct samsung_pd_info) {
+				.enable		= s5pv310_pd_enable,
+				.disable	= s5pv310_pd_disable,
+				.base		= S5P_PMU_GPS_CONF,
+			},
+		},
+	},
+};
diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
index 5399446..85d2e5c 100644
--- a/arch/arm/mach-s5pv310/include/mach/map.h
+++ b/arch/arm/mach-s5pv310/include/mach/map.h
@@ -39,6 +39,8 @@
 #define S5PV310_PA_SYSCON		(0x10010000)
 #define S5P_PA_SYSCON			S5PV310_PA_SYSCON
 
+#define S5PV310_PA_PMU			(0x10020000)
+
 #define S5PV310_PA_CMU			(0x10030000)
 
 #define S5PV310_PA_WATCHDOG		(0x10060000)
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-pmu.h b/arch/arm/mach-s5pv310/include/mach/regs-pmu.h
new file mode 100644
index 0000000..fb333d0
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/regs-pmu.h
@@ -0,0 +1,30 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/regs-pmu.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5PV310 - Power management unit definition
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_PMU_H
+#define __ASM_ARCH_REGS_PMU_H __FILE__
+
+#include <mach/map.h>
+
+#define S5P_PMUREG(x)			(S5P_VA_PMU + (x))
+
+#define S5P_PMU_CAM_CONF		S5P_PMUREG(0x3C00)
+#define S5P_PMU_TV_CONF		S5P_PMUREG(0x3C20)
+#define S5P_PMU_MFC_CONF		S5P_PMUREG(0x3C40)
+#define S5P_PMU_G3D_CONF		S5P_PMUREG(0x3C60)
+#define S5P_PMU_LCD0_CONF		S5P_PMUREG(0x3C80)
+#define S5P_PMU_LCD1_CONF		S5P_PMUREG(0x3CA0)
+#define S5P_PMU_GPS_CONF		S5P_PMUREG(0x3CE0)
+
+#define S5P_INT_LOCAL_PWR_EN		0x7
+
+#endif /* __ASM_ARCH_REGS_PMU_H */
diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-s5pv310/mach-smdkc210.c
index 2b8d4fc..f65e668 100644
--- a/arch/arm/mach-s5pv310/mach-smdkc210.c
+++ b/arch/arm/mach-s5pv310/mach-smdkc210.c
@@ -23,6 +23,7 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/sdhci.h>
+#include <plat/pd.h>
 
 #include <mach/map.h>
 #include <mach/regs-srom.h>
@@ -147,6 +148,13 @@ static struct platform_device *smdkc210_devices[] __initdata = {
 	&s3c_device_rtc,
 	&s3c_device_wdt,
 	&smdkc210_smsc911x,
+	&s5pv310_device_pd[PD_MFC],
+	&s5pv310_device_pd[PD_G3D],
+	&s5pv310_device_pd[PD_LCD0],
+	&s5pv310_device_pd[PD_LCD1],
+	&s5pv310_device_pd[PD_CAM],
+	&s5pv310_device_pd[PD_TV],
+	&s5pv310_device_pd[PD_GPS],
 };
 
 static void __init smdkc210_smsc911x_init(void)
diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
index 35826d6..19aa3e3 100644
--- a/arch/arm/mach-s5pv310/mach-smdkv310.c
+++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
@@ -23,6 +23,7 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/sdhci.h>
+#include <plat/pd.h>
 
 #include <mach/map.h>
 #include <mach/regs-srom.h>
@@ -147,6 +148,13 @@ static struct platform_device *smdkv310_devices[] __initdata = {
 	&s3c_device_rtc,
 	&s3c_device_wdt,
 	&smdkv310_smsc911x,
+	&s5pv310_device_pd[PD_MFC],
+	&s5pv310_device_pd[PD_G3D],
+	&s5pv310_device_pd[PD_LCD0],
+	&s5pv310_device_pd[PD_LCD1],
+	&s5pv310_device_pd[PD_CAM],
+	&s5pv310_device_pd[PD_TV],
+	&s5pv310_device_pd[PD_GPS],
 };
 
 static void __init smdkv310_smsc911x_init(void)
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index fef353d..d973d39 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -15,6 +15,7 @@
 
 #define S5P_VA_CHIPID		S3C_ADDR(0x02000000)
 #define S5P_VA_CMU		S3C_ADDR(0x02100000)
+#define S5P_VA_PMU		S3C_ADDR(0x02180000)
 #define S5P_VA_GPIO		S3C_ADDR(0x02200000)
 #define S5P_VA_GPIO1		S5P_VA_GPIO
 #define S5P_VA_GPIO2		S3C_ADDR(0x02240000)
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index dec0ded..46d0847 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -131,6 +131,8 @@ extern struct platform_device s5p_device_fimc0;
 extern struct platform_device s5p_device_fimc1;
 extern struct platform_device s5p_device_fimc2;
 
+extern struct platform_device s5pv310_device_pd[];
+
 /* s3c2440 specific devices */
 
 #ifdef CONFIG_CPU_S3C2440
-- 
1.6.2.5
