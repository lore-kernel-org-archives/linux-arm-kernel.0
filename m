From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 24 Jan 2013 01:38:49 -0500
Subject: [V5 PATCH 25/26] usb: otg: mv_otg: add device tree support
In-Reply-To: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
References: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1359009530-28182-26-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All blocks are removed. Add the device tree support for otg.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/otg/mv_otg.c |  128 +++++++++++++++++++++++++++++++++++++--------
 drivers/usb/otg/mv_otg.h |    6 +-
 2 files changed, 108 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/otg/mv_otg.c b/drivers/usb/otg/mv_otg.c
index 379df92..3aa7fdc 100644
--- a/drivers/usb/otg/mv_otg.c
+++ b/drivers/usb/otg/mv_otg.c
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/proc_fs.h>
 #include <linux/clk.h>
+#include <linux/of.h>
 #include <linux/workqueue.h>
 #include <linux/platform_device.h>
 
@@ -333,7 +334,7 @@ static void mv_otg_update_inputs(struct mv_otg *mvotg)
 	else
 		otg_ctrl->id = !!(otgsc & OTGSC_STS_USB_ID);
 
-	if (mvotg->pdata->otg_force_a_bus_req && !otg_ctrl->id)
+	if (mvotg->otg_force_a_bus_req && !otg_ctrl->id)
 		otg_ctrl->a_bus_req = 1;
 
 	otg_ctrl->a_sess_vld = !!(otgsc & OTGSC_STS_A_SESSION_VALID);
@@ -690,21 +691,69 @@ int mv_otg_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int mv_otg_parse_dt(struct platform_device *pdev,
+				struct mv_otg *mvotg)
+{
+	struct device_node *np = pdev->dev.of_node;
+	unsigned int clks_num;
+	unsigned int val;
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
+	mvotg->clk = devm_kzalloc(&pdev->dev,
+		sizeof(struct clk *) * clks_num, GFP_KERNEL);
+	if (mvotg->clk == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < clks_num; i++) {
+		ret = of_property_read_string_index(np, "clocks", i,
+			&clk_name);
+		if (ret)
+			return ret;
+		mvotg->clk[i] = devm_clk_get(&pdev->dev, clk_name);
+		if (IS_ERR(mvotg->clk[i]))
+			return PTR_ERR(mvotg->clk[i]);
+	}
+
+	mvotg->clknum = clks_num;
+
+	ret = of_property_read_u32(np, "extern_attr", &mvotg->extern_attr);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(np, "mode", &mvotg->mode);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(np, "force_a_bus_req", &val);
+	if (ret)
+		return ret;
+	mvotg->otg_force_a_bus_req = !!val;
+
+	ret = of_property_read_u32(np, "disable_clock_gating", &val);
+	if (ret)
+		return ret;
+	mvotg->clock_gating = !val;
+
+	return 0;
+}
+
 static int mv_otg_probe(struct platform_device *pdev)
 {
-	struct mv_usb_platform_data *pdata = pdev->dev.platform_data;
 	struct mv_otg *mvotg;
 	struct usb_otg *otg;
 	struct resource *r;
-	int retval = 0, clk_i, i;
+	int retval = 0, i;
 	size_t size;
 
-	if (pdata == NULL) {
-		dev_err(&pdev->dev, "failed to get platform data\n");
-		return -ENODEV;
-	}
-
-	size = sizeof(*mvotg) + sizeof(struct clk *) * pdata->clknum;
+	size = sizeof(*mvotg);
 	mvotg = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
 	if (!mvotg) {
 		dev_err(&pdev->dev, "failed to allocate memory!\n");
@@ -718,17 +767,45 @@ static int mv_otg_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mvotg);
 
 	mvotg->pdev = pdev;
-	mvotg->extern_attr = pdata->extern_attr;
-	mvotg->pdata = pdata;
 
-	mvotg->clknum = pdata->clknum;
-	for (clk_i = 0; clk_i < mvotg->clknum; clk_i++) {
-		mvotg->clk[clk_i] = devm_clk_get(&pdev->dev,
+	retval = mv_otg_parse_dt(pdev, mvotg);
+	if (retval > 0) {
+		struct mv_usb_platform_data *pdata = pdev->dev.platform_data;
+		/* no CONFIG_OF */
+		int clk_i = 0;
+
+		if (pdata == NULL) {
+			dev_err(&pdev->dev, "missing platform_data\n");
+			return -ENODEV;
+		}
+		mvotg->extern_attr = pdata->extern_attr;
+		mvotg->mode = pdata->mode;
+		mvotg->clknum = pdata->clknum;
+		mvotg->otg_force_a_bus_req = pdata->otg_force_a_bus_req;
+		if (pdata->disable_otg_clock_gating)
+			mvotg->clock_gating = 0;
+
+		size = sizeof(struct clk *) * mvotg->clknum;
+		mvotg->clk = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+		if (mvotg->clk == NULL) {
+			dev_err(&pdev->dev,
+				"failed to allocate memory for clk\n");
+			return -ENOMEM;
+		}
+
+		for (clk_i = 0; clk_i < mvotg->clknum; clk_i++) {
+			mvotg->clk[clk_i] = devm_clk_get(&pdev->dev,
 						pdata->clkname[clk_i]);
-		if (IS_ERR(mvotg->clk[clk_i])) {
-			retval = PTR_ERR(mvotg->clk[clk_i]);
-			return retval;
+			if (IS_ERR(mvotg->clk[clk_i])) {
+				dev_err(&pdev->dev, "failed to get clk %s\n",
+					pdata->clkname[clk_i]);
+				retval = PTR_ERR(mvotg->clk[clk_i]);
+				return retval;
+			}
 		}
+	} else if (retval < 0) {
+		dev_err(&pdev->dev, "error parse dt\n");
+		return retval;
 	}
 
 	mvotg->qwork = create_singlethread_workqueue("mv_otg_queue");
@@ -770,6 +847,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 	}
 	mvotg->mvphy = mv_usb2_get_phy();
 	if (mvotg->mvphy == NULL) {
+		dev_err(&pdev->dev, "failed to get usb phy\n");
 		retval = -ENODEV;
 		goto err_destroy_workqueue;
 	}
@@ -791,9 +869,6 @@ static int mv_otg_probe(struct platform_device *pdev)
 		mv_usb2_register_notifier(mvotg->mvphy, &mvotg->notifier);
 	}
 
-	if (pdata->disable_otg_clock_gating)
-		mvotg->clock_gating = 0;
-
 	mv_otg_reset(mvotg);
 	mv_otg_init_irq(mvotg);
 
@@ -892,13 +967,20 @@ static int mv_otg_resume(struct platform_device *pdev)
 }
 #endif
 
+static struct of_device_id mv_otg_dt_ids[] = {
+	{ .compatible = "mrvl,mv-otg" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mv_otg_dt_ids);
+
 static struct platform_driver mv_otg_driver = {
 	.probe = mv_otg_probe,
 	.remove = __exit_p(mv_otg_remove),
 	.driver = {
-		   .owner = THIS_MODULE,
-		   .name = driver_name,
-		   },
+		.owner = THIS_MODULE,
+		.name = driver_name,
+		.of_match_table = mv_otg_dt_ids,
+	},
 #ifdef CONFIG_PM
 	.suspend = mv_otg_suspend,
 	.resume = mv_otg_resume,
diff --git a/drivers/usb/otg/mv_otg.h b/drivers/usb/otg/mv_otg.h
index f5bc7dd..3b9356d 100644
--- a/drivers/usb/otg/mv_otg.h
+++ b/drivers/usb/otg/mv_otg.h
@@ -157,12 +157,12 @@ struct mv_otg {
 
 	spinlock_t wq_lock;
 
-	struct mv_usb_platform_data *pdata;
-
 	unsigned int active;
 	unsigned int clock_gating;
+	unsigned int mode;
+	unsigned int otg_force_a_bus_req;
 	unsigned int clknum;
-	struct clk *clk[0];
+	struct clk **clk;
 };
 
 #endif
-- 
1.7.4.1
