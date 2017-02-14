From: youlin.pei@mediatek.com (Youlin Pei)
Date: Tue, 14 Feb 2017 10:55:59 +0800
Subject: [PATCH v3 1/3] binding: irqchip: mtk-cirq: Add binding document
In-Reply-To: <1487040961-18319-1-git-send-email-youlin.pei@mediatek.com>
References: <1487040961-18319-1-git-send-email-youlin.pei@mediatek.com>
Message-ID: <1487040961-18319-2-git-send-email-youlin.pei@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the device tree binding document for
the mediatek cirq.

Signed-off-by: Youlin Pei <youlin.pei@mediatek.com>
---
 .../interrupt-controller/mediatek,cirq.txt         |   35 ++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
new file mode 100644
index 0000000..a7efdbc
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
@@ -0,0 +1,35 @@
+* Mediatek 27xx cirq
+
+In Mediatek SOCs, the CIRQ is a low power interrupt controller designed to
+work outside MCUSYS which comprises with Cortex-Ax cores,CCI and GIC.
+The external interrupts (outside MCUSYS) will feed through CIRQ and connect
+to GIC in MCUSYS. When CIRQ is enabled, it will record the edge-sensitive
+interrupts and generate a pulse signal to parent interrupt controller when
+flush command is executed. With CIRQ, MCUSYS can be completely turned off
+to improve the system power consumption without losing interrupts.
+
+Required properties:
+- compatible: should be one of
+  - "mediatek,mt2701-cirq" for mt2701 CIRQ
+  - "mediatek,mt8135-cirq" for mt8135 CIRQ
+  - "mediatek,mt8173-cirq" for mt8173 CIRQ
+  and "mediatek,cirq" as a fallback.
+- interrupt-controller : Identifies the node as an interrupt controller.
+- #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
+- interrupt-parent: phandle of irq parent for cirq. The parent must
+  use the same interrupt-cells format as GIC.
+- reg: Physical base address of the cirq registers and length of memory
+  mapped region.
+- mediatek,ext-irq-range: Identifies external irq number range in different
+  SOCs.
+
+Example:
+	cirq: interrupt-controller at 10204000 {
+		compatible = "mediatek,mt2701-cirq",
+			     "mediatek,mtk-cirq";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&sysirq>;
+		reg = <0 0x10204000 0 0x400>;
+		mediatek,ext-irq-start = <32 200>;
+	};
-- 
1.7.9.5
