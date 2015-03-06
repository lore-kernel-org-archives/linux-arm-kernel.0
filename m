From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:12:57 +0100
Subject: [PATCH v2 04/11] Documentation: bindings: move the Berlin clock
 documentation
In-Reply-To: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654784-27354-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Berlin clock documentation was part of the Marvell Berlin SoC
documentation because the Berlin clock configuration was inside the
chip controller. With the recent rework of the chip and system
controller handling (now all sub-devices of the soc and system
controller nodes are registred with simple-mfd, and each device has its
own sub-node), the documentation of the Berlin clock driver can be moved
to the generic clock documentation directory.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/arm/marvell,berlin.txt     | 27 +++----------------
 .../devicetree/bindings/clock/marvell,berlin.txt   | 31 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,berlin.txt

diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
index ece73c6ad973..4a8ff8e14cb7 100644
--- a/Documentation/devicetree/bindings/arm/marvell,berlin.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
@@ -75,37 +75,18 @@ Required properties:
 		"simple-mfd", "syscon"
 - reg: address and length of the system control register set
 
-* Clock provider binding
-
-As clock related registers are spread among the chip control registers, the
-chip control node also provides the clocks. Marvell Berlin2 (BG2, BG2CD, BG2Q)
-SoCs share the same IP for PLLs and clocks, with some minor differences in
-features and register layout.
-
-Required properties:
-- #clock-cells: shall be set to 1
-- clocks: clock specifiers referencing the core clock input clocks
-- clock-names: array of strings describing the input clock specifiers above.
-    Allowed clock-names for the reference clocks are
-      "refclk" for the SoCs osciallator input on all SoCs,
-    and SoC-specific input clocks for
-      BG2/BG2CD: "video_ext0" for the external video clock input
-
-Clocks provided by core clocks shall be referenced by a clock specifier
-indexing one of the provided clocks. Refer to dt-bindings/clock/berlin<soc>.h
-for the corresponding index mapping.
-
 Example:
 
 chip: chip-control at ea0000 {
 	compatible = "marvell,berlin2-chip-ctrl", "simple-mfd", "syscon";
-	#clock-cells = <1>;
 	reg = <0xea0000 0x400>;
-	clocks = <&refclk>, <&externaldev 0>;
-	clock-names = "refclk", "video_ext0";
+
+	/* sub-device nodes */
 };
 
 sysctrl: system-controller at d000 {
 	compatible = "marvell,berlin2-system-ctrl", "simple-mfd", "syscon";
 	reg = <0xd000 0x100>;
+
+	/* sub-device nodes */
 };
diff --git a/Documentation/devicetree/bindings/clock/marvell,berlin.txt b/Documentation/devicetree/bindings/clock/marvell,berlin.txt
new file mode 100644
index 000000000000..c611c495f3ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/marvell,berlin.txt
@@ -0,0 +1,31 @@
+Device Tree Clock bindings for Marvell Berlin
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Clock related registers are spread among the chip control registers. Berlin
+clock node should be a sub-node of the chip controller node. Marvell Berlin2
+(BG2, BG2CD, BG2Q) SoCs share the same IP for PLLs and clocks, with some
+minor differences in features and register layout.
+
+Required properties:
+- compatible: must be "marvell,berlin2-clk" or "marvell,berlin2q-clk"
+- #clock-cells: must be 1
+- clocks: must be the input parent clock phandle
+- clock-names: name of the input parent clock
+	Allowed clock-names for the reference clocks are
+	"refclk" for the SoCs oscillator input on all SoCs,
+	and SoC-specific input clocks for
+	BG2/BG2CD: "video_ext0" for the external video clock input
+
+
+Example:
+
+chip_clk: clock {
+	compatible = "marvell,berlin2q-clk";
+
+	#clock-cells = <1>;
+	clocks = <&refclk>;
+	clock-names = "refclk";
+};
-- 
2.3.1
