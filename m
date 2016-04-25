From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 25 Apr 2016 16:08:30 +0200
Subject: [PATCH 1/6] arm64: dts: r8a7795: Don't disable referenced optional
 clocks
In-Reply-To: <1461593315-21307-1-git-send-email-geert+renesas@glider.be>
References: <1461593315-21307-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1461593315-21307-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_get() on a disabled clock node will return -EPROBE_DEFER, which can
cause drivers to be deferred forever if such clocks are referenced in
their devices' clocks properties.

Update the various disabled external clock nodes to default to a
frequency of 0, but don't disable them, to prevent this.

Reported-by: J?rg Billeter <j@bitron.ch>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 1 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 5 +----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 63d51059ae639e9d..263abaede2a82780 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -619,6 +619,7 @@
 };
 
 &pcie_bus_clk {
+	clock-frequency = <100000000>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 575b90c294467bea..727b37d797d9b902 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -159,7 +159,6 @@
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <0>;
-		status = "disabled";
 	};
 
 	/* External SCIF clock - to be overridden by boards that provide it */
@@ -167,15 +166,13 @@
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
1.9.1
