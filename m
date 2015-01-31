From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 31 Jan 2015 17:33:03 +0100
Subject: [PATCH 10/11] ARM: dts: rockchip: add rk3288 lvds node
In-Reply-To: <1422721984-27782-1-git-send-email-heiko@sntech.de>
References: <1422721984-27782-1-git-send-email-heiko@sntech.de>
Message-ID: <1422721984-27782-11-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the basic node for the lvds controller of rk3288 and hook it into the
display-subsystem hirarchy.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 846d961..d063892 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -615,6 +615,11 @@
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
 
@@ -646,6 +651,11 @@
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
 
@@ -658,6 +668,32 @@
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
+			lvds_in: port {
+				#address-cells = <1>;
+				#size-cells = <0>;
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
2.1.1
