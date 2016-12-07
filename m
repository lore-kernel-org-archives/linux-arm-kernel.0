From: abailon@baylibre.com (Alexandre Bailon)
Date: Wed,  7 Dec 2016 18:09:26 +0100
Subject: [PATCH v6 1/2] ARM: davinci: Export two clocks function
Message-ID: <1481130567-27829-1-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename and export __clk_enable() and __clk_disable() in order
to use them from usb-da8xx.c. This file implements the usb20 phy clock
that must be able to enable or disable usb20 clock.
To prevent a recurssive call to clk_enable() that would cause a recursive
locking issue, we must use __clk_enable() and __clk_disable().
Rename these methods in davinci_clk_enable() and davinci_clk_disable(),
and export them.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Suggested-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/clock.c | 14 ++++++++------
 arch/arm/mach-davinci/clock.h |  2 ++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index df42c93..0f967c3 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -31,10 +31,10 @@ static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
 static DEFINE_SPINLOCK(clockfw_lock);
 
-static void __clk_enable(struct clk *clk)
+void davinci_clk_enable(struct clk *clk)
 {
 	if (clk->parent)
-		__clk_enable(clk->parent);
+		davinci_clk_enable(clk->parent);
 	if (clk->usecount++ == 0) {
 		if (clk->flags & CLK_PSC)
 			davinci_psc_config(clk->domain, clk->gpsc, clk->lpsc,
@@ -43,8 +43,9 @@ static void __clk_enable(struct clk *clk)
 			clk->clk_enable(clk);
 	}
 }
+EXPORT_SYMBOL(davinci_clk_enable);
 
-static void __clk_disable(struct clk *clk)
+void davinci_clk_disable(struct clk *clk)
 {
 	if (WARN_ON(clk->usecount == 0))
 		return;
@@ -56,8 +57,9 @@ static void __clk_disable(struct clk *clk)
 			clk->clk_disable(clk);
 	}
 	if (clk->parent)
-		__clk_disable(clk->parent);
+		davinci_clk_disable(clk->parent);
 }
+EXPORT_SYMBOL(davinci_clk_disable);
 
 int davinci_clk_reset(struct clk *clk, bool reset)
 {
@@ -103,7 +105,7 @@ int clk_enable(struct clk *clk)
 		return -EINVAL;
 
 	spin_lock_irqsave(&clockfw_lock, flags);
-	__clk_enable(clk);
+	davinci_clk_enable(clk);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return 0;
@@ -118,7 +120,7 @@ void clk_disable(struct clk *clk)
 		return;
 
 	spin_lock_irqsave(&clockfw_lock, flags);
-	__clk_disable(clk);
+	davinci_clk_disable(clk);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 }
 EXPORT_SYMBOL(clk_disable);
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index e2a5437..fa2b837 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -132,6 +132,8 @@ int davinci_set_sysclk_rate(struct clk *clk, unsigned long rate);
 int davinci_set_refclk_rate(unsigned long rate);
 int davinci_simple_set_rate(struct clk *clk, unsigned long rate);
 int davinci_clk_reset(struct clk *clk, bool reset);
+void davinci_clk_enable(struct clk *clk);
+void davinci_clk_disable(struct clk *clk);
 
 extern struct platform_device davinci_wdt_device;
 extern void davinci_watchdog_reset(struct platform_device *);
-- 
2.7.3
