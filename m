From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 18 Sep 2013 17:06:21 +0200
Subject: [PATCH 2/2] pwm: atmel-tcb: fix max time computation for slow clk
 source
In-Reply-To: <1379516720-23289-1-git-send-email-b.brezillon@overkiz.com>
References: <1379516720-23289-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1379516781-23379-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the the tcb counter width to compute the maximum time that can be
represented using the slow clock source instead of the static 16 bit width.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/pwm/pwm-atmel-tcb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 0266969..f3dcd02 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -307,7 +307,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		i = slowclk;
 		rate = 32768;
 		min = div_u64(NSEC_PER_SEC, rate);
-		max = min << 16;
+		max = min << tc->tcb_config->counter_width;
 
 		/* If period is too big return ERANGE error */
 		if (max < period_ns)
-- 
1.7.9.5
