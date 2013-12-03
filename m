From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 3 Dec 2013 15:37:00 +0800
Subject: [PATCH v4 06/17] usb: phy-mxs: Add anatop regmap
In-Reply-To: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
References: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1386056231-17258-7-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is needed by imx6 SoC series, but not for imx23 and imx28.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 70b084d..d34df4c 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -21,6 +21,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #define DRIVER_NAME "mxs_phy"
 
@@ -58,6 +60,9 @@
  */
 #define MXS_PHY_SENDING_SOF_TOO_FAST		BIT(2)
 
+/* The SoCs who have anatop module */
+#define MXS_PHY_HAS_ANATOP			BIT(3)
+
 struct mxs_phy_data {
 	unsigned int flags;
 };
@@ -68,11 +73,13 @@ static const struct mxs_phy_data imx23_phy_data = {
 
 static const struct mxs_phy_data imx6q_phy_data = {
 	.flags = MXS_PHY_SENDING_SOF_TOO_FAST |
-		MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS,
+		MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS |
+		MXS_PHY_HAS_ANATOP,
 };
 
 static const struct mxs_phy_data imx6sl_phy_data = {
-	.flags = MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS,
+	.flags = MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS |
+		MXS_PHY_HAS_ANATOP,
 };
 
 static const struct of_device_id mxs_phy_dt_ids[] = {
@@ -87,6 +94,7 @@ struct mxs_phy {
 	struct usb_phy phy;
 	struct clk *clk;
 	const struct mxs_phy_data *data;
+	struct regmap *regmap_anatop;
 };
 
 static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
@@ -190,6 +198,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 	int ret;
 	const struct of_device_id *of_id =
 			of_match_device(mxs_phy_dt_ids, &pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
@@ -226,6 +235,16 @@ static int mxs_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mxs_phy);
 
+	if (mxs_phy->data->flags & MXS_PHY_HAS_ANATOP) {
+		mxs_phy->regmap_anatop = syscon_regmap_lookup_by_phandle
+			(np, "fsl,anatop");
+		if (IS_ERR(mxs_phy->regmap_anatop)) {
+			dev_dbg(&pdev->dev,
+				"failed to find regmap for anatop\n");
+			return PTR_ERR(mxs_phy->regmap_anatop);
+		}
+	}
+
 	ret = usb_add_phy_dev(&mxs_phy->phy);
 	if (ret)
 		return ret;
-- 
1.7.8
