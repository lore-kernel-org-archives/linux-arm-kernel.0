From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 29 Nov 2017 17:11:27 -0800
Subject: [PATCH] arm64: dts: rockchip: add mipi_dsi1 support for rk3399
In-Reply-To: <20171130010723.GA133459@google.com>
References: <20171129233541.51337-1-briannorris@chromium.org>
 <20171130010723.GA133459@google.com>
Message-ID: <20171130011127.GB124672@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nickey Yang <nickey.yang@rock-chips.com>

This patch adds the information for the secondary MIPI DSI controller,
e.g., interrupts, grf, clocks, ports and so on. Mirrors the existing
definition for dsi0.

Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 45 ++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 8940a3dc3670..e7e882d06c68 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1526,6 +1526,11 @@
 				reg = <2>;
 				remote-endpoint = <&hdmi_in_vopl>;
 			};
+
+			vopl_out_mipi1: endpoint at 3 {
+				reg = <3>;
+				remote-endpoint = <&mipi1_in_vopl>;
+			};
 		};
 	};
 
@@ -1573,6 +1578,11 @@
 				reg = <2>;
 				remote-endpoint = <&hdmi_in_vopb>;
 			};
+
+			vopb_out_mipi1: endpoint at 3 {
+				reg = <3>;
+				remote-endpoint = <&mipi1_in_vopb>;
+			};
 		};
 	};
 
@@ -1674,6 +1684,41 @@
 		};
 	};
 
+	mipi_dsi1: mipi at ff968000 {
+		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";
+		reg = <0x0 0xff968000 0x0 0x8000>;
+		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru SCLK_DPHY_PLL>, <&cru PCLK_MIPI_DSI1>,
+			 <&cru SCLK_DPHY_TX1RX1_CFG>, <&cru PCLK_VIO_GRF>;
+		clock-names = "ref", "pclk", "phy_cfg", "grf";
+		power-domains = <&power RK3399_PD_VIO>;
+		resets = <&cru SRST_P_MIPI_DSI1>;
+		reset-names = "apb";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mipi1_in: port at 0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mipi1_in_vopb: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vopb_out_mipi1>;
+				};
+
+				mipi1_in_vopl: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&vopl_out_mipi1>;
+				};
+			};
+		};
+	};
+
 	edp: edp at ff970000 {
 		compatible = "rockchip,rk3399-edp";
 		reg = <0x0 0xff970000 0x0 0x8000>;
-- 
2.15.0.531.g2ccb3012c9-goog
