From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 14 Sep 2012 11:22:45 +0800
Subject: [PATCH 3/4] usb: chipidea: add phy notify at suspend/resume procedure
Message-ID: <1347592965-13116-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When there is a device at the port, it needs to notify PHY
driver bus's status during bus suspend/resume procedure
for some freescale i.mx SoC (i.mx23, i.mx28, i.mx6).

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/host.c |   75 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index ebff9f4..74a6d57 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -23,6 +23,7 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/usb/chipidea.h>
+#include <linux/usb/otg.h>
 
 #define CHIPIDEA_EHCI
 #include "../host/ehci-hcd.c"
@@ -46,6 +47,76 @@ static int ci_ehci_setup(struct usb_hcd *hcd)
 
 	return ret;
 }
+static enum usb_device_speed ci_get_device_speed(struct ehci_hcd *ehci,
+						u32 portsc)
+{
+	if (ehci_is_TDI(ehci)) {
+		switch ((portsc >> (ehci->has_hostpc ? 25 : 26)) & 3) {
+		case 0:
+			return USB_SPEED_FULL;
+		case 1:
+			return USB_SPEED_LOW;
+		case 2:
+			return USB_SPEED_HIGH;
+		default:
+			return USB_SPEED_UNKNOWN;
+		}
+	} else {
+		return USB_SPEED_HIGH;
+	}
+}
+
+static int ci_bus_suspend(struct usb_hcd *hcd)
+{
+	int ret;
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	int port;
+
+	ret = ehci_bus_suspend(hcd);
+	if (ret)
+		return ret;
+
+	port = HCS_N_PORTS(ehci->hcs_params);
+	while (port--) {
+		u32 __iomem *reg = &ehci->regs->port_status[port];
+		u32 portsc = ehci_readl(ehci, reg);
+
+		if (portsc & PORT_CONNECT) {
+			enum usb_device_speed speed;
+			speed = ci_get_device_speed(ehci, portsc);
+			/* notify the USB PHY */
+			if (hcd->phy)
+				usb_phy_notify_suspend(hcd->phy, speed);
+		}
+	}
+
+	return ret;
+}
+
+static int ci_bus_resume(struct usb_hcd *hcd)
+{
+	int ret;
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	int port;
+
+	ret = ehci_bus_resume(hcd);
+
+	port = HCS_N_PORTS(ehci->hcs_params);
+	while (port--) {
+		u32 __iomem *reg = &ehci->regs->port_status[port];
+		u32 portsc = ehci_readl(ehci, reg);
+
+		if (portsc & PORT_CONNECT) {
+			enum usb_device_speed speed;
+			speed = ci_get_device_speed(ehci, portsc);
+			/* notify the USB PHY */
+			if (hcd->phy)
+				usb_phy_notify_resume(hcd->phy, speed);
+		}
+	}
+
+	return ret;
+}
 
 static const struct hc_driver ci_ehci_hc_driver = {
 	.description	= "ehci_hcd",
@@ -84,8 +155,8 @@ static const struct hc_driver ci_ehci_hc_driver = {
 	 */
 	.hub_status_data	= ehci_hub_status_data,
 	.hub_control		= ehci_hub_control,
-	.bus_suspend		= ehci_bus_suspend,
-	.bus_resume		= ehci_bus_resume,
+	.bus_suspend		= ci_bus_suspend,
+	.bus_resume		= ci_bus_resume,
 	.relinquish_port	= ehci_relinquish_port,
 	.port_handed_over	= ehci_port_handed_over,
 
-- 
1.7.0.4
