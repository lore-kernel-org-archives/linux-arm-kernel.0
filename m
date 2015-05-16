From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 16 May 2015 02:23:42 +0200
Subject: [PATCH 13/14] clk: berlin: drop direct of_iomap of nodes reg property
In-Reply-To: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1431735823-28006-14-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>

The Berlin clock driver was sharing a DT node with the pin controller
and the reset driver. All these devices are now sub-nodes of the chip
controller. This patch rework the Berlin clock driver to allow moving
the Berlin clock DT bindings into their own sub-node of the chip
controller node.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/berlin/bg2.c  | 9 +--------
 drivers/clk/berlin/bg2q.c | 9 ++-------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/berlin/bg2.c b/drivers/clk/berlin/bg2.c
index d8e57097518b..73153fc45ee9 100644
--- a/drivers/clk/berlin/bg2.c
+++ b/drivers/clk/berlin/bg2.c
@@ -508,10 +508,7 @@ static void __init berlin2_clock_setup(struct device_node *np)
 	u8 avpll_flags = 0;
 	int n;
 
-	if (of_device_is_compatible(parent_np, "syscon"))
-		np = parent_np;
-
-	gbase = of_iomap(np, 0);
+	gbase = of_iomap(parent_np, 0);
 	if (!gbase)
 		return;
 
@@ -689,9 +686,5 @@ static void __init berlin2_clock_setup(struct device_node *np)
 bg2_fail:
 	iounmap(gbase);
 }
-CLK_OF_DECLARE(berlin2_clock, "marvell,berlin2-chip-ctrl",
-	       berlin2_clock_setup);
-CLK_OF_DECLARE(berlin2cd_clock, "marvell,berlin2cd-chip-ctrl",
-	       berlin2_clock_setup);
 CLK_OF_DECLARE(berlin2_clk, "marvell,berlin2-clk",
 	       berlin2_clock_setup);
diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
index 638a649ebed7..221f40c2b850 100644
--- a/drivers/clk/berlin/bg2q.c
+++ b/drivers/clk/berlin/bg2q.c
@@ -295,17 +295,14 @@ static void __init berlin2q_clock_setup(struct device_node *np)
 	struct clk *clk;
 	int n;
 
-	if (of_device_is_compatible(parent_np, "syscon"))
-		np = parent_np;
-
-	gbase = of_iomap(np, 0);
+	gbase = of_iomap(parent_np, 0);
 	if (!gbase) {
 		pr_err("%s: Unable to map global base\n", np->full_name);
 		return;
 	}
 
 	/* BG2Q CPU PLL is not part of global registers */
-	cpupll_base = of_iomap(np, 1);
+	cpupll_base = of_iomap(parent_np, 1);
 	if (!cpupll_base) {
 		pr_err("%s: Unable to map cpupll base\n", np->full_name);
 		iounmap(gbase);
@@ -388,7 +385,5 @@ bg2q_fail:
 	iounmap(cpupll_base);
 	iounmap(gbase);
 }
-CLK_OF_DECLARE(berlin2q_clock, "marvell,berlin2q-chip-ctrl",
-	       berlin2q_clock_setup);
 CLK_OF_DECLARE(berlin2q_clk, "marvell,berlin2q-clk",
 	       berlin2q_clock_setup);
-- 
2.1.0
