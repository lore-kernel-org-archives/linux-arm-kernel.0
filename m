From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Sun, 20 May 2018 22:27:30 +0200
Subject: [PATCH 2/2] rtc: brcmstb-waketimer: add range
In-Reply-To: <20180520202730.28172-1-alexandre.belloni@bootlin.com>
References: <20180520202730.28172-1-alexandre.belloni@bootlin.com>
Message-ID: <20180520202730.28172-2-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the core handle the range.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index ba49d9bcff12..f4010a75f2be 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -145,9 +145,6 @@ static int brcmstb_waketmr_settime(struct device *dev,
 
 	sec = rtc_tm_to_time64(tm);
 
-	if (sec > U32_MAX || sec < 0)
-		return -EINVAL;
-
 	writel_relaxed(sec, timer->base + BRCMSTB_WKTMR_COUNTER);
 
 	return 0;
@@ -184,9 +181,6 @@ static int brcmstb_waketmr_setalarm(struct device *dev,
 	else
 		sec = 0;
 
-	if (sec > U32_MAX || sec < 0)
-		return -EINVAL;
-
 	brcmstb_waketmr_set_alarm(timer, sec);
 
 	return 0;
@@ -266,6 +260,7 @@ static int brcmstb_waketmr_probe(struct platform_device *pdev)
 	register_reboot_notifier(&timer->reboot_notifier);
 
 	timer->rtc->ops = &brcmstb_waketmr_ops;
+	timer->rtc->range_max = U32_MAX;
 
 	ret = rtc_register_device(timer->rtc);
 	if (ret) {
-- 
2.17.0
