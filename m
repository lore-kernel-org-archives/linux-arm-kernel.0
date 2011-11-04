From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 04 Nov 2011 09:00:06 -0400
Subject: [PATCH] ARM: EXYNOS4: Add SPI support
In-Reply-To: <1320411606-11518-1-git-send-email-padma.v@samsung.com>
References: <1320411606-11518-1-git-send-email-padma.v@samsung.com>
Message-ID: <1320411606-11518-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPI setup files for GPIO configurations.
Add SPI clkdev support.
Initialize SPI platform specific code in the machine file.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig                   |    5 ++
 arch/arm/mach-exynos4/Makefile                  |    1 +
 arch/arm/mach-exynos4/clock.c                   |   72 +++++++++++++---------
 arch/arm/mach-exynos4/include/mach/irqs.h       |    3 +
 arch/arm/mach-exynos4/include/mach/map.h        |    6 ++
 arch/arm/mach-exynos4/include/mach/spi-clocks.h |   16 +++++
 arch/arm/mach-exynos4/mach-smdkv310.c           |   35 +++++++++++
 arch/arm/mach-exynos4/setup-spi.c               |   47 +++++++++++++++
 8 files changed, 155 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/include/mach/spi-clocks.h
 create mode 100644 arch/arm/mach-exynos4/setup-spi.c

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index fde6ca5..df7070e 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -127,6 +127,11 @@ config EXYNOS4_SETUP_USB_PHY
 	help
 	  Common setup code for USB PHY controller
 
+config EXYNOS4_SETUP_SPI
+	bool
+	help
+	  Common setup code for SPI GPIO configurations.
+
 # machine support
 
 menu "EXYNOS4 Machines"
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 4e302cb..e227549 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -59,5 +59,6 @@ obj-$(CONFIG_EXYNOS4_SETUP_I2C6)	+= setup-i2c6.o
 obj-$(CONFIG_EXYNOS4_SETUP_I2C7)	+= setup-i2c7.o
 obj-$(CONFIG_EXYNOS4_SETUP_KEYPAD)	+= setup-keypad.o
 obj-$(CONFIG_EXYNOS4_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
+obj-$(CONFIG_EXYNOS4_SETUP_SPI)		+= setup-spi.o
 
 obj-$(CONFIG_EXYNOS4_SETUP_USB_PHY)	+= setup-usb-phy.o
diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index 6eeabdd..3f92909 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -1116,36 +1116,6 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -1262,6 +1232,42 @@ static struct clksrc_clk clk_sclk_mmc3 = {
 	.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 24, .size = 8 },
 };
 
+static struct clksrc_clk clk_sclk_spi0 = {
+	.clk		= {
+		.name		= "sclk_spi",
+		.devname	= "s3c64xx-spi.0",
+		.enable		= exynos4_clksrc_mask_peril1_ctrl,
+		.ctrlbit	= (1 << 16),
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 16, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 0, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_spi1 = {
+	.clk		= {
+		.name		= "sclk_spi",
+		.devname	= "s3c64xx-spi.1",
+		.enable		= exynos4_clksrc_mask_peril1_ctrl,
+		.ctrlbit	= (1 << 20),
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 20, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 16, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_spi2 = {
+	.clk		= {
+		.name		= "sclk_spi",
+		.devname	= "s3c64xx-spi.2",
+		.enable		= exynos4_clksrc_mask_peril1_ctrl,
+		.ctrlbit	= (1 << 24),
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 24, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_PERIL2, .shift = 0, .size = 4 },
+};
+
 /* Clock initialization code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -1310,6 +1316,9 @@ static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_mmc1,
 	&clk_sclk_mmc2,
 	&clk_sclk_mmc3,
+	&clk_sclk_spi0,
+	&clk_sclk_spi1,
+	&clk_sclk_spi2,
 };
 
 static struct clk_lookup exynos4_clk_lookup[] = {
@@ -1323,6 +1332,9 @@ static struct clk_lookup exynos4_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),
 	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &clk_pdma0),
 	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &clk_pdma1),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk0", &clk_sclk_spi0.clk),
+	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk0", &clk_sclk_spi1.clk),
+	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk0", &clk_sclk_spi2.clk),
 };
 
 static int xtal_rate;
diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
index 713dd52..f77bce0 100644
--- a/arch/arm/mach-exynos4/include/mach/irqs.h
+++ b/arch/arm/mach-exynos4/include/mach/irqs.h
@@ -72,6 +72,9 @@
 #define IRQ_IIC5		IRQ_SPI(63)
 #define IRQ_IIC6		IRQ_SPI(64)
 #define IRQ_IIC7		IRQ_SPI(65)
+#define IRQ_SPI0		IRQ_SPI(66)
+#define IRQ_SPI1		IRQ_SPI(67)
+#define IRQ_SPI2		IRQ_SPI(68)
 
 #define IRQ_USB_HOST		IRQ_SPI(70)
 #define IRQ_USB_HSOTG		IRQ_SPI(71)
diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
index 918a979..fab8e2b 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -87,6 +87,9 @@
 #define EXYNOS4_PA_SYSMMU_TV		0x12E20000
 #define EXYNOS4_PA_SYSMMU_MFC_L		0x13620000
 #define EXYNOS4_PA_SYSMMU_MFC_R		0x13630000
+#define EXYNOS4_PA_SPI0			0x13920000
+#define EXYNOS4_PA_SPI1			0x13930000
+#define EXYNOS4_PA_SPI2			0x13940000
 
 #define EXYNOS4_PA_GPIO1		0x11400000
 #define EXYNOS4_PA_GPIO2		0x11000000
@@ -149,6 +152,9 @@
 #define SAMSUNG_PA_ADC1			EXYNOS4_PA_ADC1
 #define S3C_PA_RTC			EXYNOS4_PA_RTC
 #define S3C_PA_WDT			EXYNOS4_PA_WATCHDOG
+#define S3C_PA_SPI0			EXYNOS4_PA_SPI0
+#define S3C_PA_SPI1			EXYNOS4_PA_SPI1
+#define S3C_PA_SPI2			EXYNOS4_PA_SPI2
 
 #define S5P_PA_CHIPID			EXYNOS4_PA_CHIPID
 #define S5P_PA_FIMC0			EXYNOS4_PA_FIMC0
diff --git a/arch/arm/mach-exynos4/include/mach/spi-clocks.h b/arch/arm/mach-exynos4/include/mach/spi-clocks.h
new file mode 100644
index 0000000..576efdf
--- /dev/null
+++ b/arch/arm/mach-exynos4/include/mach/spi-clocks.h
@@ -0,0 +1,16 @@
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
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index cec2afa..8dd9167 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -40,6 +40,7 @@
 #include <plat/mfc.h>
 #include <plat/ehci.h>
 #include <plat/clock.h>
+#include <plat/s3c64xx-spi.h>
 
 #include <mach/map.h>
 
@@ -235,6 +236,40 @@ static struct i2c_board_info i2c_devs1[] __initdata = {
 	{I2C_BOARD_INFO("wm8994", 0x1a),},
 };
 
+#ifdef CONFIG_S3C64XX_DEV_SPI0
+static struct s3c64xx_spi_info smdkv310_spi0_pdata __initdata = {
+	.cfg_gpio	= s3c64xx_spi0_cfg_gpio,
+	.fifo_lvl_mask	= 0x1ff,
+	.rx_lvl_offset	= 15,
+	.high_speed	= 1,
+	.clk_from_cmu	= true,
+	.tx_st_done	= 25,
+};
+#endif
+
+#ifdef CONFIG_S3C64XX_DEV_SPI1
+static struct s3c64xx_spi_info smdkv310_spi1_pdata __initdata = {
+	.cfg_gpio	= s3c64xx_spi1_cfg_gpio,
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 15,
+	.high_speed	= 1,
+	.clk_from_cmu	= true,
+	.tx_st_done	= 25,
+};
+#endif
+
+#ifdef CONFIG_S3C64XX_DEV_SPI2
+static struct s3c64xx_spi_info smdkv310_spi2_pdata __initdata = {
+	.cfg_gpio	= s3c64xx_spi2_cfg_gpio,
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 15,
+	.high_speed	= 1,
+	.clk_from_cmu	= true,
+	.tx_st_done	= 25,
+};
+#endif
+
+
 /* USB EHCI */
 static struct s5p_ehci_platdata smdkv310_ehci_pdata;
 
diff --git a/arch/arm/mach-exynos4/setup-spi.c b/arch/arm/mach-exynos4/setup-spi.c
new file mode 100644
index 0000000..b36ae2f
--- /dev/null
+++ b/arch/arm/mach-exynos4/setup-spi.c
@@ -0,0 +1,47 @@
+/* linux/arch/arm/mach-exynos4/setup-spi0.c
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
+
+#ifdef CONFIG_S3C64XX_DEV_SPI0
+int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(EXYNOS4_GPB(0), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(EXYNOS4_GPB(0), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_S3C64XX_DEV_SPI1
+int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(EXYNOS4_GPB(4), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(EXYNOS4_GPB(4), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(EXYNOS4_GPB(6), 2,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_S3C64XX_DEV_SPI2
+int s3c64xx_spi2_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(EXYNOS4_GPC1(1), S3C_GPIO_SFN(5));
+	s3c_gpio_setpull(EXYNOS4_GPC1(1), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(EXYNOS4_GPC1(3), 2,
+				S3C_GPIO_SFN(5), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
-- 
1.7.0.4
