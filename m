From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 16 Jul 2018 16:42:01 +0200
Subject: [PATCH v3 18/23] dt-bindings: cp110: add the thermal node in the
 syscon file
In-Reply-To: <20180716144206.30985-1-miquel.raynal@bootlin.com>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
Message-ID: <20180716144206.30985-19-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Explain the thermal bindings now that the thermal IP is described being
inside of a system controller. Add a reference to the thermal-zone node.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../arm/marvell/cp110-system-controller.txt        | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
index 54b0d64ce819..81ce742d2760 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
@@ -11,6 +11,9 @@ For the top level node:
  - compatible: must be: "syscon", "simple-mfd";
  - reg: register area of the CP110 system controller
 
+SYSTEM CONTROLLER 0
+===================
+
 Clocks:
 -------
 
@@ -186,3 +189,37 @@ CP110_LABEL(syscon0): system-controller at 440000 {
 	};
 
 };
+
+SYSTEM CONTROLLER 1
+===================
+
+Thermal:
+--------
+
+The thermal IP can probe the temperature all around the processor. It
+may feature several channels, each of them wired to one sensor.
+
+For common binding part and usage, refer to
+Documentation/devicetree/bindings/thermal/thermal.txt
+
+Required properties:
+- compatible: must be one of:
+  * marvell,armada-cp110-thermal
+- reg: register range associated with the thermal functions.
+
+Optional properties:
+- #thermal-sensor-cells: shall be <1> when thermal-zones subnodes refer
+  to this IP and represents the channel ID. There is one sensor per
+  channel. O refers to the thermal IP internal channel.
+
+Example:
+CP110_LABEL(syscon1): system-controller at 6f8000 {
+	compatible = "syscon", "simple-mfd";
+	reg = <0x6f8000 0x1000>;
+
+	CP110_LABEL(thermal): thermal-sensor at 70 {
+		compatible = "marvell,armada-cp110-thermal";
+		reg = <0x70 0x10>;
+		#thermal-sensor-cells = <1>;
+	};
+};
-- 
2.14.1
