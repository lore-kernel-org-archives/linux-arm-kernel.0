From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:05:25 +0100
Subject: [PATCH v2 07/10] Documentation: bindings: move the Berlin pinctrl
 documentation
In-Reply-To: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654328-26298-8-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Berlin pinctrl documentation was part of the Marvell Berlin SoC
documentation because the Berlin pinctrl configuration was inside the
chip and the system controllers. With the recent rework of the chip and
system controller handling (now an MFD driver registers all sub-devices
of the two soc and system controller nodes and each device has its own
sub-node), the documentation of the Berlin pinctrl driver can be moved
to the generic pinctrl documentation directory.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/arm/marvell,berlin.txt     | 37 -------------------
 .../devicetree/bindings/pinctrl/berlin,pinctrl.txt | 43 ++++++++++++++++++++++
 2 files changed, 43 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
index 8bf3f2075233..ece73c6ad973 100644
--- a/Documentation/devicetree/bindings/arm/marvell,berlin.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
@@ -95,23 +95,6 @@ Clocks provided by core clocks shall be referenced by a clock specifier
 indexing one of the provided clocks. Refer to dt-bindings/clock/berlin<soc>.h
 for the corresponding index mapping.
 
-* Pin controller binding
-
-Pin control registers are part of both register sets, chip control and system
-control. The pins controlled are organized in groups, so no actual pin
-information is needed.
-
-A pin-controller node should contain subnodes representing the pin group
-configurations, one per function. Each subnode has the group name and the muxing
-function used.
-
-Be aware the Marvell Berlin datasheets use the keyword 'mode' for what is called
-a 'function' in the pin-controller subsystem.
-
-Required subnode-properties:
-- groups: a list of strings describing the group names.
-- function: a string describing the function used to mux the groups.
-
 Example:
 
 chip: chip-control at ea0000 {
@@ -120,29 +103,9 @@ chip: chip-control at ea0000 {
 	reg = <0xea0000 0x400>;
 	clocks = <&refclk>, <&externaldev 0>;
 	clock-names = "refclk", "video_ext0";
-
-	spi1_pmux: spi1-pmux {
-		groups = "G0";
-		function = "spi1";
-	};
 };
 
 sysctrl: system-controller at d000 {
 	compatible = "marvell,berlin2-system-ctrl", "simple-mfd", "syscon";
 	reg = <0xd000 0x100>;
-
-	uart0_pmux: uart0-pmux {
-		groups = "GSM4";
-		function = "uart0";
-	};
-
-	uart1_pmux: uart1-pmux {
-		groups = "GSM5";
-		function = "uart1";
-	};
-
-	uart2_pmux: uart2-pmux {
-		groups = "GSM3";
-		function = "uart2";
-	};
 };
diff --git a/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
new file mode 100644
index 000000000000..a8bb5e26019c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
@@ -0,0 +1,43 @@
+* Pin-controller driver for the Marvell Berlin SoCs
+
+Pin control registers are part of both chip controller and system
+controller register sets. Pin controller nodes should be a sub-node of
+either the chip controller or system controller node. The pins
+controlled are organized in groups, so no actual pin information is
+needed.
+
+A pin-controller node should contain subnodes representing the pin group
+configurations, one per function. Each subnode has the group name and
+the muxing function used.
+
+Be aware the Marvell Berlin datasheets use the keyword 'mode' for what
+is called a 'function' in the pin-controller subsystem.
+
+Required properties:
+- compatible: should be one of:
+	"marvell,berlin2-soc-pinctrl",
+	"marvell,berlin2-system-pinctrl",
+	"marvell,berlin2cd-soc-pinctrl",
+	"marvell,berlin2cd-system-pinctrl",
+	"marvell,berlin2q-soc-pinctrl",
+	"marvell,berlin2q-system-pinctrl"
+
+Required subnode-properties:
+- groups: a list of strings describing the group names.
+- function: a string describing the function used to mux the groups.
+
+Example:
+
+sys_pinctrl: pin-controller {
+	compatible = "marvell,berlin2q-system-pinctrl";
+
+	uart0_pmux: uart0-pmux {
+		groups = "GSM12";
+		function = "uart0";
+	};
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_pmux>;
+	pinctrl-names = "default";
+};
-- 
2.3.1
