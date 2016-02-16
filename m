From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 16 Feb 2016 10:46:08 +0000
Subject: [PATCH v2 3/3] clk: sunxi: Improve divs_clk error handling and
 reporting
In-Reply-To: <1455619568-1906-1-git-send-email-andre.przywara@arm.com>
References: <1455619568-1906-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1455619568-1906-4-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We catch errors in the base clock registration, failure to ioremap
and failures in the final of_clk_add_provider() call.
Also we unmap the registers when we need to rollback.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 4bd0917..91de0a0 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -985,13 +985,20 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
 
 	/* Set up factor clock that we will be dividing */
 	pclk = sunxi_factors_clk_setup(node, data->factors);
+	if (!pclk)
+		return NULL;
 	parent = __clk_get_name(pclk);
 
 	reg = of_iomap(node, 0);
+	if (!reg) {
+		pr_err("Could not map registers for divs-clk: %s\n",
+		       of_node_full_name(node));
+		return NULL;
+	}
 
 	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
 	if (!clk_data)
-		return NULL;
+		goto out_unmap;
 
 	clks = kcalloc(ndivs, sizeof(*clks), GFP_KERNEL);
 	if (!clks)
@@ -1074,16 +1081,21 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
 	/* Adjust to the real max */
 	clk_data->clk_num = i;
 
-	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (of_clk_add_provider(node, of_clk_src_onecell_get, clk_data)) {
+		pr_err("%s: failed to add clock provider for %s\n",
+		       __func__, clk_name);
+		goto free_gate;
+	}
 
 	return clks;
-
 free_gate:
 	kfree(gate);
 free_clks:
 	kfree(clks);
 free_clkdata:
 	kfree(clk_data);
+out_unmap:
+	iounmap(reg);
 	return NULL;
 }
 
-- 
2.6.4
