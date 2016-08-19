From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 19 Aug 2016 19:32:22 +0200
Subject: [PATCH v3 01/12] dt-bindings: mailbox: Add Tegra HSP binding
In-Reply-To: <20160819173233.13260-1-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
Message-ID: <20160819173233.13260-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joseph Lo <josephl@nvidia.com>

Add DT binding for the Hardware Synchronization Primitives (HSP). The
HSP is designed for the processors to share resources and communicate
with one another. A set of hardware synchronization primitives for
interprocessor communication (IPC) is provided. IPC protocols can use
use these hardware synchronization primitives when operating between
processors in an AMP configuration.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/mailbox/nvidia,tegra186-hsp.txt       | 52 ++++++++++++++++++++++
 include/dt-bindings/mailbox/tegra186-hsp.h         | 24 ++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
 create mode 100644 include/dt-bindings/mailbox/tegra186-hsp.h

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
new file mode 100644
index 000000000000..b99d25fc2f26
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
@@ -0,0 +1,52 @@
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
+- #mbox-cells : Should be 2.
+
+The mbox specifier of the "mboxes" property in the client node should
+contain two data. The first one should be the HSP type and the second
+one should be the ID that the client is going to use. Those information
+can be found in the following file.
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
+	#mbox-cells = <2>;
+};
+
+client {
+	...
+	mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_DB TEGRA_HSP_DB_MASTER_XXX>;
+};
diff --git a/include/dt-bindings/mailbox/tegra186-hsp.h b/include/dt-bindings/mailbox/tegra186-hsp.h
new file mode 100644
index 000000000000..f5d66e5f5f10
--- /dev/null
+++ b/include/dt-bindings/mailbox/tegra186-hsp.h
@@ -0,0 +1,24 @@
+/*
+ * This header provides constants for binding nvidia,tegra186-hsp.
+ */
+
+#ifndef _DT_BINDINGS_MAILBOX_TEGRA186_HSP_H
+#define _DT_BINDINGS_MAILBOX_TEGRA186_HSP_H
+
+/*
+ * These define the type of mailbox that is to be used (doorbell, shared
+ * mailbox, shared semaphore or arbitrated semaphore).
+ */
+#define TEGRA_HSP_MBOX_TYPE_DB 0x0
+#define TEGRA_HSP_MBOX_TYPE_SM 0x1
+#define TEGRA_HSP_MBOX_TYPE_SS 0x2
+#define TEGRA_HSP_MBOX_TYPE_AS 0x3
+
+/*
+ * These defines represent the bit associated with the given master ID in the
+ * doorbell registers.
+ */
+#define TEGRA_HSP_DB_MASTER_CCPLEX 17
+#define TEGRA_HSP_DB_MASTER_BPMP 19
+
+#endif
-- 
2.9.0
