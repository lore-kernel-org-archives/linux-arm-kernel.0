From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu, 17 Mar 2016 15:24:31 +0000
Subject: [PATCH 1/3] dt/bindings: bcm2835: add interrupt-names property
In-Reply-To: <1458228273-15591-1-git-send-email-kernel@martin.sperl.org>
References: <1458228273-15591-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1458228273-15591-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Added standard interrupt-names property so that
platform_get_irq_byname() can get used to fetch the
interrupt corresponding to each dma_channel
instead of the current platform_get_irq() with
an assumed ordering of the interrupts.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 .../devicetree/bindings/dma/brcm,bcm2835-dma.txt   | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
index 1396078..3035654 100644
--- a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
+++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
@@ -12,6 +12,8 @@ Required properties:
 - reg: Should contain DMA registers location and length.
 - interrupts: Should contain the DMA interrupts associated
 		to the DMA channels in ascending order.
+- interrupt-names: Should contain the names of the interrupt
+		   in the form "dmaXX".
 - #dma-cells: Must be <1>, the cell in the dmas property of the
 		client device represents the DREQ number.
 - brcm,dma-channel-mask: Bit mask representing the channels
@@ -34,13 +36,35 @@ dma: dma at 7e007000 {
 		     <1 24>,
 		     <1 25>,
 		     <1 26>,
+		     /* dma channel 11-14 share one irq */
 		     <1 27>,
+		     <1 27>,
+		     <1 27>,
+		     <1 27>,
+		     /* unused shared irq for all channels */
 		     <1 28>;
+	interrupt-names = "dma0",
+			  "dma1",
+			  "dma2",
+			  "dma3",
+			  "dma4",
+			  "dma5",
+			  "dma6",
+			  "dma7",
+			  "dma8",
+			  "dma9",
+			  "dma10",
+			  "dma11",
+			  "dma12",
+			  "dma13",
+			  "dma14",
+			  "dma-shared-all";
 
 	#dma-cells = <1>;
 	brcm,dma-channel-mask = <0x7f35>;
 };
 
+
 DMA clients connected to the BCM2835 DMA controller must use the format
 described in the dma.txt file, using a two-cell specifier for each channel.
 
-- 
2.1.4
