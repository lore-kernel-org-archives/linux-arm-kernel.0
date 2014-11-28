From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 28 Nov 2014 17:26:50 +0000
Subject: [PATCH 6/9] DT: tegra: add binding for the legacy interrupt controller
In-Reply-To: <1417195613-8447-1-git-send-email-marc.zyngier@arm.com>
References: <1417195613-8447-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1417195613-8447-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 .../interrupt-controller/nvdia,tegra-ictlr.txt     | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nvdia,tegra-ictlr.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/nvdia,tegra-ictlr.txt b/Documentation/devicetree/bindings/interrupt-controller/nvdia,tegra-ictlr.txt
new file mode 100644
index 0000000..4de6a2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/nvdia,tegra-ictlr.txt
@@ -0,0 +1,39 @@
+NVIDIA Legacy Interrupt Controller
+
+All Tegra SoCs contain a legacy interrupt controller that routes
+interrupts to the GIC, and also serves as a wakeup source. It is also
+refered to as "ictlr", hence the name of the binding.
+
+The HW block exposes a number of frames, each implementing a set of 32
+interrupts.
+
+Reguired properties:
+
+- compatible : should contain at least "nvidia,tegra-ictlr".
+- reg : Specifies base physical address and size of the registers.
+  Each frame must be described separately.
+- interrupt-controller : Identifies the node as an interrupt controller.
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value must be 3.
+- interrupt-parent : a phandle to the GIC these interrupts are routed
+  to.
+
+Notes:
+
+- Because this HW ultimately routes interrupts to the GIC, the
+  interrupt specifier must be that of the GIC.
+- Only SPIs can use the ictlr as an interrupt parent. SGIs and PPIs
+  are excplicitely forbiden.
+
+Example:
+
+	ictlr: interrupt-controller at 60004000 {
+		compatible = "nvidia,tegra20-ictlr", "nvidia,tegra-ictlr";
+		reg = <0x60004000 64>,
+		      <0x60004100 64>,
+		      <0x60004200 64>,
+		      <0x60004300 64>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.1.3
