From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 12 Feb 2016 15:11:53 +0000
Subject: [PATCH 3/3] clk: sunxi: Improve divs_clk error handling and reporting
In-Reply-To: <1455289913-29514-1-git-send-email-andre.przywara@arm.com>
References: <1455289913-29514-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1455289913-29514-4-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We catch errors in the base clock registration, failure to ioremap
and failures in the final of_clk_add_provider() call.
Also we unmap the registers when we need to rollback.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 1ac6c9e0..48ed81d 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -987,13 +987,20 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
 
 	/* Set up factor clock that we will be dividing */
 	pclk = sunxi_factors_clk_setup(node, data->factors);
+	if (!pclk)
+		return NULL;
 	parent = __clk_get_name(pclk);
 
 	reg = of_iomap(node, 0);
+	if (!reg) {
+		pr_err("Could not map registers for divs-clk: %s\n",
+		       node->name);
+		return NULL;
+	}
 
 	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
 	if (!clk_data)
-		return NULL;
+		goto out_unmap;
 
 	clks = kcalloc(ndivs, sizeof(*clks), GFP_KERNEL);
 	if (!clks)
@@ -1076,9 +1083,10 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
 	/* Adjust to the real max */
 	clk_data->clk_num = i;
 
-	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (!of_clk_add_provider(node, of_clk_src_onecell_get, clk_data))
+		return clks;
 
-	return clks;
+	pr_err("%s: failed to add clock provider for %s\n", __func__, clk_name);
 
 free_gate:
 	kfree(gate);
@@ -1086,6 +1094,8 @@ free_clks:
 	kfree(clks);
 free_clkdata:
 	kfree(clk_data);
+out_unmap:
+	iounmap(reg);
 	return NULL;
 }
 
-- 
2.6.4
