From: zyw@rock-chips.com (Chris Zhong)
Date: Sat, 31 Oct 2015 20:56:05 +0800
Subject: [PATCH v2 09/13] ARM: dts: rockchip: add rk3288 mipi_dsi nodes
In-Reply-To: <1446296170-3702-1-git-send-email-zyw@rock-chips.com>
References: <1446296170-3702-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1446296170-3702-10-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a mipi_dsi node, and also add mipi_dsi endpoints to vopb and vopl
output port nodes.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v2: None

 arch/arm/boot/dts/rk3288.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 6a79c9c..a5c5670 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -798,6 +798,10 @@
 				reg = <0>;
 				remote-endpoint = <&hdmi_in_vopb>;
 			};
+			vopb_out_mipi: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint = <&mipi_in_vopb>;
+			};
 		};
 	};
 
@@ -831,6 +835,10 @@
 				reg = <0>;
 				remote-endpoint = <&hdmi_in_vopl>;
 			};
+			vopl_out_mipi: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint = <&mipi_in_vopl>;
+			};
 		};
 	};
 
@@ -871,6 +879,37 @@
 		};
 	};
 
+	mipi_dsi: mipi at ff960000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi";
+		reg = <0xff960000 0x4000>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_MIPI_24M>, <&cru PCLK_MIPI_DSI0>;
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
2.6.2
