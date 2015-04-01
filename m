From: heiko@sntech.de (Heiko Stuebner)
Date: Wed,  1 Apr 2015 12:09:45 +0200
Subject: [PATCH RFC v2 11/12] ARM: dts: rockchip: add rk3288 lvds node
In-Reply-To: <1427882986-19110-1-git-send-email-heiko@sntech.de>
References: <1427882986-19110-1-git-send-email-heiko@sntech.de>
Message-ID: <1427882986-19110-12-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the basic node for the lvds controller of rk3288 and hook it into the
display-subsystem hirarchy.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index e7e94f8..97291bb 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -621,6 +621,11 @@
 				reg = <0>;
 				remote-endpoint = <&hdmi_in_vopb>;
 			};
+
+			vopb_out_lvds: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint = <&lvds_in_vopb>;
+			};
 		};
 	};
 
@@ -652,6 +657,11 @@
 				reg = <0>;
 				remote-endpoint = <&hdmi_in_vopl>;
 			};
+
+			vopl_out_lvds: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint = <&lvds_in_vopl>;
+			};
 		};
 	};
 
@@ -664,6 +674,38 @@
 		status = "disabled";
 	};
 
+	lvds: lvds at ff96c000 {
+		compatible = "rockchip,rk3288-lvds";
+		reg = <0xff96c000 0x4000>;
+		clocks = <&cru PCLK_LVDS_PHY>;
+		clock-names = "pclk_lvds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcdc0_ctl>;
+		rockchip,grf = <&grf>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			lvds_in: port at 0 {
+				reg = <0>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				lvds_in_vopb: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vopb_out_lvds>;
+				};
+				lvds_in_vopl: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&vopl_out_lvds>;
+				};
+			};
+		};
+	};
+
 	hdmi: hdmi at ff980000 {
 		compatible = "rockchip,rk3288-dw-hdmi";
 		reg = <0xff980000 0x20000>;
-- 
2.1.4
