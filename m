From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Sun, 29 Apr 2012 21:02:30 +0200
Subject: [PATCH 3/3] pwm: fix pwmchip_add return code test
In-Reply-To: <1335726150-22600-1-git-send-email-eric@eukrea.com>
References: <1335726150-22600-1-git-send-email-eric@eukrea.com>
Message-ID: <1335726150-22600-3-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* this should fail only if the value is negative.

* else after a pwm is allocated using alloc_pwms, ret contains the number
of the pwm and is returned by pwmchip_add so the calling driver
(pwm-imx in my case) fails with the following log :
mxc_pwm: probe of mxc_pwm.1 failed with error 1
mxc_pwm: probe of mxc_pwm.2 failed with error 2
mxc_pwm: probe of mxc_pwm.3 failed with error 3

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/pwm/pwm-imx.c     |    2 +-
 drivers/pwm/pwm-samsung.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index d69275f..24384cb 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -201,7 +201,7 @@ static int __devinit imx_pwm_probe(struct platform_device *pdev)
 	}
 
 	ret = pwmchip_add(&imx->chip);
-	if (ret)
+	if (ret < 0)
 		goto err_iounmap;
 
 	platform_set_drvdata(pdev, imx);
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 631edf0..c40c37e 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -253,7 +253,7 @@ static int s3c_pwm_probe(struct platform_device *pdev)
 	local_irq_restore(flags);
 
 	ret = pwmchip_add(&s3c->chip);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(dev, "failed to register pwm\n");
 		goto err_clk_tdiv;
 	}
-- 
1.7.7.6
