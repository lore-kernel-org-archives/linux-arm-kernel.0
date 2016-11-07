From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon,  7 Nov 2016 21:39:45 +0100
Subject: [PATCH v3 07/10] USB: ohci: da8xx: use a flag instead of mask for ocic
In-Reply-To: <20161107203948.28324-1-ahaslam@baylibre.com>
References: <20161107203948.28324-1-ahaslam@baylibre.com>
Message-ID: <20161107203948.28324-8-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the platform callback is removed, we can move the over
current indictor changed flag to the private data structure.

Since the driver only handles a single port, there is no need
for ocic to be a mask, we can use a simple flag instead.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 3dcbf1f..83b182e 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -43,12 +43,10 @@ struct da8xx_ohci_hcd {
 	struct regulator *vbus_reg;
 	struct notifier_block nb;
 	unsigned int is_powered;
+	unsigned int oc_changed;
 };
 #define to_da8xx_ohci(hcd) (struct da8xx_ohci_hcd *)(hcd_to_ohci(hcd)->priv)
 
-/* Over-current indicator change bitmask */
-static volatile u16 ocic_mask;
-
 static int ohci_da8xx_enable(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
@@ -168,7 +166,7 @@ static int ohci_da8xx_regulator_event(struct notifier_block *nb,
 
 	if (event & REGULATOR_EVENT_OVER_CURRENT) {
 		dev_warn(dev, "over current event\n");
-		ocic_mask |= 1;
+		da8xx_ohci->oc_changed = 1;
 		ohci_da8xx_set_power(da8xx_ohci->hcd, 0);
 	}
 
@@ -241,10 +239,11 @@ static int ohci_da8xx_reset(struct usb_hcd *hcd)
  */
 static int ohci_da8xx_hub_status_data(struct usb_hcd *hcd, char *buf)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	int length		= orig_ohci_hub_status_data(hcd, buf);
 
 	/* See if we have OCIC bit set on port 1 */
-	if (ocic_mask & (1 << 1)) {
+	if (da8xx_ohci->oc_changed) {
 		dev_dbg(hcd->self.controller, "over-current indicator change "
 			"on port 1\n");
 
@@ -262,6 +261,7 @@ static int ohci_da8xx_hub_status_data(struct usb_hcd *hcd, char *buf)
 static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				  u16 wIndex, char *buf, u16 wLength)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	struct device *dev		= hcd->self.controller;
 	int temp;
 
@@ -284,7 +284,7 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			temp |=  RH_PS_POCI;
 
 		/* The over-current indicator change (OCIC) bit is 0 too */
-		if (ocic_mask & (1 << wIndex))
+		if (da8xx_ohci->oc_changed)
 			temp |=  RH_PS_OCIC;
 
 		put_unaligned(cpu_to_le32(temp), (__le32 *)buf);
@@ -311,10 +311,7 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				temp ? "Set" : "Clear", wIndex,
 				"C_OVER_CURRENT");
 
-			if (temp)
-				ocic_mask |= 1 << wIndex;
-			else
-				ocic_mask &= ~(1 << wIndex);
+			da8xx_ohci->oc_changed = temp;
 			return 0;
 		}
 	}
-- 
2.10.1
