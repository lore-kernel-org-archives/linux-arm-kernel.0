From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 15 Jul 2013 20:32:40 -0300
Subject: [PATCH 07/10] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373931163-12670-8-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of the orion irqchip driver, now the BRIDGE_CAUSE
bit is cleared by it. There's no longer a need to do it in the watchdog
driver, so we can simply remove it.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 3c9b3d2..4a0ab47 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -59,18 +59,11 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 
 static int orion_wdt_start(struct watchdog_device *wdt_dev)
 {
-	u32 reg;
-
 	spin_lock(&wdt_lock);
 
 	/* Set watchdog duration */
 	writel(wdt_tclk * wdt_dev->timeout, wdt_reg);
 
-	/* Clear watchdog timer interrupt */
-	reg = readl(BRIDGE_CAUSE);
-	reg &= ~WDT_INT_REQ;
-	writel(reg, BRIDGE_CAUSE);
-
 	/* Enable watchdog timer */
 	orion_timer_ctrl_clrset(0, WDT_EN);
 
-- 
1.8.1.5
