From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Sat,  5 Jan 2013 10:38:47 +0800
Subject: [v3 PATCH 7/9] watchdog/at91sam9_wdt: Use module_platform_driver()
In-Reply-To: <1357353529-20901-1-git-send-email-wenyou.yang@atmel.com>
References: <1357353529-20901-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1357353529-20901-8-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using module_platform_driver() replaces module_init() and module_exit()
and makes the code simpler.

Remove '__init' annotation from the function 'at91wdt_probe'
since the driver becomes hot-plug aware now.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: wim at iguana.be
Cc: linux-watchdog at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/watchdog/at91sam9_wdt.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 94be9d6..7c13dda 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -204,7 +204,7 @@ static struct watchdog_device at91wdt_wdd = {
 	.ops = &at91wdt_ops,
 };
 
-static int __init at91wdt_probe(struct platform_device *pdev)
+static int at91wdt_probe(struct platform_device *pdev)
 {
 	struct at91wdt_drvdata *driver_data;
 	struct resource	*r;
@@ -273,6 +273,7 @@ MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
 #endif
 
 static struct platform_driver at91wdt_driver = {
+	.probe		= at91wdt_probe,
 	.remove		= __exit_p(at91wdt_remove),
 	.driver		= {
 		.name	= "at91_wdt",
@@ -281,18 +282,7 @@ static struct platform_driver at91wdt_driver = {
 	},
 };
 
-static int __init at91sam_wdt_init(void)
-{
-	return platform_driver_probe(&at91wdt_driver, at91wdt_probe);
-}
-
-static void __exit at91sam_wdt_exit(void)
-{
-	platform_driver_unregister(&at91wdt_driver);
-}
-
-module_init(at91sam_wdt_init);
-module_exit(at91sam_wdt_exit);
+module_platform_driver(at91wdt_driver);
 
 MODULE_AUTHOR("Renaud CERRATO <r.cerrato@til-technologies.fr>");
 MODULE_DESCRIPTION("Watchdog driver for Atmel AT91SAM9x processors");
-- 
1.7.9.5
