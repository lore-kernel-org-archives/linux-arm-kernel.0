From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 29 Jul 2013 17:05:10 +0200
Subject: [PATCH 2/2] dma: mv_xor: support big endian systems using descriptor
 swap feature
In-Reply-To: <1375110310-26276-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375110310-26276-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375110310-26276-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mv_xor driver had never been used in a big-endian context, and
therefore was not using the hardware features to support such an
execution environment. The hardware provides a "descriptor swap" bit
that automatically swaps the bytes of the DMA descriptors, within
blocks of 8 bytes. This requires a different DMA descriptor layout on
big-endian systems, as well as enabling this "descriptor swap" bit.

This mechanism is exactly identical to the one already used in the
mv643xx_eth network driver and the mvneta network driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c | 11 +++++++++--
 drivers/dma/mv_xor.h | 28 +++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index e98966a..fc4d0e9 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -64,7 +64,7 @@ static u32 mv_desc_get_src_addr(struct mv_xor_desc_slot *desc,
 				int src_idx)
 {
 	struct mv_xor_desc *hw_desc = desc->hw_desc;
-	return hw_desc->phy_src_addr[src_idx];
+	return hw_desc->phy_src_addr[mv_phy_src_idx(src_idx)];
 }
 
 
@@ -107,7 +107,7 @@ static void mv_desc_set_src_addr(struct mv_xor_desc_slot *desc,
 				 int index, dma_addr_t addr)
 {
 	struct mv_xor_desc *hw_desc = desc->hw_desc;
-	hw_desc->phy_src_addr[index] = addr;
+	hw_desc->phy_src_addr[mv_phy_src_idx(index)] = addr;
 	if (desc->type == DMA_XOR)
 		hw_desc->desc_command |= (1 << index);
 }
@@ -192,6 +192,13 @@ static void mv_set_mode(struct mv_xor_chan *chan,
 
 	config &= ~0x7;
 	config |= op_mode;
+
+#if defined(__BIG_ENDIAN)
+	config |= XOR_DESCRIPTOR_SWAP;
+#else
+	config &= ~XOR_DESCRIPTOR_SWAP;
+#endif
+
 	writel(config, XOR_CONFIG(chan));
 	chan->current_type = type;
 }
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index c619359..06b067f 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -29,8 +29,10 @@
 #define MV_XOR_THRESHOLD		1
 #define MV_XOR_MAX_CHANNELS             2
 
+/* Values for the XOR_CONFIG register */
 #define XOR_OPERATION_MODE_XOR		0
 #define XOR_OPERATION_MODE_MEMCPY	2
+#define XOR_DESCRIPTOR_SWAP		BIT(14)
 
 #define XOR_CURR_DESC(chan)	(chan->mmr_base + 0x210 + (chan->idx * 4))
 #define XOR_NEXT_DESC(chan)	(chan->mmr_base + 0x200 + (chan->idx * 4))
@@ -143,7 +145,16 @@ struct mv_xor_desc_slot {
 #endif
 };
 
-/* This structure describes XOR descriptor size 64bytes	*/
+/*
+ * This structure describes XOR descriptor size 64bytes. The
+ * mv_phy_src_idx() macro must be used when indexing the values of the
+ * phy_src_addr[] array. This is due to the fact that the 'descriptor
+ * swap' feature, used on big endian systems, swaps descriptors data
+ * within blocks of 8 bytes. So two consecutive values of the
+ * phy_src_addr[] array are actually swapped in big-endian, which
+ * explains the different mv_phy_src_idx() implementation.
+ */
+#if defined(__LITTLE_ENDIAN)
 struct mv_xor_desc {
 	u32 status;		/* descriptor execution status */
 	u32 crc32_result;	/* result of CRC-32 calculation */
@@ -155,6 +166,21 @@ struct mv_xor_desc {
 	u32 reserved0;
 	u32 reserved1;
 };
+#define mv_phy_src_idx(src_idx) (src_idx)
+#else
+struct mv_xor_desc {
+	u32 crc32_result;	/* result of CRC-32 calculation */
+	u32 status;		/* descriptor execution status */
+	u32 phy_next_desc;	/* next descriptor address pointer */
+	u32 desc_command;	/* type of operation to be carried out */
+	u32 phy_dest_addr;	/* destination block address */
+	u32 byte_count;		/* size of src/dst blocks in bytes */
+	u32 phy_src_addr[8];	/* source block addresses */
+	u32 reserved1;
+	u32 reserved0;
+};
+#define mv_phy_src_idx(src_idx) (src_idx ^ 1)
+#endif
 
 #define to_mv_sw_desc(addr_hw_desc)		\
 	container_of(addr_hw_desc, struct mv_xor_desc_slot, hw_desc)
-- 
1.8.1.2
