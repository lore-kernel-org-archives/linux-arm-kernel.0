From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 21 Feb 2012 17:04:50 +0800
Subject: [PATCH 1/7] rtc: sa1100: remove periodic code
In-Reply-To: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1329815096-6200-2-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since periodic timer is already supported by hrtimer in rtc interface,
we needn't keep the duplicated code in rtc-sa1100.c any more.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/rtc/rtc-sa1100.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index cb9a585..fef52c8 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -42,19 +42,8 @@
 #define RTC_DEF_TRIM		0
 
 static const unsigned long RTC_FREQ = 1024;
-static struct rtc_time rtc_alarm;
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
@@ -146,9 +135,6 @@ static irqreturn_t sa1100_rtc_interrupt(int irq, void *dev_id)
 
 	rtc_update_irq(rtc, 1, events);
 
-	if (rtsr & RTSR_AL && rtc_periodic_alarm(&rtc_alarm))
-		rtc_update_alarm(&rtc_alarm);
-
 	spin_unlock(&sa1100_rtc_lock);
 
 	return IRQ_HANDLED;
@@ -225,7 +211,6 @@ static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	u32	rtsr;
 
-	memcpy(&alrm->time, &rtc_alarm, sizeof(struct rtc_time));
 	rtsr = RTSR;
 	alrm->enabled = (rtsr & RTSR_ALE) ? 1 : 0;
 	alrm->pending = (rtsr & RTSR_AL) ? 1 : 0;
-- 
1.7.0.4
