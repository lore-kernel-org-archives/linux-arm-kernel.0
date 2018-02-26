From: justin.chen@broadcom.com (Justin Chen)
Date: Mon, 26 Feb 2018 12:09:58 -0800
Subject: [PATCH v2] rtc: brcmstb-waketimer: Set wktmr prescaler
Message-ID: <1519675798-26720-1-git-send-email-justin.chen@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HW default is one tick per second, however instead of assuming this,
lets make sure the waketimer is actually one tick per second before
arming the alarm.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index 796ac79..231b2f7 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -60,6 +60,9 @@ static void brcmstb_waketmr_set_alarm(struct brcmstb_waketmr *timer,
 {
 	brcmstb_waketmr_clear_alarm(timer);
 
+	/* Make sure we are actually counting in seconds */
+	writel_relaxed(timer->rate, timer->base + BRCMSTB_WKTMR_PRESCALER);
+
 	writel_relaxed(secs + 1, timer->base + BRCMSTB_WKTMR_ALARM);
 }
 
-- 
2.7.4
