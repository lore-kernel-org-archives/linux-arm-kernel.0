From: jtzhou@marvell.com (Jett.Zhou)
Date: Thu, 16 Aug 2012 19:59:28 +0800
Subject: [PATCH 2/3] rtc: use __devinit instead on pxa-rtc
Message-ID: <1345118368-10409-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haojian Zhuang <haojian.zhuang@marvell.com>

Avoid to use __init/__exit on probe()/remove(). Use __devinit/__devexit
instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/rtc/rtc-pxa.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index a2c3534..3a060d2 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -308,7 +308,7 @@ static const struct rtc_class_ops pxa_rtc_ops = {
 	.proc = pxa_rtc_proc,
 };
 
-static int __init pxa_rtc_probe(struct platform_device *pdev)
+static int __devinit pxa_rtc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct pxa_rtc *pxa_rtc;
@@ -381,7 +381,7 @@ err_map:
 	return ret;
 }
 
-static int __exit pxa_rtc_remove(struct platform_device *pdev)
+static int __devexit pxa_rtc_remove(struct platform_device *pdev)
 {
 	struct pxa_rtc *pxa_rtc = platform_get_drvdata(pdev);
 
@@ -422,7 +422,8 @@ static const struct dev_pm_ops pxa_rtc_pm_ops = {
 #endif
 
 static struct platform_driver pxa_rtc_driver = {
-	.remove		= __exit_p(pxa_rtc_remove),
+	.probe		= pxa_rtc_probe,
+	.remove		= __devexit_p(pxa_rtc_remove),
 	.driver		= {
 		.name	= "pxa-rtc",
 #ifdef CONFIG_PM
@@ -433,7 +434,7 @@ static struct platform_driver pxa_rtc_driver = {
 
 static int __init pxa_rtc_init(void)
 {
-	return platform_driver_probe(&pxa_rtc_driver, pxa_rtc_probe);
+	return platform_driver_register(&pxa_rtc_driver);
 }
 
 static void __exit pxa_rtc_exit(void)
-- 
1.7.0.4
