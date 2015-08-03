From: albeu@free.fr (Alban Bedel)
Date: Mon,  3 Aug 2015 21:12:30 +0200
Subject: [PATCH] usb: ehci-platform: Fix using multiple controllers from OF
Message-ID: <1438629150-11662-1-git-send-email-albeu@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using OF defined controllers the platform data struct is shared
between all devices, so it can't be used for device specific settings.
However it is currently used for the OF properties
needs-reset-on-resume and has-transaction-translator.

To fix this issue move setting hcd->has_tt to the probe and
move pdata->reset_on_resume to the private data.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/usb/host/ehci-platform.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 2593def..40d029e 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -45,6 +45,7 @@ struct ehci_platform_priv {
 	struct reset_control *rst;
 	struct phy **phys;
 	int num_phys;
+	bool reset_on_resume;
 };
 
 static const char hcd_name[] = "ehci-platform";
@@ -56,7 +57,6 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
 	int retval;
 
-	hcd->has_tt = pdata->has_tt;
 	ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
 
 	if (pdata->pre_setup) {
@@ -193,11 +193,11 @@ static int ehci_platform_probe(struct platform_device *dev)
 
 		if (of_property_read_bool(dev->dev.of_node,
 					  "needs-reset-on-resume"))
-			pdata->reset_on_resume = 1;
+			priv->reset_on_resume = 1;
 
 		if (of_property_read_bool(dev->dev.of_node,
 					  "has-transaction-translator"))
-			pdata->has_tt = 1;
+			hcd->has_tt = 1;
 
 		priv->num_phys = of_count_phandle_with_args(dev->dev.of_node,
 				"phys", "#phy-cells");
@@ -247,6 +247,10 @@ static int ehci_platform_probe(struct platform_device *dev)
 		ehci->big_endian_desc = 1;
 	if (pdata->big_endian_mmio)
 		ehci->big_endian_mmio = 1;
+	if (pdata->has_tt)
+		hcd->has_tt = 1;
+	if (pdata->reset_on_resume)
+		priv->reset_on_resume = true;
 
 #ifndef CONFIG_USB_EHCI_BIG_ENDIAN_MMIO
 	if (ehci->big_endian_mmio) {
@@ -359,6 +363,7 @@ static int ehci_platform_resume(struct device *dev)
 	struct usb_ehci_pdata *pdata = dev_get_platdata(dev);
 	struct platform_device *pdev =
 		container_of(dev, struct platform_device, dev);
+	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
 
 	if (pdata->power_on) {
 		int err = pdata->power_on(pdev);
@@ -366,7 +371,7 @@ static int ehci_platform_resume(struct device *dev)
 			return err;
 	}
 
-	ehci_resume(hcd, pdata->reset_on_resume);
+	ehci_resume(hcd, priv->reset_on_resume);
 	return 0;
 }
 #endif /* CONFIG_PM_SLEEP */
-- 
2.0.0
