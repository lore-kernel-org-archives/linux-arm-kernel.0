From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 24 Mar 2011 22:09:33 +0200
Subject: [PATCH] rtc: rtc-s3c: fix compile error due to missing s3c_rtc_setpie
Message-ID: <1300997373-28910-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c_rtc_setpie was removed, and it resulted in compiler error:

drivers/rtc/rtc-s3c.c: In function ?s3c_rtc_release?:
drivers/rtc/rtc-s3c.c:339:2: error: implicit declaration of function
?s3c_rtc_setpie?

Fix it by removing s3c_rtc_release calls.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/rtc/rtc-s3c.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 7149649..b3466c4 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -336,7 +336,6 @@ static void s3c_rtc_release(struct device *dev)
 
 	/* do not clear AIE here, it may be needed for wake */
 
-	s3c_rtc_setpie(dev, 0);
 	free_irq(s3c_rtc_alarmno, rtc_dev);
 	free_irq(s3c_rtc_tickno, rtc_dev);
 }
@@ -408,7 +407,6 @@ static int __devexit s3c_rtc_remove(struct platform_device *dev)
 	platform_set_drvdata(dev, NULL);
 	rtc_device_unregister(rtc);
 
-	s3c_rtc_setpie(&dev->dev, 0);
 	s3c_rtc_setaie(&dev->dev, 0);
 
 	clk_disable(rtc_clk);
-- 
1.7.4.1
