From: avinashphilip@ti.com (Philip Avinash)
Date: Wed, 10 Apr 2013 13:32:19 +0530
Subject: [PATCH v4] ARM: davinci: da850: add EHRPWM & ECAP DT node
Message-ID: <1365580939-16839-1-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add da850 EHRPWM & ECAP DT node along with pin-mux details for EHRPWM1.
Also adds OF_DEV_AUXDATA for EHRPWM & ECAP driver to use EHRPWM & ECAP
clock.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
Changes since v3:
	- add pin mux info for EHRPWM1.

Changes since v1:
	- Reusing ti,am33xx<ecap/ehrpwm> as compatible field as both IP's are
	  similar with am33xx platform and da850 has no platform specific
	  dependency.

 arch/arm/boot/dts/da850.dtsi     |   42 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |    5 +++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 3ade343..3bff30d 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -71,6 +71,18 @@
 					0x28 0x00222222  0x00ffffff
 				>;
 			};
+			ehrpwm1a_pins: pinmux_ehrpwm1a_pins {
+				pinctrl-single,bits = <
+					/* EPWM1A */
+					0x14 0x00000002 0x0000000f
+				>;
+			};
+			ehrpwm1b_pins: pinmux_ehrpwm1b_pins {
+				pinctrl-single,bits = <
+					/* EPWM1B */
+					0x14 0x00000020 0x000000f0
+				>;
+			};
 		};
 		serial0: serial at 1c42000 {
 			compatible = "ns16550a";
@@ -122,6 +134,36 @@
 			interrupts = <16>;
 			status = "disabled";
 		};
+		ehrpwm0: ehrpwm at 01f00000 {
+			compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
+			#pwm-cells = <3>;
+			reg = <0x300000 0x2000>;
+			status = "disabled";
+		};
+		ehrpwm1: ehrpwm at 01f02000 {
+			compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
+			#pwm-cells = <3>;
+			reg = <0x302000 0x2000>;
+			status = "disabled";
+		};
+		ecap0: ecap at 01f06000 {
+			compatible = "ti,da850-ecap", "ti,am33xx-ecap";
+			#pwm-cells = <3>;
+			reg = <0x306000 0x80>;
+			status = "disabled";
+		};
+		ecap1: ecap at 01f07000 {
+			compatible = "ti,da850-ecap", "ti,am33xx-ecap";
+			#pwm-cells = <3>;
+			reg = <0x307000 0x80>;
+			status = "disabled";
+		};
+		ecap2: ecap at 01f08000 {
+			compatible = "ti,da850-ecap", "ti,am33xx-ecap";
+			#pwm-cells = <3>;
+			reg = <0x308000 0x80>;
+			status = "disabled";
+		};
 	};
 	nand_cs3 at 62000000 {
 		compatible = "ti,davinci-nand";
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index d83de8f..05bb9a2 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -41,6 +41,11 @@ struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
 	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "watchdog", NULL),
 	OF_DEV_AUXDATA("ti,da830-mmc", 0x01c40000, "da830-mmc.0", NULL),
+	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f00000, "ehrpwm", NULL),
+	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f02000, "ehrpwm", NULL),
+	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f06000, "ecap", NULL),
+	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f07000, "ecap", NULL),
+	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f08000, "ecap", NULL),
 	{}
 };
 
-- 
1.7.9.5
