From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 25 Jan 2014 19:19:09 +0100
Subject: [PATCH 3/4] clk: mvebu: dove: maintain clock init order
In-Reply-To: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1390673950-4521-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Init order of CLK_OF_DECLARE'd drivers depends on compile order.
Unfortunately, clk_of_init does not allow drivers to return errors,
e.g. -EPROBE_DEFER if parent clocks have not been registered, yet.

To avoid init order woes for MVEBU clock drivers, we take care of
proper init order ourselves. This patch joins core-clk and gating-clk
init to maintain proper init order.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clk/mvebu/dove.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/mvebu/dove.c b/drivers/clk/mvebu/dove.c
index 38aee1e3f242..b8c2424ac926 100644
--- a/drivers/clk/mvebu/dove.c
+++ b/drivers/clk/mvebu/dove.c
@@ -154,12 +154,6 @@ static const struct coreclk_soc_desc dove_coreclks = {
 	.num_ratios = ARRAY_SIZE(dove_coreclk_ratios),
 };
 
-static void __init dove_coreclk_init(struct device_node *np)
-{
-	mvebu_coreclk_setup(np, &dove_coreclks);
-}
-CLK_OF_DECLARE(dove_core_clk, "marvell,dove-core-clock", dove_coreclk_init);
-
 /*
  * Clock Gating Control
  */
@@ -186,9 +180,14 @@ static const struct clk_gating_soc_desc dove_gating_desc[] __initconst = {
 	{ }
 };
 
-static void __init dove_clk_gating_init(struct device_node *np)
+static void __init dove_clk_init(struct device_node *np)
 {
-	mvebu_clk_gating_setup(np, dove_gating_desc);
+	struct device_node *cgnp =
+		of_find_compatible_node(NULL, NULL, "marvell,dove-gating-clock");
+
+	mvebu_coreclk_setup(np, &dove_coreclks);
+
+	if (cgnp)
+		mvebu_clk_gating_setup(cgnp, dove_gating_desc);
 }
-CLK_OF_DECLARE(dove_clk_gating, "marvell,dove-gating-clock",
-	       dove_clk_gating_init);
+CLK_OF_DECLARE(dove_clk, "marvell,dove-core-clock", dove_clk_init);
-- 
1.8.5.2
