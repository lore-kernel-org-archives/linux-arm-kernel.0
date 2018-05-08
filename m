From: robh@kernel.org (Rob Herring)
Date: Tue,  8 May 2018 08:59:29 -0500
Subject: [PATCH] arm: dts: omap: fix OF graph in omap3-devkit8000
In-Reply-To: <20180508135930.5768-1-robh@kernel.org>
References: <20180508135930.5768-1-robh@kernel.org>
Message-ID: <20180508135930.5768-5-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap3-devkit8000-common.dtsi defines a graph connection for DVI, but
then omap3-devkit8000-lcd-common.dtsi overrides that with a graph
connection for the LCD as the same output signals are used. This
leaves an incomplete graph as the TFP410 output has only half a
connection. The result is the following warning:

arch/arm/boot/dts/omap3-devkit8000-lcd70.dtb: Warning (graph_endpoint): /encoder0/ports/port at 0/endpoint: graph connection to node '/ocp at 68000000/dss at 48050000/port/endpoint' is not bidirectional

Fix this by defining multiple endpoints which is the correct way to show
a 1 to many connection.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     | 9 ++++++++-
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi | 5 ++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
index 0c0bb1b01b0b..746a658e84b6 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
@@ -349,10 +349,17 @@
 	vdda_dac-supply = <&vdac>;
 
 	port {
-		dpi_dvi_out: endpoint {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		dpi_dvi_out: endpoint at 0 {
+			reg = <0>;
 			remote-endpoint = <&tfp410_in>;
 			data-lines = <24>;
 		};
+
+		endpoint at 1 {
+			reg = <1>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
index 2d64bcffaaa8..1093387259e2 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
@@ -30,7 +30,10 @@
 
 &dss {
 	port {
-		dpi_lcd_out: endpoint {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		dpi_lcd_out: endpoint at 1 {
+			reg = <1>;
 			remote-endpoint = <&lcd_in>;
 			data-lines = <24>;
 		};
-- 
2.17.0
