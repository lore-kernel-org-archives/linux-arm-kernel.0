From: abailon@baylibre.com (Alexandre Bailon)
Date: Fri,  9 Dec 2016 17:59:32 +0100
Subject: [PATCH v7 1/2] provide lock-less versions of clk_{enable|disable}
Message-ID: <1481302773-14181-1-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename __clk_{enable|disble} in davinci_clk_{enable|disable}.
davinci_clk_{enable|disable} is a lock-less version of
clk_{enable|disable}.
This is useful to recursively enable clock without doing recursive call
to clk_enable(), which would cause a recursive locking issue.
The lock-less version could be used by example by the usb20 phy clock,
that need to enable the usb20 clock before to start.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Suggested-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/clock.c | 12 ++++++------
 arch/arm/mach-davinci/clock.h |  2 ++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index df42c93..f5dce9b 100644
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
@@ -44,7 +44,7 @@ static void __clk_enable(struct clk *clk)
 	}
 }
 
-static void __clk_disable(struct clk *clk)
+void davinci_clk_disable(struct clk *clk)
 {
 	if (WARN_ON(clk->usecount == 0))
 		return;
@@ -56,7 +56,7 @@ static void __clk_disable(struct clk *clk)
 			clk->clk_disable(clk);
 	}
 	if (clk->parent)
-		__clk_disable(clk->parent);
+		davinci_clk_disable(clk->parent);
 }
 
 int davinci_clk_reset(struct clk *clk, bool reset)
@@ -103,7 +103,7 @@ int clk_enable(struct clk *clk)
 		return -EINVAL;
 
 	spin_lock_irqsave(&clockfw_lock, flags);
-	__clk_enable(clk);
+	davinci_clk_enable(clk);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return 0;
@@ -118,7 +118,7 @@ void clk_disable(struct clk *clk)
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
