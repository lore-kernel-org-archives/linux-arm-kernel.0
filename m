From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 14 Dec 2011 10:17:16 -0500
Subject: [PATCH V3] ARM: EXYNOS4: Modified files for SPI consolidation work
Message-ID: <1323875836-22594-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As SPI platform devices are consolidated to plat-samsung, some
corresponding changes are required in the respective machine folder.
Setup files are added for SPI GPIO configurations and platform data
initialization.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                   |    5 ++
 arch/arm/mach-exynos/Makefile                  |    1 +
 arch/arm/mach-exynos/clock.c                   |   73 ++++++++++++++----------
 arch/arm/mach-exynos/include/mach/irqs.h       |    3 +
 arch/arm/mach-exynos/include/mach/map.h        |    7 ++
 arch/arm/mach-exynos/include/mach/spi-clocks.h |   17 ++++++
 arch/arm/mach-exynos/setup-spi.c               |   72 +++++++++++++++++++++++
 7 files changed, 148 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/mach-exynos/include/mach/spi-clocks.h
 create mode 100644 arch/arm/mach-exynos/setup-spi.c

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 0afcc3b..c925fec 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -148,6 +148,11 @@ config EXYNOS4_SETUP_USB_PHY
 	help
 	  Common setup code for USB PHY controller
 
+config EXYNOS4_SETUP_SPI
+	bool
+	help
+	  Common setup code for SPI GPIO configurations.
+
 # machine support
 
 if ARCH_EXYNOS4
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 57e5296..979fdd3 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_EXYNOS4_SETUP_I2C7)	+= setup-i2c7.o
 obj-$(CONFIG_EXYNOS4_SETUP_KEYPAD)	+= setup-keypad.o
 obj-$(CONFIG_EXYNOS4_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 obj-$(CONFIG_EXYNOS4_SETUP_USB_PHY)	+= setup-usb-phy.o
+obj-$(CONFIG_EXYNOS4_SETUP_SPI)		+= setup-spi.o
diff --git a/arch/arm/mach-exynos/clock.c b/arch/arm/mach-exynos/clock.c
index 28e2842..d3f41ce 100644
--- a/arch/arm/mach-exynos/clock.c
+++ b/arch/arm/mach-exynos/clock.c
@@ -1118,36 +1118,6 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLKDIV_LCD0, .shift = 0, .size = 4 },
 	}, {
 		.clk		= {
-			.name		= "sclk_spi",
-			.devname	= "s3c64xx-spi.0",
-			.enable		= exynos4_clksrc_mask_peril1_ctrl,
-			.ctrlbit	= (1 << 16),
-		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 16, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 0, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_spi",
-			.devname	= "s3c64xx-spi.1",
-			.enable		= exynos4_clksrc_mask_peril1_ctrl,
-			.ctrlbit	= (1 << 20),
-		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 20, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 16, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_spi",
-			.devname	= "s3c64xx-spi.2",
-			.enable		= exynos4_clksrc_mask_peril1_ctrl,
-			.ctrlbit	= (1 << 24),
-		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 24, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_PERIL2, .shift = 0, .size = 4 },
-	}, {
-		.clk		= {
 			.name		= "sclk_fimg2d",
 		},
 		.sources = &clkset_mout_g2d,
@@ -1264,6 +1234,42 @@ static struct clksrc_clk clk_sclk_mmc3 = {
 	.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 24, .size = 8 },
 };
 
+static struct clksrc_clk clk_sclk_spi0 = {
+	.clk		= {
+		.name		= "sclk_spi",
+		.devname		= "s3c64xx-spi.0",
+		.enable		= exynos4_clksrc_mask_peril1_ctrl,
+		.ctrlbit		= (1 << 16),
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 16, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 0, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_spi1 = {
+	.clk		= {
+		.name		= "sclk_spi",
+		.devname		= "s3c64xx-spi.1",
+		.enable		= exynos4_clksrc_mask_peril1_ctrl,
+		.ctrlbit		= (1 << 20),
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 20, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 16, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_spi2 = {
+	.clk		= {
+		.name		= "sclk_spi",
+		.devname		= "s3c64xx-spi.2",
+		.enable		= exynos4_clksrc_mask_peril1_ctrl,
+		.ctrlbit		= (1 << 24),
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 24, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_PERIL2, .shift = 0, .size = 4 },
+};
+
 /* Clock initialization code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -1313,6 +1319,10 @@ static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_mmc1,
 	&clk_sclk_mmc2,
 	&clk_sclk_mmc3,
+	&clk_sclk_spi0,
+	&clk_sclk_spi1,
+	&clk_sclk_spi2,
+
 };
 
 static struct clk_lookup exynos4_clk_lookup[] = {
@@ -1326,6 +1336,9 @@ static struct clk_lookup exynos4_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),
 	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &clk_pdma0),
 	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &clk_pdma1),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk0", &clk_sclk_spi0.clk),
+	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk0", &clk_sclk_spi1.clk),
+	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk0", &clk_sclk_spi2.clk),
 };
 
 static int xtal_rate;
diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index f7d73b1..1d401c9 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -74,6 +74,9 @@
 #define IRQ_IIC5		IRQ_SPI(63)
 #define IRQ_IIC6		IRQ_SPI(64)
 #define IRQ_IIC7		IRQ_SPI(65)
+#define IRQ_SPI0		IRQ_SPI(66)
+#define IRQ_SPI1		IRQ_SPI(67)
+#define IRQ_SPI2		IRQ_SPI(68)
 
 #define IRQ_USB_HOST		IRQ_SPI(70)
 #define IRQ_USB_HSOTG		IRQ_SPI(71)
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 03e2c99..64dca73 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -88,6 +88,10 @@
 #define EXYNOS4_PA_SYSMMU_TV		0x12E20000
 #define EXYNOS4_PA_SYSMMU_MFC_L		0x13620000
 #define EXYNOS4_PA_SYSMMU_MFC_R		0x13630000
+#define EXYNOS4_PA_SPI0			0x13920000
+#define EXYNOS4_PA_SPI1			0x13930000
+#define EXYNOS4_PA_SPI2			0x13940000
+
 
 #define EXYNOS4_PA_GPIO1		0x11400000
 #define EXYNOS4_PA_GPIO2		0x11000000
@@ -149,6 +153,9 @@
 #define S3C_PA_RTC			EXYNOS4_PA_RTC
 #define S3C_PA_WDT			EXYNOS4_PA_WATCHDOG
 #define S3C_PA_UART			EXYNOS4_PA_UART
+#define S3C_PA_SPI0			EXYNOS4_PA_SPI0
+#define S3C_PA_SPI1			EXYNOS4_PA_SPI1
+#define S3C_PA_SPI2			EXYNOS4_PA_SPI2
 
 #define S5P_PA_CHIPID			EXYNOS4_PA_CHIPID
 #define S5P_PA_EHCI			EXYNOS4_PA_EHCI
diff --git a/arch/arm/mach-exynos/include/mach/spi-clocks.h b/arch/arm/mach-exynos/include/mach/spi-clocks.h
new file mode 100644
index 0000000..9774389
--- /dev/null
+++ b/arch/arm/mach-exynos/include/mach/spi-clocks.h
@@ -0,0 +1,17 @@
+/* linux/arch/arm/mach-exynos4/include/mach/spi-clocks.h
+ *
+ * Copyright (C) 2011 Samsung Electronics Co. Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_SPI_CLKS_H
+#define __ASM_ARCH_SPI_CLKS_H __FILE__
+
+/* Must source from SCLK_SPI */
+#define EXYNOS4_SPI_SRCCLK_SCLK		0
+
+#endif /* __ASM_ARCH_SPI_CLKS_H */
+
diff --git a/arch/arm/mach-exynos/setup-spi.c b/arch/arm/mach-exynos/setup-spi.c
new file mode 100644
index 0000000..833ff40
--- /dev/null
+++ b/arch/arm/mach-exynos/setup-spi.c
@@ -0,0 +1,72 @@
+/* linux/arch/arm/mach-exynos4/setup-spi.c
+ *
+ * Copyright (C) 2011 Samsung Electronics Ltd.
+ *             http://www.samsung.com/
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
+	.fifo_lvl_mask	= 0x1ff,
+	.rx_lvl_offset	= 15,
+	.high_speed	= 1,
+	.clk_from_cmu	= true,
+	.tx_st_done	= 25,
+};
+
+int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(EXYNOS4_GPB(0), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(EXYNOS4_GPB(0), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_S3C64XX_DEV_SPI1
+struct s3c64xx_spi_info s3c64xx_spi1_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 15,
+	.high_speed	= 1,
+	.clk_from_cmu	= true,
+	.tx_st_done	= 25,
+};
+
+int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(EXYNOS4_GPB(4), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(EXYNOS4_GPB(4), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(EXYNOS4_GPB(6), 2,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_S3C64XX_DEV_SPI2
+struct s3c64xx_spi_info s3c64xx_spi2_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 15,
+	.high_speed	= 1,
+	.clk_from_cmu	= true,
+	.tx_st_done	= 25,
+};
+
+int s3c64xx_spi2_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(EXYNOS4_GPC1(1), S3C_GPIO_SFN(5));
+	s3c_gpio_setpull(EXYNOS4_GPC1(1), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(EXYNOS4_GPC1(3), 2,
+			      S3C_GPIO_SFN(5), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
-- 
1.7.0.4
