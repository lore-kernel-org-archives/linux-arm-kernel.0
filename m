From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Fri, 20 Mar 2015 14:07:10 -0700
Subject: [PATCH 3/3] usb: ohci-platform: Use devm_of_phy_get_by_index
In-Reply-To: <1426885630-32429-1-git-send-email-arun.ramamurthy@broadcom.com>
References: <1426885630-32429-1-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <1426885630-32429-4-git-send-email-arun.ramamurthy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Getting phys by index instead of phy names so that the dt
bindings phy-names remain consistent when multiple phys are present

Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
---
 drivers/usb/host/ohci-platform.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 185ceee..8b2ec4e 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -123,7 +123,6 @@ static int ohci_platform_probe(struct platform_device *dev)
 	struct usb_ohci_pdata *pdata = dev_get_platdata(&dev->dev);
 	struct ohci_platform_priv *priv;
 	struct ohci_hcd *ohci;
-	const char *phy_name;
 	int err, irq, phy_num, clk = 0;
 
 	if (usb_disabled())
@@ -182,21 +181,10 @@ static int ohci_platform_probe(struct platform_device *dev)
 			return -ENOMEM;
 
 		for (phy_num = 0; phy_num < priv->num_phys; phy_num++) {
-				err = of_property_read_string_index(
-						dev->dev.of_node,
-						"phy-names", phy_num,
-						&phy_name);
-
-				if (err < 0) {
-					if (priv->num_phys > 1) {
-						dev_err(&dev->dev, "phy-names not provided");
-						goto err_put_hcd;
-					} else
-						phy_name = "usb";
-				}
-
-				priv->phys[phy_num] = devm_phy_get(&dev->dev,
-						phy_name);
+				priv->phys[phy_num] =
+					devm_of_phy_get_by_index(&dev->dev,
+							dev->dev.of_node,
+							phy_num);
 				if (IS_ERR(priv->phys[phy_num])) {
 					err = PTR_ERR(priv->phys[phy_num]);
 					if ((priv->num_phys > 1) ||
-- 
2.3.2
