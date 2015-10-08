From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu,  8 Oct 2015 23:34:30 +0200
Subject: [PATCH 2/6] watchdog: at91sam9: use watchdog_get_drvdata instead of
 container_of
In-Reply-To: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1444340074-15437-3-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use watchdog_get_drvdata instead of container_of.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/watchdog/at91sam9_wdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 88f56b5..8c1c9de 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -80,7 +80,6 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-#define to_wdt(wdd) container_of(wdd, struct at91wdt, wdd)
 struct at91wdt {
 	struct watchdog_device wdd;
 	void __iomem *base;
@@ -134,7 +133,7 @@ static void at91_ping(unsigned long data)
 
 static int at91_wdt_start(struct watchdog_device *wdd)
 {
-	struct at91wdt *wdt = to_wdt(wdd);
+	struct at91wdt *wdt = watchdog_get_drvdata(wdd);
 	/* calculate when the next userspace timeout will be */
 	wdt->next_heartbeat = jiffies + wdd->timeout * HZ;
 	return 0;
@@ -349,6 +348,8 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 	wdt->wdd.min_timeout = 1;
 	wdt->wdd.max_timeout = 0xFFFF;
 
+	watchdog_set_drvdata(&wdt->wdd, wdt);
+
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	wdt->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(wdt->base))
-- 
2.5.1
