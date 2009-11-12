From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 12 Nov 2009 09:22:00 +0100
Subject: [PATCH 16/18] ARM: S5PC1xx: add platform helpers for SDHCI host
	controllers
In-Reply-To: <1258014122-18185-16-git-send-email-m.szyprowski@samsung.com>
References: <1258014122-18185-1-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-2-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-3-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-4-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-5-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-6-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-7-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-8-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-9-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-10-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-11-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-12-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-13-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-14-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-15-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-16-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1258014122-18185-17-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

From: Kyungmin Park <kyungmin.park@samsung.com>

Samsung S5PC100 has 3 SDHCI controllers compatible with the one known from
previous SoCs series. Add required platform setup and support code that
the devices can be used with sdhci-s3c driver.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig            |    6 ++
 arch/arm/mach-s5pc100/Makefile           |    4 ++
 arch/arm/mach-s5pc100/cpu.c              |    3 +
 arch/arm/mach-s5pc100/setup-sdhci.c      |   63 ++++++++++++++++++++++
 arch/arm/plat-s3c/Kconfig                |    5 ++
 arch/arm/plat-s3c/Makefile               |    1 +
 arch/arm/plat-s3c/dev-hsmmc2.c           |   65 ++++++++++++++++++++++
 arch/arm/plat-s3c/include/plat/sdhci.h   |   55 +++++++++++++++++++
 arch/arm/plat-s5pc1xx/Kconfig            |    6 ++
 arch/arm/plat-s5pc1xx/Makefile           |    1 +
 arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c |   86 ++++++++++++++++++++++++++++++
 11 files changed, 295 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pc100/setup-sdhci.c
 create mode 100644 arch/arm/plat-s3c/dev-hsmmc2.c
 create mode 100644 arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 36e7e00..21b1821 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -14,6 +14,12 @@ config CPU_S5PC100
 	help
 	  Enable S5PC100 CPU support
 
+config S5PC100_SETUP_SDHCI
+        bool
+        select S5PC1XX_SETUP_SDHCI_GPIO
+        help
+          Internal helper functions for S5PC100 based SDHCI systems
+
 config MACH_SMDKC100
 	bool "SMDKC100"
 	select CPU_S5PC100
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index afc89b3..809ff10 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -13,5 +13,9 @@ obj-				:=
 
 obj-$(CONFIG_CPU_S5PC100)	+= cpu.o
 
+# Helper and device support
+
+obj-$(CONFIG_S5PC100_SETUP_SDHCI)       += setup-sdhci.o
+
 # machine support
 obj-$(CONFIG_MACH_SMDKC100)	+= mach-smdkc100.o
diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
index 1319e3d..d79e757 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/cpu.c
@@ -75,6 +75,9 @@ void __init s5pc100_map_io(void)
 	iotable_init(s5pc100_iodesc, ARRAY_SIZE(s5pc100_iodesc));
 
 	/* initialise device information early */
+	s5pc100_default_sdhci0();
+	s5pc100_default_sdhci1();
+	s5pc100_default_sdhci2();
 
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
diff --git a/arch/arm/mach-s5pc100/setup-sdhci.c b/arch/arm/mach-s5pc100/setup-sdhci.c
new file mode 100644
index 0000000..634bac3
--- /dev/null
+++ b/arch/arm/mach-s5pc100/setup-sdhci.c
@@ -0,0 +1,63 @@
+/* linux/arch/arm/mach-s5pc100/setup-sdhci.c
+ *
+ * Copyright 2008 Samsung Electronics
+ *
+ * S5PC100 - Helper functions for settign up SDHCI device(s) (HSMMC)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+
+#include <plat/regs-sdhci.h>
+#include <plat/sdhci.h>
+
+/* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
+
+char *s5pc100_hsmmc_clksrcs[4] = {
+	[0] = "hsmmc",
+	[1] = "hsmmc",
+	/* [2] = "mmc_bus", not yet succesfuuly used yet */
+	/* [3] = "48m", - note not succesfully used yet */
+};
+
+
+void s5pc100_setup_sdhci0_cfg_card(struct platform_device *dev,
+				    void __iomem *r,
+				    struct mmc_ios *ios,
+				    struct mmc_card *card)
+{
+	u32 ctrl2, ctrl3;
+
+	/* don't need to alter anything acording to card-type */
+
+	writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA, r + S3C64XX_SDHCI_CONTROL4);
+
+	ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
+	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
+	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
+		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
+		  S3C_SDHCI_CTRL2_ENFBCLKRX |
+		  S3C_SDHCI_CTRL2_DFCNT_NONE |
+		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
+
+	if (ios->clock < 25 * 1000000)
+		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
+			 S3C_SDHCI_CTRL3_FCSEL2 |
+			 S3C_SDHCI_CTRL3_FCSEL1 |
+			 S3C_SDHCI_CTRL3_FCSEL0);
+	else
+		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
+
+	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
+	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
+}
diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
index f155a84..e139a72 100644
--- a/arch/arm/plat-s3c/Kconfig
+++ b/arch/arm/plat-s3c/Kconfig
@@ -184,6 +184,11 @@ config S3C_DEV_HSMMC1
 	help
 	  Compile in platform device definitions for HSMMC channel 1
 
+config S3C_DEV_HSMMC2
+	bool
+	help
+	  Compile in platform device definitions for HSMMC channel 2
+
 config S3C_DEV_I2C1
 	bool
 	help
diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index 3c09109..50444da 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_HAVE_PWM)		+= pwm.o
 
 obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
 obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
+obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
 obj-y				+= dev-i2c0.o
 obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
 obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
diff --git a/arch/arm/plat-s3c/dev-hsmmc2.c b/arch/arm/plat-s3c/dev-hsmmc2.c
new file mode 100644
index 0000000..082e55a
--- /dev/null
+++ b/arch/arm/plat-s3c/dev-hsmmc2.c
@@ -0,0 +1,65 @@
+/* linux/arch/arm/plat-s3c/dev-hsmmc2.c
+ *
+ * Copyright (c) 2009 Samsung Electronics
+ *
+ * S3C series device definition for hsmmc device 2
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
+static struct resource s3c_hsmmc2_resource[] = {
+	[0] = {
+		.start = S3C_PA_HSMMC2,
+		.end   = S3C_PA_HSMMC2 + S3C_SZ_HSMMC - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_HSMMC2,
+		.end   = IRQ_HSMMC2,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static u64 s3c_device_hsmmc2_dmamask = 0xffffffffUL;
+
+struct s3c_sdhci_platdata s3c_hsmmc2_def_platdata = {
+	.max_width	= 4,
+	.host_caps	= (MMC_CAP_4_BIT_DATA |
+			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+};
+
+struct platform_device s3c_device_hsmmc2 = {
+	.name		= "s3c-sdhci",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(s3c_hsmmc2_resource),
+	.resource	= s3c_hsmmc2_resource,
+	.dev		= {
+		.dma_mask		= &s3c_device_hsmmc2_dmamask,
+		.coherent_dma_mask	= 0xffffffffUL,
+		.platform_data		= &s3c_hsmmc2_def_platdata,
+	},
+};
+
+void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
+{
+	struct s3c_sdhci_platdata *set = &s3c_hsmmc2_def_platdata;
+
+	set->max_width = pd->max_width;
+
+	if (pd->cfg_gpio)
+		set->cfg_gpio = pd->cfg_gpio;
+	if (pd->cfg_card)
+		set->cfg_card = pd->cfg_card;
+}
diff --git a/arch/arm/plat-s3c/include/plat/sdhci.h b/arch/arm/plat-s3c/include/plat/sdhci.h
index f615308..c71d078 100644
--- a/arch/arm/plat-s3c/include/plat/sdhci.h
+++ b/arch/arm/plat-s3c/include/plat/sdhci.h
@@ -57,6 +57,7 @@ struct s3c_sdhci_platdata {
  */
 extern void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd);
 extern void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd);
+extern void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd);
 
 /* Default platform data, exported so that per-cpu initialisation can
  * set the correct one when there are more than one cpu type selected.
@@ -64,11 +65,15 @@ extern void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd);
 
 extern struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata;
 extern struct s3c_sdhci_platdata s3c_hsmmc1_def_platdata;
+extern struct s3c_sdhci_platdata s3c_hsmmc2_def_platdata;
 
 /* Helper function availablity */
 
 extern void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
+extern void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
+extern void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
+extern void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 
 /* S3C6400 SDHCI setup */
 
@@ -145,4 +150,54 @@ static inline void s3c6410_default_sdhci0(void) { }
 static inline void s3c6410_default_sdhci1(void) { }
 #endif /* CONFIG_S3C6410_SETUP_SDHCI */
 
+/* S5PC100 SDHCI setup */
+
+#ifdef CONFIG_S5PC100_SETUP_SDHCI
+extern char *s5pc100_hsmmc_clksrcs[4];
+
+extern void s5pc100_setup_sdhci0_cfg_card(struct platform_device *dev,
+					   void __iomem *r,
+					   struct mmc_ios *ios,
+					   struct mmc_card *card);
+
+#ifdef CONFIG_S3C_DEV_HSMMC
+static inline void s5pc100_default_sdhci0(void)
+{
+	s3c_hsmmc0_def_platdata.clocks = s5pc100_hsmmc_clksrcs;
+	s3c_hsmmc0_def_platdata.cfg_gpio = s5pc100_setup_sdhci0_cfg_gpio;
+	s3c_hsmmc0_def_platdata.cfg_card = s5pc100_setup_sdhci0_cfg_card;
+}
+#else
+static inline void s5pc100_default_sdhci0(void) { }
+#endif /* CONFIG_S3C_DEV_HSMMC */
+
+#ifdef CONFIG_S3C_DEV_HSMMC1
+static inline void s5pc100_default_sdhci1(void)
+{
+	s3c_hsmmc1_def_platdata.clocks = s5pc100_hsmmc_clksrcs;
+	s3c_hsmmc1_def_platdata.cfg_gpio = s5pc100_setup_sdhci1_cfg_gpio;
+	s3c_hsmmc1_def_platdata.cfg_card = s5pc100_setup_sdhci0_cfg_card;
+}
+#else
+static inline void s5pc100_default_sdhci1(void) { }
+#endif /* CONFIG_S3C_DEV_HSMMC1 */
+
+#ifdef CONFIG_S3C_DEV_HSMMC2
+static inline void s5pc100_default_sdhci2(void)
+{
+	s3c_hsmmc2_def_platdata.clocks = s5pc100_hsmmc_clksrcs;
+	s3c_hsmmc2_def_platdata.cfg_gpio = s5pc100_setup_sdhci2_cfg_gpio;
+	s3c_hsmmc2_def_platdata.cfg_card = s5pc100_setup_sdhci0_cfg_card;
+}
+#else
+static inline void s5pc100_default_sdhci2(void) { }
+#endif /* CONFIG_S3C_DEV_HSMMC1 */
+
+
+#else
+static inline void s5pc100_default_sdhci0(void) { }
+static inline void s5pc100_default_sdhci1(void) { }
+static inline void s5pc100_default_sdhci2(void) { }
+#endif /* CONFIG_S5PC100_SETUP_SDHCI */
+
 #endif /* __PLAT_S3C_SDHCI_H */
diff --git a/arch/arm/plat-s5pc1xx/Kconfig b/arch/arm/plat-s5pc1xx/Kconfig
index 1fc25b9..1608e62 100644
--- a/arch/arm/plat-s5pc1xx/Kconfig
+++ b/arch/arm/plat-s5pc1xx/Kconfig
@@ -55,4 +55,10 @@ config S5PC1XX_SETUP_I2C1
 	bool
 	help
 	  Common setup code for i2c bus 1.
+
+config S5PC1XX_SETUP_SDHCI_GPIO
+	bool
+	help
+	  Common setup code for SDHCI gpio.
+
 endif
diff --git a/arch/arm/plat-s5pc1xx/Makefile b/arch/arm/plat-s5pc1xx/Makefile
index 40ee957..278f268 100644
--- a/arch/arm/plat-s5pc1xx/Makefile
+++ b/arch/arm/plat-s5pc1xx/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_S5P_GPIO_CFG_S5PC1XX) += gpio-config.o
 obj-$(CONFIG_S5PC1XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 obj-$(CONFIG_S5PC1XX_SETUP_I2C0) += setup-i2c0.o
 obj-$(CONFIG_S5PC1XX_SETUP_I2C1) += setup-i2c1.o
+obj-$(CONFIG_S5PC1XX_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
diff --git a/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c b/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
new file mode 100644
index 0000000..3577619
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
@@ -0,0 +1,86 @@
+/* linux/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
+ *
+ * Copyright 2009 Samsung Eletronics
+ *
+ * S5PC1XX - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+
+#include <mach/gpio.h>
+#include <plat/gpio-cfg.h>
+#include <plat/regs-sdhci.h>
+
+void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+	unsigned int end;
+	unsigned int num;
+
+	num = width;
+	/* In case of 8 width, we should decrease the 2 */
+	if (width == 8)
+		num = width - 2;
+
+	end = S5PC100_GPG0(2 + num);
+
+	/* Set all the necessary GPG0/GPG1 pins to special-function 0 */
+	for (gpio = S5PC100_GPG0(0); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	if (width == 8) {
+		for (gpio = S5PC100_GPG1(0); gpio <= S5PC100_GPG1(1); gpio++) {
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		}
+	}
+
+	s3c_gpio_setpull(S5PC100_GPG1(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC100_GPG1(2), S3C_GPIO_SFN(2));
+}
+
+void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+	unsigned int end;
+
+	end = S5PC100_GPG2(2 + width);
+
+	/* Set all the necessary GPG2 pins to special-function 2 */
+	for (gpio = S5PC100_GPG2(0); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	s3c_gpio_setpull(S5PC100_GPG2(6), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC100_GPG2(6), S3C_GPIO_SFN(2));
+}
+
+void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+	unsigned int end;
+
+	end = S5PC100_GPG3(2 + width);
+
+	/* Set all the necessary GPG3 pins to special-function 2 */
+	for (gpio = S5PC100_GPG3(0); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	s3c_gpio_setpull(S5PC100_GPG3(6), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC100_GPG3(6), S3C_GPIO_SFN(2));
+}
-- 
1.6.5
