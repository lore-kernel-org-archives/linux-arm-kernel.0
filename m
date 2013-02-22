From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 22 Feb 2013 18:17:52 +0100
Subject: [PATCH/RFC 2/4] ARM: shmobile: sh73a0: add support for adjusting CPU
 frequency
In-Reply-To: <1361553474-27022-1-git-send-email-g.liakhovetski@gmx.de>
References: <1361553474-27022-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1361553474-27022-3-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On SH73A0 the output of PLL0 is supplied to two dividers, feeding clock to
the CPU core and SGX. Lower CPU frequencies allow the use of lower supply
voltages and thus reduce power consumption.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

No, I don't like the idea of changing the parent frequency in the child 
clock driver very much either. But having a clock, that acts like this, 
allows the use of the generic cpufreq-cpu0 driver, which handles exactly 
one clock and one regulator. Instead of changing a physical clock driver 
to modify its parent, we could add a virtual clock, that would adjust them 
both. Otherwise, of course, we could write our own cpufreq driver, that 
would explicitly modify the 2 clocks, but that would be too hardware-
specific. I'm open for ideas.

 arch/arm/mach-shmobile/clock-sh73a0.c |  217 ++++++++++++++++++++++++++++++++-
 1 files changed, 213 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 71843dd..3170482 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -16,6 +16,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
@@ -156,18 +157,97 @@ static unsigned long pll_recalc(struct clk *clk)
 	return clk->parent->rate * mult;
 }
 
-static struct sh_clk_ops pll_clk_ops = {
+static int pll0_mult(struct clk *clk, unsigned long *rate)
+{
+	unsigned long mult, f_parent;
+
+	if (!clk->parent || !__clk_get(clk->parent))
+		return -ENODEV;
+
+	f_parent = clk_get_rate(clk->parent);
+	__clk_put(clk->parent);
+
+	if (WARN_ON(!f_parent))
+		/* Should never happen */
+		return -EINVAL;
+
+	mult = (*rate + f_parent / 2) / f_parent;
+
+	/* 27 <= multiplier <= 46 */
+	switch (mult) {
+	case 0 ... 27 / 2:
+		/* 1:1 - rate doesn't change */
+		return 1;
+	case 27 / 2 + 1 ... 27:
+		*rate *= 27;
+		return 27;
+	case 28 ... 45:
+		*rate *= mult;
+		return mult;
+	default:
+		*rate *= 46;
+		return 46;
+	}
+}
+
+static int pll0_set_rate(struct clk *clk, unsigned long rate)
+{
+	int mult = pll0_mult(clk, &rate), i;
+
+	if (mult < 0)
+		return mult;
+
+	if (mult == 1) {
+		/* 1:1 - switch PLL off */
+		__raw_writel(__raw_readl(PLLECR) & ~(1 << clk->enable_bit),
+			     PLLECR);
+		return 0;
+	}
+
+	i = __raw_readl(PLLECR) & (1 << (8 + clk->enable_bit));
+
+	__raw_writel((__raw_readl(clk->enable_reg) & ~(0x3f << 24)) |
+		     ((mult - 1) << 24), clk->enable_reg);
+
+	if (!i)
+		__raw_writel(__raw_readl(PLLECR) | (1 << clk->enable_bit),
+			     PLLECR);
+
+	for (i = 1000; i; i--)
+		if (__raw_readl(PLLECR) & (1 << (8 + clk->enable_bit)))
+			break;
+		else
+			cpu_relax();
+
+	return i ? 0 : -ETIMEDOUT;
+}
+
+static long pll0_round_rate(struct clk *clk, unsigned long rate)
+{
+	int ret = pll0_mult(clk, &rate);
+	if (ret < 0)
+		return ret;
+	return rate;
+}
+
+static struct sh_clk_ops pll0_clk_ops = {
 	.recalc		= pll_recalc,
+	.round_rate	= pll0_round_rate,
+	.set_rate	= pll0_set_rate,
 };
 
 static struct clk pll0_clk = {
-	.ops		= &pll_clk_ops,
+	.ops		= &pll0_clk_ops,
 	.flags		= CLK_ENABLE_ON_INIT,
 	.parent		= &main_clk,
 	.enable_reg	= (void __iomem *)PLL0CR,
 	.enable_bit	= 0,
 };
 
+static struct sh_clk_ops pll_clk_ops = {
+	.recalc		= pll_recalc,
+};
+
 static struct clk pll1_clk = {
 	.ops		= &pll_clk_ops,
 	.flags		= CLK_ENABLE_ON_INIT,
@@ -277,6 +357,126 @@ static struct clk div4_clks[DIV4_NR] = {
 	[DIV4_HP] = DIV4(FRQCRB, 4, 0xdff, 0),
 };
 
+static int (*div4_set_rate)(struct clk *clk, unsigned long rate);
+static unsigned long (*div4_recalc)(struct clk *clk);
+
+/* Supported system CPU (Z-clock) and PLL0 frequency combinations */
+static struct {
+	unsigned long zclk;
+	unsigned long pll0;
+} zclk_rate[] = {
+	{
+		.zclk = 1196000000,
+		.pll0 = 1196000000,
+	}, {
+		.zclk = 806000000,
+		.pll0 = 806000000,
+	}, {
+		.zclk = 403000000,
+		.pll0 = 806000000,
+	},
+};
+
+static int zclk_set_rate(struct clk *clk, unsigned long rate)
+{
+	int i, ret;
+	struct clk *pll0;
+
+	/* We only support frequencies from the zclk_rate table above */
+	for (i = 0; i < ARRAY_SIZE(zclk_rate); i++)
+		if (rate == zclk_rate[i].zclk)
+			break;
+
+	if (i == ARRAY_SIZE(zclk_rate)) {
+		pr_warning("%s(): unsupported CPU clock frequency %lu\n",
+			   __func__, rate);
+		return -EINVAL;
+	}
+
+	/* We could just use ->parent, but it's good to refcount */
+	pll0 = clk_get(NULL, "pll0_clk");
+	if (IS_ERR(pll0))
+		return PTR_ERR(pll0);
+
+	if (zclk_rate[i].pll0 != clk_get_rate(pll0)) {
+		/* cannot call clk_set_rate() - would cause a nested spinlock */
+		ret = pll0_set_rate(pll0, zclk_rate[i].pll0);
+		if (ret < 0)
+			goto esetrate;
+		pll0->rate = pll_recalc(pll0);
+		propagate_rate(pll0);
+	}
+
+	if (zclk_rate[i].pll0 == zclk_rate[i].zclk) {
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
+	clk_put(pll0);
+	return ret;
+}
+
+static long zclk_round_rate(struct clk *clk, unsigned long rate)
+{
+	int i;
+
+	/* We only support frequencies from the zclk_rate table above */
+	for (i = 0; i < ARRAY_SIZE(zclk_rate); i++)
+		if (rate == zclk_rate[i].zclk)
+			break;
+
+	if (i == ARRAY_SIZE(zclk_rate)) {
+		pr_warning("%s(): unsupported CPU clock frequency %lu\n",
+			   __func__, rate);
+		return -EINVAL;
+	}
+
+	return rate;
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
+	div4_set_rate = div4_clks[DIV4_Z].ops->set_rate;
+	div4_recalc = div4_clks[DIV4_Z].ops->recalc;
+	div4_clks[DIV4_Z].ops->set_rate = zclk_set_rate;
+	div4_clks[DIV4_Z].ops->round_rate = zclk_round_rate;
+	div4_clks[DIV4_Z].ops->recalc = zclk_recalc;
+}
+
 enum { DIV6_VCK1, DIV6_VCK2, DIV6_VCK3, DIV6_ZB1,
 	DIV6_FLCTL, DIV6_SDHI0, DIV6_SDHI1, DIV6_SDHI2,
 	DIV6_FSIA, DIV6_FSIB, DIV6_SUB,
@@ -474,7 +674,7 @@ static struct clk *late_main_clks[] = {
 };
 
 enum { MSTP001,
-	MSTP129, MSTP128, MSTP127, MSTP126, MSTP125, MSTP118, MSTP116, MSTP100,
+	MSTP129, MSTP128, MSTP127, MSTP126, MSTP125, MSTP118, MSTP116, MSTP112, MSTP100,
 	MSTP219, MSTP218, MSTP217,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 	MSTP331, MSTP329, MSTP328, MSTP325, MSTP323, MSTP322,
@@ -495,6 +695,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP125] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 25, 0), /* TMU0 */
 	[MSTP118] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 18, 0), /* DSITX0 */
 	[MSTP116] = MSTP(&div4_clks[DIV4_HP], SMSTPCR1, 16, 0), /* IIC0 */
+	[MSTP112] = MSTP(&div4_clks[DIV4_ZG], SMSTPCR1, 12, 0), /* SGX */
 	[MSTP100] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 0, 0), /* LCDC0 */
 	[MSTP219] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 19, 0), /* SCIFA7 */
 	[MSTP218] = MSTP(&div4_clks[DIV4_HP], SMSTPCR2, 18, 0), /* SY-DMAC */
@@ -535,6 +736,10 @@ static struct clk mstp_clks[MSTP_NR] = {
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("r_clk", &r_clk),
+	CLKDEV_CON_ID("pll0_clk", &pll0_clk),
+
+	/* DIV4 clocks */
+	CLKDEV_DEV_ID("cpu0", &div4_clks[DIV4_Z]), /* cpufreq-cpu0 */
 
 	/* DIV6 clocks */
 	CLKDEV_CON_ID("vck1_clk", &div6_clks[DIV6_VCK1]),
@@ -562,6 +767,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-mipi-dsi.0", &mstp_clks[MSTP118]), /* DSITX */
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* I2C0 */
 	CLKDEV_DEV_ID("e6820000.i2c", &mstp_clks[MSTP116]), /* I2C0 */
+	CLKDEV_CON_ID("sgx_clk", &mstp_clks[MSTP112]),
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP100]), /* LCDC0 */
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP219]), /* SCIFA7 */
 	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP218]), /* SY-DMAC */
@@ -627,8 +833,11 @@ void __init sh73a0_clock_init(void)
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
