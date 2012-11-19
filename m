From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 19 Nov 2012 15:06:20 +1300
Subject: [PATCH 2/2] pwm: vt8500: Ensure pwm clock is enabled during pwm_config
In-Reply-To: <1353290780-19413-1-git-send-email-linux@prisktech.co.nz>
References: <1353290780-19413-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1353290780-19413-3-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When all PWMs are disabled, PWM module may be disabled during
calls to pwm_config. This patch enables/disables the clock in
pwm_config to ensure the module is active before register read/
writes.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/pwm/pwm-vt8500.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 806f72c..cc97af9 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -63,6 +63,8 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long c;
 	unsigned long period_cycles, prescale, pv, dc;
 
+	clk_enable(vt8500->clk);
+
 	c = clk_get_rate(vt8500->clk);
 	c = c * period_ns;
 	do_div(c, 1000000000);
@@ -75,8 +77,10 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (pv > 4095)
 		pv = 4095;
 
-	if (prescale > 1023)
+	if (prescale > 1023) {
+		clk_disable(vt8500->clk);
 		return -EINVAL;
+	}
 
 	c = (unsigned long long)pv * duty_ns;
 	do_div(c, period_ns);
@@ -91,6 +95,7 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_busy_wait(vt8500->base + 0x40 + pwm->hwpwm, (1 << 3));
 	writel(dc, vt8500->base + 0xc + (pwm->hwpwm << 4));
 
+	clk_disable(vt8500->clk);
 	return 0;
 }
 
-- 
1.7.9.5
