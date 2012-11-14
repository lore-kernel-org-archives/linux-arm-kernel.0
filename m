From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 14 Nov 2012 15:16:06 +0800
Subject: [PATCH 08/11] watchdog/at91sam9_wdt: use module_platform_driver()
In-Reply-To: <1352877369-19740-1-git-send-email-wenyou.yang@atmel.com>
References: <1352877369-19740-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1352877369-19740-9-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using module_platform_driver() replaces module_init() and module_exit()
and makes the code simpler.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 drivers/watchdog/at91sam9_wdt.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 187e33f..e7ce9ea 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -252,6 +252,7 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver at91wdt_driver = {
+	.probe		= at91wdt_probe,
 	.remove		= __exit_p(at91wdt_remove),
 	.driver		= {
 		.name	= "at91_wdt",
@@ -259,18 +260,7 @@ static struct platform_driver at91wdt_driver = {
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
