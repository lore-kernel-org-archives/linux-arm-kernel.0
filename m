From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri,  4 Jul 2014 22:24:20 +0200
Subject: [PATCH v7 17/24] mfd: max77686: Add documentation for DVS bindings
In-Reply-To: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1404505467-26526-18-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MAX77686 PMIC submodule has Dynamic Voltage Scaling (DVS)
support on some regulators. Now that the regulator driver has
bindings to configure it, these bindings have to be documented.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 Documentation/devicetree/bindings/mfd/max77686.txt | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max77686.txt b/Documentation/devicetree/bindings/mfd/max77686.txt
index 678f3cf..daf1c07 100644
--- a/Documentation/devicetree/bindings/mfd/max77686.txt
+++ b/Documentation/devicetree/bindings/mfd/max77686.txt
@@ -10,12 +10,38 @@ PMIC submodule.
 Binding for the built-in 32k clock generator block is defined separately
 in bindings/clk/maxim,max77686.txt file.
 
+Buck regulators 2, 3 and 4 include Dynamic Voltage Scaling (DVS) that allows
+each output voltage to change dynamically. Each Buck output voltage is selected
+using a set of external inputs: DVS1-3 and SELB2, 3 and 4.
+
+There are 8 DVS registers that can be used to configure the output voltage
+for each Buck regulator and which one is active is controled by DVSx lines.
+
+SELBx lines are used to control if individual Buck lines are ON or OFF.
+
 Required properties:
 - compatible : Must be "maxim,max77686";
 - reg : Specifies the i2c slave address of PMIC block.
 - interrupts : This i2c device has an IRQ line connected to the main SoC.
 - interrupt-parent : The parent interrupt controller.
 
+Optional properties:
+- max77686,pmic-buck-default-dvs-idx: We'll always write this DVS index in the
+  PMIC for Bucks with DVS.
+  NOTE: at the moment these bindings don't include enough details for actual
+  GPIO-DVS--this just lets you choose which single slot to use.
+
+- max77686,pmic-buck-dvs-gpios: A GPIO array where each GPIO is connected to a
+  DVS line. We'll try to set these GPIOs to match pmic-buck-default-dvs-idx at
+  probe time if they are defined. If some or all of these GPIOs are not defined
+  it's assumed that the board has any missing GPIOs hardwired to match
+  pmic-buck-default-dvs-idx.
+
+- max77686,pmic-buck-selb-gpios: A GPIO array where each GPIO is connected to a
+  SELBx line. Should be three values: 2, 3 and 4. It is strongly suggested to
+  include these GPIOs if there's any chance that changing DVS GPIOs one line at
+  a time might glitch your DVS values.
+
 Optional node:
 - voltage-regulators : The regulators of max77686 have to be instantiated
   under subnode named "voltage-regulators" using the following format.
@@ -42,6 +68,14 @@ Example:
 		interrupts = <26 0>;
 		reg = <0x09>;
 
+		max77686,pmic-buck-default-dvs-idx = <1>;
+		max77686,pmic-buck-dvs-gpios = <&gpy7 6 0>,
+					       <&gpj4 2 0>,
+					       <&gpj4 3 0>;
+		max77686,pmic-buck-selb-gpios = <&gph0 1 0>,
+						<&gph0 2 0>,
+						<&gph0 3 0>,
+
 		voltage-regulators {
 			ldo11_reg {
 				regulator-compatible = "LDO11";
-- 
2.0.0.rc2
