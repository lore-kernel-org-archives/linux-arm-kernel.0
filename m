From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 10 Sep 2017 20:40:05 +0800
Subject: [PATCH 1/2] clk: sunxi-ng: add CLK_SET_RATE_UNGATE to all H3 PLLs
In-Reply-To: <20170910124006.60250-1-icenowy@aosc.io>
References: <20170910124006.60250-1-icenowy@aosc.io>
Message-ID: <20170910124006.60250-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PLLs on H3 have a lock bit, which will only be set to 1 when the PLL
is really working.

Add CLK_SET_RATE_UNGATE to the PLLs, otherwise it will timeout when
trying to set PLL clock frequency without enabling it.

Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 1729ff6a5aae..7a81c4885836 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -37,7 +37,7 @@ static SUNXI_CCU_NKMP_WITH_GATE_LOCK(pll_cpux_clk, "pll-cpux",
 				     16, 2,	/* P */
 				     BIT(31),	/* gate */
 				     BIT(28),	/* lock */
-				     0);
+				     CLK_SET_RATE_UNGATE);
 
 /*
  * The Audio PLL is supposed to have 4 outputs: 3 fixed factors from
@@ -55,7 +55,7 @@ static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
 				   0, 5,	/* M */
 				   BIT(31),	/* gate */
 				   BIT(28),	/* lock */
-				   0);
+				   CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video_clk, "pll-video",
 					"osc24M", 0x0010,
@@ -67,7 +67,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video_clk, "pll-video",
 					297000000,	/* frac rate 1 */
 					BIT(31),	/* gate */
 					BIT(28),	/* lock */
-					0);
+					CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
 					"osc24M", 0x0018,
@@ -79,7 +79,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
 					297000000,	/* frac rate 1 */
 					BIT(31),	/* gate */
 					BIT(28),	/* lock */
-					0);
+					CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_ddr_clk, "pll-ddr",
 				    "osc24M", 0x020,
@@ -88,7 +88,7 @@ static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_ddr_clk, "pll-ddr",
 				    0, 2,	/* M */
 				    BIT(31),	/* gate */
 				    BIT(28),	/* lock */
-				    0);
+				    CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(pll_periph0_clk, "pll-periph0",
 					   "osc24M", 0x028,
@@ -97,7 +97,7 @@ static SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(pll_periph0_clk, "pll-periph0",
 					   BIT(31),	/* gate */
 					   BIT(28),	/* lock */
 					   2,		/* post-div */
-					   0);
+					   CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
 					"osc24M", 0x0038,
@@ -109,7 +109,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
 					297000000,	/* frac rate 1 */
 					BIT(31),	/* gate */
 					BIT(28),	/* lock */
-					0);
+					CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(pll_periph1_clk, "pll-periph1",
 					   "osc24M", 0x044,
@@ -118,7 +118,7 @@ static SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(pll_periph1_clk, "pll-periph1",
 					   BIT(31),	/* gate */
 					   BIT(28),	/* lock */
 					   2,		/* post-div */
-					   0);
+					   CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_de_clk, "pll-de",
 					"osc24M", 0x0048,
@@ -130,7 +130,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_de_clk, "pll-de",
 					297000000,	/* frac rate 1 */
 					BIT(31),	/* gate */
 					BIT(28),	/* lock */
-					0);
+					CLK_SET_RATE_UNGATE);
 
 static const char * const cpux_parents[] = { "osc32k", "osc24M",
 					     "pll-cpux" , "pll-cpux" };
-- 
2.13.5
