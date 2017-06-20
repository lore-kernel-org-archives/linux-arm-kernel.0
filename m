From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 20 Jun 2017 11:35:47 +0200
Subject: [PATCH 39/51] rtc: sirfsoc: stop using rtc deprecated functions
In-Reply-To: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1497951359-13334-40-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Barry Song <baohua@kernel.org>
CC: rtc-linux at googlegroups.com
CC: linux-kernel at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
---
 drivers/rtc/rtc-sirfsoc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-sirfsoc.c b/drivers/rtc/rtc-sirfsoc.c
index 7367f61..972ede9 100644
--- a/drivers/rtc/rtc-sirfsoc.c
+++ b/drivers/rtc/rtc-sirfsoc.c
@@ -91,11 +91,11 @@ static int sirfsoc_rtc_read_alarm(struct device *dev,
 	 */
 	/* if alarm is in next overflow cycle */
 	if (rtc_count > rtc_alarm)
-		rtc_time_to_tm((rtcdrv->overflow_rtc + 1)
-				<< (BITS_PER_LONG - RTC_SHIFT)
-				| rtc_alarm >> RTC_SHIFT, &(alrm->time));
+		rtc_time64_to_tm((rtcdrv->overflow_rtc + 1)
+				  << (BITS_PER_LONG - RTC_SHIFT)
+				  | rtc_alarm >> RTC_SHIFT, &(alrm->time));
 	else
-		rtc_time_to_tm(rtcdrv->overflow_rtc
+		rtc_time64_to_tm(rtcdrv->overflow_rtc
 				<< (BITS_PER_LONG - RTC_SHIFT)
 				| rtc_alarm >> RTC_SHIFT, &(alrm->time));
 	if (sirfsoc_rtc_readl(rtcdrv, RTC_STATUS) & SIRFSOC_RTC_AL0E)
@@ -109,12 +109,12 @@ static int sirfsoc_rtc_read_alarm(struct device *dev,
 static int sirfsoc_rtc_set_alarm(struct device *dev,
 		struct rtc_wkalrm *alrm)
 {
-	unsigned long rtc_status_reg, rtc_alarm;
+	unsigned long long rtc_status_reg, rtc_alarm;
 	struct sirfsoc_rtc_drv *rtcdrv;
 	rtcdrv = dev_get_drvdata(dev);
 
 	if (alrm->enabled) {
-		rtc_tm_to_time(&(alrm->time), &rtc_alarm);
+		rtc_alarm = rtc_tm_to_time64(&alrm->time);
 
 		spin_lock_irq(&rtcdrv->lock);
 
@@ -182,7 +182,7 @@ static int sirfsoc_rtc_read_time(struct device *dev,
 		cpu_relax();
 	} while (tmp_rtc != sirfsoc_rtc_readl(rtcdrv, RTC_CN));
 
-	rtc_time_to_tm(rtcdrv->overflow_rtc << (BITS_PER_LONG - RTC_SHIFT) |
+	rtc_time64_to_tm(rtcdrv->overflow_rtc << (BITS_PER_LONG - RTC_SHIFT) |
 					tmp_rtc >> RTC_SHIFT, tm);
 	return 0;
 }
@@ -190,11 +190,11 @@ static int sirfsoc_rtc_read_time(struct device *dev,
 static int sirfsoc_rtc_set_time(struct device *dev,
 		struct rtc_time *tm)
 {
-	unsigned long rtc_time;
+	unsigned long long rtc_time;
 	struct sirfsoc_rtc_drv *rtcdrv;
 	rtcdrv = dev_get_drvdata(dev);
 
-	rtc_tm_to_time(tm, &rtc_time);
+	rtc_time = rtc_tm_to_time64(tm);
 
 	rtcdrv->overflow_rtc = rtc_time >> (BITS_PER_LONG - RTC_SHIFT);
 
-- 
1.9.1
