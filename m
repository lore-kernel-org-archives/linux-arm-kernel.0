From: s-anna@ti.com (Suman Anna)
Date: Wed, 24 May 2017 13:09:29 -0500
Subject: [PATCH v5 1/2] Documentation: dt: reset: Add TI SCI reset binding
In-Reply-To: <20170524180930.9290-1-s-anna@ti.com>
References: <20170524180930.9290-1-s-anna@ti.com>
Message-ID: <20170524180930.9290-2-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Andrew F. Davis" <afd@ti.com>

Add TI SCI reset controller binding. This describes the DT binding
details for a reset controller node providing reset management services
to hardware blocks (reset consumers) using the Texas Instrument's System
Control Interface (TI SCI) protocol to communicate to a system controller
block present on the SoC.

Signed-off-by: Andrew F. Davis <afd@ti.com>
[s-anna at ti.com: revise the binding format]
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v5:
 - Dropped the include/dt-bindings/reset/k2g.h file and its references
 - Updated description for the resets property in the TI-SCI Reset
   Consumer Nodes section
 - Updated the example as well to not use the macros from before

 .../devicetree/bindings/reset/ti,sci-reset.txt     | 62 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/ti,sci-reset.txt b/Documentation/devicetree/bindings/reset/ti,sci-reset.txt
new file mode 100644
index 000000000000..8b1cf022f18a
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/ti,sci-reset.txt
@@ -0,0 +1,62 @@
+Texas Instruments System Control Interface (TI-SCI) Reset Controller
+=====================================================================
+
+Some TI SoCs contain a system controller (like the Power Management Micro
+Controller (PMMC) on Keystone 66AK2G SoC) that are responsible for controlling
+the state of the various hardware modules present on the SoC. Communication
+between the host processor running an OS and the system controller happens
+through a protocol called TI System Control Interface (TI-SCI protocol).
+For TI SCI details, please refer to the document,
+Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+
+TI-SCI Reset Controller Node
+============================
+This reset controller node uses the TI SCI protocol to perform the reset
+management of various hardware modules present on the SoC. Must be a child
+node of the associated TI-SCI system controller node.
+
+Required properties:
+--------------------
+ - compatible	: Should be "ti,sci-reset"
+ - #reset-cells	: Should be 2. Please see the reset consumer node below for
+		  usage details.
+
+TI-SCI Reset Consumer Nodes
+===========================
+Each of the reset consumer nodes should have the following properties,
+in addition to their own properties.
+
+Required properties:
+--------------------
+ - resets	: A phandle and reset specifier pair, one pair for each reset
+		  signal that affects the device, or that the device manages.
+		  The phandle should point to the TI-SCI reset controller node,
+		  and the reset specifier should have 2 cell-values. The first
+		  cell should contain the device ID. The second cell should
+		  contain the reset mask value used by system controller.
+		  Please refer to the protocol documentation for these values
+		  to be used for different devices,
+		  http://processors.wiki.ti.com/index.php/TISCI#66AK2G02_Data
+
+Please also refer to Documentation/devicetree/bindings/reset/reset.txt for
+common reset controller usage by consumers.
+
+Example:
+--------
+The following example demonstrates both a TI-SCI reset controller node and a
+consumer (a DSP device) on the 66AK2G SoC.
+
+pmmc: pmmc {
+	compatible = "ti,k2g-sci";
+
+	k2g_reset: reset-controller {
+		compatible = "ti,sci-reset";
+		#reset-cells = <2>;
+	};
+};
+
+dsp0: dsp at 10800000 {
+	...
+	resets = <&k2g_reset 0x0046 0x1>;
+	...
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index f7d568b8f133..a4c48ec23a11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12630,6 +12630,7 @@ F:	include/linux/soc/ti/ti_sci_protocol.h
 F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 F:	include/dt-bindings/genpd/k2g.h
 F:	drivers/soc/ti/ti_sci_pm_domains.c
+F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
 
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
2.12.0
