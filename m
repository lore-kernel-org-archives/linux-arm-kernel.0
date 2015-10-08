From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu,  8 Oct 2015 23:34:32 +0200
Subject: [PATCH 4/6] watchdog: at91sam9: remove nowayout useless copy
In-Reply-To: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1444340074-15437-5-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nowayout is a global variable set by module parameter, remove the
nowayout useless copy.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/watchdog/at91sam9_wdt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 2c506e0..8629f48 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -86,7 +86,6 @@ struct at91wdt {
 	u32 mr;
 	u32 mr_mask;
 	unsigned long heartbeat;	/* WDT heartbeat in jiffies */
-	bool nowayout;
 	unsigned int irq;
 	struct clk *sclk;
 };
@@ -233,7 +232,7 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 	/* Try to set timeout from device tree first */
 	if (watchdog_init_timeout(&wdt->wdd, 0, dev))
 		watchdog_init_timeout(&wdt->wdd, wdt_timeout, dev);
-	watchdog_set_nowayout(&wdt->wdd, wdt->nowayout);
+	watchdog_set_nowayout(&wdt->wdd, nowayout);
 	err = watchdog_register_device(&wdt->wdd);
 	if (err)
 		goto out_stop_timer;
@@ -338,7 +337,6 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 	wdt->mr = (WDT_HW_TIMEOUT * 256) | AT91_WDT_WDRSTEN | AT91_WDT_WDD |
 		  AT91_WDT_WDDBGHLT;
 	wdt->mr_mask = 0x3FFFFFFF;
-	wdt->nowayout = nowayout;
 	wdt->wdd.parent = &pdev->dev;
 	wdt->wdd.info = &at91_wdt_info;
 	wdt->wdd.ops = &at91_wdt_ops;
@@ -376,7 +374,7 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, wdt);
 
 	pr_info("initialized (timeout=%d sec, nowayout=%d)\n",
-		wdt->wdd.timeout, wdt->nowayout);
+		wdt->wdd.timeout, nowayout);
 
 	return 0;
 
-- 
2.5.1
