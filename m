From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  8 Jun 2016 18:34:37 +0200
Subject: [PATCH v2 02/13] pwm: rockchip: Fix period and duty_cycle
 approximation
In-Reply-To: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1465403688-17098-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation always round down the duty and period
values, while it would be better to round them to the closest integer.

These changes are needed in preparation of atomic update support to
prevent a period/duty cycle drift when executing several time the
'pwm_get_state() / modify / pwm_apply_state()' sequence.

Say you have an expected period of 3.333 us and a clk rate of
112.666667 MHz -- the clock frequency doesn't divide evenly,
so the period (stashed in nanoseconds) shrinks when we convert to
the register value and back, as follows:

  pwm_apply_state(): register = period * 112666667 / 1000000000;
  pwm_get_state(): period = register * 1000000000 / 112666667;

or in other words:

  period = period * 112666667 / 1000000000 * 1000000000 / 112666667;

which yields a sequence like:

  3333 -> 3328
  3328 -> 3319
  3319 -> 3310
  3310 -> 3301
  3301 -> 3292
  3292 -> ... (etc) ...

With this patch, we'd see instead:

  period = div_round_closest(period * 112666667, 1000000000) *
	   1000000000 / 112666667;

which yields a stable sequence:

  3333 -> 3337
  3337 -> 3337
  3337 -> ... (etc) ...

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
---
 drivers/pwm/pwm-rockchip.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 7d9cc90..68d72ce 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -114,12 +114,11 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * default prescaler value for all practical clock rate values.
 	 */
 	div = clk_rate * period_ns;
-	do_div(div, pc->data->prescaler * NSEC_PER_SEC);
-	period = div;
+	period = DIV_ROUND_CLOSEST_ULL(div,
+				       pc->data->prescaler * NSEC_PER_SEC);
 
 	div = clk_rate * duty_ns;
-	do_div(div, pc->data->prescaler * NSEC_PER_SEC);
-	duty = div;
+	duty = DIV_ROUND_CLOSEST_ULL(div, pc->data->prescaler * NSEC_PER_SEC);
 
 	ret = clk_enable(pc->clk);
 	if (ret)
-- 
2.7.4
