From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 30 Jan 2015 19:20:10 +0000
Subject: [PATCH V2 RESEND] clk: mxs: Fix invalid 32-bit access to frac
 registers
Message-ID: <1422645610-3052-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to i.MX23 and i.MX28 reference manual [1],[2] the fractional
clock control register is 32-bit wide, but is separated in 4 parts.
So write instructions must not apply to more than 1 part at once.

The clk init for the i.MX28 violates this restriction and all the other
accesses on that register suggest that there isn't such a restriction.

This patch restricts the access to this register to byte instructions and
extends the comment in the init functions.

Btw the imx23 init now uses a R-M-W sequence just like imx28 init
to avoid any clock glitches.

The changes has been tested with a i.MX23 and a i.MX28 board.

[1] - http://cache.freescale.com/files/dsp/doc/ref_manual/IMX23RM.pdf
[2] - http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---

Changes in V2:
- use relaxed access operations in clk-ref

 drivers/clk/mxs/clk-imx23.c |   11 ++++++++---
 drivers/clk/mxs/clk-imx28.c |   19 +++++++++++++------
 drivers/clk/mxs/clk-ref.c   |   19 ++++++++++---------
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index 9fc9359..a084566 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -46,11 +46,13 @@ static void __iomem *digctrl;
 #define BP_CLKSEQ_BYPASS_SAIF	0
 #define BP_CLKSEQ_BYPASS_SSP	5
 #define BP_SAIF_DIV_FRAC_EN	16
-#define BP_FRAC_IOFRAC		24
+
+#define FRAC_IO	3
 
 static void __init clk_misc_init(void)
 {
 	u32 val;
+	u8 frac;
 
 	/* Gate off cpu clock in WFI for power saving */
 	writel_relaxed(1 << BP_CPU_INTERRUPT_WAIT, CPU + SET);
@@ -72,9 +74,12 @@ static void __init clk_misc_init(void)
 	/*
 	 * 480 MHz seems too high to be ssp clock source directly,
 	 * so set frac to get a 288 MHz ref_io.
+	 * According to reference manual we must access frac bytewise.
 	 */
-	writel_relaxed(0x3f << BP_FRAC_IOFRAC, FRAC + CLR);
-	writel_relaxed(30 << BP_FRAC_IOFRAC, FRAC + SET);
+	frac = readb_relaxed(FRAC + FRAC_IO);
+	frac &= ~0x3f;
+	frac |= 30;
+	writeb_relaxed(frac, FRAC + FRAC_IO);
 }
 
 static const char *sel_pll[]  __initconst = { "pll", "ref_xtal", };
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index a6c3501..c541377 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -53,8 +53,9 @@ static void __iomem *clkctrl;
 #define BP_ENET_SLEEP		31
 #define BP_CLKSEQ_BYPASS_SAIF0	0
 #define BP_CLKSEQ_BYPASS_SSP0	3
-#define BP_FRAC0_IO1FRAC	16
-#define BP_FRAC0_IO0FRAC	24
+
+#define FRAC0_IO1	2
+#define FRAC0_IO0	3
 
 static void __iomem *digctrl;
 #define DIGCTRL digctrl
@@ -85,6 +86,7 @@ int mxs_saif_clkmux_select(unsigned int clkmux)
 static void __init clk_misc_init(void)
 {
 	u32 val;
+	u8 frac;
 
 	/* Gate off cpu clock in WFI for power saving */
 	writel_relaxed(1 << BP_CPU_INTERRUPT_WAIT, CPU + SET);
@@ -118,11 +120,16 @@ static void __init clk_misc_init(void)
 	/*
 	 * 480 MHz seems too high to be ssp clock source directly,
 	 * so set frac0 to get a 288 MHz ref_io0 and ref_io1.
+	 * According to reference manual we must access frac0 bytewise.
 	 */
-	val = readl_relaxed(FRAC0);
-	val &= ~((0x3f << BP_FRAC0_IO0FRAC) | (0x3f << BP_FRAC0_IO1FRAC));
-	val |= (30 << BP_FRAC0_IO0FRAC) | (30 << BP_FRAC0_IO1FRAC);
-	writel_relaxed(val, FRAC0);
+	frac = readb_relaxed(FRAC0 + FRAC0_IO0);
+	frac &= ~0x3f;
+	frac |= 30;
+	writeb_relaxed(frac, FRAC0 + FRAC0_IO0);
+	frac = readb_relaxed(FRAC0 + FRAC0_IO1);
+	frac &= ~0x3f;
+	frac |= 30;
+	writeb_relaxed(frac, FRAC0 + FRAC0_IO1);
 }
 
 static const char *sel_cpu[]  __initconst = { "ref_cpu", "ref_xtal", };
diff --git a/drivers/clk/mxs/clk-ref.c b/drivers/clk/mxs/clk-ref.c
index 4adeed6..ad3851c 100644
--- a/drivers/clk/mxs/clk-ref.c
+++ b/drivers/clk/mxs/clk-ref.c
@@ -16,6 +16,8 @@
 #include <linux/slab.h>
 #include "clk.h"
 
+#define BF_CLKGATE	BIT(7)
+
 /**
  * struct clk_ref - mxs reference clock
  * @hw: clk_hw for the reference clock
@@ -39,7 +41,7 @@ static int clk_ref_enable(struct clk_hw *hw)
 {
 	struct clk_ref *ref = to_clk_ref(hw);
 
-	writel_relaxed(1 << ((ref->idx + 1) * 8 - 1), ref->reg + CLR);
+	writeb_relaxed(BF_CLKGATE, ref->reg + ref->idx + CLR);
 
 	return 0;
 }
@@ -48,7 +50,7 @@ static void clk_ref_disable(struct clk_hw *hw)
 {
 	struct clk_ref *ref = to_clk_ref(hw);
 
-	writel_relaxed(1 << ((ref->idx + 1) * 8 - 1), ref->reg + SET);
+	writeb_relaxed(BF_CLKGATE, ref->reg + ref->idx + SET);
 }
 
 static unsigned long clk_ref_recalc_rate(struct clk_hw *hw,
@@ -56,7 +58,7 @@ static unsigned long clk_ref_recalc_rate(struct clk_hw *hw,
 {
 	struct clk_ref *ref = to_clk_ref(hw);
 	u64 tmp = parent_rate;
-	u8 frac = (readl_relaxed(ref->reg) >> (ref->idx * 8)) & 0x3f;
+	u8 frac = readb_relaxed(ref->reg + ref->idx) & 0x3f;
 
 	tmp *= 18;
 	do_div(tmp, frac);
@@ -93,8 +95,7 @@ static int clk_ref_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_ref *ref = to_clk_ref(hw);
 	unsigned long flags;
 	u64 tmp = parent_rate;
-	u32 val;
-	u8 frac, shift = ref->idx * 8;
+	u8 frac, val;
 
 	tmp = tmp * 18 + rate / 2;
 	do_div(tmp, rate);
@@ -107,10 +108,10 @@ static int clk_ref_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	spin_lock_irqsave(&mxs_lock, flags);
 
-	val = readl_relaxed(ref->reg);
-	val &= ~(0x3f << shift);
-	val |= frac << shift;
-	writel_relaxed(val, ref->reg);
+	val = readb_relaxed(ref->reg + ref->idx);
+	val &= ~0x3f;
+	val |= frac;
+	writeb_relaxed(val, ref->reg + ref->idx);
 
 	spin_unlock_irqrestore(&mxs_lock, flags);
 
-- 
1.7.9.5
