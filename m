From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  8 Mar 2016 12:15:13 +0100
Subject: [PATCH 5/7] mtd: provide helper to prepare buffers for DMA operations
In-Reply-To: <1457435715-24740-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457435715-24740-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457435715-24740-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some NAND controller drivers are making use of DMA to transfer data from
the controller to the buffer passed by the MTD user.
Provide a generic mtd_map/unmap_buf() implementation to avoid open coded
(and sometime erroneous) implementations.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/mtdcore.c   | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h | 25 +++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 3096251..3c368f0 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1253,6 +1253,72 @@ void *mtd_kmalloc_up_to(const struct mtd_info *mtd, size_t *size)
 }
 EXPORT_SYMBOL_GPL(mtd_kmalloc_up_to);
 
+#ifdef CONFIG_HAS_DMA
+/**
+ * mtd_map_buf - create an SG table and prepare it for DMA operations
+ *
+ * @mtd: mtd device description object pointer
+ * @dev: device handling the DMA operation
+ * @buf: buf used to create the SG table
+ * @len: length of buf
+ * @constraints: optional constraints to take into account when creating
+ *		 the SG table. Can be NULL if no specific constraints
+ *		 are required.
+ * @dir: direction of the DMA operation
+ *
+ * This function should be used when an MTD driver wants to do DMA operations
+ * on a buffer passed by the MTD layer. This functions takes care of
+ * vmallocated buffer constraints, and return and sg_table that you can safely
+ * use.
+ */
+int mtd_map_buf(struct mtd_info *mtd, struct device *dev,
+		struct sg_table *sgt, const void *buf, size_t len,
+		const struct sg_constraints *constraints,
+		enum dma_data_direction dir)
+{
+	int ret;
+
+	ret = sg_alloc_table_from_buf(sgt, buf, len, constraints, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	ret = dma_map_sg(dev, sgt->sgl, sgt->nents, dir);
+	if (!ret)
+		ret = -ENOMEM;
+
+	if (ret < 0) {
+		sg_free_table(sgt);
+		return ret;
+	}
+
+	sgt->nents = ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtd_map_buf);
+
+/**
+ * mtd_map_buf - unmap an SG table and release its resources
+ *
+ * @mtd: mtd device description object pointer
+ * @dev: device handling the DMA operation
+ * @sgt: SG table
+ * @dir: direction of the DMA operation
+ *
+ * This function unmaps a previously mapped SG table and release SG table
+ * resources. Should be called when your DMA operation is done.
+ */
+void mtd_unmap_buf(struct mtd_info *mtd, struct device *dev,
+		   struct sg_table *sgt, enum dma_data_direction dir)
+{
+	if (sgt->orig_nents) {
+		dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
+		sg_free_table(sgt);
+	}
+}
+EXPORT_SYMBOL_GPL(mtd_unmap_buf);
+#endif /* !CONFIG_HAS_DMA */
+
 #ifdef CONFIG_PROC_FS
 
 /*====================================================================*/
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index cc84923..11c63f1 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -24,6 +24,7 @@
 #include <linux/uio.h>
 #include <linux/notifier.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 
 #include <mtd/mtd-abi.h>
 
@@ -406,6 +407,30 @@ extern void register_mtd_user (struct mtd_notifier *new);
 extern int unregister_mtd_user (struct mtd_notifier *old);
 void *mtd_kmalloc_up_to(const struct mtd_info *mtd, size_t *size);
 
+#ifdef CONFIG_HAS_DMA
+int mtd_map_buf(struct mtd_info *mtd, struct device *dev,
+		struct sg_table *sgt, const void *buf, size_t len,
+		const struct sg_constraints *constraints,
+		enum dma_data_direction dir);
+void mtd_unmap_buf(struct mtd_info *mtd, struct device *dev,
+		   struct sg_table *sgt, enum dma_data_direction dir);
+#else
+static inline int mtd_map_buf(struct mtd_info *mtd, struct device *dev,
+			      struct sg_table *sgt, const void *buf,
+			      size_t len,
+			      const struct sg_constraints *constraints
+			      enum dma_data_direction dir)
+{
+	return -ENOTSUPP;
+}
+
+static void mtd_unmap_buf(struct mtd_info *mtd, struct device *dev,
+			  struct sg_table *sgt, enum dma_data_direction dir)
+{
+	return -ENOTSUPP;
+}
+#endif
+
 void mtd_erase_callback(struct erase_info *instr);
 
 static inline int mtd_is_bitflip(int err) {
-- 
2.1.4
