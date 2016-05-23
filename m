From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 23 May 2016 21:33:38 +0800
Subject: [PATCH 2/3] arm64: dts: rockchip: add eDP device node for rk3399
In-Reply-To: <1464010400-10903-1-git-send-email-ykk@rock-chips.com>
References: <1464010400-10903-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1464010418-11014-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add rk3399 eDP device node, and connect to VOP device node with
remote endpoint.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 54e5c25..be322db 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -557,6 +557,11 @@
 		vopl_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			vopl_out_edp: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&edp_in_vopl>;
+			};
 		};
 	};
 
@@ -583,6 +588,11 @@
 		vopb_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			vopb_out_edp: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&edp_in_vopb>;
+			};
 		};
 	};
 
@@ -595,6 +605,41 @@
 		status = "disabled";
 	};
 
+	edp: edp at ff970000 {
+		compatible = "rockchip,rk3399-edp";
+		reg = <0x0 0xff970000 0x0 0x8000>;
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_EDP>, <&cru PCLK_EDP_CTRL>;
+		clock-names = "dp", "pclk";
+		resets = <&cru SRST_P_EDP_CTRL>;
+		reset-names = "dp";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_hpd>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			edp_in: port at 0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				edp_in_vopb: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vopb_out_edp>;
+				};
+
+				edp_in_vopl: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&vopl_out_edp>;
+				};
+			};
+		};
+	};
+
 	display_subsystem: display-subsystem {
 		compatible = "rockchip,display-subsystem";
 		ports = <&vopl_out>, <&vopb_out>;
@@ -1067,5 +1112,12 @@
 					<1 14 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
+
+		edp {
+			edp_hpd: edp-hpd {
+				rockchip,pins =
+					<4 23 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
 	};
 };
-- 
1.9.1
