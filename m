From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 16 Feb 2016 10:46:06 +0000
Subject: [PATCH v2 1/3] clk: sunxi: improve mux_clk error handling and
 reporting
In-Reply-To: <1455619568-1906-1-git-send-email-andre.przywara@arm.com>
References: <1455619568-1906-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1455619568-1906-2-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now catch and report a failing ioremap, also a failure in the final
step of the clock registration is now handled and reported.
Also warnings are turned into errors.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 99f60ef..775e137 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -674,11 +674,16 @@ static struct clk * __init sunxi_mux_clk_setup(struct device_node *node,
 	int i;
 
 	reg = of_iomap(node, 0);
+	if (!reg) {
+		pr_err("Could not map registers for mux-clk: %s\n",
+		       of_node_full_name(node));
+		return NULL;
+	}
 
 	i = of_clk_parent_fill(node, parents, SUNXI_MAX_PARENTS);
 	if (of_property_read_string(node, "clock-output-names", &clk_name)) {
-		pr_warn("%s: could not read clock-output-names for \"%s\"\n",
-			__func__, clk_name);
+		pr_err("%s: could not read clock-output-names from \"%s\"\n",
+		       __func__, of_node_full_name(node));
 		goto out_unmap;
 	}
 
@@ -688,15 +693,19 @@ static struct clk * __init sunxi_mux_clk_setup(struct device_node *node,
 			       0, &clk_lock);
 
 	if (IS_ERR(clk)) {
-		pr_warn("%s: failed to register mux clock %s: %ld\n", __func__,
-			clk_name, PTR_ERR(clk));
+		pr_err("%s: failed to register mux clock %s: %ld\n", __func__,
+		       clk_name, PTR_ERR(clk));
 		goto out_unmap;
 	}
 
-	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (of_clk_add_provider(node, of_clk_src_simple_get, clk)) {
+		pr_err("%s: failed to add clock provider for %s\n",
+		       __func__, clk_name);
+		clk_unregister_divider(clk);
+		goto out_unmap;
+	}
 
 	return clk;
-
 out_unmap:
 	iounmap(reg);
 	return NULL;
-- 
2.6.4
