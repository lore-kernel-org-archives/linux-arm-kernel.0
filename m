From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 27 Jun 2011 20:43:25 +0900
Subject: [PATCH 2/3] rtc: rtc-s3c: Disable alarm entries that are not chosen.
In-Reply-To: <1309175006-9218-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309175006-9218-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1309175006-9218-3-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When rtc_setalarm is called, the entries that are not chosen (entries
without valid time values) should be disabled. However, in the previous
rtc-s3c driver, they are not explicitly disabled (did not changed). This
patch allows to disable such entries even if they were previously used.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/rtc/rtc-s3c.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 3c8dfa7..be85ea5 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -273,7 +273,8 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 		 1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
 		 tm->tm_hour, tm->tm_min, tm->tm_sec);
 
-	alrm_en = readb(base + S3C2410_RTCALM) & S3C2410_RTCALM_ALMEN;
+	/* Disable entires that are not chosen by alrm */
+	alrm_en = S3C2410_RTCALM_ALMEN;
 	writeb(0x00, base + S3C2410_RTCALM);
 
 	if (tm->tm_sec < 60 && tm->tm_sec >= 0) {
-- 
1.7.4.1
