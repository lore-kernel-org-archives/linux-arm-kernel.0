From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 12 Feb 2015 20:30:07 +0000
Subject: [PATCH] Revert "clk: mxs: Fix invalid 32-bit access to frac registers"
Message-ID: <1423773007-10752-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Revert commit 039e59707507 (clk: mxs: Fix invalid 32-bit access to frac
registers), because it leads to a faulty spi communication on mx28evk.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/clk/mxs/clk-imx23.c |   11 +++--------
 drivers/clk/mxs/clk-imx28.c |   19 ++++++-------------
 drivers/clk/mxs/clk-ref.c   |   19 +++++++++----------
 3 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index a084566..9fc9359 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -46,13 +46,11 @@ static void __iomem *digctrl;
 #define BP_CLKSEQ_BYPASS_SAIF	0
 #define BP_CLKSEQ_BYPASS_SSP	5
 #define BP_SAIF_DIV_FRAC_EN	16
-
-#define FRAC_IO	3
+#define BP_FRAC_IOFRAC		24
 
 static void __init clk_misc_init(void)
 {
 	u32 val;
-	u8 frac;
 
 	/* Gate off cpu clock in WFI for power saving */
 	writel_relaxed(1 << BP_CPU_INTERRUPT_WAIT, CPU + SET);
@@ -74,12 +72,9 @@ static void __init clk_misc_init(void)
 	/*
 	 * 480 MHz seems too high to be ssp clock source directly,
 	 * so set frac to get a 288 MHz ref_io.
-	 * According to reference manual we must access frac bytewise.
 	 */
-	frac = readb_relaxed(FRAC + FRAC_IO);
-	frac &= ~0x3f;
-	frac |= 30;
-	writeb_relaxed(frac, FRAC + FRAC_IO);
+	writel_relaxed(0x3f << BP_FRAC_IOFRAC, FRAC + CLR);
+	writel_relaxed(30 << BP_FRAC_IOFRAC, FRAC + SET);
 }
 
 static const char *sel_pll[]  __initconst = { "pll", "ref_xtal", };
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index c541377..a6c3501 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -53,9 +53,8 @@ static void __iomem *clkctrl;
 #define BP_ENET_SLEEP		31
 #define BP_CLKSEQ_BYPASS_SAIF0	0
 #define BP_CLKSEQ_BYPASS_SSP0	3
-
-#define FRAC0_IO1	2
-#define FRAC0_IO0	3
+#define BP_FRAC0_IO1FRAC	16
+#define BP_FRAC0_IO0FRAC	24
 
 static void __iomem *digctrl;
 #define DIGCTRL digctrl
@@ -86,7 +85,6 @@ int mxs_saif_clkmux_select(unsigned int clkmux)
 static void __init clk_misc_init(void)
 {
 	u32 val;
-	u8 frac;
 
 	/* Gate off cpu clock in WFI for power saving */
 	writel_relaxed(1 << BP_CPU_INTERRUPT_WAIT, CPU + SET);
@@ -120,16 +118,11 @@ static void __init clk_misc_init(void)
 	/*
 	 * 480 MHz seems too high to be ssp clock source directly,
 	 * so set frac0 to get a 288 MHz ref_io0 and ref_io1.
-	 * According to reference manual we must access frac0 bytewise.
 	 */
-	frac = readb_relaxed(FRAC0 + FRAC0_IO0);
-	frac &= ~0x3f;
-	frac |= 30;
-	writeb_relaxed(frac, FRAC0 + FRAC0_IO0);
-	frac = readb_relaxed(FRAC0 + FRAC0_IO1);
-	frac &= ~0x3f;
-	frac |= 30;
-	writeb_relaxed(frac, FRAC0 + FRAC0_IO1);
+	val = readl_relaxed(FRAC0);
+	val &= ~((0x3f << BP_FRAC0_IO0FRAC) | (0x3f << BP_FRAC0_IO1FRAC));
+	val |= (30 << BP_FRAC0_IO0FRAC) | (30 << BP_FRAC0_IO1FRAC);
+	writel_relaxed(val, FRAC0);
 }
 
 static const char *sel_cpu[]  __initconst = { "ref_cpu", "ref_xtal", };
diff --git a/drivers/clk/mxs/clk-ref.c b/drivers/clk/mxs/clk-ref.c
index ad3851c..4adeed6 100644
--- a/drivers/clk/mxs/clk-ref.c
+++ b/drivers/clk/mxs/clk-ref.c
@@ -16,8 +16,6 @@
 #include <linux/slab.h>
 #include "clk.h"
 
-#define BF_CLKGATE	BIT(7)
-
 /**
  * struct clk_ref - mxs reference clock
  * @hw: clk_hw for the reference clock
@@ -41,7 +39,7 @@ static int clk_ref_enable(struct clk_hw *hw)
 {
 	struct clk_ref *ref = to_clk_ref(hw);
 
-	writeb_relaxed(BF_CLKGATE, ref->reg + ref->idx + CLR);
+	writel_relaxed(1 << ((ref->idx + 1) * 8 - 1), ref->reg + CLR);
 
 	return 0;
 }
@@ -50,7 +48,7 @@ static void clk_ref_disable(struct clk_hw *hw)
 {
 	struct clk_ref *ref = to_clk_ref(hw);
 
-	writeb_relaxed(BF_CLKGATE, ref->reg + ref->idx + SET);
+	writel_relaxed(1 << ((ref->idx + 1) * 8 - 1), ref->reg + SET);
 }
 
 static unsigned long clk_ref_recalc_rate(struct clk_hw *hw,
@@ -58,7 +56,7 @@ static unsigned long clk_ref_recalc_rate(struct clk_hw *hw,
 {
 	struct clk_ref *ref = to_clk_ref(hw);
 	u64 tmp = parent_rate;
-	u8 frac = readb_relaxed(ref->reg + ref->idx) & 0x3f;
+	u8 frac = (readl_relaxed(ref->reg) >> (ref->idx * 8)) & 0x3f;
 
 	tmp *= 18;
 	do_div(tmp, frac);
@@ -95,7 +93,8 @@ static int clk_ref_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_ref *ref = to_clk_ref(hw);
 	unsigned long flags;
 	u64 tmp = parent_rate;
-	u8 frac, val;
+	u32 val;
+	u8 frac, shift = ref->idx * 8;
 
 	tmp = tmp * 18 + rate / 2;
 	do_div(tmp, rate);
@@ -108,10 +107,10 @@ static int clk_ref_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	spin_lock_irqsave(&mxs_lock, flags);
 
-	val = readb_relaxed(ref->reg + ref->idx);
-	val &= ~0x3f;
-	val |= frac;
-	writeb_relaxed(val, ref->reg + ref->idx);
+	val = readl_relaxed(ref->reg);
+	val &= ~(0x3f << shift);
+	val |= frac << shift;
+	writel_relaxed(val, ref->reg);
 
 	spin_unlock_irqrestore(&mxs_lock, flags);
 
-- 
1.7.9.5
