From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Sep 2012 08:53:15 +0200
Subject: [PATCH 1/2] ARM: i.MX clk pllv1: move mxc_decode_pll code to its user
In-Reply-To: <1347346396-27669-1-git-send-email-s.hauer@pengutronix.de>
References: <1347346396-27669-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1347346396-27669-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only code using mxc_decode_pll is clk-pllv1.c, so move the code
there.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk-pllv1.c          |   47 +++++++++++++++++++++++++++++++-
 arch/arm/plat-mxc/clock.c              |   45 ------------------------------
 arch/arm/plat-mxc/include/mach/clock.h |    2 --
 3 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv1.c b/arch/arm/mach-imx/clk-pllv1.c
index 2d856f9..4a03c93 100644
--- a/arch/arm/mach-imx/clk-pllv1.c
+++ b/arch/arm/mach-imx/clk-pllv1.c
@@ -29,8 +29,53 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
 	struct clk_pllv1 *pll = to_clk_pllv1(hw);
+	long long ll;
+	int mfn_abs;
+	unsigned int mfi, mfn, mfd, pd;
+	u32 reg;
+	unsigned long rate;
 
-	return mxc_decode_pll(readl(pll->base), parent_rate);
+	reg = readl(pll->base);
+
+	/*
+	 * Get the resulting clock rate from a PLL register value and the input
+	 * frequency. PLLs with this register layout can be found on i.MX1,
+	 * i.MX21, i.MX27 and i,MX31
+	 *
+	 *                  mfi + mfn / (mfd + 1)
+	 *  f = 2 * f_ref * --------------------
+	 *                        pd + 1
+	 */
+
+	mfi = (reg >> 10) & 0xf;
+	mfn = reg & 0x3ff;
+	mfd = (reg >> 16) & 0x3ff;
+	pd =  (reg >> 26) & 0xf;
+
+	mfi = mfi <= 5 ? 5 : mfi;
+
+	mfn_abs = mfn;
+
+	/*
+	 * On all i.MXs except i.MX1 and i.MX21 mfn is a 10bit
+	 * 2's complements number
+	 */
+	if (!cpu_is_mx1() && !cpu_is_mx21() && mfn >= 0x200)
+		mfn_abs = 0x400 - mfn;
+
+	rate = parent_rate * 2;
+	rate /= pd + 1;
+
+	ll = (unsigned long long)rate * mfn_abs;
+
+	do_div(ll, mfd + 1);
+
+	if (!cpu_is_mx1() && !cpu_is_mx21() && mfn >= 0x200)
+		ll = -ll;
+
+	ll = (rate * mfi) + ll;
+
+	return ll;
 }
 
 struct clk_ops clk_pllv1_ops = {
diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
index 5079787..0ed0954 100644
--- a/arch/arm/plat-mxc/clock.c
+++ b/arch/arm/plat-mxc/clock.c
@@ -210,48 +210,3 @@ EXPORT_SYMBOL(clk_get_parent);
 DEFINE_SPINLOCK(imx_ccm_lock);
 
 #endif /* CONFIG_COMMON_CLK */
-
-/*
- * Get the resulting clock rate from a PLL register value and the input
- * frequency. PLLs with this register layout can at least be found on
- * MX1, MX21, MX27 and MX31
- *
- *                  mfi + mfn / (mfd + 1)
- *  f = 2 * f_ref * --------------------
- *                        pd + 1
- */
-unsigned long mxc_decode_pll(unsigned int reg_val, u32 freq)
-{
-	long long ll;
-	int mfn_abs;
-	unsigned int mfi, mfn, mfd, pd;
-
-	mfi = (reg_val >> 10) & 0xf;
-	mfn = reg_val & 0x3ff;
-	mfd = (reg_val >> 16) & 0x3ff;
-	pd =  (reg_val >> 26) & 0xf;
-
-	mfi = mfi <= 5 ? 5 : mfi;
-
-	mfn_abs = mfn;
-
-	/* On all i.MXs except i.MX1 and i.MX21 mfn is a 10bit
-	 * 2's complements number
-	 */
-	if (!cpu_is_mx1() && !cpu_is_mx21() && mfn >= 0x200)
-		mfn_abs = 0x400 - mfn;
-
-	freq *= 2;
-	freq /= pd + 1;
-
-	ll = (unsigned long long)freq * mfn_abs;
-
-	do_div(ll, mfd + 1);
-
-	if (!cpu_is_mx1() && !cpu_is_mx21() && mfn >= 0x200)
-		ll = -ll;
-
-	ll = (freq * mfi) + ll;
-
-	return ll;
-}
diff --git a/arch/arm/plat-mxc/include/mach/clock.h b/arch/arm/plat-mxc/include/mach/clock.h
index bd940c7..0c4ad77 100644
--- a/arch/arm/plat-mxc/include/mach/clock.h
+++ b/arch/arm/plat-mxc/include/mach/clock.h
@@ -64,7 +64,5 @@ void clk_unregister(struct clk *clk);
 
 extern spinlock_t imx_ccm_lock;
 
-unsigned long mxc_decode_pll(unsigned int pll, u32 f_ref);
-
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_MXC_CLOCK_H__ */
-- 
1.7.10.4
