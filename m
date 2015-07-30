From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 30 Jul 2015 14:35:50 +0200
Subject: [PATCH 1/3] clk: berlin: add cpuclk
In-Reply-To: <1438259752-16320-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1438259752-16320-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1438259752-16320-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpuclk in the Berlin BG2Q clock driver. This clk has a divider
fixed to 1.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/clk/berlin/bg2q.c            | 14 +++++++-------
 include/dt-bindings/clock/berlin2q.h |  3 ++-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
index 221f40c2b850..72d2f3500db8 100644
--- a/drivers/clk/berlin/bg2q.c
+++ b/drivers/clk/berlin/bg2q.c
@@ -45,7 +45,7 @@
 #define REG_SDIO0XIN_CLKCTL	0x0158
 #define REG_SDIO1XIN_CLKCTL	0x015c
 
-#define	MAX_CLKS 27
+#define	MAX_CLKS 28
 static struct clk *clks[MAX_CLKS];
 static struct clk_onecell_data clk_data;
 static DEFINE_SPINLOCK(lock);
@@ -356,13 +356,13 @@ static void __init berlin2q_clock_setup(struct device_node *np)
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
index 287fc3b4afb2..a80c3272794d 100644
--- a/include/dt-bindings/clock/berlin2q.h
+++ b/include/dt-bindings/clock/berlin2q.h
@@ -28,4 +28,5 @@
 #define CLKID_NFC		23
 #define CLKID_SMEMC		24
 #define CLKID_PCIE		25
-#define CLKID_TWD		26
+#define CLKID_CPU		26
+#define CLKID_TWD		27
-- 
2.5.0
