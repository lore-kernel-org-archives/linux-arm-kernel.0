From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 12 Jul 2017 10:04:25 +0200
Subject: [PATCH v2 05/22] rtc: ab8500: stop using rtc deprecated functions
In-Reply-To: <1499846682-14093-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1499846682-14093-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1499846682-14093-6-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

version 2:
- fix compilation issues by  using do_div()
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
CC: Linus Walleij <linus.walleij@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux at googlegroups.com
CC: linux-kernel at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
---
 drivers/rtc/rtc-ab8500.c | 53 +++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 24a0af6..4b8696f 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -71,7 +71,7 @@
 /* Calculate the seconds from 1970 to 01-01-2000 00:00:00 */
 static unsigned long get_elapsed_seconds(int year)
 {
-	unsigned long secs;
+	unsigned long long secs;
 	struct rtc_time tm = {
 		.tm_year = year - 1900,
 		.tm_mday = 1,
@@ -81,7 +81,7 @@ static unsigned long get_elapsed_seconds(int year)
 	 * This function calculates secs from 1970 and not from
 	 * 1900, even if we supply the offset from year 1900.
 	 */
-	rtc_tm_to_time(&tm, &secs);
+	secs = rtc_tm_to_time64(&tm);
 	return secs;
 }
 
@@ -89,7 +89,7 @@ static int ab8500_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long timeout = jiffies + HZ;
 	int retval, i;
-	unsigned long mins, secs;
+	unsigned long long mins, secs;
 	unsigned char buf[ARRAY_SIZE(ab8500_rtc_time_regs)];
 	u8 value;
 
@@ -130,7 +130,7 @@ static int ab8500_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	/* Add back the initially subtracted number of seconds */
 	secs += get_elapsed_seconds(AB8500_RTC_EPOCH);
 
-	rtc_time_to_tm(secs, tm);
+	rtc_time64_to_tm(secs, tm);
 	return rtc_valid_tm(tm);
 }
 
@@ -138,7 +138,7 @@ static int ab8500_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	int retval, i;
 	unsigned char buf[ARRAY_SIZE(ab8500_rtc_time_regs)];
-	unsigned long no_secs, no_mins, secs = 0;
+	unsigned long long no_secs, secs = 0;
 
 	if (tm->tm_year < (AB8500_RTC_EPOCH - 1900)) {
 		dev_dbg(dev, "year should be equal to or greater than %d\n",
@@ -147,7 +147,7 @@ static int ab8500_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	}
 
 	/* Get the number of seconds since 1970 */
-	rtc_tm_to_time(tm, &secs);
+	secs = rtc_tm_to_time64(tm);
 
 	/*
 	 * Convert it to the number of seconds since 01-01-2000 00:00:00, since
@@ -155,18 +155,16 @@ static int ab8500_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	 */
 	secs -= get_elapsed_seconds(AB8500_RTC_EPOCH);
 
-	no_mins = secs / 60;
-
-	no_secs = secs % 60;
+	no_secs = do_div(secs, 60);
 	/* Make the seconds count as per the RTC resolution */
 	no_secs = no_secs * COUNTS_PER_SEC;
 
 	buf[4] = no_secs & 0xFF;
 	buf[3] = (no_secs >> 8) & 0xFF;
 
-	buf[2] = no_mins & 0xFF;
-	buf[1] = (no_mins >> 8) & 0xFF;
-	buf[0] = (no_mins >> 16) & 0xFF;
+	buf[2] = secs & 0xFF;
+	buf[1] = (secs >> 8) & 0xFF;
+	buf[0] = (secs >> 16) & 0xFF;
 
 	for (i = 0; i < ARRAY_SIZE(ab8500_rtc_time_regs); i++) {
 		retval = abx500_set_register_interruptible(dev, AB8500_RTC,
@@ -185,7 +183,7 @@ static int ab8500_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	int retval, i;
 	u8 rtc_ctrl, value;
 	unsigned char buf[ARRAY_SIZE(ab8500_rtc_alarm_regs)];
-	unsigned long secs, mins;
+	unsigned long long secs, mins;
 
 	/* Check if the alarm is enabled or not */
 	retval = abx500_get_register_interruptible(dev, AB8500_RTC,
@@ -214,7 +212,7 @@ static int ab8500_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	/* Add back the initially subtracted number of seconds */
 	secs += get_elapsed_seconds(AB8500_RTC_EPOCH);
 
-	rtc_time_to_tm(secs, &alarm->time);
+	rtc_time64_to_tm(secs, &alarm->time);
 
 	return rtc_valid_tm(&alarm->time);
 }
@@ -230,7 +228,7 @@ static int ab8500_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	int retval, i;
 	unsigned char buf[ARRAY_SIZE(ab8500_rtc_alarm_regs)];
-	unsigned long mins, secs = 0, cursec = 0;
+	unsigned long long secs = 0, cursec = 0;
 	struct rtc_time curtm;
 
 	if (alarm->time.tm_year < (AB8500_RTC_EPOCH - 1900)) {
@@ -240,7 +238,7 @@ static int ab8500_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	}
 
 	/* Get the number of seconds since 1970 */
-	rtc_tm_to_time(&alarm->time, &secs);
+	secs = rtc_tm_to_time64(&alarm->time);
 
 	/*
 	 * Check whether alarm is set less than 1min.
@@ -248,7 +246,7 @@ static int ab8500_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	 * return -EINVAL, so UIE EMUL can take it up, incase of UIE_ON
 	 */
 	ab8500_rtc_read_time(dev, &curtm); /* Read current time */
-	rtc_tm_to_time(&curtm, &cursec);
+	cursec = rtc_tm_to_time64(&curtm);
 	if ((secs - cursec) < 59) {
 		dev_dbg(dev, "Alarm less than 1 minute not supported\r\n");
 		return -EINVAL;
@@ -260,11 +258,11 @@ static int ab8500_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	 */
 	secs -= get_elapsed_seconds(AB8500_RTC_EPOCH);
 
-	mins = secs / 60;
+	do_div(secs, 60);
 
-	buf[2] = mins & 0xFF;
-	buf[1] = (mins >> 8) & 0xFF;
-	buf[0] = (mins >> 16) & 0xFF;
+	buf[2] = secs & 0xFF;
+	buf[1] = (secs >> 8) & 0xFF;
+	buf[0] = (secs >> 16) & 0xFF;
 
 	/* Set the alarm time */
 	for (i = 0; i < ARRAY_SIZE(ab8500_rtc_alarm_regs); i++) {
@@ -281,7 +279,7 @@ static int ab8540_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	int retval, i;
 	unsigned char buf[ARRAY_SIZE(ab8540_rtc_alarm_regs)];
-	unsigned long mins, secs = 0;
+	unsigned long long secs = 0;
 
 	if (alarm->time.tm_year < (AB8500_RTC_EPOCH - 1900)) {
 		dev_dbg(dev, "year should be equal to or greater than %d\n",
@@ -290,18 +288,17 @@ static int ab8540_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	}
 
 	/* Get the number of seconds since 1970 */
-	rtc_tm_to_time(&alarm->time, &secs);
+	secs = rtc_tm_to_time64(&alarm->time);
 
 	/*
 	 * Convert it to the number of seconds since 01-01-2000 00:00:00
 	 */
 	secs -= get_elapsed_seconds(AB8500_RTC_EPOCH);
-	mins = secs / 60;
 
-	buf[3] = secs % 60;
-	buf[2] = mins & 0xFF;
-	buf[1] = (mins >> 8) & 0xFF;
-	buf[0] = (mins >> 16) & 0xFF;
+	buf[3] = do_div(secs, 60);
+	buf[2] = secs & 0xFF;
+	buf[1] = (secs >> 8) & 0xFF;
+	buf[0] = (secs >> 16) & 0xFF;
 
 	/* Set the alarm time */
 	for (i = 0; i < ARRAY_SIZE(ab8540_rtc_alarm_regs); i++) {
-- 
1.9.1
