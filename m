From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 1 Oct 2009 12:32:45 -0400
Subject: [PATCH] ep93xx: introduce clk parent
In-Reply-To: <20091001145939.GA28044@n2100.arm.linux.org.uk>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF45C@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D42467@mi8nycmail19.Mi8.com>
	<4AC3B748.5060904@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D42C80@mi8nycmail19.Mi8.com>
	<20091001145939.GA28044@n2100.arm.linux.org.uk>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901D42D95@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock generation system in the ep93xx uses two external oscillator's
and two internal PLLs to derive all the internal clocks.  Many of these
internal clocks can be stopped to save power.

This introduces a "parent" hierarchy for the clocks so that the users
count can be correctly tracked for power management.

The "parent" for the video clock can either be one of the PLL outputs
or the external oscillator.  In order to correctly track the "parent"
for the video clock calc_clk_div() needed to be modified.  It now
returns an error code if the desired rate cannot be generated.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: Ryan Mallon <ryan@bluewatersys.com>

---

Added locking for clk_enable and clk_disable to prevent the use count
being corrupted by simultaneous calls.


diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index dda19cd..1d0f9d8 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -16,13 +16,16 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/io.h>
+#include <linux/spinlock.h>
+
+#include <mach/hardware.h>
 
 #include <asm/clkdev.h>
 #include <asm/div64.h>
-#include <mach/hardware.h>
 
 
 struct clk {
+	struct clk	*parent;
 	unsigned long	rate;
 	int		users;
 	int		sw_locked;
@@ -39,40 +42,60 @@ static unsigned long get_uart_rate(struct clk *clk);
 static int set_keytchclk_rate(struct clk *clk, unsigned long rate);
 static int set_div_rate(struct clk *clk, unsigned long rate);
 
+
+static struct clk clk_xtali = {
+	.rate		= EP93XX_EXT_CLK_RATE,
+};
 static struct clk clk_uart1 = {
+	.parent		= &clk_xtali,
 	.sw_locked	= 1,
 	.enable_reg	= EP93XX_SYSCON_DEVCFG,
 	.enable_mask	= EP93XX_SYSCON_DEVCFG_U1EN,
 	.get_rate	= get_uart_rate,
 };
 static struct clk clk_uart2 = {
+	.parent		= &clk_xtali,
 	.sw_locked	= 1,
 	.enable_reg	= EP93XX_SYSCON_DEVCFG,
 	.enable_mask	= EP93XX_SYSCON_DEVCFG_U2EN,
 	.get_rate	= get_uart_rate,
 };
 static struct clk clk_uart3 = {
+	.parent		= &clk_xtali,
 	.sw_locked	= 1,
 	.enable_reg	= EP93XX_SYSCON_DEVCFG,
 	.enable_mask	= EP93XX_SYSCON_DEVCFG_U3EN,
 	.get_rate	= get_uart_rate,
 };
-static struct clk clk_pll1;
-static struct clk clk_f;
-static struct clk clk_h;
-static struct clk clk_p;
-static struct clk clk_pll2;
+static struct clk clk_pll1 = {
+	.parent		= &clk_xtali,
+};
+static struct clk clk_f = {
+	.parent		= &clk_pll1,
+};
+static struct clk clk_h = {
+	.parent		= &clk_pll1,
+};
+static struct clk clk_p = {
+	.parent		= &clk_pll1,
+};
+static struct clk clk_pll2 = {
+	.parent		= &clk_xtali,
+};
 static struct clk clk_usb_host = {
+	.parent		= &clk_pll2,
 	.enable_reg	= EP93XX_SYSCON_PWRCNT,
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_USH_EN,
 };
 static struct clk clk_keypad = {
+	.parent		= &clk_xtali,
 	.sw_locked	= 1,
 	.enable_reg	= EP93XX_SYSCON_KEYTCHCLKDIV,
 	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
 	.set_rate	= set_keytchclk_rate,
 };
 static struct clk clk_pwm = {
+	.parent		= &clk_xtali,
 	.rate		= EP93XX_EXT_CLK_RATE,
 };
 
@@ -85,50 +108,62 @@ static struct clk clk_video = {
 
 /* DMA Clocks */
 static struct clk clk_m2p0 = {
+	.parent		= &clk_h,
 	.enable_reg	= EP93XX_SYSCON_PWRCNT,
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P0,
 };
 static struct clk clk_m2p1 = {
+	.parent		= &clk_h,
 	.enable_reg	= EP93XX_SYSCON_PWRCNT,
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P1,
 };
 static struct clk clk_m2p2 = {
+	.parent		= &clk_h,
 	.enable_reg	= EP93XX_SYSCON_PWRCNT,
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P2,
 };
 static struct clk clk_m2p3 = {
+	.parent		= &clk_h,
 	.enable_reg	= EP93XX_SYSCON_PWRCNT,
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P3,
 };
 static struct clk clk_m2p4 = {
+	.parent		= &clk_h,
 	.enable_reg	= EP93XX_SYSCON_PWRCNT,
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P4,
 };
 static struct clk clk_m2p5 = {
+	.parent		= &clk_h,
 	.enable_reg	= EP93XX_SYSCON_PWRCNT,
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P5,
 };
 static struct clk clk_m2p6 = {
+	.parent		= &clk_h,
 	.enable_reg	= EP93XX_SYSCON_PWRCNT,
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P6,
 };
 static struct clk clk_m2p7 = {
+	.parent		= &clk_h,
 	.enable_reg	= EP93XX_SYSCON_PWRCNT,
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P7,
 };
 static struct clk clk_m2p8 = {
+	.parent		= &clk_h,
 	.enable_reg	= EP93XX_SYSCON_PWRCNT,
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P8,
 };
 static struct clk clk_m2p9 = {
+	.parent		= &clk_h,
 	.enable_reg	= EP93XX_SYSCON_PWRCNT,
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P9,
 };
 static struct clk clk_m2m0 = {
+	.parent		= &clk_h,
 	.enable_reg	= EP93XX_SYSCON_PWRCNT,
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2M0,
 };
 static struct clk clk_m2m1 = {
+	.parent		= &clk_h,
 	.enable_reg	= EP93XX_SYSCON_PWRCNT,
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2M1,
 };
@@ -137,6 +172,7 @@ static struct clk clk_m2m1 = {
 	{ .dev_id = dev, .con_id = con, .clk = ck }
 
 static struct clk_lookup clocks[] = {
+	INIT_CK(NULL,			"xtali",	&clk_xtali),
 	INIT_CK("apb:uart1",		NULL,		&clk_uart1),
 	INIT_CK("apb:uart2",		NULL,		&clk_uart2),
 	INIT_CK("apb:uart3",		NULL,		&clk_uart3),
@@ -163,48 +199,84 @@ static struct clk_lookup clocks[] = {
 	INIT_CK(NULL,			"m2m1",		&clk_m2m1),
 };
 
+static DEFINE_SPINLOCK(clk_lock);
+
+static void __clk_enable(struct clk *clk)
+{
+	if (!clk->users++) {
+		if (clk->parent)
+			__clk_enable(clk->parent);
+
+		if (clk->enable_reg) {
+			u32 v;
+
+			v = __raw_readl(clk->enable_reg);
+			v |= clk->enable_mask;
+			if (clk->sw_locked)
+				ep93xx_syscon_swlocked_write(v, clk->enable_reg);
+			else
+				__raw_writel(v, clk->enable_reg);
+		}
+	}
+}
 
 int clk_enable(struct clk *clk)
 {
-	if (!clk->users++ && clk->enable_reg) {
-		u32 value;
+	unsigned long flags;
 
-		value = __raw_readl(clk->enable_reg);
-		value |= clk->enable_mask;
-		if (clk->sw_locked)
-			ep93xx_syscon_swlocked_write(value, clk->enable_reg);
-		else
-			__raw_writel(value, clk->enable_reg);
-	}
+	if (!clk)
+		return -EINVAL;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	__clk_enable(clk);
+	spin_unlock_irqrestore(&clk_lock, flags);
 
 	return 0;
 }
 EXPORT_SYMBOL(clk_enable);
 
-void clk_disable(struct clk *clk)
+static void __clk_disable(struct clk *clk)
 {
-	if (!--clk->users && clk->enable_reg) {
-		u32 value;
+	if (!--clk->users) {
+		if (clk->enable_reg) {
+			u32 v;
+
+			v = __raw_readl(clk->enable_reg);
+			v &= ~clk->enable_mask;
+			if (clk->sw_locked)
+				ep93xx_syscon_swlocked_write(v, clk->enable_reg);
+			else
+				__raw_writel(v, clk->enable_reg);
+		}
 
-		value = __raw_readl(clk->enable_reg);
-		value &= ~clk->enable_mask;
-		if (clk->sw_locked)
-			ep93xx_syscon_swlocked_write(value, clk->enable_reg);
-		else
-			__raw_writel(value, clk->enable_reg);
+		if (clk->parent)
+			__clk_disable(clk->parent);
 	}
 }
+
+void clk_disable(struct clk *clk)
+{
+	unsigned long flags;
+
+	if (!clk)
+		return;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	__clk_disable(clk);
+	spin_unlock_irqrestore(&clk_lock, flags);
+}
 EXPORT_SYMBOL(clk_disable);
 
 static unsigned long get_uart_rate(struct clk *clk)
 {
+	unsigned long rate = clk_get_rate(clk->parent);
 	u32 value;
 
 	value = __raw_readl(EP93XX_SYSCON_PWRCNT);
 	if (value & EP93XX_SYSCON_PWRCNT_UARTBAUD)
-		return EP93XX_EXT_CLK_RATE;
+		return rate;
 	else
-		return EP93XX_EXT_CLK_RATE / 2;
+		return rate / 2;
 }
 
 unsigned long clk_get_rate(struct clk *clk)
@@ -244,16 +316,16 @@ static int set_keytchclk_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
-static unsigned long calc_clk_div(unsigned long rate, int *psel, int *esel,
-				  int *pdiv, int *div)
+static int calc_clk_div(struct clk *clk, unsigned long rate,
+			int *psel, int *esel, int *pdiv, int *div)
 {
-	unsigned long max_rate, best_rate = 0,
-		actual_rate = 0, mclk_rate = 0, rate_err = -1;
+	struct clk *mclk;
+	unsigned long max_rate, actual_rate, mclk_rate, rate_err = -1;
 	int i, found = 0, __div = 0, __pdiv = 0;
 
 	/* Don't exceed the maximum rate */
 	max_rate = max(max(clk_pll1.rate / 4, clk_pll2.rate / 4),
-		       (unsigned long)EP93XX_EXT_CLK_RATE / 4);
+		       clk_xtali.rate / 4);
 	rate = min(rate, max_rate);
 
 	/*
@@ -267,11 +339,12 @@ static unsigned long calc_clk_div(unsigned long rate, int *psel, int *esel,
 	 */
 	for (i = 0; i < 3; i++) {
 		if (i == 0)
-			mclk_rate = EP93XX_EXT_CLK_RATE * 2;
+			mclk = &clk_xtali;
 		else if (i == 1)
-			mclk_rate = clk_pll1.rate * 2;
-		else if (i == 2)
-			mclk_rate = clk_pll2.rate * 2;
+			mclk = &clk_pll1;
+		else
+			mclk = &clk_pll2;
+		mclk_rate = mclk->rate * 2;
 
 		/* Try each predivider value */
 		for (__pdiv = 4; __pdiv <= 6; __pdiv++) {
@@ -286,7 +359,8 @@ static unsigned long calc_clk_div(unsigned long rate, int *psel, int *esel,
 				*div = __div;
 				*psel = (i == 2);
 				*esel = (i != 0);
-				best_rate = actual_rate;
+				clk->parent = mclk;
+				clk->rate = actual_rate;
 				rate_err = abs(actual_rate - rate);
 				found = 1;
 			}
@@ -294,21 +368,19 @@ static unsigned long calc_clk_div(unsigned long rate, int *psel, int *esel,
 	}
 
 	if (!found)
-		return 0;
+		return -EINVAL;
 
-	return best_rate;
+	return 0;
 }
 
 static int set_div_rate(struct clk *clk, unsigned long rate)
 {
-	unsigned long actual_rate;
-	int psel = 0, esel = 0, pdiv = 0, div = 0;
+	int err, psel = 0, esel = 0, pdiv = 0, div = 0;
 	u32 val;
 
-	actual_rate = calc_clk_div(rate, &psel, &esel, &pdiv, &div);
-	if (actual_rate == 0)
-		return -EINVAL;
-	clk->rate = actual_rate;
+	err = calc_clk_div(clk, rate, &psel, &esel, &pdiv, &div);
+	if (err)
+		return err;
 
 	/* Clear the esel, psel, pdiv and div bits */
 	val = __raw_readl(clk->enable_reg);
@@ -344,7 +416,7 @@ static unsigned long calc_pll_rate(u32 config_word)
 	unsigned long long rate;
 	int i;
 
-	rate = EP93XX_EXT_CLK_RATE;
+	rate = clk_xtali.rate;
 	rate *= ((config_word >> 11) & 0x1f) + 1;		/* X1FBD */
 	rate *= ((config_word >> 5) & 0x3f) + 1;		/* X2FBD */
 	do_div(rate, (config_word & 0x1f) + 1);			/* X2IPD */
@@ -377,7 +449,7 @@ static int __init ep93xx_clock_init(void)
 
 	value = __raw_readl(EP93XX_SYSCON_CLOCK_SET1);
 	if (!(value & 0x00800000)) {			/* PLL1 bypassed?  */
-		clk_pll1.rate = EP93XX_EXT_CLK_RATE;
+		clk_pll1.rate = clk_xtali.rate;
 	} else {
 		clk_pll1.rate = calc_pll_rate(value);
 	}
@@ -388,7 +460,7 @@ static int __init ep93xx_clock_init(void)
 
 	value = __raw_readl(EP93XX_SYSCON_CLOCK_SET2);
 	if (!(value & 0x00080000)) {			/* PLL2 bypassed?  */
-		clk_pll2.rate = EP93XX_EXT_CLK_RATE;
+		clk_pll2.rate = clk_xtali.rate;
 	} else if (value & 0x00040000) {		/* PLL2 enabled?  */
 		clk_pll2.rate = calc_pll_rate(value);
 	} else { 
