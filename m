From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 16 Nov 2017 14:34:10 +0100
Subject: [PATCH v2] arm64: dts: renesas: salvator-common: Add BD9571 PMIC
Message-ID: <1510839250-11199-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the ROHM BD9571MWV PMIC.

This was based on the example in the DT binding documentation, but using
IRQ0 instead of a GPIO interrupt, as that matches the schematics, and
because INTC-EX is a simpler block.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Clarify the choice for INTC-EX.
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 24a32c63ce7c1821..b9505a65a793708e 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -355,6 +355,30 @@
 
 &i2c_dvfs {
 	status = "okay";
+
+	pmic: pmic at 30 {
+		pinctrl-0 = <&irq0_pins>;
+		pinctrl-names = "default";
+
+		compatible = "rohm,bd9571mwv";
+		reg = <0x30>;
+		interrupt-parent = <&intc_ex>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		regulators {
+			dvfs: dvfs {
+				regulator-name = "dvfs";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1030000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &ohci0 {
@@ -410,6 +434,11 @@
 		function = "i2c2";
 	};
 
+	irq0_pins: irq0 {
+		groups = "intc_ex_irq0";
+		function = "intc_ex";
+	};
+
 	pwm1_pins: pwm1 {
 		groups = "pwm1_a";
 		function = "pwm1";
-- 
2.7.4
