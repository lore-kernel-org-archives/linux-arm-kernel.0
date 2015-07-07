From: eric@anholt.net (Eric Anholt)
Date: Tue,  7 Jul 2015 14:13:36 -0700
Subject: [PATCH 3/4] irqchip: Add documentation for the bcm2836 interrupt
 controller.
In-Reply-To: <1436303617-17185-1-git-send-email-eric@anholt.net>
References: <1436303617-17185-1-git-send-email-eric@anholt.net>
Message-ID: <1436303617-17185-4-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a new per-cpu root interrupt controller on the Raspberry Pi 2,
which will chain to the bcm2835 interrupt controller for peripheral
interrupts.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../interrupt-controller/brcm,bcm2836-l1-intc.txt  | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt
new file mode 100644
index 0000000..f320dcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt
@@ -0,0 +1,37 @@
+BCM2836 per-CPU interrupt controller
+
+The BCM2836 has a per-cpu interrupt controller for the timer, PMU
+events, and SMP IPIs.  One of the CPUs may receive interrupts for the
+peripheral (GPU) events, which chain to the BCM2835-style interrupt
+controller.
+
+Required properties:
+
+- compatible:	 	Should be "brcm,bcm2836-l1-intc"
+- reg:			Specifies base physical address and size of the
+			  registers
+- interrupt-controller:	Identifies the node as an interrupt controller
+- #interrupt-cells:	Specifies the number of cells needed to encode an
+			  interrupt source. The value shall be 1
+
+Please refer to interrupts.txt in this directory for details of the common
+Interrupt Controllers bindings used by client devices.
+
+The interrupt sources are as follows:
+
+0: CNTPSIRQ
+1: CNTPNSIRQ
+2: CNTHPIRQ
+3: CNTVIRQ
+8: GPU_FAST
+9: PMU_FAST
+
+Example:
+
+local_intc: local_intc {
+	compatible = "brcm,bcm2836-l1-intc";
+	reg = <0x40000000 0x100>;
+	interrupt-controller;
+	#interrupt-cells = <1>;
+	interrupt-parent = <&local_intc>;
+};
-- 
2.1.4
