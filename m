From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Aug 2010 14:03:55 +0200
Subject: [PATCH 6/9] ARM: S5PV210: convert sdhci to device-table
In-Reply-To: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
References: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1281528238-7298-7-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert s3c-sdhci platform device initialization to device-table approach.
The conversion is performed only for S5PV210 SoC.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig              |   39 ++++---
 arch/arm/mach-s5pv210/Makefile             |    3 +-
 arch/arm/mach-s5pv210/cpu.c                |    5 -
 arch/arm/mach-s5pv210/dev-table.c          |   18 +++
 arch/arm/mach-s5pv210/mach-aquila.c        |    9 +-
 arch/arm/mach-s5pv210/mach-goni.c          |    9 +-
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c   |  137 ----------------------
 arch/arm/mach-s5pv210/setup-sdhci.c        |  168 +++++++++++++++++++++++++++-
 arch/arm/plat-samsung/Kconfig              |   15 ---
 arch/arm/plat-samsung/Makefile             |    3 -
 arch/arm/plat-samsung/dev-hsmmc.c          |   58 +++-------
 arch/arm/plat-samsung/dev-hsmmc1.c         |   73 ------------
 arch/arm/plat-samsung/dev-hsmmc2.c         |   74 ------------
 arch/arm/plat-samsung/dev-hsmmc3.c         |   77 -------------
 arch/arm/plat-samsung/dev_templates.c      |    2 +
 arch/arm/plat-samsung/include/plat/sdhci.h |  106 ++++++++----------
 16 files changed, 285 insertions(+), 511 deletions(-)
 delete mode 100644 arch/arm/mach-s5pv210/setup-sdhci-gpio.c
 delete mode 100644 arch/arm/plat-samsung/dev-hsmmc1.c
 delete mode 100644 arch/arm/plat-samsung/dev-hsmmc2.c
 delete mode 100644 arch/arm/plat-samsung/dev-hsmmc3.c

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 680b55b..7b59855 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -42,16 +42,29 @@ config S5PV210_SETUP_KEYPAD
 	help
 	  Common setup code for keypad.
 
-config S5PV210_SETUP_SDHCI
+config S5PV210_SETUP_SDHCI0
+	select S3C_DEV_HSMMC
         bool
-        select S5PV210_SETUP_SDHCI_GPIO
         help
           Internal helper functions for S5PV210 based SDHCI systems
 
-config S5PV210_SETUP_SDHCI_GPIO
-	bool
-	help
-	  Common setup code for SDHCI gpio.
+config S5PV210_SETUP_SDHCI1
+	select S3C_DEV_HSMMC
+        bool
+        help
+          Internal helper functions for S5PV210 based SDHCI systems
+
+config S5PV210_SETUP_SDHCI2
+	select S3C_DEV_HSMMC
+        bool
+        help
+          Internal helper functions for S5PV210 based SDHCI systems
+
+config S5PV210_SETUP_SDHCI3
+	select S3C_DEV_HSMMC
+        bool
+        help
+          Internal helper functions for S5PV210 based SDHCI systems
 
 config S5PC110_DEV_ONENAND
 	bool
@@ -68,11 +81,10 @@ config MACH_AQUILA
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC1
-	select S3C_DEV_HSMMC2
 	select S5PV210_SETUP_FB_24BPP
-	select S5PV210_SETUP_SDHCI
+	select S5PV210_SETUP_SDHCI0
+	select S5PV210_SETUP_SDHCI1
+	select S5PV210_SETUP_SDHCI2
 	help
 	  Machine support for the Samsung Aquila target based on S5PC110 SoC
 
@@ -84,11 +96,10 @@ config MACH_GONI
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC1
-	select S3C_DEV_HSMMC2
 	select S5PV210_SETUP_FB_24BPP
-	select S5PV210_SETUP_SDHCI
+	select S5PV210_SETUP_SDHCI0
+	select S5PV210_SETUP_SDHCI1
+	select S5PV210_SETUP_SDHCI2
 	help
 	  Machine support for Samsung GONI board
 	  S5PC110(MCP) is one of package option of S5PV210
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 23bde19..a5fd9ae 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -33,5 +33,4 @@ obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
 obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
 obj-$(CONFIG_S5PV210_SETUP_IDE)		+= setup-ide.o
 obj-$(CONFIG_S5PV210_SETUP_KEYPAD)	+= setup-keypad.o
-obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
-obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
+obj-$(CONFIG_S3C_DEV_HSMMC)		+= setup-sdhci.o
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 785f011..5f5ab1e 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -90,11 +90,6 @@ void __init s5pv210_map_io(void)
 	s5pv210_register_devtable();
 
 	/* initialise device information early */
-	s5pv210_default_sdhci0();
-	s5pv210_default_sdhci1();
-	s5pv210_default_sdhci2();
-	s5pv210_default_sdhci3();
-
 	s3c_adc_setname("s3c64xx-adc");
 
 	s3c_cfcon_setname("s5pv210-pata");
diff --git a/arch/arm/mach-s5pv210/dev-table.c b/arch/arm/mach-s5pv210/dev-table.c
index 38e870a..86f3792 100644
--- a/arch/arm/mach-s5pv210/dev-table.c
+++ b/arch/arm/mach-s5pv210/dev-table.c
@@ -81,6 +81,24 @@ struct s3c_pdev_table s5pv210_dev_table[] __initdata = {
 			IRQ_S5P_UART_RX3, IRQ_S5P_UART_TX3, IRQ_S5P_UART_ERR3,
 		},
 	}, {
+		.type	= SAMSUNG_DEVICE_SDHCI,
+		.name	= "s3c-sdhci",
+		.index	= 0,
+		.res	= {S5PV210_PA_HSMMC(0), IRQ_HSMMC0},
+		.defpdata = s5pv210_hsmmc0_def_platdata_p,
+	}, {
+		.type	= SAMSUNG_DEVICE_SDHCI,
+		.name	= "s3c-sdhci",
+		.index	= 1,
+		.res	= {S5PV210_PA_HSMMC(1), IRQ_HSMMC1},
+		.defpdata = s5pv210_hsmmc1_def_platdata_p,
+	}, {
+		.type	= SAMSUNG_DEVICE_SDHCI,
+		.name	= "s3c-sdhci",
+		.index	= 2,
+		.res	= {S5PV210_PA_HSMMC(2), IRQ_HSMMC2},
+		.defpdata = s5pv210_hsmmc2_def_platdata_p,
+	}, {
 		.type	= SAMSUNG_DEVICE_ONENAND,
 		.name	= "s5pc110-onenand",
 		.index	= -1,
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 5a502f3..c4f5261 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -470,18 +470,12 @@ static void aquila_setup_sdhci(void)
 	gpio_request(AQUILA_EXT_FLASH_EN, "FLASH_EN");
 	gpio_direction_output(AQUILA_EXT_FLASH_EN, 1);
 
-	s3c_sdhci0_set_platdata(&aquila_hsmmc0_data);
-	s3c_sdhci1_set_platdata(&aquila_hsmmc1_data);
-	s3c_sdhci2_set_platdata(&aquila_hsmmc2_data);
 };
 
 static struct platform_device *aquila_devices[] __initdata = {
 	&aquila_i2c_gpio_pmic,
 	&aquila_device_gpiokeys,
 	&s3c_device_fb,
-	&s3c_device_hsmmc0,
-	&s3c_device_hsmmc1,
-	&s3c_device_hsmmc2,
 	&s5p_device_fimc0,
 	&s5p_device_fimc1,
 	&s5p_device_fimc2,
@@ -489,6 +483,9 @@ static struct platform_device *aquila_devices[] __initdata = {
 
 static struct s3c_devtable aquila_devtable[] __initdata = {
 	{ .type = SAMSUNG_DEVICE_ONENAND,	.index = -1 },
+	{ .type = SAMSUNG_DEVICE_SDHCI,		.index = 0, .pdata = &aquila_hsmmc0_data},
+	{ .type = SAMSUNG_DEVICE_SDHCI,		.index = 1, .pdata = &aquila_hsmmc1_data},
+	{ .type = SAMSUNG_DEVICE_SDHCI,		.index = 2, .pdata = &aquila_hsmmc2_data},
 };
 
 static void __init aquila_map_io(void)
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index e24b815..9c9f6ca 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -449,9 +449,6 @@ static void goni_setup_sdhci(void)
 	gpio_request(GONI_EXT_FLASH_EN, "FLASH_EN");
 	gpio_direction_output(GONI_EXT_FLASH_EN, 1);
 
-	s3c_sdhci0_set_platdata(&goni_hsmmc0_data);
-	s3c_sdhci1_set_platdata(&goni_hsmmc1_data);
-	s3c_sdhci2_set_platdata(&goni_hsmmc2_data);
 };
 
 static struct platform_device *goni_devices[] __initdata = {
@@ -461,13 +458,13 @@ static struct platform_device *goni_devices[] __initdata = {
 	&s5p_device_fimc0,
 	&s5p_device_fimc1,
 	&s5p_device_fimc2,
-	&s3c_device_hsmmc0,
-	&s3c_device_hsmmc1,
-	&s3c_device_hsmmc2,
 };
 
 static struct s3c_devtable goni_devtable[] __initdata = {
 	{ .type = SAMSUNG_DEVICE_ONENAND, .index = -1, },
+	{ .type = SAMSUNG_DEVICE_SDHCI, .index = 0, .pdata = &goni_hsmmc0_data},
+	{ .type = SAMSUNG_DEVICE_SDHCI,	.index = 1, .pdata = &goni_hsmmc1_data},
+	{ .type = SAMSUNG_DEVICE_SDHCI,	.index = 2, .pdata = &goni_hsmmc2_data},
 };
 
 static void __init goni_map_io(void)
diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
deleted file mode 100644
index b18587b..0000000
--- a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
+++ /dev/null
@@ -1,137 +0,0 @@
-/* linux/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5PV210 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/gpio.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/card.h>
-
-#include <plat/gpio-cfg.h>
-#include <plat/regs-sdhci.h>
-#include <plat/sdhci.h>
-
-void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
-{
-	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
-	unsigned int gpio;
-
-	/* Set all the necessary GPG0/GPG1 pins to special-function 2 */
-	for (gpio = S5PV210_GPG0(0); gpio < S5PV210_GPG0(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-	switch (width) {
-	case 8:
-		/* GPG1[3:6] special-funtion 3 */
-		for (gpio = S5PV210_GPG1(3); gpio <= S5PV210_GPG1(6); gpio++) {
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
-			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		}
-	case 4:
-		/* GPG0[3:6] special-funtion 2 */
-		for (gpio = S5PV210_GPG0(3); gpio <= S5PV210_GPG0(6); gpio++) {
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		}
-	default:
-		break;
-	}
-
-	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
-		s3c_gpio_setpull(S5PV210_GPG0(2), S3C_GPIO_PULL_UP);
-		s3c_gpio_cfgpin(S5PV210_GPG0(2), S3C_GPIO_SFN(2));
-	}
-}
-
-void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
-{
-	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
-	unsigned int gpio;
-
-	/* Set all the necessary GPG1[0:1] pins to special-function 2 */
-	for (gpio = S5PV210_GPG1(0); gpio < S5PV210_GPG1(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	/* Data pin GPG1[3:6] to special-function 2 */
-	for (gpio = S5PV210_GPG1(3); gpio <= S5PV210_GPG1(6); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
-		s3c_gpio_setpull(S5PV210_GPG1(2), S3C_GPIO_PULL_UP);
-		s3c_gpio_cfgpin(S5PV210_GPG1(2), S3C_GPIO_SFN(2));
-	}
-}
-
-void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
-{
-	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
-	unsigned int gpio;
-
-	/* Set all the necessary GPG2[0:1] pins to special-function 2 */
-	for (gpio = S5PV210_GPG2(0); gpio < S5PV210_GPG2(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	switch (width) {
-	case 8:
-		/* Data pin GPG3[3:6] to special-function 3 */
-		for (gpio = S5PV210_GPG3(3); gpio <= S5PV210_GPG3(6); gpio++) {
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
-			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		}
-	case 4:
-		/* Data pin GPG2[3:6] to special-function 2 */
-		for (gpio = S5PV210_GPG2(3); gpio <= S5PV210_GPG2(6); gpio++) {
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		}
-	default:
-		break;
-	}
-
-	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
-		s3c_gpio_setpull(S5PV210_GPG2(2), S3C_GPIO_PULL_UP);
-		s3c_gpio_cfgpin(S5PV210_GPG2(2), S3C_GPIO_SFN(2));
-	}
-}
-
-void s5pv210_setup_sdhci3_cfg_gpio(struct platform_device *dev, int width)
-{
-	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
-	unsigned int gpio;
-
-	/* Set all the necessary GPG3[0:2] pins to special-function 2 */
-	for (gpio = S5PV210_GPG3(0); gpio < S5PV210_GPG3(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	/* Data pin GPG3[3:6] to special-function 2 */
-	for (gpio = S5PV210_GPG3(3); gpio <= S5PV210_GPG3(6); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
-		s3c_gpio_setpull(S5PV210_GPG3(2), S3C_GPIO_PULL_UP);
-		s3c_gpio_cfgpin(S5PV210_GPG3(2), S3C_GPIO_SFN(2));
-	}
-}
diff --git a/arch/arm/mach-s5pv210/setup-sdhci.c b/arch/arm/mach-s5pv210/setup-sdhci.c
index c32e202..b946d10 100644
--- a/arch/arm/mach-s5pv210/setup-sdhci.c
+++ b/arch/arm/mach-s5pv210/setup-sdhci.c
@@ -19,19 +19,21 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 
+#include <mach/gpio.h>
+#include <plat/gpio-cfg.h>
 #include <plat/regs-sdhci.h>
 #include <plat/sdhci.h>
 
 /* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
 
-char *s5pv210_hsmmc_clksrcs[4] = {
+static char *s5pv210_hsmmc_clksrcs[4] = {
 	[0] = "hsmmc",		/* HCLK */
 	/* [1] = "hsmmc",	- duplicate HCLK entry */
 	[2] = "sclk_mmc",	/* mmc_bus */
 	/* [3] = NULL,		- reserved */
 };
 
-void s5pv210_setup_sdhci_cfg_card(struct platform_device *dev,
+static void s5pv210_setup_sdhci_cfg_card(struct platform_device *dev,
 				    void __iomem *r,
 				    struct mmc_ios *ios,
 				    struct mmc_card *card)
@@ -61,3 +63,165 @@ void s5pv210_setup_sdhci_cfg_card(struct platform_device *dev,
 	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
 	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
 }
+
+#ifdef CONFIG_S5PV210_SETUP_SDHCI0
+
+static void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
+{
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
+	unsigned int gpio;
+
+	/* Set all the necessary GPG0/GPG1 pins to special-function 2 */
+	for (gpio = S5PV210_GPG0(0); gpio < S5PV210_GPG0(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+	switch (width) {
+	case 8:
+		/* GPG1[3:6] special-funtion 3 */
+		for (gpio = S5PV210_GPG1(3); gpio <= S5PV210_GPG1(6); gpio++) {
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		}
+	case 4:
+		/* GPG0[3:6] special-funtion 2 */
+		for (gpio = S5PV210_GPG0(3); gpio <= S5PV210_GPG0(6); gpio++) {
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		}
+	default:
+		break;
+	}
+
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_setpull(S5PV210_GPG0(2), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(S5PV210_GPG0(2), S3C_GPIO_SFN(2));
+	}
+}
+
+struct s3c_sdhci_platdata s5pv210_hsmmc0_def_platdata __initdata = {
+	.max_width	= 4,
+	.host_caps	= (MMC_CAP_4_BIT_DATA |
+			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.clocks		= s5pv210_hsmmc_clksrcs,
+	.cfg_gpio	= s5pv210_setup_sdhci0_cfg_gpio,
+	.cfg_card	= s5pv210_setup_sdhci_cfg_card,
+};
+
+#endif
+
+#ifdef CONFIG_S5PV210_SETUP_SDHCI1
+
+static void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
+{
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
+	unsigned int gpio;
+
+	/* Set all the necessary GPG1[0:1] pins to special-function 2 */
+	for (gpio = S5PV210_GPG1(0); gpio < S5PV210_GPG1(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	/* Data pin GPG1[3:6] to special-function 2 */
+	for (gpio = S5PV210_GPG1(3); gpio <= S5PV210_GPG1(6); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_setpull(S5PV210_GPG1(2), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(S5PV210_GPG1(2), S3C_GPIO_SFN(2));
+	}
+}
+
+struct s3c_sdhci_platdata s5pv210_hsmmc1_def_platdata __initdata = {
+	.max_width	= 4,
+	.host_caps	= (MMC_CAP_4_BIT_DATA |
+			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.clocks		= s5pv210_hsmmc_clksrcs,
+	.cfg_gpio	= s5pv210_setup_sdhci1_cfg_gpio,
+	.cfg_card	= s5pv210_setup_sdhci_cfg_card,
+};
+
+#endif
+
+#ifdef CONFIG_S5PV210_SETUP_SDHCI2
+
+static void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
+{
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
+	unsigned int gpio;
+
+	/* Set all the necessary GPG2[0:1] pins to special-function 2 */
+	for (gpio = S5PV210_GPG2(0); gpio < S5PV210_GPG2(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	switch (width) {
+	case 8:
+		/* Data pin GPG3[3:6] to special-function 3 */
+		for (gpio = S5PV210_GPG3(3); gpio <= S5PV210_GPG3(6); gpio++) {
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		}
+	case 4:
+		/* Data pin GPG2[3:6] to special-function 2 */
+		for (gpio = S5PV210_GPG2(3); gpio <= S5PV210_GPG2(6); gpio++) {
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		}
+	default:
+		break;
+	}
+
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		s3c_gpio_setpull(S5PV210_GPG2(2), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgpin(S5PV210_GPG2(2), S3C_GPIO_SFN(2));
+	}
+}
+
+struct s3c_sdhci_platdata s5pv210_hsmmc2_def_platdata __initdata = {
+	.max_width	= 4,
+	.host_caps	= (MMC_CAP_4_BIT_DATA |
+			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.clocks		= s5pv210_hsmmc_clksrcs,
+	.cfg_gpio	= s5pv210_setup_sdhci2_cfg_gpio,
+	.cfg_card	= s5pv210_setup_sdhci_cfg_card,
+};
+
+#endif
+
+#ifdef CONFIG_S5PV210_SETUP_SDHCI3
+
+static void s5pv210_setup_sdhci3_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+
+	/* Set all the necessary GPG3[0:2] pins to special-function 2 */
+	for (gpio = S5PV210_GPG3(0); gpio < S5PV210_GPG3(2); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	/* Data pin GPG3[3:6] to special-function 2 */
+	for (gpio = S5PV210_GPG3(3); gpio <= S5PV210_GPG3(6); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	s3c_gpio_setpull(S5PV210_GPG3(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV210_GPG3(2), S3C_GPIO_SFN(2));
+}
+
+struct s3c_sdhci_platdata s5pv210_hsmmc3_def_platdata __initdata = {
+	.max_width	= 4,
+	.host_caps	= (MMC_CAP_4_BIT_DATA |
+			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.clocks		= s5pv210_hsmmc_clksrcs,
+	.cfg_gpio	= s5pv210_setup_sdhci3_cfg_gpio,
+	.cfg_card	= s5pv210_setup_sdhci_cfg_card,
+};
+
+#endif
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 8f3be02..57c791c 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -160,21 +160,6 @@ config S3C_DEV_HSMMC
 	help
 	  Compile in platform device definitions for HSMMC code
 
-config S3C_DEV_HSMMC1
-	bool
-	help
-	  Compile in platform device definitions for HSMMC channel 1
-
-config S3C_DEV_HSMMC2
-	bool
-	help
-	  Compile in platform device definitions for HSMMC channel 2
-
-config S3C_DEV_HSMMC3
-	bool
-	help
-	  Compile in platform device definitions for HSMMC channel 3
-
 config S3C_DEV_HWMON
 	bool
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index edaa083..b59a6e4 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -36,9 +36,6 @@ obj-y				+= platformdata.o
 obj-$(CONFIG_S3C24XX_DEV_UART)	+= dev-uart-s3c24xx.o
 obj-$(CONFIG_S3C64XX_DEV_UART)	+= dev-uart-s3c64xx.o
 obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
-obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
-obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
-obj-$(CONFIG_S3C_DEV_HSMMC3)	+= dev-hsmmc3.o
 obj-$(CONFIG_S3C_DEV_HWMON)	+= dev-hwmon.o
 obj-y				+= dev-i2c0.o
 obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
diff --git a/arch/arm/plat-samsung/dev-hsmmc.c b/arch/arm/plat-samsung/dev-hsmmc.c
index b0f93f1..ff7452e9 100644
--- a/arch/arm/plat-samsung/dev-hsmmc.c
+++ b/arch/arm/plat-samsung/dev-hsmmc.c
@@ -15,50 +15,19 @@
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
 
-#include <mach/map.h>
 #include <plat/sdhci.h>
 #include <plat/devs.h>
-#include <plat/cpu.h>
+#include <plat/dev-core.h>
 
-#define S3C_SZ_HSMMC	(0x1000)
-
-static struct resource s3c_hsmmc_resource[] = {
-	[0] = {
-		.start = S3C_PA_HSMMC0,
-		.end   = S3C_PA_HSMMC0 + S3C_SZ_HSMMC - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_HSMMC0,
-		.end   = IRQ_HSMMC0,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-static u64 s3c_device_hsmmc_dmamask = 0xffffffffUL;
-
-struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata = {
-	.max_width	= 4,
-	.host_caps	= (MMC_CAP_4_BIT_DATA |
-			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-};
-
-struct platform_device s3c_device_hsmmc0 = {
-	.name		= "s3c-sdhci",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(s3c_hsmmc_resource),
-	.resource	= s3c_hsmmc_resource,
-	.dev		= {
-		.dma_mask		= &s3c_device_hsmmc_dmamask,
-		.coherent_dma_mask	= 0xffffffffUL,
-		.platform_data		= &s3c_hsmmc0_def_platdata,
-	},
-};
-
-void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
+void __init s3c_sdhci_set_platdata(void *src, int id)
 {
-	struct s3c_sdhci_platdata *set = &s3c_hsmmc0_def_platdata;
-
+	struct s3c_sdhci_platdata *pd = src;
+	struct s3c_sdhci_platdata *set;
+	set = s3c_device_get_defplatdata(SAMSUNG_DEVICE_SDHCI, id);
+	if (!set) {
+		printk(KERN_ERR "%s: no default platform data\n", __func__);
+		return;
+	}
 	set->max_width = pd->max_width;
 	set->cd_type = pd->cd_type;
 	set->ext_cd_init = pd->ext_cd_init;
@@ -71,3 +40,12 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
 	if (pd->cfg_card)
 		set->cfg_card = pd->cfg_card;
 }
+
+struct s3c_pdev_template s3c_hsmmc_template __initdata = {
+	.type = SAMSUNG_DEVICE_SDHCI,
+	.resources = s3c_std_resources_4k,
+	.nr_res = 2,
+	.pdata_size = sizeof(struct s3c_sdhci_platdata),
+	.pdata_set = s3c_sdhci_set_platdata,
+	.dma = &samsung_std_dma_mask,
+};
diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
deleted file mode 100644
index 1504fd8..0000000
--- a/arch/arm/plat-samsung/dev-hsmmc1.c
+++ /dev/null
@@ -1,73 +0,0 @@
-/* linux/arch/arm/plat-s3c/dev-hsmmc1.c
- *
- * Copyright (c) 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C series device definition for hsmmc device 1
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/mmc/host.h>
-
-#include <mach/map.h>
-#include <plat/sdhci.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-#define S3C_SZ_HSMMC	(0x1000)
-
-static struct resource s3c_hsmmc1_resource[] = {
-	[0] = {
-		.start = S3C_PA_HSMMC1,
-		.end   = S3C_PA_HSMMC1 + S3C_SZ_HSMMC - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_HSMMC1,
-		.end   = IRQ_HSMMC1,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-static u64 s3c_device_hsmmc1_dmamask = 0xffffffffUL;
-
-struct s3c_sdhci_platdata s3c_hsmmc1_def_platdata = {
-	.max_width	= 4,
-	.host_caps	= (MMC_CAP_4_BIT_DATA |
-			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-};
-
-struct platform_device s3c_device_hsmmc1 = {
-	.name		= "s3c-sdhci",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(s3c_hsmmc1_resource),
-	.resource	= s3c_hsmmc1_resource,
-	.dev		= {
-		.dma_mask		= &s3c_device_hsmmc1_dmamask,
-		.coherent_dma_mask	= 0xffffffffUL,
-		.platform_data		= &s3c_hsmmc1_def_platdata,
-	},
-};
-
-void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
-{
-	struct s3c_sdhci_platdata *set = &s3c_hsmmc1_def_platdata;
-
-	set->max_width = pd->max_width;
-	set->cd_type = pd->cd_type;
-	set->ext_cd_init = pd->ext_cd_init;
-	set->ext_cd_cleanup = pd->ext_cd_cleanup;
-	set->ext_cd_gpio = pd->ext_cd_gpio;
-	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
-
-	if (pd->cfg_gpio)
-		set->cfg_gpio = pd->cfg_gpio;
-	if (pd->cfg_card)
-		set->cfg_card = pd->cfg_card;
-}
diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
deleted file mode 100644
index b28ef17..0000000
--- a/arch/arm/plat-samsung/dev-hsmmc2.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/* linux/arch/arm/plat-s3c/dev-hsmmc2.c
- *
- * Copyright (c) 2009 Samsung Electronics
- * Copyright (c) 2009 Maurus Cuelenaere
- *
- * Based on arch/arm/plat-s3c/dev-hsmmc1.c
- * original file Copyright (c) 2008 Simtec Electronics
- *
- * S3C series device definition for hsmmc device 2
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/mmc/host.h>
-
-#include <mach/map.h>
-#include <plat/sdhci.h>
-#include <plat/devs.h>
-
-#define S3C_SZ_HSMMC	(0x1000)
-
-static struct resource s3c_hsmmc2_resource[] = {
-	[0] = {
-		.start = S3C_PA_HSMMC2,
-		.end   = S3C_PA_HSMMC2 + S3C_SZ_HSMMC - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_HSMMC2,
-		.end   = IRQ_HSMMC2,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-static u64 s3c_device_hsmmc2_dmamask = 0xffffffffUL;
-
-struct s3c_sdhci_platdata s3c_hsmmc2_def_platdata = {
-	.max_width	= 4,
-	.host_caps	= (MMC_CAP_4_BIT_DATA |
-			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-};
-
-struct platform_device s3c_device_hsmmc2 = {
-	.name		= "s3c-sdhci",
-	.id		= 2,
-	.num_resources	= ARRAY_SIZE(s3c_hsmmc2_resource),
-	.resource	= s3c_hsmmc2_resource,
-	.dev		= {
-		.dma_mask		= &s3c_device_hsmmc2_dmamask,
-		.coherent_dma_mask	= 0xffffffffUL,
-		.platform_data		= &s3c_hsmmc2_def_platdata,
-	},
-};
-
-void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
-{
-	struct s3c_sdhci_platdata *set = &s3c_hsmmc2_def_platdata;
-
-	set->max_width = pd->max_width;
-	set->cd_type = pd->cd_type;
-	set->ext_cd_init = pd->ext_cd_init;
-	set->ext_cd_cleanup = pd->ext_cd_cleanup;
-	set->ext_cd_gpio = pd->ext_cd_gpio;
-	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
-
-	if (pd->cfg_gpio)
-		set->cfg_gpio = pd->cfg_gpio;
-	if (pd->cfg_card)
-		set->cfg_card = pd->cfg_card;
-}
diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c b/arch/arm/plat-samsung/dev-hsmmc3.c
deleted file mode 100644
index 85aaf0f..0000000
--- a/arch/arm/plat-samsung/dev-hsmmc3.c
+++ /dev/null
@@ -1,77 +0,0 @@
-/* linux/arch/arm/plat-samsung/dev-hsmmc3.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Copyright (c) 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * Based on arch/arm/plat-samsung/dev-hsmmc1.c
- *
- * Samsung device definition for hsmmc device 3
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/mmc/host.h>
-
-#include <mach/map.h>
-#include <plat/sdhci.h>
-#include <plat/devs.h>
-
-#define S3C_SZ_HSMMC	(0x1000)
-
-static struct resource s3c_hsmmc3_resource[] = {
-	[0] = {
-		.start	= S3C_PA_HSMMC3,
-		.end	= S3C_PA_HSMMC3 + S3C_SZ_HSMMC - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_MMC3,
-		.end	= IRQ_MMC3,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static u64 s3c_device_hsmmc3_dmamask = 0xffffffffUL;
-
-struct s3c_sdhci_platdata s3c_hsmmc3_def_platdata = {
-	.max_width	= 4,
-	.host_caps	= (MMC_CAP_4_BIT_DATA |
-			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
-};
-
-struct platform_device s3c_device_hsmmc3 = {
-	.name		= "s3c-sdhci",
-	.id		= 3,
-	.num_resources	= ARRAY_SIZE(s3c_hsmmc3_resource),
-	.resource	= s3c_hsmmc3_resource,
-	.dev		= {
-		.dma_mask		= &s3c_device_hsmmc3_dmamask,
-		.coherent_dma_mask	= 0xffffffffUL,
-		.platform_data		= &s3c_hsmmc3_def_platdata,
-	},
-};
-
-void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata *pd)
-{
-	struct s3c_sdhci_platdata *set = &s3c_hsmmc3_def_platdata;
-
-	set->max_width = pd->max_width;
-	set->cd_type = pd->cd_type;
-	set->ext_cd_init = pd->ext_cd_init;
-	set->ext_cd_cleanup = pd->ext_cd_cleanup;
-	set->ext_cd_gpio = pd->ext_cd_gpio;
-	set->ext_cd_gpio_invert = pd->ext_cd_gpio_invert;
-
-	if (pd->cfg_gpio)
-		set->cfg_gpio = pd->cfg_gpio;
-	if (pd->cfg_card)
-		set->cfg_card = pd->cfg_card;
-}
diff --git a/arch/arm/plat-samsung/dev_templates.c b/arch/arm/plat-samsung/dev_templates.c
index dcf8c0e..922c6e9 100644
--- a/arch/arm/plat-samsung/dev_templates.c
+++ b/arch/arm/plat-samsung/dev_templates.c
@@ -22,6 +22,7 @@
 #include <plat/cpu.h>
 
 #include <plat/uart.h>
+#include <plat/sdhci.h>
 
 #define TEMPLATE_ENTRY(_type, _res) \
 {	.type = (_type), \
@@ -43,6 +44,7 @@ struct resource s3c_std_resources_4k[] __initdata = {
 static struct s3c_pdev_template *templates[] __initdata = {
 	s3c24xx_uart_template_p,
 	s3c64xx_uart_template_p,
+	s3c_hsmmc_template_p,
 };
 
 u64 samsung_std_dma_mask = 0xffffffffUL;
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 30844c2..280f291 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -106,10 +106,6 @@ extern void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
 extern void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 extern void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
-extern void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
-extern void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
-extern void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
-extern void s5pv210_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
 
 /* S3C64XX SDHCI setup */
 
@@ -234,58 +230,54 @@ static inline void s5pc100_default_sdhci2(void) { }
 
 #endif /* CONFIG_S5PC100_SETUP_SDHCI */
 
-/* S5PV210 SDHCI setup */
-
-#ifdef CONFIG_S5PV210_SETUP_SDHCI
-extern char *s5pv210_hsmmc_clksrcs[4];
-
-extern void s5pv210_setup_sdhci_cfg_card(struct platform_device *dev,
-					   void __iomem *r,
-					   struct mmc_ios *ios,
-					   struct mmc_card *card);
-
-static inline void s5pv210_default_sdhci0(void)
-{
-#ifdef CONFIG_S3C_DEV_HSMMC
-	s3c_hsmmc0_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
-	s3c_hsmmc0_def_platdata.cfg_gpio = s5pv210_setup_sdhci0_cfg_gpio;
-	s3c_hsmmc0_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
-#endif
-}
-
-static inline void s5pv210_default_sdhci1(void)
-{
-#ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
-	s3c_hsmmc1_def_platdata.cfg_gpio = s5pv210_setup_sdhci1_cfg_gpio;
-	s3c_hsmmc1_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
-#endif
-}
-
-static inline void s5pv210_default_sdhci2(void)
-{
-#ifdef CONFIG_S3C_DEV_HSMMC2
-	s3c_hsmmc2_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
-	s3c_hsmmc2_def_platdata.cfg_gpio = s5pv210_setup_sdhci2_cfg_gpio;
-	s3c_hsmmc2_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
-#endif
-}
-
-static inline void s5pv210_default_sdhci3(void)
-{
-#ifdef CONFIG_S3C_DEV_HSMMC3
-	s3c_hsmmc3_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
-	s3c_hsmmc3_def_platdata.cfg_gpio = s5pv210_setup_sdhci3_cfg_gpio;
-	s3c_hsmmc3_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
-#endif
-}
-
-#else
-static inline void s5pv210_default_sdhci0(void) { }
-static inline void s5pv210_default_sdhci1(void) { }
-static inline void s5pv210_default_sdhci2(void) { }
-static inline void s5pv210_default_sdhci3(void) { }
-
-#endif /* CONFIG_S5PV210_SETUP_SDHCI */
+/**
+ * s3c_sdhci_set_platdata - Set platform data for S3C SDHCI device.
+ * @pd: Platform data to register to device.
+ *
+ * Register the given platform data for use withe S3C SDHCI device.
+ * The call will copy the platform data, so the board definitions can
+ * make the structure itself __initdata.
+ */
+extern void s3c_sdhci_set_platdata(void *pd, int id);
+
+#ifdef CONFIG_S3C_DEV_HSMMC
+extern struct s3c_pdev_template s3c_hsmmc_template;
+#define s3c_hsmmc_template_p (&s3c_hsmmc_template)
+#else
+#define s3c_hsmmc_template_p NULL
+#endif
+
+/* Default platform data, exported so that per-cpu initialisation can
+ * set the correct one when there are more than one cpu type selected.
+*/
+
+extern struct s3c_sdhci_platdata s5pv210_hsmmc0_def_platdata;
+extern struct s3c_sdhci_platdata s5pv210_hsmmc1_def_platdata;
+extern struct s3c_sdhci_platdata s5pv210_hsmmc2_def_platdata;
+extern struct s3c_sdhci_platdata s5pv210_hsmmc3_def_platdata;
+
+#ifdef CONFIG_S5PV210_SETUP_SDHCI0
+#define s5pv210_hsmmc0_def_platdata_p (&s5pv210_hsmmc0_def_platdata)
+#else
+#define s5pv210_hsmmc0_def_platdata_p NULL
+#endif
+
+#ifdef CONFIG_S5PV210_SETUP_SDHCI1
+#define s5pv210_hsmmc1_def_platdata_p (&s5pv210_hsmmc1_def_platdata)
+#else
+#define s5pv210_hsmmc1_def_platdata_p NULL
+#endif
+
+#ifdef CONFIG_S5PV210_SETUP_SDHCI2
+#define s5pv210_hsmmc2_def_platdata_p (&s5pv210_hsmmc2_def_platdata)
+#else
+#define s5pv210_hsmmc2_def_platdata_p NULL
+#endif
+
+#ifdef CONFIG_S5PV210_SETUP_SDHCI3
+#define s5pv210_hsmmc3_def_platdata_p (&s5pv210_hsmmc3_def_platdata)
+#else
+#define s5pv210_hsmmc3_def_platdata_p NULL
+#endif
 
 #endif /* __PLAT_S3C_SDHCI_H */
-- 
1.7.1.569.g6f426
