From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Oct 2013 13:58:40 +0800
Subject: [Patch v2 06/14] usb: phy-mxs: Add anatop regmap
In-Reply-To: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
References: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382421528-17897-7-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is needed by mx6 SoC serial, but not for mx23 and mx28.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 87ba429..6d48bde 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -21,6 +21,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #define DRIVER_NAME "mxs_phy"
 
@@ -52,6 +54,7 @@ struct mxs_phy {
 	struct usb_phy phy;
 	struct clk *clk;
 	enum imx_phy_type devtype;
+	struct regmap *regmap_anatop;
 };
 
 static inline int is_mx6q_phy(struct mxs_phy *data)
@@ -193,9 +196,10 @@ static int mxs_phy_probe(struct platform_device *pdev)
 	int ret;
 	const struct of_device_id *of_id =
 			of_match_device(mxs_phy_dt_ids, &pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
 
 	/* This driver is DT-only version now */
-	if (!of_id)
+	if (!of_id || !np)
 		return -ENXIO;
 
 	pdev->id_entry = of_id->data;
@@ -218,6 +222,17 @@ static int mxs_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	/* Some SoCs don't have anatop registers */
+	if (of_get_property(np, "fsl,anatop", NULL)) {
+		mxs_phy->regmap_anatop = syscon_regmap_lookup_by_phandle
+			(np, "fsl,anatop");
+		if (IS_ERR(mxs_phy->regmap_anatop)) {
+			dev_dbg(&pdev->dev,
+				"failed to find regmap for anatop\n");
+			return PTR_ERR(mxs_phy->regmap_anatop);
+		}
+	}
+
 	mxs_phy->phy.io_priv		= base;
 	mxs_phy->phy.dev		= &pdev->dev;
 	mxs_phy->phy.label		= DRIVER_NAME;
-- 
1.7.1
