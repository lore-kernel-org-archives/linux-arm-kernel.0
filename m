From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 14 Apr 2014 14:25:58 +0200
Subject: [PATCH/RFC 2/3] USB: ohci-pxa27x: Add support for external vbus
 regulators
In-Reply-To: <1397478359-22541-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1397478359-22541-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1397478359-22541-3-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Override the hub control operation to enable and disable external
regulators for the ports vbus power supply in response to clear/set
USB_PORT_FEAT_POWER requests.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/usb/host/ohci-pxa27x.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index d21d5fe..0c31265 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -30,6 +30,7 @@
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/usb-pxa3xx-ulpi.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/signal.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
@@ -120,6 +121,8 @@ static struct hc_driver __read_mostly ohci_pxa27x_hc_driver;
 struct pxa27x_ohci {
 	struct clk	*clk;
 	void __iomem	*mmio_base;
+	struct regulator *vbus[3];
+	bool		vbus_enabled[3];
 };
 
 #define to_pxa27x_ohci(hcd)	(struct pxa27x_ohci *)(hcd_to_ohci(hcd)->priv)
@@ -166,6 +169,52 @@ static int pxa27x_ohci_select_pmm(struct pxa27x_ohci *pxa_ohci, int mode)
 	return 0;
 }
 
+static int pxa27x_ohci_set_vbus_power(struct pxa27x_ohci *pxa_ohci,
+				      unsigned int port, bool enable)
+{
+	struct regulator *vbus = pxa_ohci->vbus[port];
+	int ret = 0;
+
+	if (IS_ERR_OR_NULL(vbus))
+		return 0;
+
+	if (enable && !pxa_ohci->vbus_enabled[port])
+		ret = regulator_enable(vbus);
+	else if (!enable && pxa_ohci->vbus_enabled[port])
+		ret = regulator_disable(vbus);
+
+	if (ret < 0)
+		return ret;
+
+	pxa_ohci->vbus_enabled[port] = enable;
+
+	return 0;
+}
+
+static int pxa27x_ohci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
+				   u16 wIndex, char *buf, u16 wLength)
+{
+	struct pxa27x_ohci *pxa_ohci = to_pxa27x_ohci(hcd);
+	int ret;
+
+	switch (typeReq) {
+	case SetPortFeature:
+	case ClearPortFeature:
+		if (!wIndex || wIndex > 3)
+			return -EPIPE;
+
+		if (wValue != USB_PORT_FEAT_POWER)
+			break;
+
+		ret = pxa27x_ohci_set_vbus_power(pxa_ohci, wIndex - 1,
+						 typeReq == SetPortFeature);
+		if (ret)
+			return ret;
+		break;
+	}
+
+	return ohci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
+}
 /*-------------------------------------------------------------------------*/
 
 static inline void pxa27x_setup_hc(struct pxa27x_ohci *pxa_ohci,
@@ -372,6 +421,7 @@ int usb_hcd_pxa27x_probe (const struct hc_driver *driver, struct platform_device
 	struct ohci_hcd *ohci;
 	struct resource *r;
 	struct clk *usb_clk;
+	unsigned int i;
 
 	retval = ohci_pxa_of_init(pdev);
 	if (retval)
@@ -417,6 +467,16 @@ int usb_hcd_pxa27x_probe (const struct hc_driver *driver, struct platform_device
 	pxa_ohci->clk = usb_clk;
 	pxa_ohci->mmio_base = (void __iomem *)hcd->regs;
 
+	for (i = 0; i < 3; ++i) {
+		char name[6];
+
+		if (!(inf->flags & (ENABLE_PORT1 << i)))
+			continue;
+
+		sprintf(name, "vbus%u", i + 1);
+		pxa_ohci->vbus[i] = devm_regulator_get(&pdev->dev, name);
+	}
+
 	retval = pxa27x_start_hc(pxa_ohci, &pdev->dev);
 	if (retval < 0) {
 		pr_debug("pxa27x_start_hc failed");
@@ -462,6 +522,10 @@ int usb_hcd_pxa27x_probe (const struct hc_driver *driver, struct platform_device
 void usb_hcd_pxa27x_remove (struct usb_hcd *hcd, struct platform_device *pdev)
 {
 	struct pxa27x_ohci *pxa_ohci = to_pxa27x_ohci(hcd);
+	unsigned int i;
+
+	for (i = 0; i < 3; ++i)
+		pxa27x_ohci_set_vbus_power(pxa_ohci, i, false);
 
 	usb_remove_hcd(hcd);
 	pxa27x_stop_hc(pxa_ohci, &pdev->dev);
@@ -563,7 +627,10 @@ static int __init ohci_pxa27x_init(void)
 		return -ENODEV;
 
 	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+
 	ohci_init_driver(&ohci_pxa27x_hc_driver, &pxa27x_overrides);
+	ohci_pxa27x_hc_driver.hub_control = pxa27x_ohci_hub_control;
+
 	return platform_driver_register(&ohci_hcd_pxa27x_driver);
 }
 module_init(ohci_pxa27x_init);
-- 
1.8.3.2
