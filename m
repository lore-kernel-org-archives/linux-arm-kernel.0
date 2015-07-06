From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jul 2015 09:58:28 +0100
Subject: [RESEND 06/10] dt: regulator: pwm-regulator: Re-write bindings
In-Reply-To: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
References: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1436173112-21397-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Add support for continuous-voltage mode
* Put more meat on the bones with regards to voltage-table mode
* Sort out formatting for ease of consumption

Cc: devicetree at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../bindings/regulator/pwm-regulator.txt           | 66 ++++++++++++++++++----
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
index ce91f61..0ae7895 100644
--- a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
@@ -1,27 +1,69 @@
-pwm regulator bindings
+Bindings for the Generic PWM Regulator
+======================================
+
+Currently supports 2 modes of operation:
+
+voltage-table:		When in this mode, a voltage table (See below) of predefined
+			voltage <=> duty-cycle values must be provided via DT.
+			Limitations are that the regulator can only operate at the
+			voltages supplied in the table.  Intermediary duty-cycle
+			values which would normally allow finer grained voltage
+			selection are ignored and rendered useless.  Although more
+			control is given to the user if the assumptions made in
+			continuous-voltage mode do not reign true.
+
+continuous-voltage:	This mode uses the regulator's maximum and minimum supplied
+			voltages specified in the regulator-{min,max}-microvolt
+			properties to calculate appropriate duty-cycle values.  This
+			allows for a much more fine grained solution when compared
+			with voltage-table mode above.  This solution does make an
+			assumption that a %50 duty-cycle value will cause the
+			regulator voltage to run at half way between the supplied
+			max_uV and min_uV values.
 
 Required properties:
-- compatible: Should be "pwm-regulator"
-- pwms: OF device-tree PWM specification (see PWM binding pwm.txt)
-- voltage-table: voltage and duty table, include 2 members in each set of
-  brackets, first one is voltage(unit: uv), the next is duty(unit: percent)
+--------------------
+- compatible:		Should be "pwm-regulator"
+
+- pwms:			PWM specification (See: ../pwm/pwm.txt)
+
+One of these must be provided:
+- voltage-table: 	Voltage and Duty-Cycle table consisting of 2 cells
+			    First cell is voltage in microvolts (uV)
+			    Second cell is duty-cycle in percent (%)
+
+- max-duty-cycle:	Maximum Duty-Cycle value -- this will normally be 255 (0xff)
+			for an 8 bit PWM device
 
-Any property defined as part of the core regulator binding defined in
-regulator.txt can also be used.
+If both are provided, the current default is voltage-table mode.
 
-Example:
+Any property defined as part of the core regulator binding can also be used.
+(See: ../regulator/regulator.txt)
+
+Continuous Voltage Example:
 	pwm_regulator {
 		compatible = "pwm-regulator;
 		pwms = <&pwm1 0 8448 0>;
+		regulator-min-microvolt = <1016000>;
+		regulator-max-microvolt = <1114000>;
+		regulator-name = "vdd_logic";
+
+		max-duty-cycle = <255>; /* 8bit PWM */
+	};
 
+Voltage Table Example:
+	pwm_regulator {
+		compatible = "pwm-regulator;
+		pwms = <&pwm1 0 8448 0>;
+		regulator-min-microvolt = <1016000>;
+		regulator-max-microvolt = <1114000>;
+		regulator-name = "vdd_logic";
+
+			      /* Voltage Duty-Cycle */
 		voltage-table = <1114000 0>,
 				<1095000 10>,
 				<1076000 20>,
 				<1056000 30>,
 				<1036000 40>,
 				<1016000 50>;
-
-		regulator-min-microvolt = <1016000>;
-		regulator-max-microvolt = <1114000>;
-		regulator-name = "vdd_logic";
 	};
-- 
1.9.1
