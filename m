From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Wed, 17 Mar 2010 14:03:31 +0300
Subject: [PATCH 2/2 v2] [ARM] [IMX]: Fix clock use counter from underflow on
	multiple clk_disable().
In-Reply-To: <20100317092042.GB16150@pengutronix.de>
References: <20100317092042.GB16150@pengutronix.de>
Message-ID: <1268823811-9035-1-git-send-email-vzapolskiy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If clk_disable() is called for already disabled clock clk->usecount
value is decremented anyway. This leads to a problem that sequent
clk_enable() call doesn't enable the clock as expected.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/clock.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
index 2daec3c..3189275 100644
--- a/arch/arm/plat-mxc/clock.c
+++ b/arch/arm/plat-mxc/clock.c
@@ -53,10 +53,14 @@ static void __clk_disable(struct clk *clk)
 	if (clk == NULL || IS_ERR(clk))
 		return;
 
+	if (!clk->usecount) {
+		WARN(1, "Trying to disable a clock with 0 usecount\n");
+		return;
+	}
+
 	__clk_disable(clk->parent);
 	__clk_disable(clk->secondary);
 
-	WARN_ON(!clk->usecount);
 	if (!(--clk->usecount) && clk->disable)
 		clk->disable(clk);
 }
-- 
1.6.6.1
