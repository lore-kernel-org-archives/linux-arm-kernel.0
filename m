From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 25 Jan 2014 19:19:08 +0100
Subject: [PATCH 2/4] clk: mvebu: armada-xp: maintain clock init order
In-Reply-To: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1390673950-4521-3-git-send-email-sebastian.hesselbarth@gmail.com>
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
 drivers/clk/mvebu/armada-xp.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/mvebu/armada-xp.c b/drivers/clk/mvebu/armada-xp.c
index 9922c4475aa8..b3094315a3c0 100644
--- a/drivers/clk/mvebu/armada-xp.c
+++ b/drivers/clk/mvebu/armada-xp.c
@@ -158,13 +158,6 @@ static const struct coreclk_soc_desc axp_coreclks = {
 	.num_ratios = ARRAY_SIZE(axp_coreclk_ratios),
 };
 
-static void __init axp_coreclk_init(struct device_node *np)
-{
-	mvebu_coreclk_setup(np, &axp_coreclks);
-}
-CLK_OF_DECLARE(axp_core_clk, "marvell,armada-xp-core-clock",
-	       axp_coreclk_init);
-
 /*
  * Clock Gating Control
  */
@@ -202,9 +195,14 @@ static const struct clk_gating_soc_desc axp_gating_desc[] __initconst = {
 	{ }
 };
 
-static void __init axp_clk_gating_init(struct device_node *np)
+static void __init axp_clk_init(struct device_node *np)
 {
-	mvebu_clk_gating_setup(np, axp_gating_desc);
+	struct device_node *cgnp =
+		of_find_compatible_node(NULL, NULL, "marvell,armada-xp-gating-clock");
+
+	mvebu_coreclk_setup(np, &axp_coreclks);
+
+	if (cgnp)
+		mvebu_clk_gating_setup(cgnp, axp_gating_desc);
 }
-CLK_OF_DECLARE(axp_clk_gating, "marvell,armada-xp-gating-clock",
-	       axp_clk_gating_init);
+CLK_OF_DECLARE(axp_clk, "marvell,armada-xp-core-clock", axp_clk_init);
-- 
1.8.5.2
