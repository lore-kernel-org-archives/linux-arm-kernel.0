From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 16 Sep 2009 18:57:19 -0400
Subject: [PATCH] ep93xx: introduce clk parent
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901CBF45C@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock generation system in the ep93xx uses two external oscillator's
and two internal PLL's to derive all the internal clocks.  Many of these
internal clocks can be stopped to save power.

This introduces a "parent" hierarchy for the clocks so that the users
count can be correctly tracked for power management.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 3dd0e2a..11a2fd5 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -23,6 +23,7 @@
 
 
 struct clk {
+	struct clk	*parent;
 	unsigned long	rate;
 	int		users;
 	int		sw_locked;
@@ -39,89 +40,120 @@ static unsigned long get_uart_rate(struct clk *clk);
 static int set_keytchclk_rate(struct clk *clk, unsigned long rate);
 
 
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
@@ -130,6 +162,7 @@ static struct clk clk_m2m1 = {
 	{ .dev_id = dev, .con_id = con, .clk = ck }
 
 static struct clk_lookup clocks[] = {
+	INIT_CK(NULL,			"xtali",	&clk_xtali),
 	INIT_CK("apb:uart1",		NULL,		&clk_uart1),
 	INIT_CK("apb:uart2",		NULL,		&clk_uart2),
 	INIT_CK("apb:uart3",		NULL,		&clk_uart3),
@@ -158,15 +191,20 @@ static struct clk_lookup clocks[] = {
 
 int clk_enable(struct clk *clk)
 {
-	if (!clk->users++ && clk->enable_reg) {
-		u32 value;
-
-		value = __raw_readl(clk->enable_reg);
-		value |= clk->enable_mask;
-		if (clk->sw_locked)
-			ep93xx_syscon_swlocked_write(value, clk->enable_reg);
-		else
-			__raw_writel(value, clk->enable_reg);
+	if (!clk->users++) {
+		if (clk->parent)
+			clk_enable(clk->parent);
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
 	}
 
 	return 0;
@@ -175,28 +213,34 @@ EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
-	if (!--clk->users && clk->enable_reg) {
-		u32 value;
-
-		value = __raw_readl(clk->enable_reg);
-		value &= ~clk->enable_mask;
-		if (clk->sw_locked)
-			ep93xx_syscon_swlocked_write(value, clk->enable_reg);
-		else
-			__raw_writel(value, clk->enable_reg);
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
+
+		if (clk->parent)
+			clk_disable(clk->parent);
 	}
 }
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
@@ -258,7 +302,7 @@ static unsigned long calc_pll_rate(u32 config_word)
 	unsigned long long rate;
 	int i;
 
-	rate = EP93XX_EXT_CLK_RATE;
+	rate = clk_xtali.rate;
 	rate *= ((config_word >> 11) & 0x1f) + 1;		/* X1FBD */
 	rate *= ((config_word >> 5) & 0x3f) + 1;		/* X2FBD */
 	do_div(rate, (config_word & 0x1f) + 1);			/* X2IPD */
@@ -291,7 +335,7 @@ static int __init ep93xx_clock_init(void)
 
 	value = __raw_readl(EP93XX_SYSCON_CLOCK_SET1);
 	if (!(value & 0x00800000)) {			/* PLL1 bypassed?  */
-		clk_pll1.rate = EP93XX_EXT_CLK_RATE;
+		clk_pll1.rate = clk_xtali.rate;
 	} else {
 		clk_pll1.rate = calc_pll_rate(value);
 	}
@@ -302,7 +346,7 @@ static int __init ep93xx_clock_init(void)
 
 	value = __raw_readl(EP93XX_SYSCON_CLOCK_SET2);
 	if (!(value & 0x00080000)) {			/* PLL2 bypassed?  */
-		clk_pll2.rate = EP93XX_EXT_CLK_RATE;
+		clk_pll2.rate = clk_xtali.rate;
 	} else if (value & 0x00040000) {		/* PLL2 enabled?  */
 		clk_pll2.rate = calc_pll_rate(value);
 	} else { 
