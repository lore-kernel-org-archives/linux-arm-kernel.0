From: stigge@antcom.de (Roland Stigge)
Date: Wed,  8 Feb 2012 21:41:05 +0100
Subject: [PATCH v4 7/7] ARM: LPC32xx: clock.c: Fix mutex lock issues
In-Reply-To: <1328733665-17836-1-git-send-email-stigge@antcom.de>
References: <1328733665-17836-1-git-send-email-stigge@antcom.de>
Message-ID: <1328733665-17836-8-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the mutex issue in clock.c, as done in Kevin Wells' original
driver update:

In some cases, the clock drivers could grab a mutex twice in an improper
context. This patch changes the mutex mechanism to a simple irq lock/unlock
mechanism and removes un-needed locks from some functions.

(See also git.lpclinux.com)

Signed-off-by: Roland Stigge <stigge@antcom.de>
Tested-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Kevin Wells <kevin.wells@nxp.com>

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 0606a63..0e01bf4 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -98,9 +98,10 @@
 #include "clock.h"
 #include "common.h"
 
+static DEFINE_SPINLOCK(global_clkregs_lock);
+
 static struct clk clk_armpll;
 static struct clk clk_usbpll;
-static DEFINE_MUTEX(clkm_lock);
 
 /*
  * Post divider values for PLLs based on selected register value
@@ -892,16 +893,6 @@ static struct clk clk_lcd = {
 	.enable_mask	= LPC32XX_CLKPWR_LCDCTRL_CLK_EN,
 };
 
-static inline void clk_lock(void)
-{
-	mutex_lock(&clkm_lock);
-}
-
-static inline void clk_unlock(void)
-{
-	mutex_unlock(&clkm_lock);
-}
-
 static void local_clk_disable(struct clk *clk)
 {
 	/* Don't attempt to disable clock if it has no users */
@@ -946,10 +937,11 @@ static int local_clk_enable(struct clk *clk)
 int clk_enable(struct clk *clk)
 {
 	int ret;
+	unsigned long flags;
 
-	clk_lock();
+	spin_lock_irqsave(&global_clkregs_lock, flags);
 	ret = local_clk_enable(clk);
-	clk_unlock();
+	spin_unlock_irqrestore(&global_clkregs_lock, flags);
 
 	return ret;
 }
@@ -960,9 +952,11 @@ EXPORT_SYMBOL(clk_enable);
  */
 void clk_disable(struct clk *clk)
 {
-	clk_lock();
+	unsigned long flags;
+
+	spin_lock_irqsave(&global_clkregs_lock, flags);
 	local_clk_disable(clk);
-	clk_unlock();
+	spin_unlock_irqrestore(&global_clkregs_lock, flags);
 }
 EXPORT_SYMBOL(clk_disable);
 
@@ -971,13 +965,7 @@ EXPORT_SYMBOL(clk_disable);
  */
 unsigned long clk_get_rate(struct clk *clk)
 {
-	unsigned long rate;
-
-	clk_lock();
-	rate = clk->get_rate(clk);
-	clk_unlock();
-
-	return rate;
+	return clk->get_rate(clk);
 }
 EXPORT_SYMBOL(clk_get_rate);
 
@@ -993,11 +981,8 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	 * the actual rate set as part of the peripheral dividers
 	 * instead of high level clock control
 	 */
-	if (clk->set_rate) {
-		clk_lock();
+	if (clk->set_rate)
 		ret = clk->set_rate(clk, rate);
-		clk_unlock();
-	}
 
 	return ret;
 }
@@ -1008,15 +993,11 @@ EXPORT_SYMBOL(clk_set_rate);
  */
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	clk_lock();
-
 	if (clk->round_rate)
 		rate = clk->round_rate(clk, rate);
 	else
 		rate = clk->get_rate(clk);
 
-	clk_unlock();
-
 	return rate;
 }
 EXPORT_SYMBOL(clk_round_rate);
