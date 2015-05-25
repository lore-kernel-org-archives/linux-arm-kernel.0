From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 25 May 2015 15:19:56 +0200
Subject: [PATCH 2/2] PWM: atmel: fix incorrect CDTY value after disabling
In-Reply-To: <1432559996-4415-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432559996-4415-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1432559996-4415-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pwm-leds calls .config() and .disable() in a row. This exhibits that it may
happen that the channel gets disabled before CDTY has been updated with CUPD.
The issue gets quite worse with long periods.
So, ensure that at least one period has past before disabling the channel by
polling ISR.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pwm/pwm-atmel.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 89f9ca41d9af..054db5aacd7a 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -21,6 +22,7 @@
 #define PWM_ENA			0x04
 #define PWM_DIS			0x08
 #define PWM_SR			0x0C
+#define PWM_ISR			0x1C
 /* Bit field in SR */
 #define PWM_SR_ALL_CH_ON	0x0F
 
@@ -243,6 +245,17 @@ static int atmel_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
+	unsigned long timeout = jiffies + 2 * HZ;
+
+	/*
+	 * Wait for at least a complete period to have passed before disabling a
+	 * channel to be sure that CDTY has been updated
+	 */
+	atmel_pwm_readl(atmel_pwm, PWM_ISR);
+
+	while (!(atmel_pwm_readl(atmel_pwm, PWM_ISR) & (1 << pwm->hwpwm)) &&
+	       time_before(jiffies, timeout))
+		usleep_range(10, 100);
 
 	atmel_pwm_writel(atmel_pwm, PWM_DIS, 1 << pwm->hwpwm);
 
-- 
2.1.4
