From: avinashphilip@ti.com (Philip, Avinash)
Date: Tue, 27 Nov 2012 14:18:12 +0530
Subject: [PATCH v5 07/12] pwm: pwm-tiehrpwm: Adding TBCLK gating support.
In-Reply-To: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
References: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1354006097-25895-8-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms (like AM33XX) requires clock gating from control module
explicitly for TBCLK. Enabling of this clock required for the
functioning of the time base sub module in EHRPWM module. Adding support
for handling by enabling the clock on PWM device enable & disable on PWM
device disable. Platforms don't have explicit TBCLK gating has to add
dummy TBCLK node.

Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
---
Changes since v4:
	- Made TBCLK gating as a must clock for EHRPWM. Platforms don't
	  have explicit TBCLK gating, has to populate dummy clock node for
	  TBCLK.

 drivers/pwm/pwm-tiehrpwm.c |   14 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index d3c1dff..56a1325 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -115,6 +115,7 @@ struct ehrpwm_pwm_chip {
 	void __iomem	*mmio_base;
 	unsigned long period_cycles[NUM_PWM_CHANNEL];
 	enum pwm_polarity polarity[NUM_PWM_CHANNEL];
+	struct	clk	*tbclk;
 };
 
 static inline struct ehrpwm_pwm_chip *to_ehrpwm_pwm_chip(struct pwm_chip *chip)
@@ -335,6 +336,9 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	/* Channels polarity can be configured from action qualifier module */
 	configure_polarity(pc, pwm->hwpwm);
 
+	/* Enable TBCLK before enabling PWM device */
+	clk_enable(pc->tbclk);
+
 	/* Enable time counter for free_run */
 	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_RUN_MASK, TBCTL_FREE_RUN);
 	return 0;
@@ -363,6 +367,9 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
 
+	/* Disabling TBCLK on PWM disable */
+	clk_disable(pc->tbclk);
+
 	/* Stop Time base counter */
 	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_RUN_MASK, TBCTL_STOP_NEXT);
 
@@ -432,6 +439,13 @@ static int __devinit ehrpwm_pwm_probe(struct platform_device *pdev)
 	if (!pc->mmio_base)
 		return  -EADDRNOTAVAIL;
 
+	/* Acquire tbclk for Time Base EHRPWM submodule */
+	pc->tbclk = devm_clk_get(&pdev->dev, "tbclk");
+	if (IS_ERR(pc->tbclk)) {
+		dev_err(&pdev->dev, "Failed to get tbclk\n");
+		return PTR_ERR(pc->tbclk);
+	}
+
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-- 
1.7.0.4
