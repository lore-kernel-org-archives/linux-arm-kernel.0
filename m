From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 14 Dec 2011 10:16:00 -0500
Subject: [PATCH V3 3/6] ARM: S5PC100: Modified files for SPI consolidation work
In-Reply-To: <1323875763-21197-1-git-send-email-padma.v@samsung.com>
References: <1323875763-21197-1-git-send-email-padma.v@samsung.com>
Message-ID: <1323875763-21197-4-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As SPI platform devices are consolidated to plat-samsung, some
corresponding changes are required in the respective machine folder.
Added SPI Setup file for GPIO configurations and platform data
initialization.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig                    |    5 ++
 arch/arm/mach-s5pc100/Makefile                   |    1 +
 arch/arm/mach-s5pc100/include/mach/map.h         |    3 +
 arch/arm/mach-s5pc100/setup-spi.c                |   65 ++++++++++++++++++++++
 arch/arm/plat-samsung/devs.c                     |    3 +
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    2 +
 6 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pc100/setup-spi.c

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index e538a4c..75a26ea 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -45,6 +45,11 @@ config S5PC100_SETUP_SDHCI_GPIO
 	help
 	  Common setup code for SDHCI gpio.
 
+config S5PC100_SETUP_SPI
+	bool
+	help
+	  Common setup code for SPI GPIO configurations.
+
 config MACH_SMDKC100
 	bool "SMDKC100"
 	select CPU_S5PC100
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index 238a836..291e246 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_S5PC100_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5PC100_SETUP_IDE)		+= setup-ide.o
 obj-$(CONFIG_S5PC100_SETUP_KEYPAD)	+= setup-keypad.o
 obj-$(CONFIG_S5PC100_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
+obj-$(CONFIG_S5PC100_SETUP_SPI)	+= setup-spi.o
 
 # device support
 obj-y				+= dev-audio.o
diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
index ccbe6b7..54bc4f8 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -100,6 +100,9 @@
 #define S3C_PA_USB_HSOTG		S5PC100_PA_USB_HSOTG
 #define S3C_PA_USB_HSPHY		S5PC100_PA_USB_HSPHY
 #define S3C_PA_WDT			S5PC100_PA_WATCHDOG
+#define S3C_PA_SPI0			S5PC100_PA_SPI0
+#define S3C_PA_SPI1			S5PC100_PA_SPI1
+#define S3C_PA_SPI2			S5PC100_PA_SPI2
 
 #define S5P_PA_CHIPID			S5PC100_PA_CHIPID
 #define S5P_PA_FIMC0			S5PC100_PA_FIMC0
diff --git a/arch/arm/mach-s5pc100/setup-spi.c b/arch/arm/mach-s5pc100/setup-spi.c
new file mode 100644
index 0000000..431a6f7
--- /dev/null
+++ b/arch/arm/mach-s5pc100/setup-spi.c
@@ -0,0 +1,65 @@
+/* linux/arch/arm/mach-s5pc100/setup-spi.c
+ *
+ * Copyright (C) 2011 Samsung Electronics Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+
+#include <plat/gpio-cfg.h>
+#include <plat/s3c64xx-spi.h>
+
+#ifdef CONFIG_S3C64XX_DEV_SPI0
+struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 13,
+	.high_speed	= 1,
+	.tx_st_done	= 21,
+};
+
+int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgall_range(S5PC100_GPB(0), 3,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_S3C64XX_DEV_SPI1
+struct s3c64xx_spi_info s3c64xx_spi1_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 13,
+	.high_speed	= 1,
+	.tx_st_done	= 21,
+};
+
+int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgall_range(S5PC100_GPB(4), 3,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_S3C64XX_DEV_SPI2
+struct s3c64xx_spi_info s3c64xx_spi2_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 13,
+	.high_speed	= 1,
+	.tx_st_done	= 21,
+};
+
+int s3c64xx_spi2_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PC100_GPG3(0), S3C_GPIO_SFN(3));
+	s3c_gpio_setpull(S5PC100_GPG3(0), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5PC100_GPB(2), 2,
+				S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 2652dd9..7aa3bec 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1582,6 +1582,9 @@ void __init s3c64xx_spi2_set_platdata(struct s3c64xx_spi_info *pd,
 
 	pd->num_cs = num_cs;
 	pd->src_clk_nr = src_clk_nr;
+	if (!pd->cfg_gpio)
+		pd->cfg_gpio = s3c64xx_spi2_cfg_gpio;
+
 	s3c_set_platdata(pd, sizeof(*pd), &s3c64xx_device_spi2);
 }
 #endif /* CONFIG_S3C64XX_DEV_SPI2 */
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index d3e2209..aea68b6 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -75,7 +75,9 @@ extern void s3c64xx_spi2_set_platdata(struct s3c64xx_spi_info *pd,
 /* defined by architecture to configure gpio */
 extern int s3c64xx_spi0_cfg_gpio(struct platform_device *dev);
 extern int s3c64xx_spi1_cfg_gpio(struct platform_device *dev);
+extern int s3c64xx_spi2_cfg_gpio(struct platform_device *dev);
 
 extern struct s3c64xx_spi_info s3c64xx_spi0_pdata;
 extern struct s3c64xx_spi_info s3c64xx_spi1_pdata;
+extern struct s3c64xx_spi_info s3c64xx_spi2_pdata;
 #endif /* __S3C64XX_PLAT_SPI_H */
-- 
1.7.0.4
