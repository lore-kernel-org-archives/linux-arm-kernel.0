From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 21 Dec 2009 16:41:56 +0100
Subject: [PATCH v2] imx/mx3: depend on USB_ULPI for otg_ulpi_create
In-Reply-To: <4B2F9358.1090705@epfl.ch>
References: <4B2F9358.1090705@epfl.ch>
Message-ID: <1261410116-10382-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

otg_ulpi_create is defined in drivers/usb/otg/ulpi.c which depends on
CONFIG_USB_ULPI.  So protect its usage by the same symbol.  Moreover
mxc_ulpi_access_ops needs CONFIG_MXC_ULPI.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>
Cc: Daniel Mack <daniel@caiaq.de>
---
Hello,

compared to the previous version moboard_usbotg_init and
mxc_register_device(&mxc_otg_udc_device, ...) isn't protected by

The old comment about not building drivers/usb/otg/ulpi.o into vmlinux
still applies, so I reproduce the old text again:

This is still not a complete fix, as with
CONFIG_USB=m, CONFIG_PCI=n, CONFIG_USB_OTG_UTILS=n
drivers/usb/otg/ulpi.o isn't included in drivers/builtin.o and so the
linker still errors out.  Maybe USB_ULPI needs to select USB_OTG_UTILS?
Then the line

	obj-$(CONFIG_USB_ULPI)          += otg/

in drivers/usb/Makefile becomes superflous as drivers/Makefile has

	obj-$(CONFIG_USB_OTG_UTILS)     += usb/otg/

.  OTOH drivers/usb/otg/ulpi.c doesn't seem to make use of anything
defined in drivers/usb/otg/otg.c.

Best regards
Uwe
---
 arch/arm/mach-mx3/Kconfig            |    3 ++-
 arch/arm/mach-mx3/mach-mx31lite.c    |    4 ++++
 arch/arm/mach-mx3/mach-mx31moboard.c |    4 ++++
 3 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index ea8ed10..2829441 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -49,6 +49,7 @@ config MACH_PCM037_EET
 config MACH_MX31LITE
 	bool "Support MX31 LITEKIT (LogicPD)"
 	select ARCH_MX31
+	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for MX31 LITEKIT platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -63,7 +64,7 @@ config MACH_MX31_3DS
 config MACH_MX31MOBOARD
 	bool "Support mx31moboard platforms (EPFL Mobots group)"
 	select ARCH_MX31
-	select MXC_ULPI
+	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for mx31moboard platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
index db741be..1e26397 100644
--- a/arch/arm/mach-mx3/mach-mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -135,6 +135,7 @@ static struct spi_board_info mc13783_spi_dev __initdata = {
  * USB
  */
 
+#if defined(CONFIG_USB_ULPI)
 #define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
 			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
 
@@ -180,6 +181,7 @@ static struct mxc_usbh_platform_data usbh2_pdata = {
 	.portsc = MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
 	.flags  = MXC_EHCI_POWER_PINS_ENABLED,
 };
+#endif
 
 /*
  * NOR flash
@@ -256,11 +258,13 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
 	spi_register_board_info(&mc13783_spi_dev, 1);
 
+#if defined(CONFIG_USB_ULPI)
 	/* USB */
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
 
 	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+#endif
 
 	/* SMSC9117 IRQ pin */
 	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_SFS6), "sms9117-irq");
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 949b4de..ac4c815 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -341,6 +341,7 @@ static void moboard_usbotg_init(void)
 	gpio_direction_output(OTG_EN_B, 0);
 }
 
+#if defined(CONFIG_USB_ULPI)
 static struct fsl_usb2_platform_data usb_pdata = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_ULPI,
@@ -394,6 +395,9 @@ static int __init moboard_usbh2_init(void)
 
 	return mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 }
+#else
+static inline int moboard_usbh2_init(void) {}
+#endif
 
 
 static struct gpio_led mx31moboard_leds[] = {
-- 
1.6.5.2
