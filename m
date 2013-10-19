From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Oct 2013 13:12:18 +0100
Subject: imx-drm: Add HDMI support
In-Reply-To: <20131017203545.GV25034@n2100.arm.linux.org.uk>
References: <52602EEA.6060402@prisktech.co.nz>
 <20131017193948.GT25034@n2100.arm.linux.org.uk>
 <1382039535.976669051@f130.i.mail.ru>
 <20131017203545.GV25034@n2100.arm.linux.org.uk>
Message-ID: <20131019121218.GH25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, more on this.

If I switch to using the DI clock, sourced from PLL5, and then "fix"
the clock tree such that I can change PLL5's rate, then I get most of
the display modes working.

However, it will occasionally not work, and when that happens I need
to reboot to get any kind of output working again.  I haven't delved
into it with the scope to find out what the HDMI clock is doing yet.

Having solved it, what I think is going on is as follows:

When one of the PLLs is prepared and then subsequently enabled, the
following sequence is used:

- Clear bypass
- Power up the PLL
- Wait for the PLL to indicate lock
- Enable output

This causes problems for me.  If I change this to:

- Power up the PLL
- Wait for PLL to indicate lock
- Clear bypass
- Enable output

then I don't see any problems.  My theory is that the bypass mux and/or
enable gate settings are synchronised with the mux output, and if the
mux output glitches while the PLL is gaining lock, it knocks that out
preventing the output from ever being enabled until the chip is hit with
a reset.

The other issue is that the set_rate() functions don't wait for the PLL
to lock before returning, and don't set bypass mode.  It looks like this
code relies on drivers unpreparing the clocks before calling clk_set_rate().
I don't see the clk API enforcing this in any way, so I'd suggest that
the set_rate() function also does the bypass -> set rate -> wait lock
-> clear bypass transition too.  Maybe this should be applied to the
other PLLs too.

Here's a diff which updates the av PLL to do this:

 arch/arm/mach-imx/clk-pllv3.c |   77 ++++++++++++++++++++++++++++------------
 1 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
index f6640b6..11a7048 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -45,21 +45,10 @@ struct clk_pllv3 {
 
 #define to_clk_pllv3(_hw) container_of(_hw, struct clk_pllv3, hw)
 
-static int clk_pllv3_prepare(struct clk_hw *hw)
+static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
 {
-	struct clk_pllv3 *pll = to_clk_pllv3(hw);
-	unsigned long timeout;
-	u32 val;
-
-	val = readl_relaxed(pll->base);
-	val &= ~BM_PLL_BYPASS;
-	if (pll->powerup_set)
-		val |= BM_PLL_POWER;
-	else
-		val &= ~BM_PLL_POWER;
-	writel_relaxed(val, pll->base);
+	unsigned long timeout = jiffies + msecs_to_jiffies(100);
 
-	timeout = jiffies + msecs_to_jiffies(10);
 	/* Wait for PLL to lock */
 	do {
 		if (readl_relaxed(pll->base) & BM_PLL_LOCK)
@@ -68,10 +57,31 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
 			break;
 	} while (1);
 
-	if (readl_relaxed(pll->base) & BM_PLL_LOCK)
-		return 0;
+	return readl_relaxed(pll->base) & BM_PLL_LOCK ? 0 : -ETIMEDOUT;
+}
+
+static int clk_pllv3_prepare(struct clk_hw *hw)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	u32 val, newval;
+	int ret;
+
+	val = readl_relaxed(pll->base);
+	if (pll->powerup_set)
+		newval = val | BM_PLL_POWER;
 	else
-		return -ETIMEDOUT;
+		newval = val & ~BM_PLL_POWER;
+	writel_relaxed(newval, pll->base);
+
+	ret = clk_pllv3_wait_lock(pll);
+	if (ret == 0) {
+		newval &= ~BM_PLL_BYPASS;
+		writel_relaxed(newval, pll->base);
+	} else {
+		writel_relaxed(val, pll->base);
+	}
+
+	return ret;
 }
 
 static void clk_pllv3_unprepare(struct clk_hw *hw)
@@ -80,6 +90,7 @@ static void clk_pllv3_unprepare(struct clk_hw *hw)
 	u32 val;
 
 	val = readl_relaxed(pll->base);
+	pr_info("%s: 0x%08x\n", __func__, val);
 	val |= BM_PLL_BYPASS;
 	if (pll->powerup_set)
 		val &= ~BM_PLL_POWER;
@@ -256,9 +267,10 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
 	unsigned long min_rate = parent_rate * 27;
 	unsigned long max_rate = parent_rate * 54;
-	u32 val, div;
+	u32 val, newval, div;
 	u32 mfn, mfd = 1000000;
 	s64 temp64;
+	int ret;
 
 	if (rate < min_rate || rate > max_rate)
 		return -EINVAL;
@@ -270,13 +282,32 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
 	mfn = temp64;
 
 	val = readl_relaxed(pll->base);
-	val &= ~pll->div_mask;
-	val |= div;
-	writel_relaxed(val, pll->base);
+
+	/* set the PLL into bypass mode */
+	newval = val | BM_PLL_BYPASS;
+	writel_relaxed(newval, pll->base);
+
+	/* configure the new frequency */
+	newval &= ~pll->div_mask;
+	newval |= div;
+	writel_relaxed(newval, pll->base);
 	writel_relaxed(mfn, pll->base + PLL_NUM_OFFSET);
-	writel_relaxed(mfd, pll->base + PLL_DENOM_OFFSET);
+	writel(mfd, pll->base + PLL_DENOM_OFFSET);
+
+	if (val & BM_PLL_POWER) {
+		/* PLL is powered down */
+		ret = 0;
+	} else {
+		ret = clk_pllv3_wait_lock(pll);
+		if (ret == 0) {
+			/* only if it locked can we switch back to the PLL */
+			newval &= ~BM_PLL_BYPASS;
+			newval |= val & BM_PLL_BYPASS;
+			writel(newval, pll->base);
+		}
+	}
 
-	return 0;
+	return ret;
 }
 
 static const struct clk_ops clk_pllv3_av_ops = {
