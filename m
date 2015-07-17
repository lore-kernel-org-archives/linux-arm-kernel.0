From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 17 Jul 2015 08:29:27 +0200
Subject: [PATCH v2 4/4] mfd: max77686: Split out regulator part from the DT
 binding
In-Reply-To: <1437114567-17629-1-git-send-email-javier@osg.samsung.com>
References: <1437114567-17629-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1437114567-17629-5-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Maxim MAX77686 PMIC is a multi-function device with regulators,
clocks and a RTC. The DT bindings for the clocks are in a separate
file but the bindings for the regulators are inside the mfd part.

To make it consistent with the clocks portion of the binding and
because is more natural to look for regulator bindings under the
bindings/regulator sub-directory, split the regulator portion of
the DT binding and add it as a separate file.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes in v2:
- Use a generic name for the max77686 node in the regulator example.

 Documentation/devicetree/bindings/mfd/max77686.txt | 58 +-----------------
 .../devicetree/bindings/regulator/max77686.txt     | 71 ++++++++++++++++++++++
 2 files changed, 74 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt

diff --git a/Documentation/devicetree/bindings/mfd/max77686.txt b/Documentation/devicetree/bindings/mfd/max77686.txt
index d2ed3c20a5c3..c5aeca609b1f 100644
--- a/Documentation/devicetree/bindings/mfd/max77686.txt
+++ b/Documentation/devicetree/bindings/mfd/max77686.txt
@@ -8,7 +8,8 @@ client while probing.This document describes the binding for mfd device and
 PMIC submodule.
 
 Binding for the built-in 32k clock generator block is defined separately
-in bindings/clk/maxim,max77686.txt file.
+in the bindings/clk/maxim,max77686.txt file and binding for the regulators
+is defined in the bindings/regulator/max77686.txt file.
 
 Required properties:
 - compatible : Must be "maxim,max77686";
@@ -16,36 +17,6 @@ Required properties:
 - interrupts : This i2c device has an IRQ line connected to the main SoC.
 - interrupt-parent : The parent interrupt controller.
 
-Optional node:
-- voltage-regulators : The regulators of max77686 have to be instantiated
-  under subnode named "voltage-regulators" using the following format.
-
-	regulator_name {
-		regulator-compatible = LDOn/BUCKn
-		standard regulator constraints....
-	};
-	refer Documentation/devicetree/bindings/regulator/regulator.txt
-
-  The regulator node's name should be initialized with a string
-to get matched with their hardware counterparts as follow:
-
-	-LDOn 	:	for LDOs, where n can lie in range 1 to 26.
-		 	example: LDO1, LDO2, LDO26.
-	-BUCKn 	:	for BUCKs, where n can lie in range 1 to 9.
-			example: BUCK1, BUCK5, BUCK9.
-
-  Regulators which can be turned off during system suspend:
-	-LDOn	:	2, 6-8, 10-12, 14-16,
-	-BUCKn	:	1-4.
-  Use standard regulator bindings for it ('regulator-off-in-suspend').
-
-  LDO20, LDO21, LDO22, BUCK8 and BUCK9 can be configured to GPIO enable
-  control. To turn this feature on this property must be added to the regulator
-  sub-node:
-	- maxim,ena-gpios :	one GPIO specifier enable control (the gpio
-				flags are actually ignored and always
-				ACTIVE_HIGH is used)
-
 Example:
 
 	max77686: pmic at 09 {
@@ -53,27 +24,4 @@ Example:
 		interrupt-parent = <&wakeup_eint>;
 		interrupts = <26 0>;
 		reg = <0x09>;
-
-		voltage-regulators {
-			ldo11_reg: LDO11 {
-				regulator-name = "vdd_ldo11";
-				regulator-min-microvolt = <1900000>;
-				regulator-max-microvolt = <1900000>;
-				regulator-always-on;
-			};
-
-			buck1_reg: BUCK1 {
-				regulator-name = "vdd_mif";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			buck9_reg: BUCK9 {
-				regulator-name = "CAM_ISP_CORE_1.2V";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1200000>;
-				maxim,ena-gpios = <&gpm0 3 GPIO_ACTIVE_HIGH>;
-			};
-	}
+	};
diff --git a/Documentation/devicetree/bindings/regulator/max77686.txt b/Documentation/devicetree/bindings/regulator/max77686.txt
new file mode 100644
index 000000000000..831cbd3cd965
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/max77686.txt
@@ -0,0 +1,71 @@
+Binding for Maxim MAX77686 regulators
+
+This is a part of the device tree bindings of MAX77686 multi-function device.
+More information can be found in bindings/mfd/max77686.txt file.
+
+The MAX77686 PMIC has 9 high-efficiency Buck and 26 Low-dropout (LDO)
+regulators that can be controlled over I2C.
+
+Following properties should be present in main device node of the MFD chip.
+
+Optional node:
+- voltage-regulators : The regulators of max77686 have to be instantiated
+  under subnode named "voltage-regulators" using the following format.
+
+	regulator_name {
+		regulator-compatible = LDOn/BUCKn
+		standard regulator constraints....
+	};
+	refer Documentation/devicetree/bindings/regulator/regulator.txt
+
+  The regulator node's name should be initialized with a string
+to get matched with their hardware counterparts as follow:
+
+	-LDOn 	:	for LDOs, where n can lie in range 1 to 26.
+			example: LDO1, LDO2, LDO26.
+	-BUCKn 	:	for BUCKs, where n can lie in range 1 to 9.
+			example: BUCK1, BUCK5, BUCK9.
+
+  Regulators which can be turned off during system suspend:
+	-LDOn	:	2, 6-8, 10-12, 14-16,
+	-BUCKn	:	1-4.
+  Use standard regulator bindings for it ('regulator-off-in-suspend').
+
+  LDO20, LDO21, LDO22, BUCK8 and BUCK9 can be configured to GPIO enable
+  control. To turn this feature on this property must be added to the regulator
+  sub-node:
+	- maxim,ena-gpios :	one GPIO specifier enable control (the gpio
+				flags are actually ignored and always
+				ACTIVE_HIGH is used)
+
+Example:
+
+	max77686: pmic at 09 {
+		compatible = "maxim,max77686";
+		interrupt-parent = <&wakeup_eint>;
+		interrupts = <26 0>;
+		reg = <0x09>;
+
+		voltage-regulators {
+			ldo11_reg: LDO11 {
+				regulator-name = "vdd_ldo11";
+				regulator-min-microvolt = <1900000>;
+				regulator-max-microvolt = <1900000>;
+				regulator-always-on;
+			};
+
+			buck1_reg: BUCK1 {
+				regulator-name = "vdd_mif";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck9_reg: BUCK9 {
+				regulator-name = "CAM_ISP_CORE_1.2V";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1200000>;
+				maxim,ena-gpios = <&gpm0 3 GPIO_ACTIVE_HIGH>;
+			};
+	};
-- 
2.4.3
