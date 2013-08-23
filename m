From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 23 Aug 2013 19:12:17 -0300
Subject: [PATCH v2 4/9] watchdog: orion: Remove RSTOUT bit enable/disable
In-Reply-To: <1377295942-5955-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377295942-5955-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377295942-5955-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog RSTOUT bit must be enabled on a per-machine
basis at machine initialization time, either at watchdog device
registration or at reset-controller initialization.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 83350ad..d6f6128 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -37,8 +37,6 @@
 #define WDT_IN_USE		0
 #define WDT_OK_TO_CLOSE		1
 
-#define WDT_RESET_OUT_EN	BIT(1)
-
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = -1;		/* module parameter (seconds) */
 static unsigned int wdt_max_duration;	/* (seconds) */
@@ -73,11 +71,6 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	reg |= WDT_EN;
 	writel(reg, wdt_reg + TIMER_CTRL);
 
-	/* Enable reset on watchdog */
-	reg = readl(RSTOUTn_MASK);
-	reg |= WDT_RESET_OUT_EN;
-	writel(reg, RSTOUTn_MASK);
-
 	spin_unlock(&wdt_lock);
 	return 0;
 }
@@ -88,11 +81,6 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 
 	spin_lock(&wdt_lock);
 
-	/* Disable reset on watchdog */
-	reg = readl(RSTOUTn_MASK);
-	reg &= ~WDT_RESET_OUT_EN;
-	writel(reg, RSTOUTn_MASK);
-
 	/* Disable watchdog timer */
 	reg = readl(wdt_reg + TIMER_CTRL);
 	reg &= ~WDT_EN;
-- 
1.8.1.5
