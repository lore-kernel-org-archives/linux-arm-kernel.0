From: zyw@rock-chips.com (Chris Zhong)
Date: Wed, 16 Dec 2015 18:10:15 +0800
Subject: [PATCH v6 5/6] ARM: dts: rockchip: add rk3288 mipi_dsi nodes
In-Reply-To: <1450260616-21160-1-git-send-email-zyw@rock-chips.com>
References: <1450260616-21160-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1450260616-21160-6-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a mipi_dsi node, and also add mipi_dsi endpoints to vopb and vopl
output port nodes.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

Changes in v6: None
Changes in v5:
- modify the clk name to SCLK_MIPIDSI_24M

Changes in v4: None
Changes in v3: None

 arch/arm/boot/dts/rk3288.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index a9270f7..1086761 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -817,6 +817,10 @@
 				reg = <1>;
 				remote-endpoint = <&hdmi_in_vopb>;
 			};
+			vopb_out_mipi: endpoint at 2 {
+				reg = <2>;
+				remote-endpoint = <&mipi_in_vopb>;
+			};
 		};
 	};
 
@@ -853,6 +857,10 @@
 				reg = <1>;
 				remote-endpoint = <&hdmi_in_vopl>;
 			};
+			vopl_out_mipi: endpoint at 2 {
+				reg = <2>;
+				remote-endpoint = <&mipi_in_vopl>;
+			};
 		};
 	};
 
@@ -954,6 +962,37 @@
 		status = "disabled";
 	};
 
+	mipi_dsi: mipi at ff960000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi";
+		reg = <0xff960000 0x4000>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_MIPIDSI_24M>, <&cru PCLK_MIPI_DSI0>;
+		clock-names = "ref", "pclk";
+		rockchip,grf = <&grf>;
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
 	gic: interrupt-controller at ffc01000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
-- 
2.6.3
