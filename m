From: stefan@agner.ch (Stefan Agner)
Date: Fri, 30 Jan 2015 11:33:04 +0100
Subject: [PATCH v4 2/3] irqchip: vf610-mscm: dt-bindings: add MSCM bindings
In-Reply-To: <1422613985-11726-1-git-send-email-stefan@agner.ch>
References: <1422613985-11726-1-git-send-email-stefan@agner.ch>
Message-ID: <1422613985-11726-3-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for CPU configuration and interrupt router
submodule of the Miscellaneous System Control Module. The MSCM is
used in all variants of Freescale Vybrid SoC's.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 .../arm/freescale/fsl,vf610-mscm-cpucfg.txt        | 14 +++++++++
 .../bindings/arm/freescale/fsl,vf610-mscm-ir.txt   | 33 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-cpucfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-ir.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-cpucfg.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-cpucfg.txt
new file mode 100644
index 0000000..44aa3c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-cpucfg.txt
@@ -0,0 +1,14 @@
+Freescale Vybrid Miscellaneous System Control - CPU Configuration
+
+The MSCM IP contains multiple sub modules, this binding describes the first
+block of registers which contains CPU configuration information.
+
+Required properties:
+- compatible:	"fsl,vf610-mscm-cpucfg", "syscon"
+- reg:		the register range of the MSCM CPU configuration registers
+
+Example:
+	mscm_cpucfg: cpucfg at 40001000 {
+		compatible = "fsl,vf610-mscm-cpucfg", "syscon";
+		reg = <0x40001000 0x800>;
+	}
diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-ir.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-ir.txt
new file mode 100644
index 0000000..669808b2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-ir.txt
@@ -0,0 +1,33 @@
+Freescale Vybrid Miscellaneous System Control - Interrupt Router
+
+The MSCM IP contains multiple sub modules, this binding describes the second
+block of registers which control the interrupt router. The interrupt router
+allows to configure the recipient of each peripheral interrupt. Furthermore
+it controls the directed processor interrupts. The module is available in all
+Vybrid SoC's but is only really useful in dual core configurations (VF6xx
+which comes with a Cortex-A5/Cortex-M4 combination).
+
+Required properties:
+- compatible:		"fsl,vf610-mscm-ir"
+- reg:			the register range of the MSCM Interrupt Router
+- fsl,cpucfg:		The handle to the MSCM CPU configuration node, required
+			to get the current CPU ID
+- interrupt-controller:	Identifies the node as an interrupt controller
+- #interrupt-cells:	Two cells, interrupt number and cells.
+			The hardware interrupt number according to interrupt
+			assignment of the interrupt router is required.
+			Flags get passed only when using GIC as parent. Flags
+			encoding as documented by the GIC bindings.
+- interrupt-parent:	Should be the phandle for the interrupt controller of
+			the CPU the device tree is intended to be used on. This
+			is either the node of the GIC or NVIC controller.
+
+Example:
+	mscm_ir: interrupt-controller at 40001800 {
+		compatible = "fsl,vf610-mscm-ir";
+		reg = <0x40001800 0x400>;
+		fsl,cpucfg = <&mscm_cpucfg>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&intc>;
+	}
-- 
2.2.2
