From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 22 Jun 2011 23:20:14 +0200
Subject: [PATCH 2/2] rtc: vt8500: use define instead of hardcoded value for
	status bit
In-Reply-To: <1308777614-19043-1-git-send-email-w.sang@pengutronix.de>
References: <1308777614-19043-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1308777614-19043-2-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Alexey Charkov <alchark@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
---

I guess 3.1 is fine for this one.

 drivers/rtc/rtc-vt8500.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-vt8500.c b/drivers/rtc/rtc-vt8500.c
index efd6066..f93f412 100644
--- a/drivers/rtc/rtc-vt8500.c
+++ b/drivers/rtc/rtc-vt8500.c
@@ -74,6 +74,8 @@
 #define VT8500_RTC_CR_SM_SEC	(1 << 3)	/* 0: 1Hz/60, 1: 1Hz */
 #define VT8500_RTC_CR_CALIB	(1 << 4)	/* Enable calibration */
 
+#define VT8500_RTC_IS_ALARM	(1 << 0)	/* Alarm interrupt status */
+
 struct vt8500_rtc {
 	void __iomem		*regbase;
 	struct resource		*res;
@@ -96,7 +98,7 @@ static irqreturn_t vt8500_rtc_irq(int irq, void *dev_id)
 
 	spin_unlock(&vt8500_rtc->lock);
 
-	if (isr & 1)
+	if (isr & VT8500_RTC_IS_ALARM)
 		events |= RTC_AF | RTC_IRQF;
 
 	rtc_update_irq(vt8500_rtc->rtc, 1, events);
@@ -161,8 +163,8 @@ static int vt8500_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	alrm->time.tm_sec = bcd2bin((alarm & TIME_SEC_MASK));
 
 	alrm->enabled = (alarm & ALARM_ENABLE_MASK) ? 1 : 0;
+	alrm->pending = (isr & VT8500_RTC_IS_ALARM) ? 1 : 0;
 
-	alrm->pending = (isr & 1) ? 1 : 0;
 	return rtc_valid_tm(&alrm->time);
 }
 
-- 
1.7.2.5
