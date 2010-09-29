From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 29 Sep 2010 18:02:15 +0800
Subject: [PATCH 2/2] rtc: use __devinit instead on pxa-rtc
In-Reply-To: <1285754535-30802-1-git-send-email-haojian.zhuang@marvell.com>
References: <1285754535-30802-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1285754535-30802-2-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to use __init/__exit on probe()/remove(). Use __devinit/__devexit
instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Alessandro Zummo <a.zummo@towertech.it>
---
 drivers/rtc/rtc-pxa.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index 4bcc520..f520daf 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -352,7 +352,7 @@ static const struct rtc_class_ops pxa_rtc_ops = {
 	.irq_set_freq = pxa_periodic_irq_set_freq,
 };
 
-static int __init pxa_rtc_probe(struct platform_device *pdev)
+static int __devinit pxa_rtc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct pxa_rtc *pxa_rtc;
@@ -425,7 +425,7 @@ err_map:
 	return ret;
 }
 
-static int __exit pxa_rtc_remove(struct platform_device *pdev)
+static int __devexit pxa_rtc_remove(struct platform_device *pdev)
 {
 	struct pxa_rtc *pxa_rtc = platform_get_drvdata(pdev);
 
@@ -466,7 +466,8 @@ static const struct dev_pm_ops pxa_rtc_pm_ops = {
 #endif
 
 static struct platform_driver pxa_rtc_driver = {
-	.remove		= __exit_p(pxa_rtc_remove),
+	.probe		= pxa_rtc_probe,
+	.remove		= __devexit_p(pxa_rtc_remove),
 	.driver		= {
 		.name	= "pxa-rtc",
 #ifdef CONFIG_PM
@@ -477,7 +478,7 @@ static struct platform_driver pxa_rtc_driver = {
 
 static int __init pxa_rtc_init(void)
 {
-	return platform_driver_probe(&pxa_rtc_driver, pxa_rtc_probe);
+	return platform_driver_register(&pxa_rtc_driver);
 }
 
 static void __exit pxa_rtc_exit(void)
-- 
1.5.6.5
