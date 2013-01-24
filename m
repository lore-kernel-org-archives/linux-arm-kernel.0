From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 24 Jan 2013 01:38:50 -0500
Subject: [V5 PATCH 26/26] usb: ehci: ehci-mv: add device tree support
In-Reply-To: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
References: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1359009530-28182-27-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All blocks are removed. Add the device tree support for ehci.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-mv.c |  105 +++++++++++++++++++++++++++++++++----------
 1 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 171e145..79eca0c 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/of.h>
 #include <linux/err.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/mv_usb2.h>
@@ -32,11 +33,9 @@ struct ehci_hcd_mv {
 
 	struct usb_phy *otg;
 
-	struct mv_usb_platform_data *pdata;
-
 	/* clock source and total clock number */
 	unsigned int clknum;
-	struct clk *clk[0];
+	struct clk **clk;
 };
 
 static void ehci_clock_enable(struct ehci_hcd_mv *ehci_mv)
@@ -138,22 +137,55 @@ static const struct hc_driver mv_ehci_hc_driver = {
 	.bus_resume = ehci_bus_resume,
 };
 
+static int mv_ehci_parse_dt(struct platform_device *pdev,
+				struct ehci_hcd_mv *ehci_mv)
+{
+	struct device_node *np = pdev->dev.of_node;
+	unsigned int clks_num;
+	int i, ret;
+	const char *clk_name;
+
+	if (!np)
+		return 1;
+
+	clks_num = of_property_count_strings(np, "clocks");
+	if (clks_num < 0)
+		return clks_num;
+
+	ehci_mv->clk = devm_kzalloc(&pdev->dev,
+		sizeof(struct clk *) * clks_num, GFP_KERNEL);
+	if (ehci_mv->clk == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < clks_num; i++) {
+		ret = of_property_read_string_index(np, "clocks", i,
+			&clk_name);
+		if (ret)
+			return ret;
+		ehci_mv->clk[i] = clk_get(NULL, clk_name);
+		if (IS_ERR(ehci_mv->clk[i]))
+			return PTR_ERR(ehci_mv->clk[i]);
+	}
+
+	ehci_mv->clknum = clks_num;
+
+	ret = of_property_read_u32(np, "mode", &ehci_mv->mode);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int mv_ehci_probe(struct platform_device *pdev)
 {
-	struct mv_usb_platform_data *pdata = pdev->dev.platform_data;
 	struct usb_hcd *hcd;
 	struct ehci_hcd *ehci;
 	struct ehci_hcd_mv *ehci_mv;
 	struct resource *r;
-	int clk_i, retval = -ENODEV;
+	int retval = -ENODEV;
 	u32 offset;
 	size_t size;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "missing platform_data\n");
-		return -ENODEV;
-	}
-
 	if (usb_disabled())
 		return -ENODEV;
 
@@ -161,7 +193,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	if (!hcd)
 		return -ENOMEM;
 
-	size = sizeof(*ehci_mv) + sizeof(struct clk *) * pdata->clknum;
+	size = sizeof(*ehci_mv);
 	ehci_mv = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
 	if (ehci_mv == NULL) {
 		dev_err(&pdev->dev, "cannot allocate ehci_hcd_mv\n");
@@ -170,19 +202,36 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, ehci_mv);
-	ehci_mv->pdata = pdata;
 	ehci_mv->hcd = hcd;
 
-	ehci_mv->clknum = pdata->clknum;
-	for (clk_i = 0; clk_i < ehci_mv->clknum; clk_i++) {
-		ehci_mv->clk[clk_i] =
-		    devm_clk_get(&pdev->dev, pdata->clkname[clk_i]);
-		if (IS_ERR(ehci_mv->clk[clk_i])) {
-			dev_err(&pdev->dev, "error get clck \"%s\"\n",
-				pdata->clkname[clk_i]);
-			retval = PTR_ERR(ehci_mv->clk[clk_i]);
-			goto err_clear_drvdata;
+	retval = mv_ehci_parse_dt(pdev, ehci_mv);
+	if (retval > 0) {
+		struct mv_usb_platform_data *pdata = pdev->dev.platform_data;
+		int clk_i = 0;
+
+		/* no CONFIG_OF */
+		if (pdata == NULL) {
+			dev_err(&pdev->dev, "missing platform_data\n");
+			return -ENODEV;
+		}
+		ehci_mv->mode = pdata->mode;
+		ehci_mv->clknum = pdata->clknum;
+
+		size = sizeof(struct clk *) * ehci_mv->clknum;
+		ehci_mv->clk = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+		if (ehci_mv->clk == NULL)
+			return -ENOMEM;
+		for (clk_i = 0; clk_i < ehci_mv->clknum; clk_i++) {
+			ehci_mv->clk[clk_i] = devm_clk_get(&pdev->dev,
+						pdata->clkname[clk_i]);
+			if (IS_ERR(ehci_mv->clk[clk_i])) {
+				retval = PTR_ERR(ehci_mv->clk[clk_i]);
+				return retval;
+			}
 		}
+	} else if (retval < 0) {
+		dev_err(&pdev->dev, "error parse dt\n");
+		return retval;
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -230,7 +279,6 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	ehci = hcd_to_ehci(hcd);
 	ehci->caps = (struct ehci_caps *) ehci_mv->cap_regs;
 
-	ehci_mv->mode = pdata->mode;
 	if (ehci_mv->mode == MV_USB_MODE_OTG) {
 #ifdef CONFIG_USB_OTG_UTILS
 		ehci_mv->otg = devm_usb_get_phy(&pdev->dev, USB_PHY_TYPE_USB2);
@@ -334,13 +382,20 @@ static void mv_ehci_shutdown(struct platform_device *pdev)
 		hcd->driver->shutdown(hcd);
 }
 
+static struct of_device_id mv_ehci_dt_ids[] = {
+	{ .compatible = "mrvl,mv-ehci" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mv_ehci_dt_ids);
+
 static struct platform_driver ehci_mv_driver = {
 	.probe = mv_ehci_probe,
 	.remove = mv_ehci_remove,
 	.shutdown = mv_ehci_shutdown,
 	.driver = {
-		   .name = "mv-ehci",
-		   .bus = &platform_bus_type,
-		   },
+		.name = "mv-ehci",
+		.bus = &platform_bus_type,
+		.of_match_table = mv_ehci_dt_ids,
+	},
 	.id_table = ehci_id_table,
 };
-- 
1.7.4.1
