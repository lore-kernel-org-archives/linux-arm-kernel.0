From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 31 Jul 2015 11:39:51 +0200
Subject: [PATCH 15/23] rtc: at91rm9200: get and use slow clock
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438335599-3301-16-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
hang") added a workaround for the slow clock as it is not properly handled
by its users.

Get and use the slow clock as it is necessary for the at91rm9200 rtc.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux at googlegroups.com
 drivers/rtc/rtc-at91rm9200.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 35efd3f75b18..8093d9e50619 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -24,6 +24,7 @@
 #include <linux/time.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
+#include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/ioctl.h>
@@ -59,6 +60,7 @@ static bool suspended;
 static DEFINE_SPINLOCK(suspended_lock);
 static unsigned long cached_events;
 static u32 at91_rtc_imr;
+static struct clk *sclk;
 
 static void at91_rtc_write_ier(u32 mask)
 {
@@ -407,6 +409,16 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	sclk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(sclk))
+		return PTR_ERR(sclk);
+
+	ret = clk_prepare_enable(sclk);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not enable slow clock\n");
+		return ret;
+	}
+
 	at91_rtc_write(AT91_RTC_CR, 0);
 	at91_rtc_write(AT91_RTC_MR, 0);		/* 24 hour mode */
 
@@ -420,7 +432,7 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 			       "at91_rtc", pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "IRQ %d already in use.\n", irq);
-		return ret;
+		goto err_clk;
 	}
 
 	/* cpu init code should really have flagged this device as
@@ -431,8 +443,10 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 
 	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
 				&at91_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
+	if (IS_ERR(rtc)) {
+		ret = PTR_ERR(rtc);
+		goto err_clk;
+	}
 	platform_set_drvdata(pdev, rtc);
 
 	/* enable SECEV interrupt in order to initialize at91_rtc_upd_rdy
@@ -442,6 +456,11 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "AT91 Real Time Clock driver.\n");
 	return 0;
+
+err_clk:
+	clk_disable_unprepare(sclk);
+
+	return ret;
 }
 
 /*
@@ -454,6 +473,8 @@ static int __exit at91_rtc_remove(struct platform_device *pdev)
 					AT91_RTC_SECEV | AT91_RTC_TIMEV |
 					AT91_RTC_CALEV);
 
+	clk_disable_unprepare(sclk);
+
 	return 0;
 }
 
-- 
2.1.4
