From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 24 Feb 2012 00:00:46 +0800
Subject: [PATCH v3 2/7] rtc: sa1100: remove verification code of alarm
In-Reply-To: <1330012851-13693-1-git-send-email-haojian.zhuang@marvell.com>
References: <1330012851-13693-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1330012851-13693-3-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since next alarm time is already calculated in rtc common interface, we
needn't keep this logic in rtc-sa1100.c any more.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/rtc/rtc-sa1100.c |   66 +++++++--------------------------------------
 1 files changed, 11 insertions(+), 55 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index fef52c8..91d58bd 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -44,54 +44,6 @@
 static const unsigned long RTC_FREQ = 1024;
 static DEFINE_SPINLOCK(sa1100_rtc_lock);
 
-/*
- * Calculate the next alarm time given the requested alarm time mask
- * and the current time.
- */
-static void rtc_next_alarm_time(struct rtc_time *next, struct rtc_time *now,
-	struct rtc_time *alrm)
-{
-	unsigned long next_time;
-	unsigned long now_time;
-
-	next->tm_year = now->tm_year;
-	next->tm_mon = now->tm_mon;
-	next->tm_mday = now->tm_mday;
-	next->tm_hour = alrm->tm_hour;
-	next->tm_min = alrm->tm_min;
-	next->tm_sec = alrm->tm_sec;
-
-	rtc_tm_to_time(now, &now_time);
-	rtc_tm_to_time(next, &next_time);
-
-	if (next_time < now_time) {
-		/* Advance one day */
-		next_time += 60 * 60 * 24;
-		rtc_time_to_tm(next_time, next);
-	}
-}
-
-static int rtc_update_alarm(struct rtc_time *alrm)
-{
-	struct rtc_time alarm_tm, now_tm;
-	unsigned long now, time;
-	int ret;
-
-	do {
-		now = RCNR;
-		rtc_time_to_tm(now, &now_tm);
-		rtc_next_alarm_time(&alarm_tm, &now_tm, alrm);
-		ret = rtc_tm_to_time(&alarm_tm, &time);
-		if (ret != 0)
-			break;
-
-		RTSR = RTSR & (RTSR_HZE|RTSR_ALE|RTSR_AL);
-		RTAR = time;
-	} while (now != RCNR);
-
-	return ret;
-}
-
 static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 {
 	struct platform_device *pdev = to_platform_device(dev_id);
@@ -219,16 +171,20 @@ static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int sa1100_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
+	unsigned long time;
 	int ret;
 
 	spin_lock_irq(&sa1100_rtc_lock);
-	ret = rtc_update_alarm(&alrm->time);
-	if (ret == 0) {
-		if (alrm->enabled)
-			RTSR |= RTSR_ALE;
-		else
-			RTSR &= ~RTSR_ALE;
-	}
+	ret = rtc_tm_to_time(&alrm->time, &time);
+	if (ret != 0)
+		goto out;
+	RTSR = RTSR & (RTSR_HZE|RTSR_ALE|RTSR_AL);
+	RTAR = time;
+	if (alrm->enabled)
+		RTSR |= RTSR_ALE;
+	else
+		RTSR &= ~RTSR_ALE;
+out:
 	spin_unlock_irq(&sa1100_rtc_lock);
 
 	return ret;
-- 
1.7.0.4
