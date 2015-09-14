From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 14 Sep 2015 12:29:39 +0300
Subject: [PATCH] ARM: davinci: clock: Correct return values for API functions
Message-ID: <1442222979-9703-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the values returned by the publicly used functions.
These function should return 0 when they are called with clk == NULL in
similar manner as the clock API does to avoid different behavior in drivers
used by daVinci and other architectures.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Sekhar,

This issue is visible when using generic drivers like ASoC simnple card for
audio support.
They rely on the fact that these functions will not return with error in case
of clk == NULL.

Regards,
Peter

 arch/arm/mach-davinci/clock.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index c70bb0a4dfb4..3caff9637a82 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -97,7 +97,9 @@ int clk_enable(struct clk *clk)
 {
 	unsigned long flags;
 
-	if (clk == NULL || IS_ERR(clk))
+	if (!clk)
+		return 0;
+	else if (IS_ERR(clk))
 		return -EINVAL;
 
 	spin_lock_irqsave(&clockfw_lock, flags);
@@ -124,7 +126,7 @@ EXPORT_SYMBOL(clk_disable);
 unsigned long clk_get_rate(struct clk *clk)
 {
 	if (clk == NULL || IS_ERR(clk))
-		return -EINVAL;
+		return 0;
 
 	return clk->rate;
 }
@@ -159,8 +161,10 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	unsigned long flags;
 	int ret = -EINVAL;
 
-	if (clk == NULL || IS_ERR(clk))
-		return ret;
+	if (!clk)
+		return 0;
+	else if (IS_ERR(clk))
+		return -EINVAL;
 
 	if (clk->set_rate)
 		ret = clk->set_rate(clk, rate);
@@ -181,7 +185,9 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	unsigned long flags;
 
-	if (clk == NULL || IS_ERR(clk))
+	if (!clk)
+		return 0;
+	else if (IS_ERR(clk))
 		return -EINVAL;
 
 	/* Cannot change parent on enabled clock */
-- 
2.5.2
