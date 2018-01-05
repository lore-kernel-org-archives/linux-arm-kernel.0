From: david@lechnology.com (David Lechner)
Date: Thu,  4 Jan 2018 18:38:10 -0600
Subject: [PATCH 5/7] clk: rockchip: make use of clk_alloc_onecell_data()
In-Reply-To: <1515112695-3160-1-git-send-email-david@lechnology.com>
References: <1515112695-3160-1-git-send-email-david@lechnology.com>
Message-ID: <1515112695-3160-6-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper function clk_alloc_onecell_data() to allocate struct
clk_onecell_data.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/clk/rockchip/clk-rockchip.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rockchip.c b/drivers/clk/rockchip/clk-rockchip.c
index 2c9bb81..499af3a 100644
--- a/drivers/clk/rockchip/clk-rockchip.c
+++ b/drivers/clk/rockchip/clk-rockchip.c
@@ -52,19 +52,12 @@ static void __init rk2928_gate_clk_init(struct device_node *node)
 	if (!reg)
 		return;
 
-	clk_data = kzalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
+	clk_data = clk_alloc_onecell_data(qty);
 	if (!clk_data) {
 		iounmap(reg);
 		return;
 	}
 
-	clk_data->clks = kzalloc(qty * sizeof(struct clk *), GFP_KERNEL);
-	if (!clk_data->clks) {
-		kfree(clk_data);
-		iounmap(reg);
-		return;
-	}
-
 	flags = CLK_GATE_HIWORD_MASK | CLK_GATE_SET_TO_DISABLE;
 
 	for (i = 0; i < qty; i++) {
@@ -91,8 +84,6 @@ static void __init rk2928_gate_clk_init(struct device_node *node)
 		WARN_ON(IS_ERR(clk_data->clks[i]));
 	}
 
-	clk_data->clk_num = qty;
-
 	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 }
 CLK_OF_DECLARE(rk2928_gate, "rockchip,rk2928-gate-clk", rk2928_gate_clk_init);
-- 
2.7.4
