From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 28 Dec 2011 16:03:22 +0900
Subject: [PATCH 1/6] ARM: S3C64XX: Add usb otg phy control
Message-ID: <1325055807-29347-1-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supports to control usb otg phy of S3C64XX. Currently, the
driver for usb otg controls usb otg phy but it can be removed by this
patch.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
This was done compile test only.

 arch/arm/mach-s3c64xx/Kconfig                      |    8 ++
 arch/arm/mach-s3c64xx/Makefile                     |    1 +
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    4 +
 arch/arm/mach-s3c64xx/mach-smartq.c                |    3 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    4 +
 arch/arm/mach-s3c64xx/setup-usb-phy.c              |   90 ++++++++++++++++++++
 arch/arm/plat-samsung/devs.c                       |   14 +++
 .../plat-samsung/include/plat/regs-usb-hsotg-phy.h |    7 +-
 arch/arm/plat-samsung/include/plat/udc-hs.h        |    5 +
 9 files changed, 133 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/setup-usb-phy.c

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index e9dae91..b268009 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -82,6 +82,11 @@ config S3C64XX_SETUP_SPI
 	help
 	 Common setup code for SPI GPIO configurations
 
+config S3C64XX_SETUP_USB_PHY
+	bool
+	help
+	  Common setup code for USB PHY controller
+
 # S36400 Macchine support
 
 config MACH_SMDK6400
@@ -156,6 +161,7 @@ config MACH_SMDK6410
 	select S3C64XX_SETUP_IDE
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_KEYPAD
+	select S3C64XX_SETUP_USB_PHY
 	help
 	  Machine support for the Samsung SMDK6410
 
@@ -255,6 +261,7 @@ config MACH_SMARTQ
 	select S3C_DEV_USB_HOST
 	select S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_FB_24BPP
+	select S3C64XX_SETUP_USB_PHY
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
@@ -282,6 +289,7 @@ config MACH_WLF_CRAGG_6410
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_KEYPAD
 	select S3C64XX_SETUP_SPI
+	select S3C64XX_SETUP_USB_PHY
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_KEYPAD
 	select S3C_DEV_USB_HOST
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 2244c42..0280cb8f 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_S3C64XX_SETUP_KEYPAD) += setup-keypad.o
 obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
 obj-$(CONFIG_S3C64XX_SETUP_SPI) += setup-spi.o
+obj-$(CONFIG_S3C64XX_SETUP_USB_PHY) += setup-usb-phy.o
 
 # PM
 
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 42d3d64..62c613c 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -59,6 +59,7 @@
 #include <plat/sdhci.h>
 #include <plat/gpio-cfg.h>
 #include <plat/s3c64xx-spi.h>
+#include <plat/udc-hs.h>
 
 #include <plat/keypad.h>
 #include <plat/clock.h>
@@ -702,6 +703,8 @@ static struct s3c_sdhci_platdata crag6410_hsmmc0_pdata = {
 	.cfg_gpio		= crag6410_cfg_sdhci0,
 };
 
+static struct s3c_hsotg_plat crag6410_hsotg_pdata;
+
 static void __init crag6410_machine_init(void)
 {
 	/* Open drain IRQs need pullups */
@@ -727,6 +730,7 @@ static void __init crag6410_machine_init(void)
 	s3c_i2c0_set_platdata(&i2c0_pdata);
 	s3c_i2c1_set_platdata(&i2c1_pdata);
 	s3c_fb_set_platdata(&crag6410_lcd_pdata);
+	s3c_hsotg_set_platdata(&crag6410_hsotg_pdata);
 
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index cb1ebeb..a6c4922 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -185,6 +185,8 @@ static struct s3c_hwmon_pdata smartq_hwmon_pdata __initdata = {
 	},
 };
 
+static struct s3c_hsotg_plat smartq_hsotg_pdata;
+
 static int __init smartq_lcd_setup_gpio(void)
 {
 	int ret;
@@ -381,6 +383,7 @@ void __init smartq_map_io(void)
 void __init smartq_machine_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
+	s3c_hsotg_set_platdata(&smartq_hsotg_pdata);
 	s3c_hwmon_set_platdata(&smartq_hwmon_pdata);
 	s3c_sdhci1_set_platdata(&smartq_internal_hsmmc_pdata);
 	s3c_sdhci2_set_platdata(&smartq_internal_hsmmc_pdata);
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 8bc8edd..dab9c58 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -72,6 +72,7 @@
 #include <plat/keypad.h>
 #include <plat/backlight.h>
 #include <plat/regs-fb-v4.h>
+#include <plat/udc-hs.h>
 
 #define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
@@ -629,6 +630,8 @@ static struct platform_pwm_backlight_data smdk6410_bl_data = {
 	.pwm_id = 1,
 };
 
+static struct s3c_hsotg_plat smdk6410_hsotg_pdata;
+
 static void __init smdk6410_map_io(void)
 {
 	u32 tmp;
@@ -657,6 +660,7 @@ static void __init smdk6410_machine_init(void)
 	s3c_i2c0_set_platdata(NULL);
 	s3c_i2c1_set_platdata(NULL);
 	s3c_fb_set_platdata(&smdk6410_lcd_pdata);
+	s3c_hsotg_set_platdata(&smdk6410_hsotg_pdata);
 
 	samsung_keypad_set_platdata(&smdk6410_keypad_data);
 
diff --git a/arch/arm/mach-s3c64xx/setup-usb-phy.c b/arch/arm/mach-s3c64xx/setup-usb-phy.c
new file mode 100644
index 0000000..f6757e0
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/setup-usb-phy.c
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2011 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <mach/map.h>
+#include <mach/regs-sys.h>
+#include <plat/cpu.h>
+#include <plat/regs-usb-hsotg-phy.h>
+#include <plat/usb-phy.h>
+
+static int s3c_usb_otgphy_init(struct platform_device *pdev)
+{
+	struct clk *xusbxti;
+	u32 phyclk;
+
+	writel(readl(S3C64XX_OTHERS) | S3C64XX_OTHERS_USBMASK, S3C64XX_OTHERS);
+
+	/* set clock frequency for PLL */
+	phyclk = readl(S3C_PHYCLK) & ~S3C_PHYCLK_CLKSEL_MASK;
+
+	xusbxti = clk_get(&pdev->dev, "xusbxti");
+	if (xusbxti && !IS_ERR(xusbxti)) {
+		switch (clk_get_rate(xusbxti)) {
+		case 12 * MHZ:
+			phyclk |= S3C_PHYCLK_CLKSEL_12M;
+			break;
+		case 24 * MHZ:
+			phyclk |= S3C_PHYCLK_CLKSEL_24M;
+			break;
+		default:
+		case 48 * MHZ:
+			/* default reference clock */
+			break;
+		}
+		clk_put(xusbxti);
+	}
+
+	/* TODO: select external clock/oscillator */
+	writel(phyclk | S3C_PHYCLK_CLK_FORCE, S3C_PHYCLK);
+
+	/* set to normal OTG PHY */
+	writel((readl(S3C_PHYPWR) & ~S3C_PHYPWR_NORMAL_MASK), S3C_PHYPWR);
+	mdelay(1);
+
+	/* reset OTG PHY and Link */
+	writel(S3C_RSTCON_PHY | S3C_RSTCON_HCLK | S3C_RSTCON_PHYCLK,
+			S3C_RSTCON);
+	udelay(20);	/* at-least 10uS */
+	writel(0, S3C_RSTCON);
+
+	return 0;
+}
+
+static int s3c_usb_otgphy_exit(struct platform_device *pdev)
+{
+	writel((readl(S3C_PHYPWR) | S3C_PHYPWR_ANALOG_POWERDOWN |
+				S3C_PHYPWR_OTG_DISABLE), S3C_PHYPWR);
+
+	writel(readl(S3C64XX_OTHERS) & ~S3C64XX_OTHERS_USBMASK, S3C64XX_OTHERS);
+
+	return 0;
+}
+
+int s5p_usb_phy_init(struct platform_device *pdev, int type)
+{
+	if (type == S5P_USB_PHY_DEVICE)
+		return s3c_usb_otgphy_init(pdev);
+
+	return -EINVAL;
+}
+
+int s5p_usb_phy_exit(struct platform_device *pdev, int type)
+{
+	if (type == S5P_USB_PHY_DEVICE)
+		return s3c_usb_otgphy_exit(pdev);
+
+	return -EINVAL;
+}
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 79db367..e5138ee 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -56,6 +56,7 @@
 #include <plat/sdhci.h>
 #include <plat/ts.h>
 #include <plat/udc.h>
+#include <plat/udc-hs.h>
 #include <plat/usb-control.h>
 #include <plat/usb-phy.h>
 #include <plat/regs-iic.h>
@@ -1448,6 +1449,19 @@ struct platform_device s3c_device_usb_hsotg = {
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
+
+void __init s3c_hsotg_set_platdata(struct s3c_hsotg_plat *pd)
+{
+	struct s3c_hsotg_plat *npd;
+
+	npd = s3c_set_platdata(pd, sizeof(struct s3c_hsotg_plat),
+			&s3c_device_usb_hsotg);
+
+	if (!npd->phy_init)
+		npd->phy_init = s5p_usb_phy_init;
+	if (!npd->phy_exit)
+		npd->phy_exit = s5p_usb_phy_exit;
+}
 #endif /* CONFIG_S3C_DEV_USB_HSOTG */
 
 /* USB High Spped 2.0 Device (Gadget) */
diff --git a/arch/arm/plat-samsung/include/plat/regs-usb-hsotg-phy.h b/arch/arm/plat-samsung/include/plat/regs-usb-hsotg-phy.h
index a111ad8..fcf2796 100644
--- a/arch/arm/plat-samsung/include/plat/regs-usb-hsotg-phy.h
+++ b/arch/arm/plat-samsung/include/plat/regs-usb-hsotg-phy.h
@@ -25,8 +25,9 @@
 #define S3C_HSOTG_PHYREG(x)	((x) + S3C_VA_USB_HSPHY)
 
 #define S3C_PHYPWR				S3C_HSOTG_PHYREG(0x00)
-#define SRC_PHYPWR_OTG_DISABLE			(1 << 4)
-#define SRC_PHYPWR_ANALOG_POWERDOWN		(1 << 3)
+#define S3C_PHYPWR_NORMAL_MASK			(0x19 << 0)
+#define S3C_PHYPWR_OTG_DISABLE			(1 << 4)
+#define S3C_PHYPWR_ANALOG_POWERDOWN		(1 << 3)
 #define SRC_PHYPWR_FORCE_SUSPEND		(1 << 1)
 
 #define S3C_PHYCLK				S3C_HSOTG_PHYREG(0x04)
@@ -42,7 +43,7 @@
 
 #define S3C_RSTCON				S3C_HSOTG_PHYREG(0x08)
 #define S3C_RSTCON_PHYCLK			(1 << 2)
-#define S3C_RSTCON_HCLK				(1 << 2)
+#define S3C_RSTCON_HCLK				(1 << 1)
 #define S3C_RSTCON_PHY				(1 << 0)
 
 #define S3C_PHYTUNE				S3C_HSOTG_PHYREG(0x20)
diff --git a/arch/arm/plat-samsung/include/plat/udc-hs.h b/arch/arm/plat-samsung/include/plat/udc-hs.h
index a22a4f2..c9e3667 100644
--- a/arch/arm/plat-samsung/include/plat/udc-hs.h
+++ b/arch/arm/plat-samsung/include/plat/udc-hs.h
@@ -26,4 +26,9 @@ enum s3c_hsotg_dmamode {
 struct s3c_hsotg_plat {
 	enum s3c_hsotg_dmamode	dma;
 	unsigned int		is_osc : 1;
+
+	int (*phy_init)(struct platform_device *pdev, int type);
+	int (*phy_exit)(struct platform_device *pdev, int type);
 };
+
+extern void s3c_hsotg_set_platdata(struct s3c_hsotg_plat *pd);
-- 
1.7.5.4
