From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 18 Aug 2010 17:56:45 +0200
Subject: [PATCH 2/2] mx35_3ds: add usb host2 support
In-Reply-To: <1282147005-4358-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1282147005-4358-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1282147005-4358-3-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

we still have to toggle two pins on the mc9sdz60:

/* MUX3_CTR to be low for USB Host2 DP&DM */
pmic_gpio_set_bit_val(MCU_GPIO_REG_GPIO_CONTROL_2, 6, 0);

/* CAN_PWDN to be high for USB Host2 Power&OC */
pmic_gpio_set_bit_val(MCU_GPIO_REG_GPIO_CONTROL_2, 1, 1);

until we've a proper driver for the mx9sdz60 in linux we'll do this in
barebox (a.k.a. u-boot-v2)

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-mx3/mach-mx35_3ds.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index ae0f17c..1dd7baa 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -38,6 +38,7 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
+#include <mach/mxc_ehci.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
@@ -105,6 +106,9 @@ static struct pad_desc mx35pdk_pads[] = {
 	/* USBOTG */
 	MX35_PAD_USBOTG_PWR__USB_TOP_USBOTG_PWR,
 	MX35_PAD_USBOTG_OC__USB_TOP_USBOTG_OC,
+	/* USBH1 */
+	MX35_PAD_I2C2_CLK__USB_TOP_USBH2_PWR,
+	MX35_PAD_I2C2_DAT__USB_TOP_USBH2_OC,
 };
 
 /* OTG config */
@@ -113,6 +117,13 @@ static struct fsl_usb2_platform_data usb_otg_pdata = {
 	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
 };
 
+/* USB HOST config */
+static struct mxc_usbh_platform_data usb_host_pdata = {
+	.portsc		= MXC_EHCI_MODE_SERIAL,
+	.flags		= MXC_EHCI_INTERFACE_SINGLE_UNI |
+			  MXC_EHCI_INTERNAL_PHY,
+};
+
 /*
  * Board specific initialization.
  */
@@ -126,6 +137,8 @@ static void __init mxc_board_init(void)
 
 	mxc_register_device(&mxc_otg_udc_device, &usb_otg_pdata);
 
+	mxc_register_device(&mxc_usbh1, &usb_host_pdata);
+
 	imx35_add_mxc_nand(&mx35pdk_nand_board_info);
 }
 
-- 
1.7.1
