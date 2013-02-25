From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 25 Feb 2013 18:17:09 +0100 (CET)
Subject: [PATCH/RFC v2 1/2] ARM: shmobile: sh73a0: add support for adjusting
 CPU frequency
In-Reply-To: <Pine.LNX.4.64.1302251644010.3030@axis700.grange>
References: <Pine.LNX.4.64.1302251644010.3030@axis700.grange>
Message-ID: <Pine.LNX.4.64.1302251648480.3030@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On SH73A0 the output of PLL0 is supplied to two dividers, feeding clock to
the CPU core and SGX. Lower CPU frequencies allow the use of lower supply
voltages and thus reduce power consumption.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2:
1. Don't touch PLL0 in this initial implementation. This means we cannot 
configure the CPU frequency exactly as in the datasheet - 806 and 403MHz 
for 1.175 and 1.065V OPPs respectively. Instead we can only set 598 and 
398.(6)MHz.
2. Add a comment to describe SGX ZG clock restrictions.

 arch/arm/mach-shmobile/clock-sh73a0.c |   93 ++++++++++++++++++++++++++++++++-
 1 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 71843dd..1a4edb9 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
+#include <asm/processor.h>
 #include <mach/common.h>
 
 #define FRQCRA		IOMEM(0xe6150000)
@@ -265,6 +266,11 @@ enum { DIV4_I, DIV4_ZG, DIV4_M3, DIV4_B, DIV4_M1, DIV4_M2,
 
 static struct clk div4_clks[DIV4_NR] = {
 	[DIV4_I] = DIV4(FRQCRA, 20, 0xdff, CLK_ENABLE_ON_INIT),
+	/*
+	 * ZG clock is dividing PLL0 frequency to supply SGX. Make sure not to
+	 * exceed maximum frequencies of 201.5MHz for VDD_DVFS=1.175 and
+	 * 239.2MHz for VDD_DVFS=1.315V.
+	 */
 	[DIV4_ZG] = SH_CLK_DIV4(&pll0_clk, FRQCRA, 16, 0xd7f, CLK_ENABLE_ON_INIT),
 	[DIV4_M3] = DIV4(FRQCRA, 12, 0x1dff, CLK_ENABLE_ON_INIT),
 	[DIV4_B] = DIV4(FRQCRA, 8, 0xdff, CLK_ENABLE_ON_INIT),
@@ -277,6 +283,82 @@ static struct clk div4_clks[DIV4_NR] = {
 	[DIV4_HP] = DIV4(FRQCRB, 4, 0xdff, 0),
 };
 
+static int (*div4_set_rate)(struct clk *clk, unsigned long rate);
+static unsigned long (*div4_recalc)(struct clk *clk);
+static long (*div4_round_rate)(struct clk *clk, unsigned long rate);
+
+static int zclk_set_rate(struct clk *clk, unsigned long rate)
+{
+	int i, ret;
+
+	if (!clk->parent || !__clk_get(clk->parent))
+		return -ENODEV;
+
+	if (rate == clk_get_rate(clk->parent)) {
+		/* 1:1 - switch off divider */
+		__raw_writel(__raw_readl(FRQCRB) & ~(1 << 28), FRQCRB);
+		ret = 0;
+	} else {
+		/* set the divider - call the DIV4 method */
+		ret = div4_set_rate(clk, rate);
+		if (ret < 0)
+			goto esetrate;
+
+		/* Enable the divider */
+		__raw_writel(__raw_readl(FRQCRB) | (1 << 28), FRQCRB);
+	}
+
+	/*
+	 * Kick the clock - this is also done in sh_clk_div_set_rate(), but we
+	 * want to check success
+	 */
+	__raw_writel(__raw_readl(FRQCRB) | (1 << 31), FRQCRB);
+	for (i = 1000; i; i--)
+		if (__raw_readl(FRQCRB) & (1 << 31))
+			cpu_relax();
+		else
+			break;
+	if (!i)
+		ret = -ETIMEDOUT;
+
+esetrate:
+	__clk_put(clk->parent);
+	return ret;
+}
+
+static long zclk_round_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long div_freq = div4_round_rate(clk, rate),
+		parent_freq = clk_get_rate(clk->parent);
+
+	if (rate > div_freq && abs(parent_freq - rate) < rate - div_freq)
+		return parent_freq;
+
+	return div_freq;
+}
+
+static unsigned long zclk_recalc(struct clk *clk)
+{
+	/* Must recalculate frequencies, even if the divisor is unused ATM! */
+	unsigned long div_freq = div4_recalc(clk);
+
+	if (__raw_readl(FRQCRB) & (1 << 28))
+		return div_freq;
+
+	return clk_get_rate(clk->parent);
+}
+
+static void zclk_extend(void)
+{
+	/* We extend the DIV4 clock with a 1:1 pass-through case */
+	div4_set_rate = div4_clks[DIV4_Z].ops->set_rate;
+	div4_round_rate = div4_clks[DIV4_Z].ops->round_rate;
+	div4_recalc = div4_clks[DIV4_Z].ops->recalc;
+	div4_clks[DIV4_Z].ops->set_rate = zclk_set_rate;
+	div4_clks[DIV4_Z].ops->round_rate = zclk_round_rate;
+	div4_clks[DIV4_Z].ops->recalc = zclk_recalc;
+}
+
 enum { DIV6_VCK1, DIV6_VCK2, DIV6_VCK3, DIV6_ZB1,
 	DIV6_FLCTL, DIV6_SDHI0, DIV6_SDHI1, DIV6_SDHI2,
 	DIV6_FSIA, DIV6_FSIB, DIV6_SUB,
@@ -474,7 +556,7 @@ static struct clk *late_main_clks[] = {
 };
 
 enum { MSTP001,
-	MSTP129, MSTP128, MSTP127, MSTP126, MSTP125, MSTP118, MSTP116, MSTP100,
+	MSTP129, MSTP128, MSTP127, MSTP126, MSTP125, MSTP118, MSTP116, MSTP112, MSTP100,
 	MSTP219, MSTP218, MSTP217,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 	MSTP331, MSTP329, MSTP328, MSTP325, MSTP323, MSTP322,
@@ -495,6 +577,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP125] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 25, 0), /* TMU0 */
 	[MSTP118] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 18, 0), /* DSITX0 */
 	[MSTP116] = MSTP(&div4_clks[DIV4_HP], SMSTPCR1, 16, 0), /* IIC0 */
+	[MSTP112] = MSTP(&div4_clks[DIV4_ZG], SMSTPCR1, 12, 0), /* SGX */
 	[MSTP100] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 0, 0), /* LCDC0 */
 	[MSTP219] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 19, 0), /* SCIFA7 */
 	[MSTP218] = MSTP(&div4_clks[DIV4_HP], SMSTPCR2, 18, 0), /* SY-DMAC */
@@ -536,6 +619,9 @@ static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("r_clk", &r_clk),
 
+	/* DIV4 clocks */
+	CLKDEV_DEV_ID("cpu0", &div4_clks[DIV4_Z]), /* cpufreq-cpu0 */
+
 	/* DIV6 clocks */
 	CLKDEV_CON_ID("vck1_clk", &div6_clks[DIV6_VCK1]),
 	CLKDEV_CON_ID("vck2_clk", &div6_clks[DIV6_VCK2]),
@@ -627,8 +713,11 @@ void __init sh73a0_clock_init(void)
 	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
 		ret = clk_register(main_clks[k]);
 
-	if (!ret)
+	if (!ret) {
 		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
+		if (!ret)
+			zclk_extend();
+	}
 
 	if (!ret)
 		ret = sh_clk_div6_reparent_register(div6_clks, DIV6_NR);
-- 
1.7.2.5
