From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu,  8 Oct 2015 23:34:33 +0200
Subject: [PATCH 5/6] watchdog: at91sam9: remove unused pdata support
In-Reply-To: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1444340074-15437-6-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All SoC using this driver were converted to device tree. Remove pdata
support and initialization steps which are only used for pdata.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/watchdog/at91sam9_wdt.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 8629f48..5d3e8c0 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -62,9 +62,6 @@
 /* Watchdog max delta/value in secs */
 #define WDT_COUNTER_MAX_SECS	ticks_to_secs(WDT_COUNTER_MAX_TICKS)
 
-/* Hardware timeout in seconds */
-#define WDT_HW_TIMEOUT 16
-
 /* User land default timeout */
 #define WDT_DEFAULT_TIMEOUT 15
 
@@ -261,7 +258,6 @@ static const struct watchdog_ops at91_wdt_ops = {
 	.set_timeout =	at91_wdt_set_timeout,
 };
 
-#if defined(CONFIG_OF)
 static int of_at91wdt_init(struct device_node *np, struct at91wdt *wdt)
 {
 	u32 min = 0;
@@ -317,12 +313,6 @@ static int of_at91wdt_init(struct device_node *np, struct at91wdt *wdt)
 
 	return 0;
 }
-#else
-static inline int of_at91wdt_init(struct device_node *np, struct at91wdt *wdt)
-{
-	return 0;
-}
-#endif
 
 static int __init at91wdt_probe(struct platform_device *pdev)
 {
@@ -334,9 +324,6 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 	if (!wdt)
 		return -ENOMEM;
 
-	wdt->mr = (WDT_HW_TIMEOUT * 256) | AT91_WDT_WDRSTEN | AT91_WDT_WDD |
-		  AT91_WDT_WDDBGHLT;
-	wdt->mr_mask = 0x3FFFFFFF;
 	wdt->wdd.parent = &pdev->dev;
 	wdt->wdd.info = &at91_wdt_info;
 	wdt->wdd.ops = &at91_wdt_ops;
@@ -396,14 +383,12 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_OF)
 static const struct of_device_id at91_wdt_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9260-wdt" },
 	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
-#endif
 
 static struct platform_driver at91wdt_driver = {
 	.remove		= __exit_p(at91wdt_remove),
-- 
2.5.1
