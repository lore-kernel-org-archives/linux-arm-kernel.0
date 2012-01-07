From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 07 Jan 2012 15:40:55 +0530
Subject: [PATCH v2 2/2] ARM: Exynos: Hook up power domains to generic power
 domain infrastructure
In-Reply-To: <1325931055-14486-1-git-send-email-thomas.abraham@linaro.org>
References: <1325931055-14486-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1325931055-14486-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for generic power domain for Exynos4 platforms and remove the
Samsung specific power domain control for Exynos4.

The generic power domain infrastructure is used to control the power domains
available on Exynos4. For non-dt platforms, the power domains are statically
instantiated. For dt platforms, the power domain nodes found in the device
tree are instantiated.

Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
This patch is mainly derived from Mark Brown's work on generic power domain
support for s3c64xx platforms.

 arch/arm/mach-exynos/Kconfig               |   10 +--
 arch/arm/mach-exynos/Makefile              |    2 +-
 arch/arm/mach-exynos/dev-pd.c              |  139 ---------------------
 arch/arm/mach-exynos/mach-nuri.c           |   11 --
 arch/arm/mach-exynos/mach-origen.c         |   14 --
 arch/arm/mach-exynos/mach-smdkv310.c       |   12 --
 arch/arm/mach-exynos/mach-universal_c210.c |   17 ---
 arch/arm/mach-exynos/pm_domains.c          |  183 ++++++++++++++++++++++++++++
 8 files changed, 185 insertions(+), 203 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/dev-pd.c
 create mode 100644 arch/arm/mach-exynos/pm_domains.c

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index e931924..5dec134 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -32,6 +32,7 @@ config CPU_EXYNOS4210
 	select ARM_CPU_SUSPEND if PM
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
+	select PM_GENERIC_DOMAINS
 	help
 	  Enable EXYNOS4210 CPU support
 
@@ -72,11 +73,6 @@ config EXYNOS4_SETUP_FIMD0
 	help
 	  Common setup code for FIMD0.
 
-config EXYNOS4_DEV_PD
-	bool
-	help
-	  Compile in platform device definitions for Power Domain
-
 config EXYNOS4_DEV_SYSMMU
 	bool
 	help
@@ -194,7 +190,6 @@ config MACH_SMDKV310
 	select EXYNOS4_DEV_AHCI
 	select SAMSUNG_DEV_KEYPAD
 	select EXYNOS4_DEV_DMA
-	select EXYNOS4_DEV_PD
 	select SAMSUNG_DEV_PWM
 	select EXYNOS4_DEV_USB_OHCI
 	select EXYNOS4_DEV_SYSMMU
@@ -243,7 +238,6 @@ config MACH_UNIVERSAL_C210
 	select S5P_DEV_ONENAND
 	select S5P_DEV_TV
 	select EXYNOS4_DEV_DMA
-	select EXYNOS4_DEV_PD
 	select EXYNOS4_SETUP_FIMD0
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_I2C3
@@ -277,7 +271,6 @@ config MACH_NURI
 	select S5P_DEV_USB_EHCI
 	select S5P_SETUP_MIPIPHY
 	select EXYNOS4_DEV_DMA
-	select EXYNOS4_DEV_PD
 	select EXYNOS4_SETUP_FIMC
 	select EXYNOS4_SETUP_FIMD0
 	select EXYNOS4_SETUP_I2C1
@@ -310,7 +303,6 @@ config MACH_ORIGEN
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
 	select EXYNOS4_DEV_DMA
-	select EXYNOS4_DEV_PD
 	select EXYNOS4_DEV_USB_OHCI
 	select EXYNOS4_SETUP_FIMD0
 	select EXYNOS4_SETUP_SDHCI
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index db527ab..b7e4eca 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARCH_EXYNOS4)	+= irq-eint.o pmu.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
 obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
 obj-$(CONFIG_PM)		+= pm.o
+obj-$(CONFIG_PM_GENERIC_DOMAINS)	+= pm_domains.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
@@ -43,7 +44,6 @@ obj-$(CONFIG_MACH_EXYNOS4_DT)		+= mach-exynos4-dt.o
 
 obj-$(CONFIG_ARCH_EXYNOS4)		+= dev-audio.o
 obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-ahci.o
-obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
 obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
 obj-$(CONFIG_EXYNOS4_DEV_DWMCI)		+= dev-dwmci.o
 obj-$(CONFIG_EXYNOS4_DEV_DMA)		+= dma.o
diff --git a/arch/arm/mach-exynos/dev-pd.c b/arch/arm/mach-exynos/dev-pd.c
deleted file mode 100644
index 3273f25..0000000
--- a/arch/arm/mach-exynos/dev-pd.c
+++ /dev/null
@@ -1,139 +0,0 @@
-/* linux/arch/arm/mach-exynos4/dev-pd.c
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4 - Power Domain support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-
-#include <mach/regs-pmu.h>
-
-#include <plat/pd.h>
-
-static int exynos4_pd_enable(struct device *dev)
-{
-	struct samsung_pd_info *pdata =  dev->platform_data;
-	u32 timeout;
-
-	__raw_writel(S5P_INT_LOCAL_PWR_EN, pdata->base);
-
-	/* Wait max 1ms */
-	timeout = 10;
-	while ((__raw_readl(pdata->base + 0x4) & S5P_INT_LOCAL_PWR_EN)
-		!= S5P_INT_LOCAL_PWR_EN) {
-		if (timeout == 0) {
-			printk(KERN_ERR "Power domain %s enable failed.\n",
-				dev_name(dev));
-			return -ETIMEDOUT;
-		}
-		timeout--;
-		udelay(100);
-	}
-
-	return 0;
-}
-
-static int exynos4_pd_disable(struct device *dev)
-{
-	struct samsung_pd_info *pdata =  dev->platform_data;
-	u32 timeout;
-
-	__raw_writel(0, pdata->base);
-
-	/* Wait max 1ms */
-	timeout = 10;
-	while (__raw_readl(pdata->base + 0x4) & S5P_INT_LOCAL_PWR_EN) {
-		if (timeout == 0) {
-			printk(KERN_ERR "Power domain %s disable failed.\n",
-				dev_name(dev));
-			return -ETIMEDOUT;
-		}
-		timeout--;
-		udelay(100);
-	}
-
-	return 0;
-}
-
-struct platform_device exynos4_device_pd[] = {
-	{
-		.name		= "samsung-pd",
-		.id		= 0,
-		.dev = {
-			.platform_data = &(struct samsung_pd_info) {
-				.enable		= exynos4_pd_enable,
-				.disable	= exynos4_pd_disable,
-				.base		= S5P_PMU_MFC_CONF,
-			},
-		},
-	}, {
-		.name		= "samsung-pd",
-		.id		= 1,
-		.dev = {
-			.platform_data = &(struct samsung_pd_info) {
-				.enable		= exynos4_pd_enable,
-				.disable	= exynos4_pd_disable,
-				.base		= S5P_PMU_G3D_CONF,
-			},
-		},
-	}, {
-		.name		= "samsung-pd",
-		.id		= 2,
-		.dev = {
-			.platform_data = &(struct samsung_pd_info) {
-				.enable		= exynos4_pd_enable,
-				.disable	= exynos4_pd_disable,
-				.base		= S5P_PMU_LCD0_CONF,
-			},
-		},
-	}, {
-		.name		= "samsung-pd",
-		.id		= 3,
-		.dev = {
-			.platform_data = &(struct samsung_pd_info) {
-				.enable		= exynos4_pd_enable,
-				.disable	= exynos4_pd_disable,
-				.base		= S5P_PMU_LCD1_CONF,
-			},
-		},
-	}, {
-		.name		= "samsung-pd",
-		.id		= 4,
-		.dev = {
-			.platform_data = &(struct samsung_pd_info) {
-				.enable		= exynos4_pd_enable,
-				.disable	= exynos4_pd_disable,
-				.base		= S5P_PMU_TV_CONF,
-			},
-		},
-	}, {
-		.name		= "samsung-pd",
-		.id		= 5,
-		.dev = {
-			.platform_data = &(struct samsung_pd_info) {
-				.enable		= exynos4_pd_enable,
-				.disable	= exynos4_pd_disable,
-				.base		= S5P_PMU_CAM_CONF,
-			},
-		},
-	}, {
-		.name		= "samsung-pd",
-		.id		= 6,
-		.dev = {
-			.platform_data = &(struct samsung_pd_info) {
-				.enable		= exynos4_pd_enable,
-				.disable	= exynos4_pd_disable,
-				.base		= S5P_PMU_GPS_CONF,
-			},
-		},
-	},
-};
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 3df8bf4..179a992 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -1266,9 +1266,6 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&s5p_device_mfc,
 	&s5p_device_mfc_l,
 	&s5p_device_mfc_r,
-	&exynos4_device_pd[PD_MFC],
-	&exynos4_device_pd[PD_LCD0],
-	&exynos4_device_pd[PD_CAM],
 	&s5p_device_fimc_md,
 
 	/* NURI Devices */
@@ -1319,14 +1316,6 @@ static void __init nuri_machine_init(void)
 
 	/* Last */
 	platform_add_devices(nuri_devices, ARRAY_SIZE(nuri_devices));
-	s5p_device_mfc.dev.parent = &exynos4_device_pd[PD_MFC].dev;
-	s5p_device_fimd0.dev.parent = &exynos4_device_pd[PD_LCD0].dev;
-
-	s5p_device_fimc0.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_fimc1.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_fimc2.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_fimc3.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_mipi_csis0.dev.parent = &exynos4_device_pd[PD_CAM].dev;
 }
 
 MACHINE_START(NURI, "NURI")
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 23fc5cb..da871b9 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -639,13 +639,6 @@ static struct platform_device *origen_devices[] __initdata = {
 	&s5p_device_mfc_r,
 	&s5p_device_mixer,
 	&exynos4_device_ohci,
-	&exynos4_device_pd[PD_LCD0],
-	&exynos4_device_pd[PD_TV],
-	&exynos4_device_pd[PD_G3D],
-	&exynos4_device_pd[PD_LCD1],
-	&exynos4_device_pd[PD_CAM],
-	&exynos4_device_pd[PD_GPS],
-	&exynos4_device_pd[PD_MFC],
 	&origen_device_gpiokeys,
 	&origen_lcd_hv070wsa,
 	&origen_device_bluetooth,
@@ -724,13 +717,6 @@ static void __init origen_machine_init(void)
 
 	platform_add_devices(origen_devices, ARRAY_SIZE(origen_devices));
 
-	s5p_device_fimd0.dev.parent = &exynos4_device_pd[PD_LCD0].dev;
-
-	s5p_device_hdmi.dev.parent = &exynos4_device_pd[PD_TV].dev;
-	s5p_device_mixer.dev.parent = &exynos4_device_pd[PD_TV].dev;
-
-	s5p_device_mfc.dev.parent = &exynos4_device_pd[PD_MFC].dev;
-
 	samsung_bl_set(&origen_bl_gpio_info, &origen_bl_data);
 
 	origen_bt_setup();
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index bf2094e..88d1a30 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -275,13 +275,6 @@ static struct platform_device *smdkv310_devices[] __initdata = {
 	&s5p_device_mfc,
 	&s5p_device_mfc_l,
 	&s5p_device_mfc_r,
-	&exynos4_device_pd[PD_MFC],
-	&exynos4_device_pd[PD_G3D],
-	&exynos4_device_pd[PD_LCD0],
-	&exynos4_device_pd[PD_LCD1],
-	&exynos4_device_pd[PD_CAM],
-	&exynos4_device_pd[PD_TV],
-	&exynos4_device_pd[PD_GPS],
 	&exynos4_device_spdif,
 	&exynos4_device_sysmmu,
 	&samsung_asoc_dma,
@@ -334,10 +327,6 @@ static void s5p_tv_setup(void)
 	WARN_ON(gpio_request_one(EXYNOS4_GPX3(7), GPIOF_IN, "hpd-plug"));
 	s3c_gpio_cfgpin(EXYNOS4_GPX3(7), S3C_GPIO_SFN(0x3));
 	s3c_gpio_setpull(EXYNOS4_GPX3(7), S3C_GPIO_PULL_NONE);
-
-	/* setup dependencies between TV devices */
-	s5p_device_hdmi.dev.parent = &exynos4_device_pd[PD_TV].dev;
-	s5p_device_mixer.dev.parent = &exynos4_device_pd[PD_TV].dev;
 }
 
 static void __init smdkv310_map_io(void)
@@ -377,7 +366,6 @@ static void __init smdkv310_machine_init(void)
 	clk_xusbxti.rate = 24000000;
 
 	platform_add_devices(smdkv310_devices, ARRAY_SIZE(smdkv310_devices));
-	s5p_device_mfc.dev.parent = &exynos4_device_pd[PD_MFC].dev;
 }
 
 MACHINE_START(SMDKV310, "SMDKV310")
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index c38e18d..28d8f02 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -968,7 +968,6 @@ static struct platform_device *universal_devices[] __initdata = {
 	&s3c_device_i2c5,
 	&s5p_device_i2c_hdmiphy,
 	&hdmi_fixed_voltage,
-	&exynos4_device_pd[PD_TV],
 	&s5p_device_hdmi,
 	&s5p_device_sdo,
 	&s5p_device_mixer,
@@ -981,9 +980,6 @@ static struct platform_device *universal_devices[] __initdata = {
 	&s5p_device_mfc,
 	&s5p_device_mfc_l,
 	&s5p_device_mfc_r,
-	&exynos4_device_pd[PD_MFC],
-	&exynos4_device_pd[PD_LCD0],
-	&exynos4_device_pd[PD_CAM],
 	&cam_i_core_fixed_reg_dev,
 	&cam_s_if_fixed_reg_dev,
 	&s5p_device_fimc_md,
@@ -1002,10 +998,6 @@ void s5p_tv_setup(void)
 	gpio_request_one(EXYNOS4_GPX3(7), GPIOF_IN, "hpd-plug");
 	s3c_gpio_cfgpin(EXYNOS4_GPX3(7), S3C_GPIO_SFN(0x3));
 	s3c_gpio_setpull(EXYNOS4_GPX3(7), S3C_GPIO_PULL_NONE);
-
-	/* setup dependencies between TV devices */
-	s5p_device_hdmi.dev.parent = &exynos4_device_pd[PD_TV].dev;
-	s5p_device_mixer.dev.parent = &exynos4_device_pd[PD_TV].dev;
 }
 
 static void __init universal_reserve(void)
@@ -1039,15 +1031,6 @@ static void __init universal_machine_init(void)
 
 	/* Last */
 	platform_add_devices(universal_devices, ARRAY_SIZE(universal_devices));
-
-	s5p_device_mfc.dev.parent = &exynos4_device_pd[PD_MFC].dev;
-	s5p_device_fimd0.dev.parent = &exynos4_device_pd[PD_LCD0].dev;
-
-	s5p_device_fimc0.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_fimc1.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_fimc2.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_fimc3.dev.parent = &exynos4_device_pd[PD_CAM].dev;
-	s5p_device_mipi_csis0.dev.parent = &exynos4_device_pd[PD_CAM].dev;
 }
 
 MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
new file mode 100644
index 0000000..95a7c55
--- /dev/null
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -0,0 +1,183 @@
+/*
+ * Exynos4 Generic power domain support.
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Implementation of Exynos4 specific power domain control which is used in
+ * conjunction with runtime-pm. Support for both device-tree and non-device-tree
+ * based power domain support is included.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/pm_domain.h>
+#include <linux/delay.h>
+#include <linux/of_address.h>
+
+#include <mach/regs-pmu.h>
+#include <plat/devs.h>
+
+/*
+ * Exynos4 specific wrapper around the generic power domain
+ */
+struct exynos4_pm_domain {
+	void __iomem *base;
+	char const *name;
+	bool is_off;
+	struct generic_pm_domain pd;
+};
+
+static int exynos4_pd_power(struct generic_pm_domain *domain, bool power_on)
+{
+	struct exynos4_pm_domain *pd;
+	void __iomem *base;
+	u32 timeout, pwr;
+	char *op;
+
+	pd = container_of(domain, struct exynos4_pm_domain, pd);
+	base = pd->base;
+
+	pwr = (power_on) ? S5P_INT_LOCAL_PWR_EN : 0;
+	__raw_writel(pwr, base);
+
+	/* Wait max 1ms */
+	timeout = 10;
+
+	while ((__raw_readl(base + 0x4) & S5P_INT_LOCAL_PWR_EN)	!= pwr) {
+		if (!timeout) {
+			op = (power_on) ? "enable" : "disable";
+			pr_err("Power domain %s %s failed\n", op, domain->name);
+			return -ETIMEDOUT;
+		}
+		timeout--;
+		cpu_relax();
+		usleep_range(80, 100);
+	}
+	return 0;
+}
+
+static int exynos4_pd_power_on(struct generic_pm_domain *domain)
+{
+	return exynos4_pd_power(domain, true);
+}
+
+static int exynos4_pd_power_off(struct generic_pm_domain *domain)
+{
+	return exynos4_pd_power(domain, false);
+}
+
+
+#define EXYNOS4_GPD(PD, BASE, NAME)			\
+static struct exynos4_pm_domain PD = {			\
+	.base = (void __iomem *)BASE,			\
+	.name = NAME,					\
+	.pd = {						\
+		.power_off = exynos4_pd_power_off,	\
+		.power_on = exynos4_pd_power_on,	\
+	},						\
+}
+
+EXYNOS4_GPD(exynos4_pd_mfc, S5P_PMU_MFC_CONF, "pd-mfc");
+EXYNOS4_GPD(exynos4_pd_g3d, S5P_PMU_G3D_CONF, "pd-g3d");
+EXYNOS4_GPD(exynos4_pd_lcd0, S5P_PMU_LCD0_CONF, "pd-lcd0");
+EXYNOS4_GPD(exynos4_pd_lcd1, S5P_PMU_LCD1_CONF, "pd-lcd1");
+EXYNOS4_GPD(exynos4_pd_tv, S5P_PMU_TV_CONF, "pd-tv");
+EXYNOS4_GPD(exynos4_pd_cam, S5P_PMU_CAM_CONF, "pd-cam");
+EXYNOS4_GPD(exynos4_pd_gps, S5P_PMU_GPS_CONF, "pd-gps");
+
+static struct exynos4_pm_domain *exynos4_pm_domains[] = {
+	&exynos4_pd_mfc,
+	&exynos4_pd_g3d,
+	&exynos4_pd_lcd0,
+	&exynos4_pd_lcd1,
+	&exynos4_pd_tv,
+	&exynos4_pd_cam,
+	&exynos4_pd_gps,
+};
+
+static __init int exynos4_pm_init_power_domain(void)
+{
+	int idx;
+	struct device_node *np;
+
+#ifdef CONFIG_OF
+	if (!of_have_populated_dt())
+		goto no_dt;
+
+	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
+		struct exynos4_pm_domain *pd;
+
+		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+		if (!pd) {
+			pr_err("exynos4_pm_init_power_domain: failed to "
+					"allocate memory for domain\n");
+			return -ENOMEM;
+		}
+
+		if (of_get_property(np, "samsung,exynos4210-pd-off", NULL))
+			pd->is_off = true;
+		pd->name = np->name;
+		pd->base = of_iomap(np, 0);
+		pd->pd.power_off = exynos4_pd_power_off;
+		pd->pd.power_on = exynos4_pd_power_on;
+		pd->pd.of_node = np;
+		pm_genpd_init(&pd->pd, NULL, false);
+	}
+	return 0;
+#endif /* CONFIG_OF */
+
+ no_dt:
+	for (idx = 0; idx < ARRAY_SIZE(exynos4_pm_domains); idx++)
+		pm_genpd_init(&exynos4_pm_domains[idx]->pd, NULL,
+				exynos4_pm_domains[idx]->is_off);
+
+#ifdef CONFIG_S5P_DEV_FIMD0
+	if (pm_genpd_add_device(&exynos4_pd_lcd0.pd, &s5p_device_fimd0.dev))
+		pr_info("error in adding fimd0 to lcd0 power domain\n");
+#endif
+#ifdef CONFIG_S5P_DEV_TV
+	if (pm_genpd_add_device(&exynos4_pd_tv.pd, &s5p_device_hdmi.dev))
+		pr_info("error in adding hdmi to tv power domain\n");
+	if (pm_genpd_add_device(&exynos4_pd_tv.pd, &s5p_device_mixer.dev))
+		pr_info("error in adding mixer to tv power domain\n");
+#endif
+#ifdef CONFIG_S5P_DEV_MFC
+	if (pm_genpd_add_device(&exynos4_pd_mfc.pd, &s5p_device_mfc.dev))
+		pr_info("error in adding mfc to mfc power domain\n");
+#endif
+#ifdef CONFIG_S5P_DEV_FIMC0
+	if (pm_genpd_add_device(&exynos4_pd_cam.pd, &s5p_device_fimc0.dev))
+		pr_info("error in adding fimc0 to cam power domain\n");
+#endif
+#ifdef CONFIG_S5P_DEV_FIMC1
+	if (pm_genpd_add_device(&exynos4_pd_cam.pd, &s5p_device_fimc1.dev))
+		pr_info("error in adding fimc1 to cam power domain\n");
+#endif
+#ifdef CONFIG_S5P_DEV_FIMC2
+	if (pm_genpd_add_device(&exynos4_pd_cam.pd, &s5p_device_fimc2.dev))
+		pr_info("error in adding fimc2 to cam power domain\n");
+#endif
+#ifdef CONFIG_S5P_DEV_FIMC3
+	if (pm_genpd_add_device(&exynos4_pd_cam.pd, &s5p_device_fimc3.dev))
+		pr_info("error in adding fimc3 to cam power domain\n");
+#endif
+#ifdef CONFIG_S5P_DEV_CSIS0
+	if (pm_genpd_add_device(&exynos4_pd_cam.pd, &s5p_device_mipi_csis0.dev))
+		pr_info("error in adding csis0 to cam power domain\n");
+#endif
+	return 0;
+}
+arch_initcall(exynos4_pm_init_power_domain);
+
+static __init int exynos4_pm_late_initcall(void)
+{
+	pm_genpd_poweroff_unused();
+	return 0;
+}
+late_initcall(exynos4_pm_late_initcall);
-- 
1.6.6.rc2
