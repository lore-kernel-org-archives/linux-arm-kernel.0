From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Sep 2016 14:57:39 +0800
Subject: [PATCH 2/3] clk: sunxi-ng: sun6i-a31: set CLK_SET_RATE_UNGATE for all
 PLLs
In-Reply-To: <20160915065740.13664-1-wens@csie.org>
References: <20160915065740.13664-1-wens@csie.org>
Message-ID: <20160915065740.13664-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PLLs have a "lock" bit in their configuration registers which
indicate if the PLL has locked on to the requested clock rate. We
check this bit in the .set_rate op. The PLL cannot lock on if it's
not running, which might be a false positive (warning).

Set the CLK_SET_RATE_UNGATE flag for all PLLs so whenever clk_set_rate
is called on them, they get enabled and the "lock" check is really
checking the PLL.

Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index bb488e8baea8..ff0d621495fd 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -59,7 +59,7 @@ static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
 				   0, 5,	/* M */
 				   BIT(31),	/* gate */
 				   BIT(28),	/* lock */
-				   0);
+				   CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video0_clk, "pll-video0",
 					"osc24M", 0x010,
@@ -71,7 +71,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video0_clk, "pll-video0",
 					297000000,	/* frac rate 1 */
 					BIT(31),	/* gate */
 					BIT(28),	/* lock */
-					0);
+					CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
 					"osc24M", 0x018,
@@ -83,7 +83,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
 					297000000,	/* frac rate 1 */
 					BIT(31),	/* gate */
 					BIT(28),	/* lock */
-					0);
+					CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_ddr_clk, "pll-ddr",
 				    "osc24M", 0x020,
@@ -92,7 +92,7 @@ static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_ddr_clk, "pll-ddr",
 				    0, 2,	/* M */
 				    BIT(31),	/* gate */
 				    BIT(28),	/* lock */
-				    0);
+				    CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(pll_periph_clk, "pll-periph",
 					   "osc24M", 0x028,
@@ -101,7 +101,7 @@ static SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(pll_periph_clk, "pll-periph",
 					   BIT(31),	/* gate */
 					   BIT(28),	/* lock */
 					   2,		/* post-div */
-					   0);
+					   CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video1_clk, "pll-video1",
 					"osc24M", 0x030,
@@ -113,7 +113,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video1_clk, "pll-video1",
 					297000000,	/* frac rate 1 */
 					BIT(31),	/* gate */
 					BIT(28),	/* lock */
-					0);
+					CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
 					"osc24M", 0x038,
@@ -125,7 +125,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
 					297000000,	/* frac rate 1 */
 					BIT(31),	/* gate */
 					BIT(28),	/* lock */
-					0);
+					CLK_SET_RATE_UNGATE);
 
 /*
  * The MIPI PLL has 2 modes: "MIPI" and "HDMI".
@@ -145,7 +145,7 @@ static SUNXI_CCU_NKM_WITH_MUX_GATE_LOCK(pll_mipi_clk, "pll-mipi",
 					21, 0,	/* mux */
 					BIT(31),	/* gate */
 					BIT(28),	/* lock */
-					0);
+					CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll9_clk, "pll9",
 					"osc24M", 0x044,
@@ -157,7 +157,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll9_clk, "pll9",
 					297000000,	/* frac rate 1 */
 					BIT(31),	/* gate */
 					BIT(28),	/* lock */
-					0);
+					CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll10_clk, "pll10",
 					"osc24M", 0x048,
@@ -169,7 +169,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll10_clk, "pll10",
 					297000000,	/* frac rate 1 */
 					BIT(31),	/* gate */
 					BIT(28),	/* lock */
-					0);
+					CLK_SET_RATE_UNGATE);
 
 static const char * const cpux_parents[] = { "osc32k", "osc24M",
 					     "pll-cpu", "pll-cpu" };
-- 
2.9.3
