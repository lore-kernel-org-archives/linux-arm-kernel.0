From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Tue, 25 Oct 2011 10:21:41 +0900
Subject: [PATCH] ARM: SAMSUNG: Add clk enable/disable of pwm
Message-ID: <1319505701-9784-1-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PWM timers use pclk("timers" clk) as parent clk. If this pclk is the
disabled state when PWM driver is probed, then it causes wrong read and
write operation about registers of PWM.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/pwm.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/pwm.c b/arch/arm/plat-samsung/pwm.c
index f37457c..dc1185d 100644
--- a/arch/arm/plat-samsung/pwm.c
+++ b/arch/arm/plat-samsung/pwm.c
@@ -299,6 +299,9 @@ static int s3c_pwm_probe(struct platform_device *pdev)
 		goto err_clk_tin;
 	}
 
+	clk_enable(pwm->clk);
+	clk_enable(pwm->clk_div);
+
 	local_irq_save(flags);
 
 	tcon = __raw_readl(S3C2410_TCON);
@@ -326,6 +329,8 @@ static int s3c_pwm_probe(struct platform_device *pdev)
 	return 0;
 
  err_clk_tdiv:
+	clk_disable(pwm->clk_div);
+	clk_disable(pwm->clk);
 	clk_put(pwm->clk_div);
 
  err_clk_tin:
@@ -340,6 +345,8 @@ static int __devexit s3c_pwm_remove(struct platform_device *pdev)
 {
 	struct pwm_device *pwm = platform_get_drvdata(pdev);
 
+	clk_disable(pwm->clk_div);
+	clk_disable(pwm->clk);
 	clk_put(pwm->clk_div);
 	clk_put(pwm->clk);
 	kfree(pwm);
-- 
1.7.5.4
