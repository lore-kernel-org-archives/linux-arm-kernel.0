From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 14 Jun 2016 11:13:17 +0200
Subject: [PATCH v3 09/14] regulator: pwm: Adjust PWM config at probe time
In-Reply-To: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1465895602-31008-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PWM attached to a PWM regulator device might have been previously
configured by the bootloader.
Make sure the bootloader and linux config are in sync, and adjust the PWM
config if that's not the case.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/regulator/pwm-regulator.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index ab3cc02..524b43f 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -285,11 +285,9 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to the
-	 * atomic PWM API.
-	 */
-	pwm_apply_args(drvdata->pwm);
+	ret = pwm_adjust_config(drvdata->pwm);
+	if (ret)
+		return ret;
 
 	regulator = devm_regulator_register(&pdev->dev,
 					    &drvdata->desc, &config);
-- 
2.7.4
