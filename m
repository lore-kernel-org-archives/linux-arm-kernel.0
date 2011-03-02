From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  2 Mar 2011 12:01:22 +0100
Subject: [PATCH 3/4] ARM i.MX31 lilly: remove incomplete otg support
In-Reply-To: <1299063683-24903-1-git-send-email-s.hauer@pengutronix.de>
References: <1299063683-24903-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1299063683-24903-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform data for the otg port is present but never used, so
remove it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-mx3/mach-mx31lilly.c |   53 ------------------------------------
 1 files changed, 0 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
index be79a0d..e2f9de1 100644
--- a/arch/arm/mach-mx3/mach-mx31lilly.c
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c
@@ -116,52 +116,6 @@ static struct platform_device physmap_flash_device = {
 #define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
 			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
 
-static int usbotg_init(struct platform_device *pdev)
-{
-	unsigned int pins[] = {
-		MX31_PIN_USBOTG_DATA0__USBOTG_DATA0,
-		MX31_PIN_USBOTG_DATA1__USBOTG_DATA1,
-		MX31_PIN_USBOTG_DATA2__USBOTG_DATA2,
-		MX31_PIN_USBOTG_DATA3__USBOTG_DATA3,
-		MX31_PIN_USBOTG_DATA4__USBOTG_DATA4,
-		MX31_PIN_USBOTG_DATA5__USBOTG_DATA5,
-		MX31_PIN_USBOTG_DATA6__USBOTG_DATA6,
-		MX31_PIN_USBOTG_DATA7__USBOTG_DATA7,
-		MX31_PIN_USBOTG_CLK__USBOTG_CLK,
-		MX31_PIN_USBOTG_DIR__USBOTG_DIR,
-		MX31_PIN_USBOTG_NXT__USBOTG_NXT,
-		MX31_PIN_USBOTG_STP__USBOTG_STP,
-	};
-
-	mxc_iomux_setup_multiple_pins(pins, ARRAY_SIZE(pins), "USB OTG");
-
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA0, USB_PAD_CFG);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA1, USB_PAD_CFG);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA2, USB_PAD_CFG);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA3, USB_PAD_CFG);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA4, USB_PAD_CFG);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA5, USB_PAD_CFG);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA6, USB_PAD_CFG);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA7, USB_PAD_CFG);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_CLK, USB_PAD_CFG);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DIR, USB_PAD_CFG);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_NXT, USB_PAD_CFG);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_STP, USB_PAD_CFG);
-
-	mxc_iomux_set_gpr(MUX_PGP_USB_4WIRE, true);
-	mxc_iomux_set_gpr(MUX_PGP_USB_COMMON, true);
-
-	/* chip select */
-	mxc_iomux_alloc_pin(IOMUX_MODE(MX31_PIN_DTR_DCE2, IOMUX_CONFIG_GPIO),
-				"USBOTG_CS");
-	gpio_request(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE2), "USBH1 CS");
-	gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE2), 0);
-
-	mdelay(10);
-
-	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED);
-}
-
 static int usbh1_init(struct platform_device *pdev)
 {
 	int pins[] = {
@@ -231,11 +185,6 @@ static int usbh2_init(struct platform_device *pdev)
 	return mx31_initialize_usb_hw(pdev->id, MXC_EHCI_POWER_PINS_ENABLED);
 }
 
-static struct mxc_usbh_platform_data usbotg_pdata = {
-	.init	= usbotg_init,
-	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
-};
-
 static const struct mxc_usbh_platform_data usbh1_pdata __initconst = {
 	.init	= usbh1_init,
 	.portsc	= MXC_EHCI_MODE_UTMI | MXC_EHCI_SERIAL,
@@ -248,8 +197,6 @@ static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 
 static void lilly1131_usb_init(void)
 {
-	usbotg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
 				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
-- 
1.7.2.3
