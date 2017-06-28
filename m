From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jun 2017 22:07:34 +0200
Subject: [PATCH] rtc: brcmstb-waketimer: fix settime function
Message-ID: <20170628200839.3114345-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc warns about an unused variable in the new driver:

drivers/rtc/rtc-brcmstb-waketimer.c: In function 'brcmstb_waketmr_settime':
drivers/rtc/rtc-brcmstb-waketimer.c:142:6: error: unused variable 'ret' [-Werror=unused-variable]

The same function also doesn't handle overflow correctly, this makes
it return -EINVAL when passed a time that doesn't fit within the
range of the register.

Fixes: 9f4ad359c801 ("rtc: brcmstb-waketimer: Add Broadcom STB wake-timer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index 5dea6d0627d8..796ac792a381 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -138,10 +138,12 @@ static int brcmstb_waketmr_settime(struct device *dev,
 				   struct rtc_time *tm)
 {
 	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
-	unsigned long sec;
-	int ret;
+	time64_t sec;
+
+	sec = rtc_tm_to_time64(tm);
 
-	rtc_tm_to_time(tm, &sec);
+	if (sec > U32_MAX || sec < 0)
+		return -EINVAL;
 
 	writel_relaxed(sec, timer->base + BRCMSTB_WKTMR_COUNTER);
 
@@ -152,14 +154,14 @@ static int brcmstb_waketmr_getalarm(struct device *dev,
 				    struct rtc_wkalrm *alarm)
 {
 	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
-	unsigned long sec;
+	time64_t sec;
 	u32 reg;
 
 	sec = readl_relaxed(timer->base + BRCMSTB_WKTMR_ALARM);
 	if (sec != 0) {
 		/* Alarm is enabled */
 		alarm->enabled = 1;
-		rtc_time_to_tm(sec, &alarm->time);
+		rtc_time64_to_tm(sec, &alarm->time);
 	}
 
 	reg = readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
@@ -172,13 +174,16 @@ static int brcmstb_waketmr_setalarm(struct device *dev,
 				     struct rtc_wkalrm *alarm)
 {
 	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
-	unsigned long sec;
+	time64_t sec;
 
 	if (alarm->enabled)
-		rtc_tm_to_time(&alarm->time, &sec);
+		sec = rtc_tm_to_time64(&alarm->time);
 	else
 		sec = 0;
 
+	if (sec > U32_MAX || sec < 0)
+		return -EINVAL;
+
 	brcmstb_waketmr_set_alarm(timer, sec);
 
 	return 0;
-- 
2.9.0
