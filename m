From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Apr 2016 14:06:46 +1000
Subject: [PATCH 4/4] arm64: dts: r8a7795: Don't disable referenced optional
 clocks
In-Reply-To: <cover.1461723181.git.horms+renesas@verge.net.au>
References: <cover.1461723181.git.horms+renesas@verge.net.au>
Message-ID: <9f33a8a9e1b7dbb0b91a58af958d1c301a6fab1a.1461723181.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

clk_get() on a disabled clock node will return -EPROBE_DEFER, which can
cause drivers to be deferred forever if such clocks are referenced in
their devices' clocks properties.

Update the various disabled external clock nodes to default to a
frequency of 0, but don't disable them, to prevent this.

Reported-by: J?rg Billeter <j@bitron.ch>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 1 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 5 +----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 78c02937697e..8d8de245a845 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -394,6 +394,7 @@
 };
 
 &pcie_bus_clk {
+	clock-frequency = <100000000>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 11f9971a8543..7cb2d72e7378 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -120,7 +120,6 @@
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <0>;
-		status = "disabled";
 	};
 
 	/* External SCIF clock - to be overridden by boards that provide it */
@@ -128,15 +127,13 @@
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <0>;
-		status = "disabled";
 	};
 
 	/* External PCIe clock - can be overridden by the board */
 	pcie_bus_clk: pcie_bus {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-		status = "disabled";
+		clock-frequency = <0>;
 	};
 
 	soc {
-- 
2.7.0.rc3.207.g0ac5344
