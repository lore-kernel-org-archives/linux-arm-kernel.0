From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 27 Jan 2012 12:42:04 -0200
Subject: [PATCH v2] ARM: mx28: clock-mx28: Use a proper timeout mechanism
In-Reply-To: <1327329667-25512-1-git-send-email-fabio.estevam@freescale.com>
References: <1327329667-25512-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1327675324-11307-1-git-send-email-fabio.estevam@freescale.com>
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
Changes since v1:
- Removed empty lines
- Removed _func_ from error message
- Put mxs_clkctrl_timeout in common file
- Change mx23 too
- Fixed comment about jiffy

 arch/arm/mach-mxs/clock-mx23.c          |   34 +++------------------
 arch/arm/mach-mxs/clock-mx28.c          |   49 ++++---------------------------
 arch/arm/mach-mxs/include/mach/common.h |    2 +
 arch/arm/mach-mxs/system.c              |   16 ++++++++++
 4 files changed, 29 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index e12e112..293958b 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -223,7 +223,6 @@ static int cpu_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	u32 reg, bm_busy, div_max, d, f, div, frac;
 	unsigned long diff, parent_rate, calc_rate;
-	int i;
 
 	parent_rate = clk_get_rate(clk->parent);
 
@@ -275,14 +274,7 @@ static int cpu_clk_set_rate(struct clk *clk, unsigned long rate)
 	reg |= div << BP_CLKCTRL_CPU_DIV_CPU;
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_CPU);
 
-	for (i = 10000; i; i--)
-		if (!(__raw_readl(CLKCTRL_BASE_ADDR +
-					HW_CLKCTRL_CPU) & bm_busy))
-			break;
-	if (!i)	{
-		pr_err("%s: divider writing timeout\n", __func__);
-		return -ETIMEDOUT;
-	}
+	mxs_clkctrl_timeout(HW_CLKCTRL_CPU, bm_busy);
 
 	return 0;
 }
@@ -292,7 +284,6 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 {									\
 	u32 reg, div_max, div;						\
 	unsigned long parent_rate;					\
-	int i;								\
 									\
 	parent_rate = clk_get_rate(clk->parent);			\
 	div_max = BM_CLKCTRL_##dr##_DIV >> BP_CLKCTRL_##dr##_DIV;	\
@@ -310,15 +301,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
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
+	mxs_clkctrl_timeout(HW_CLKCTRL_##dr, BM_CLKCTRL_##dr##_BUSY);	\
 	return 0;							\
 }
 
@@ -461,7 +444,7 @@ static struct clk_lookup lookups[] = {
 static int clk_misc_init(void)
 {
 	u32 reg;
-	int i;
+	int ret;
 
 	/* Fix up parent per register setting */
 	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_CLKSEQ);
@@ -510,14 +493,7 @@ static int clk_misc_init(void)
 	reg |= 3 << BP_CLKCTRL_HBUS_DIV;
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_HBUS);
 
-	for (i = 10000; i; i--)
-		if (!(__raw_readl(CLKCTRL_BASE_ADDR +
-			HW_CLKCTRL_HBUS) & BM_CLKCTRL_HBUS_BUSY))
-			break;
-	if (!i) {
-		pr_err("%s: divider writing timeout\n", __func__);
-		return -ETIMEDOUT;
-	}
+	ret = mxs_clkctrl_timeout(HW_CLKCTRL_HBUS, BM_CLKCTRL_HBUS_BUSY);
 
 	/* Gate off cpu clock in WFI for power saving */
 	__raw_writel(BM_CLKCTRL_CPU_INTERRUPT_WAIT,
@@ -532,7 +508,7 @@ static int clk_misc_init(void)
 	reg |= 30 << BP_CLKCTRL_FRAC_IOFRAC;
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC);
 
-	return 0;
+	return ret;
 }
 
 int __init mx23_clocks_init(void)
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 5d68e41..f91b8fb 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -322,7 +322,6 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 {									\
 	u32 reg, bm_busy, div_max, d, f, div, frac;			\
 	unsigned long diff, parent_rate, calc_rate;			\
-	int i;								\
 									\
 	div_max = BM_CLKCTRL_##dr##_DIV >> BP_CLKCTRL_##dr##_DIV;	\
 	bm_busy = BM_CLKCTRL_##dr##_BUSY;				\
@@ -396,16 +395,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
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
@@ -421,7 +411,6 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 {									\
 	u32 reg, div_max, div;						\
 	unsigned long parent_rate;					\
-	int i;								\
 									\
 	parent_rate = clk_get_rate(clk->parent);			\
 	div_max = BM_CLKCTRL_##dr##_DIV >> BP_CLKCTRL_##dr##_DIV;	\
@@ -439,16 +428,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
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
@@ -461,7 +441,6 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 	u32 reg;							\
 	u64 lrate;							\
 	unsigned long parent_rate;					\
-	int i;								\
 									\
 	parent_rate = clk_get_rate(clk->parent);			\
 	if (rate > parent_rate)						\
@@ -479,16 +458,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
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
@@ -676,7 +646,7 @@ static struct clk_lookup lookups[] = {
 static int clk_misc_init(void)
 {
 	u32 reg;
-	int i;
+	int ret;
 
 	/* Fix up parent per register setting */
 	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_CLKSEQ);
@@ -756,14 +726,7 @@ static int clk_misc_init(void)
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
@@ -790,7 +753,7 @@ static int clk_misc_init(void)
 	reg |= 30 << BP_CLKCTRL_FRAC0_IO0FRAC;
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC0);
 
-	return 0;
+	return ret;
 }
 
 int __init mx28_clocks_init(void)
diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
index e1237ab..c50c3ea 100644
--- a/arch/arm/mach-mxs/include/mach/common.h
+++ b/arch/arm/mach-mxs/include/mach/common.h
@@ -31,4 +31,6 @@ extern void mx28_init_irq(void);
 
 extern void icoll_init_irq(void);
 
+extern int mxs_clkctrl_timeout(unsigned int reg_offset, unsigned int mask);
+
 #endif /* __MACH_MXS_COMMON_H__ */
diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
index 54f91ad..98e2de0 100644
--- a/arch/arm/mach-mxs/system.c
+++ b/arch/arm/mach-mxs/system.c
@@ -37,6 +37,8 @@
 #define MXS_MODULE_CLKGATE		(1 << 30)
 #define MXS_MODULE_SFTRST		(1 << 31)
 
+#define CLKCTRL_TIMEOUT		10	/* 10 ms */
+
 static void __iomem *mxs_clkctrl_reset_addr;
 
 /*
@@ -137,3 +139,17 @@ error:
 	return -ETIMEDOUT;
 }
 EXPORT_SYMBOL(mxs_reset_block);
+
+int mxs_clkctrl_timeout(unsigned int reg_offset, unsigned int mask)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(CLKCTRL_TIMEOUT);
+	while (readl_relaxed(MXS_IO_ADDRESS(MXS_CLKCTRL_BASE_ADDR)
+						+ reg_offset) & mask) {
+		if (time_after(jiffies, timeout)) {
+			pr_err("Timeout@CLKCTRL + 0x%x\n", reg_offset);
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
-- 
1.7.1
