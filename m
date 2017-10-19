From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Oct 2017 18:15:50 +0100
Subject: [PATCH 14/17] coresight: etr: Add support for save restore buffers
In-Reply-To: <20171019171553.24056-1-suzuki.poulose@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
Message-ID: <20171019171553.24056-15-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for creating buffers which can be used in save-restore
mode (e.g, for use by perf). If the TMC-ETR supports save-restore
feature, we could support the mode in all buffer backends. However,
if it doesn't, we should fall back to using in built SG mechanism,
where we can rotate the SG table by making some adjustments in the
page table.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 132 +++++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc.h     |  15 +++
 2 files changed, 143 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 849684f85443..f8e654e1f5b2 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -590,7 +590,7 @@ tmc_etr_sg_table_index_to_daddr(struct tmc_sg_table *sg_table, u32 index)
  * 3) Update the hwaddr to point to the table pointer for the buffer
  *    which starts at "base".
  */
-static int __maybe_unused
+static int
 tmc_etr_sg_table_rotate(struct etr_sg_table *etr_table, u64 base_offset)
 {
 	u32 last_entry, first_entry;
@@ -700,6 +700,9 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
 		return -ENOMEM;
 	etr_buf->vaddr = vaddr;
 	etr_buf->hwaddr = paddr;
+	etr_buf->rrp = paddr;
+	etr_buf->rwp = paddr;
+	etr_buf->status = 0;
 	etr_buf->mode = ETR_MODE_FLAT;
 	etr_buf->private = drvdata;
 	return 0;
@@ -754,13 +757,19 @@ static int tmc_etr_alloc_sg_buf(struct tmc_drvdata *drvdata,
 				void **pages)
 {
 	struct etr_sg_table *etr_table;
+	struct tmc_sg_table *sg_table;
 
 	etr_table = tmc_init_etr_sg_table(drvdata->dev, node,
 					  etr_buf->size, pages);
 	if (IS_ERR(etr_table))
 		return -ENOMEM;
+	sg_table = etr_table->sg_table;
 	etr_buf->vaddr = tmc_sg_table_data_vaddr(etr_table->sg_table);
 	etr_buf->hwaddr = etr_table->hwaddr;
+	/* TMC ETR SG automatically sets the RRP/RWP when enabled */
+	etr_buf->rrp = etr_table->hwaddr;
+	etr_buf->rwp = etr_table->hwaddr;
+	etr_buf->status = 0;
 	etr_buf->mode = ETR_MODE_ETR_SG;
 	etr_buf->private = etr_table;
 	return 0;
@@ -816,11 +825,49 @@ static void tmc_etr_sync_sg_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
 	tmc_sg_table_sync_data_range(table, r_offset, etr_buf->len);
 }
 
+static int tmc_etr_restore_sg_buf(struct etr_buf *etr_buf,
+				   u64 r_offset, u64 w_offset,
+				   u32 status, bool has_save_restore)
+{
+	int rc;
+	struct etr_sg_table *etr_table = etr_buf->private;
+	struct device *dev = etr_table->sg_table->dev;
+
+	/*
+	 * It is highly unlikely that we have an ETR with in-built SG and
+	 * Save-Restore capability and we are not sure if the PTRs will
+	 * be updated.
+	 */
+	if (has_save_restore) {
+		dev_warn_once(dev,
+		"Unexpected feature combination of SG and save-restore\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Since we cannot program RRP/RWP different from DBAL, the offsets
+	 * should match.
+	 */
+	if (r_offset != w_offset) {
+		dev_dbg(dev, "Mismatched RRP/RWP offsets\n");
+		return -EINVAL;
+	}
+
+	rc = tmc_etr_sg_table_rotate(etr_table, w_offset);
+	if (!rc) {
+		etr_buf->hwaddr = etr_table->hwaddr;
+		etr_buf->rrp = etr_table->hwaddr;
+		etr_buf->rwp = etr_table->hwaddr;
+	}
+	return rc;
+}
+
 static const struct etr_buf_operations etr_sg_buf_ops = {
 	.alloc = tmc_etr_alloc_sg_buf,
 	.free = tmc_etr_free_sg_buf,
 	.sync = tmc_etr_sync_sg_buf,
 	.get_data = tmc_etr_get_data_sg_buf,
+	.restore = tmc_etr_restore_sg_buf,
 };
 
 static const struct etr_buf_operations *etr_buf_ops[] = {
@@ -861,10 +908,42 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
 {
 	int rc = -ENOMEM;
 	bool has_etr_sg, has_iommu;
+	bool has_flat, has_save_restore;
 	struct etr_buf *etr_buf;
 
 	has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
 	has_iommu = iommu_get_domain_for_dev(drvdata->dev);
+	has_save_restore = tmc_etr_has_cap(drvdata, TMC_ETR_SAVE_RESTORE);
+
+	/*
+	 * We can normally use flat DMA buffer provided that the buffer
+	 * is not used in save restore fashion without hardware support.
+	 */
+	has_flat = !(flags & ETR_BUF_F_RESTORE_PTRS) || has_save_restore;
+
+	/*
+	 * To support save-restore on a given ETR we have the following
+	 * conditions:
+	 *  1) If the buffer requires save-restore of a pointers as well
+	 *     as the Status bit, we require ETR support for it and we coul
+	 *     support all the backends.
+	 *  2) If the buffer requires only save-restore of pointers, then
+	 *     we could exploit a circular ETR SG list. None of the other
+	 *     backends can support it without the ETR feature.
+	 *
+	 * If the buffer will be used in a save-restore mode without
+	 * the ETR support for SAVE_RESTORE, we can only support TMC
+	 * ETR in-built SG tables which can be rotated to make it work.
+	 */
+	if ((flags & ETR_BUF_F_RESTORE_STATUS) && !has_save_restore)
+		return ERR_PTR(-EINVAL);
+
+	if (!has_flat && !has_etr_sg) {
+		dev_dbg(drvdata->dev,
+			"No available backends for ETR buffer with flags %x\n",
+			flags);
+		return ERR_PTR(-EINVAL);
+	}
 
 	etr_buf = kzalloc(sizeof(*etr_buf), GFP_KERNEL);
 	if (!etr_buf)
@@ -883,7 +962,7 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
 	 * Fallback to available mechanisms.
 	 *
 	 */
-	if (!pages &&
+	if (!pages && has_flat &&
 	    (!has_etr_sg || has_iommu || size < SZ_1M))
 		rc = tmc_etr_mode_alloc_buf(ETR_MODE_FLAT, drvdata,
 					    etr_buf, node, pages);
@@ -961,6 +1040,51 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
 		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
 }
 
+/*
+ * tmc_etr_restore_generic: Common helper to restore the buffer
+ * status for FLAT buffers, which use linear TMC ETR address range.
+ * This is only possible with in-built ETR capability to save-restore
+ * the pointers. The DBA will still point to the original start of the
+ * buffer.
+ */
+static int tmc_etr_buf_generic_restore(struct etr_buf *etr_buf,
+					u64 r_offset, u64 w_offset,
+					u32 status, bool has_save_restore)
+{
+	u64 size = etr_buf->size;
+
+	if (!has_save_restore)
+		return -EINVAL;
+	etr_buf->rrp = etr_buf->hwaddr + (r_offset % size);
+	etr_buf->rwp = etr_buf->hwaddr + (w_offset % size);
+	etr_buf->status = status;
+	return 0;
+}
+
+static int __maybe_unused
+tmc_restore_etr_buf(struct tmc_drvdata *drvdata, struct etr_buf *etr_buf,
+		    u64 r_offset, u64 w_offset, u32 status)
+{
+	bool has_save_restore = tmc_etr_has_cap(drvdata, TMC_ETR_SAVE_RESTORE);
+
+	if (WARN_ON_ONCE(!has_save_restore && etr_buf->mode != ETR_MODE_ETR_SG))
+		return -EINVAL;
+	/*
+	 * If we use a circular SG list without ETR support, we can't
+	 * support restoring "Full" bit.
+	 */
+	if (WARN_ON_ONCE(!has_save_restore && status))
+		return -EINVAL;
+	if (status & ~TMC_STS_FULL)
+		return -EINVAL;
+	if (etr_buf->ops->restore)
+		return etr_buf->ops->restore(etr_buf, r_offset, w_offset,
+					      status, has_save_restore);
+	else
+		return tmc_etr_buf_generic_restore(etr_buf, r_offset, w_offset,
+					       status, has_save_restore);
+}
+
 static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 			      struct etr_buf *etr_buf)
 {
@@ -1004,8 +1128,8 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 	 * STS to "not full").
 	 */
 	if (tmc_etr_has_cap(drvdata, TMC_ETR_SAVE_RESTORE)) {
-		tmc_write_rrp(drvdata, etr_buf->hwaddr);
-		tmc_write_rwp(drvdata, etr_buf->hwaddr);
+		tmc_write_rrp(drvdata, etr_buf->rrp);
+		tmc_write_rwp(drvdata, etr_buf->rwp);
 		sts = readl_relaxed(drvdata->base + TMC_STS) & ~TMC_STS_FULL;
 		writel_relaxed(sts, drvdata->base + TMC_STS);
 	}
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 14a3dec50b0f..2c5b905b6494 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -142,12 +142,22 @@ enum etr_mode {
 	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
 };
 
+/* ETR buffer should support save-restore */
+#define ETR_BUF_F_RESTORE_PTRS		0x1
+#define ETR_BUF_F_RESTORE_STATUS	0x2
+
+#define ETR_BUF_F_RESTORE_MINIMAL	ETR_BUF_F_RESTORE_PTRS
+#define ETR_BUF_F_RESTORE_FULL		(ETR_BUF_F_RESTORE_PTRS |\
+					 ETR_BUF_F_RESTORE_STATUS)
 struct etr_buf_operations;
 
 /**
  * struct etr_buf - Details of the buffer used by ETR
  * @mode	: Mode of the ETR buffer, contiguous, Scatter Gather etc.
  * @full	: Trace data overflow
+ * @status	: Value for STATUS if the ETR supports save-restore.
+ * @rrp		: Value for RRP{LO:HI} if the ETR supports save-restore
+ * @rwp		: Value for RWP{LO:HI} if the ETR supports save-restore
  * @size	: Size of the buffer.
  * @hwaddr	: Address to be programmed in the TMC:DBA{LO,HI}
  * @vaddr	: Virtual address of the buffer used for trace.
@@ -159,6 +169,9 @@ struct etr_buf_operations;
 struct etr_buf {
 	enum etr_mode			mode;
 	bool				full;
+	u32				status;
+	dma_addr_t			rrp;
+	dma_addr_t			rwp;
 	ssize_t				size;
 	dma_addr_t			hwaddr;
 	void				*vaddr;
@@ -212,6 +225,8 @@ struct etr_buf_operations {
 	int (*alloc)(struct tmc_drvdata *drvdata, struct etr_buf *etr_buf,
 			int node, void **pages);
 	void (*sync)(struct etr_buf *etr_buf, u64 rrp, u64 rwp);
+	int (*restore)(struct etr_buf *etr_buf, u64 r_offset,
+		       u64 w_offset, u32 status, bool has_save_restore);
 	ssize_t (*get_data)(struct etr_buf *etr_buf, u64 offset, size_t len,
 				char **bufpp);
 	void (*free)(struct etr_buf *etr_buf);
-- 
2.13.6
