From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 21 Jan 2014 10:26:05 -0300
Subject: [PATCH v3 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1390310774-20781-7-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After adding the IRQ request, the BRIDGE_CAUSE bit should be cleared by the
bridge interrupt controller. There's no longer a need to do it in the watchdog
driver, so we can simply remove it.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 19e4adc..7889309 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -24,7 +24,6 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <mach/bridge-regs.h>
 
 /*
  * Watchdog timer block registers.
@@ -38,7 +37,6 @@
 #define WDT_OK_TO_CLOSE		1
 
 #define WDT_RESET_OUT_EN	BIT(1)
-#define WDT_INT_REQ		BIT(3)
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static int heartbeat = -1;		/* module parameter (seconds) */
@@ -60,9 +58,6 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	/* Set watchdog duration */
 	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
 
-	/* Clear watchdog timer interrupt */
-	writel(~WDT_INT_REQ, BRIDGE_CAUSE);
-
 	/* Enable watchdog timer */
 	atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, WDT_EN);
 
-- 
1.8.1.5
