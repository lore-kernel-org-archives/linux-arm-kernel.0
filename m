From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Thu, 13 Jul 2017 00:03:54 +0800
Subject: [PATCH 4/5] arm64: dts: rockchip: add rk3399 mipi nodes
In-Reply-To: <1499875435-23944-1-git-send-email-jacob-chen@iotwrt.com>
References: <1499875435-23944-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1499875435-23944-5-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an mipi node, and also add mipi endpoints to vopb and vopl
output port nodes.

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index b4ff50a..4965163 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1475,6 +1475,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			vopl_out_mipi: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&mipi_in_vopl>;
+			};
+
 			vopl_out_edp: endpoint at 1 {
 				reg = <1>;
 				remote-endpoint = <&edp_in_vopl>;
@@ -1516,6 +1521,11 @@
 				remote-endpoint = <&edp_in_vopb>;
 			};
 
+			vopb_out_mipi: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint = <&mipi_in_vopb>;
+			};
+
 		};
 	};
 
@@ -1531,6 +1541,40 @@
 		status = "disabled";
 	};
 
+	mipi_dsi: mipi at ff960000 {
+		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";
+		reg = <0x0 0xff960000 0x0 0x8000>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru SCLK_MIPIDPHY_REF>, <&cru PCLK_MIPI_DSI0>,
+			 <&cru SCLK_DPHY_TX0_CFG>;
+		clock-names = "ref", "pclk", "phy_cfg";
+		power-domains = <&power RK3399_PD_VIO>;
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			mipi_in: port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mipi_in_vopb: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vopb_out_mipi>;
+				};
+				mipi_in_vopl: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&vopl_out_mipi>;
+				};
+			};
+		};
+	};
+
 	edp: edp at ff970000 {
 		compatible = "rockchip,rk3399-edp";
 		reg = <0x0 0xff970000 0x0 0x8000>;
-- 
2.7.4
