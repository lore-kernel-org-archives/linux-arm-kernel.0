From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 18 Nov 2011 09:35:46 -0500
Subject: [PATCH V2 2/6] ARM: S3C64XX: Modified files for SPI consolidation work
In-Reply-To: <1321626950-19859-1-git-send-email-padma.v@samsung.com>
References: <1321626950-19859-1-git-send-email-padma.v@samsung.com>
Message-ID: <1321626950-19859-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As SPI platform devices are consolidated to plat-samsung, some
corresponding changes are required in the respective machine folder.
Setup files are added for SPI GPIO configurations and platform data
initialization.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s3c64xx/Kconfig                    |    5 ++
 arch/arm/mach-s3c64xx/Makefile                   |    1 +
 arch/arm/mach-s3c64xx/include/mach/map.h         |    2 +
 arch/arm/mach-s3c64xx/setup-spi.c                |   47 ++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    7 +++
 5 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/setup-spi.c

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 4d8c489..dea62bf 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -77,6 +77,11 @@ config S3C64XX_SETUP_SDHCI_GPIO
 	help
 	  Common setup code for S3C64XX SDHCI GPIO configurations
 
+config S3C64XX_SETUP_SPI
+	bool
+	help
+	 Common setup code for SPI GPIO configurations
+
 # S36400 Macchine support
 
 config MACH_SMDK6400
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index d1d0f09..d7d9bb5 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_S3C64XX_SETUP_IDE) += setup-ide.o
 obj-$(CONFIG_S3C64XX_SETUP_KEYPAD) += setup-keypad.o
 obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
+obj-$(CONFIG_S3C64XX_SETUP_SPI) += setup-spi.o
 
 # PM
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h b/arch/arm/mach-s3c64xx/include/mach/map.h
index 23a1d71..8e2097b 100644
--- a/arch/arm/mach-s3c64xx/include/mach/map.h
+++ b/arch/arm/mach-s3c64xx/include/mach/map.h
@@ -115,6 +115,8 @@
 #define S3C_PA_USB_HSOTG	S3C64XX_PA_USB_HSOTG
 #define S3C_PA_RTC		S3C64XX_PA_RTC
 #define S3C_PA_WDT		S3C64XX_PA_WATCHDOG
+#define S3C_PA_SPI0		S3C64XX_PA_SPI0
+#define S3C_PA_SPI1		S3C64XX_PA_SPI1
 
 #define SAMSUNG_PA_ADC		S3C64XX_PA_ADC
 #define SAMSUNG_PA_CFCON	S3C64XX_PA_CFCON
diff --git a/arch/arm/mach-s3c64xx/setup-spi.c b/arch/arm/mach-s3c64xx/setup-spi.c
new file mode 100644
index 0000000..c802375
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/setup-spi.c
@@ -0,0 +1,47 @@
+/* linux/arch/arm/mach-s3c64xx/setup-spi.c
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
+	.tx_st_done	= 21,
+	.cntrlr_no	= 0,
+};
+
+int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgall_range(S3C64XX_GPC(0), 3,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_S3C64XX_DEV_SPI1
+struct s3c64xx_spi_info s3c64xx_spi1_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 13,
+	.tx_st_done	= 21,
+	.cntrlr_no	= 1,
+};
+
+int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgall_range(S3C64XX_GPC(4), 3,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index 483dfba..ff19e6c 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -69,4 +69,11 @@ struct s3c64xx_spi_info {
  */
 extern void s3c64xx_spi_set_platdata(struct s3c64xx_spi_info *pd,
 				     int src_clk_nr, int num_cs);
+
+/* defined by architecture to configure gpio */
+extern int s3c64xx_spi0_cfg_gpio(struct platform_device *dev);
+extern int s3c64xx_spi1_cfg_gpio(struct platform_device *dev);
+
+extern struct s3c64xx_spi_info s3c64xx_spi0_pdata;
+extern struct s3c64xx_spi_info s3c64xx_spi1_pdata;
 #endif /* __S3C64XX_PLAT_SPI_H */
-- 
1.7.1
