From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 5 Jul 2016 17:04:22 +0800
Subject: [PATCH V2 01/10] Documentation: dt-bindings: mailbox: tegra: Add
 binding for HSP mailbox
In-Reply-To: <20160705090431.5852-1-josephl@nvidia.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
Message-ID: <20160705090431.5852-2-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding for the Hardware Synchronization Primitives (HSP). The
HSP is designed for the processors to share resources and communicate
together. It provides a set of hardware synchronization primitives for
interprocessor communication. So the interprocessor communication (IPC)
protocols can use hardware synchronization primitive, when operating
between two processors not in an SMP relationship.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
Changes in V2:
- revise the compatible string, interrupt-names, interrupts, and #mbox-cells
  properties
- remove "nvidia,hsp-function" property
- fix the header file name
- the binding supports the concept of multiple HSP sub-modules on one HSP HW
  block now.
---
 .../bindings/mailbox/nvidia,tegra186-hsp.txt       | 51 ++++++++++++++++++++++
 include/dt-bindings/mailbox/tegra186-hsp.h         | 23 ++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
 create mode 100644 include/dt-bindings/mailbox/tegra186-hsp.h

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
new file mode 100644
index 000000000000..10e53edbe1c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
@@ -0,0 +1,51 @@
+NVIDIA Tegra Hardware Synchronization Primitives (HSP)
+
+The HSP modules are used for the processors to share resources and communicate
+together. It provides a set of hardware synchronization primitives for
+interprocessor communication. So the interprocessor communication (IPC)
+protocols can use hardware synchronization primitives, when operating between
+two processors not in an SMP relationship.
+
+The features that HSP supported are shared mailboxes, shared semaphores,
+arbitrated semaphores and doorbells.
+
+Required properties:
+- name : Should be hsp
+- compatible
+    Array of strings.
+    one of:
+    - "nvidia,tegra186-hsp"
+- reg : Offset and length of the register set for the device.
+- interrupt-names
+    Array of strings.
+    Contains a list of names for the interrupts described by the interrupt
+    property. May contain the following entries, in any order:
+    - "doorbell"
+    Users of this binding MUST look up entries in the interrupt property
+    by name, using this interrupt-names property to do so.
+- interrupts
+    Array of interrupt specifiers.
+    Must contain one entry per entry in the interrupt-names property,
+    in a matching order.
+- #mbox-cells : Should be 1.
+
+The mbox specifier of the "mboxes" property in the client node should use
+the "HSP_MBOX_ID" macro which integrates the HSP type and master ID data.
+Those information can be found in the following file.
+
+- <dt-bindings/mailbox/tegra186-hsp.h>.
+
+Example:
+
+hsp_top0: hsp at 3c00000 {
+	compatible = "nvidia,tegra186-hsp";
+	reg = <0x0 0x03c00000 0x0 0xa0000>;
+	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "doorbell";
+	#mbox-cells = <1>;
+};
+
+client {
+	...
+	mboxes = <&hsp_top0 HSP_MBOX_ID(DB, HSP_DB_MASTER_XXX)>;
+};
diff --git a/include/dt-bindings/mailbox/tegra186-hsp.h b/include/dt-bindings/mailbox/tegra186-hsp.h
new file mode 100644
index 000000000000..365dbeb5d894
--- /dev/null
+++ b/include/dt-bindings/mailbox/tegra186-hsp.h
@@ -0,0 +1,23 @@
+/*
+ * This header provides constants for binding nvidia,tegra186-hsp.
+ *
+ * The number with HSP_DB_MASTER prefix indicates the bit that is
+ * associated with a master ID in the doorbell registers.
+ */
+
+
+#ifndef _DT_BINDINGS_MAILBOX_TEGRA186_HSP_H
+#define _DT_BINDINGS_MAILBOX_TEGRA186_HSP_H
+
+#define HSP_MBOX_TYPE_DB 0x0
+#define HSP_MBOX_TYPE_SM 0x1
+#define HSP_MBOX_TYPE_SS 0x2
+#define HSP_MBOX_TYPE_AS 0x3
+
+#define HSP_DB_MASTER_CCPLEX 17
+#define HSP_DB_MASTER_BPMP 19
+
+#define HSP_MBOX_ID(type, ID) \
+		(HSP_MBOX_TYPE_##type << 16 | ID)
+
+#endif	/* _DT_BINDINGS_MAILBOX_TEGRA186_HSP_H */
-- 
2.9.0
