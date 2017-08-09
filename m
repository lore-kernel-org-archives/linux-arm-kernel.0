From: hjc@rock-chips.com (Sandy Huang)
Date: Wed,  9 Aug 2017 18:00:55 +0800
Subject: [PATCH 2/3] ARM: dts: Add LVDS info for rk3288
In-Reply-To: <1502272846-63941-1-git-send-email-hjc@rock-chips.com>
References: <1502272846-63941-1-git-send-email-hjc@rock-chips.com>
Message-ID: <1502272855-64102-1-git-send-email-hjc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add LVDS info in rk3288.dtsi for LVDS driver
This based on the patches from Mark yao and Heiko Stuebner.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
Signed-off-by: Mark yao <mark.yao@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 2484f11..c2e33b8 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -983,6 +983,11 @@
 				reg = <2>;
 				remote-endpoint = <&mipi_in_vopb>;
 			};
+
+			vopb_out_lvds: endpoint at 3 {
+				reg = <3>;
+				remote-endpoint = <&lvds_in_vopb>;
+			};
 		};
 	};
 
@@ -1026,6 +1031,11 @@
 				reg = <2>;
 				remote-endpoint = <&mipi_in_vopl>;
 			};
+
+			vopl_out_lvds: endpoint at 3 {
+				reg = <3>;
+				remote-endpoint = <&lvds_in_vopl>;
+			};
 		};
 	};
 
@@ -1099,6 +1109,39 @@
 		};
 	};
 
+	lvds: lvds at ff96c000 {
+		compatible = "rockchip,rk3288-lvds";
+		reg = <0xff96c000 0x4000>;
+		clocks = <&cru PCLK_LVDS_PHY>;
+		clock-names = "pclk_lvds";
+		pinctrl-names = "lcdc";
+		pinctrl-0 = <&lcdc_ctl>;
+		power-domains = <&power RK3288_PD_VIO>;
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
@@ -1823,5 +1866,14 @@
 				rockchip,pins = <RK_GPIO6 11 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
+
+		lcdc {
+			lcdc_ctl: lcdc-ctl {
+				rockchip,pins = <1 24 RK_FUNC_1 &pcfg_pull_none>,
+						<1 25 RK_FUNC_1 &pcfg_pull_none>,
+						<1 26 RK_FUNC_1 &pcfg_pull_none>,
+						<1 27 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
 	};
 };
-- 
2.7.4
