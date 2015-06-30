From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Jun 2015 16:36:54 +0200
Subject: [PATCH v3 3/6] dmaengine: mv_xor: remove support for dmacap,
 * DT properties
In-Reply-To: <1435675017-875-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1435675017-875-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1435675017-875-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only reason why we had dmacap,* properties is because back when
DMA_MEMSET was supported, only one out of the two channels per engine
could do a memset operation. But this is something that the driver
already knows anyway, and since then, the DMA_MEMSET support has been
removed.

The driver is already well aware of what each channel supports and the
one to one mapping between Linux specific implementation details (such
as dmacap,interrupt enabling DMA_INTERRUPT) and DT properties is a
good indication that these DT properties are wrong.

Therefore, this commit simply gets rid of these dmacap,* properties,
they are now ignored, and the driver is responsible for knowing the
capabilities of the hardware with regard to the dmaengine subsystem
expectations.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/dma/mv-xor.txt | 10 ++++------
 drivers/dma/mv_xor.c                             |  9 +++------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/mv-xor.txt b/Documentation/devicetree/bindings/dma/mv-xor.txt
index cc29c35..276ef81 100644
--- a/Documentation/devicetree/bindings/dma/mv-xor.txt
+++ b/Documentation/devicetree/bindings/dma/mv-xor.txt
@@ -12,10 +12,13 @@ XOR engine has. Those sub-nodes have the following required
 properties:
 - interrupts: interrupt of the XOR channel
 
-And the following optional properties:
+The sub-nodes used to contain one or several of the following
+properties, but they are now deprecated:
 - dmacap,memcpy to indicate that the XOR channel is capable of memcpy operations
 - dmacap,memset to indicate that the XOR channel is capable of memset operations
 - dmacap,xor to indicate that the XOR channel is capable of xor operations
+- dmacap,interrupt to indicate that the XOR channel is capable of
+  generating interrupts
 
 Example:
 
@@ -28,13 +31,8 @@ xor at d0060900 {
 
 	xor00 {
 	      interrupts = <51>;
-	      dmacap,memcpy;
-	      dmacap,xor;
 	};
 	xor01 {
 	      interrupts = <52>;
-	      dmacap,memcpy;
-	      dmacap,xor;
-	      dmacap,memset;
 	};
 };
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 0a3ddc2..6aedc36 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1236,12 +1236,9 @@ static int mv_xor_probe(struct platform_device *pdev)
 			op_in_desc = (int)of_id->data;
 
 			dma_cap_zero(cap_mask);
-			if (of_property_read_bool(np, "dmacap,memcpy"))
-				dma_cap_set(DMA_MEMCPY, cap_mask);
-			if (of_property_read_bool(np, "dmacap,xor"))
-				dma_cap_set(DMA_XOR, cap_mask);
-			if (of_property_read_bool(np, "dmacap,interrupt"))
-				dma_cap_set(DMA_INTERRUPT, cap_mask);
+			dma_cap_set(DMA_MEMCPY, cap_mask);
+			dma_cap_set(DMA_XOR, cap_mask);
+			dma_cap_set(DMA_INTERRUPT, cap_mask);
 
 			irq = irq_of_parse_and_map(np, 0);
 			if (!irq) {
-- 
2.4.5
