From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 16 Nov 2010 09:02:52 +0900
Subject: [PATCH 1/3] rtc: rtc-s3c: Fix return type and argument of
	s3c_rtc_setaie
In-Reply-To: <1289865774-31073-1-git-send-email-kgene.kim@samsung.com>
References: <1289865774-31073-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1289865774-31073-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to struct rtc_class_ops, this patch fixes return type
and argument of s3c_rtc_setaie().

 int (*alarm_irq_enable)(struct device *, unsigned int enabled);

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/rtc/rtc-s3c.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index cf953ec..e2636ff 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -76,19 +76,20 @@ static irqreturn_t s3c_rtc_tickirq(int irq, void *id)
 	return IRQ_HANDLED;
 }
 
-/* Update control registers */
-static void s3c_rtc_setaie(int to)
+static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
 {
 	unsigned int tmp;
 
-	pr_debug("%s: aie=%d\n", __func__, to);
+	pr_debug("%s: aie=%d\n", __func__, enabled);
 
 	tmp = readb(s3c_rtc_base + S3C2410_RTCALM) & ~S3C2410_RTCALM_ALMEN;
 
-	if (to)
+	if (enabled)
 		tmp |= S3C2410_RTCALM_ALMEN;
 
 	writeb(tmp, s3c_rtc_base + S3C2410_RTCALM);
+
+	return 0;
 }
 
 static int s3c_rtc_setpie(struct device *dev, int enabled)
@@ -308,7 +309,7 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	writeb(alrm_en, base + S3C2410_RTCALM);
 
-	s3c_rtc_setaie(alrm->enabled);
+	s3c_rtc_setaie(dev, alrm->enabled);
 
 	return 0;
 }
@@ -440,7 +441,7 @@ static int __devexit s3c_rtc_remove(struct platform_device *dev)
 	rtc_device_unregister(rtc);
 
 	s3c_rtc_setpie(&dev->dev, 0);
-	s3c_rtc_setaie(0);
+	s3c_rtc_setaie(&dev->dev, 0);
 
 	clk_disable(rtc_clk);
 	clk_put(rtc_clk);
-- 
1.6.2.5
