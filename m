From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:42:26 +0100
Subject: [PATCH 129/222] leds: leds-pwm: implement PWM inversion
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeWQ-0007Lq-Ds@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some PWM outputs are wired such that the LED they're controlling is
connected to supply rather than ground.  These PWMs may not support
output inversion, or when they do, disabling the PWM may set the
PWM output low, causing a "brightness" value of zero to turn the LED
fully on.

The platform data for this driver already indicates that this was
thought about, and we have the "active_low" property there already.
However, the implementation for this is missing.

Add the trivial implementation for this feature.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/leds/leds-pwm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 35c1c5f144dc..8bd225df14de 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -69,6 +69,10 @@ static void led_pwm_set(struct led_classdev *led_cdev,
 
 	duty *= brightness;
 	do_div(duty, max);
+
+	if (led_dat->active_low)
+		duty = led_dat->period - duty;
+
 	led_dat->duty = duty;
 
 	if (led_dat->can_sleep)
-- 
1.8.3.1
