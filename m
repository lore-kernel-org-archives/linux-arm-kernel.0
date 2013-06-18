From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 18 Jun 2013 17:20:32 +0100
Subject: [PATCH 2/2] Watchdog: fix clearing of the watchdog interrupt
Message-ID: <E1Uoye0-0001Cw-Po@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bits in BRIDGE_CAUSE are documented as RW0C - read, write 0 to
clear.  If we read the register, mask off the watchdog bit, and
write it back, we're actually clearing every interrupt which wasn't
pending at the time we read the register - and that is racy.

Fix this to only write ~WATCHDOG_BIT to the register, which means
we write as zero only the watchdog bit.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/watchdog/orion_wdt.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 4074244..4ea5fcc 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -70,9 +70,7 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
 
 	/* Clear watchdog timer interrupt */
-	reg = readl(BRIDGE_CAUSE);
-	reg &= ~WDT_INT_REQ;
-	writel(reg, BRIDGE_CAUSE);
+	writel(~WDT_INT_REQ, BRIDGE_CAUSE);
 
 	/* Enable watchdog timer */
 	reg = readl(wdt_reg + TIMER_CTRL);
-- 
1.7.4.4
