From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 20 Oct 2010 08:52:18 +1300
Subject: [PATCH] EP93xx: Document DMA M2P API
In-Reply-To: <20101018074335.GD4772@gw.healthdatacare.com>
References: <4CBB99D5.6070009@bluewatersys.com>
	<20101018074335.GD4772@gw.healthdatacare.com>
Message-ID: <4CBDF6F2.7070808@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2010 08:43 PM, Mika Westerberg wrote:
> On Mon, Oct 18, 2010 at 01:50:29PM +1300, Ryan Mallon wrote:
>   
>> Add documentation for the EP93xx DMA memory to peripheral/peripheral to
>> memory API.
>>     
> This is a good thing but I think that you might want to use standard
> kernel-doc style comments (see Documentation/kernel-doc-nano-HOWTO.txt)
> so that we can get nicely formatted document of the DMA API when
> 'make *docs' is run.
>   

Here is the updated patch which uses proper kernel-doc formatting. I
have also expanded the documentation in a couple of places.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---

diff --git a/arch/arm/mach-ep93xx/include/mach/dma.h b/arch/arm/mach-ep93xx/include/mach/dma.h
index 3a5961d..a917a5b 100644
--- a/arch/arm/mach-ep93xx/include/mach/dma.h
+++ b/arch/arm/mach-ep93xx/include/mach/dma.h
@@ -1,6 +1,14 @@
-/*
- * arch/arm/mach-ep93xx/include/mach/dma.h
- */
+/**
+ * DOC: EP93xx DMA M2P memory to peripheral and peripheral to memory engine
+ *
+ * The EP93xx DMA M2P subsystem handles DMA transfers between memory and
+ * peripherals. DMA M2P channels are available for audio, UARTs and IrDA.
+ * See chapter 10 of the EP93xx users guide for full details on the DMA M2P
+ * engine.
+ *
+ * See sound/soc/ep93xx/ep93xx-pcm.c for an example use of the DMA M2P code.
+ *
+ */ 
 
 #ifndef __ASM_ARCH_DMA_H
 #define __ASM_ARCH_DMA_H
@@ -8,12 +16,34 @@
 #include <linux/list.h>
 #include <linux/types.h>
 
+/**
+ * struct ep93xx_dma_buffer - Information about a buffer to be transferred
+ * using the DMA M2P engine
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
+ * struct ep93xx_dma_m2p_client - Information about a DMA M2P client
+ *
+ * @name: Unique name for this client
+ * @flags: Client flags
+ * @cookie: User data to pass to callback functions
+ * @buffer_started: Non NULL function to call when a transfer is started.
+ * 			The arguments are the user data cookie and the DMA
+ *			buffer which is starting.
+ * @buffer_finished: Non NULL function to call when a transfer is completed.
+ *			The arguments are the user data cookie, the DMA buffer
+ *			which has completed, and a boolean flag indicating if
+ *			the transfer had an error.
+ */
 struct ep93xx_dma_m2p_client {
 	char			*name;
 	u8			flags;
@@ -24,10 +54,11 @@ struct ep93xx_dma_m2p_client {
 					struct ep93xx_dma_buffer *buf,
 					int bytes, int error);
 
-	/* Internal to the DMA code.  */
+	/* private: Internal use only */
 	void			*channel;
 };
 
+/* DMA M2P ports */
 #define EP93XX_DMA_M2P_PORT_I2S1	0x00
 #define EP93XX_DMA_M2P_PORT_I2S2	0x01
 #define EP93XX_DMA_M2P_PORT_AAC1	0x02
@@ -39,18 +70,80 @@ struct ep93xx_dma_m2p_client {
 #define EP93XX_DMA_M2P_PORT_UART3	0x08
 #define EP93XX_DMA_M2P_PORT_IRDA	0x09
 #define EP93XX_DMA_M2P_PORT_MASK	0x0f
-#define EP93XX_DMA_M2P_TX		0x00
-#define EP93XX_DMA_M2P_RX		0x10
-#define EP93XX_DMA_M2P_ABORT_ON_ERROR	0x20
-#define EP93XX_DMA_M2P_IGNORE_ERROR	0x40
-#define EP93XX_DMA_M2P_ERROR_MASK	0x60
 
-int  ep93xx_dma_m2p_client_register(struct ep93xx_dma_m2p_client *m2p);
+/* DMA M2P client flags */
+#define EP93XX_DMA_M2P_TX		0x00	/* Memory to peripheral */
+#define EP93XX_DMA_M2P_RX		0x10	/* Peripheral to memory */
+
+/*
+ * DMA M2P client error handling flags. See the EP93xx users guide
+ * documentation on the DMA M2P CONTROL register for more details
+ */
+#define EP93XX_DMA_M2P_ABORT_ON_ERROR	0x20	/* Abort on peripheral error */
+#define EP93XX_DMA_M2P_IGNORE_ERROR	0x40	/* Ignore peripheral errors */
+#define EP93XX_DMA_M2P_ERROR_MASK	0x60	/* Mask of error bits */
+
+/**
+ * ep93xx_dma_m2p_client_register - Register a client with the DMA M2P
+ * subsystem
+ *
+ * @m2p: Client information to register
+ * returns 0 on success
+ *
+ * The DMA M2P subsystem allocates a channel and an interrupt line for the DMA
+ * client
+ */
+int ep93xx_dma_m2p_client_register(struct ep93xx_dma_m2p_client *m2p);
+
+/**
+ * ep93xx_dma_m2p_client_unregister - Unregister a client from the DMA M2P
+ * subsystem
+ *
+ * @m2p: Client to unregister
+ *
+ * Any transfers currently in progress will be completed in hardware, but
+ * ignored in software.
+ */
 void ep93xx_dma_m2p_client_unregister(struct ep93xx_dma_m2p_client *m2p);
+
+/**
+ * ep93xx_dma_m2p_submit - Submit a DMA M2P transfer
+ *
+ * @m2p: DMA Client to submit the transfer on
+ * @buf: DMA Buffer to submit
+ *
+ * If the current or next transfer positions are free on the M2P client then
+ * the transfer is started immediately. If not, the transfer is added to the
+ * list of pending transfers. This function must not be called from the
+ * buffer_finished callback for an M2P channel.
+ * 
+ */
 void ep93xx_dma_m2p_submit(struct ep93xx_dma_m2p_client *m2p,
 			   struct ep93xx_dma_buffer *buf);
+
+/**
+ * ep93xx_dma_m2p_submit_recursive - Put a DMA transfer on the pending list
+ * for an M2P channel
+ *
+ * @m2p: DMA Client to submit the transfer on
+ * @buf: DMA Buffer to submit 
+ *
+ * This function must only be called from the buffer_finished callback for an
+ * M2P channel. It is commonly used to add the next transfer in a chained list
+ * of DMA transfers.
+ */
 void ep93xx_dma_m2p_submit_recursive(struct ep93xx_dma_m2p_client *m2p,
 				     struct ep93xx_dma_buffer *buf);
+
+/**
+ * ep93xx_dma_m2p_flush - Flush all pending transfers on a DMA M2P client
+ *
+ * @m2p: DMA client to flush transfers on
+ *
+ * Any transfers currently in progress will be completed in hardware, but
+ * ignored in software.
+ *
+ */
 void ep93xx_dma_m2p_flush(struct ep93xx_dma_m2p_client *m2p);
 
 #endif /* __ASM_ARCH_DMA_H */
