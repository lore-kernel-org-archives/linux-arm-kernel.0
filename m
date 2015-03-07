From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 07 Mar 2015 15:28:54 +0100
Subject: [PATCH 1/2] regulator: act8865: add input supply handling
Message-ID: <1709506.shJhJsMxOa@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The act8846/act8865 regulators have a number of input supplies supplying the
individual regulators. This may even be recursively like on most Rockchip boards
using the act8846 where REG4 is most of the time connected to the inl1-supply.

Therefore add the ability to specify the input supplies for the individual inputs.
The input-names are taken from the datasheets of both act8846 and act8865.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/regulator/act8865-regulator.txt       | 16 +++++++++
 drivers/regulator/act8865-regulator.c              | 41 +++++++++++-----------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
index dad6358..45028bb 100644
--- a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
@@ -9,6 +9,22 @@ Optional properties:
 - system-power-controller: Telling whether or not this pmic is controlling
   the system power. See Documentation/devicetree/bindings/power/power-controller.txt .
 
+Optional input supply properties:
+- for act8846:
+  - vp1-supply:  The input supply for REG1
+  - vp2-supply:  The input supply for REG2
+  - vp3-supply:  The input supply for REG3
+  - vp4-supply:  The input supply for REG4
+  - inl1-supply:  The input supply for REG5, REG6 and REG7
+  - inl2-supply:  The input supply for REG8 and LDO_REG9
+  - inl3-supply:  The input supply for REG10, REG11 and REG12
+- for act8865:
+  - vp1-supply:  The input supply for DCDC_REG1
+  - vp2-supply:  The input supply for DCDC_REG2
+  - vp3-supply:  The input supply for DCDC_REG3
+  - inl45-supply:  The input supply for LDO_REG1 and LDO_REG2
+  - inl67-supply:  The input supply for LDO_REG3 and LDO_REG4
+
 Any standard regulator properties can be used to configure the single regulator.
 
 The valid names for regulators are:
diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 9eec453..a4a85cd 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -126,9 +126,10 @@ static struct regulator_ops act8865_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 };
 
-#define ACT88xx_REG(_name, _family, _id, _vsel_reg)			\
+#define ACT88xx_REG(_name, _family, _id, _vsel_reg, _supply)		\
 	[_family##_ID_##_id] = {					\
 		.name			= _name,			\
+		.supply_name		= _supply,			\
 		.id			= _family##_ID_##_id,		\
 		.type			= REGULATOR_VOLTAGE,		\
 		.ops			= &act8865_ops,			\
@@ -143,28 +144,28 @@ static struct regulator_ops act8865_ops = {
 	}
 
 static const struct regulator_desc act8846_regulators[] = {
-	ACT88xx_REG("REG1", ACT8846, REG1, VSET),
-	ACT88xx_REG("REG2", ACT8846, REG2, VSET0),
-	ACT88xx_REG("REG3", ACT8846, REG3, VSET0),
-	ACT88xx_REG("REG4", ACT8846, REG4, VSET0),
-	ACT88xx_REG("REG5", ACT8846, REG5, VSET),
-	ACT88xx_REG("REG6", ACT8846, REG6, VSET),
-	ACT88xx_REG("REG7", ACT8846, REG7, VSET),
-	ACT88xx_REG("REG8", ACT8846, REG8, VSET),
-	ACT88xx_REG("REG9", ACT8846, REG9, VSET),
-	ACT88xx_REG("REG10", ACT8846, REG10, VSET),
-	ACT88xx_REG("REG11", ACT8846, REG11, VSET),
-	ACT88xx_REG("REG12", ACT8846, REG12, VSET),
+	ACT88xx_REG("REG1", ACT8846, REG1, VSET, "vp1"),
+	ACT88xx_REG("REG2", ACT8846, REG2, VSET0, "vp2"),
+	ACT88xx_REG("REG3", ACT8846, REG3, VSET0, "vp3"),
+	ACT88xx_REG("REG4", ACT8846, REG4, VSET0, "vp4"),
+	ACT88xx_REG("REG5", ACT8846, REG5, VSET, "inl1"),
+	ACT88xx_REG("REG6", ACT8846, REG6, VSET, "inl1"),
+	ACT88xx_REG("REG7", ACT8846, REG7, VSET, "inl1"),
+	ACT88xx_REG("REG8", ACT8846, REG8, VSET, "inl2"),
+	ACT88xx_REG("REG9", ACT8846, REG9, VSET, "inl2"),
+	ACT88xx_REG("REG10", ACT8846, REG10, VSET, "inl3"),
+	ACT88xx_REG("REG11", ACT8846, REG11, VSET, "inl3"),
+	ACT88xx_REG("REG12", ACT8846, REG12, VSET, "inl3"),
 };
 
 static const struct regulator_desc act8865_regulators[] = {
-	ACT88xx_REG("DCDC_REG1", ACT8865, DCDC1, VSET1),
-	ACT88xx_REG("DCDC_REG2", ACT8865, DCDC2, VSET1),
-	ACT88xx_REG("DCDC_REG3", ACT8865, DCDC3, VSET1),
-	ACT88xx_REG("LDO_REG1", ACT8865, LDO1, VSET),
-	ACT88xx_REG("LDO_REG2", ACT8865, LDO2, VSET),
-	ACT88xx_REG("LDO_REG3", ACT8865, LDO3, VSET),
-	ACT88xx_REG("LDO_REG4", ACT8865, LDO4, VSET),
+	ACT88xx_REG("DCDC_REG1", ACT8865, DCDC1, VSET1, "vp1"),
+	ACT88xx_REG("DCDC_REG2", ACT8865, DCDC2, VSET1, "vp2"),
+	ACT88xx_REG("DCDC_REG3", ACT8865, DCDC3, VSET1, "vp3"),
+	ACT88xx_REG("LDO_REG1", ACT8865, LDO1, VSET, "inl45"),
+	ACT88xx_REG("LDO_REG2", ACT8865, LDO2, VSET, "inl45"),
+	ACT88xx_REG("LDO_REG3", ACT8865, LDO3, VSET, "inl67"),
+	ACT88xx_REG("LDO_REG4", ACT8865, LDO4, VSET, "inl67"),
 };
 
 #ifdef CONFIG_OF
-- 
2.1.4
