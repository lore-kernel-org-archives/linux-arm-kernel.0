From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 25 Jan 2016 21:15:41 +0800
Subject: [PATCH RFC 05/11] clk: sunxi: unmap registers in
 sunxi_factors_clk_setup if register call fails
In-Reply-To: <1453727747-23307-1-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
Message-ID: <1453727747-23307-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sunxi_factors_clk_setup() does not unmap registers when
sunxi_factors_register() fails.

This patch adds proper error handling, and also an error message
when sunxi_factors_register() fails. Also use the full DT node name
in error messages, as the node name is often just "clk", which is
useless.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 7e719d089017..5dd927859bc2 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -747,15 +747,24 @@ static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
 						   const struct factors_data *data)
 {
 	void __iomem *reg;
+	struct clk *clk;
 
 	reg = of_iomap(node, 0);
 	if (!reg) {
 		pr_err("Could not get registers for factors-clk: %s\n",
-		       node->name);
+		       of_node_full_name(node));
 		return NULL;
 	}
 
-	return sunxi_factors_register(node, data, &clk_lock, reg);
+	clk = sunxi_factors_register(node, data, &clk_lock, reg);
+
+	if (!clk) {
+		pr_err("Could not register factors-clk: %s\n",
+		       of_node_full_name(node));
+		iounmap(reg);
+	}
+
+	return clk;
 }
 
 
-- 
2.7.0
