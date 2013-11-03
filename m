From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Sun,  3 Nov 2013 18:52:44 +0100
Subject: [PATCH 3/3] watchdog: at91sam9_wdt: increase security margin on
 watchdog counter reset
In-Reply-To: <1383501164-8111-1-git-send-email-b.brezillon@overkiz.com>
References: <1383501164-8111-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1383501164-8111-4-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Try to reset the watchdog counter 4 or 2 times more often than actually
requested, to avoid spurious watchdog reset.
If this is not possible because of the min_heartbeat value, reset it at
the min_heartbeat period.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/watchdog/at91sam9_wdt.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index ab0c4e0..489729b 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -158,6 +158,7 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 	int err;
 	u32 mask = wdt->mr_mask;
 	unsigned long min_heartbeat = 1;
+	unsigned long max_heartbeat;
 	struct device *dev = &pdev->dev;
 
 	tmp = wdt_read(wdt, AT91_WDT_MR);
@@ -181,23 +182,29 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 	if (delta < value)
 		min_heartbeat = ticks_to_hz_roundup(value - delta);
 
-	wdt->heartbeat = ticks_to_hz_rounddown(value);
-	if (!wdt->heartbeat) {
+	max_heartbeat = ticks_to_hz_rounddown(value);
+	if (!max_heartbeat) {
 		dev_err(dev,
 			"heartbeat is too small for the system to handle it correctly\n");
 		return -EINVAL;
 	}
 
-	if (wdt->heartbeat < min_heartbeat + 4) {
+	/*
+	 * Try to reset the watchdog counter 4 or 2 times more often than
+	 * actually requested, to avoid spurious watchdog reset.
+	 * If this is not possible because of the min_heartbeat value, reset
+	 * it@the min_heartbeat period.
+	 */
+	if ((max_heartbeat / 4) >= min_heartbeat)
+		wdt->heartbeat = max_heartbeat / 4;
+	else if ((max_heartbeat / 2) >= min_heartbeat)
+		wdt->heartbeat = max_heartbeat / 2;
+	else
 		wdt->heartbeat = min_heartbeat;
+
+	if (max_heartbeat < min_heartbeat + 4)
 		dev_warn(dev,
 			 "min heartbeat and max heartbeat might be too close for the system to handle it correctly\n");
-		if (wdt->heartbeat < 4)
-			dev_warn(dev,
-				 "heartbeat might be too small for the system to handle it correctly\n");
-	} else {
-		wdt->heartbeat -= 4;
-	}
 
 	if ((tmp & AT91_WDT_WDFIEN) && wdt->irq) {
 		err = request_irq(wdt->irq, wdt_interrupt,
-- 
1.7.9.5
