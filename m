From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 21 Jan 2015 22:32:40 +0100
Subject: [PATCH 2/2] ARM: dts: rockchip: add rk3288 hdmi nodes
In-Reply-To: <3715086.HVfme6flvD@phil>
References: <3715086.HVfme6flvD@phil>
Message-ID: <3155335.rHyPNic7RI@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an hdmi node, and also add hdmi endpoints to vopb and vopl
output port nodes.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Tested-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 1d22238..c7235fa 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -585,6 +585,11 @@
 		vopb_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			vopb_out_hdmi: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_in_vopb>;
+			};
 		};
 	};
 
@@ -611,6 +616,11 @@
 		vopl_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			vopl_out_hdmi: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_in_vopl>;
+			};
 		};
 	};
 
@@ -623,6 +633,33 @@
 		status = "disabled";
 	};
 
+	hdmi: hdmi at ff980000 {
+		compatible = "rockchip,rk3288-dw-hdmi";
+		reg = <0xff980000 0x20000>;
+		reg-io-width = <4>;
+		ddc-i2c-bus = <&i2c5>;
+		rockchip,grf = <&grf>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru  PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_HDCP>;
+		clock-names = "iahb", "isfr";
+		status = "disabled";
+
+		ports {
+			hdmi_in: port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				hdmi_in_vopb: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vopb_out_hdmi>;
+				};
+				hdmi_in_vopl: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&vopl_out_hdmi>;
+				};
+			};
+		};
+	};
+
 	gic: interrupt-controller at ffc01000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
-- 
2.1.1
