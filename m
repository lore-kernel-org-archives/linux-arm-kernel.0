From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 23 Jan 2012 12:41:07 -0200
Subject: [PATCH] ARM: mx28: clock-mx28: Use a proper timeout mechanism
Message-ID: <1327329667-25512-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a function for checking the busy bits of CLKCTRL register that 
uses a proper timeout mechanism.

Remove parts of code that use busy loops and replace them with the 
mxs_clkctrl_timeout() function.

Tested on a mx28evk by performing audio playback.

Suggested-by: Wolfram Sang <w.sang@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/clock-mx28.c |   64 +++++++++++++---------------------------
 1 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 5d68e41..ad5482d 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -38,6 +38,7 @@
 #define DIGCTRL_BASE_ADDR	MX28_IO_ADDRESS(MX28_DIGCTL_BASE_ADDR)
 
 #define PARENT_RATE_SHIFT	8
+#define CLKCTRL_TIMEOUT		10	/* 10 ms = 1 jiffy */
 
 static struct clk pll2_clk;
 static struct clk cpu_clk;
@@ -127,6 +128,20 @@ static unsigned long pll2_clk_get_rate(struct clk *clk)
 	return 50000000;
 }
 
+static int mxs_clkctrl_timeout(unsigned int reg_offset, unsigned int mask)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(CLKCTRL_TIMEOUT);
+	while (readl_relaxed(CLKCTRL_BASE_ADDR + reg_offset) & mask) {
+		if (time_after(jiffies, timeout)) {
+			pr_err("%s: divider writing timeout\n", __func__);
+			return -ETIMEDOUT;
+		}
+
+	}
+
+	return 0;
+}
+
 #define _CLK_ENABLE_PLL(name, r, g)					\
 static int name##_enable(struct clk *clk)				\
 {									\
@@ -322,7 +337,6 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 {									\
 	u32 reg, bm_busy, div_max, d, f, div, frac;			\
 	unsigned long diff, parent_rate, calc_rate;			\
-	int i;								\
 									\
 	div_max = BM_CLKCTRL_##dr##_DIV >> BP_CLKCTRL_##dr##_DIV;	\
 	bm_busy = BM_CLKCTRL_##dr##_BUSY;				\
@@ -396,16 +410,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 	}								\
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##dr);		\
 									\
-	for (i = 10000; i; i--)						\
-		if (!(__raw_readl(CLKCTRL_BASE_ADDR +			\
-			HW_CLKCTRL_##dr) & bm_busy))			\
-			break;						\
-	if (!i)	{							\
-		pr_err("%s: divider writing timeout\n", __func__);	\
-		return -ETIMEDOUT;					\
-	}								\
-									\
-	return 0;							\
+	return mxs_clkctrl_timeout(HW_CLKCTRL_##dr, bm_busy);		\
 }
 
 _CLK_SET_RATE(cpu_clk, CPU, FRAC0, CPU)
@@ -421,7 +426,6 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 {									\
 	u32 reg, div_max, div;						\
 	unsigned long parent_rate;					\
-	int i;								\
 									\
 	parent_rate = clk_get_rate(clk->parent);			\
 	div_max = BM_CLKCTRL_##dr##_DIV >> BP_CLKCTRL_##dr##_DIV;	\
@@ -439,16 +443,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 	}								\
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##dr);		\
 									\
-	for (i = 10000; i; i--)						\
-		if (!(__raw_readl(CLKCTRL_BASE_ADDR +			\
-			HW_CLKCTRL_##dr) & BM_CLKCTRL_##dr##_BUSY))	\
-			break;						\
-	if (!i)	{							\
-		pr_err("%s: divider writing timeout\n", __func__);	\
-		return -ETIMEDOUT;					\
-	}								\
-									\
-	return 0;							\
+	return mxs_clkctrl_timeout(HW_CLKCTRL_##dr, BM_CLKCTRL_##dr##_BUSY);\
 }
 
 _CLK_SET_RATE1(xbus_clk, XBUS)
@@ -461,7 +456,6 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 	u32 reg;							\
 	u64 lrate;							\
 	unsigned long parent_rate;					\
-	int i;								\
 									\
 	parent_rate = clk_get_rate(clk->parent);			\
 	if (rate > parent_rate)						\
@@ -479,16 +473,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 	reg |= div << BP_CLKCTRL_##rs##_DIV;				\
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
 									\
-	for (i = 10000; i; i--)						\
-		if (!(__raw_readl(CLKCTRL_BASE_ADDR +			\
-			HW_CLKCTRL_##rs) & BM_CLKCTRL_##rs##_BUSY))	\
-			break;						\
-	if (!i) {							\
-		pr_err("%s: divider writing timeout\n", __func__);	\
-		return -ETIMEDOUT;					\
-	}								\
-									\
-	return 0;							\
+	return mxs_clkctrl_timeout(HW_CLKCTRL_##rs, BM_CLKCTRL_##rs##_BUSY);\
 }
 
 _CLK_SET_RATE_SAIF(saif0_clk, SAIF0)
@@ -676,7 +661,7 @@ static struct clk_lookup lookups[] = {
 static int clk_misc_init(void)
 {
 	u32 reg;
-	int i;
+	int ret;
 
 	/* Fix up parent per register setting */
 	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_CLKSEQ);
@@ -756,14 +741,7 @@ static int clk_misc_init(void)
 	reg |= 3 << BP_CLKCTRL_HBUS_DIV;
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_HBUS);
 
-	for (i = 10000; i; i--)
-		if (!(__raw_readl(CLKCTRL_BASE_ADDR +
-			HW_CLKCTRL_HBUS) & BM_CLKCTRL_HBUS_ASM_BUSY))
-			break;
-	if (!i) {
-		pr_err("%s: divider writing timeout\n", __func__);
-		return -ETIMEDOUT;
-	}
+	ret = mxs_clkctrl_timeout(HW_CLKCTRL_HBUS, BM_CLKCTRL_HBUS_ASM_BUSY);
 
 	/* Gate off cpu clock in WFI for power saving */
 	__raw_writel(BM_CLKCTRL_CPU_INTERRUPT_WAIT,
@@ -790,7 +768,7 @@ static int clk_misc_init(void)
 	reg |= 30 << BP_CLKCTRL_FRAC0_IO0FRAC;
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC0);
 
-	return 0;
+	return ret;
 }
 
 int __init mx28_clocks_init(void)
-- 
1.7.1
