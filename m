From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Tue,  7 Jul 2015 15:34:25 +0530
Subject: [PATCH] dmaengine: xgene-dma: Fix the resource map to handle
 overlapping
Message-ID: <1436263465-7677-1-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an overlap in dma ring cmd csr region due to sharing of ethernet
ring cmd csr region. This patch fix the resource overlapping by mapping
the entire dma ring cmd csr region.

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
---
 Documentation/devicetree/bindings/dma/apm-xgene-dma.txt | 2 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi                  | 2 +-
 drivers/dma/xgene-dma.c                                 | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/apm-xgene-dma.txt b/Documentation/devicetree/bindings/dma/apm-xgene-dma.txt
index d305876..c53e0b0 100644
--- a/Documentation/devicetree/bindings/dma/apm-xgene-dma.txt
+++ b/Documentation/devicetree/bindings/dma/apm-xgene-dma.txt
@@ -35,7 +35,7 @@ Example:
 			device_type = "dma";
 			reg = <0x0 0x1f270000 0x0 0x10000>,
 			      <0x0 0x1f200000 0x0 0x10000>,
-			      <0x0 0x1b008000 0x0 0x2000>,
+			      <0x0 0x1b000000 0x0 0x400000>,
 			      <0x0 0x1054a000 0x0 0x100>;
 			interrupts = <0x0 0x82 0x4>,
 				     <0x0 0xb8 0x4>,
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 0689c3f..58093ed 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -823,7 +823,7 @@
 			device_type = "dma";
 			reg = <0x0 0x1f270000 0x0 0x10000>,
 			      <0x0 0x1f200000 0x0 0x10000>,
-			      <0x0 0x1b008000 0x0 0x2000>,
+			      <0x0 0x1b000000 0x0 0x400000>,
 			      <0x0 0x1054a000 0x0 0x100>;
 			interrupts = <0x0 0x82 0x4>,
 				     <0x0 0xb8 0x4>,
diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index 620fd55ec..dff22ab 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -111,6 +111,7 @@
 #define XGENE_DMA_MEM_RAM_SHUTDOWN		0xD070
 #define XGENE_DMA_BLK_MEM_RDY			0xD074
 #define XGENE_DMA_BLK_MEM_RDY_VAL		0xFFFFFFFF
+#define XGENE_DMA_RING_CMD_SM_OFFSET		0x8000

 /* X-Gene SoC EFUSE csr register and bit defination */
 #define XGENE_SOC_JTAG1_SHADOW			0x18
@@ -1887,6 +1888,8 @@ static int xgene_dma_get_resources(struct platform_device *pdev,
 		return -ENOMEM;
 	}

+	pdma->csr_ring_cmd += XGENE_DMA_RING_CMD_SM_OFFSET;
+
 	/* Get efuse csr region */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
 	if (!res) {
--
1.8.2.1
