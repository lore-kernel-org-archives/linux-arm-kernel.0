From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 27 Jan 2012 14:17:23 +0900
Subject: [PATCH] ARM: SAMSUNG: use spin_lock_irqsave() in clk_{enable, disable}
Message-ID: <01a001ccdcb2$f3a3f600$daebe200$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Minho Ban <mhban@samsung.com>

The clk_enable()and clk_disable() can be called in process and ISR
either. Actually that is used for real product and other platforms
now. So it's time to use spin_lock_irqsave() instead.

Signed-off-by: Minho Ban <mhban@samsung.com>
Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Sunyoung Kang <sy0816.kang@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Note: There were discussion about this before.
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/028788.html

As we discussed, actually that is used for real product and other platforms
now. Plus, we don't need to change the PLL during kernel so the latency
doesn't matter. I think it's time to use spin_lock_irqsave() instead.

 arch/arm/plat-samsung/clock.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
index 10f7117..65c5eca 100644
--- a/arch/arm/plat-samsung/clock.c
+++ b/arch/arm/plat-samsung/clock.c
@@ -84,31 +84,35 @@ static int clk_null_enable(struct clk *clk, int enable)
 
 int clk_enable(struct clk *clk)
 {
+	unsigned long flags;
+
 	if (IS_ERR(clk) || clk == NULL)
 		return -EINVAL;
 
 	clk_enable(clk->parent);
 
-	spin_lock(&clocks_lock);
+	spin_lock_irqsave(&clocks_lock, flags);
 
 	if ((clk->usage++) == 0)
 		(clk->enable)(clk, 1);
 
-	spin_unlock(&clocks_lock);
+	spin_unlock_irqrestore(&clocks_lock, flags);
 	return 0;
 }
 
 void clk_disable(struct clk *clk)
 {
+	unsigned long flags;
+
 	if (IS_ERR(clk) || clk == NULL)
 		return;
 
-	spin_lock(&clocks_lock);
+	spin_lock_irqsave(&clocks_lock, flags);
 
 	if ((--clk->usage) == 0)
 		(clk->enable)(clk, 0);
 
-	spin_unlock(&clocks_lock);
+	spin_unlock_irqrestore(&clocks_lock, flags);
 	clk_disable(clk->parent);
 }
 
-- 
1.7.1
