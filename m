From: jc.lee@samsung.com (Jaecheol Lee)
Date: Tue, 12 Oct 2010 09:39:40 +0900
Subject: [PATCH] ARM: SAMSUNG: Bug fix spin_lock recursion in clk_enable() and
	clk_disable()
Message-ID: <1286843980-23684-1-git-send-email-jc.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Minho Ban <mhban@samsung.com>

The clk_enable() and clk_disable() can be used process and ISR either.
So spin_lock_irqsave should be used instead.

Signed-off-by: Minho Ban <mhban@samsung.com>
Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
---
 arch/arm/plat-samsung/clock.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
index e8d20b0..2a991a5 100644
--- a/arch/arm/plat-samsung/clock.c
+++ b/arch/arm/plat-samsung/clock.c
@@ -138,31 +138,35 @@ void clk_put(struct clk *clk)
 
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
1.6.2.5
