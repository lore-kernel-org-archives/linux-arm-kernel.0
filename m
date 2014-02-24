From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Feb 2014 17:22:44 +0100
Subject: [PATCH 2/5] clk: sun6i: Reparent AHB clock on PLL6
In-Reply-To: <1393258967-4843-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1393258967-4843-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1393258967-4843-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for the DMA controller to work for SDRAM to devices transfers, the AHB
clock should be reparented on the PLL6.

Force that parenting in the clock driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index cedaf4b..6cfcd23 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1286,7 +1286,7 @@ static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_mat
  */
 static void __init sunxi_clock_protect(void)
 {
-	struct clk *clk;
+	struct clk *clk, *parent;
 
 	/* memory bus clock - sun5i+ */
 	clk = clk_get(NULL, "mbus");
@@ -1309,6 +1309,22 @@ static void __init sunxi_clock_protect(void)
 		clk_put(clk);
 	}
 
+	clk = clk_get(NULL, "ahb1_mux");
+	if (IS_ERR(clk)) {
+		pr_err("Couldn't get AHB1 Mux\n");
+		return;
+	}
+
+	parent = clk_get(NULL, "pll6");
+	if (IS_ERR(clk)) {
+		pr_err("Couldn't get PLL6\n");
+		return;
+	}
+
+	clk_set_parent(clk, parent);
+
+	clk_put(clk);
+	clk_put(parent);
 }
 
 static void __init sunxi_init_clocks(void)
-- 
1.9.0
