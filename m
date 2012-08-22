From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 22 Aug 2012 15:18:45 +0800
Subject: [PATCH 4/7] regulator: anatop-regulator: convert to use imx-syscon to
 access anatop register
In-Reply-To: <1345619928-15446-1-git-send-email-b29396@freescale.com>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
Message-ID: <1345619928-15446-5-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Using standard imx syscon API to access anatop register.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 arch/arm/boot/dts/imx6q.dtsi         |    6 ++++++
 drivers/regulator/Kconfig            |    2 +-
 drivers/regulator/anatop-regulator.c |   17 +++++++++++------
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 7732b70..7076be0 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -395,6 +395,7 @@
 					anatop-min-bit-val = <4>;
 					anatop-min-voltage = <800000>;
 					anatop-max-voltage = <1375000>;
+					fsl,anatop = <&anatop>;
 				};
 
 				regulator-3p0 at 120 {
@@ -409,6 +410,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2625000>;
 					anatop-max-voltage = <3400000>;
+					fsl,anatop = <&anatop>;
 				};
 
 				regulator-2p5 at 130 {
@@ -423,6 +425,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2000000>;
 					anatop-max-voltage = <2750000>;
+					fsl,anatop = <&anatop>;
 				};
 
 				regulator-vddcore at 140 {
@@ -437,6 +440,7 @@
 					anatop-min-bit-val = <1>;
 					anatop-min-voltage = <725000>;
 					anatop-max-voltage = <1450000>;
+					fsl,anatop = <&anatop>;
 				};
 
 				regulator-vddpu at 140 {
@@ -451,6 +455,7 @@
 					anatop-min-bit-val = <1>;
 					anatop-min-voltage = <725000>;
 					anatop-max-voltage = <1450000>;
+					fsl,anatop = <&anatop>;
 				};
 
 				regulator-vddsoc at 140 {
@@ -465,6 +470,7 @@
 					anatop-min-bit-val = <1>;
 					anatop-min-voltage = <725000>;
 					anatop-max-voltage = <1450000>;
+					fsl,anatop = <&anatop>;
 				};
 			};
 
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 4e932cc..7ceea1a 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -112,7 +112,7 @@ config REGULATOR_DA9052
 
 config REGULATOR_ANATOP
 	tristate "Freescale i.MX on-chip ANATOP LDO regulators"
-	depends on MFD_ANATOP
+	depends on MFD_IMX_SYSCON
 	help
 	  Say y here to support Freescale i.MX on-chip ANATOP LDOs
 	  regulators. It is recommended that this option be
diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index ce0fe72..e0b9ef1 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -21,19 +21,20 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/mfd/imx-syscon.h>
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
+	struct device_node *anatop;
 	int vol_bit_shift;
 	int vol_bit_width;
 	int min_bit_val;
@@ -56,7 +57,8 @@ static int anatop_set_voltage_sel(struct regulator_dev *reg, unsigned selector)
 	mask = ((1 << anatop_reg->vol_bit_width) - 1) <<
 		anatop_reg->vol_bit_shift;
 	val <<= anatop_reg->vol_bit_shift;
-	anatop_write_reg(anatop_reg->mfd, anatop_reg->control_reg, val, mask);
+	imx_syscon_update_bits(anatop_reg->anatop, anatop_reg->control_reg,
+				mask, val);
 
 	return 0;
 }
@@ -69,7 +71,7 @@ static int anatop_get_voltage_sel(struct regulator_dev *reg)
 	if (!anatop_reg->control_reg)
 		return -ENOTSUPP;
 
-	val = anatop_read_reg(anatop_reg->mfd, anatop_reg->control_reg);
+	imx_syscon_read(anatop_reg->anatop, anatop_reg->control_reg, &val);
 	mask = ((1 << anatop_reg->vol_bit_width) - 1) <<
 		anatop_reg->vol_bit_shift;
 	val = (val & mask) >> anatop_reg->vol_bit_shift;
@@ -92,7 +94,6 @@ static int __devinit anatop_regulator_probe(struct platform_device *pdev)
 	struct regulator_dev *rdev;
 	struct anatop_regulator *sreg;
 	struct regulator_init_data *initdata;
-	struct anatop *anatopmfd = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
 	int ret = 0;
 
@@ -109,7 +110,11 @@ static int __devinit anatop_regulator_probe(struct platform_device *pdev)
 	rdesc->ops = &anatop_rops;
 	rdesc->type = REGULATOR_VOLTAGE;
 	rdesc->owner = THIS_MODULE;
-	sreg->mfd = anatopmfd;
+
+	sreg->anatop = of_parse_phandle(np, "fsl,anatop", 0);
+	if (!sreg->anatop)
+		return -ENODEV;
+
 	ret = of_property_read_u32(np, "anatop-reg-offset",
 				   &sreg->control_reg);
 	if (ret) {
-- 
1.7.0.4
