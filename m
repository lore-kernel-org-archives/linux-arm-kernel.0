From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  7 Apr 2015 16:45:01 +0200
Subject: [PATCH v3 1/9] clk: berlin: move to a dedicated sub-node
In-Reply-To: <1428417909-27378-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1428417909-27378-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1428417909-27378-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Berlin clock driver was sharing a DT node with the pin controller
and the reset driver. All these devices are now sub-nodes of the chip
controller. This patch rework the Berlin clock driver to allow moving
the Berlin clock DT bindings into their own sub-node of the chip
controller node.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/clk/berlin/bg2.c  | 7 +++----
 drivers/clk/berlin/bg2q.c | 7 ++++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/berlin/bg2.c b/drivers/clk/berlin/bg2.c
index 515fb133495c..3bfb3aede9f4 100644
--- a/drivers/clk/berlin/bg2.c
+++ b/drivers/clk/berlin/bg2.c
@@ -502,12 +502,13 @@ static const struct berlin2_gate_data bg2_gates[] __initconst = {
 
 static void __init berlin2_clock_setup(struct device_node *np)
 {
+	struct device_node *parent_np = of_get_parent(np);
 	const char *parent_names[9];
 	struct clk *clk;
 	u8 avpll_flags = 0;
 	int n;
 
-	gbase = of_iomap(np, 0);
+	gbase = of_iomap(parent_np, 0);
 	if (!gbase)
 		return;
 
@@ -685,7 +686,5 @@ static void __init berlin2_clock_setup(struct device_node *np)
 bg2_fail:
 	iounmap(gbase);
 }
-CLK_OF_DECLARE(berlin2_clock, "marvell,berlin2-chip-ctrl",
-	       berlin2_clock_setup);
-CLK_OF_DECLARE(berlin2cd_clock, "marvell,berlin2cd-chip-ctrl",
+CLK_OF_DECLARE(berlin2_clock, "marvell,berlin2-clk",
 	       berlin2_clock_setup);
diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
index 440ef81ab15c..72a50ded145a 100644
--- a/drivers/clk/berlin/bg2q.c
+++ b/drivers/clk/berlin/bg2q.c
@@ -290,18 +290,19 @@ static const struct berlin2_gate_data bg2q_gates[] __initconst = {
 
 static void __init berlin2q_clock_setup(struct device_node *np)
 {
+	struct device_node *parent_np = of_get_parent(np);
 	const char *parent_names[9];
 	struct clk *clk;
 	int n;
 
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
@@ -384,5 +385,5 @@ bg2q_fail:
 	iounmap(cpupll_base);
 	iounmap(gbase);
 }
-CLK_OF_DECLARE(berlin2q_clock, "marvell,berlin2q-chip-ctrl",
+CLK_OF_DECLARE(berlin2q_clock, "marvell,berlin2q-clk",
 	       berlin2q_clock_setup);
-- 
2.3.5
