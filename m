From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 12 Jul 2017 10:04:31 +0200
Subject: [PATCH v2 11/22] rtc: gemini: stop using rtc deprecated functions
In-Reply-To: <1499846682-14093-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1499846682-14093-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1499846682-14093-12-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Hans Ulli Kroll <ulli.kroll@googlemail.com>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux at googlegroups.com
CC: linux-kernel at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
---
 drivers/rtc/rtc-ftrtc010.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index af8d6be..6328913 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -74,7 +74,7 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct ftrtc010_rtc *rtc = dev_get_drvdata(dev);
 
 	unsigned int  days, hour, min, sec;
-	unsigned long offset, time;
+	unsigned long long offset, time;
 
 	sec  = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
 	min  = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
@@ -84,7 +84,7 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	time = offset + days * 86400 + hour * 3600 + min * 60 + sec;
 
-	rtc_time_to_tm(time, tm);
+	rtc_time64_to_tm(time, tm);
 
 	return 0;
 }
@@ -93,12 +93,12 @@ static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct ftrtc010_rtc *rtc = dev_get_drvdata(dev);
 	unsigned int sec, min, hour, day;
-	unsigned long offset, time;
+	unsigned long long offset, time;
 
 	if (tm->tm_year >= 2148)	/* EPOCH Year + 179 */
 		return -EINVAL;
 
-	rtc_tm_to_time(tm, &time);
+	time = rtc_tm_to_time64(tm);
 
 	sec = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
 	min = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
-- 
1.9.1
