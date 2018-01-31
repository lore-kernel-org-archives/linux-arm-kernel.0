From: houlong.wei@mediatek.com (houlong.wei at mediatek.com)
Date: Wed, 31 Jan 2018 15:28:10 +0800
Subject: [PATCH v21 1/4] dt-bindings: soc: Add documentation for the MediaTek
 GCE unit
In-Reply-To: <1517383693-25591-1-git-send-email-houlong.wei@mediatek.com>
References: <1517383693-25591-1-git-send-email-houlong.wei@mediatek.com>
Message-ID: <1517383693-25591-2-git-send-email-houlong.wei@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "hs.liao@mediatek.com" <hs.liao@mediatek.com>

This adds documentation for the MediaTek Global Command Engine (GCE) unit
found in MT8173 SoCs.

Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
Signed-off-by: HS Liao <hs.liao@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mailbox/mtk-gce.txt        |   43 ++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt

diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
new file mode 100644
index 0000000..d2d3ccb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
@@ -0,0 +1,43 @@
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
+- #mbox-cells: Should be 2
+
+Required properties for a client device:
+- mboxes: client use mailbox to communicate with GCE, it should have this
+  property and list of phandle, mailbox channel specifiers, and atomic
+  execution flag.
+
+Example:
+
+	gce: gce at 10212000 {
+		compatible = "mediatek,mt8173-gce";
+		reg = <0 0x10212000 0 0x1000>;
+		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_GCE>;
+		clock-names = "gce";
+
+		#mbox-cells = <2>;
+	};
+
+Example for a client device:
+
+	mmsys: clock-controller at 14000000 {
+		compatible = "mediatek,mt8173-mmsys";
+		mboxes = <&gce 0 1 /* main display with atomic execution */
+			  &gce 1 1>; /* sub display with atomic execution */
+		...
+	};
-- 
1.7.9.5
