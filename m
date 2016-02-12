From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 12 Feb 2016 15:11:52 +0000
Subject: [PATCH 2/3] clk: sunxi: improve divider_clk error handling and
 reporting
In-Reply-To: <1455289913-29514-1-git-send-email-andre.przywara@arm.com>
References: <1455289913-29514-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1455289913-29514-3-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now report a failing ioremap, failing output names parsing,
failures in table registration and in the final step.
Also there was a bug where clk_register_divider_table() would return
an ERR_PTR value instead of NULL, which we were checking for.
We now implement proper rollback in case of an error.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 361f396..1ac6c9e0 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -819,17 +819,44 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
 	void __iomem *reg;
 
 	reg = of_iomap(node, 0);
+	if (!reg) {
+		pr_err("Could not map registers for mux-clk: %s\n", node->name);
+		return;
+	}
 
 	clk_parent = of_clk_get_parent_name(node, 0);
 
-	of_property_read_string(node, "clock-output-names", &clk_name);
+	if (of_property_read_string(node, "clock-output-names", &clk_name)) {
+		pr_err("%s: could not read clock-output-names for \"%s\"\n",
+		       __func__, clk_name);
+		goto out_unmap;
+	}
 
 	clk = clk_register_divider_table(NULL, clk_name, clk_parent, 0,
 					 reg, data->shift, data->width,
 					 data->pow ? CLK_DIVIDER_POWER_OF_TWO : 0,
 					 data->table, &clk_lock);
-	if (clk)
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (IS_ERR(clk)) {
+		pr_err("%s: failed to register divider clock %s: %ld\n",
+		       __func__, clk_name, PTR_ERR(clk));
+		goto out_unmap;
+	}
+
+	if (of_clk_add_provider(node, of_clk_src_simple_get, clk)) {
+		pr_err("%s: failed to add clock provider for %s\n",
+		       __func__, clk_name);
+		goto out_unregister;
+	}
+
+	if (!clk_register_clkdev(clk, clk_name, NULL))
+		return;
+
+	of_clk_del_provider(node);
+out_unregister:
+	clk_unregister_divider(clk);
+
+out_unmap:
+	iounmap(reg);
 }
 
 static void __init sun4i_ahb_clk_setup(struct device_node *node)
-- 
2.6.4
