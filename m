From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 11 Feb 2015 17:15:23 +0100
Subject: [PATCH 02/11] Documentation: bindings: add the Berlin controller
 documentation
In-Reply-To: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1423671332-24580-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A Berlin controller mfd driver was added to handle correctly the chip
and system controller DT nodes. Its purpose is to register devices
configured by one of the controller nodes. This adds the corresponding
bindings documentation.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/arm/marvell,berlin.txt     | 29 ---------------
 .../devicetree/bindings/mfd/berlin-ctrl.txt        | 43 ++++++++++++++++++++++
 2 files changed, 43 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/berlin-ctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
index a99eb9eb14c0..cb280bc8de80 100644
--- a/Documentation/devicetree/bindings/arm/marvell,berlin.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
@@ -40,35 +40,6 @@ cpu-ctrl at f7dd0000 {
 	reg = <0xf7dd0000 0x10000>;
 };
 
-* Marvell Berlin2 chip control binding
-
-Marvell Berlin SoCs have a chip control register set providing several
-individual registers dealing with pinmux, padmux, clock, reset, and secondary
-CPU boot address. Unfortunately, the individual registers are spread among the
-chip control registers, so there should be a single DT node only providing the
-different functions which are described below.
-
-Required properties:
-- compatible: shall be one of
-	"marvell,berlin2-chip-ctrl" for BG2
-	"marvell,berlin2cd-chip-ctrl" for BG2CD
-	"marvell,berlin2q-chip-ctrl" for BG2Q
-- reg: address and length of following register sets for
-  BG2/BG2CD: chip control register set
-  BG2Q: chip control register set and cpu pll registers
-
-* Marvell Berlin2 system control binding
-
-Marvell Berlin SoCs have a system control register set providing several
-individual registers dealing with pinmux, padmux, and reset.
-
-Required properties:
-- compatible: should be one of
-	"marvell,berlin2-system-ctrl" for BG2
-	"marvell,berlin2cd-system-ctrl" for BG2CD
-	"marvell,berlin2q-system-ctrl" for BG2Q
-- reg: address and length of the system control register set
-
 * Clock provider binding
 
 As clock related registers are spread among the chip control registers, the
diff --git a/Documentation/devicetree/bindings/mfd/berlin-ctrl.txt b/Documentation/devicetree/bindings/mfd/berlin-ctrl.txt
new file mode 100644
index 000000000000..eed8ed437a1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/berlin-ctrl.txt
@@ -0,0 +1,43 @@
+* Marvell Berlin Multi-Functional Device controller
+
+Marvell Berlin SoCs have a chip control register set providing several
+individual registers dealing with pinmux, padmux, clock, reset, and secondary
+CPU boot address. Unfortunately, the individual registers are spread among the
+chip control registers, so there should be a single DT node only providing the
+different functions which are described below.
+
+Marvell Berlin SoCs also have a system control register set providing several
+individual registers dealing with pinmux, padmux, and reset.
+
+The Berlin controller mfd handles the chip and the system controllers on Berlin
+SoCs. It exposes various devices:
+- pinctrl, see Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
+- reset, see Documentation/devicetree/bindings/reset/berlin,reset.txt
+
+Required properties:
+- compatible:
+	* the first value should be one of:
+		"marvell,berlin2-chip-ctrl",
+		"marvell,berlin2-system-ctrl",
+		"marvell,berlin2cd-chip-ctrl",
+		"marvell,berlin2cd-system-ctrl",
+		"marvell,berlin2q-chip-ctrl",
+		"marvell,berlin2q-system-ctrl"
+	* the second value must be "syscon"
+- reg: the controller register range
+
+Example:
+
+chip: chip-controller at f7ea0000 {
+	compatible = "marvell,berlin2q-chip-ctrl", "syscon";
+	reg = <0xf7ea0000 0x400>;
+
+	/* sub-device nodes */
+};
+
+sysctrl: system-controller at f7fcd000 {
+	compatible = "marvell,berlin2q-system-ctrl", "syscon";
+	reg = <0xf7fcd000 0x100>;
+
+	/* sub-device nodes */
+};
-- 
2.3.0
