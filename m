From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 16 May 2012 12:05:11 +0100
Subject: [PATCH 1/6] DMA: PL08x: move private data structures into amba-pl08x.c
In-Reply-To: <20120516110451.GA9571@n2100.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
Message-ID: <E1SUc2Z-0001md-KT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the driver private data structures into the driver itself, rather
than having them exposed to everyone in a header file.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   72 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/amba/pl08x.h |   74 +------------------------------------------
 2 files changed, 74 insertions(+), 72 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 3d704ab..492160b 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -90,6 +90,7 @@
 #define DRIVER_NAME	"pl08xdmac"
 
 static struct amba_driver pl08x_amba_driver;
+struct pl08x_driver_data;
 
 /**
  * struct vendor_data - vendor-specific config parameters for PL08x derivatives
@@ -115,6 +116,77 @@ struct pl08x_lli {
 };
 
 /**
+ * struct pl08x_bus_data - information of source or destination
+ * busses for a transfer
+ * @addr: current address
+ * @maxwidth: the maximum width of a transfer on this bus
+ * @buswidth: the width of this bus in bytes: 1, 2 or 4
+ */
+struct pl08x_bus_data {
+	dma_addr_t addr;
+	u8 maxwidth;
+	u8 buswidth;
+};
+
+/**
+ * struct pl08x_phy_chan - holder for the physical channels
+ * @id: physical index to this channel
+ * @lock: a lock to use when altering an instance of this struct
+ * @signal: the physical signal (aka channel) serving this physical channel
+ * right now
+ * @serving: the virtual channel currently being served by this physical
+ * channel
+ */
+struct pl08x_phy_chan {
+	unsigned int id;
+	void __iomem *base;
+	spinlock_t lock;
+	int signal;
+	struct pl08x_dma_chan *serving;
+};
+
+/**
+ * struct pl08x_sg - structure containing data per sg
+ * @src_addr: src address of sg
+ * @dst_addr: dst address of sg
+ * @len: transfer len in bytes
+ * @node: node for txd's dsg_list
+ */
+struct pl08x_sg {
+	dma_addr_t src_addr;
+	dma_addr_t dst_addr;
+	size_t len;
+	struct list_head node;
+};
+
+/**
+ * struct pl08x_txd - wrapper for struct dma_async_tx_descriptor
+ * @tx: async tx descriptor
+ * @node: node for txd list for channels
+ * @dsg_list: list of children sg's
+ * @direction: direction of transfer
+ * @llis_bus: DMA memory address (physical) start for the LLIs
+ * @llis_va: virtual memory address start for the LLIs
+ * @cctl: control reg values for current txd
+ * @ccfg: config reg values for current txd
+ */
+struct pl08x_txd {
+	struct dma_async_tx_descriptor tx;
+	struct list_head node;
+	struct list_head dsg_list;
+	enum dma_transfer_direction direction;
+	dma_addr_t llis_bus;
+	struct pl08x_lli *llis_va;
+	/* Default cctl value for LLIs */
+	u32 cctl;
+	/*
+	 * Settings to be put into the physical channel when we
+	 * trigger this txd.  Other registers are in llis_va[0].
+	 */
+	u32 ccfg;
+};
+
+/**
  * struct pl08x_driver_data - the local state holder for the PL08x
  * @slave: slave engine for this instance
  * @memcpy: memcpy engine for this instance
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index e64ce2c..ab3d846 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -21,8 +21,9 @@
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 
-struct pl08x_lli;
 struct pl08x_driver_data;
+struct pl08x_phy_chan;
+struct pl08x_txd;
 
 /* Bitmasks for selecting AHB ports for DMA transfers */
 enum {
@@ -72,77 +73,6 @@ struct pl08x_channel_data {
 };
 
 /**
- * Struct pl08x_bus_data - information of source or destination
- * busses for a transfer
- * @addr: current address
- * @maxwidth: the maximum width of a transfer on this bus
- * @buswidth: the width of this bus in bytes: 1, 2 or 4
- */
-struct pl08x_bus_data {
-	dma_addr_t addr;
-	u8 maxwidth;
-	u8 buswidth;
-};
-
-/**
- * struct pl08x_phy_chan - holder for the physical channels
- * @id: physical index to this channel
- * @lock: a lock to use when altering an instance of this struct
- * @signal: the physical signal (aka channel) serving this physical channel
- * right now
- * @serving: the virtual channel currently being served by this physical
- * channel
- */
-struct pl08x_phy_chan {
-	unsigned int id;
-	void __iomem *base;
-	spinlock_t lock;
-	int signal;
-	struct pl08x_dma_chan *serving;
-};
-
-/**
- * struct pl08x_sg - structure containing data per sg
- * @src_addr: src address of sg
- * @dst_addr: dst address of sg
- * @len: transfer len in bytes
- * @node: node for txd's dsg_list
- */
-struct pl08x_sg {
-	dma_addr_t src_addr;
-	dma_addr_t dst_addr;
-	size_t len;
-	struct list_head node;
-};
-
-/**
- * struct pl08x_txd - wrapper for struct dma_async_tx_descriptor
- * @tx: async tx descriptor
- * @node: node for txd list for channels
- * @dsg_list: list of children sg's
- * @direction: direction of transfer
- * @llis_bus: DMA memory address (physical) start for the LLIs
- * @llis_va: virtual memory address start for the LLIs
- * @cctl: control reg values for current txd
- * @ccfg: config reg values for current txd
- */
-struct pl08x_txd {
-	struct dma_async_tx_descriptor tx;
-	struct list_head node;
-	struct list_head dsg_list;
-	enum dma_transfer_direction direction;
-	dma_addr_t llis_bus;
-	struct pl08x_lli *llis_va;
-	/* Default cctl value for LLIs */
-	u32 cctl;
-	/*
-	 * Settings to be put into the physical channel when we
-	 * trigger this txd.  Other registers are in llis_va[0].
-	 */
-	u32 ccfg;
-};
-
-/**
  * struct pl08x_dma_chan_state - holds the PL08x specific virtual channel
  * states
  * @PL08X_CHAN_IDLE: the channel is idle
-- 
1.7.4.4
