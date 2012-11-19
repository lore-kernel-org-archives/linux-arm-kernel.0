From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 19 Nov 2012 20:30:54 +1300
Subject: [PATCH v2 2/2] pwm: vt8500: Ensure pwm clock is enabled during
 pwm_config
In-Reply-To: <1353310254-21581-1-git-send-email-linux@prisktech.co.nz>
References: <1353310254-21581-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1353310254-21581-3-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch corrects a bug reported by Peter Vasil.

When all PWMs are disabled, PWM module may be disabled during
calls to pwm_config. This patch enables/disables the clock in
pwm_config to ensure the module is active before register read/
writes.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
Tested-by: Peter Vasil <petervasil@gmail.com>
---
 drivers/pwm/pwm-vt8500.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 806f72c..9fdb70d 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -62,6 +62,13 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct vt8500_chip *vt8500 = to_vt8500_chip(chip);
 	unsigned long long c;
 	unsigned long period_cycles, prescale, pv, dc;
+	int err;
+
+	err = clk_enable(vt8500->clk);
+	if (err < 0) {
+		dev_err(chip->dev, "failed to enable clock in pwm_config()\n");
+		return err;
+	};
 
 	c = clk_get_rate(vt8500->clk);
 	c = c * period_ns;
@@ -75,8 +82,10 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (pv > 4095)
 		pv = 4095;
 
-	if (prescale > 1023)
+	if (prescale > 1023) {
+		clk_disable(vt8500->clk);
 		return -EINVAL;
+	}
 
 	c = (unsigned long long)pv * duty_ns;
 	do_div(c, period_ns);
@@ -91,6 +100,7 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_busy_wait(vt8500->base + 0x40 + pwm->hwpwm, (1 << 3));
 	writel(dc, vt8500->base + 0xc + (pwm->hwpwm << 4));
 
+	clk_disable(vt8500->clk);
 	return 0;
 }
 
-- 
1.7.9.5
