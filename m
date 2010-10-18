From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 18 Oct 2010 13:50:29 +1300
Subject: [PATCH] EP93xx: Document DMA M2P API
Message-ID: <4CBB99D5.6070009@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for the EP93xx DMA memory to peripheral/peripheral to
memory API.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---

diff --git a/arch/arm/mach-ep93xx/include/mach/dma.h b/arch/arm/mach-ep93xx/include/mach/dma.h
index 3a5961d..66b1555 100644
--- a/arch/arm/mach-ep93xx/include/mach/dma.h
+++ b/arch/arm/mach-ep93xx/include/mach/dma.h
@@ -1,6 +1,11 @@
-/*
- * arch/arm/mach-ep93xx/include/mach/dma.h
- */
+/**
+ * EP93xx DMA M2P memory to peripheral and peripheral to memory engine
+ *
+ * DMA M2P channels are available for audio, UARTs and IrDA. See chapter 10 of
+ * the EP93xx users guide for full details on the DMA M2P engine.
+ * See sound/soc/ep93xx/ep93xx-pcm.c for an example use of the DMA M2P code.
+ *
+ */ 
 
 #ifndef __ASM_ARCH_DMA_H
 #define __ASM_ARCH_DMA_H
@@ -8,12 +13,29 @@
 #include <linux/list.h>
 #include <linux/types.h>
 
+/**
+ * Information about a buffer to be transferred using the DMA M2P engine
+ *
+ * @list: Entry in DMA buffer list
+ * @bus_addr: Physical address of the buffer
+ * @size: Size of the buffer in bytes
+ */
 struct ep93xx_dma_buffer {
 	struct list_head	list;
 	u32			bus_addr;
 	u16			size;
 };
 
+/**
+ * Information about a DMA M2P client
+ *
+ * @name: Unique name for this client
+ * @flags: Client flags
+ * @cookie: User data to pass to callback functions
+ * @buffer_started: Non NULL function to call when a transfer is started
+ * @buffer_finished: Non NULL function to call when a transfer is completed
+ * @channel: Internal DMA M2P channel pointer. Do not modify
+ */
 struct ep93xx_dma_m2p_client {
 	char			*name;
 	u8			flags;
@@ -28,6 +50,9 @@ struct ep93xx_dma_m2p_client {
 	void			*channel;
 };
 
+/**
+ * DMA M2P ports
+ */
 #define EP93XX_DMA_M2P_PORT_I2S1	0x00
 #define EP93XX_DMA_M2P_PORT_I2S2	0x01
 #define EP93XX_DMA_M2P_PORT_AAC1	0x02
@@ -39,18 +64,66 @@ struct ep93xx_dma_m2p_client {
 #define EP93XX_DMA_M2P_PORT_UART3	0x08
 #define EP93XX_DMA_M2P_PORT_IRDA	0x09
 #define EP93XX_DMA_M2P_PORT_MASK	0x0f
-#define EP93XX_DMA_M2P_TX		0x00
-#define EP93XX_DMA_M2P_RX		0x10
-#define EP93XX_DMA_M2P_ABORT_ON_ERROR	0x20
-#define EP93XX_DMA_M2P_IGNORE_ERROR	0x40
-#define EP93XX_DMA_M2P_ERROR_MASK	0x60
 
+/**
+ * DMA M2P client flags
+ */
+#define EP93XX_DMA_M2P_TX		0x00	/* Memory to peripheral */
+#define EP93XX_DMA_M2P_RX		0x10	/* Peripheral to memory */
+
+/**
+ * DMA M2P client error handling flags. See the EP93xx users guide
+ * documentation on the DMA M2P CONTROL register for more details
+ */
+#define EP93XX_DMA_M2P_ABORT_ON_ERROR	0x20	/* Abort on peripheral error */
+#define EP93XX_DMA_M2P_IGNORE_ERROR	0x40	/* Ignore peripheral errors */
+#define EP93XX_DMA_M2P_ERROR_MASK	0x60	/* Mask of error bits */
+
+/**
+ * Register a client with the DMA M2P subsystem. The DMA M2P subsystem
+ * allocates a channel and an interrupt line for the DMA client.
+ *
+ * @m2p: Client information to register
+ * returns 0 on success
+ */
 int  ep93xx_dma_m2p_client_register(struct ep93xx_dma_m2p_client *m2p);
+
+/**
+ * Unregister a DMA M2P subsystem. Any transfers currently in progress will be
+ * completed in hardware, but ignored in software.
+ *
+ * @m2p: Client to unregister
+ */
 void ep93xx_dma_m2p_client_unregister(struct ep93xx_dma_m2p_client *m2p);
+
+/**
+ * Submit a DMA M2P transfer. If the current or next transfer positions are
+ * free on the M2P client then the transfer is started immediately. If not,
+ * the transfer is added to the list of pending transfers. This function must
+ * not be called from the buffer_finished callback for an M2P channel.
+ *
+ * @m2p: DMA Client to submit the transfer on
+ * @buf: DMA Buffer to submit
+ */
 void ep93xx_dma_m2p_submit(struct ep93xx_dma_m2p_client *m2p,
 			   struct ep93xx_dma_buffer *buf);
+
+/**
+ * Put a DMA transfer on the pending list for an M2P channel. This function
+ * must only be called from the buffer_finished callback for an M2P channel.
+ *
+ * @m2p: DMA Client to submit the transfer on
+ * @buf: DMA Buffer to submit 
+ */
 void ep93xx_dma_m2p_submit_recursive(struct ep93xx_dma_m2p_client *m2p,
 				     struct ep93xx_dma_buffer *buf);
+
+/**
+ * Flush all pending transfers on a DMA M2P client. Any transfers currently
+ * in progress will be completed in hardware, but ignored in software.
+ *
+ * @m2p: DMA client to flush transfers on
+ */
 void ep93xx_dma_m2p_flush(struct ep93xx_dma_m2p_client *m2p);
 
 #endif /* __ASM_ARCH_DMA_H */
