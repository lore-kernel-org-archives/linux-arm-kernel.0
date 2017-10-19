From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Oct 2017 18:15:43 +0100
Subject: [PATCH 07/17] coresight: tmc etr: Add transparent buffer management
In-Reply-To: <20171019171553.24056-1-suzuki.poulose@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
Message-ID: <20171019171553.24056-8-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment we always use contiguous memory for TMC ETR tracing
when used from sysfs. The size of the buffer is fixed at boot time
and can only be changed by modifiying the DT. With the introduction
of SG support we could support really large buffers in that mode.
This patch abstracts the buffer used for ETR to switch between a
contiguous buffer or a SG table depending on the availability of
the memory.

This also enables the sysfs mode to use the ETR in SG mode depending
on configured the trace buffer size. Also, since ETR will use the
new infrastructure to manage the buffer, we can get rid of some
of the members in the tmc_drvdata and clean up the fields a bit.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 433 +++++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-tmc.h     |  60 +++-
 2 files changed, 403 insertions(+), 90 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index c171b244e12a..9e41eeaa5284 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/coresight.h>
+#include <linux/iommu.h>
 #include <linux/slab.h>
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
@@ -646,7 +647,7 @@ tmc_etr_sg_table_rotate(struct etr_sg_table *etr_table, u64 base_offset)
  * @size	- Total size of the data buffer
  * @pages	- Optional list of page virtual address
  */
-static struct etr_sg_table __maybe_unused *
+static struct etr_sg_table *
 tmc_init_etr_sg_table(struct device *dev, int node,
 		  unsigned long size, void **pages)
 {
@@ -682,19 +683,298 @@ tmc_init_etr_sg_table(struct device *dev, int node,
 	return etr_table;
 }
 
+/*
+ * tmc_etr_alloc_flat_buf: Allocate a contiguous DMA buffer.
+ * We keep the tmc_drvdata in the @private field to retrieve the
+ * device information, while the DMA address and virtual address are
+ * stored already in @hwaddr and @vaddr respectively, which never changes.
+ */
+static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
+				  struct etr_buf *etr_buf, int node,
+				  void **pages)
+{
+	dma_addr_t paddr;
+	void *vaddr = dma_alloc_coherent(drvdata->dev, etr_buf->size,
+					   &paddr, GFP_KERNEL);
+	if (!vaddr)
+		return -ENOMEM;
+	etr_buf->vaddr = vaddr;
+	etr_buf->hwaddr = paddr;
+	etr_buf->mode = ETR_MODE_FLAT;
+	etr_buf->private = drvdata;
+	return 0;
+}
+
+static void tmc_etr_free_flat_buf(struct etr_buf *etr_buf)
+{
+	struct tmc_drvdata *drvdata = etr_buf->private;
+
+	if (etr_buf->hwaddr)
+		dma_free_coherent(drvdata->dev, etr_buf->size,
+					etr_buf->vaddr, etr_buf->hwaddr);
+}
+
+static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
+{
+	/*
+	 * Adjust the buffer to point to the beginning of the trace data
+	 * and update the available trace data.
+	 */
+	etr_buf->offset = rrp - etr_buf->hwaddr;
+	if (etr_buf->full)
+		etr_buf->len = etr_buf->size;
+	else
+		etr_buf->len = rwp - rrp;
+}
+
+static ssize_t tmc_etr_get_data_flat_buf(struct etr_buf *etr_buf,
+					 u64 offset, size_t len, char **bufpp)
+{
+	/*
+	 * tmc_etr_buf_get_data already adjusts the length to handle
+	 * buffer wrapping around.
+	 */
+	*bufpp = (char *)((unsigned long)etr_buf->vaddr + offset);
+	return len;
+}
+
+static const struct etr_buf_operations etr_flat_buf_ops = {
+	.alloc = tmc_etr_alloc_flat_buf,
+	.free = tmc_etr_free_flat_buf,
+	.sync = tmc_etr_sync_flat_buf,
+	.get_data = tmc_etr_get_data_flat_buf,
+};
+
+/*
+ * tmc_etr_alloc_sg_buf: Allocate an SG buf  @etr_buf. Setup the parameters
+ * appropriately.
+ */
+static int tmc_etr_alloc_sg_buf(struct tmc_drvdata *drvdata,
+				struct etr_buf *etr_buf, int node,
+				void **pages)
+{
+	struct etr_sg_table *etr_table;
+
+	etr_table = tmc_init_etr_sg_table(drvdata->dev, node,
+					  etr_buf->size, pages);
+	if (IS_ERR(etr_table))
+		return -ENOMEM;
+	etr_buf->vaddr = tmc_sg_table_data_vaddr(etr_table->sg_table);
+	etr_buf->hwaddr = etr_table->hwaddr;
+	etr_buf->mode = ETR_MODE_ETR_SG;
+	etr_buf->private = etr_table;
+	return 0;
+}
+
+static void tmc_etr_free_sg_buf(struct etr_buf *etr_buf)
+{
+	struct etr_sg_table *etr_table = etr_buf->private;
+
+	if (etr_table) {
+		tmc_free_sg_table(etr_table->sg_table);
+		kfree(etr_table);
+	}
+}
+
+static ssize_t tmc_etr_get_data_sg_buf(struct etr_buf *etr_buf, u64 offset,
+				       size_t len, char **bufpp)
+{
+	struct etr_sg_table *etr_table = etr_buf->private;
+
+	return tmc_sg_table_get_data(etr_table->sg_table, offset, len, bufpp);
+}
+
+static void tmc_etr_sync_sg_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
+{
+	long r_offset, w_offset;
+	struct etr_sg_table *etr_table = etr_buf->private;
+	struct tmc_sg_table *table = etr_table->sg_table;
+
+	r_offset = tmc_sg_get_data_page_offset(table, rrp);
+	if (r_offset < 0) {
+		dev_warn(table->dev, "Unable to map RRP %llx to offset\n",
+				rrp);
+		etr_buf->len = 0;
+		return;
+	}
+
+	w_offset = tmc_sg_get_data_page_offset(table, rwp);
+	if (w_offset < 0) {
+		dev_warn(table->dev, "Unable to map RWP %llx to offset\n",
+				rwp);
+		etr_buf->len = 0;
+		return;
+	}
+
+	etr_buf->offset = r_offset;
+	if (etr_buf->full)
+		etr_buf->len = etr_buf->size;
+	else
+		etr_buf->len = (w_offset < r_offset) ?
+			etr_buf->size + w_offset - r_offset :
+			w_offset - r_offset;
+	tmc_sg_table_sync_data_range(table, r_offset, etr_buf->len);
+}
+
+static const struct etr_buf_operations etr_sg_buf_ops = {
+	.alloc = tmc_etr_alloc_sg_buf,
+	.free = tmc_etr_free_sg_buf,
+	.sync = tmc_etr_sync_sg_buf,
+	.get_data = tmc_etr_get_data_sg_buf,
+};
+
+static const struct etr_buf_operations *etr_buf_ops[] = {
+	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
+	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
+};
+
+static inline int tmc_etr_mode_alloc_buf(int mode,
+				  struct tmc_drvdata *drvdata,
+				  struct etr_buf *etr_buf, int node,
+				  void **pages)
+{
+	int rc;
+
+	switch (mode) {
+	case ETR_MODE_FLAT:
+	case ETR_MODE_ETR_SG:
+		rc = etr_buf_ops[mode]->alloc(drvdata, etr_buf, node, pages);
+		if (!rc)
+			etr_buf->ops = etr_buf_ops[mode];
+		return rc;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * tmc_alloc_etr_buf: Allocate a buffer use by ETR.
+ * @drvdata	: ETR device details.
+ * @size	: size of the requested buffer.
+ * @flags	: Required properties of the type of buffer.
+ * @node	: Node for memory allocations.
+ * @pages	: An optional list of pages.
+ */
+static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
+					  ssize_t size, int flags,
+					  int node, void **pages)
+{
+	int rc = -ENOMEM;
+	bool has_etr_sg, has_iommu;
+	struct etr_buf *etr_buf;
+
+	has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
+	has_iommu = iommu_get_domain_for_dev(drvdata->dev);
+
+	etr_buf = kzalloc(sizeof(*etr_buf), GFP_KERNEL);
+	if (!etr_buf)
+		return ERR_PTR(-ENOMEM);
+
+	etr_buf->size = size;
+
+	/*
+	 * If we have to use an existing list of pages, we cannot reliably
+	 * use a contiguous DMA memory (even if we have an IOMMU). Otherwise,
+	 * we use the contiguous DMA memory if :
+	 *  a) The ETR cannot use Scatter-Gather.
+	 *  b) if not a, we have an IOMMU backup
+	 *  c) if none of the above holds, use it for smaller memory (< 1M).
+	 *
+	 * Fallback to available mechanisms.
+	 *
+	 */
+	if (!pages &&
+	    (!has_etr_sg || has_iommu || size < SZ_1M))
+		rc = tmc_etr_mode_alloc_buf(ETR_MODE_FLAT, drvdata,
+					    etr_buf, node, pages);
+	if (rc && has_etr_sg)
+		rc = tmc_etr_mode_alloc_buf(ETR_MODE_ETR_SG, drvdata,
+					    etr_buf, node, pages);
+	if (rc) {
+		kfree(etr_buf);
+		return ERR_PTR(rc);
+	}
+
+	return etr_buf;
+}
+
+static void tmc_free_etr_buf(struct etr_buf *etr_buf)
+{
+	WARN_ON(!etr_buf->ops || !etr_buf->ops->free);
+	etr_buf->ops->free(etr_buf);
+	kfree(etr_buf);
+}
+
+/*
+ * tmc_etr_buf_get_data: Get the pointer the trace data at @offset
+ * with a maximum of @len bytes.
+ * Returns: The size of the linear data available @pos, with *bufpp
+ * updated to point to the buffer.
+ */
+static ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
+				    u64 offset, size_t len, char **bufpp)
+{
+	/* Adjust the length to limit this transaction to end of buffer */
+	len = (len < (etr_buf->size - offset)) ? len : etr_buf->size - offset;
+
+	return etr_buf->ops->get_data(etr_buf, (u64)offset, len, bufpp);
+}
+
+static inline s64
+tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
+{
+	ssize_t len;
+	char *bufp;
+
+	len = tmc_etr_buf_get_data(etr_buf, offset,
+				   CORESIGHT_BARRIER_PKT_SIZE, &bufp);
+	if (WARN_ON(len <= CORESIGHT_BARRIER_PKT_SIZE))
+		return -EINVAL;
+	coresight_insert_barrier_packet(bufp);
+	return offset + CORESIGHT_BARRIER_PKT_SIZE;
+}
+
+/*
+ * tmc_sync_etr_buf: Sync the trace buffer availability with drvdata.
+ * Makes sure the trace data is synced to the memory for consumption.
+ * @etr_buf->offset will hold the offset to the beginning of the trace data
+ * within the buffer, with @etr_buf->len bytes to consume. @etr_buf->vaddr
+ * will always point to the beginning of the "trace buffer".
+ */
+static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
+{
+	struct etr_buf *etr_buf = drvdata->etr_buf;
+	u64 rrp, rwp;
+	u32 status;
+
+	rrp = tmc_read_rrp(drvdata);
+	rwp = tmc_read_rwp(drvdata);
+	status = readl_relaxed(drvdata->base + TMC_STS);
+	etr_buf->full = status & TMC_STS_FULL;
+
+	WARN_ON(!etr_buf->ops || !etr_buf->ops->sync);
+
+	etr_buf->ops->sync(etr_buf, rrp, rwp);
+
+	/* Insert barrier packets at the beginning, if there was an overflow */
+	if (etr_buf->full)
+		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
+}
+
 static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
 	u32 axictl, sts;
+	struct etr_buf *etr_buf = drvdata->etr_buf;
 
 	/* Zero out the memory to help with debug */
-	memset(drvdata->vaddr, 0, drvdata->size);
+	memset(etr_buf->vaddr, 0, etr_buf->size);
 
 	CS_UNLOCK(drvdata->base);
 
 	/* Wait for TMCSReady bit to be set */
 	tmc_wait_for_tmcready(drvdata);
 
-	writel_relaxed(drvdata->size / 4, drvdata->base + TMC_RSZ);
+	writel_relaxed(etr_buf->size / 4, drvdata->base + TMC_RSZ);
 	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
 
 	axictl = readl_relaxed(drvdata->base + TMC_AXICTL);
@@ -707,16 +987,22 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 		axictl |= TMC_AXICTL_ARCACHE_OS;
 	}
 
+	if (etr_buf->mode == ETR_MODE_ETR_SG) {
+		if (WARN_ON(!tmc_etr_has_cap(drvdata, TMC_ETR_SG)))
+			return;
+		axictl |= TMC_AXICTL_SCT_GAT_MODE;
+	}
+
 	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
-	tmc_write_dba(drvdata, drvdata->paddr);
+	tmc_write_dba(drvdata, etr_buf->hwaddr);
 	/*
 	 * If the TMC pointers must be programmed before the session,
 	 * we have to set it properly (i.e, RRP/RWP to base address and
 	 * STS to "not full").
 	 */
 	if (tmc_etr_has_cap(drvdata, TMC_ETR_SAVE_RESTORE)) {
-		tmc_write_rrp(drvdata, drvdata->paddr);
-		tmc_write_rwp(drvdata, drvdata->paddr);
+		tmc_write_rrp(drvdata, etr_buf->hwaddr);
+		tmc_write_rwp(drvdata, etr_buf->hwaddr);
 		sts = readl_relaxed(drvdata->base + TMC_STS) & ~TMC_STS_FULL;
 		writel_relaxed(sts, drvdata->base + TMC_STS);
 	}
@@ -732,62 +1018,52 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 }
 
 /*
- * Return the available trace data in the buffer @pos, with a maximum
- * limit of @len, also updating the @bufpp on where to find it.
+ * Return the available trace data in the buffer (starts at etr_buf->offset,
+ * limited by etr_buf->len) from @pos, with a maximum limit of @len,
+ * also updating the @bufpp on where to find it. Since the trace data
+ * starts at anywhere in the buffer, depending on the RRP, we adjust the
+ * @len returned to handle buffer wrapping around.
  */
 ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
 			    loff_t pos, size_t len, char **bufpp)
 {
-	char *bufp = drvdata->buf + pos;
-	char *bufend = (char *)(drvdata->vaddr + drvdata->size);
-
-	/* Adjust the len to available size @pos */
-	if (pos + len > drvdata->len)
-		len = drvdata->len - pos;
+	s64 offset;
+	struct etr_buf *etr_buf = drvdata->etr_buf;
 
+	if (pos + len > etr_buf->len)
+		len = etr_buf->len - pos;
 	if (len <= 0)
 		return len;
 
-	/*
-	 * Since we use a circular buffer, with trace data starting
-	 * @drvdata->buf, possibly anywhere in the buffer @drvdata->vaddr,
-	 * wrap the current @pos to within the buffer.
-	 */
-	if (bufp >= bufend)
-		bufp -= drvdata->size;
-	/*
-	 * For simplicity, avoid copying over a wrapped around buffer.
-	 */
-	if ((bufp + len) > bufend)
-		len = bufend - bufp;
-	*bufpp = bufp;
-	return len;
+	/* Compute the offset from which we read the data */
+	offset = etr_buf->offset + pos;
+	if (offset >= etr_buf->size)
+		offset -= etr_buf->size;
+	return tmc_etr_buf_get_data(etr_buf, offset, len, bufpp);
 }
 
-static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
+static struct etr_buf *
+tmc_etr_setup_sysfs_buf(struct tmc_drvdata *drvdata)
 {
-	u32 val;
-	u64 rwp;
+	return tmc_alloc_etr_buf(drvdata, drvdata->size, 0,
+				  cpu_to_node(0), NULL);
+}
 
-	rwp = tmc_read_rwp(drvdata);
-	val = readl_relaxed(drvdata->base + TMC_STS);
+static void
+tmc_etr_free_sysfs_buf(struct etr_buf *buf)
+{
+	if (buf)
+		tmc_free_etr_buf(buf);
+}
 
-	/*
-	 * Adjust the buffer to point to the beginning of the trace data
-	 * and update the available trace data.
-	 */
-	if (val & TMC_STS_FULL) {
-		drvdata->buf = drvdata->vaddr + rwp - drvdata->paddr;
-		drvdata->len = drvdata->size;
-		coresight_insert_barrier_packet(drvdata->buf);
-	} else {
-		drvdata->buf = drvdata->vaddr;
-		drvdata->len = rwp - drvdata->paddr;
-	}
+static void tmc_etr_sync_sysfs_buf(struct tmc_drvdata *drvdata)
+{
+	tmc_sync_etr_buf(drvdata);
 }
 
 static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 {
+
 	CS_UNLOCK(drvdata->base);
 
 	tmc_flush_and_stop(drvdata);
@@ -796,7 +1072,8 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 	 * read before the TMC is disabled.
 	 */
 	if (drvdata->mode == CS_MODE_SYSFS)
-		tmc_etr_dump_hw(drvdata);
+		tmc_etr_sync_sysfs_buf(drvdata);
+
 	tmc_disable_hw(drvdata);
 
 	CS_LOCK(drvdata->base);
@@ -807,34 +1084,31 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	int ret = 0;
 	bool used = false;
 	unsigned long flags;
-	void __iomem *vaddr = NULL;
-	dma_addr_t paddr;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct etr_buf *new_buf = NULL, *free_buf = NULL;
 
 
 	/*
-	 * If we don't have a buffer release the lock and allocate memory.
-	 * Otherwise keep the lock and move along.
+	 * If we are enabling the ETR from disabled state, we need to make
+	 * sure we have a buffer with the right size. The etr_buf is not reset
+	 * immediately after we stop the tracing in SYSFS mode as we wait for
+	 * the user to collect the data. We may be able to reuse the existing
+	 * buffer, provided the size matches. Any allocation has to be done
+	 * with the lock released.
 	 */
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (!drvdata->vaddr) {
+	if (!drvdata->etr_buf || (drvdata->etr_buf->size != drvdata->size)) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
-
-		/*
-		 * Contiguous  memory can't be allocated while a spinlock is
-		 * held.  As such allocate memory here and free it if a buffer
-		 * has already been allocated (from a previous session).
-		 */
-		vaddr = dma_alloc_coherent(drvdata->dev, drvdata->size,
-					   &paddr, GFP_KERNEL);
-		if (!vaddr)
-			return -ENOMEM;
+		/* Allocate memory with the spinlock released */
+		free_buf = new_buf = tmc_etr_setup_sysfs_buf(drvdata);
+		if (IS_ERR(new_buf))
+			return PTR_ERR(new_buf);
 
 		/* Let's try again */
 		spin_lock_irqsave(&drvdata->spinlock, flags);
 	}
 
-	if (drvdata->reading) {
+	if (drvdata->reading || drvdata->mode == CS_MODE_PERF) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -842,21 +1116,20 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	/*
 	 * In sysFS mode we can have multiple writers per sink.  Since this
 	 * sink is already enabled no memory is needed and the HW need not be
-	 * touched.
+	 * touched, even if the buffer size has changed.
 	 */
 	if (drvdata->mode == CS_MODE_SYSFS)
 		goto out;
 
 	/*
-	 * If drvdata::buf == NULL, use the memory allocated above.
-	 * Otherwise a buffer still exists from a previous session, so
-	 * simply use that.
+	 * If we don't have a buffer or it doesn't match the requested size,
+	 * use the memory allocated above. Otherwise reuse it.
 	 */
-	if (drvdata->buf == NULL) {
+	if (!drvdata->etr_buf ||
+	    (new_buf && drvdata->etr_buf->size != new_buf->size)) {
 		used = true;
-		drvdata->vaddr = vaddr;
-		drvdata->paddr = paddr;
-		drvdata->buf = drvdata->vaddr;
+		free_buf = drvdata->etr_buf;
+		drvdata->etr_buf = new_buf;
 	}
 
 	drvdata->mode = CS_MODE_SYSFS;
@@ -865,8 +1138,8 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/* Free memory outside the spinlock if need be */
-	if (!used && vaddr)
-		dma_free_coherent(drvdata->dev, drvdata->size, vaddr, paddr);
+	if (free_buf)
+		tmc_etr_free_sysfs_buf(free_buf);
 
 	if (!ret)
 		dev_info(drvdata->dev, "TMC-ETR enabled\n");
@@ -945,8 +1218,8 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 		goto out;
 	}
 
-	/* If drvdata::buf is NULL the trace data has been read already */
-	if (drvdata->buf == NULL) {
+	/* If drvdata::etr_buf is NULL the trace data has been read already */
+	if (drvdata->etr_buf == NULL) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -965,8 +1238,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 {
 	unsigned long flags;
-	dma_addr_t paddr;
-	void __iomem *vaddr = NULL;
+	struct etr_buf *etr_buf = NULL;
 
 	/* config types are set a boot time and never change */
 	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
@@ -988,17 +1260,16 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 		 * The ETR is not tracing and the buffer was just read.
 		 * As such prepare to free the trace buffer.
 		 */
-		vaddr = drvdata->vaddr;
-		paddr = drvdata->paddr;
-		drvdata->buf = drvdata->vaddr = NULL;
+		etr_buf =  drvdata->etr_buf;
+		drvdata->etr_buf = NULL;
 	}
 
 	drvdata->reading = false;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/* Free allocated memory out side of the spinlock */
-	if (vaddr)
-		dma_free_coherent(drvdata->dev, drvdata->size, vaddr, paddr);
+	if (etr_buf)
+		tmc_free_etr_buf(etr_buf);
 
 	return 0;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 5e49c035a1ac..50ebc17c4645 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -55,6 +55,8 @@
 #define TMC_STS_TMCREADY_BIT	2
 #define TMC_STS_FULL		BIT(0)
 #define TMC_STS_TRIGGERED	BIT(1)
+#define TMC_STS_MEMERR		BIT(5)
+
 /*
  * TMC_AXICTL - 0x110
  *
@@ -134,6 +136,37 @@ enum tmc_mem_intf_width {
 #define CORESIGHT_SOC_600_ETR_CAPS	\
 	(TMC_ETR_SAVE_RESTORE | TMC_ETR_AXI_ARCACHE)
 
+enum etr_mode {
+	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
+	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
+};
+
+struct etr_buf_operations;
+
+/**
+ * struct etr_buf - Details of the buffer used by ETR
+ * @mode	: Mode of the ETR buffer, contiguous, Scatter Gather etc.
+ * @full	: Trace data overflow
+ * @size	: Size of the buffer.
+ * @hwaddr	: Address to be programmed in the TMC:DBA{LO,HI}
+ * @vaddr	: Virtual address of the buffer used for trace.
+ * @offset	: Offset of the trace data in the buffer for consumption.
+ * @len		: Available trace data @buf (may round up to the beginning).
+ * @ops		: ETR buffer operations for the mode.
+ * @private	: Backend specific information for the buf
+ */
+struct etr_buf {
+	enum etr_mode			mode;
+	bool				full;
+	ssize_t				size;
+	dma_addr_t			hwaddr;
+	void				*vaddr;
+	unsigned long			offset;
+	u64				len;
+	const struct etr_buf_operations	*ops;
+	void				*private;
+};
+
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
  * @base:	memory mapped base address for this component.
@@ -141,11 +174,10 @@ enum tmc_mem_intf_width {
  * @csdev:	component vitals needed by the framework.
  * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
  * @spinlock:	only one at a time pls.
- * @buf:	area of memory where trace data get sent.
- * @paddr:	DMA start location in RAM.
- * @vaddr:	virtual representation of @paddr.
- * @size:	trace buffer size.
- * @len:	size of the available trace.
+ * @buf:	Snapshot of the trace data for ETF/ETB.
+ * @etr_buf:	details of buffer used in TMC-ETR
+ * @len:	size of the available trace for ETF/ETB.
+ * @size:	trace buffer size for this TMC (common for all modes).
  * @mode:	how this TMC is being used.
  * @config_type: TMC variant, must be of type @tmc_config_type.
  * @memwidth:	width of the memory interface databus, in bytes.
@@ -160,11 +192,12 @@ struct tmc_drvdata {
 	struct miscdevice	miscdev;
 	spinlock_t		spinlock;
 	bool			reading;
-	char			*buf;
-	dma_addr_t		paddr;
-	void __iomem		*vaddr;
-	u32			size;
+	union {
+		char		*buf;		/* TMC ETB */
+		struct etr_buf	*etr_buf;	/* TMC ETR */
+	};
 	u32			len;
+	u32			size;
 	u32			mode;
 	enum tmc_config_type	config_type;
 	enum tmc_mem_intf_width	memwidth;
@@ -172,6 +205,15 @@ struct tmc_drvdata {
 	u32			etr_caps;
 };
 
+struct etr_buf_operations {
+	int (*alloc)(struct tmc_drvdata *drvdata, struct etr_buf *etr_buf,
+			int node, void **pages);
+	void (*sync)(struct etr_buf *etr_buf, u64 rrp, u64 rwp);
+	ssize_t (*get_data)(struct etr_buf *etr_buf, u64 offset, size_t len,
+				char **bufpp);
+	void (*free)(struct etr_buf *etr_buf);
+};
+
 /**
  * struct tmc_pages - Collection of pages used for SG.
  * @nr_pages:		Number of pages in the list.
-- 
2.13.6
