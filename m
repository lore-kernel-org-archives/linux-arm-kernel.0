From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:17 +0200
Subject: [PATCH 21/61] ARM: mx3: mx31lilly: fix build error for
	!CONFIG_USB_ULPI
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-22-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-mx3/built-in.o: In function `mx31lilly_board_init':
mach-kzm_arm11_01.c:(.init.text+0x674): undefined reference to `otg_ulpi_create'
mach-kzm_arm11_01.c:(.init.text+0x68c): undefined reference to `otg_ulpi_create'
mach-kzm_arm11_01.c:(.init.text+0x744): undefined reference to `mxc_ulpi_access_ops'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mach-mx31lilly.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
index d3d5877..b2c7f51 100644
--- a/arch/arm/mach-mx3/mach-mx31lilly.c
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c
@@ -115,6 +115,8 @@ static struct platform_device physmap_flash_device = {
 
 /* USB */
 
+#if defined(CONFIG_USB_ULPI)
+
 #define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
 			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
 
@@ -244,10 +246,20 @@ static struct mxc_usbh_platform_data usbh2_pdata = {
 	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
 };
 
-static struct platform_device *devices[] __initdata = {
-	&smsc91x_device,
-	&physmap_flash_device,
-};
+static void lilly1131_usb_init(void)
+{
+	usbotg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+
+	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
+	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+}
+
+#else
+static inline void lilly1131_usb_init(void) {}
+#endif /* CONFIG_USB_ULPI */
 
 /* SPI */
 
@@ -279,6 +291,11 @@ static struct spi_board_info mc13783_dev __initdata = {
 	.platform_data	= &mc13783_pdata,
 };
 
+static struct platform_device *devices[] __initdata = {
+	&smsc91x_device,
+	&physmap_flash_device,
+};
+
 static int mx31lilly_baseboard;
 core_param(mx31lilly_baseboard, mx31lilly_baseboard, int, 0444);
 
@@ -321,13 +338,7 @@ static void __init mx31lilly_board_init(void)
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	/* USB */
-	usbotg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
-	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
-
-	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
-	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+	lilly1131_usb_init();
 }
 
 static void __init mx31lilly_timer_init(void)
-- 
1.7.1
