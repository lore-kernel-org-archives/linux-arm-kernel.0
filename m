From: mail@maciej.szmigiero.name (Maciej S. Szmigiero)
Date: Sun, 31 Jan 2016 00:42:35 +0100
Subject: [PATCH] ARM: dts: imx6qdl-udoo: add sound support
Message-ID: <56AD4A6B.80409@maciej.szmigiero.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sound support in UDOO board DT file.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 57 +++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 1211da894ee9..d3e54e40a017 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -34,6 +34,18 @@
 			gpio = <&gpio7 12 0>;
 		};
 	};
+
+	sound {
+		compatible = "fsl,imx6q-udoo-ac97",
+			     "fsl,imx-audio-ac97";
+		model = "fsl,imx6q-udoo-ac97";
+		audio-cpu = <&ssi1>;
+		audio-routing =
+			"RX", "Mic Jack",
+			"Headphone Jack", "TX";
+		mux-int-port = <1>;
+		mux-ext-port = <6>;
+	};
 };
 
 &fec {
@@ -109,6 +121,36 @@
 				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
 			>;
 		};
+
+		pinctrl_ac97_running: ac97running {
+			fsl,pins = <
+				MX6QDL_PAD_DI0_PIN2__AUD6_TXD		0x1b0b0
+				MX6QDL_PAD_DI0_PIN3__AUD6_TXFS		0x1b0b0
+				MX6QDL_PAD_DI0_PIN4__AUD6_RXD		0x1b0b0
+				MX6QDL_PAD_DI0_PIN15__AUD6_TXC		0x1b0b0
+				MX6QDL_PAD_EIM_EB2__GPIO2_IO30		0x1b0b0
+			>;
+		};
+
+		pinctrl_ac97_warm_reset: ac97warmreset {
+			fsl,pins = <
+				MX6QDL_PAD_DI0_PIN2__AUD6_TXD		0x1b0b0
+				MX6QDL_PAD_DI0_PIN3__GPIO4_IO19		0x1b0b0
+				MX6QDL_PAD_DI0_PIN4__AUD6_RXD		0x1b0b0
+				MX6QDL_PAD_DI0_PIN15__AUD6_TXC		0x1b0b0
+				MX6QDL_PAD_EIM_EB2__GPIO2_IO30		0x1b0b0
+			>;
+		};
+
+		pinctrl_ac97_reset: ac97reset {
+			fsl,pins = <
+				MX6QDL_PAD_DI0_PIN2__GPIO4_IO18		0x1b0b0
+				MX6QDL_PAD_DI0_PIN3__GPIO4_IO19		0x1b0b0
+				MX6QDL_PAD_DI0_PIN4__AUD6_RXD		0x1b0b0
+				MX6QDL_PAD_DI0_PIN15__AUD6_TXC		0x1b0b0
+				MX6QDL_PAD_EIM_EB2__GPIO2_IO30		0x1b0b0
+			>;
+		};
 	};
 };
 
@@ -132,3 +174,18 @@
 	non-removable;
 	status = "okay";
 };
+
+&audmux {
+	status = "okay";
+};
+
+&ssi1 {
+	cell-index = <0>;
+	fsl,mode = "ac97-slave";
+	pinctrl-names = "ac97-running", "ac97-reset", "ac97-warm-reset";
+	pinctrl-0 = <&pinctrl_ac97_running>;
+	pinctrl-1 = <&pinctrl_ac97_reset>;
+	pinctrl-2 = <&pinctrl_ac97_warm_reset>;
+	ac97-gpios = <&gpio4 19 0 &gpio4 18 0 &gpio2 30 0>;
+	status = "okay";
+};
