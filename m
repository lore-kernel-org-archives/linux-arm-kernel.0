From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jul 2015 09:58:32 +0100
Subject: [RESEND 10/10] regulator: pwm-regulator: Don't assign structure
 attributes right away
In-Reply-To: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
References: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1436173112-21397-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Perhaps this is just personal preference, but ...

This patch introduces a new local variable to receive and test regulator
initialisation data.  It simplifies and cleans up the code making it
that little bit easier to read and maintain.  The local value is assigned
to the structure attribute when all the others are.  This is the way we
usually do things.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/pwm-regulator.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index d5cb267..cb48208 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -218,6 +218,7 @@ static int pwm_regulator_init_continuous(struct platform_device *pdev,
 
 static int pwm_regulator_probe(struct platform_device *pdev)
 {
+	const struct regulator_init_data *init_data;
 	struct pwm_regulator_data *drvdata;
 	struct regulator_dev *regulator;
 	struct regulator_config config = { };
@@ -240,14 +241,15 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	config.init_data = of_get_regulator_init_data(&pdev->dev, np,
-						      &pwm_regulator_desc);
-	if (!config.init_data)
+	init_data = of_get_regulator_init_data(&pdev->dev, np,
+					       &pwm_regulator_desc);
+	if (!init_data)
 		return -ENOMEM;
 
 	config.of_node = np;
 	config.dev = &pdev->dev;
 	config.driver_data = drvdata;
+	config.init_data = init_data;
 
 	drvdata->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(drvdata->pwm)) {
-- 
1.9.1
