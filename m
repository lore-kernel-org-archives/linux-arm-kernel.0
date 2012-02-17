From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 17 Feb 2012 18:50:04 +0100
Subject: [PATCH 12/18] ARM: at91:rtc/rtc-at91sam9: ioremap register bank
In-Reply-To: <1329501010-30468-1-git-send-email-nicolas.ferre@atmel.com>
References: <1329501010-30468-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <840d899dfcd707cb9fc282d6f04c6645fd3b84fe.1329500622.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Instead of computing virtual address with AT91_VA_BASE_SYS, use the
appropriate ioremap() call on the driver "memory" resource.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/rtc/rtc-at91sam9.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 65896a3..08b69fd 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -307,8 +307,12 @@ static int __devinit at91_rtc_probe(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, 1);
 
 	platform_set_drvdata(pdev, rtc);
-	rtc->rtt = (void __force __iomem *) (AT91_VA_BASE_SYS - AT91_BASE_SYS);
-	rtc->rtt += r->start;
+	rtc->rtt = ioremap(r->start, resource_size(r));
+	if (!rtc->rtt) {
+		dev_err(&pdev->dev, "failed to map registers, aborting.\n");
+		ret = -ENOMEM;
+		goto fail;
+	}
 
 	mr = rtt_readl(rtc, MR);
 
@@ -326,7 +330,7 @@ static int __devinit at91_rtc_probe(struct platform_device *pdev)
 				&at91_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtcdev)) {
 		ret = PTR_ERR(rtc->rtcdev);
-		goto fail;
+		goto fail_register;
 	}
 
 	/* register irq handler after we know what name we'll use */
@@ -351,6 +355,8 @@ static int __devinit at91_rtc_probe(struct platform_device *pdev)
 
 	return 0;
 
+fail_register:
+	iounmap(rtc->rtt);
 fail:
 	platform_set_drvdata(pdev, NULL);
 	kfree(rtc);
@@ -371,6 +377,7 @@ static int __devexit at91_rtc_remove(struct platform_device *pdev)
 
 	rtc_device_unregister(rtc->rtcdev);
 
+	iounmap(rtc->rtt);
 	platform_set_drvdata(pdev, NULL);
 	kfree(rtc);
 	return 0;
-- 
1.7.9
