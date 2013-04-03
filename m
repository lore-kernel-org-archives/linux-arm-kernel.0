From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 3 Apr 2013 18:23:50 +0530
Subject: [PATCH v5 2/6] usb: phy: omap-usb2: use the new generic PHY framework
In-Reply-To: <1364993634-6378-1-git-send-email-kishon@ti.com>
References: <1364993634-6378-1-git-send-email-kishon@ti.com>
Message-ID: <1364993634-6378-3-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Used the generic PHY framework API to create the PHY. omap_usb2_suspend
is split into omap_usb_suspend and omap_usb_resume in order to align
with the new framework.

However using the old USB PHY library cannot be completely removed
because OTG is intertwined with PHY and moving to the new framework
will break OTG. Once we have a separate OTG state machine, we
can get rid of the USB PHY library.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/phy/omap-usb2.c |   48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/usb/phy/omap-usb2.c b/drivers/usb/phy/omap-usb2.c
index 844ab68..4e48db4 100644
--- a/drivers/usb/phy/omap-usb2.c
+++ b/drivers/usb/phy/omap-usb2.c
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
 #include <linux/usb/omap_control_usb.h>
+#include <linux/phy/phy.h>
 
 /**
  * omap_usb2_set_comparator - links the comparator present in the sytem with
@@ -119,9 +120,49 @@ static int omap_usb2_suspend(struct usb_phy *x, int suspend)
 	return 0;
 }
 
+static int omap_usb_suspend(struct phy *x)
+{
+	struct omap_usb *phy = dev_get_drvdata(&x->dev);
+
+	if (!phy->is_suspended) {
+		omap_control_usb_phy_power(phy->control_dev, 0);
+		pm_runtime_put_sync(phy->dev);
+		phy->is_suspended = 1;
+	}
+
+	return 0;
+}
+
+static int omap_usb_resume(struct phy *x)
+{
+	u32 ret;
+	struct omap_usb *phy = dev_get_drvdata(&x->dev);
+
+	if (phy->is_suspended) {
+		ret = pm_runtime_get_sync(phy->dev);
+		if (ret < 0) {
+			dev_err(phy->dev, "get_sync failed with err %d\n",
+									ret);
+			return ret;
+		}
+		omap_control_usb_phy_power(phy->control_dev, 1);
+		phy->is_suspended = 0;
+	}
+
+	return 0;
+}
+
+static struct phy_ops ops = {
+	.suspend	= omap_usb_suspend,
+	.resume		= omap_usb_resume,
+	.of_xlate	= of_phy_xlate,
+	.owner		= THIS_MODULE,
+};
+
 static int omap_usb2_probe(struct platform_device *pdev)
 {
 	struct omap_usb			*phy;
+	struct phy			*generic_phy;
 	struct usb_otg			*otg;
 
 	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
@@ -144,6 +185,13 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	phy->phy.otg		= otg;
 	phy->phy.type		= USB_PHY_TYPE_USB2;
 
+	generic_phy = devm_phy_create(phy->dev, "omap-usb2", pdev->dev.of_node,
+		USB_PHY_TYPE_USB2, &ops, phy);
+	if (IS_ERR(generic_phy)) {
+		dev_dbg(&pdev->dev, "Failed to create PHY\n");
+		return PTR_ERR(generic_phy);
+	}
+
 	phy->control_dev = omap_get_control_dev();
 	if (IS_ERR(phy->control_dev)) {
 		dev_dbg(&pdev->dev, "Failed to get control device\n");
-- 
1.7.10.4
