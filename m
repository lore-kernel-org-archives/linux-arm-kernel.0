From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  7 Jul 2012 17:47:21 -0300
Subject: [PATCH 3/3] rtc: rtc-mxc: Convert to module_platform_driver
In-Reply-To: <1341694041-7839-1-git-send-email-festevam@gmail.com>
References: <1341694041-7839-1-git-send-email-festevam@gmail.com>
Message-ID: <1341694041-7839-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Converting to module_platform_driver can make the code smaller and cleaner.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/rtc/rtc-mxc.c |   20 +++++---------------
 1 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 5d8456a..33d6e27 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -343,7 +343,7 @@ static struct rtc_class_ops mxc_rtc_ops = {
 	.alarm_irq_enable	= mxc_rtc_alarm_irq_enable,
 };
 
-static int __init mxc_rtc_probe(struct platform_device *pdev)
+static int __devinit mxc_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct rtc_device *rtc;
@@ -434,7 +434,7 @@ exit_free_pdata:
 	return ret;
 }
 
-static int __exit mxc_rtc_remove(struct platform_device *pdev)
+static int __devexit mxc_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
 
@@ -482,21 +482,11 @@ static struct platform_driver mxc_rtc_driver = {
 #endif
 		   .owner	= THIS_MODULE,
 	},
-	.remove		= __exit_p(mxc_rtc_remove),
+	.probe = mxc_rtc_probe,
+	.remove = __devexit_p(mxc_rtc_remove),
 };
 
-static int __init mxc_rtc_init(void)
-{
-	return platform_driver_probe(&mxc_rtc_driver, mxc_rtc_probe);
-}
-
-static void __exit mxc_rtc_exit(void)
-{
-	platform_driver_unregister(&mxc_rtc_driver);
-}
-
-module_init(mxc_rtc_init);
-module_exit(mxc_rtc_exit);
+module_platform_driver(mxc_rtc_driver);
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
 MODULE_DESCRIPTION("RTC driver for Freescale MXC");
-- 
1.7.1
