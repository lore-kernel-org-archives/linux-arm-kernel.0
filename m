From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  8 Jun 2016 18:34:42 +0200
Subject: [PATCH v2 07/13] pwm: sti: Avoid glitches on already running PWMs
In-Reply-To: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1465403688-17098-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current logic will disable the PWM clk even if a PWM was left
enabled by the bootloader (because it's controlling a critical device
like a regulator for example).
Keep the PWM clk enabled if at least one PWM is enabled to avoid any
glitches.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-sti.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 6300d3e..5bda51d 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -340,7 +340,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	struct sti_pwm_compat_data *cdata;
 	struct sti_pwm_chip *pc;
 	struct resource *res;
-	int ret;
+	int i, ret;
 
 	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc)
@@ -391,7 +391,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = clk_prepare(pc->clk);
+	ret = clk_prepare_enable(pc->clk);
 	if (ret) {
 		dev_err(dev, "failed to prepare clock\n");
 		return ret;
@@ -409,6 +409,16 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * Keep the PWM clk enabled if some PWMs appear to be up and
+	 * running.
+	 */
+	for (i = 0; i < pc->chip.npwm; i++) {
+		if (pwm_is_enabled(&pc->chip.pwms[i]))
+			clk_enable(pc->clk);
+	}
+	clk_disable(pc->clk);
+
 	platform_set_drvdata(pdev, pc);
 
 	return 0;
-- 
2.7.4
