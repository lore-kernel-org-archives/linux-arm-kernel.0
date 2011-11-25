From: jtzhou@marvell.com (Jett.Zhou)
Date: Fri, 25 Nov 2011 19:06:39 +0800
Subject: [V1 2/3] RTC: sa1100: remove redundant code of setting alarm
Message-ID: <1322219199-1825-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In rtc generic interface of setting alarm, it will check the alarm time
value valid or not, so rtc_periodic_alarm is redundant, remove it.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/rtc/rtc-sa1100.c |   53 ++++++++++-----------------------------------
 1 files changed, 12 insertions(+), 41 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index 6f22c1f..d268cf1 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -45,16 +45,6 @@ static const unsigned long RTC_FREQ = 1024;
 static struct rtc_time rtc_alarm;
 static DEFINE_SPINLOCK(sa1100_rtc_lock);
 
-static inline int rtc_periodic_alarm(struct rtc_time *tm)
-{
-	return  (tm->tm_year == -1) ||
-		((unsigned)tm->tm_mon >= 12) ||
-		((unsigned)(tm->tm_mday - 1) >= 31) ||
-		((unsigned)tm->tm_hour > 23) ||
-		((unsigned)tm->tm_min > 59) ||
-		((unsigned)tm->tm_sec > 59);
-}
-
 /*
  * Calculate the next alarm time given the requested alarm time mask
  * and the current time.
@@ -82,27 +72,6 @@ static void rtc_next_alarm_time(struct rtc_time *next, struct rtc_time *now,
 	}
 }
 
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
@@ -146,9 +115,6 @@ static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 
 	rtc_update_irq(rtc, 1, events);
 
-	if (rtsr & RTSR_AL && rtc_periodic_alarm(&rtc_alarm))
-		rtc_update_alarm(&rtc_alarm);
-
 	spin_unlock(&sa1100_rtc_lock);
 
 	return IRQ_HANDLED;
@@ -234,16 +200,21 @@ static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int sa1100_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
+	struct rtc_time now_tm, alarm_tm;
 	int ret;
 
 	spin_lock_irq(&sa1100_rtc_lock);
-	ret = rtc_update_alarm(&alrm->time);
-	if (ret == 0) {
-		if (alrm->enabled)
-			RTSR |= RTSR_ALE;
-		else
-			RTSR &= ~RTSR_ALE;
-	}
+
+	now = RCNR;
+	rtc_time_to_tm(now, &now_tm);
+	rtc_next_alarm_time(&alarm_tm, &now_tm, alrm->time);
+	rtc_tm_to_time(&alarm_tm, &time);
+	RTAR = time;
+	if (alrm->enabled)
+		RTSR |= RTSR_ALE;
+	else
+		RTSR &= ~RTSR_ALE;
+
 	spin_unlock_irq(&sa1100_rtc_lock);
 
 	return ret;
-- 
1.7.0.4
