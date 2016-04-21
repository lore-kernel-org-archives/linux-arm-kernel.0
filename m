From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 21 Apr 2016 13:44:29 +1000
Subject: [PATCH 1/3] ARM: dts: r8a7791: Don't disable referenced optional
 clocks
In-Reply-To: <cover.1461209970.git.horms+renesas@verge.net.au>
References: <cover.1461209970.git.horms+renesas@verge.net.au>
Message-ID: <ac6908b3049397b10bcfd8143d79cbdbbd266f02.1461209970.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

clk_get on a disabled clock node will return EPROBE_DEFER, which can
cause drivers to be deferred forever if such clocks are referenced in
their clocks property.

Update the various disabled external clock nodes to default to a
frequency of 0, but don't disable them to prevent this.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 1 +
 arch/arm/boot/dts/r8a7791-porter.dts  | 1 +
 arch/arm/boot/dts/r8a7791.dtsi        | 5 +----
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 0ad71b81d3a2..cc6e28f81fe4 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -661,6 +661,7 @@
 };
 
 &pcie_bus_clk {
+	clock-frequency = <100000000>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 6c08314427d6..76c5b2ef8b7e 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -414,6 +414,7 @@
 };
 
 &pcie_bus_clk {
+	clock-frequency = <100000000>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 6439f0569fe2..1cd1b6a3a72a 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1083,9 +1083,8 @@
 		pcie_bus_clk: pcie_bus_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <100000000>;
+			clock-frequency = <0>;
 			clock-output-names = "pcie_bus";
-			status = "disabled";
 		};
 
 		/* External SCIF clock */
@@ -1094,7 +1093,6 @@
 			#clock-cells = <0>;
 			/* This value must be overridden by the board. */
 			clock-frequency = <0>;
-			status = "disabled";
 		};
 
 		/* External USB clock - can be overridden by the board */
@@ -1112,7 +1110,6 @@
 			/* This value must be overridden by the board. */
 			clock-frequency = <0>;
 			clock-output-names = "can_clk";
-			status = "disabled";
 		};
 
 		/* Special CPG clocks */
-- 
2.7.0.rc3.207.g0ac5344
