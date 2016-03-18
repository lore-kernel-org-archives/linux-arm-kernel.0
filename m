From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 18 Mar 2016 02:39:58 +0100
Subject: [PATCH 02/10] ARM: dts: rockchip: add rk3288 displayport controller
 node
In-Reply-To: <1458265206-15733-1-git-send-email-heiko@sntech.de>
References: <1458265206-15733-1-git-send-email-heiko@sntech.de>
Message-ID: <1458265206-15733-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the rk3288 edp node and its hooks into the display-subsystem.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index d6af337..26cdcee 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -830,6 +830,12 @@
 				reg = <0>;
 				remote-endpoint = <&hdmi_in_vopb>;
 			};
+
+			vopb_out_edp: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint = <&edp_in_vopb>;
+			};
+
 			vopb_out_mipi: endpoint at 2 {
 				reg = <2>;
 				remote-endpoint = <&mipi_in_vopb>;
@@ -867,6 +873,12 @@
 				reg = <0>;
 				remote-endpoint = <&hdmi_in_vopl>;
 			};
+
+			vopl_out_edp: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint = <&edp_in_vopl>;
+			};
+
 			vopl_out_mipi: endpoint at 2 {
 				reg = <2>;
 				remote-endpoint = <&mipi_in_vopl>;
@@ -915,6 +927,38 @@
 		};
 	};
 
+	edp: dp at ff970000 {
+		compatible = "rockchip,rk3288-dp";
+		reg = <0xff970000 0x4000>;
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
+		clock-names = "dp", "pclk";
+		phys = <&edp_phy>;
+		phy-names = "dp";
+		resets = <&cru SRST_EDP>;
+		reset-names = "dp";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			edp_in: port at 0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				edp_in_vopb: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vopb_out_edp>;
+				};
+				edp_in_vopl: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&vopl_out_edp>;
+				};
+			};
+		};
+	};
+
 	hdmi: hdmi at ff980000 {
 		compatible = "rockchip,rk3288-dw-hdmi";
 		reg = <0xff980000 0x20000>;
-- 
2.6.4
