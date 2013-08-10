From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 10 Aug 2013 09:43:02 -0300
Subject: [PATCH 3/3] watchdog: orion: Use atomic access for shared registers
In-Reply-To: <1376138582-7550-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1376138582-7550-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1376138582-7550-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the timer control register is shared with the clocksource driver,
use the recently introduced atomic_io_clear_set() to access such register.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 4ea5fcc..de35ae9 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -73,9 +73,7 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	writel(~WDT_INT_REQ, BRIDGE_CAUSE);
 
 	/* Enable watchdog timer */
-	reg = readl(wdt_reg + TIMER_CTRL);
-	reg |= WDT_EN;
-	writel(reg, wdt_reg + TIMER_CTRL);
+	atomic_io_clear_set(wdt_reg + TIMER_CTRL, 0, WDT_EN);
 
 	/* Enable reset on watchdog */
 	reg = readl(RSTOUTn_MASK);
@@ -98,9 +96,7 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 	writel(reg, RSTOUTn_MASK);
 
 	/* Disable watchdog timer */
-	reg = readl(wdt_reg + TIMER_CTRL);
-	reg &= ~WDT_EN;
-	writel(reg, wdt_reg + TIMER_CTRL);
+	atomic_io_clear_set(wdt_reg + TIMER_CTRL, WDT_EN, 0);
 
 	spin_unlock(&wdt_lock);
 	return 0;
-- 
1.8.1.5
