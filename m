From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri,  7 Jun 2013 18:26:42 +0200
Subject: [RFC PATCH 30/50] pwm: atmel-tcb: prepare clk before calling enable
In-Reply-To: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1370622402-19693-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
avoid common clk framework warnings.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/pwm/pwm-atmel-tcb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 0a7b658..09be626 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -76,7 +76,7 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 	if (!tcbpwm)
 		return -ENOMEM;
 
-	ret = clk_enable(tc->clk[group]);
+	ret = clk_prepare_enable(tc->clk[group]);
 	if (ret) {
 		devm_kfree(chip->dev, tcbpwm);
 		return ret;
@@ -124,7 +124,7 @@ static void atmel_tcb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
 	struct atmel_tc *tc = tcbpwmc->tc;
 
-	clk_disable(tc->clk[pwm->hwpwm / 2]);
+	clk_disable_unprepare(tc->clk[pwm->hwpwm / 2]);
 	tcbpwmc->pwms[pwm->hwpwm] = NULL;
 	devm_kfree(chip->dev, tcbpwm);
 }
-- 
1.7.9.5
