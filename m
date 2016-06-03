From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  3 Jun 2016 10:23:01 +0200
Subject: [PATCH 03/14] pwm: rockchip: Fix period and duty_cycle approximation
In-Reply-To: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1464942192-25967-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation always round down the duty and period
values, while it would be better to round them to the closest integer.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
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
