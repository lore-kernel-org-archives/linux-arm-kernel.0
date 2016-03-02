From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed,  2 Mar 2016 23:57:09 +0100
Subject: [PATCH v2] pwm: pwm-lpc18xx-sct: test clock rate to avoid division by
 0
Message-ID: <1456959443-10032-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The clk API may return 0 on clk_get_rate, so we should check the result before
using it as a divisor.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 9163085101bc94..9861fed4e67d04 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -360,6 +360,11 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	}
 
 	lpc18xx_pwm->clk_rate = clk_get_rate(lpc18xx_pwm->pwm_clk);
+	if (!lpc18xx_pwm->clk_rate) {
+		dev_err(&pdev->dev, "pwm clock has no frequency\n");
+		ret = -EINVAL;
+		goto disable_pwmclk;
+	}
 
 	mutex_init(&lpc18xx_pwm->res_lock);
 	mutex_init(&lpc18xx_pwm->period_lock);
-- 
2.7.0
