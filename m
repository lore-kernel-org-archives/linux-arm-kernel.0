From: p.paneri@samsung.com (Praveen Paneri)
Date: Fri, 23 Nov 2012 18:02:30 +0530
Subject: [PATCH v9 1/3] ARM: S3C64XX: Enabling samsung-usbphy driver
In-Reply-To: <1353673952-13537-1-git-send-email-p.paneri@samsung.com>
References: <1353673952-13537-1-git-send-email-p.paneri@samsung.com>
Message-ID: <1353673952-13537-2-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding platform device for samsung-usbphy driver. Enabling it for
s3c64xx based machines which are using s3c-hsotg.

Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
---
 arch/arm/Kconfig                             |    1 +
 arch/arm/mach-s3c64xx/include/mach/map.h     |    2 ++
 arch/arm/mach-s3c64xx/mach-crag6410.c        |    3 +++
 arch/arm/mach-s3c64xx/mach-smartq.c          |    3 +++
 arch/arm/mach-s3c64xx/mach-smdk6410.c        |    3 +++
 arch/arm/mach-s3c64xx/setup-usb-phy.c        |   15 +++++++++++++++
 arch/arm/plat-samsung/Kconfig                |    5 +++++
 arch/arm/plat-samsung/devs.c                 |   24 ++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h    |    1 +
 arch/arm/plat-samsung/include/plat/usb-phy.h |    2 ++
 10 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ade7e92..065f2a2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -773,6 +773,7 @@ config ARCH_S3C64XX
 	select SAMSUNG_GPIOLIB_4BIT
 	select SAMSUNG_IRQ_VIC_TIMER
 	select USB_ARCH_HAS_OHCI
+	select SAMSUNG_DEV_USBPHY
 	help
 	  Samsung S3C64XX series based systems
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h b/arch/arm/mach-s3c64xx/include/mach/map.h
index 8e2097b..dc482bb 100644
--- a/arch/arm/mach-s3c64xx/include/mach/map.h
+++ b/arch/arm/mach-s3c64xx/include/mach/map.h
@@ -65,6 +65,7 @@
 
 #define S3C64XX_PA_NAND		(0x70200000)
 #define S3C64XX_PA_FB		(0x77100000)
+#define S3C64XX_PA_USB_HSPHY	(0x7C100000)
 #define S3C64XX_PA_USB_HSOTG	(0x7C000000)
 #define S3C64XX_PA_WATCHDOG	(0x7E004000)
 #define S3C64XX_PA_RTC		(0x7E005000)
@@ -113,6 +114,7 @@
 #define S3C_PA_FB		S3C64XX_PA_FB
 #define S3C_PA_USBHOST		S3C64XX_PA_USBHOST
 #define S3C_PA_USB_HSOTG	S3C64XX_PA_USB_HSOTG
+#define S3C_PA_USB_PHY		S3C64XX_PA_USB_HSPHY
 #define S3C_PA_RTC		S3C64XX_PA_RTC
 #define S3C_PA_WDT		S3C64XX_PA_WATCHDOG
 #define S3C_PA_SPI0		S3C64XX_PA_SPI0
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 2abe95d..270529e 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -70,6 +70,7 @@
 #include <plat/adc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/pm.h>
+#include <plat/usb-phy.h>
 
 #include "common.h"
 
@@ -354,6 +355,7 @@ static struct platform_device wallvdd_device = {
 };
 
 static struct platform_device *crag6410_devices[] __initdata = {
+	&samsung_device_usbphy,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc2,
 	&s3c_device_i2c0,
@@ -831,6 +833,7 @@ static void __init crag6410_machine_init(void)
 	s3c_i2c0_set_platdata(&i2c0_pdata);
 	s3c_i2c1_set_platdata(&i2c1_pdata);
 	s3c_fb_set_platdata(&crag6410_lcd_pdata);
+	samsung_usbphy_set_pdata(&s3c_usbphy_pdata);
 	s3c_hsotg_set_platdata(&crag6410_hsotg_pdata);
 
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index c6d7390..2f815f4 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -37,6 +37,7 @@
 #include <linux/platform_data/usb-ohci-s3c2410.h>
 #include <plat/sdhci.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
+#include <plat/usb-phy.h>
 
 #include <video/platform_lcd.h>
 
@@ -236,6 +237,7 @@ static struct i2c_board_info smartq_i2c_devs[] __initdata = {
 };
 
 static struct platform_device *smartq_devices[] __initdata = {
+	&samsung_device_usbphy,
 	&s3c_device_hsmmc1,	/* Init iNAND first, ... */
 	&s3c_device_hsmmc0,	/* ... then the external SD card */
 	&s3c_device_hsmmc2,
@@ -390,6 +392,7 @@ void __init smartq_machine_init(void)
 	s3c_sdhci1_set_platdata(&smartq_internal_hsmmc_pdata);
 	s3c_sdhci2_set_platdata(&smartq_internal_hsmmc_pdata);
 	s3c24xx_ts_set_platdata(&smartq_touchscreen_pdata);
+	samsung_usbphy_set_pdata(&s3c_usbphy_pdata);
 
 	i2c_register_board_info(0, smartq_i2c_devs,
 				ARRAY_SIZE(smartq_i2c_devs));
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index da1a771..6575e11 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -73,6 +73,7 @@
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <plat/keypad.h>
 #include <plat/backlight.h>
+#include <plat/usb-phy.h>
 
 #include "common.h"
 
@@ -264,6 +265,7 @@ static struct samsung_keypad_platdata smdk6410_keypad_data __initdata = {
 static struct map_desc smdk6410_iodesc[] = {};
 
 static struct platform_device *smdk6410_devices[] __initdata = {
+	&samsung_device_usbphy,
 #ifdef CONFIG_SMDK6410_SD_CH0
 	&s3c_device_hsmmc0,
 #endif
@@ -657,6 +659,7 @@ static void __init smdk6410_machine_init(void)
 	s3c_i2c0_set_platdata(NULL);
 	s3c_i2c1_set_platdata(NULL);
 	s3c_fb_set_platdata(&smdk6410_lcd_pdata);
+	samsung_usbphy_set_pdata(&s3c_usbphy_pdata);
 	s3c_hsotg_set_platdata(&smdk6410_hsotg_pdata);
 
 	samsung_keypad_set_platdata(&smdk6410_keypad_data);
diff --git a/arch/arm/mach-s3c64xx/setup-usb-phy.c b/arch/arm/mach-s3c64xx/setup-usb-phy.c
index f6757e0..0cc9ed5 100644
--- a/arch/arm/mach-s3c64xx/setup-usb-phy.c
+++ b/arch/arm/mach-s3c64xx/setup-usb-phy.c
@@ -20,6 +20,21 @@
 #include <plat/regs-usb-hsotg-phy.h>
 #include <plat/usb-phy.h>
 
+void s5p_usb_phy_pmu_isolation(int on)
+{
+	if (on) {
+		writel(readl(S3C64XX_OTHERS) & ~S3C64XX_OTHERS_USBMASK,
+			S3C64XX_OTHERS);
+	} else {
+		writel(readl(S3C64XX_OTHERS) | S3C64XX_OTHERS_USBMASK,
+			S3C64XX_OTHERS);
+	}
+}
+
+struct samsung_usbphy_data s3c_usbphy_pdata __initdata = {
+	.pmu_isolation = s5p_usb_phy_pmu_isolation,
+};
+
 static int s3c_usb_otgphy_init(struct platform_device *pdev)
 {
 	struct clk *xusbxti;
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index a9d5216..005c5c2 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -260,6 +260,11 @@ config S3C_DEV_USB_HSOTG
 	help
 	  Compile in platform device definition for USB high-speed OtG
 
+config SAMSUNG_DEV_USBPHY
+	bool
+	help
+	  Compile in platform device definition for Samsung USB PHY
+
 config S3C_DEV_WDT
 	bool
 	default y if ARCH_S3C24XX
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index bc50b20..e44b606 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -31,6 +31,7 @@
 #include <linux/ioport.h>
 #include <linux/platform_data/s3c-hsudc.h>
 #include <linux/platform_data/s3c-hsotg.h>
+#include <linux/platform_data/samsung-usbphy.h>
 
 #include <media/s5p_hdmi.h>
 
@@ -1366,6 +1367,29 @@ struct platform_device s5p_device_mixer = {
 #endif /* CONFIG_S5P_DEV_TV */
 
 /* USB */
+#ifdef CONFIG_SAMSUNG_DEV_USBPHY
+/* USB PHY*/
+static struct resource samsung_usbphy_resource[] = {
+	[0] = {
+		.start = S3C_PA_USB_PHY,
+		.end   = S3C_PA_USB_PHY + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device samsung_device_usbphy = {
+	.name		= "s3c64xx-usbphy",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(samsung_usbphy_resource),
+	.resource	= samsung_usbphy_resource,
+};
+
+void __init samsung_usbphy_set_pdata(struct samsung_usbphy_data *pd)
+{
+	s3c_set_platdata(pd, sizeof(struct samsung_usbphy_data),
+			&samsung_device_usbphy);
+}
+#endif
 
 #ifdef CONFIG_S3C_DEV_USB_HOST
 static struct resource s3c_usb_resource[] = {
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 133e3e4..7f81dbc 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -136,6 +136,7 @@ extern struct platform_device exynos4_device_spdif;
 extern struct platform_device samsung_asoc_dma;
 extern struct platform_device samsung_asoc_idma;
 extern struct platform_device samsung_device_keypad;
+extern struct platform_device samsung_device_usbphy;
 
 /* s3c2440 specific devices */
 
diff --git a/arch/arm/plat-samsung/include/plat/usb-phy.h b/arch/arm/plat-samsung/include/plat/usb-phy.h
index 959bcdb..46b54bf 100644
--- a/arch/arm/plat-samsung/include/plat/usb-phy.h
+++ b/arch/arm/plat-samsung/include/plat/usb-phy.h
@@ -10,12 +10,14 @@
 
 #ifndef __PLAT_SAMSUNG_USB_PHY_H
 #define __PLAT_SAMSUNG_USB_PHY_H __FILE__
+#include <linux/platform_data/samsung-usbphy.h>
 
 enum s5p_usb_phy_type {
 	S5P_USB_PHY_DEVICE,
 	S5P_USB_PHY_HOST,
 };
 
+extern struct samsung_usbphy_data s3c_usbphy_pdata;
 extern int s5p_usb_phy_init(struct platform_device *pdev, int type);
 extern int s5p_usb_phy_exit(struct platform_device *pdev, int type);
 
-- 
1.7.1
