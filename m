From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  1 Feb 2016 17:39:27 +0000
Subject: [PATCH 08/11] clk: sunxi: improve error reporting for the mux clock
In-Reply-To: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1454348370-3816-9-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_register_mux returns a pointer wrapped error value in case of
failure, so a simple NULL check is not sufficient to catch errors.
Fix that and elaborate on the failure reason on the way. The whole
function does not return any error value, so silently failing may
leave users scratching their heads because the kernel does not
provide any clues on what's wrong.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index efcce85..9416e0f3 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -627,17 +627,29 @@ static void __init sunxi_mux_clk_setup(struct device_node *node,
 	reg = of_iomap(node, 0);
 
 	i = of_clk_parent_fill(node, parents, SUNXI_MAX_PARENTS);
-	of_property_read_string(node, "clock-output-names", &clk_name);
+	if (of_property_read_string(node, "clock-output-names", &clk_name)) {
+		pr_warn("%s: could not read clock-output-names for \"%s\"\n",
+			__func__, clk_name);
+		goto out_unmap;
+	}
 
 	clk = clk_register_mux(NULL, clk_name, parents, i,
 			       CLK_SET_RATE_PARENT, reg,
 			       data->shift, SUNXI_MUX_GATE_WIDTH,
 			       0, &clk_lock);
 
-	if (clk) {
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		clk_register_clkdev(clk, clk_name, NULL);
+	if (IS_ERR(clk)) {
+		pr_warn("%s: failed to register mux clock %s: %ld\n", __func__,
+			clk_name, PTR_ERR(clk));
+		goto out_unmap;
 	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	clk_register_clkdev(clk, clk_name, NULL);
+	return;
+
+out_unmap:
+	iounmap(reg);
 }
 
 
-- 
2.6.4
