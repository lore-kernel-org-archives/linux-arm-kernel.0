From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Mon, 26 Oct 2015 22:32:32 +0100
Subject: [PATCH 01/10] pwm: lpc18xx_pwm: use pwm_set_chip_data
In-Reply-To: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <1445895161-2317-2-git-send-email-o.schinagl@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

The lpc18xx driver currently manipulates the pwm_device struct directly
rather then using the pwm_set_chip_data. While the current method may
save a clock cycle or two, it is more obvious that data is set to the
chip pointer (especially since it is only a single int holding struct.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 11 +++++++----
 drivers/pwm/pwm-sun4i.c       | 11 +++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 9163085..0ab59f1 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -408,14 +408,17 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < lpc18xx_pwm->chip.npwm; i++) {
+		struct lpc18xx_pwm_data *lpc18xx_data;
+
 		pwm = &lpc18xx_pwm->chip.pwms[i];
-		pwm->chip_data = devm_kzalloc(lpc18xx_pwm->dev,
-					      sizeof(struct lpc18xx_pwm_data),
-					      GFP_KERNEL);
-		if (!pwm->chip_data) {
+		lpc18xx_data = devm_kzalloc(lpc18xx_pwm->dev,
+					    sizeof(struct lpc18xx_pwm_data),
+					    GFP_KERNEL);
+		if (!lpc18xx_data) {
 			ret = -ENOMEM;
 			goto remove_pwmchip;
 		}
+		pwm_set_chip_data(pwm, lpc18xx_data);
 	}
 
 	platform_set_drvdata(pdev, lpc18xx_pwm);
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index cd9dde5..5ec4e8e 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -244,6 +245,16 @@ static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 	val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
+	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
+	spin_unlock(&sun4i_pwm->ctrl_lock);
+
+	/* Allow for the PWM hardware to finish its last toggle. The pulse
+	 * may have just started and thus we should wait a full period.
+	 */
+	ndelay(pwm_get_period(pwm));
+
+	spin_lock(&sun4i_pwm->ctrl_lock);
+	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 	val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
 	spin_unlock(&sun4i_pwm->ctrl_lock);
-- 
2.6.1
