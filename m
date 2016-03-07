From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Mon,  7 Mar 2016 14:39:47 -0600
Subject: [Patch v4 6/6] ARM: dts: DRA7: Add dt nodes for PWMSS
In-Reply-To: <1457383187-17166-1-git-send-email-fcooper@ti.com>
References: <1457383187-17166-1-git-send-email-fcooper@ti.com>
Message-ID: <1457383187-17166-7-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vignesh R <vigneshr@ti.com>

Add PWMSS device tree nodes for DRA7 SoC family and add documentation
for dt bindings.

Signed-off-by: Vignesh R <vigneshr@ti.com>
[fcooper at ti.com: Use updated bindings for PWMSS and ePWM]
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
Version 4 changes:
Remove hwmod entries.
Add clocks/clock-names to pwm nodes.

 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  9 ++++
 .../devicetree/bindings/pwm/pwm-tipwmss.txt        | 15 +++++-
 arch/arm/boot/dts/dra7.dtsi                        | 60 ++++++++++++++++++++++
 3 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index 345d3f6..5965b9d 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: Must be "ti,<soc>-ehrpwm".
   for am33xx - compatible = "ti,am33xx-ehrpwm";
   for da850  - compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
+  for dra7xx - compatible = "ti,dra7xx-ehrpwm", "ti,am33xx-ehrpwm";
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format. The only third cell flag supported by this binding is
   PWM_POLARITY_INVERTED.
@@ -28,3 +29,11 @@ ehrpwm0: pwm at 01f00000 { /* EHRPWM on da850 */
 	#pwm-cells = <3>;
 	reg = <0x300000 0x2000>;
 };
+
+ehrpwm0: pwm at 4843e200 { /* EHRPWM on dra7xx */
+	compatible = "ti,dra7xx-ehrpwm", "ti,am33xx-ehrpwm";
+	#pwm-cells = <3>;
+	reg = <0x48440200 0x80>;
+	clocks = <&ehrpwm0_tbclk>;
+	clock-names = "tbclk";
+};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
index 672fa71..f137d0b 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
@@ -1,7 +1,9 @@
 TI SOC based PWM Subsystem
 
 Required properties:
-- compatible: Must be "ti,am33xx-pwmss";
+- compatible: Must be "ti,<soc>-pwmss".
+  for am33xx - compatible = "ti,am33xx-pwmss"
+  for dra7xx - compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss"
 - reg: physical base address and size of the registers map.
 - address-cells: Specify the number of u32 entries needed in child nodes.
 		  Should set to 1.
@@ -25,3 +27,14 @@ pwmss0: pwmss at 48300000 {
 
 	/* child nodes go here */
 };
+
+epwmss0: epwmss at 4843e000 { /* On DRA7xx */
+	compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
+	reg = <0x4843e000 0x30>;
+	ti,hwmods = "epwmss0";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	/* child nodes go here */
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c4d9175..cc161b3 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1597,6 +1597,66 @@
 				clock-names = "fck", "sys_clk";
 			};
 		};
+
+		epwmss0: epwmss at 4843e000 {
+			compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
+			reg = <0x4843e000 0x30>;
+			ti,hwmods = "epwmss0";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ehrpwm0: pwm at 4843e200 {
+				compatible = "ti,dra7xx-ehrpwm",
+					     "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x4843e200 0x80>;
+				clocks = <&ehrpwm0_tbclk>;
+				clock-names = "tbclk";
+				status = "disabled";
+			};
+		};
+
+		epwmss1: epwmss at 48440000 {
+			compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
+			reg = <0x48440000 0x30>;
+			ti,hwmods = "epwmss1";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ehrpwm1: pwm at 48440200 {
+				compatible = "ti,dra7xx-ehrpwm",
+					     "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48440200 0x80>;
+				clocks = <&ehrpwm1_tbclk>;
+				clock-names = "tbclk";
+				status = "disabled";
+			};
+		};
+
+		epwmss2: epwmss at 48442000 {
+			compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
+			reg = <0x48442000 0x30>;
+			ti,hwmods = "epwmss2";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+			ranges;
+
+			ehrpwm2: pwm at 48442200 {
+				compatible = "ti,dra7xx-ehrpwm",
+					     "ti,am33xx-ehrpwm";
+				#pwm-cells = <3>;
+				reg = <0x48442200 0x80>;
+				clocks = <&ehrpwm2_tbclk>;
+				clock-names = "tbclk";
+				status = "disabled";
+			};
+		};
 	};
 
 	thermal_zones: thermal-zones {
-- 
2.7.0
