From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 25 Jan 2014 19:19:07 +0100
Subject: [PATCH 1/4] clk: mvebu: armada-370: maintain clock init order
In-Reply-To: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1390673950-4521-2-git-send-email-sebastian.hesselbarth@gmail.com>
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
 drivers/clk/mvebu/armada-370.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
index 81a202d12a7a..bef198a83863 100644
--- a/drivers/clk/mvebu/armada-370.c
+++ b/drivers/clk/mvebu/armada-370.c
@@ -141,13 +141,6 @@ static const struct coreclk_soc_desc a370_coreclks = {
 	.num_ratios = ARRAY_SIZE(a370_coreclk_ratios),
 };
 
-static void __init a370_coreclk_init(struct device_node *np)
-{
-	mvebu_coreclk_setup(np, &a370_coreclks);
-}
-CLK_OF_DECLARE(a370_core_clk, "marvell,armada-370-core-clock",
-	       a370_coreclk_init);
-
 /*
  * Clock Gating Control
  */
@@ -168,9 +161,15 @@ static const struct clk_gating_soc_desc a370_gating_desc[] __initconst = {
 	{ }
 };
 
-static void __init a370_clk_gating_init(struct device_node *np)
+static void __init a370_clk_init(struct device_node *np)
 {
-	mvebu_clk_gating_setup(np, a370_gating_desc);
+	struct device_node *cgnp =
+		of_find_compatible_node(NULL, NULL, "marvell,armada-370-gating-clock");
+
+	mvebu_coreclk_setup(np, &a370_coreclks);
+
+	if (cgnp)
+		mvebu_clk_gating_setup(cgnp, a370_gating_desc);
 }
-CLK_OF_DECLARE(a370_clk_gating, "marvell,armada-370-gating-clock",
-	       a370_clk_gating_init);
+CLK_OF_DECLARE(a370_clk, "marvell,armada-370-core-clock", a370_clk_init);
+
-- 
1.8.5.2
