From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  2 Aug 2011 13:26:30 +0200
Subject: [BUGFIX][PATCH] Fix double inversion bug in clk_disable()
Message-ID: <1312284390-20244-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The condition check for calling the low level disable function is
wrong due to double inversion via '!' and '== 0'.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/clk/clk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 83c6b67..1525e2a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -81,7 +81,7 @@ void clk_disable(struct clk *clk)
 
 	WARN_ON(clk->enable_count == 0);
 
-	if (!--clk->enable_count == 0 && clk->ops->disable)
+	if (--clk->enable_count == 0 && clk->ops->disable)
 		clk->ops->disable(clk);
 
 	spin_unlock_irqrestore(&clk->enable_lock, flags);
-- 
1.5.6.5
