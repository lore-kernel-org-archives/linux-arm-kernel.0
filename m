From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 22 Aug 2016 09:57:41 +0800
Subject: [PATCH v6] usb: ohci-at91: Forcibly suspend ports while USB suspend
Message-ID: <1471831061-24110-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usb controller does not manage correctly the suspend mode for
the ehci. In echi mode, there is no way to suspend without any
device connected to it. This is why this specific control is added
to fix this issue. Since the suspend mode works in ohci mode, this
specific control works by suspend the usb controller in ohci mode.

This specific control is by setting the SUSPEND_A/B/C fields of
SFR_OHCIICR(OHCI Interrupt Configuration Register) in the SFR
while the OHCI USB suspend.

This set operation must be done before the USB clock disabled,
clear operation after the USB clock enabled.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---

Changes in v6:
 - Set all the suspend bits for all the ports in the OHCIICR register
   at once, instead of port by port.
 - Amend the commit log for clearer.

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

 drivers/usb/host/ohci-at91.c | 63 +++++++++++++++++++++++++++++++++++++++++++-
 include/soc/at91/atmel-sfr.h | 14 ++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index d177372..1a26ed9 100644
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
 
+static int ohci_at91_port_ctrl(struct regmap *regmap, u8 set)
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
+		regval |= AT91_OHCIICR_USB_SUSPEND;
+	else
+		regval &= ~AT91_OHCIICR_USB_SUSPEND;
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
+			ohci_at91_port_ctrl(ohci_at91->sfr_regmap, 1);
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
+			ohci_at91_port_ctrl(ohci_at91->sfr_regmap, 0);
+			break;
 		}
 		break;
 	}
@@ -599,6 +653,9 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 	if (ohci_at91->wakeup)
 		enable_irq_wake(hcd->irq);
 
+	ohci_at91_hub_control(hcd, SetPortFeature,
+			      USB_PORT_FEAT_SUSPEND, 1, NULL, 0);
+
 	ret = ohci_suspend(hcd, ohci_at91->wakeup);
 	if (ret) {
 		if (ohci_at91->wakeup)
@@ -638,6 +695,10 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 	at91_start_clock(ohci_at91);
 
 	ohci_resume(hcd, false);
+
+	ohci_at91_hub_control(hcd, ClearPortFeature,
+			      USB_PORT_FEAT_SUSPEND, 1, NULL, 0);
+
 	return 0;
 }
 
diff --git a/include/soc/at91/atmel-sfr.h b/include/soc/at91/atmel-sfr.h
index 2f9bb98..faf41a5 100644
--- a/include/soc/at91/atmel-sfr.h
+++ b/include/soc/at91/atmel-sfr.h
@@ -13,6 +13,20 @@
 #ifndef _LINUX_MFD_SYSCON_ATMEL_SFR_H
 #define _LINUX_MFD_SYSCON_ATMEL_SFR_H
 
+#define AT91_SFR_DDRCFG		0x04	/* DDR Configuration Register */
+/* 0x08 ~ 0x0c: Reserved */
+#define AT91_SFR_OHCIICR	0x10	/* OHCI Interrupt Configuration Register */
+#define AT91_SFR_OHCIISR	0x14	/* OHCI Interrupt Status Register */
 #define AT91_SFR_I2SCLKSEL	0x90	/* I2SC Register */
 
+/* Field definitions */
+#define AT91_OHCIICR_SUSPEND_A	BIT(8)
+#define AT91_OHCIICR_SUSPEND_B	BIT(9)
+#define AT91_OHCIICR_SUSPEND_C	BIT(10)
+
+#define AT91_OHCIICR_USB_SUSPEND	(AT91_OHCIICR_SUSPEND_A | \
+					 AT91_OHCIICR_SUSPEND_B | \
+					 AT91_OHCIICR_SUSPEND_C)
+
+
 #endif /* _LINUX_MFD_SYSCON_ATMEL_SFR_H */
-- 
2.7.4
