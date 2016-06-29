From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Jun 2016 19:05:21 +0100
Subject: Applied "regulator: rn5t618: Add RN5T567 PMIC support" to the
 regulator tree
In-Reply-To: <20160605001749.4062-4-stefan@agner.ch>
Message-ID: <E1bIJrV-0003fg-Vm@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: rn5t618: Add RN5T567 PMIC support

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ed6d362d8dbc3494cd98cd771737ea8b1407ed61 Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Tue, 28 Jun 2016 22:53:20 -0700
Subject: [PATCH] regulator: rn5t618: Add RN5T567 PMIC support

Extend the driver to support Ricoh RN5T567. Support the additional
DCDC and slightly different voltage range of LDORTC1.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/Kconfig             |  5 +++--
 drivers/regulator/rn5t618-regulator.c | 40 +++++++++++++++++++++++++++++++----
 include/linux/mfd/rn5t618.h           |  1 +
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 144cbf5b3e5a..547269416950 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -636,10 +636,11 @@ config REGULATOR_RK808
 	  outputs which can be controlled by i2c communication.
 
 config REGULATOR_RN5T618
-	tristate "Ricoh RN5T618 voltage regulators"
+	tristate "Ricoh RN5T567/618 voltage regulators"
 	depends on MFD_RN5T618
 	help
-	  Say y here to support the regulators found on Ricoh RN5T618 PMIC.
+	  Say y here to support the regulators found on Ricoh RN5T567 or
+	  RN5T618 PMIC.
 
 config REGULATOR_RT5033
 	tristate "Richtek RT5033 Regulators"
diff --git a/drivers/regulator/rn5t618-regulator.c b/drivers/regulator/rn5t618-regulator.c
index b85ceb8ff911..9c930eb68cda 100644
--- a/drivers/regulator/rn5t618-regulator.c
+++ b/drivers/regulator/rn5t618-regulator.c
@@ -46,6 +46,23 @@ static struct regulator_ops rn5t618_reg_ops = {
 		.vsel_mask	= (vmask),				\
 	}
 
+static struct regulator_desc rn5t567_regulators[] = {
+	/* DCDC */
+	REG(DCDC1, DC1CTL, BIT(0), DC1DAC, 0xff, 600000, 3500000, 12500),
+	REG(DCDC2, DC2CTL, BIT(0), DC2DAC, 0xff, 600000, 3500000, 12500),
+	REG(DCDC3, DC3CTL, BIT(0), DC3DAC, 0xff, 600000, 3500000, 12500),
+	REG(DCDC4, DC4CTL, BIT(0), DC4DAC, 0xff, 600000, 3500000, 12500),
+	/* LDO */
+	REG(LDO1, LDOEN1, BIT(0), LDO1DAC, 0x7f, 900000, 3500000, 25000),
+	REG(LDO2, LDOEN1, BIT(1), LDO2DAC, 0x7f, 900000, 3500000, 25000),
+	REG(LDO3, LDOEN1, BIT(2), LDO3DAC, 0x7f, 600000, 3500000, 25000),
+	REG(LDO4, LDOEN1, BIT(3), LDO4DAC, 0x7f, 900000, 3500000, 25000),
+	REG(LDO5, LDOEN1, BIT(4), LDO5DAC, 0x7f, 900000, 3500000, 25000),
+	/* LDO RTC */
+	REG(LDORTC1, LDOEN2, BIT(4), LDORTCDAC, 0x7f, 1200000, 3500000, 25000),
+	REG(LDORTC2, LDOEN2, BIT(5), LDORTC2DAC, 0x7f, 900000, 3500000, 25000),
+};
+
 static struct regulator_desc rn5t618_regulators[] = {
 	/* DCDC */
 	REG(DCDC1, DC1CTL, BIT(0), DC1DAC, 0xff, 600000, 3500000, 12500),
@@ -67,18 +84,33 @@ static int rn5t618_regulator_probe(struct platform_device *pdev)
 	struct rn5t618 *rn5t618 = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
+	struct regulator_desc *regulators;
 	int i;
 
+	switch (rn5t618->variant) {
+	case RN5T567:
+		regulators = rn5t567_regulators;
+		break;
+	case RN5T618:
+		regulators = rn5t618_regulators;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	config.dev = pdev->dev.parent;
+	config.regmap = rn5t618->regmap;
+
 	for (i = 0; i < RN5T618_REG_NUM; i++) {
-		config.dev = pdev->dev.parent;
-		config.regmap = rn5t618->regmap;
+		if (!regulators[i].name)
+			continue;
 
 		rdev = devm_regulator_register(&pdev->dev,
-					       &rn5t618_regulators[i],
+					       &regulators[i],
 					       &config);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev, "failed to register %s regulator\n",
-				rn5t618_regulators[i].name);
+				regulators[i].name);
 			return PTR_ERR(rdev);
 		}
 	}
diff --git a/include/linux/mfd/rn5t618.h b/include/linux/mfd/rn5t618.h
index 54179c2577ae..cadc6543909d 100644
--- a/include/linux/mfd/rn5t618.h
+++ b/include/linux/mfd/rn5t618.h
@@ -217,6 +217,7 @@ enum {
 	RN5T618_DCDC1,
 	RN5T618_DCDC2,
 	RN5T618_DCDC3,
+	RN5T618_DCDC4,
 	RN5T618_LDO1,
 	RN5T618_LDO2,
 	RN5T618_LDO3,
-- 
2.8.1
