From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Dec 2012 13:02:13 -0800
Subject: [PATCH 2/4] clk: highbank: Use of_init_clk_data()
In-Reply-To: <1355778135-32458-1-git-send-email-sboyd@codeaurora.org>
References: <1355778135-32458-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1355778135-32458-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reduce lines of code and simplify this driver by using the
generic clock binding parsing function.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 drivers/clk/clk-highbank.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-highbank.c b/drivers/clk/clk-highbank.c
index 52fecad..5dbbf62 100644
--- a/drivers/clk/clk-highbank.c
+++ b/drivers/clk/clk-highbank.c
@@ -275,8 +275,6 @@ static __init struct clk *hb_clk_init(struct device_node *node, const struct clk
 	u32 reg;
 	struct clk *clk;
 	struct hb_clk *hb_clk;
-	const char *clk_name = node->name;
-	const char *parent_name;
 	struct clk_init_data init;
 	int rc;
 
@@ -290,24 +288,21 @@ static __init struct clk *hb_clk_init(struct device_node *node, const struct clk
 
 	hb_clk->reg = sregs_base + reg;
 
-	of_property_read_string(node, "clock-output-names", &clk_name);
-
-	init.name = clk_name;
 	init.ops = ops;
-	init.flags = 0;
-	parent_name = of_clk_get_parent_name(node, 0);
-	init.parent_names = &parent_name;
-	init.num_parents = 1;
+	rc = of_init_clk_data(node, &init);
+	if (WARN_ON(rc))
+		goto err;
 
 	hb_clk->hw.init = &init;
 
 	clk = clk_register(NULL, &hb_clk->hw);
-	if (WARN_ON(IS_ERR(clk))) {
-		kfree(hb_clk);
-		return NULL;
-	}
+	if (WARN_ON(IS_ERR(clk)))
+		goto err;
 	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
 	return clk;
+err:
+	kfree(hb_clk);
+	return NULL;
 }
 
 static void __init hb_pll_init(struct device_node *node)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
