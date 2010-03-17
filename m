From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Wed, 17 Mar 2010 10:11:56 +0300
Subject: [PATCH 2/2] [ARM] [IMX]: Fix clock usecount counter from underflow.
In-Reply-To: <1268809916-6525-1-git-send-email-vzapolskiy@gmail.com>
References: <1268809916-6525-1-git-send-email-vzapolskiy@gmail.com>
Message-ID: <1268809916-6525-2-git-send-email-vzapolskiy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If clk_disable() is called for already disabled clock clk->usecount
value is decremented anyway. This leads to a problem that sequent
clk_enable() call doesn't enable the clock as expected.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/clock.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
index 2daec3c..fd7596c 100644
--- a/arch/arm/plat-mxc/clock.c
+++ b/arch/arm/plat-mxc/clock.c
@@ -53,10 +53,15 @@ static void __clk_disable(struct clk *clk)
 	if (clk == NULL || IS_ERR(clk))
 		return;
 
+        if (!clk->usecount) {
+                printk(KERN_ERR "Trying to disable a clock with 0 usecount\n");
+                WARN_ON(1);
+                return;
+        }
+
 	__clk_disable(clk->parent);
 	__clk_disable(clk->secondary);
 
-	WARN_ON(!clk->usecount);
 	if (!(--clk->usecount) && clk->disable)
 		clk->disable(clk);
 }
-- 
1.6.6.1
