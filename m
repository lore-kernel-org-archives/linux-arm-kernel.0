From: vikas.sajjan@linaro.org (Vikas Sajjan)
Date: Thu, 20 Feb 2014 15:36:01 +0545
Subject: [PATCH] rtc: rtc-s3c: Fix incorrect way of save/restore of
 S3C2410_TICNT for TYPE_S3C64XX
Message-ID: <1392889861-5044-1-git-send-email-vikas.sajjan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On exynos5250, exynos5420 and exynos5260 it was observed that, after 1 cycle
of S2R, the rtc-tick occurs at a very fast rate as compared to the rtc-tick
occuring before S2R.

This patch fixes the above issue by correcting the wrong way of save/restore
of S3C2410_TICNT for TYPE_S3C64XX.

Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 drivers/rtc/rtc-s3c.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 7afd373..c4cde9c 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -580,10 +580,12 @@ static int s3c_rtc_suspend(struct device *dev)
 
 	clk_enable(rtc_clk);
 	/* save TICNT for anyone using periodic interrupts */
-	ticnt_save = readb(s3c_rtc_base + S3C2410_TICNT);
 	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
 		ticnt_en_save = readw(s3c_rtc_base + S3C2410_RTCCON);
 		ticnt_en_save &= S3C64XX_RTCCON_TICEN;
+		ticnt_save = readl(s3c_rtc_base + S3C2410_TICNT);
+	} else {
+		ticnt_save = readb(s3c_rtc_base + S3C2410_TICNT);
 	}
 	s3c_rtc_enable(pdev, 0);
 
@@ -605,10 +607,15 @@ static int s3c_rtc_resume(struct device *dev)
 
 	clk_enable(rtc_clk);
 	s3c_rtc_enable(pdev, 1);
-	writeb(ticnt_save, s3c_rtc_base + S3C2410_TICNT);
-	if (s3c_rtc_cpu_type == TYPE_S3C64XX && ticnt_en_save) {
-		tmp = readw(s3c_rtc_base + S3C2410_RTCCON);
-		writew(tmp | ticnt_en_save, s3c_rtc_base + S3C2410_RTCCON);
+	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
+		writel(ticnt_save, s3c_rtc_base + S3C2410_TICNT);
+		if (ticnt_en_save) {
+			tmp = readw(s3c_rtc_base + S3C2410_RTCCON);
+			writew(tmp | ticnt_en_save,
+					s3c_rtc_base + S3C2410_RTCCON);
+		}
+	} else {
+		writeb(ticnt_save, s3c_rtc_base + S3C2410_TICNT);
 	}
 
 	if (device_may_wakeup(dev) && wake_en) {
-- 
1.7.9.5
