From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:43:02 +0100
Subject: [PATCH 136/222] regulator: allow GPIO 0 to be used for an enable
 signal
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeX0-0007ML-68@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO number 0 *is* legal and must be accepted.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/regulator/anatop-regulator.c | 1 +
 drivers/regulator/core.c             | 2 +-
 drivers/regulator/dummy.c            | 1 +
 drivers/regulator/fixed.c            | 4 +---
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 7c397bb81e01..6da2fbbb9bd5 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -267,6 +267,7 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	config.driver_data = sreg;
 	config.of_node = pdev->dev.of_node;
 	config.regmap = sreg->anatop;
+	config.ena_gpio = -EINVAL;
 
 	/* Only core regulators have the ramp up delay configuration. */
 	if (sreg->control_reg && sreg->delay_bit_width) {
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9a09f3cdbabb..19c4077374b6 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3459,7 +3459,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 
 	dev_set_drvdata(&rdev->dev, rdev);
 
-	if (config->ena_gpio && gpio_is_valid(config->ena_gpio)) {
+	if (gpio_is_valid(config->ena_gpio)) {
 		ret = regulator_ena_gpio_request(rdev, config);
 		if (ret != 0) {
 			rdev_err(rdev, "Failed to request enable GPIO%d: %d\n",
diff --git a/drivers/regulator/dummy.c b/drivers/regulator/dummy.c
index 2436db9e2ca3..acc4ea593c95 100644
--- a/drivers/regulator/dummy.c
+++ b/drivers/regulator/dummy.c
@@ -48,6 +48,7 @@ static int dummy_regulator_probe(struct platform_device *pdev)
 
 	config.dev = &pdev->dev;
 	config.init_data = &dummy_initdata;
+	config.ena_gpio = -EINVAL;
 
 	dummy_regulator_rdev = regulator_register(&dummy_desc, &config);
 	if (IS_ERR(dummy_regulator_rdev)) {
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index c61f7e97e4f8..aabf10dc8a50 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -161,9 +161,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 		drvdata->desc.n_voltages = 1;
 
 	drvdata->desc.fixed_uV = config->microvolts;
-
-	if (config->gpio >= 0)
-		cfg.ena_gpio = config->gpio;
+	cfg.ena_gpio = config->gpio;
 	cfg.ena_gpio_invert = !config->enable_high;
 	if (config->enabled_at_boot) {
 		if (config->enable_high)
-- 
1.8.3.1
