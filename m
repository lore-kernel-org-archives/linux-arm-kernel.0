From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 22 Apr 2013 11:57:14 +0200
Subject: [PATCH 13/23] regulator: ab3100: refactor probe to use IDs
Message-ID: <1366624634-6579-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This refactors the AB3100 regulator probe to use regulator IDs
and pass this to a separate registration function. This works
much smoother when migrating to device tree, as we can use a
match table with this regulator ID encoded in the .driver_data.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Mark, seeking an ACK on this to take it through the
ARM SoC tree.
---
 drivers/regulator/ab3100.c | 90 ++++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 35 deletions(-)

diff --git a/drivers/regulator/ab3100.c b/drivers/regulator/ab3100.c
index 111ec69..740735d 100644
--- a/drivers/regulator/ab3100.c
+++ b/drivers/regulator/ab3100.c
@@ -488,6 +488,58 @@ ab3100_regulator_desc[AB3100_NUM_REGULATORS] = {
 	},
 };
 
+static int ab3100_regulator_register(struct platform_device *pdev,
+				     struct ab3100_platform_data *plfdata,
+				     int id)
+{
+	struct regulator_desc *desc;
+	struct ab3100_regulator *reg;
+	struct regulator_dev *rdev;
+	struct regulator_config config = { };
+	int err, i;
+
+	for (i = 0; i < AB3100_NUM_REGULATORS; i++) {
+		desc = &ab3100_regulator_desc[i];
+		if (desc->id == id)
+			break;
+	}
+	if (desc->id != id)
+		return -ENODEV;
+
+	/* Same index used for this array */
+	reg = &ab3100_regulators[i];
+
+	/*
+	 * Initialize per-regulator struct.
+	 * Inherit platform data, this comes down from the
+	 * i2c boarddata, from the machine. So if you want to
+	 * see what it looks like for a certain machine, go
+	 * into the machine I2C setup.
+	 */
+	reg->dev = &pdev->dev;
+	if (plfdata) {
+		/* This will be replaced by device tree data */
+		reg->plfdata = plfdata;
+		config.init_data = &plfdata->reg_constraints[i];
+	}
+	config.dev = &pdev->dev;
+	config.driver_data = reg;
+
+	rdev = regulator_register(desc, &config);
+	if (IS_ERR(rdev)) {
+		err = PTR_ERR(rdev);
+		dev_err(&pdev->dev,
+			"%s: failed to register regulator %s err %d\n",
+			__func__, desc->name,
+			err);
+		return err;
+	}
+
+	/* Then set a pointer back to the registered regulator */
+	reg->rdev = rdev;
+	return 0;
+}
+
 /*
  * NOTE: the following functions are regulators pluralis - it is the
  * binding to the AB3100 core driver and the parent platform device
@@ -497,7 +549,6 @@ ab3100_regulator_desc[AB3100_NUM_REGULATORS] = {
 static int ab3100_regulators_probe(struct platform_device *pdev)
 {
 	struct ab3100_platform_data *plfdata = pdev->dev.platform_data;
-	struct regulator_config config = { };
 	int err = 0;
 	u8 data;
 	int i;
@@ -530,42 +581,11 @@ static int ab3100_regulators_probe(struct platform_device *pdev)
 
 	/* Register the regulators */
 	for (i = 0; i < AB3100_NUM_REGULATORS; i++) {
-		struct ab3100_regulator *reg = &ab3100_regulators[i];
-		struct regulator_dev *rdev;
-
-		/*
-		 * Initialize per-regulator struct.
-		 * Inherit platform data, this comes down from the
-		 * i2c boarddata, from the machine. So if you want to
-		 * see what it looks like for a certain machine, go
-		 * into the machine I2C setup.
-		 */
-		reg->dev = &pdev->dev;
-		reg->plfdata = plfdata;
-
-		config.dev = &pdev->dev;
-		config.driver_data = reg;
-		config.init_data = &plfdata->reg_constraints[i];
+		struct regulator_desc *desc = &ab3100_regulator_desc[i];
 
-		/*
-		 * Register the regulator, pass around
-		 * the ab3100_regulator struct
-		 */
-		rdev = regulator_register(&ab3100_regulator_desc[i], &config);
-		if (IS_ERR(rdev)) {
-			err = PTR_ERR(rdev);
-			dev_err(&pdev->dev,
-				"%s: failed to register regulator %s err %d\n",
-				__func__, ab3100_regulator_desc[i].name,
-				err);
-			/* remove the already registered regulators */
-			while (--i >= 0)
-				regulator_unregister(ab3100_regulators[i].rdev);
+		err = ab3100_regulator_register(pdev, plfdata, desc->id);
+		if (err)
 			return err;
-		}
-
-		/* Then set a pointer back to the registered regulator */
-		reg->rdev = rdev;
 	}
 
 	return 0;
-- 
1.7.11.3
