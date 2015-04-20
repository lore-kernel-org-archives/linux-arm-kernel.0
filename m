From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Mon, 20 Apr 2015 16:23:58 +0530
Subject: [PATCH v4] dmaengine: xgene-dma: Fix sparse wannings and coccinelle
 warnings
Message-ID: <1429527238-17440-1-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v4 changes:
	* Re-generate patch on top of latest for-linux git

v3 changes:
	* Minor changes in length setting in DMA descriptor

v2 changes:
	* Code cleanup
	* Changed way of setting DMA descriptors for big-endian

This patch fixes compilation sparse warnings like incorrect type in assignment
(different base types), cast to restricted __le64, symbol
'__UNIQUE_ID_author__COUNTER__' has multiple initializers etc and
coccinelle warnings (No need to set .owner here. The core will do it.)

This patch is based on slave-dma / for-linus branch.
(commit: 9f2fd0dfa594d857fbdaeda523ff7a46f16567f5 [26/28]
	dmaengine: Add support for APM X-Gene SoC DMA engine driver)

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
---
 drivers/dma/xgene-dma.c | 161 ++++++++++++++++++------------------------------
 1 file changed, 61 insertions(+), 100 deletions(-)

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index f52e3750..063c835 100755
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -127,29 +127,6 @@
 #define XGENE_DMA_DESC_FLYBY_POS		4
 #define XGENE_DMA_DESC_BUFLEN_POS		48
 #define XGENE_DMA_DESC_HOENQ_NUM_POS		48
-
-#define XGENE_DMA_DESC_NV_SET(m)		\
-	(((u64 *)(m))[0] |= XGENE_DMA_DESC_NV_BIT)
-#define XGENE_DMA_DESC_IN_SET(m)		\
-	(((u64 *)(m))[0] |= XGENE_DMA_DESC_IN_BIT)
-#define XGENE_DMA_DESC_RTYPE_SET(m, v)		\
-	(((u64 *)(m))[0] |= ((u64)(v) << XGENE_DMA_DESC_RTYPE_POS))
-#define XGENE_DMA_DESC_BUFADDR_SET(m, v)	\
-	(((u64 *)(m))[0] |= (v))
-#define XGENE_DMA_DESC_BUFLEN_SET(m, v)		\
-	(((u64 *)(m))[0] |= ((u64)(v) << XGENE_DMA_DESC_BUFLEN_POS))
-#define XGENE_DMA_DESC_C_SET(m)			\
-	(((u64 *)(m))[1] |= XGENE_DMA_DESC_C_BIT)
-#define XGENE_DMA_DESC_FLYBY_SET(m, v)		\
-	(((u64 *)(m))[2] |= ((v) << XGENE_DMA_DESC_FLYBY_POS))
-#define XGENE_DMA_DESC_MULTI_SET(m, v, i)	\
-	(((u64 *)(m))[2] |= ((u64)(v) << (((i) + 1) * 8)))
-#define XGENE_DMA_DESC_DR_SET(m)		\
-	(((u64 *)(m))[2] |= XGENE_DMA_DESC_DR_BIT)
-#define XGENE_DMA_DESC_DST_ADDR_SET(m, v)	\
-	(((u64 *)(m))[3] |= (v))
-#define XGENE_DMA_DESC_H0ENQ_NUM_SET(m, v)	\
-	(((u64 *)(m))[3] |= ((u64)(v) << XGENE_DMA_DESC_HOENQ_NUM_POS))
 #define XGENE_DMA_DESC_ELERR_RD(m)		\
 	(((m) >> XGENE_DMA_DESC_ELERR_POS) & 0x3)
 #define XGENE_DMA_DESC_LERR_RD(m)		\
@@ -158,14 +135,7 @@
 	(((elerr) << 4) | (lerr))

 /* X-Gene DMA descriptor empty s/w signature */
-#define XGENE_DMA_DESC_EMPTY_INDEX		0
 #define XGENE_DMA_DESC_EMPTY_SIGNATURE		~0ULL
-#define XGENE_DMA_DESC_SET_EMPTY(m)		\
-	(((u64 *)(m))[XGENE_DMA_DESC_EMPTY_INDEX] =	\
-	 XGENE_DMA_DESC_EMPTY_SIGNATURE)
-#define XGENE_DMA_DESC_IS_EMPTY(m)		\
-	(((u64 *)(m))[XGENE_DMA_DESC_EMPTY_INDEX] ==	\
-	 XGENE_DMA_DESC_EMPTY_SIGNATURE)

 /* X-Gene DMA configurable parameters defines */
 #define XGENE_DMA_RING_NUM		512
@@ -238,10 +208,10 @@
 	dev_err(chan->dev, "%s: " fmt, chan->name, ##arg)

 struct xgene_dma_desc_hw {
-	u64 m0;
-	u64 m1;
-	u64 m2;
-	u64 m3;
+	__le64 m0;
+	__le64 m1;
+	__le64 m2;
+	__le64 m3;
 };

 enum xgene_dma_ring_cfgsize {
@@ -388,14 +358,6 @@ static bool is_pq_enabled(struct xgene_dma *pdma)
 	return !(val & XGENE_DMA_PQ_DISABLE_MASK);
 }

-static void xgene_dma_cpu_to_le64(u64 *desc, int count)
-{
-	int i;
-
-	for (i = 0; i < count; i++)
-		desc[i] = cpu_to_le64(desc[i]);
-}
-
 static u16 xgene_dma_encode_len(u32 len)
 {
 	return (len < XGENE_DMA_MAX_BYTE_CNT) ?
@@ -424,34 +386,52 @@ static u32 xgene_dma_ring_desc_cnt(struct xgene_dma_ring *ring)
 	return XGENE_DMA_RING_DESC_CNT(ring_state);
 }

-static void xgene_dma_set_src_buffer(void *ext8, size_t *len,
+static void xgene_dma_set_src_buffer(__le64 *ext8, size_t *len,
 				     dma_addr_t *paddr)
 {
 	size_t nbytes = (*len < XGENE_DMA_MAX_BYTE_CNT) ?
 			*len : XGENE_DMA_MAX_BYTE_CNT;

-	XGENE_DMA_DESC_BUFADDR_SET(ext8, *paddr);
-	XGENE_DMA_DESC_BUFLEN_SET(ext8, xgene_dma_encode_len(nbytes));
+	*ext8 |= cpu_to_le64(*paddr);
+	*ext8 |= cpu_to_le64((u64)xgene_dma_encode_len(nbytes) <<
+			     XGENE_DMA_DESC_BUFLEN_POS);
 	*len -= nbytes;
 	*paddr += nbytes;
 }

-static void xgene_dma_invalidate_buffer(void *ext8)
+static void xgene_dma_invalidate_buffer(__le64 *ext8)
 {
-	XGENE_DMA_DESC_BUFLEN_SET(ext8, XGENE_DMA_INVALID_LEN_CODE);
+	*ext8 |= cpu_to_le64((u64)XGENE_DMA_INVALID_LEN_CODE <<
+			     XGENE_DMA_DESC_BUFLEN_POS);
 }

-static void *xgene_dma_lookup_ext8(u64 *desc, int idx)
+static __le64 *xgene_dma_lookup_ext8(struct xgene_dma_desc_hw *desc, int idx)
 {
-	return (idx % 2) ? (desc + idx - 1) : (desc + idx + 1);
+	switch (idx) {
+	case 0:
+		return &desc->m1;
+	case 1:
+		return &desc->m0;
+	case 2:
+		return &desc->m3;
+	case 3:
+		return &desc->m2;
+	default:
+		pr_err("Invalid dma descriptor index\n");
+	}
+
+	return NULL;
 }

-static void xgene_dma_init_desc(void *desc, u16 dst_ring_num)
+static void xgene_dma_init_desc(struct xgene_dma_desc_hw *desc,
+				u16 dst_ring_num)
 {
-	XGENE_DMA_DESC_C_SET(desc); /* Coherent IO */
-	XGENE_DMA_DESC_IN_SET(desc);
-	XGENE_DMA_DESC_H0ENQ_NUM_SET(desc, dst_ring_num);
-	XGENE_DMA_DESC_RTYPE_SET(desc, XGENE_DMA_RING_OWNER_DMA);
+	desc->m0 |= cpu_to_le64(XGENE_DMA_DESC_IN_BIT);
+	desc->m0 |= cpu_to_le64((u64)XGENE_DMA_RING_OWNER_DMA <<
+				XGENE_DMA_DESC_RTYPE_POS);
+	desc->m1 |= cpu_to_le64(XGENE_DMA_DESC_C_BIT);
+	desc->m3 |= cpu_to_le64((u64)dst_ring_num <<
+				XGENE_DMA_DESC_HOENQ_NUM_POS);
 }

 static void xgene_dma_prep_cpy_desc(struct xgene_dma_chan *chan,
@@ -459,7 +439,7 @@ static void xgene_dma_prep_cpy_desc(struct xgene_dma_chan *chan,
 				    dma_addr_t dst, dma_addr_t src,
 				    size_t len)
 {
-	void *desc1, *desc2;
+	struct xgene_dma_desc_hw *desc1, *desc2;
 	int i;

 	/* Get 1st descriptor */
@@ -467,23 +447,21 @@ static void xgene_dma_prep_cpy_desc(struct xgene_dma_chan *chan,
 	xgene_dma_init_desc(desc1, chan->tx_ring.dst_ring_num);

 	/* Set destination address */
-	XGENE_DMA_DESC_DR_SET(desc1);
-	XGENE_DMA_DESC_DST_ADDR_SET(desc1, dst);
+	desc1->m2 |= cpu_to_le64(XGENE_DMA_DESC_DR_BIT);
+	desc1->m3 |= cpu_to_le64(dst);

 	/* Set 1st source address */
-	xgene_dma_set_src_buffer(desc1 + 8, &len, &src);
+	xgene_dma_set_src_buffer(&desc1->m1, &len, &src);

-	if (len <= 0) {
-		desc2 = NULL;
-		goto skip_additional_src;
-	}
+	if (!len)
+		return;

 	/*
 	 * We need to split this source buffer,
 	 * and need to use 2nd descriptor
 	 */
 	desc2 = &desc_sw->desc2;
-	XGENE_DMA_DESC_NV_SET(desc1);
+	desc1->m0 |= cpu_to_le64(XGENE_DMA_DESC_NV_BIT);

 	/* Set 2nd to 5th source address */
 	for (i = 0; i < 4 && len; i++)
@@ -496,12 +474,6 @@ static void xgene_dma_prep_cpy_desc(struct xgene_dma_chan *chan,

 	/* Updated flag that we have prepared 64B descriptor */
 	desc_sw->flags |= XGENE_DMA_FLAG_64B_DESC;
-
-skip_additional_src:
-	/* Hardware stores descriptor in little endian format */
-	xgene_dma_cpu_to_le64(desc1, 4);
-	if (desc2)
-		xgene_dma_cpu_to_le64(desc2, 4);
 }

 static void xgene_dma_prep_xor_desc(struct xgene_dma_chan *chan,
@@ -510,7 +482,7 @@ static void xgene_dma_prep_xor_desc(struct xgene_dma_chan *chan,
 				    u32 src_cnt, size_t *nbytes,
 				    const u8 *scf)
 {
-	void *desc1, *desc2;
+	struct xgene_dma_desc_hw *desc1, *desc2;
 	size_t len = *nbytes;
 	int i;

@@ -521,28 +493,25 @@ static void xgene_dma_prep_xor_desc(struct xgene_dma_chan *chan,
 	xgene_dma_init_desc(desc1, chan->tx_ring.dst_ring_num);

 	/* Set destination address */
-	XGENE_DMA_DESC_DR_SET(desc1);
-	XGENE_DMA_DESC_DST_ADDR_SET(desc1, *dst);
+	desc1->m2 |= cpu_to_le64(XGENE_DMA_DESC_DR_BIT);
+	desc1->m3 |= cpu_to_le64(*dst);

 	/* We have multiple source addresses, so need to set NV bit*/
-	XGENE_DMA_DESC_NV_SET(desc1);
+	desc1->m0 |= cpu_to_le64(XGENE_DMA_DESC_NV_BIT);

 	/* Set flyby opcode */
-	XGENE_DMA_DESC_FLYBY_SET(desc1, xgene_dma_encode_xor_flyby(src_cnt));
+	desc1->m2 |= cpu_to_le64(xgene_dma_encode_xor_flyby(src_cnt) <<
+				 XGENE_DMA_DESC_FLYBY_POS);

 	/* Set 1st to 5th source addresses */
 	for (i = 0; i < src_cnt; i++) {
 		len = *nbytes;
-		xgene_dma_set_src_buffer((i == 0) ? (desc1 + 8) :
+		xgene_dma_set_src_buffer((i == 0) ? &desc1->m1 :
 					 xgene_dma_lookup_ext8(desc2, i - 1),
 					 &len, &src[i]);
-		XGENE_DMA_DESC_MULTI_SET(desc1, scf[i], i);
+		desc1->m2 |= cpu_to_le64((scf[i] << ((i + 1) * 8)));
 	}

-	/* Hardware stores descriptor in little endian format */
-	xgene_dma_cpu_to_le64(desc1, 4);
-	xgene_dma_cpu_to_le64(desc2, 4);
-
 	/* Update meta data */
 	*nbytes = len;
 	*dst += XGENE_DMA_MAX_BYTE_CNT;
@@ -738,7 +707,7 @@ static int xgene_chan_xfer_request(struct xgene_dma_ring *ring,
  * xgene_chan_xfer_ld_pending - push any pending transactions to hw
  * @chan : X-Gene DMA channel
  *
- * LOCKING: must hold chan->desc_lock
+ * LOCKING: must hold chan->lock
  */
 static void xgene_chan_xfer_ld_pending(struct xgene_dma_chan *chan)
 {
@@ -808,7 +777,8 @@ static void xgene_dma_cleanup_descriptors(struct xgene_dma_chan *chan)
 		desc_hw = &ring->desc_hw[ring->head];

 		/* Check if this descriptor has been completed */
-		if (unlikely(XGENE_DMA_DESC_IS_EMPTY(desc_hw)))
+		if (unlikely(le64_to_cpu(desc_hw->m0) ==
+			     XGENE_DMA_DESC_EMPTY_SIGNATURE))
 			break;

 		if (++ring->head == ring->slots)
@@ -842,7 +812,7 @@ static void xgene_dma_cleanup_descriptors(struct xgene_dma_chan *chan)
 		iowrite32(-1, ring->cmd);

 		/* Mark this hw descriptor as processed */
-		XGENE_DMA_DESC_SET_EMPTY(desc_hw);
+		desc_hw->m0 = cpu_to_le64(XGENE_DMA_DESC_EMPTY_SIGNATURE);

 		xgene_dma_run_tx_complete_actions(chan, desc_sw);

@@ -889,7 +859,7 @@ static int xgene_dma_alloc_chan_resources(struct dma_chan *dchan)
  * @chan: X-Gene DMA channel
  * @list: the list to free
  *
- * LOCKING: must hold chan->desc_lock
+ * LOCKING: must hold chan->lock
  */
 static void xgene_dma_free_desc_list(struct xgene_dma_chan *chan,
 				     struct list_head *list)
@@ -900,15 +870,6 @@ static void xgene_dma_free_desc_list(struct xgene_dma_chan *chan,
 		xgene_dma_clean_descriptor(chan, desc);
 }

-static void xgene_dma_free_tx_desc_list(struct xgene_dma_chan *chan,
-					struct list_head *list)
-{
-	struct xgene_dma_desc_sw *desc, *_desc;
-
-	list_for_each_entry_safe(desc, _desc, list, node)
-		xgene_dma_clean_descriptor(chan, desc);
-}
-
 static void xgene_dma_free_chan_resources(struct dma_chan *dchan)
 {
 	struct xgene_dma_chan *chan = to_dma_chan(dchan);
@@ -985,7 +946,7 @@ fail:
 	if (!first)
 		return NULL;

-	xgene_dma_free_tx_desc_list(chan, &first->tx_list);
+	xgene_dma_free_desc_list(chan, &first->tx_list);
 	return NULL;
 }

@@ -1093,7 +1054,7 @@ fail:
 	if (!first)
 		return NULL;

-	xgene_dma_free_tx_desc_list(chan, &first->tx_list);
+	xgene_dma_free_desc_list(chan, &first->tx_list);
 	return NULL;
 }

@@ -1141,7 +1102,7 @@ fail:
 	if (!first)
 		return NULL;

-	xgene_dma_free_tx_desc_list(chan, &first->tx_list);
+	xgene_dma_free_desc_list(chan, &first->tx_list);
 	return NULL;
 }

@@ -1218,7 +1179,7 @@ fail:
 	if (!first)
 		return NULL;

-	xgene_dma_free_tx_desc_list(chan, &first->tx_list);
+	xgene_dma_free_desc_list(chan, &first->tx_list);
 	return NULL;
 }

@@ -1316,7 +1277,6 @@ static void xgene_dma_setup_ring(struct xgene_dma_ring *ring)
 {
 	void *ring_cfg = ring->state;
 	u64 addr = ring->desc_paddr;
-	void *desc;
 	u32 i, val;

 	ring->slots = ring->size / XGENE_DMA_RING_WQ_DESC_SIZE;
@@ -1358,8 +1318,10 @@ static void xgene_dma_setup_ring(struct xgene_dma_ring *ring)

 	/* Set empty signature to DMA Rx ring descriptors */
 	for (i = 0; i < ring->slots; i++) {
+		struct xgene_dma_desc_hw *desc;
+
 		desc = &ring->desc_hw[i];
-		XGENE_DMA_DESC_SET_EMPTY(desc);
+		desc->m0 = cpu_to_le64(XGENE_DMA_DESC_EMPTY_SIGNATURE);
 	}

 	/* Enable DMA Rx ring interrupt */
@@ -2084,6 +2046,5 @@ module_platform_driver(xgene_dma_driver);

 MODULE_DESCRIPTION("APM X-Gene SoC DMA driver");
 MODULE_AUTHOR("Rameshwar Prasad Sahu <rsahu@apm.com>");
-MODULE_AUTHOR("Loc Ho <lho@apm.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0");
--
1.8.2.1
