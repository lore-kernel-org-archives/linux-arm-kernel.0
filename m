From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Jan 2011 16:20:52 -0800
Subject: [PATCHv2 1/5] msm: clock: Remove unused code and definitions
In-Reply-To: <1296087656-3693-1-git-send-email-sboyd@codeaurora.org>
References: <1296087656-3693-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1296087656-3693-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code is dead or otherwise useless so just remove it.

Reviewed-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/board-msm8x60.c |    4 ---
 arch/arm/mach-msm/clock.c         |   20 +---------------
 arch/arm/mach-msm/clock.h         |   42 -------------------------------------
 3 files changed, 2 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index 9b5eb2b..b3c55f1 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -28,10 +28,6 @@
 #include <mach/board.h>
 #include <mach/msm_iomap.h>
 
-unsigned long clk_get_max_axi_khz(void)
-{
-	return 0;
-}
 
 static void __init msm8x60_map_io(void)
 {
diff --git a/arch/arm/mach-msm/clock.c b/arch/arm/mach-msm/clock.c
index 2069bfa..b67498d 100644
--- a/arch/arm/mach-msm/clock.c
+++ b/arch/arm/mach-msm/clock.c
@@ -37,13 +37,6 @@ struct clk *msm_clocks;
 unsigned msm_num_clocks;
 
 /*
- * Bitmap of enabled clocks, excluding ACPU which is always
- * enabled
- */
-static DECLARE_BITMAP(clock_map_enabled, NR_CLKS);
-static DEFINE_SPINLOCK(clock_map_lock);
-
-/*
  * Standard clock functions defined in include/linux/clk.h
  */
 struct clk *clk_get(struct device *dev, const char *id)
@@ -77,12 +70,8 @@ int clk_enable(struct clk *clk)
 	unsigned long flags;
 	spin_lock_irqsave(&clocks_lock, flags);
 	clk->count++;
-	if (clk->count == 1) {
+	if (clk->count == 1)
 		clk->ops->enable(clk->id);
-		spin_lock(&clock_map_lock);
-		clock_map_enabled[BIT_WORD(clk->id)] |= BIT_MASK(clk->id);
-		spin_unlock(&clock_map_lock);
-	}
 	spin_unlock_irqrestore(&clocks_lock, flags);
 	return 0;
 }
@@ -94,12 +83,8 @@ void clk_disable(struct clk *clk)
 	spin_lock_irqsave(&clocks_lock, flags);
 	BUG_ON(clk->count == 0);
 	clk->count--;
-	if (clk->count == 0) {
+	if (clk->count == 0)
 		clk->ops->disable(clk->id);
-		spin_lock(&clock_map_lock);
-		clock_map_enabled[BIT_WORD(clk->id)] &= ~BIT_MASK(clk->id);
-		spin_unlock(&clock_map_lock);
-	}
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 EXPORT_SYMBOL(clk_disable);
@@ -196,7 +181,6 @@ void __init msm_clock_init(struct clk *clock_tbl, unsigned num_clocks)
 {
 	unsigned n;
 
-	spin_lock_init(&clocks_lock);
 	mutex_lock(&clocks_mutex);
 	msm_clocks = clock_tbl;
 	msm_num_clocks = num_clocks;
diff --git a/arch/arm/mach-msm/clock.h b/arch/arm/mach-msm/clock.h
index c270b55..db9a77a 100644
--- a/arch/arm/mach-msm/clock.h
+++ b/arch/arm/mach-msm/clock.h
@@ -59,51 +59,9 @@ struct clk {
 	struct device *dev;
 };
 
-#define A11S_CLK_CNTL_ADDR		(MSM_CSR_BASE + 0x100)
-#define A11S_CLK_SEL_ADDR		(MSM_CSR_BASE + 0x104)
-#define A11S_VDD_SVS_PLEVEL_ADDR	(MSM_CSR_BASE + 0x124)
-
-#ifdef CONFIG_DEBUG_FS
-#define CLOCK_DBG_NAME(x) .dbg_name = x,
-#else
-#define CLOCK_DBG_NAME(x)
-#endif
-
-#define CLOCK(clk_name, clk_id, clk_dev, clk_flags) {	\
-	.name = clk_name, \
-	.id = clk_id, \
-	.flags = clk_flags, \
-	.dev = clk_dev, \
-	 CLOCK_DBG_NAME(#clk_id) \
-	}
-
 #define OFF CLKFLAG_AUTO_OFF
 #define CLK_MIN CLKFLAG_MIN
 #define CLK_MAX CLKFLAG_MAX
 #define CLK_MINMAX (CLK_MIN | CLK_MAX)
-#define NR_CLKS	P_NR_CLKS
-
-enum {
-	PLL_0 = 0,
-	PLL_1,
-	PLL_2,
-	PLL_3,
-	PLL_4,
-	PLL_5,
-	PLL_6,
-	NUM_PLL
-};
-
-enum clkvote_client {
-	CLKVOTE_ACPUCLK = 0,
-	CLKVOTE_PMQOS,
-	CLKVOTE_MAX,
-};
-
-int msm_clock_require_tcxo(unsigned long *reason, int nbits);
-int msm_clock_get_name(uint32_t id, char *name, uint32_t size);
-int ebi1_clk_set_min_rate(enum clkvote_client client, unsigned long rate);
-unsigned long clk_get_max_axi_khz(void);
 
 #endif
-
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
