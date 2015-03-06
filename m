From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:05:22 +0100
Subject: [PATCH v2 04/10] Documentation: bindings: move the Berlin reset
 documentation
In-Reply-To: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654328-26298-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Berlin reset documentation was part of the Marvell Berlin SoC
documentation because the Berlin reset configuration was inside the chip
controller. With the recent rework of the chip and system controller
handling (now an MFD driver registers all sub-devices of the two soc and
system controller nodes and each device has its own sub-node), the
documentation of the Berlin reset driver can be moved to the generic
reset documentation directory.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/arm/marvell,berlin.txt     | 10 ----------
 .../devicetree/bindings/reset/berlin,reset.txt     | 23 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/berlin,reset.txt

diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
index 3a7fce4dc4af..8bf3f2075233 100644
--- a/Documentation/devicetree/bindings/arm/marvell,berlin.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
@@ -112,21 +112,11 @@ Required subnode-properties:
 - groups: a list of strings describing the group names.
 - function: a string describing the function used to mux the groups.
 
-* Reset controller binding
-
-A reset controller is part of the chip control registers set. The chip control
-node also provides the reset. The register set is not at the same offset between
-Berlin SoCs.
-
-Required property:
-- #reset-cells: must be set to 2
-
 Example:
 
 chip: chip-control at ea0000 {
 	compatible = "marvell,berlin2-chip-ctrl", "simple-mfd", "syscon";
 	#clock-cells = <1>;
-	#reset-cells = <2>;
 	reg = <0xea0000 0x400>;
 	clocks = <&refclk>, <&externaldev 0>;
 	clock-names = "refclk", "video_ext0";
diff --git a/Documentation/devicetree/bindings/reset/berlin,reset.txt b/Documentation/devicetree/bindings/reset/berlin,reset.txt
new file mode 100644
index 000000000000..514fee098b4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/berlin,reset.txt
@@ -0,0 +1,23 @@
+Marvell Berlin reset controller
+===============================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+The reset controller node must be a sub-node of the chip controller
+node on Berlin SoCs.
+
+Required properties:
+- compatible: should be "marvell,berlin2-reset"
+- #reset-cells: must be set to 2
+
+Example:
+
+chip_rst: reset {
+	compatible = "marvell,berlin2-reset";
+	#reset-cells = <2>;
+};
+
+&usb_phy0 {
+	resets = <&chip_rst 0x104 12>;
+};
-- 
2.3.1
