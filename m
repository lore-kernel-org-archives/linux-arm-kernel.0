From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  1 Mar 2016 18:03:12 +0100
Subject: [PATCH] rtc: vr41xx: remove unused function:
Message-ID: <1456851797-3510153-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vr41xx_rtc_alarm_irq_enable function is never called
has no effect other than producing a warning:

drivers/rtc/rtc-vr41xx.c:228:12: error: 'vr41xx_rtc_alarm_irq_enable' defined but not used [-Werror=unused-function]

This removes it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-vr41xx.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index f64c282275b3..68cb63ef1e44 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -225,24 +225,6 @@ static int vr41xx_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long
 	return 0;
 }
 
-static int vr41xx_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
-{
-	spin_lock_irq(&rtc_lock);
-	if (enabled) {
-		if (!alarm_enabled) {
-			enable_irq(aie_irq);
-			alarm_enabled = 1;
-		}
-	} else {
-		if (alarm_enabled) {
-			disable_irq(aie_irq);
-			alarm_enabled = 0;
-		}
-	}
-	spin_unlock_irq(&rtc_lock);
-	return 0;
-}
-
 static irqreturn_t elapsedtime_interrupt(int irq, void *dev_id)
 {
 	struct platform_device *pdev = (struct platform_device *)dev_id;
-- 
2.7.0
