From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 14 Dec 2011 10:15:59 -0500
Subject: [PATCH V3 2/6] ARM: S3C64XX: Modified files for SPI consolidation work
In-Reply-To: <1323875763-21197-1-git-send-email-padma.v@samsung.com>
References: <1323875763-21197-1-git-send-email-padma.v@samsung.com>
Message-ID: <1323875763-21197-3-git-send-email-padma.v@samsung.com>
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
 arch/arm/mach-s3c64xx/setup-spi.c                |   45 ++++++++++++++++++++++
 arch/arm/plat-samsung/devs.c                     |    6 +++
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    7 +++
 6 files changed, 66 insertions(+), 0 deletions(-)
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
index 0000000..d9592ad
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/setup-spi.c
@@ -0,0 +1,45 @@
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
+};
+
+int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgall_range(S3C64XX_GPC(4), 3,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index c943b46..2652dd9 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1498,6 +1498,9 @@ void __init s3c64xx_spi0_set_platdata(struct s3c64xx_spi_info *pd,
 
 	pd->num_cs = num_cs;
 	pd->src_clk_nr = src_clk_nr;
+	if (!pd->cfg_gpio)
+		pd->cfg_gpio = s3c64xx_spi0_cfg_gpio;
+
 	s3c_set_platdata(pd, sizeof(*pd), &s3c64xx_device_spi0);
 }
 #endif /* CONFIG_S3C64XX_DEV_SPI0 */
@@ -1537,6 +1540,9 @@ void __init s3c64xx_spi1_set_platdata(struct s3c64xx_spi_info *pd,
 
 	pd->num_cs = num_cs;
 	pd->src_clk_nr = src_clk_nr;
+	if (!pd->cfg_gpio)
+		pd->cfg_gpio = s3c64xx_spi1_cfg_gpio;
+
 	s3c_set_platdata(pd, sizeof(*pd), &s3c64xx_device_spi1);
 }
 #endif /* CONFIG_S3C64XX_DEV_SPI1 */
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index effca53..d3e2209 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -71,4 +71,11 @@ extern void s3c64xx_spi1_set_platdata(struct s3c64xx_spi_info *pd,
 				      int src_clk_nr, int num_cs);
 extern void s3c64xx_spi2_set_platdata(struct s3c64xx_spi_info *pd,
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
1.7.0.4
