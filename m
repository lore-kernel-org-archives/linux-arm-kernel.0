From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue,  6 Oct 2015 22:28:45 +0200
Subject: [PATCH] watchdog: at91sam9: keep watchdog running in idle mode
Message-ID: <1444163325-3041-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since turning on idle-halt in commit 5161b31dc39a (watchdog:
at91sam9_wdt: better watchdog support"), SoCs compatible with
at91sam9260-wdt not using a device tree no longer reboot if the watchdog
times out while the CPU is in idle state. Removing the
AT91_WDT_WDIDLEHLT flag that was set by default fixes this.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Fixes: 5161b31dc39a ("watchdog: at91sam9_wdt: better watchdog support")
Cc: <stable@vger.kernel.org> # 3.14+
---
 drivers/watchdog/at91sam9_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 7e6acaf..6e3a167 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -339,7 +339,7 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	wdt->mr = (WDT_HW_TIMEOUT * 256) | AT91_WDT_WDRSTEN | AT91_WDT_WDD |
-		  AT91_WDT_WDDBGHLT | AT91_WDT_WDIDLEHLT;
+		  AT91_WDT_WDDBGHLT;
 	wdt->mr_mask = 0x3FFFFFFF;
 	wdt->nowayout = nowayout;
 	wdt->wdd.parent = &pdev->dev;
-- 
2.5.1
