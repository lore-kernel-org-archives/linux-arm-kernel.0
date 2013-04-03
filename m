From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 3 Apr 2013 18:23:51 +0530
Subject: [PATCH v5 3/6] usb: otg: twl4030: use the new generic PHY framework
In-Reply-To: <1364993634-6378-1-git-send-email-kishon@ti.com>
References: <1364993634-6378-1-git-send-email-kishon@ti.com>
Message-ID: <1364993634-6378-4-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Used the generic PHY framework API to create the PHY. twl4030_usb_suspend
and twl4030_usb_resume is added to phy_ops in order to align
with the new framework.

However using the old USB PHY library cannot be completely removed
because OTG is intertwined with PHY and moving to the new
framework completely will break OTG. Once we have a separate OTG state machine,
we can get rid of the USB PHY library.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/otg/twl4030-usb.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index a994715..6dab049 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -33,6 +33,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/usb/otg.h>
+#include <linux/phy/phy.h>
 #include <linux/usb/musb-omap.h>
 #include <linux/usb/ulpi.h>
 #include <linux/i2c/twl.h>
@@ -575,10 +576,39 @@ static int twl4030_set_host(struct usb_otg *otg, struct usb_bus *host)
 	return 0;
 }
 
+static int twl4030_usb_suspend(struct phy *phy)
+{
+	struct twl4030_usb *twl = dev_get_drvdata(&phy->dev);
+
+	twl4030_phy_suspend(twl, 1);
+
+	return 0;
+}
+
+static int twl4030_usb_resume(struct phy *phy)
+{
+	struct twl4030_usb *twl = dev_get_drvdata(&phy->dev);
+
+	if (!twl->asleep)
+		return -EBUSY;
+	__twl4030_phy_resume(twl);
+	twl->asleep = 0;
+
+	return 0;
+}
+
+static struct phy_ops ops = {
+	.suspend	= twl4030_usb_suspend,
+	.resume		= twl4030_usb_resume,
+	.of_xlate	= of_phy_xlate,
+	.owner		= THIS_MODULE,
+};
+
 static int twl4030_usb_probe(struct platform_device *pdev)
 {
 	struct twl4030_usb_data *pdata = pdev->dev.platform_data;
 	struct twl4030_usb	*twl;
+	struct phy		*phy;
 	int			status, err;
 	struct usb_otg		*otg;
 	struct device_node	*np = pdev->dev.of_node;
@@ -617,6 +647,13 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	otg->set_host		= twl4030_set_host;
 	otg->set_peripheral	= twl4030_set_peripheral;
 
+	phy = devm_phy_create(twl->dev, "twl4030", pdev->dev.of_node,
+		USB_PHY_TYPE_USB2, &ops, twl);
+	if (IS_ERR(phy)) {
+		dev_dbg(&pdev->dev, "Failed to create PHY\n");
+		return PTR_ERR(phy);
+	}
+
 	/* init spinlock for workqueue */
 	spin_lock_init(&twl->lock);
 
-- 
1.7.10.4
