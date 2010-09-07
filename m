From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue,  7 Sep 2010 14:29:41 +0900
Subject: [PATCH 5/5] rtc: rtc-s3c: Fix debug message format on RTC
In-Reply-To: <1283837381-9575-1-git-send-email-kgene.kim@samsung.com>
References: <1283837381-9575-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1283837381-9575-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes debug message format on rtc-s3c.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/rtc/rtc-s3c.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 7f15073..3c3ecdf 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -171,8 +171,8 @@ static int s3c_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 		goto retry_get_time;
 	}
 
-	pr_debug("read time %02x.%02x.%02x %02x/%02x/%02x\n",
-		 rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
+	pr_debug("read time %04d.%02d.%02d %02d:%02d:%02d\n",
+		 1900 + rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
 		 rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
 
 	rtc_tm->tm_sec = bcd2bin(rtc_tm->tm_sec);
@@ -193,8 +193,8 @@ static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
 	void __iomem *base = s3c_rtc_base;
 	int year = tm->tm_year - 100;
 
-	pr_debug("set time %02d.%02d.%02d %02d/%02d/%02d\n",
-		 tm->tm_year, tm->tm_mon, tm->tm_mday,
+	pr_debug("set time %04d.%02d.%02d %02d:%02d:%02d\n",
+		 1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
 		 tm->tm_hour, tm->tm_min, tm->tm_sec);
 
 	/* we get around y2k by simply not supporting it */
@@ -231,9 +231,9 @@ static int s3c_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	alrm->enabled = (alm_en & S3C2410_RTCALM_ALMEN) ? 1 : 0;
 
-	pr_debug("read alarm %02x %02x.%02x.%02x %02x/%02x/%02x\n",
+	pr_debug("read alarm %d, %04d.%02d.%02d %02d:%02d:%02d\n",
 		 alm_en,
-		 alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
+		 1900 + alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
 		 alm_tm->tm_hour, alm_tm->tm_min, alm_tm->tm_sec);
 
 
@@ -280,10 +280,10 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	void __iomem *base = s3c_rtc_base;
 	unsigned int alrm_en;
 
-	pr_debug("s3c_rtc_setalarm: %d, %02x/%02x/%02x %02x.%02x.%02x\n",
+	pr_debug("s3c_rtc_setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
 		 alrm->enabled,
-		 tm->tm_mday & 0xff, tm->tm_mon & 0xff, tm->tm_year & 0xff,
-		 tm->tm_hour & 0xff, tm->tm_min & 0xff, tm->tm_sec);
+		 1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
+		 tm->tm_hour, tm->tm_min, tm->tm_sec);
 
 
 	alrm_en = readb(base + S3C2410_RTCALM) & S3C2410_RTCALM_ALMEN;
-- 
1.6.2.5
