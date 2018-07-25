From: houlong.wei@mediatek.com (Houlong Wei)
Date: Wed, 25 Jul 2018 09:26:39 +0800
Subject: [PATCH v23 1/4] dt-bindings: soc: Add documentation for the MediaTek
 GCE unit
In-Reply-To: <1532482002-11164-1-git-send-email-houlong.wei@mediatek.com>
References: <1532482002-11164-1-git-send-email-houlong.wei@mediatek.com>
Message-ID: <1532482002-11164-2-git-send-email-houlong.wei@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation for the MediaTek Global Command Engine (GCE) unit
found in MT8173 SoCs.

Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 .../devicetree/bindings/mailbox/mtk-gce.txt        |   57 ++++++++++++++++++++
 include/dt-bindings/gce/mt8173-gce.h               |   44 +++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
 create mode 100644 include/dt-bindings/gce/mt8173-gce.h

diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
new file mode 100644
index 0000000..7d72b21
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
@@ -0,0 +1,57 @@
+MediaTek GCE
+===============
+
+The Global Command Engine (GCE) is used to help read/write registers with
+critical time limitation, such as updating display configuration during the
+vblank. The GCE can be used to implement the Command Queue (CMDQ) driver.
+
+CMDQ driver uses mailbox framework for communication. Please refer to
+mailbox.txt for generic information about mailbox device-tree bindings.
+
+Required properties:
+- compatible: Must be "mediatek,mt8173-gce"
+- reg: Address range of the GCE unit
+- interrupts: The interrupt signal from the GCE block
+- clock: Clocks according to the common clock binding
+- clock-names: Must be "gce" to stand for GCE clock
+- #mbox-cells: Should be 3.
+	<&phandle channel priority atomic_exec>
+	phandle: Label name of a gce node.
+	channel: Channel of mailbox. Be equal to the thread id of GCE.
+	priority: Priority of GCE thread.
+	atomic_exec: GCE processing continuous packets of commands in atomic
+		way.
+
+Required properties for a client device:
+- mboxes: Client use mailbox to communicate with GCE, it should have this
+  property and list of phandle, mailbox specifiers.
+- mediatek,gce-subsys: u32, specify the sub-system id which is corresponding
+  to the register address.
+
+Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'. Such as
+sub-system ids, thread priority, event ids.
+
+Example:
+
+	gce: gce at 10212000 {
+		compatible = "mediatek,mt8173-gce";
+		reg = <0 0x10212000 0 0x1000>;
+		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_GCE>;
+		clock-names = "gce";
+		thread-num = CMDQ_THR_MAX_COUNT;
+		#mbox-cells = <3>;
+	};
+
+Example for a client device:
+
+	mmsys: clock-controller at 14000000 {
+		compatible = "mediatek,mt8173-mmsys";
+		mboxes = <&gce 0 CMDQ_THR_PRIO_LOWEST 1>,
+			 <&gce 1 CMDQ_THR_PRIO_LOWEST 1>;
+		mediatek,gce-subsys = <SUBSYS_1400XXXX>;
+		mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
+				CMDQ_EVENT_MUTEX1_STREAM_EOF>;
+
+		...
+	};
diff --git a/include/dt-bindings/gce/mt8173-gce.h b/include/dt-bindings/gce/mt8173-gce.h
new file mode 100644
index 0000000..ffcf94b
--- /dev/null
+++ b/include/dt-bindings/gce/mt8173-gce.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Houlong Wei <houlong.wei@mediatek.com>
+ *
+ */
+
+#ifndef _DT_BINDINGS_GCE_MT8173_H
+#define _DT_BINDINGS_GCE_MT8173_H
+
+/* GCE HW thread priority */
+#define CMDQ_THR_PRIO_LOWEST	0
+#define CMDQ_THR_PRIO_HIGHEST	1
+
+/* GCE SUBSYS */
+#define SUBSYS_1400XXXX		1
+#define SUBSYS_1401XXXX		2
+#define SUBSYS_1402XXXX		3
+
+/* GCE HW EVENT */
+#define CMDQ_EVENT_DISP_OVL0_SOF		11
+#define CMDQ_EVENT_DISP_OVL1_SOF		12
+#define CMDQ_EVENT_DISP_RDMA0_SOF		13
+#define CMDQ_EVENT_DISP_RDMA1_SOF		14
+#define CMDQ_EVENT_DISP_RDMA2_SOF		15
+#define CMDQ_EVENT_DISP_WDMA0_SOF		16
+#define CMDQ_EVENT_DISP_WDMA1_SOF		17
+#define CMDQ_EVENT_DISP_OVL0_EOF		39
+#define CMDQ_EVENT_DISP_OVL1_EOF		40
+#define CMDQ_EVENT_DISP_RDMA0_EOF		41
+#define CMDQ_EVENT_DISP_RDMA1_EOF		42
+#define CMDQ_EVENT_DISP_RDMA2_EOF		43
+#define CMDQ_EVENT_DISP_WDMA0_EOF		44
+#define CMDQ_EVENT_DISP_WDMA1_EOF		45
+#define CMDQ_EVENT_MUTEX0_STREAM_EOF		53
+#define CMDQ_EVENT_MUTEX1_STREAM_EOF		54
+#define CMDQ_EVENT_MUTEX2_STREAM_EOF		55
+#define CMDQ_EVENT_MUTEX3_STREAM_EOF		56
+#define CMDQ_EVENT_MUTEX4_STREAM_EOF		57
+#define CMDQ_EVENT_DISP_RDMA0_UNDERRUN		63
+#define CMDQ_EVENT_DISP_RDMA1_UNDERRUN		64
+#define CMDQ_EVENT_DISP_RDMA2_UNDERRUN		65
+
+#endif
-- 
1.7.9.5
