From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Thu, 13 Jul 2017 00:03:53 +0800
Subject: [PATCH 3/5] arm64: dts: rockchip: add rk3399 edp nodes
In-Reply-To: <1499875435-23944-1-git-send-email-jacob-chen@iotwrt.com>
References: <1499875435-23944-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1499875435-23944-4-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an edp node, and also add edp endpoints to vopb and vopl
output port nodes.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index b88bd02..b4ff50a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1474,6 +1474,12 @@
 		vopl_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			vopl_out_edp: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint = <&edp_in_vopl>;
+			};
+
 		};
 	};
 
@@ -1504,6 +1510,12 @@
 		vopb_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			vopb_out_edp: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&edp_in_vopb>;
+			};
+
 		};
 	};
 
@@ -1519,6 +1531,42 @@
 		status = "disabled";
 	};
 
+	edp: edp at ff970000 {
+		compatible = "rockchip,rk3399-edp";
+		reg = <0x0 0xff970000 0x0 0x8000>;
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_EDP>, <&cru PCLK_EDP_CTRL>;
+		clock-names = "dp", "pclk";
+		power-domains = <&power RK3399_PD_EDP>;
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
 	display-subsystem {
 		compatible = "rockchip,display-subsystem";
 		ports = <&vopl_out>, <&vopb_out>;
-- 
2.7.4
