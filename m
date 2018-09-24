From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon, 24 Sep 2018 16:49:01 +0200
Subject: [PATCH 2/3] rtc: ab8500: let the core handle range
In-Reply-To: <20180924144902.607-1-alexandre.belloni@bootlin.com>
References: <20180924144902.607-1-alexandre.belloni@bootlin.com>
Message-ID: <20180924144902.607-2-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the core handle offsetting and windowing the RTC range.
The RTC has a 24 bit counter for minutes plus a seconds counter.
Keep the epoch at the beginning of 2000.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab8500.c | 53 +++-------------------------------------
 1 file changed, 4 insertions(+), 49 deletions(-)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index e97015e5c63e..2e2671b84ab0 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -46,7 +46,6 @@
 #define RTC_STATUS_DATA			0x01
 
 #define COUNTS_PER_SEC			(0xF000 / 60)
-#define AB8500_RTC_EPOCH		2000
 
 static const u8 ab8500_rtc_time_regs[] = {
 	AB8500_RTC_WATCH_TMIN_HI_REG, AB8500_RTC_WATCH_TMIN_MID_REG,
@@ -59,23 +58,6 @@ static const u8 ab8500_rtc_alarm_regs[] = {
 	AB8500_RTC_ALRM_MIN_LOW_REG
 };
 
-/* Calculate the seconds from 1970 to 01-01-2000 00:00:00 */
-static unsigned long get_elapsed_seconds(int year)
-{
-	unsigned long secs;
-	struct rtc_time tm = {
-		.tm_year = year - 1900,
-		.tm_mday = 1,
-	};
-
-	/*
-	 * This function calculates secs from 1970 and not from
-	 * 1900, even if we supply the offset from year 1900.
-	 */
-	rtc_tm_to_time(&tm, &secs);
-	return secs;
-}
-
 static int ab8500_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -118,9 +100,6 @@ static int ab8500_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	secs =	secs / COUNTS_PER_SEC;
 	secs =	secs + (mins * 60);
 
-	/* Add back the initially subtracted number of seconds */
-	secs += get_elapsed_seconds(AB8500_RTC_EPOCH);
-
 	rtc_time_to_tm(secs, tm);
 	return 0;
 }
@@ -131,21 +110,8 @@ static int ab8500_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	unsigned char buf[ARRAY_SIZE(ab8500_rtc_time_regs)];
 	unsigned long no_secs, no_mins, secs = 0;
 
-	if (tm->tm_year < (AB8500_RTC_EPOCH - 1900)) {
-		dev_dbg(dev, "year should be equal to or greater than %d\n",
-				AB8500_RTC_EPOCH);
-		return -EINVAL;
-	}
-
-	/* Get the number of seconds since 1970 */
 	rtc_tm_to_time(tm, &secs);
 
-	/*
-	 * Convert it to the number of seconds since 01-01-2000 00:00:00, since
-	 * we only have a small counter in the RTC.
-	 */
-	secs -= get_elapsed_seconds(AB8500_RTC_EPOCH);
-
 	no_mins = secs / 60;
 
 	no_secs = secs % 60;
@@ -202,9 +168,6 @@ static int ab8500_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	mins = (buf[0] << 16) | (buf[1] << 8) | (buf[2]);
 	secs = mins * 60;
 
-	/* Add back the initially subtracted number of seconds */
-	secs += get_elapsed_seconds(AB8500_RTC_EPOCH);
-
 	rtc_time_to_tm(secs, &alarm->time);
 
 	return rtc_valid_tm(&alarm->time);
@@ -224,12 +187,6 @@ static int ab8500_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	unsigned long mins, secs = 0, cursec = 0;
 	struct rtc_time curtm;
 
-	if (alarm->time.tm_year < (AB8500_RTC_EPOCH - 1900)) {
-		dev_dbg(dev, "year should be equal to or greater than %d\n",
-				AB8500_RTC_EPOCH);
-		return -EINVAL;
-	}
-
 	/* Get the number of seconds since 1970 */
 	rtc_tm_to_time(&alarm->time, &secs);
 
@@ -245,12 +202,6 @@ static int ab8500_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		return -EINVAL;
 	}
 
-	/*
-	 * Convert it to the number of seconds since 01-01-2000 00:00:00, since
-	 * we only have a small counter in the RTC.
-	 */
-	secs -= get_elapsed_seconds(AB8500_RTC_EPOCH);
-
 	mins = secs / 60;
 
 	buf[2] = mins & 0xFF;
@@ -445,6 +396,10 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 
 	rtc->uie_unsupported = 1;
 
+	rtc->range_max = (1ULL << 24) * 60 - 1; // 24-bit minutes + 59 secs
+	rtc->start_secs = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->set_start_time = true;
+
 	err = rtc_add_group(rtc, &ab8500_rtc_sysfs_files);
 	if (err)
 		return err;
-- 
2.19.0
