From: rajeshwari.s@samsung.com (Rajeshwari Shinde)
Date: Fri, 04 Nov 2011 19:26:58 +0530
Subject: [PATCH 1/3] ARM: S5P64X0: Add HSMMC setup for host Controller
In-Reply-To: <1320415020-7439-1-git-send-email-rajeshwari.s@samsung.com>
References: <1320415020-7439-1-git-send-email-rajeshwari.s@samsung.com>
Message-ID: <1320415020-7439-2-git-send-email-rajeshwari.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds support for HSMMC for S5P64X0 platform, performs
setup for host controller and related GPIO.

Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
---
 arch/arm/mach-s5p64x0/Kconfig              |   24 +++++++
 arch/arm/mach-s5p64x0/Makefile             |    1 +
 arch/arm/mach-s5p64x0/cpu.c                |    9 +++
 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c   |  104 ++++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/sdhci.h |   42 +++++++++++
 5 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c

diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 4de625a..4d6154e 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -41,6 +41,11 @@ config S5P64X0_SETUP_SPI
        help
          Common setup code for SPI GPIO configurations
 
+config S5P64X0_SETUP_SDHCI_GPIO
+	bool
+	help
+	  Common setup code for SDHCI gpio.
+
 # machine support
 
 config MACH_SMDK6440
@@ -50,12 +55,16 @@ config MACH_SMDK6440
 	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
+	select S3C_DEV_HSMMC2
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
 	select S5P64X0_SETUP_FB_24BPP
 	select S5P64X0_SETUP_I2C1
+	select S5P64X0_SETUP_SDHCI_GPIO
 	help
 	  Machine support for the Samsung SMDK6440
 
@@ -66,13 +75,28 @@ config MACH_SMDK6450
 	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
+	select S3C_DEV_HSMMC2
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
 	select S5P64X0_SETUP_FB_24BPP
 	select S5P64X0_SETUP_I2C1
+	select S5P64X0_SETUP_SDHCI_GPIO
 	help
 	  Machine support for the Samsung SMDK6450
 
+menu "Use 8-bit SDHCI bus width"
+
+config S5P64X0_SD_CH1_8BIT
+	bool "SDHCI Channel 1 (Slot 1)"
+	depends on MACH_SMDK6450 || MACH_SMDK6440
+	help
+	  Support SDHCI Channel 1 8-bit bus.
+	  If selected, Channel 2 is disabled.
+
+endmenu
+
 endif
diff --git a/arch/arm/mach-s5p64x0/Makefile b/arch/arm/mach-s5p64x0/Makefile
index 5f473de..084f436 100644
--- a/arch/arm/mach-s5p64x0/Makefile
+++ b/arch/arm/mach-s5p64x0/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 obj-$(CONFIG_S5P64X0_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5P64X0_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 obj-$(CONFIG_S5P64X0_SETUP_SPI)		+= setup-spi.o
+obj-$(CONFIG_S5P64X0_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
diff --git a/arch/arm/mach-s5p64x0/cpu.c b/arch/arm/mach-s5p64x0/cpu.c
index ecab40c..f6e24f3 100644
--- a/arch/arm/mach-s5p64x0/cpu.c
+++ b/arch/arm/mach-s5p64x0/cpu.c
@@ -40,6 +40,7 @@
 #include <plat/s5p6450.h>
 #include <plat/adc-core.h>
 #include <plat/fb-core.h>
+#include <plat/sdhci.h>
 
 /* Initial IO mappings */
 
@@ -112,6 +113,10 @@ void __init s5p6440_map_io(void)
 	s3c_adc_setname("s3c64xx-adc");
 	s3c_fb_setname("s5p64x0-fb");
 
+	s5p64x0_default_sdhci0();
+	s5p64x0_default_sdhci1();
+	s5p6440_default_sdhci2();
+
 	iotable_init(s5p64x0_iodesc, ARRAY_SIZE(s5p64x0_iodesc));
 	iotable_init(s5p6440_iodesc, ARRAY_SIZE(s5p6440_iodesc));
 	init_consistent_dma_size(SZ_8M);
@@ -123,6 +128,10 @@ void __init s5p6450_map_io(void)
 	s3c_adc_setname("s3c64xx-adc");
 	s3c_fb_setname("s5p64x0-fb");
 
+	s5p64x0_default_sdhci0();
+	s5p64x0_default_sdhci1();
+	s5p6450_default_sdhci2();
+
 	iotable_init(s5p64x0_iodesc, ARRAY_SIZE(s5p64x0_iodesc));
 	iotable_init(s5p6450_iodesc, ARRAY_SIZE(s5p6450_iodesc));
 	init_consistent_dma_size(SZ_8M);
diff --git a/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c b/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
new file mode 100644
index 0000000..8410af0
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
@@ -0,0 +1,104 @@
+/* linux/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P64X0 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+
+#include <mach/regs-gpio.h>
+#include <mach/regs-clock.h>
+
+#include <plat/gpio-cfg.h>
+#include <plat/sdhci.h>
+#include <plat/cpu.h>
+
+void s5p64x0_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
+{
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
+
+	/* Set all the necessary GPG pins to special-function 2 */
+	if (soc_is_s5p6450())
+		s3c_gpio_cfgrange_nopull(S5P6450_GPG(0), 2 + width,
+					 S3C_GPIO_SFN(2));
+	else
+		s3c_gpio_cfgrange_nopull(S5P6440_GPG(0), 2 + width,
+					 S3C_GPIO_SFN(2));
+
+	/* Set GPG[6] pin to special-function 2 - MMC0 CDn */
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		if (soc_is_s5p6450()) {
+			s3c_gpio_setpull(S5P6450_GPG(6), S3C_GPIO_PULL_UP);
+			s3c_gpio_cfgpin(S5P6450_GPG(6), S3C_GPIO_SFN(2));
+		} else {
+			s3c_gpio_setpull(S5P6440_GPG(6), S3C_GPIO_PULL_UP);
+			s3c_gpio_cfgpin(S5P6440_GPG(6), S3C_GPIO_SFN(2));
+		}
+	}
+}
+
+void s5p64x0_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
+{
+	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
+
+	/* Set GPH[0:1] pins to special-function 2 - CLK and CMD */
+	if (soc_is_s5p6450())
+		s3c_gpio_cfgrange_nopull(S5P6450_GPH(0), 2, S3C_GPIO_SFN(2));
+	else
+		s3c_gpio_cfgrange_nopull(S5P6440_GPH(0), 2 , S3C_GPIO_SFN(2));
+
+	switch (width) {
+	case 8:
+		/* Set data pins GPH[6:9] special-function 2 */
+		if (soc_is_s5p6450())
+			s3c_gpio_cfgrange_nopull(S5P6450_GPH(6), 4,
+						 S3C_GPIO_SFN(2));
+		else
+			s3c_gpio_cfgrange_nopull(S5P6440_GPH(6), 4,
+						 S3C_GPIO_SFN(2));
+	case 4:
+		/* set data pins GPH[2:5] special-function 2 */
+		if (soc_is_s5p6450())
+			s3c_gpio_cfgrange_nopull(S5P6450_GPH(2), 4,
+						 S3C_GPIO_SFN(2));
+		else
+			s3c_gpio_cfgrange_nopull(S5P6440_GPH(2), 4,
+						 S3C_GPIO_SFN(2));
+	default:
+		break;
+	}
+
+	/* Set GPG[6] pin to special-funtion 3 : MMC1 CDn */
+	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
+		if (soc_is_s5p6450()) {
+			s3c_gpio_setpull(S5P6450_GPG(6), S3C_GPIO_PULL_UP);
+			s3c_gpio_cfgpin(S5P6450_GPG(6), S3C_GPIO_SFN(3));
+		} else {
+			s3c_gpio_setpull(S5P6440_GPG(6), S3C_GPIO_PULL_UP);
+			s3c_gpio_cfgpin(S5P6440_GPG(6), S3C_GPIO_SFN(3));
+		}
+	}
+}
+
+void s5p6440_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
+{
+	/* Set GPC[4:5] pins to special-function 3 - CLK and CMD */
+	s3c_gpio_cfgrange_nopull(S5P6440_GPC(4), 2, S3C_GPIO_SFN(3));
+
+	/* Set data pins GPH[6:9] pins to special-function 3 */
+	s3c_gpio_cfgrange_nopull(S5P6440_GPH(6), 4, S3C_GPIO_SFN(3));
+}
+
+void s5p6450_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
+{
+	/* Set all the necessary GPG pins to special-function 3 */
+	s3c_gpio_cfgrange_nopull(S5P6450_GPG(7), 2 + width, S3C_GPIO_SFN(3));
+}
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index ae23555..b43999c 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -118,6 +118,10 @@ extern void exynos4_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void exynos4_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
 extern void exynos4_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 extern void exynos4_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
+extern void s5p64x0_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
+extern void s5p64x0_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
+extern void s5p6440_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
+extern void s5p6450_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 
 /* S3C2416 SDHCI setup */
 
@@ -329,4 +333,42 @@ static inline void s3c_sdhci_setname(int id, char *name)
 #endif
 	}
 }
+
+/* S5P64X0 SDHCI setup */
+#ifdef CONFIG_S5P64X0_SETUP_SDHCI
+static inline void s5p64x0_default_sdhci0(void)
+{
+#ifdef CONFIG_S3C_DEV_HSMMC
+	s3c_hsmmc0_def_platdata.cfg_gpio = s5p64x0_setup_sdhci0_cfg_gpio;
+#endif /* CONFIG_S3C_DEV_HSMMC */
+}
+
+static inline void s5p64x0_default_sdhci1(void)
+{
+#ifdef CONFIG_S3C_DEV_HSMMC1
+	s3c_hsmmc1_def_platdata.cfg_gpio = s5p64x0_setup_sdhci1_cfg_gpio;
+#endif /* CONFIG_S3C_DEV_HSMMC1 */
+}
+
+static inline void s5p6440_default_sdhci2(void)
+{
+#ifdef CONFIG_S3C_DEV_HSMMC2
+	s3c_hsmmc2_def_platdata.cfg_gpio = s5p6440_setup_sdhci2_cfg_gpio;
+#endif /* CONFIG_S3C_DEV_HSMMC2 */
+}
+
+static inline void s5p6450_default_sdhci2(void)
+{
+#ifdef CONFIG_S3C_DEV_HSMMC2
+	s3c_hsmmc2_def_platdata.cfg_gpio = s5p6450_setup_sdhci2_cfg_gpio;
+#endif /* CONFIG_S3C_DEV_HSMMC2 */
+}
+
+#else
+static inline void s5p64x0_default_sdhci0(void) { }
+static inline void s5p64x0_default_sdhci1(void) { }
+static inline void s5p6440_default_sdhci2(void) { }
+static inline void s5p6450_default_sdhci2(void) { }
+#endif /* CONFIG_S5P64X0_SETUP_SDHCI */
+
 #endif /* __PLAT_S3C_SDHCI_H */
-- 
1.7.4.4
