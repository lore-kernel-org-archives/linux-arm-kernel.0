From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Tue, 18 Nov 2014 21:38:42 +0200
Subject: [PATCH 4/5] pwm: do not set of_pwm_xlate_with_flags() as a callback
In-Reply-To: <1416339523-7967-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1416339438-7867-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1416339523-7967-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1416339523-7967-4-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default of_pwm_simple_xlate() function is capable to process PWM
inverted signal polarity flag, there is no need to use exported
of_pwm_xlate_with_flags() by the drivers.

The minimal expected by of_pwm_simple_xlate() amount of pwms arguments
is changed from 3 to 2, it allows to specify less PWM arguments in the
device tree omitting secondary configuration options (in this case it
is signal polarity value). The change has side effects, only if

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: linux-pwm at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
---
 drivers/pwm/pwm-atmel-hlcdc.c |    2 --
 drivers/pwm/pwm-atmel-tcb.c   |    2 --
 drivers/pwm/pwm-atmel.c       |    6 ------
 drivers/pwm/pwm-bcm-kona.c    |    2 --
 drivers/pwm/pwm-fsl-ftm.c     |    2 --
 drivers/pwm/pwm-renesas-tpu.c |    2 --
 drivers/pwm/pwm-rockchip.c    |    5 -----
 drivers/pwm/pwm-samsung.c     |    3 ---
 drivers/pwm/pwm-tiecap.c      |    2 --
 drivers/pwm/pwm-tiehrpwm.c    |    2 --
 drivers/pwm/pwm-vt8500.c      |    2 --
 11 files changed, 30 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index eaf8b12..492a1b5 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -209,8 +209,6 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 	chip->chip.dev = dev;
 	chip->chip.base = -1;
 	chip->chip.npwm = 1;
-	chip->chip.of_xlate = of_pwm_xlate_with_flags;
-	chip->chip.of_pwm_n_cells = 3;
 	chip->chip.can_sleep = 1;
 
 	ret = pwmchip_add(&chip->chip);
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index d56e5b7..cbc46ad 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -394,8 +394,6 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 
 	tcbpwm->chip.dev = &pdev->dev;
 	tcbpwm->chip.ops = &atmel_tcb_pwm_ops;
-	tcbpwm->chip.of_xlate = of_pwm_xlate_with_flags;
-	tcbpwm->chip.of_pwm_n_cells = 3;
 	tcbpwm->chip.base = -1;
 	tcbpwm->chip.npwm = NPWM;
 	tcbpwm->tc = tc;
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index d3c22de..b57079d 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -347,12 +347,6 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	atmel_pwm->chip.dev = &pdev->dev;
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
-
-	if (pdev->dev.of_node) {
-		atmel_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
-		atmel_pwm->chip.of_pwm_n_cells = 3;
-	}
-
 	atmel_pwm->chip.base = -1;
 	atmel_pwm->chip.npwm = 4;
 	atmel_pwm->chip.can_sleep = true;
diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 02bc048..df2e03d 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -244,8 +244,6 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 	kp->chip.ops = &kona_pwm_ops;
 	kp->chip.base = -1;
 	kp->chip.npwm = 6;
-	kp->chip.of_xlate = of_pwm_xlate_with_flags;
-	kp->chip.of_pwm_n_cells = 3;
 	kp->chip.can_sleep = true;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 0f2cc7e..366d55b 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -454,8 +454,6 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_CNTEN]);
 
 	fpc->chip.ops = &fsl_pwm_ops;
-	fpc->chip.of_xlate = of_pwm_xlate_with_flags;
-	fpc->chip.of_pwm_n_cells = 3;
 	fpc->chip.base = -1;
 	fpc->chip.npwm = 8;
 	fpc->chip.can_sleep = true;
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 3b71b42..46bc415 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -418,8 +418,6 @@ static int tpu_probe(struct platform_device *pdev)
 
 	tpu->chip.dev = &pdev->dev;
 	tpu->chip.ops = &tpu_pwm_ops;
-	tpu->chip.of_xlate = of_pwm_xlate_with_flags;
-	tpu->chip.of_pwm_n_cells = 3;
 	tpu->chip.base = -1;
 	tpu->chip.npwm = TPU_CHANNEL_MAX;
 
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 9442df2..8dc09e8 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -265,11 +265,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	pc->chip.base = -1;
 	pc->chip.npwm = 1;
 
-	if (pc->data->ops->set_polarity) {
-		pc->chip.of_xlate = of_pwm_xlate_with_flags;
-		pc->chip.of_pwm_n_cells = 3;
-	}
-
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
 		clk_unprepare(pc->clk);
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index ba6b650..6cc6913 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -482,9 +482,6 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 		ret = pwm_samsung_parse_dt(chip);
 		if (ret)
 			return ret;
-
-		chip->chip.of_xlate = of_pwm_xlate_with_flags;
-		chip->chip.of_pwm_n_cells = 3;
 	} else {
 		if (!pdev->dev.platform_data) {
 			dev_err(&pdev->dev, "no platform data specified\n");
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 74efbe7..bd6f477 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -226,8 +226,6 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &ecap_pwm_ops;
-	pc->chip.of_xlate = of_pwm_xlate_with_flags;
-	pc->chip.of_pwm_n_cells = 3;
 	pc->chip.base = -1;
 	pc->chip.npwm = 1;
 
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index cb75133..43c164e 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -457,8 +457,6 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &ehrpwm_pwm_ops;
-	pc->chip.of_xlate = of_pwm_xlate_with_flags;
-	pc->chip.of_pwm_n_cells = 3;
 	pc->chip.base = -1;
 	pc->chip.npwm = NUM_PWM_CHANNEL;
 
diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 652e6b5..234c356 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -216,8 +216,6 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 
 	chip->chip.dev = &pdev->dev;
 	chip->chip.ops = &vt8500_pwm_ops;
-	chip->chip.of_xlate = of_pwm_xlate_with_flags;
-	chip->chip.of_pwm_n_cells = 3;
 	chip->chip.base = -1;
 	chip->chip.npwm = VT8500_NR_PWMS;
 
-- 
1.7.10.4
