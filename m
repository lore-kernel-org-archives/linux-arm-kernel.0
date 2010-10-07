From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu,  7 Oct 2010 17:20:07 +0900
Subject: [PATCH v2 2/3] rtc: rtc-s3c: Fix on RTC initialization method
In-Reply-To: <1286439608-22722-1-git-send-email-kgene.kim@samsung.com>
References: <1286439608-22722-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1286439608-22722-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch changes RTC initialization method on probe(). The
'rtc_valid_tm(tm)' can check whether RTC BCD is valid or not.
And should be changed the method of check because previous
method cannot validate RTC BCD registers properly.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
Changes since v1:
- Added 'dev_warn' when initialized RTC as per Ben's suggestion

 drivers/rtc/rtc-s3c.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 276b7c1..125c50a 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -453,8 +453,8 @@ static int __devexit s3c_rtc_remove(struct platform_device *dev)
 static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
+	struct rtc_time rtc_tm;
 	struct resource *res;
-	unsigned int tmp, i;
 	int ret;
 
 	pr_debug("%s: probe=%p\n", __func__, pdev);
@@ -535,11 +535,19 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
 
 	/* Check RTC Time */
 
-	for (i = S3C2410_RTCSEC; i <= S3C2410_RTCYEAR; i += 0x4) {
-		tmp = readb(s3c_rtc_base + i);
+	s3c_rtc_gettime(NULL, &rtc_tm);
 
-		if ((tmp & 0xf) > 0x9 || ((tmp >> 4) & 0xf) > 0x9)
-			writeb(0, s3c_rtc_base + i);
+	if (rtc_valid_tm(&rtc_tm)) {
+		rtc_tm.tm_year	= 100;
+		rtc_tm.tm_mon	= 0;
+		rtc_tm.tm_mday	= 1;
+		rtc_tm.tm_hour	= 0;
+		rtc_tm.tm_min	= 0;
+		rtc_tm.tm_sec	= 0;
+
+		s3c_rtc_settime(NULL, &rtc_tm);
+
+		dev_warn(&pdev->dev, "warning: invalid RTC value so initializing it\n");
 	}
 
 	if (s3c_rtc_cpu_type == TYPE_S3C64XX)
-- 
1.6.2.5
