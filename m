From: elen.song@atmel.com (Elen Song)
Date: Tue, 9 Jul 2013 14:33:46 +0800
Subject: [PATCH 7/7] serial: at91: add dma support in usart binding
 descriptions
In-Reply-To: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
References: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
Message-ID: <1373351626-30143-8-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 .../devicetree/bindings/tty/serial/atmel-usart.txt |   21 +++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt b/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
index 82f45ec..fb50023 100644
--- a/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
@@ -8,15 +8,21 @@ Required properties:
 - interrupts: Should contain interrupt
 
 Optional properties:
-- atmel,use-pdc-rx: use of PDC for receiving data
-- atmel,use-pdc-tx: use of PDC for transmitting data
+- for those only support PDC transfer socs:
+	- atmel,use-pdc-rx: use of PDC for receiving data
+	- atmel,use-pdc-tx: use of PDC for transmitting data
+- for those only support DMA transfer socs:
+	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
+	  memory peripheral interface and USART DMA channel ID, FIFO configuration.
+	  Refer to dma.txt and atmel-dma.txt for details.
+	- dma-names: "rx" for RX channel, "tx" for TX channel.
 
 <chip> compatible description:
 - at91rm9200:  legacy USART support
 - at91sam9260: generic USART implementation for SAM9 SoCs
 
 Example:
-
+- use PDC:
 	usart0: serial at fff8c000 {
 		compatible = "atmel,at91sam9260-usart";
 		reg = <0xfff8c000 0x200>;
@@ -25,3 +31,12 @@ Example:
 		atmel,use-pdc-tx;
 	};
 
+- use DMA:
+	usart0: serial at f001c000 {
+		compatible = "atmel,at91sam9260-usart";
+		reg = <0xf001c000 0x100>;
+		interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
+		dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
+		       <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+		dma-names = "tx", "rx";
+	};
-- 
1.7.9.5
