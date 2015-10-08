From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu,  8 Oct 2015 23:34:31 +0200
Subject: [PATCH 3/6] watchdog: at91sam9: rename heartbeats into timeout where
 necessary
In-Reply-To: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1444340074-15437-4-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a confusing naming here, heartbeats is used instead of timeout
where the real meaning is timeout in various places.

Remove the unused WDT_TIMEOUT variable, which used to be a heartbeat
value. Rename WDT_HEARTBEAT into WDT_DEFAULT_TIMEOUT and rename
"heartbeats" into "timeout" in pr_ strings where necessary.

Rename the "enabled" in the watchdog welcome message ("enabled (timeout
= %d sec, nowayout = %d)\n") to "initialized", the watchdog user land
timeout and nowayout values are not used before userland starts to pat
the watchdog, reduce confusion by not telling those values are used
right now while there are not.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/watchdog/at91sam9_wdt.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 8c1c9de..2c506e0 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -65,15 +65,13 @@
 /* Hardware timeout in seconds */
 #define WDT_HW_TIMEOUT 16
 
-/* Timer heartbeat (500ms) */
-#define WDT_TIMEOUT	(HZ/2)
+/* User land default timeout */
+#define WDT_DEFAULT_TIMEOUT 15
 
-/* User land timeout */
-#define WDT_HEARTBEAT 15
-static int heartbeat;
-module_param(heartbeat, int, 0);
-MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. "
-	"(default = " __MODULE_STRING(WDT_HEARTBEAT) ")");
+static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
+module_param(wdt_timeout, int, 0);
+MODULE_PARM_DESC(wdt_timeout, "Watchdog timeout in seconds. "
+	"(default = " __MODULE_STRING(WDT_DEFAULT_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
@@ -234,7 +232,7 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 
 	/* Try to set timeout from device tree first */
 	if (watchdog_init_timeout(&wdt->wdd, 0, dev))
-		watchdog_init_timeout(&wdt->wdd, heartbeat, dev);
+		watchdog_init_timeout(&wdt->wdd, wdt_timeout, dev);
 	watchdog_set_nowayout(&wdt->wdd, wdt->nowayout);
 	err = watchdog_register_device(&wdt->wdd);
 	if (err)
@@ -344,7 +342,7 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 	wdt->wdd.parent = &pdev->dev;
 	wdt->wdd.info = &at91_wdt_info;
 	wdt->wdd.ops = &at91_wdt_ops;
-	wdt->wdd.timeout = WDT_HEARTBEAT;
+	wdt->wdd.timeout = wdt_timeout;
 	wdt->wdd.min_timeout = 1;
 	wdt->wdd.max_timeout = 0xFFFF;
 
@@ -377,7 +375,7 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdt);
 
-	pr_info("enabled (heartbeat=%d sec, nowayout=%d)\n",
+	pr_info("initialized (timeout=%d sec, nowayout=%d)\n",
 		wdt->wdd.timeout, wdt->nowayout);
 
 	return 0;
-- 
2.5.1
