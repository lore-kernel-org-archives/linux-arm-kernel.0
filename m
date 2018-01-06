From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat,  6 Jan 2018 12:23:20 +0800
Subject: [PATCH 1/7] pinctrl: sunxi: add support for pin controllers without
 bus gate
Message-ID: <20180106042326.46519-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner H6 pin controllers (both the main one and the CPUs one)
have no bus gate clocks.

Add support for this kind of pin controllers.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 30 ++++++++++++++++++++----------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h |  1 +
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 4b6cb25bc796..68cd505679d9 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1182,7 +1182,12 @@ static int sunxi_pinctrl_setup_debounce(struct sunxi_pinctrl *pctl,
 	unsigned int hosc_div, losc_div;
 	struct clk *hosc, *losc;
 	u8 div, src;
-	int i, ret;
+	int i, ret, clk_count;
+
+	if (pctl->desc->without_bus_gate)
+		clk_count = 2;
+	else
+		clk_count = 3;
 
 	/* Deal with old DTs that didn't have the oscillators */
 	if (of_count_phandle_with_args(node, "clocks", "#clock-cells") != 3)
@@ -1360,15 +1365,19 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 			goto gpiochip_error;
 	}
 
-	clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto gpiochip_error;
-	}
+	if (!desc->without_bus_gate) {
+		clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			goto gpiochip_error;
+		}
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		goto gpiochip_error;
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			goto gpiochip_error;
+	} else {
+		clk = NULL;
+	}
 
 	pctl->irq = devm_kcalloc(&pdev->dev,
 				 pctl->desc->irq_banks,
@@ -1425,7 +1434,8 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	return 0;
 
 clk_error:
-	clk_disable_unprepare(clk);
+	if (clk)
+		clk_disable_unprepare(clk);
 gpiochip_error:
 	gpiochip_remove(pctl->chip);
 	return ret;
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 11b128f54ed2..ccb6230f0bb5 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -113,6 +113,7 @@ struct sunxi_pinctrl_desc {
 	unsigned			irq_bank_base;
 	bool				irq_read_needs_mux;
 	bool				disable_strict_mode;
+	bool				without_bus_gate;
 };
 
 struct sunxi_pinctrl_function {
-- 
2.14.2
