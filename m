From: p.paneri@samsung.com (Praveen Paneri)
Date: Wed, 01 Aug 2012 18:35:50 +0530
Subject: [PATCH 4/5] ARM: S3C64XX: Enabling sec_usbphy driver
In-Reply-To: <1343826351-8756-1-git-send-email-p.paneri@samsung.com>
References: <1343826351-8756-1-git-send-email-p.paneri@samsung.com>
Message-ID: <1343826351-8756-5-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding platform device for sec_usbphy driver. Enabling it for s3c64xx
based machines using s3c-hsotg.

Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
---
 arch/arm/mach-s3c64xx/include/mach/map.h     |    2 +
 arch/arm/mach-s3c64xx/mach-crag6410.c        |    3 ++
 arch/arm/mach-s3c64xx/mach-smartq.c          |    4 +++
 arch/arm/mach-s3c64xx/mach-smdk6410.c        |    3 ++
 arch/arm/mach-s3c64xx/setup-usb-phy.c        |   14 +++++++++++
 arch/arm/plat-samsung/devs.c                 |   32 ++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h    |    1 +
 arch/arm/plat-samsung/include/plat/usb-phy.h |    1 +
 8 files changed, 60 insertions(+), 0 deletions(-)

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
index 984146e..88c4671 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -337,6 +337,7 @@ static struct platform_device wallvdd_device = {
 };
 
 static struct platform_device *crag6410_devices[] __initdata = {
+	&s3c_device_usbphy,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc2,
 	&s3c_device_i2c0,
@@ -767,6 +768,7 @@ static const struct gpio_led_platform_data gpio_leds_pdata = {
 	.num_leds = ARRAY_SIZE(gpio_leds),
 };
 
+static struct s3c_usbphy_plat crag6410_usbphy_pdata;
 
 static void __init crag6410_machine_init(void)
 {
@@ -792,6 +794,7 @@ static void __init crag6410_machine_init(void)
 	s3c_i2c0_set_platdata(&i2c0_pdata);
 	s3c_i2c1_set_platdata(&i2c1_pdata);
 	s3c_fb_set_platdata(&crag6410_lcd_pdata);
+	s3c_usbphy_set_platdata(&crag6410_usbphy_pdata);
 
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 3647202..97751d5 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -235,6 +235,7 @@ static struct i2c_board_info smartq_i2c_devs[] __initdata = {
 };
 
 static struct platform_device *smartq_devices[] __initdata = {
+	&s3c_device_usbphy,
 	&s3c_device_hsmmc1,	/* Init iNAND first, ... */
 	&s3c_device_hsmmc0,	/* ... then the external SD card */
 	&s3c_device_hsmmc2,
@@ -381,9 +382,12 @@ void __init smartq_map_io(void)
 	smartq_lcd_mode_set();
 }
 
+static struct s3c_usbphy_plat smartq_usbphy_pdata;
+
 void __init smartq_machine_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
+	s3c_usbphy_set_platdata(&smartq_usbphy_pdata);
 	s3c_hwmon_set_platdata(&smartq_hwmon_pdata);
 	s3c_sdhci1_set_platdata(&smartq_internal_hsmmc_pdata);
 	s3c_sdhci2_set_platdata(&smartq_internal_hsmmc_pdata);
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index ceec1a9..c5ea838 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -264,6 +264,7 @@ static struct samsung_keypad_platdata smdk6410_keypad_data __initdata = {
 static struct map_desc smdk6410_iodesc[] = {};
 
 static struct platform_device *smdk6410_devices[] __initdata = {
+	&s3c_device_usbphy,
 #ifdef CONFIG_SMDK6410_SD_CH0
 	&s3c_device_hsmmc0,
 #endif
@@ -628,6 +629,7 @@ static struct platform_pwm_backlight_data smdk6410_bl_data = {
 	.pwm_id = 1,
 };
 
+static struct s3c_usbphy_plat smdk6410_usbphy_pdata;
 
 static void __init smdk6410_map_io(void)
 {
@@ -657,6 +659,7 @@ static void __init smdk6410_machine_init(void)
 	s3c_i2c0_set_platdata(NULL);
 	s3c_i2c1_set_platdata(NULL);
 	s3c_fb_set_platdata(&smdk6410_lcd_pdata);
+	s3c_usbphy_set_platdata(&smdk6410_usbphy_pdata);
 
 	samsung_keypad_set_platdata(&smdk6410_keypad_data);
 
diff --git a/arch/arm/mach-s3c64xx/setup-usb-phy.c b/arch/arm/mach-s3c64xx/setup-usb-phy.c
index 7a09553..3aee778 100644
--- a/arch/arm/mach-s3c64xx/setup-usb-phy.c
+++ b/arch/arm/mach-s3c64xx/setup-usb-phy.c
@@ -9,3 +9,17 @@
  *
  */
 
+#include <linux/io.h>
+#include <mach/map.h>
+#include <mach/regs-sys.h>
+
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
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 6303974..77a35f1 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1343,6 +1343,35 @@ struct platform_device s5p_device_mixer = {
 
 /* USB */
 
+#ifdef CONFIG_S3C_DEV_USB_HSOTG
+/* USB PHY*/
+static struct resource s3c_usbphy_resource[] = {
+	[0] = {
+		.start = S3C_PA_USB_PHY,
+		.end   = S3C_PA_USB_PHY + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device s3c_device_usbphy = {
+	.name		= "s3c64xx-usbphy",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_usbphy_resource),
+	.resource	= s3c_usbphy_resource,
+};
+
+void __init s3c_usbphy_set_platdata(struct s3c_usbphy_plat *pd)
+{
+	struct s3c_usbphy_plat *npd;
+
+	npd = s3c_set_platdata(pd, sizeof(struct s3c_usbphy_plat),
+			&s3c_device_usbphy);
+
+	if (!npd->pmu_isolation)
+		npd->pmu_isolation = s5p_usb_phy_pmu_isolation;
+}
+#endif
+
 #ifdef CONFIG_S3C_DEV_USB_HOST
 static struct resource s3c_usb_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C_PA_USBHOST, SZ_256),
@@ -1449,6 +1478,8 @@ struct platform_device s3c_device_usb_hsotg = {
 	},
 };
 
+#ifndef CONFIG_ARCH_S3C64XX
+/* TODO: To be removed later. Currently only S3C64XX is platform data free */
 void __init s3c_hsotg_set_platdata(struct s3c_hsotg_plat *pd)
 {
 	struct s3c_hsotg_plat *npd;
@@ -1461,6 +1492,7 @@ void __init s3c_hsotg_set_platdata(struct s3c_hsotg_plat *pd)
 	if (!npd->phy_exit)
 		npd->phy_exit = s5p_usb_phy_exit;
 }
+#endif
 #endif /* CONFIG_S3C_DEV_USB_HSOTG */
 
 /* USB High Spped 2.0 Device (Gadget) */
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 61ca2f3..cbb079a 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -71,6 +71,7 @@ extern struct platform_device s3c_device_spi1;
 extern struct platform_device s3c_device_ts;
 extern struct platform_device s3c_device_timer[];
 extern struct platform_device s3c_device_usbgadget;
+extern struct platform_device s3c_device_usbphy;
 extern struct platform_device s3c_device_usb_hsotg;
 extern struct platform_device s3c_device_usb_hsudc;
 extern struct platform_device s3c_device_wdt;
diff --git a/arch/arm/plat-samsung/include/plat/usb-phy.h b/arch/arm/plat-samsung/include/plat/usb-phy.h
index 959bcdb..165ffe7 100644
--- a/arch/arm/plat-samsung/include/plat/usb-phy.h
+++ b/arch/arm/plat-samsung/include/plat/usb-phy.h
@@ -18,5 +18,6 @@ enum s5p_usb_phy_type {
 
 extern int s5p_usb_phy_init(struct platform_device *pdev, int type);
 extern int s5p_usb_phy_exit(struct platform_device *pdev, int type);
+extern void s5p_usb_phy_pmu_isolation(int on);
 
 #endif /* __PLAT_SAMSUNG_USB_PHY_H */
-- 
1.7.1
