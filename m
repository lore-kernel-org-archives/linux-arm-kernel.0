From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 9 Aug 2017 17:17:59 +0800
Subject: [PATCH 3/4] phy: ti: use of_device_get_match_data()
In-Reply-To: <1502270280-13792-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1502270280-13792-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1502270280-13792-3-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reduce the boilerplate code to get the specific data

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/ti/phy-omap-usb2.c |   11 ++++-------
 drivers/phy/ti/phy-ti-pipe3.c  |    8 ++------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index fe909fd..70375b1 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -31,6 +31,7 @@
 #include <linux/phy/phy.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/of_device.h>
 #include <linux/of_platform.h>
 
 #define USB2PHY_DISCON_BYP_LATCH (1 << 31)
@@ -280,16 +281,12 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *control_node;
 	struct platform_device *control_pdev;
-	const struct of_device_id *of_id;
-	struct usb_phy_data *phy_data;
+	const struct usb_phy_data *phy_data;
 
-	of_id = of_match_device(omap_usb2_id_table, &pdev->dev);
-
-	if (!of_id)
+	phy_data = of_device_get_match_data(&pdev->dev);
+	if (!phy_data)
 		return -EINVAL;
 
-	phy_data = (struct usb_phy_data *)of_id->data;
-
 	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index 9c84d32..063ab2e 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -27,6 +27,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
 #include <linux/phy/omap_control_phy.h>
+#include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
@@ -516,7 +517,6 @@ static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 static int ti_pipe3_get_pll_base(struct ti_pipe3 *phy)
 {
 	struct resource *res;
-	const struct of_device_id *match;
 	struct device *dev = phy->dev;
 	struct device_node *node = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
@@ -524,11 +524,7 @@ static int ti_pipe3_get_pll_base(struct ti_pipe3 *phy)
 	if (of_device_is_compatible(node, "ti,phy-pipe3-pcie"))
 		return 0;
 
-	match = of_match_device(ti_pipe3_id_table, dev);
-	if (!match)
-		return -EINVAL;
-
-	phy->dpll_map = (struct pipe3_dpll_map *)match->data;
+	phy->dpll_map = of_device_get_match_data(dev);
 	if (!phy->dpll_map) {
 		dev_err(dev, "no DPLL data\n");
 		return -EINVAL;
-- 
1.7.9.5
