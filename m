From: kbingham@kernel.org (Kieran Bingham)
Date: Wed, 14 Jun 2017 20:58:13 +0100
Subject: [PATCH v5 2/2] arm64: dts: renesas: salvator-x: Add ADV7482 support
In-Reply-To: <cover.90fc3153078e79a3f74af832de923ac675eb29ad.1497469745.git-series.kieran.bingham+renesas@ideasonboard.com>
References: <cover.90fc3153078e79a3f74af832de923ac675eb29ad.1497469745.git-series.kieran.bingham+renesas@ideasonboard.com>
Message-ID: <ce388da93b793abc1b54df3e59ab287aedb9797f.1497469745.git-series.kieran.bingham+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

The Salvator boards use an ADV7482 receiver for HDMI and CVBS inputs.

Provide ADV7482 node on the i2c4 bus, along with connectors for the
hdmi and cvbs inputs, and link to the csi20 and csi40 nodes as outputs.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

v4:
 - dt: Rebase to dts/renesas/salvator-x.dtsi
 - dt: Use AIN0-7 rather than AIN1-8

v5:
 - dt: Move to salvator-common.dtsi
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 123 ++++++++++++++++-
 1 file changed, 123 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index aef35e0b685a..d74fb55c38bc 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -65,6 +65,27 @@
 		enable-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
 	};
 
+	cvbs-in {
+		compatible = "composite-video-connector";
+		label = "CVBS IN";
+
+		port {
+			cvbs_con: endpoint {
+			};
+		};
+	};
+
+	hdmi-in {
+		compatible = "hdmi-connector";
+		label = "HDMI IN";
+		type = "a";
+
+		port {
+			hdmi_in_con: endpoint {
+			};
+		};
+	};
+
 	reg_1p8v: regulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
@@ -257,6 +278,59 @@
 	};
 };
 
+&csi20 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			reg = <0>;
+			csi20_in: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1>;
+				remote-endpoint = <&adv7482_txb>;
+			};
+		};
+	};
+};
+
+&csi40 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			reg = <0>;
+
+			csi40_in: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1 2 3 4>;
+				remote-endpoint = <&adv7482_txa>;
+			};
+		};
+	};
+};
+
+&cvbs_con {
+	port {
+		cvbs_in: endpoint {
+			remote-endpoint = <&adv7482_ain7>;
+		};
+	};
+};
+
+&hdmi_in_con {
+	port {
+		hdmi_in: endpoint {
+			remote-endpoint = <&adv7482_hdmi>;
+		};
+	};
+};
+
 &du {
 	pinctrl-0 = <&du_pins>;
 	pinctrl-names = "default";
@@ -343,6 +417,55 @@
 
 		shunt-resistor-micro-ohms = <5000>;
 	};
+
+	video-receiver at 70 {
+		compatible = "adi,adv7482";
+		reg = <0x70>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		interrupt-parent = <&gpio6>;
+		interrupt-names = "intrq1", "intrq2";
+		interrupts = <30 IRQ_TYPE_LEVEL_LOW>,
+			     <31 IRQ_TYPE_LEVEL_LOW>;
+
+		port at 7 {
+			reg = <7>;
+
+			adv7482_ain7: endpoint {
+				remote-endpoint = <&cvbs_in>;
+			};
+		};
+
+		port at 8 {
+			reg = <8>;
+
+			adv7482_hdmi: endpoint {
+				remote-endpoint = <&hdmi_in>;
+			};
+		};
+
+		port at 10 {
+			reg = <10>;
+
+			adv7482_txa: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1 2 3 4>;
+				remote-endpoint = <&csi40_in>;
+			};
+		};
+
+		port at 11 {
+			reg = <11>;
+
+			adv7482_txb: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1>;
+				remote-endpoint = <&csi20_in>;
+			};
+		};
+	};
 };
 
 &i2c_dvfs {
-- 
git-series 0.9.1
