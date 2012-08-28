From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 28 Aug 2012 17:10:02 +0800
Subject: [PATCH v3 4/7] regulator: anatop-regulator: convert to use syscon to
 access anatop register
In-Reply-To: <1346145005-17961-1-git-send-email-b29396@freescale.com>
References: <1346145005-17961-1-git-send-email-b29396@freescale.com>
Message-ID: <1346145005-17961-5-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Using syscon to access anatop register.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
ChangeLog v2->v3:
 * update to use syscon_node_to_regmap and use of_get_parent to get anatop node.
ChangeLog v1-v2:
 * update to use generic regmap api
---
 drivers/regulator/Kconfig            |    2 +-
 drivers/regulator/anatop-regulator.c |   30 ++++++++++++++++++++----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 4e932cc..2ae1d97 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -112,7 +112,7 @@ config REGULATOR_DA9052
 
 config REGULATOR_ANATOP
 	tristate "Freescale i.MX on-chip ANATOP LDO regulators"
-	depends on MFD_ANATOP
+	depends on MFD_SYSCON
 	help
 	  Say y here to support Freescale i.MX on-chip ANATOP LDOs
 	  regulators. It is recommended that this option be
diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index ce0fe72..346e5f6 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -21,19 +21,20 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/mfd/syscon.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/mfd/anatop.h>
+#include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
 
 struct anatop_regulator {
 	const char *name;
 	u32 control_reg;
-	struct anatop *mfd;
+	struct regmap *anatop;
 	int vol_bit_shift;
 	int vol_bit_width;
 	int min_bit_val;
@@ -43,7 +44,8 @@ struct anatop_regulator {
 	struct regulator_init_data *initdata;
 };
 
-static int anatop_set_voltage_sel(struct regulator_dev *reg, unsigned selector)
+static int anatop_regmap_set_voltage_sel(struct regulator_dev *reg,
+					unsigned selector)
 {
 	struct anatop_regulator *anatop_reg = rdev_get_drvdata(reg);
 	u32 val, mask;
@@ -56,12 +58,13 @@ static int anatop_set_voltage_sel(struct regulator_dev *reg, unsigned selector)
 	mask = ((1 << anatop_reg->vol_bit_width) - 1) <<
 		anatop_reg->vol_bit_shift;
 	val <<= anatop_reg->vol_bit_shift;
-	anatop_write_reg(anatop_reg->mfd, anatop_reg->control_reg, val, mask);
+	regmap_update_bits(anatop_reg->anatop, anatop_reg->control_reg,
+				mask, val);
 
 	return 0;
 }
 
-static int anatop_get_voltage_sel(struct regulator_dev *reg)
+static int anatop_regmap_get_voltage_sel(struct regulator_dev *reg)
 {
 	struct anatop_regulator *anatop_reg = rdev_get_drvdata(reg);
 	u32 val, mask;
@@ -69,7 +72,7 @@ static int anatop_get_voltage_sel(struct regulator_dev *reg)
 	if (!anatop_reg->control_reg)
 		return -ENOTSUPP;
 
-	val = anatop_read_reg(anatop_reg->mfd, anatop_reg->control_reg);
+	regmap_read(anatop_reg->anatop, anatop_reg->control_reg, &val);
 	mask = ((1 << anatop_reg->vol_bit_width) - 1) <<
 		anatop_reg->vol_bit_shift;
 	val = (val & mask) >> anatop_reg->vol_bit_shift;
@@ -78,8 +81,8 @@ static int anatop_get_voltage_sel(struct regulator_dev *reg)
 }
 
 static struct regulator_ops anatop_rops = {
-	.set_voltage_sel = anatop_set_voltage_sel,
-	.get_voltage_sel = anatop_get_voltage_sel,
+	.set_voltage_sel = anatop_regmap_set_voltage_sel,
+	.get_voltage_sel = anatop_regmap_get_voltage_sel,
 	.list_voltage = regulator_list_voltage_linear,
 	.map_voltage = regulator_map_voltage_linear,
 };
@@ -88,11 +91,11 @@ static int __devinit anatop_regulator_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	struct device_node *anatop_np;
 	struct regulator_desc *rdesc;
 	struct regulator_dev *rdev;
 	struct anatop_regulator *sreg;
 	struct regulator_init_data *initdata;
-	struct anatop *anatopmfd = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
 	int ret = 0;
 
@@ -109,7 +112,14 @@ static int __devinit anatop_regulator_probe(struct platform_device *pdev)
 	rdesc->ops = &anatop_rops;
 	rdesc->type = REGULATOR_VOLTAGE;
 	rdesc->owner = THIS_MODULE;
-	sreg->mfd = anatopmfd;
+
+	anatop_np = of_get_parent(np);
+	if (!anatop_np)
+		return -ENODEV;
+	sreg->anatop = syscon_node_to_regmap(anatop_np);
+	if (IS_ERR(sreg->anatop))
+		return PTR_ERR(sreg->anatop);
+
 	ret = of_property_read_u32(np, "anatop-reg-offset",
 				   &sreg->control_reg);
 	if (ret) {
-- 
1.7.0.4
