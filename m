From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 21 Jan 2014 06:12:29 -0300
Subject: [PATCH v2 03/15] watchdog: orion: Use atomic access for shared
 registers
In-Reply-To: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1390295561-3466-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the timer control register is shared with the clocksource driver,
use the recently introduced atomic_io_clear_set() to access such register.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index f7722a4..cf64510 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -61,8 +61,6 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 
 static int orion_wdt_start(struct watchdog_device *wdt_dev)
 {
-	u32 reg;
-
 	spin_lock(&wdt_lock);
 
 	/* Set watchdog duration */
@@ -72,14 +70,10 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	writel(~WDT_INT_REQ, BRIDGE_CAUSE);
 
 	/* Enable watchdog timer */
-	reg = readl(wdt_reg + TIMER_CTRL);
-	reg |= WDT_EN;
-	writel(reg, wdt_reg + TIMER_CTRL);
+	atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, WDT_EN);
 
 	/* Enable reset on watchdog */
-	reg = readl(RSTOUTn_MASK);
-	reg |= WDT_RESET_OUT_EN;
-	writel(reg, RSTOUTn_MASK);
+	atomic_io_modify(RSTOUTn_MASK, WDT_RESET_OUT_EN, WDT_RESET_OUT_EN);
 
 	spin_unlock(&wdt_lock);
 	return 0;
@@ -87,19 +81,13 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 
 static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 {
-	u32 reg;
-
 	spin_lock(&wdt_lock);
 
 	/* Disable reset on watchdog */
-	reg = readl(RSTOUTn_MASK);
-	reg &= ~WDT_RESET_OUT_EN;
-	writel(reg, RSTOUTn_MASK);
+	atomic_io_modify(RSTOUTn_MASK, WDT_RESET_OUT_EN, 0);
 
 	/* Disable watchdog timer */
-	reg = readl(wdt_reg + TIMER_CTRL);
-	reg &= ~WDT_EN;
-	writel(reg, wdt_reg + TIMER_CTRL);
+	atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, 0);
 
 	spin_unlock(&wdt_lock);
 	return 0;
-- 
1.8.1.5
