From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue,  7 Sep 2010 14:29:37 +0900
Subject: [PATCH 1/5] rtc: rtc-s3c: Fix access unit from byte to word on RTCCON
In-Reply-To: <1283837381-9575-1-git-send-email-kgene.kim@samsung.com>
References: <1283837381-9575-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1283837381-9575-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

S3C2410_RTCCON of TYPE_S3C64XX RTC should be read/written by readw and writew,
because TYPE_S3C64XX RTC uses bit8 and bit9.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/rtc/rtc-s3c.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index a0d3ec8..557a538 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -100,7 +100,7 @@ static int s3c_rtc_setpie(struct device *dev, int enabled)
 	spin_lock_irq(&s3c_rtc_pie_lock);
 
 	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
-		tmp = readb(s3c_rtc_base + S3C2410_RTCCON);
+		tmp = readw(s3c_rtc_base + S3C2410_RTCCON);
 		tmp &= ~S3C64XX_RTCCON_TICEN;
 
 		if (enabled)
@@ -323,7 +323,7 @@ static int s3c_rtc_proc(struct device *dev, struct seq_file *seq)
 	unsigned int ticnt;
 
 	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
-		ticnt = readb(s3c_rtc_base + S3C2410_RTCCON);
+		ticnt = readw(s3c_rtc_base + S3C2410_RTCCON);
 		ticnt &= S3C64XX_RTCCON_TICEN;
 	} else {
 		ticnt = readb(s3c_rtc_base + S3C2410_TICNT);
@@ -396,11 +396,11 @@ static void s3c_rtc_enable(struct platform_device *pdev, int en)
 		return;
 
 	if (!en) {
-		tmp = readb(base + S3C2410_RTCCON);
+		tmp = readw(base + S3C2410_RTCCON);
 		if (s3c_rtc_cpu_type == TYPE_S3C64XX)
 			tmp &= ~S3C64XX_RTCCON_TICEN;
 		tmp &= ~S3C2410_RTCCON_RTCEN;
-		writeb(tmp, base + S3C2410_RTCCON);
+		writew(tmp, base + S3C2410_RTCCON);
 
 		if (s3c_rtc_cpu_type == TYPE_S3C2410) {
 			tmp = readb(base + S3C2410_TICNT);
@@ -519,8 +519,8 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 
 	s3c_rtc_enable(pdev, 1);
 
- 	pr_debug("s3c2410_rtc: RTCCON=%02x\n",
-		 readb(s3c_rtc_base + S3C2410_RTCCON));
+	pr_debug("s3c2410_rtc: RTCCON=%02x\n",
+		 readw(s3c_rtc_base + S3C2410_RTCCON));
 
 	device_init_wakeup(&pdev->dev, 1);
 
@@ -583,7 +583,7 @@ static int s3c_rtc_suspend(struct platform_device *pdev, pm_message_t state)
 	/* save TICNT for anyone using periodic interrupts */
 	ticnt_save = readb(s3c_rtc_base + S3C2410_TICNT);
 	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
-		ticnt_en_save = readb(s3c_rtc_base + S3C2410_RTCCON);
+		ticnt_en_save = readw(s3c_rtc_base + S3C2410_RTCCON);
 		ticnt_en_save &= S3C64XX_RTCCON_TICEN;
 	}
 	s3c_rtc_enable(pdev, 0);
@@ -597,8 +597,8 @@ static int s3c_rtc_resume(struct platform_device *pdev)
 	s3c_rtc_enable(pdev, 1);
 	writeb(ticnt_save, s3c_rtc_base + S3C2410_TICNT);
 	if (s3c_rtc_cpu_type == TYPE_S3C64XX && ticnt_en_save) {
-		tmp = readb(s3c_rtc_base + S3C2410_RTCCON);
-		writeb(tmp | ticnt_en_save, s3c_rtc_base + S3C2410_RTCCON);
+		tmp = readw(s3c_rtc_base + S3C2410_RTCCON);
+		writew(tmp | ticnt_en_save, s3c_rtc_base + S3C2410_RTCCON);
 	}
 	return 0;
 }
-- 
1.6.2.5
