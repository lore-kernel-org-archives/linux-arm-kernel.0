From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Mon, 21 Jun 2010 13:33:05 -0700 (PDT)
Subject: [PATCH] mx31_3ds: Handle USB OTG GPIO Errors
Message-ID: <261388.38765.qm@web51008.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 58e5729..974748b 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -182,8 +182,10 @@ static struct mxc_nand_platform_data imx31_3ds_nand_flash_pdata = {
 
 #define USBOTG_RST_B IOMUX_TO_GPIO(MX31_PIN_USB_PWR)
 
-static void mx31_3ds_usbotg_init(void)
+static int mx31_3ds_usbotg_init(void)
 {
+	int err;
+	
 	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA0, USB_PAD_CFG);
 	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA1, USB_PAD_CFG);
 	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA2, USB_PAD_CFG);
@@ -197,10 +199,25 @@ static void mx31_3ds_usbotg_init(void)
 	mxc_iomux_set_pad(MX31_PIN_USBOTG_NXT, USB_PAD_CFG);
 	mxc_iomux_set_pad(MX31_PIN_USBOTG_STP, USB_PAD_CFG);
 
-	gpio_request(USBOTG_RST_B, "otgusb-reset");
-	gpio_direction_output(USBOTG_RST_B, 0);
+	err = gpio_request(USBOTG_RST_B, "otgusb-reset");
+	if (err) {
+		pr_err("Failed to request the USB OTG reset gpio\n");
+		return err;
+	}
+
+	err = gpio_direction_output(USBOTG_RST_B, 0);
+	if (err) {
+		pr_err("Failed to drive the USB OTG reset gpio\n");
+		goto usbotg_free_reset;
+	}
+
 	mdelay(1);
 	gpio_set_value(USBOTG_RST_B, 1);
+	return 0;
+
+usbotg_free_reset:
+	gpio_free(USBOTG_RST_B);
+	return err;
 }
 
 static struct fsl_usb2_platform_data usbotg_pdata = {
-- 
1.6.0.4




      
