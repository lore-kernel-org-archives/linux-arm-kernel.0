From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 4 Aug 2016 12:23:32 +0800
Subject: [PATCH v5] usb: ohci-at91: Forcibly suspend ports while USB suspend
Message-ID: <1470284612-3336-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usb controller does not managed correctly the suspend mode for
the ehci. In echi mode, there is no way to have utmi_suspend_o_n[1]
suspend without any device connected to it. This is why this specific
control is added to fix this issue. The suspend mode works in ohci
mode.

This specific control is by setting the SUSPEND_A/B/C fields of
SFR_OHCIICR(OHCI Interrupt Configuration Register) in the SFR
while OHCI USB suspend.

This setting operation must be done before the USB clock disabled,
clear them after the USB clock enabled.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---

Changes in v5:
 - Use the USB_PORT_FEAT_SUSPEND subcase of the SetPortFeature case
   to take care it.
 - Update the commit log.

Changes in v4:
 - To check whether the SFR node with "atmel,sama5d2-sfr" compatible
   is present or not to decide if this feature is applied or not
   when USB OHCI suspend/resume, instead of new compatible.
 - Drop the compatible "atmel,sama5d2-ohci".
 - Drop [PATCH 2/2] ARM: at91/dt: sama5d2: Use new compatible for
   ohci node.
 - Drop include/soc/at91/at91_sfr.h, move the macro definitions to
   atmel-sfr.h which already exists.
 - Change the defines to align the exists.

Changes in v3:
 - Change the compatible description for more precise.

Changes in v2:
 - Add compatible to support forcibly suspend the ports.
 - Add soc/at91/at91_sfr.h to accommodate the defines.
 - Add error checking for .sfr_regmap.
 - Remove unnecessary regmap_read() statement.

 drivers/usb/host/ohci-at91.c | 72 ++++++++++++++++++++++++++++++++++++++++++--
 include/soc/at91/atmel-sfr.h |  3 ++
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index d177372..4d7d7a0 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -21,8 +21,11 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
+#include <soc/at91/atmel-sfr.h>
 
 #include "ohci.h"
 
@@ -51,6 +54,7 @@ struct ohci_at91_priv {
 	struct clk *hclk;
 	bool clocked;
 	bool wakeup;		/* Saved wake-up state for resume */
+	struct regmap *sfr_regmap;
 };
 /* interface and function clocks; sometimes also an AHB clock */
 
@@ -134,6 +138,17 @@ static void at91_stop_hc(struct platform_device *pdev)
 
 static void usb_hcd_at91_remove (struct usb_hcd *, struct platform_device *);
 
+struct regmap *at91_dt_syscon_sfr(void)
+{
+	struct regmap *regmap;
+
+	regmap = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
+	if (IS_ERR(regmap))
+		regmap = NULL;
+
+	return regmap;
+}
+
 /* configure so an HC device and id are always provided */
 /* always called with process context; sleeping is OK */
 
@@ -197,6 +212,10 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 		goto err;
 	}
 
+	ohci_at91->sfr_regmap = at91_dt_syscon_sfr();
+	if (!ohci_at91->sfr_regmap)
+		dev_warn(dev, "failed to find sfr node\n");
+
 	board = hcd->self.controller->platform_data;
 	ohci = hcd_to_ohci(hcd);
 	ohci->num_ports = board->ports;
@@ -282,6 +301,28 @@ static int ohci_at91_hub_status_data(struct usb_hcd *hcd, char *buf)
 	return length;
 }
 
+static int ohci_at91_port_ctrl(struct regmap *regmap, u16 port, u8 set)
+{
+	u32 regval;
+	int ret;
+
+	if (!regmap)
+		return 0;
+
+	ret = regmap_read(regmap, AT91_SFR_OHCIICR, &regval);
+	if (ret)
+		return ret;
+
+	if (set)
+		regval |= AT91_OHCIICR_SUSPEND(port);
+	else
+		regval &= ~AT91_OHCIICR_SUSPEND(port);
+
+	regmap_write(regmap, AT91_SFR_OHCIICR, regval);
+
+	return 0;
+}
+
 /*
  * Look at the control requests to the root hub and see if we need to override.
  */
@@ -289,6 +330,7 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				 u16 wIndex, char *buf, u16 wLength)
 {
 	struct at91_usbh_data *pdata = dev_get_platdata(hcd->self.controller);
+	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
 	struct usb_hub_descriptor *desc;
 	int ret = -EINVAL;
 	u32 *data = (u32 *)buf;
@@ -301,7 +343,8 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 	switch (typeReq) {
 	case SetPortFeature:
-		if (wValue == USB_PORT_FEAT_POWER) {
+		switch (wValue) {
+		case USB_PORT_FEAT_POWER:
 			dev_dbg(hcd->self.controller, "SetPortFeat: POWER\n");
 			if (valid_port(wIndex)) {
 				ohci_at91_usb_set_power(pdata, wIndex, 1);
@@ -309,6 +352,11 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			}
 
 			goto out;
+
+		case USB_PORT_FEAT_SUSPEND:
+			dev_dbg(hcd->self.controller, "SetPortFeat: SUSPEND\n");
+			ohci_at91_port_ctrl(ohci_at91->sfr_regmap, wIndex, 1);
+			break;
 		}
 		break;
 
@@ -342,6 +390,12 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				ohci_at91_usb_set_power(pdata, wIndex, 0);
 				return 0;
 			}
+			break;
+
+		case USB_PORT_FEAT_SUSPEND:
+			dev_dbg(hcd->self.controller, "ClearPortFeature: SUSPEND\n");
+			ohci_at91_port_ctrl(ohci_at91->sfr_regmap, wIndex, 0);
+			break;
 		}
 		break;
 	}
@@ -587,7 +641,8 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
 	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
-	int		ret;
+	u16 i;
+	int ret;
 
 	/*
 	 * Disable wakeup if we are going to sleep with slow clock mode
@@ -599,6 +654,11 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 	if (ohci_at91->wakeup)
 		enable_irq_wake(hcd->irq);
 
+	for (i = 0; i < ohci->num_ports; i++) {
+		ohci_at91_hub_control(hcd, SetPortFeature,
+				      USB_PORT_FEAT_SUSPEND, (i + 1), NULL, 0);
+	}
+
 	ret = ohci_suspend(hcd, ohci_at91->wakeup);
 	if (ret) {
 		if (ohci_at91->wakeup)
@@ -630,7 +690,9 @@ static int __maybe_unused
 ohci_hcd_at91_drv_resume(struct device *dev)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
+	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
 	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
+	u16 i;
 
 	if (ohci_at91->wakeup)
 		disable_irq_wake(hcd->irq);
@@ -638,6 +700,12 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 	at91_start_clock(ohci_at91);
 
 	ohci_resume(hcd, false);
+
+	for (i = 0; i < ohci->num_ports; i++) {
+		ohci_at91_hub_control(hcd, ClearPortFeature,
+				      USB_PORT_FEAT_SUSPEND, i + 1, NULL, 0);
+	}
+
 	return 0;
 }
 
diff --git a/include/soc/at91/atmel-sfr.h b/include/soc/at91/atmel-sfr.h
index 2f9bb98..c1abf09 100644
--- a/include/soc/at91/atmel-sfr.h
+++ b/include/soc/at91/atmel-sfr.h
@@ -13,6 +13,9 @@
 #ifndef _LINUX_MFD_SYSCON_ATMEL_SFR_H
 #define _LINUX_MFD_SYSCON_ATMEL_SFR_H
 
+#define AT91_SFR_OHCIICR	0x10	/* OHCI Interrupt Configuration Register */
 #define AT91_SFR_I2SCLKSEL	0x90	/* I2SC Register */
 
+#define AT91_OHCIICR_SUSPEND(port)	BIT(8 + port)
+
 #endif /* _LINUX_MFD_SYSCON_ATMEL_SFR_H */
-- 
2.7.4
