From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 17 Sep 2015 12:15:01 +0200
Subject: [PATCH v3 2/6] clk: berlin: add cpuclk
In-Reply-To: <1442484905-15656-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1442484905-15656-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1442484905-15656-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpuclk in the Berlin BG2Q clock driver. This clk has a divider
fixed to 1.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/berlin/bg2q.c            | 12 ++++++------
 include/dt-bindings/clock/berlin2q.h |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
index a27958efab92..c2f48f3773e8 100644
--- a/drivers/clk/berlin/bg2q.c
+++ b/drivers/clk/berlin/bg2q.c
@@ -355,13 +355,13 @@ static void __init berlin2q_clock_setup(struct device_node *np)
 			    gd->bit_idx, 0, &lock);
 	}
 
-	/*
-	 * twdclk is derived from cpu/3
-	 * TODO: use cpupll until cpuclk is not available
-	 */
+	/* cpuclk divider is fixed to 1 */
+	clks[CLKID_CPU] =
+		clk_register_fixed_factor(NULL, "cpu", clk_names[CPUPLL],
+					  0, 1, 1);
+	/* twdclk is derived from cpu/3 */
 	clks[CLKID_TWD] =
-		clk_register_fixed_factor(NULL, "twd", clk_names[CPUPLL],
-					  0, 1, 3);
+		clk_register_fixed_factor(NULL, "twd", "cpu", 0, 1, 3);
 
 	/* check for errors on leaf clocks */
 	for (n = 0; n < MAX_CLKS; n++) {
diff --git a/include/dt-bindings/clock/berlin2q.h b/include/dt-bindings/clock/berlin2q.h
index c79af928ae92..771d8739f67a 100644
--- a/include/dt-bindings/clock/berlin2q.h
+++ b/include/dt-bindings/clock/berlin2q.h
@@ -29,5 +29,6 @@
 #define CLKID_SMEMC		24
 #define CLKID_PCIE		25
 #define CLKID_TWD		26
+#define CLKID_CPU		27
 
-#define MAX_CLKS		27
+#define MAX_CLKS		28
-- 
2.5.2
