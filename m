From: radu_nicolae.pirea@upb.ro (Radu Pirea)
Date: Wed, 21 Nov 2018 13:27:31 +0200
Subject: [PATCH 2/3] dt-bindings: mfd: atmel-usart: add DMA bindings for SPI
 mode
In-Reply-To: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
Message-ID: <20181121112732.15690-3-radu_nicolae.pirea@upb.ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bindings for DMA are now common for both drivers of the USART
IP.

The node given as an example for USART in SPI mode has been updated in
order to include DMA bindings.

Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
---
 .../devicetree/bindings/mfd/atmel-usart.txt       | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
index 7f0cd72f47d2..8ad008175343 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
@@ -17,17 +17,19 @@ Required properties for USART in SPI mode:
 - cs-gpios: chipselects (internal cs not supported)
 - atmel,usart-mode : Must be <AT91_USART_MODE_SPI> (found in dt-bindings/mfd/at91-usart.h)
 
+Optional properties in serial and SPI mode:
+- dma bindings for dma transfer:
+	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
+		memory peripheral interface and USART DMA channel ID, FIFO configuration.
+		Refer to dma.txt and atmel-dma.txt for details.
+	- dma-names: "rx" for RX channel, "tx" for TX channel.
+
 Optional properties in serial mode:
 - atmel,use-dma-rx: use of PDC or DMA for receiving data
 - atmel,use-dma-tx: use of PDC or DMA for transmitting data
 - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD line respectively.
   It will use specified PIO instead of the peripheral function pin for the USART feature.
   If unsure, don't specify this property.
-- add dma bindings for dma transfer:
-	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
-		memory peripheral interface and USART DMA channel ID, FIFO configuration.
-		Refer to dma.txt and atmel-dma.txt for details.
-	- dma-names: "rx" for RX channel, "tx" for TX channel.
 - atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
   capable USARTs.
 - rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
@@ -81,5 +83,8 @@ Example:
 		interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
 		clocks = <&usart0_clk>;
 		clock-names = "usart";
+		dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
+		       <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+		dma-names = "tx", "rx";
 		cs-gpios = <&pioB 3 0>;
 	};
-- 
2.19.1
