From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 21 Feb 2018 10:20:33 +0100
Subject: [PATCH v2 09/10] arm: dts: sun8i: a33: Add the DSI-related nodes
In-Reply-To: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
References: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
Message-ID: <5513fa8f9297470d602d742f42fddd4a41e03faf.1519204731.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The A33 has a MIPI-DSI block, along with its D-PHY. Let's add it in order
to use it in the relevant boards.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 35 +++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 50eb84fa246a..20400c87d611 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -236,6 +236,11 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <1>;
+
+					tcon0_out_dsi0: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&dsi0_in_tcon0>;
+					};
 				};
 			};
 		};
@@ -280,6 +285,36 @@
 			#io-channel-cells = <0>;
 		};
 
+		dsi0: dsi at 1ca0000 {
+			compatible = "allwinner,sun6i-a31-mipi-dsi";
+			reg = <0x01ca0000 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>,
+				 <&ccu CLK_DSI_SCLK>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			phys = <&dphy0>;
+			phy-names = "dphy";
+			status = "disabled";
+
+			port {
+				dsi0_in_tcon0: endpoint {
+					remote-endpoint = <&tcon0_out_dsi0>;
+				};
+			};
+		};
+
+		dphy0: d-phy at 1ca1000 {
+			compatible = "allwinner,sun6i-a31-mipi-dphy";
+			reg = <0x01ca1000 0x1000>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>,
+				 <&ccu CLK_DSI_DPHY>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			status = "disabled";
+			#phy-cells = <0>;
+		};
+
 		fe0: display-frontend at 1e00000 {
 			compatible = "allwinner,sun8i-a33-display-frontend";
 			reg = <0x01e00000 0x20000>;
-- 
git-series 0.9.1
