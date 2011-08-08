From: rajeshwari.s@samsung.com (Rajeshwari Shinde)
Date: Mon, 08 Aug 2011 14:17:55 +0530
Subject: RFC[PATCH 5/6] ARM: S5P64X0: Enable SDHCI support
In-Reply-To: <1312793277-18689-1-git-send-email-rajeshwari.s@samsung.com>
References: <1312793277-18689-1-git-send-email-rajeshwari.s@samsung.com>
Message-ID: <1312793277-18689-6-git-send-email-rajeshwari.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch initializes default sdhci devices and platform
data for SMDK6440 and SMDK6450.

Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
---
 arch/arm/mach-s5p64x0/Makefile                     |    2 +-
 .../include/mach/s5p64x0-common-sdhci.h            |   15 +++++++++
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |   10 ++++++
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |   10 ++++++
 arch/arm/mach-s5p64x0/s5p64x0-common-sdhci.c       |   34 ++++++++++++++++++++
 5 files changed, 70 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/s5p64x0-common-sdhci.h
 create mode 100644 arch/arm/mach-s5p64x0/s5p64x0-common-sdhci.c

diff --git a/arch/arm/mach-s5p64x0/Makefile b/arch/arm/mach-s5p64x0/Makefile
index 6642448..e8dd7c6 100644
--- a/arch/arm/mach-s5p64x0/Makefile
+++ b/arch/arm/mach-s5p64x0/Makefile
@@ -28,5 +28,5 @@ obj-y				+= dev-audio.o
 obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 
 obj-$(CONFIG_S5P64X0_SETUP_I2C1)	+= setup-i2c1.o
-obj-$(CONFIG_S5P64X0_SETUP_SDHCI)	+= setup-sdhci.o
+obj-$(CONFIG_S5P64X0_SETUP_SDHCI)	+= setup-sdhci.o s5p64x0-common-sdhci.o
 obj-$(CONFIG_S5P64X0_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
diff --git a/arch/arm/mach-s5p64x0/include/mach/s5p64x0-common-sdhci.h b/arch/arm/mach-s5p64x0/include/mach/s5p64x0-common-sdhci.h
new file mode 100644
index 0000000..a3381f0
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/include/mach/s5p64x0-common-sdhci.h
@@ -0,0 +1,15 @@
+/* linux/arch/arm/mach-s5p64x0/include/mach/s5p64x0-common-sdhci.h
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <plat/sdhci.h>
+
+extern struct s3c_sdhci_platdata smdk64x0_hsmmc0_pdata;
+extern struct s3c_sdhci_platdata smdk64x0_hsmmc1_pdata;
+extern struct s3c_sdhci_platdata smdk64x0_hsmmc2_pdata;
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 346f8df..065977f 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/pwm_backlight.h>
+#include <linux/mmc/host.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -34,6 +35,7 @@
 #include <mach/regs-clock.h>
 #include <mach/i2c.h>
 #include <mach/regs-gpio.h>
+#include <mach/s5p64x0-common-sdhci.h>
 
 #include <plat/regs-serial.h>
 #include <plat/gpio-cfg.h>
@@ -47,6 +49,7 @@
 #include <plat/ts.h>
 #include <plat/s5p-time.h>
 #include <plat/backlight.h>
+#include <plat/sdhci.h>
 
 #define SMDK6440_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -101,6 +104,9 @@ static struct platform_device *smdk6440_devices[] __initdata = {
 	&s3c_device_wdt,
 	&samsung_asoc_dma,
 	&s5p6440_device_iis,
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
 };
 
 static struct s3c2410_platform_i2c s5p6440_i2c0_data __initdata = {
@@ -166,6 +172,10 @@ static void __init smdk6440_machine_init(void)
 
 	samsung_bl_set(&smdk6440_bl_gpio_info, &smdk6440_bl_data);
 
+	s3c_sdhci0_set_platdata(&smdk64x0_hsmmc0_pdata);
+	s3c_sdhci1_set_platdata(&smdk64x0_hsmmc1_pdata);
+	s3c_sdhci2_set_platdata(&smdk64x0_hsmmc2_pdata);
+
 	platform_add_devices(smdk6440_devices, ARRAY_SIZE(smdk6440_devices));
 }
 
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 33f2adf..9e6fcef 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/pwm_backlight.h>
+#include <linux/mmc/host.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -34,6 +35,7 @@
 #include <mach/regs-clock.h>
 #include <mach/i2c.h>
 #include <mach/regs-gpio.h>
+#include <mach/s5p64x0-common-sdhci.h>
 
 #include <plat/regs-serial.h>
 #include <plat/gpio-cfg.h>
@@ -47,6 +49,7 @@
 #include <plat/ts.h>
 #include <plat/s5p-time.h>
 #include <plat/backlight.h>
+#include <plat/sdhci.h>
 
 #define SMDK6450_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -119,6 +122,9 @@ static struct platform_device *smdk6450_devices[] __initdata = {
 	&s3c_device_wdt,
 	&samsung_asoc_dma,
 	&s5p6450_device_iis0,
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
 	/* s5p6450_device_spi0 will be added */
 };
 
@@ -185,6 +191,10 @@ static void __init smdk6450_machine_init(void)
 
 	samsung_bl_set(&smdk6450_bl_gpio_info, &smdk6450_bl_data);
 
+	s3c_sdhci0_set_platdata(&smdk64x0_hsmmc0_pdata);
+	s3c_sdhci1_set_platdata(&smdk64x0_hsmmc1_pdata);
+	s3c_sdhci2_set_platdata(&smdk64x0_hsmmc2_pdata);
+
 	platform_add_devices(smdk6450_devices, ARRAY_SIZE(smdk6450_devices));
 }
 
diff --git a/arch/arm/mach-s5p64x0/s5p64x0-common-sdhci.c b/arch/arm/mach-s5p64x0/s5p64x0-common-sdhci.c
new file mode 100644
index 0000000..03d89f6
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/s5p64x0-common-sdhci.c
@@ -0,0 +1,34 @@
+/* linux/arch/arm/mach-s5p64x0/s5p64x0-common-sdhci.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/init.h>
+#include <linux/mmc/host.h>
+#include <linux/types.h>
+
+#include <mach/s5p64x0-common-sdhci.h>
+
+struct s3c_sdhci_platdata smdk64x0_hsmmc0_pdata __initdata = {
+	.cd_type        = S3C_SDHCI_CD_NONE,
+	.clk_type       = S3C_SDHCI_CLK_DIV_EXTERNAL,
+};
+
+struct s3c_sdhci_platdata smdk64x0_hsmmc1_pdata __initdata = {
+	.cd_type        = S3C_SDHCI_CD_NONE,
+#if defined(CONFIG_S5P64X0_SD_CH1_8BIT)
+	.max_width      = 8,
+	.host_caps      = MMC_CAP_8_BIT_DATA,
+#endif
+	.clk_type       = S3C_SDHCI_CLK_DIV_EXTERNAL,
+};
+
+struct s3c_sdhci_platdata smdk64x0_hsmmc2_pdata __initdata = {
+	.cd_type        = S3C_SDHCI_CD_NONE,
+	.clk_type       = S3C_SDHCI_CLK_DIV_EXTERNAL,
+};
-- 
1.7.4.4
