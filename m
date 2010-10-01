From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:33 -0700
Subject: [PATCH 09/47] davinci: clock: add support for setting sysclk rate
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-10-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Setting sysclk rate will be useful in cases where the
sysclk is not at a fixed ratio to the PLL output but
can asynchronously be changed.

This support forms the basis of attempt to keep the AEMIF
clock constant on OMAP-L138 even as PLL0 output changes
as ARM clock is changed to save power.

This patch has been tested on OMAP-L138.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c |   73 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/clock.h |    5 +++
 2 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 5b0cb62..01ba080 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -287,6 +287,79 @@ static unsigned long clk_sysclk_recalc(struct clk *clk)
 	return rate;
 }
 
+int davinci_set_sysclk_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned v;
+	struct pll_data *pll;
+	unsigned long input;
+	unsigned ratio = 0;
+
+	/* If this is the PLL base clock, wrong function to call */
+	if (clk->pll_data)
+		return -EINVAL;
+
+	/* There must be a parent... */
+	if (WARN_ON(!clk->parent))
+		return -EINVAL;
+
+	/* ... the parent must be a PLL... */
+	if (WARN_ON(!clk->parent->pll_data))
+		return -EINVAL;
+
+	/* ... and this clock must have a divider. */
+	if (WARN_ON(!clk->div_reg))
+		return -EINVAL;
+
+	pll = clk->parent->pll_data;
+
+	input = clk->parent->rate;
+
+	/* If pre-PLL, source clock is before the multiplier and divider(s) */
+	if (clk->flags & PRE_PLL)
+		input = pll->input_rate;
+
+	if (input > rate) {
+		/*
+		 * Can afford to provide an output little higher than requested
+		 * only if maximum rate supported by hardware on this sysclk
+		 * is known.
+		 */
+		if (clk->maxrate) {
+			ratio = DIV_ROUND_CLOSEST(input, rate);
+			if (input / ratio > clk->maxrate)
+				ratio = 0;
+		}
+
+		if (ratio == 0)
+			ratio = DIV_ROUND_UP(input, rate);
+
+		ratio--;
+	}
+
+	if (ratio > PLLDIV_RATIO_MASK)
+		return -EINVAL;
+
+	do {
+		v = __raw_readl(pll->base + PLLSTAT);
+	} while (v & PLLSTAT_GOSTAT);
+
+	v = __raw_readl(pll->base + clk->div_reg);
+	v &= ~PLLDIV_RATIO_MASK;
+	v |= ratio | PLLDIV_EN;
+	__raw_writel(v, pll->base + clk->div_reg);
+
+	v = __raw_readl(pll->base + PLLCMD);
+	v |= PLLCMD_GOSET;
+	__raw_writel(v, pll->base + PLLCMD);
+
+	do {
+		v = __raw_readl(pll->base + PLLSTAT);
+	} while (v & PLLSTAT_GOSTAT);
+
+	return 0;
+}
+EXPORT_SYMBOL(davinci_set_sysclk_rate);
+
 static unsigned long clk_leafclk_recalc(struct clk *clk)
 {
 	if (WARN_ON(!clk->parent))
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index 01e3648..1109998 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -70,6 +70,9 @@
 #include <linux/list.h>
 #include <asm/clkdev.h>
 
+#define PLLSTAT_GOSTAT	BIT(0)
+#define PLLCMD_GOSET	BIT(0)
+
 struct pll_data {
 	u32 phys_base;
 	void __iomem *base;
@@ -86,6 +89,7 @@ struct clk {
 	struct module		*owner;
 	const char		*name;
 	unsigned long		rate;
+	unsigned long		maxrate;	/* H/W supported max rate */
 	u8			usecount;
 	u8			lpsc;
 	u8			gpsc;
@@ -118,6 +122,7 @@ struct clk {
 int davinci_clk_init(struct clk_lookup *clocks);
 int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 				unsigned int mult, unsigned int postdiv);
+int davinci_set_sysclk_rate(struct clk *clk, unsigned long rate);
 
 extern struct platform_device davinci_wdt_device;
 extern void davinci_watchdog_reset(struct platform_device *);
-- 
1.7.2.1
