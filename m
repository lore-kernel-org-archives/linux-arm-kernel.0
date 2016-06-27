From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 27 Jun 2016 17:02:39 +0800
Subject: [PATCH 01/10] Documentation: dt-bindings: mailbox: tegra: Add binding
 for HSP mailbox
In-Reply-To: <20160627090248.23621-1-josephl@nvidia.com>
References: <20160627090248.23621-1-josephl@nvidia.com>
Message-ID: <20160627090248.23621-2-josephl@nvidia.com>
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
 .../bindings/mailbox/nvidia,tegra186-hsp.txt       | 42 ++++++++++++++++++++++
 include/dt-bindings/mailbox/tegra-hsp.h            | 20 +++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
 create mode 100644 include/dt-bindings/mailbox/tegra-hsp.h

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
new file mode 100644
index 000000000000..ca07af2d951e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
@@ -0,0 +1,42 @@
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
+- compatible : Should be "nvidia,tegra<chip>-hsp"
+- reg : Offset and length of the register set for the device
+- interrupts : Should contain the HSP interrupts
+- interrupt-names: Should contain the names of the HSP interrupts that the
+		   client are using.
+		   "doorbell"
+- nvidia,hsp-function : Specifies one of the HSP functions that the HSP unit
+			will be supported. The function ID can be found in the
+			header file <dt-bindings/mailbox/tegra-hsp.h>.
+- #mbox-cells : Should be 1. Specifies the HSP master that will be enabled of
+		the HSP client. The master ID constants can be found in the
+		header file <dt-bindings/mailbox/tegra-hsp.h>.
+
+Example:
+
+hsp_top: hsp at 3c00000 {
+	compatible = "nvidia,tegra186-hsp";
+	reg = <0x0 0x03c00000 0x0 0xa0000>;
+	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "doorbell";
+	nvidia,hsp-function = <HSP_DOORBELL>;
+	#mbox-cells = <1>;
+};
+
+bpmp at d0000000 {
+	...
+	mboxes = <&hsp_top HSP_DB_MASTER_BPMP>;
+	...
+};
diff --git a/include/dt-bindings/mailbox/tegra-hsp.h b/include/dt-bindings/mailbox/tegra-hsp.h
new file mode 100644
index 000000000000..720c66784b72
--- /dev/null
+++ b/include/dt-bindings/mailbox/tegra-hsp.h
@@ -0,0 +1,20 @@
+/*
+ * This header provides constants for binding nvidia,tegra<chip>-hsp.
+ *
+ * The number with HSP_DB_MASTER prefix indicates the bit that is
+ * associated with a master ID in the doorbell registers.
+ */
+
+
+#ifndef _DT_BINDINGS_MAILBOX_TEGRA186_HSP_H
+#define _DT_BINDINGS_MAILBOX_TEGRA186_HSP_H
+
+#define HSP_SHARED_MAILBOX		0
+#define HSP_SHARED_SEMAPHORE		1
+#define HSP_ARBITRATED_SEMAPHORE	2
+#define HSP_DOORBELL			3
+
+#define HSP_DB_MASTER_CCPLEX 17
+#define HSP_DB_MASTER_BPMP 19
+
+#endif	/* _DT_BINDINGS_MAILBOX_TEGRA186_HSP_H */
-- 
2.9.0
