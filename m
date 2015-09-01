From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 31 Aug 2015 18:41:06 -0700
Subject: [PATCH] soc: qcom: Make qcom_smem_get() return a pointer
Message-ID: <1441071666-16156-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Passing a void ** almost always requires a cast at the call site.
Instead of littering the code with casts every time this function
is called, have qcom_smem_get() return a void pointer to the
location of the smem item. This frees the caller from having to
cast the pointer with the small downside of doing some extra work
to find the item in the case that the caller doesn't care to use
the pointer.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This is on top of the smd and smem big endian support.

 drivers/soc/qcom/smd.c        | 30 +++++++++---------
 drivers/soc/qcom/smem.c       | 73 +++++++++++++++++++------------------------
 include/linux/soc/qcom/smem.h |  2 +-
 3 files changed, 48 insertions(+), 57 deletions(-)

diff --git a/drivers/soc/qcom/smd.c b/drivers/soc/qcom/smd.c
index 53642a874339..b3526d096d05 100644
--- a/drivers/soc/qcom/smd.c
+++ b/drivers/soc/qcom/smd.c
@@ -1028,10 +1028,11 @@ static struct qcom_smd_channel *qcom_smd_create_channel(struct qcom_smd_edge *ed
 	spin_lock_init(&channel->recv_lock);
 	init_waitqueue_head(&channel->fblockread_event);
 
-	ret = qcom_smem_get(edge->remote_pid, smem_info_item, (void **)&info,
-			    &info_size);
-	if (ret)
+	info = qcom_smem_get(edge->remote_pid, smem_info_item, &info_size);
+	if (IS_ERR(info)) {
+		ret = PTR_ERR(info);
 		goto free_name_and_channel;
+	}
 
 	/*
 	 * Use the size of the item to figure out which channel info struct to
@@ -1048,10 +1049,11 @@ static struct qcom_smd_channel *qcom_smd_create_channel(struct qcom_smd_edge *ed
 		goto free_name_and_channel;
 	}
 
-	ret = qcom_smem_get(edge->remote_pid, smem_fifo_item, &fifo_base,
-			    &fifo_size);
-	if (ret)
+	fifo_base = qcom_smem_get(edge->remote_pid, smem_fifo_item, &fifo_size);
+	if (IS_ERR(fifo_base)) {
+		ret =  PTR_ERR(fifo_base);
 		goto free_name_and_channel;
+	}
 
 	/* The channel consist of a rx and tx fifo of equal size */
 	fifo_size /= 2;
@@ -1088,17 +1090,14 @@ static void qcom_discover_channels(struct qcom_smd_edge *edge)
 	unsigned long flags;
 	unsigned fifo_id;
 	unsigned info_id;
-	int ret;
 	int tbl;
 	int i;
 	u32 eflags, cid;
 
 	for (tbl = 0; tbl < SMD_ALLOC_TBL_COUNT; tbl++) {
-		ret = qcom_smem_get(edge->remote_pid,
-				    smem_items[tbl].alloc_tbl_id,
-				    (void **)&alloc_tbl,
-				    NULL);
-		if (ret < 0)
+		alloc_tbl = qcom_smem_get(edge->remote_pid,
+				    smem_items[tbl].alloc_tbl_id, NULL);
+		if (IS_ERR(alloc_tbl))
 			continue;
 
 		for (i = 0; i < SMD_ALLOC_TBL_SIZE; i++) {
@@ -1278,11 +1277,12 @@ static int qcom_smd_probe(struct platform_device *pdev)
 	int num_edges;
 	int ret;
 	int i = 0;
+	void *p;
 
 	/* Wait for smem */
-	ret = qcom_smem_get(QCOM_SMEM_HOST_ANY, smem_items[0].alloc_tbl_id, NULL, NULL);
-	if (ret == -EPROBE_DEFER)
-		return ret;
+	p = qcom_smem_get(QCOM_SMEM_HOST_ANY, smem_items[0].alloc_tbl_id, NULL);
+	if (PTR_ERR(p) == -EPROBE_DEFER)
+		return PTR_ERR(p);
 
 	num_edges = of_get_available_child_count(pdev->dev.of_node);
 	array_size = sizeof(*smd) + num_edges * sizeof(struct qcom_smd_edge);
diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 889bd23316fd..74017114ce6e 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -418,10 +418,9 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
 }
 EXPORT_SYMBOL(qcom_smem_alloc);
 
-static int qcom_smem_get_global(struct qcom_smem *smem,
-				unsigned item,
-				void **ptr,
-				size_t *size)
+static void *qcom_smem_get_global(struct qcom_smem *smem,
+				  unsigned item,
+				  size_t *size)
 {
 	struct smem_header *header;
 	struct smem_region *area;
@@ -430,37 +429,32 @@ static int qcom_smem_get_global(struct qcom_smem *smem,
 	unsigned i;
 
 	if (WARN_ON(item >= SMEM_ITEM_COUNT))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	header = smem->regions[0].virt_base;
 	entry = &header->toc[item];
 	if (!entry->allocated)
-		return -ENXIO;
+		return ERR_PTR(-ENXIO);
 
-	if (ptr != NULL) {
-		aux_base = le32_to_cpu(entry->aux_base) & AUX_BASE_MASK;
+	aux_base = le32_to_cpu(entry->aux_base) & AUX_BASE_MASK;
 
-		for (i = 0; i < smem->num_regions; i++) {
-			area = &smem->regions[i];
+	for (i = 0; i < smem->num_regions; i++) {
+		area = &smem->regions[i];
 
-			if (area->aux_base == aux_base || !aux_base) {
-				*ptr = area->virt_base +
-				       le32_to_cpu(entry->offset);
-				break;
-			}
+		if (area->aux_base == aux_base || !aux_base) {
+			if (size != NULL)
+				*size = le32_to_cpu(entry->size);
+			return area->virt_base + le32_to_cpu(entry->offset);
 		}
 	}
-	if (size != NULL)
-		*size = le32_to_cpu(entry->size);
 
-	return 0;
+	return ERR_PTR(-ENOENT);
 }
 
-static int qcom_smem_get_private(struct qcom_smem *smem,
-				 unsigned host,
-				 unsigned item,
-				 void **ptr,
-				 size_t *size)
+static void *qcom_smem_get_private(struct qcom_smem *smem,
+				   unsigned host,
+				   unsigned item,
+				   size_t *size)
 {
 	struct smem_partition_header *phdr;
 	struct smem_private_entry *e, *end;
@@ -474,56 +468,55 @@ static int qcom_smem_get_private(struct qcom_smem *smem,
 			dev_err(smem->dev,
 				"Found invalid canary in host %d partition\n",
 				host);
-			return -EINVAL;
+			return ERR_PTR(-EINVAL);
 		}
 
 		if (le16_to_cpu(e->item) == item) {
-			if (ptr != NULL)
-				*ptr = entry_to_item(e);
-
 			if (size != NULL)
 				*size = le32_to_cpu(e->size) -
 					le16_to_cpu(e->padding_data);
 
-			return 0;
+			return entry_to_item(e);
 		}
 
 		e = private_entry_next(e);
 	}
 
-	return -ENOENT;
+	return ERR_PTR(-ENOENT);
 }
 
 /**
  * qcom_smem_get() - resolve ptr of size of a smem item
  * @host:	the remote processor, or -1
  * @item:	smem item handle
- * @ptr:	pointer to be filled out with address of the item
  * @size:	pointer to be filled out with size of the item
  *
- * Looks up pointer and size of a smem item.
+ * Looks up smem item and returns pointer to it. Size of smem
+ * item is returned in @size.
  */
-int qcom_smem_get(unsigned host, unsigned item, void **ptr, size_t *size)
+void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
 {
 	unsigned long flags;
 	int ret;
+	void *ptr = ERR_PTR(-EPROBE_DEFER);
 
 	if (!__smem)
-		return -EPROBE_DEFER;
+		return ptr;
 
 	ret = hwspin_lock_timeout_irqsave(__smem->hwlock,
 					  HWSPINLOCK_TIMEOUT,
 					  &flags);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 	if (host < SMEM_HOST_COUNT && __smem->partitions[host])
-		ret = qcom_smem_get_private(__smem, host, item, ptr, size);
+		ptr = qcom_smem_get_private(__smem, host, item, size);
 	else
-		ret = qcom_smem_get_global(__smem, item, ptr, size);
+		ptr = qcom_smem_get_global(__smem, item, size);
 
 	hwspin_unlock_irqrestore(__smem->hwlock, &flags);
-	return ret;
+
+	return ptr;
 
 }
 EXPORT_SYMBOL(qcom_smem_get);
@@ -561,11 +554,9 @@ static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
 {
 	__le32 *versions;
 	size_t size;
-	int ret;
 
-	ret = qcom_smem_get_global(smem, SMEM_ITEM_VERSION,
-				   (void **)&versions, &size);
-	if (ret < 0) {
+	versions = qcom_smem_get_global(smem, SMEM_ITEM_VERSION, &size);
+	if (IS_ERR(versions)) {
 		dev_err(smem->dev, "Unable to read the version item\n");
 		return -ENOENT;
 	}
diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
index bc9630d3aced..785e196ee2ca 100644
--- a/include/linux/soc/qcom/smem.h
+++ b/include/linux/soc/qcom/smem.h
@@ -4,7 +4,7 @@
 #define QCOM_SMEM_HOST_ANY -1
 
 int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
-int qcom_smem_get(unsigned host, unsigned item, void **ptr, size_t *size);
+void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
 
 int qcom_smem_get_free_space(unsigned host);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
