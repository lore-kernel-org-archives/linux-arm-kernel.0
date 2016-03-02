From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed,  2 Mar 2016 23:33:35 +0100
Subject: [PATCH 4/6] pwm: pwm-lpc18xx-sct: test clock rate to avoid division
 by 0
In-Reply-To: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
References: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1456958018-7849-5-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The clk API may return 0 on clk_get_rate, so we should check the result before
using it as a divisor.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Should go individually via subsystem tree.

 drivers/pwm/pwm-lpc18xx-sct.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 9163085101bc94..6487962c355c03 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -360,6 +360,8 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	}
 
 	lpc18xx_pwm->clk_rate = clk_get_rate(lpc18xx_pwm->pwm_clk);
+	if (!lpc18xx_pwm->clk_rate)
+		return -EINVAL;
 
 	mutex_init(&lpc18xx_pwm->res_lock);
 	mutex_init(&lpc18xx_pwm->period_lock);
-- 
2.7.0
