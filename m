From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  7 Aug 2013 01:04:12 +0200
Subject: [PATCH] ARM: nomadik: switch to use the Nomadik I2C driver
Message-ID: <1375830252-27233-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using bit-banged I2C, let's use the actual I2C
driver in the kernel. Since the I2C block may be communicating
with things like the PMIC, we need to select it from the Kconfig
just like the bit-banged adapter is selected today. The rest of
the configuration for this driver can be done from the device
tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 42 ++++++++++++++++++++++--------
 arch/arm/mach-nomadik/Kconfig              |  1 +
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index a3acfa7..9169d30 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -140,18 +140,30 @@
 			};
 		};
 		i2c0 {
+			i2c0_default_mux: i2c0_mux {
+				i2c0_default_mux {
+					ste,function = "i2c0";
+					ste,pins = "i2c0_a_1";
+				};
+			};
 			i2c0_default_mode: i2c0_default {
 				i2c0_default_cfg {
 					ste,pins = "GPIO62_D3", "GPIO63_D2";
-					ste,input = <1>;
+					ste,input = <0>;
 				};
 			};
 		};
 		i2c1 {
+			i2c1_default_mux: i2c1_mux {
+				i2c1_default_mux {
+					ste,function = "i2c1";
+					ste,pins = "i2c1_a_1";
+				};
+			};
 			i2c1_default_mode: i2c1_default {
 				i2c1_default_cfg {
 					ste,pins = "GPIO53_L4", "GPIO54_L3";
-					ste,input = <1>;
+					ste,input = <0>;
 				};
 			};
 		};
@@ -159,7 +171,7 @@
 			i2c2_default_mode: i2c2_default {
 				i2c2_default_cfg {
 					ste,pins = "GPIO73_C21", "GPIO74_C20";
-					ste,input = <1>;
+					ste,input = <0>;
 				};
 			};
 		};
@@ -682,13 +694,17 @@
 
 	/* I2C0 connected to the STw4811 power management chip */
 	i2c0 {
-		compatible = "i2c-gpio";
-		gpios = <&gpio1 31 0>, /* sda */
-			<&gpio1 30 0>; /* scl */
+		compatible = "st,nomadik-i2c", "arm,primecell";
+		reg = <0x101f8000 0x1000>;
+		interrupt-parent = <&vica>;
+		interrupts = <20>;
+		clock-frequency = <100000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&i2c0clk>, <&pclki2c0>;
+		clock-names = "mclk", "apb_pclk";
 		pinctrl-names = "default";
-		pinctrl-0 = <&i2c0_default_mode>;
+		pinctrl-0 = <&i2c0_default_mux>, <&i2c0_default_mode>;
 
 		stw4811 at 2d {
 			   compatible = "st,stw4811";
@@ -698,13 +714,17 @@
 
 	/* I2C1 connected to various sensors */
 	i2c1 {
-		compatible = "i2c-gpio";
-		gpios = <&gpio1 22 0>, /* sda */
-			<&gpio1 21 0>; /* scl */
+		compatible = "st,nomadik-i2c", "arm,primecell";
+		reg = <0x101f7000 0x1000>;
+		interrupt-parent = <&vica>;
+		interrupts = <21>;
+		clock-frequency = <100000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&i2c1clk>, <&pclki2c1>;
+		clock-names = "mclk", "apb_pclk";
 		pinctrl-names = "default";
-		pinctrl-0 = <&i2c1_default_mode>;
+		pinctrl-0 = <&i2c1_default_mux>, <&i2c1_default_mode>;
 
 		camera at 2d {
 			   compatible = "st,camera";
diff --git a/arch/arm/mach-nomadik/Kconfig b/arch/arm/mach-nomadik/Kconfig
index 5981c3d..4d42da4 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -27,6 +27,7 @@ config MACH_NOMADIK_8815NHK
 	select NOMADIK_8815
 	select I2C
 	select I2C_ALGOBIT
+	select I2C_NOMADIK
 
 endmenu
 endif
-- 
1.8.1.4
