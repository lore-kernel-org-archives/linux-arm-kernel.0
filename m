From: markz@nvidia.com (Mark Zhang)
Date: Fri, 19 Oct 2012 13:58:31 +0800
Subject: [PATCH] ARM: dt: tegra: ventana: define pinmux for ddc
Message-ID: <1350626311-18131-1-git-send-email-markz@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define pinmux for DDC. The DDC pinmux in Ventana is 2 pins in I2C2.

Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 arch/arm/boot/dts/tegra20-ventana.dts |   70 ++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index bec8bb2..b6b3af4 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -64,11 +64,6 @@
 				nvidia,pins = "dap4";
 				nvidia,function = "dap4";
 			};
-			ddc {
-				nvidia,pins = "ddc", "owc", "spdi", "spdo",
-					"uac";
-				nvidia,function = "rsvd2";
-			};
 			dta {
 				nvidia,pins = "dta", "dtb", "dtc", "dtd", "dte";
 				nvidia,function = "vi";
@@ -248,6 +243,39 @@
 				nvidia,slew-rate-falling = <3>;
 			};
 		};
+
+		state_i2cmux_ddc: pinmux_i2cmux_ddc {
+			ddc {
+				nvidia,pins = "ddc";
+				nvidia,function = "i2c2";
+			};
+			pta {
+				nvidia,pins = "pta";
+				nvidia,function = "rsvd4";
+			};
+		};
+
+		state_i2cmux_pta: pinmux_i2cmux_pta {
+			ddc {
+				nvidia,pins = "ddc";
+				nvidia,function = "rsvd4";
+			};
+			pta {
+				nvidia,pins = "pta";
+				nvidia,function = "i2c2";
+			};
+		};
+
+		state_i2cmux_idle: pinmux_i2cmux_idle {
+			ddc {
+				nvidia,pins = "ddc";
+				nvidia,function = "rsvd4";
+			};
+			pta {
+				nvidia,pins = "pta";
+				nvidia,function = "rsvd4";
+			};
+		};
 	};
 
 	i2s at 70002800 {
@@ -291,6 +319,38 @@
 		clock-frequency = <400000>;
 	};
 
+	i2cmux {
+		compatible = "i2c-mux-pinctrl";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c-parent = <&{/i2c@7000c400}>;
+
+		pinctrl-names = "ddc", "pta", "idle";
+		pinctrl-0 = <&state_i2cmux_ddc>;
+		pinctrl-1 = <&state_i2cmux_pta>;
+		pinctrl-2 = <&state_i2cmux_idle>;
+
+		i2c at 0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c at 1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			smart-battery at b {
+				compatible = "ti,bq24617", "smart-battery-1.1";
+				reg = <0xb>;
+				ti,i2c-retry-count = <2>;
+				ti,poll-retry-count = <10>;
+			};
+		};
+	};
+
 	i2c at 7000c500 {
 		status = "okay";
 		clock-frequency = <400000>;
-- 
1.7.9.5
