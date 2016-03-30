From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:03:52 +0200
Subject: [PATCH v5 29/46] regulator: pwm: properly initialize the ->state field
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-30-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ->state field is currently initialized to 0, thus referencing the
voltage selector at index 0, which might not reflect the current voltage
value.
If possible, retrieve the current voltage selector from the PWM state, else
return -EINVAL.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pwm-regulator.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 42cc312..9374796 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -48,10 +48,35 @@ struct pwm_voltages {
 /**
  * Voltage table call-backs
  */
+static void pwm_regulator_init_state(struct regulator_dev *rdev)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
+	struct pwm_state pwm_state;
+	unsigned int dutycycle;
+	int i;
+
+	pwm_get_state(drvdata->pwm, &pwm_state);
+
+	if (!pwm_state.period)
+		return;
+
+	dutycycle = (pwm_state.duty_cycle * 100) / pwm_state.period;
+
+	for (i = 0; i < rdev->desc->n_voltages; i++) {
+		if (dutycycle == drvdata->duty_cycle_table[i].dutycycle) {
+			drvdata->state = i;
+			return;
+		}
+	}
+}
+
 static int pwm_regulator_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
 
+	if (drvdata->state < 0)
+		pwm_regulator_init_state(rdev);
+
 	return drvdata->state;
 }
 
@@ -234,6 +259,7 @@ static int pwm_regulator_init_table(struct platform_device *pdev,
 		return ret;
 	}
 
+	drvdata->state			= -EINVAL;
 	drvdata->duty_cycle_table	= duty_cycle_table;
 	memcpy(&drvdata->ops, &pwm_regulator_voltage_table_ops,
 	       sizeof(drvdata->ops));
-- 
2.5.0
