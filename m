From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 16 May 2015 02:23:38 +0200
Subject: [PATCH 09/14] clk: berlin: prepare simple-mfd conversion
In-Reply-To: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1431735823-28006-10-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>

Prepare conversion of berlin clk drivers to a simple-mfd sub-node by
checking for parent node compatible. If parent node is "syscon" compatible
use it for of_iomap instead of the own node.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/berlin/bg2.c  | 6 ++++++
 drivers/clk/berlin/bg2q.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/clk/berlin/bg2.c b/drivers/clk/berlin/bg2.c
index 515fb133495c..d8e57097518b 100644
--- a/drivers/clk/berlin/bg2.c
+++ b/drivers/clk/berlin/bg2.c
@@ -502,11 +502,15 @@ static const struct berlin2_gate_data bg2_gates[] __initconst = {
 
 static void __init berlin2_clock_setup(struct device_node *np)
 {
+	struct device_node *parent_np = of_get_parent(np);
 	const char *parent_names[9];
 	struct clk *clk;
 	u8 avpll_flags = 0;
 	int n;
 
+	if (of_device_is_compatible(parent_np, "syscon"))
+		np = parent_np;
+
 	gbase = of_iomap(np, 0);
 	if (!gbase)
 		return;
@@ -689,3 +693,5 @@ CLK_OF_DECLARE(berlin2_clock, "marvell,berlin2-chip-ctrl",
 	       berlin2_clock_setup);
 CLK_OF_DECLARE(berlin2cd_clock, "marvell,berlin2cd-chip-ctrl",
 	       berlin2_clock_setup);
+CLK_OF_DECLARE(berlin2_clk, "marvell,berlin2-clk",
+	       berlin2_clock_setup);
diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
index 440ef81ab15c..638a649ebed7 100644
--- a/drivers/clk/berlin/bg2q.c
+++ b/drivers/clk/berlin/bg2q.c
@@ -290,10 +290,14 @@ static const struct berlin2_gate_data bg2q_gates[] __initconst = {
 
 static void __init berlin2q_clock_setup(struct device_node *np)
 {
+	struct device_node *parent_np = of_get_parent(np);
 	const char *parent_names[9];
 	struct clk *clk;
 	int n;
 
+	if (of_device_is_compatible(parent_np, "syscon"))
+		np = parent_np;
+
 	gbase = of_iomap(np, 0);
 	if (!gbase) {
 		pr_err("%s: Unable to map global base\n", np->full_name);
@@ -386,3 +390,5 @@ bg2q_fail:
 }
 CLK_OF_DECLARE(berlin2q_clock, "marvell,berlin2q-chip-ctrl",
 	       berlin2q_clock_setup);
+CLK_OF_DECLARE(berlin2q_clk, "marvell,berlin2q-clk",
+	       berlin2q_clock_setup);
-- 
2.1.0
