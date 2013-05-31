From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 31 May 2013 15:37:07 -0700
Subject: [PATCH] rtc: rtc-twl: ensure IRQ is wakeup enabled
Message-ID: <1370039827-25033-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the RTC IRQ is never wakeup-enabled so is not capable of
bringing the system out of suspend.

On OMAP platforms, we have gotten by without this because the TWL RTC
is on an I2C-connected chip which is capable of waking up the OMAP via
the IO ring when the OMAP is in low-power states.

However, if the OMAP suspends without hitting the low-power states
(and the IO ring is not enabled), RTC wakeups will not work because
the IRQ is not wakeup enabled.

To fix, ensure the RTC IRQ is wakeup enabled whenever the RTC alarm is
set.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/rtc/rtc-twl.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 8751a52..bbda0fd 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -213,12 +213,24 @@ static int mask_rtc_irq_bit(unsigned char bit)
 
 static int twl_rtc_alarm_irq_enable(struct device *dev, unsigned enabled)
 {
+	struct platform_device *pdev = to_platform_device(dev);
+	int irq = platform_get_irq(pdev, 0);
+	static bool twl_rtc_wake_enabled;
 	int ret;
 
-	if (enabled)
+	if (enabled) {
 		ret = set_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
-	else
+		if (device_can_wakeup(dev) && !twl_rtc_wake_enabled) {
+			enable_irq_wake(irq);
+			twl_rtc_wake_enabled = true;
+		}
+	} else {
 		ret = mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
+		if (twl_rtc_wake_enabled) {
+			disable_irq_wake(irq);
+			twl_rtc_wake_enabled = false;
+		}
+	}
 
 	return ret;
 }
-- 
1.8.2
