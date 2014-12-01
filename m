From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 1 Dec 2014 15:35:08 +0100
Subject: [PATCH v4 3/4] mmc: atmel-mci: stop using specific initcall
In-Reply-To: <1417444509-15501-1-git-send-email-ludovic.desroches@atmel.com>
References: <1417444509-15501-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1417444509-15501-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No more use late initcall to manage probing order. Use probe deferring
if needed.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index f16d019..00f6088 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2565,6 +2565,7 @@ static const struct dev_pm_ops atmci_dev_pm_ops = {
 };
 
 static struct platform_driver atmci_driver = {
+	.probe		= atmci_probe,
 	.remove		= atmci_remove,
 	.driver		= {
 		.name		= "atmel_mci",
@@ -2572,19 +2573,7 @@ static struct platform_driver atmci_driver = {
 		.pm		= &atmci_dev_pm_ops,
 	},
 };
-
-static int __init atmci_init(void)
-{
-	return platform_driver_probe(&atmci_driver, atmci_probe);
-}
-
-static void __exit atmci_exit(void)
-{
-	platform_driver_unregister(&atmci_driver);
-}
-
-late_initcall(atmci_init); /* try to load after dma driver when built-in */
-module_exit(atmci_exit);
+module_platform_driver(atmci_driver);
 
 MODULE_DESCRIPTION("Atmel Multimedia Card Interface driver");
 MODULE_AUTHOR("Haavard Skinnemoen (Atmel)");
-- 
2.0.3
