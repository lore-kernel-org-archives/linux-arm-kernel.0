From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:16 -0700
Subject: [PATCH 12/46] davinci: support changing the clock rate in clock
	framework
In-Reply-To: <1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

clk_round_rate, clk_set_rate have been updated to handle dynamic
frequency changes.

The motivation behind the changes is to support dynamic CPU frequency
change.

davinci_set_pllrate() changes the PLL rate of a given PLL. This function
has been presented as a generic function though it has been tested only
on OMAP-L138 EVM. No other currently available DaVinci device will probably
use this function, but any future device specific changes will hopefully be
small enough to get taken care using a cpu_is_xxx() macro.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c |  114 +++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-davinci/clock.h |    8 +++
 2 files changed, 119 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 6de1e34..09e0e1c 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -19,6 +19,7 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include <mach/hardware.h>
 
@@ -99,17 +100,44 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 	if (clk == NULL || IS_ERR(clk))
 		return -EINVAL;
 
+	if (clk->round_rate)
+		return clk->round_rate(clk, rate);
+
 	return clk->rate;
 }
 EXPORT_SYMBOL(clk_round_rate);
 
+/* Propagate rate to children */
+static void propagate_rate(struct clk *root)
+{
+	struct clk *clk;
+
+	list_for_each_entry(clk, &root->children, childnode) {
+		if (clk->recalc)
+			clk->rate = clk->recalc(clk);
+		propagate_rate(clk);
+	}
+}
+
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
+	unsigned long flags;
+	int ret = -EINVAL;
+
 	if (clk == NULL || IS_ERR(clk))
-		return -EINVAL;
+		return ret;
 
-	/* changing the clk rate is not supported */
-	return -EINVAL;
+	spin_lock_irqsave(&clockfw_lock, flags);
+	if (clk->set_rate)
+		ret = clk->set_rate(clk, rate);
+	if (ret == 0) {
+		if (clk->recalc)
+			clk->rate = clk->recalc(clk);
+		propagate_rate(clk);
+	}
+	spin_unlock_irqrestore(&clockfw_lock, flags);
+
+	return ret;
 }
 EXPORT_SYMBOL(clk_set_rate);
 
@@ -296,6 +324,86 @@ static unsigned long clk_pllclk_recalc(struct clk *clk)
 	return rate;
 }
 
+/**
+ * davinci_set_pllrate - set the output rate of a given PLL.
+ *
+ * Note: Currently tested to work with OMAP-L138 only.
+ *
+ * @pll: pll whose rate needs to be changed.
+ * @prediv: The pre divider value. Passing 0 disables the pre-divider.
+ * @pllm: The multiplier value. Passing 0 leads to multiply-by-one.
+ * @postdiv: The post divider value. Passing 0 disables the post-divider.
+ */
+int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
+					unsigned int mult, unsigned int postdiv)
+{
+	u32 ctrl;
+	unsigned int locktime;
+
+	if (pll->base == NULL)
+		return -EINVAL;
+
+	/*
+	 *  PLL lock time required per OMAP-L138 datasheet is
+	 * (2000 * prediv)/sqrt(pllm) OSCIN cycles. We approximate sqrt(pllm)
+	 * as 4 and OSCIN cycle as 25 MHz.
+	 */
+	if (prediv) {
+		locktime = ((2000 * prediv) / 100);
+		prediv = (prediv - 1) | PLLDIV_EN;
+	} else {
+		locktime = 20;
+	}
+	if (postdiv)
+		postdiv = (postdiv - 1) | PLLDIV_EN;
+	if (mult)
+		mult = mult - 1;
+
+	ctrl = __raw_readl(pll->base + PLLCTL);
+
+	/* Switch the PLL to bypass mode */
+	ctrl &= ~(PLLCTL_PLLENSRC | PLLCTL_PLLEN);
+	__raw_writel(ctrl, pll->base + PLLCTL);
+
+	/*
+	 * Wait for 4 OSCIN/CLKIN cycles to ensure that the PLLC has switched
+	 * to bypass mode. Delay of 1us ensures we are good for all > 4MHz
+	 * OSCIN/CLKIN inputs. Typically the input is ~25MHz.
+	 */
+	udelay(1);
+
+	/* Reset and enable PLL */
+	ctrl &= ~(PLLCTL_PLLRST | PLLCTL_PLLDIS);
+	__raw_writel(ctrl, pll->base + PLLCTL);
+
+	if (pll->flags & PLL_HAS_PREDIV)
+		__raw_writel(prediv, pll->base + PREDIV);
+
+	__raw_writel(mult, pll->base + PLLM);
+
+	if (pll->flags & PLL_HAS_POSTDIV)
+		__raw_writel(postdiv, pll->base + POSTDIV);
+
+	/*
+	 * Wait for PLL to reset properly, OMAP-L138 datasheet says
+	 * 'min' time = 125ns
+	 */
+	udelay(1);
+
+	/* Bring PLL out of reset */
+	ctrl |= PLLCTL_PLLRST;
+	__raw_writel(ctrl, pll->base + PLLCTL);
+
+	udelay(locktime);
+
+	/* Remove PLL from bypass mode */
+	ctrl |= PLLCTL_PLLEN;
+	__raw_writel(ctrl, pll->base + PLLCTL);
+
+	return 0;
+}
+EXPORT_SYMBOL(davinci_set_pllrate);
+
 int __init davinci_clk_init(struct davinci_clk *clocks)
   {
 	struct davinci_clk *c;
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index 202b9ff..a75d3f7 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -22,6 +22,10 @@
 /* PLL/Reset register offsets */
 #define PLLCTL          0x100
 #define PLLCTL_PLLEN    BIT(0)
+#define PLLCTL_PLLPWRDN	BIT(1)
+#define PLLCTL_PLLRST	BIT(3)
+#define PLLCTL_PLLDIS	BIT(4)
+#define PLLCTL_PLLENSRC	BIT(5)
 #define PLLCTL_CLKMODE  BIT(8)
 
 #define PLLM		0x110
@@ -74,6 +78,8 @@ struct clk {
 	struct pll_data         *pll_data;
 	u32                     div_reg;
 	unsigned long (*recalc) (struct clk *);
+	int (*set_rate) (struct clk *clk, unsigned long rate);
+	int (*round_rate) (struct clk *clk, unsigned long rate);
 };
 
 /* Clock flags */
@@ -97,6 +103,8 @@ struct davinci_clk {
 	}
 
 int davinci_clk_init(struct davinci_clk *clocks);
+int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
+				unsigned int mult, unsigned int postdiv);
 
 extern struct platform_device davinci_wdt_device;
 
-- 
1.6.4.3
