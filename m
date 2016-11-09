From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed,  9 Nov 2016 15:58:20 -0700
Subject: [PATCH fpga 6/9] fpga: Add scatterlist based write ops to the driver
 ops
In-Reply-To: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <1478732303-13718-7-git-send-email-jgunthorpe@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Requiring contiguous kernel memory is not a good idea, this is a limited
resource and allocation can fail under normal work loads.

As a first step allow for drivers to provide a _sg write interface and
internally convert the existing contiguous mappings into a scatterlist.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/fpga/fpga-mgr.c       | 127 +++++++++++++++++++++++++++++++++++++++---
 include/linux/fpga/fpga-mgr.h |   9 ++-
 2 files changed, 128 insertions(+), 8 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 953dc9195937..c2491ffeabd3 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -25,26 +25,76 @@
 #include <linux/of.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/scatterlist.h>
+#include <linux/highmem.h>
 
 static DEFINE_IDA(fpga_mgr_ida);
 static struct class *fpga_mgr_class;
 
 /**
- * fpga_mgr_buf_load - load fpga from image in buffer
+ * fpga_mgr_buf_load_sg - load fpga from image in buffer from a scatter list
  * @mgr:	fpga manager
  * @flags:	flags setting fpga confuration modes
- * @buf:	buffer contain fpga image
- * @count:	byte count of buf
+ * @sgt:	scatterlist table
  *
  * Step the low level fpga manager through the device-specific steps of getting
  * an FPGA ready to be configured, writing the image to it, then doing whatever
  * post-configuration steps necessary.  This code assumes the caller got the
  * mgr pointer from of_fpga_mgr_get() and checked that it is not an error code.
  *
+ * This is the preferred entry point for FPGA programming, it does not require
+ * any contiguous kernel memory.
+ *
  * Return: 0 on success, negative error code otherwise.
  */
-int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags, const char *buf,
-		      size_t count)
+static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr, u32 flags,
+				struct sg_table *sgt)
+{
+	struct device *dev = &mgr->dev;
+	int ret;
+
+	/*
+	 * Call the low level driver's write_init function.  This will do the
+	 * device-specific things to get the FPGA into the state where it is
+	 * ready to receive an FPGA image.
+	 */
+	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
+	ret = mgr->mops->write_init_sg(mgr, flags, sgt);
+	if (ret) {
+		dev_err(dev, "Error preparing FPGA for writing\n");
+		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
+		return ret;
+	}
+
+	/*
+	 * Write the FPGA image to the FPGA.
+	 */
+	mgr->state = FPGA_MGR_STATE_WRITE;
+	ret = mgr->mops->write_sg(mgr, sgt);
+	if (ret) {
+		dev_err(dev, "Error while writing image data to FPGA\n");
+		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
+		return ret;
+	}
+
+	/*
+	 * After all the FPGA image has been written, do the device specific
+	 * steps to finish and set the FPGA into operating mode.
+	 */
+	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
+	ret = mgr->mops->write_complete(mgr, flags);
+	if (ret) {
+		dev_err(dev, "Error after writing image data to FPGA\n");
+		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
+		return ret;
+	}
+	mgr->state = FPGA_MGR_STATE_OPERATING;
+
+	return 0;
+}
+
+static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr, u32 flags,
+				    const char *buf, size_t count)
 {
 	struct device *dev = &mgr->dev;
 	int ret;
@@ -88,6 +138,68 @@ int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags, const char *buf,
 
 	return 0;
 }
+
+/**
+ * fpga_mgr_buf_load - load fpga from image in buffer
+ * @mgr:	fpga manager
+ * @flags:	flags setting fpga confuration modes
+ * @buf:	buffer contain fpga image
+ * @count:	byte count of buf
+ *
+ * Step the low level fpga manager through the device-specific steps of getting
+ * an FPGA ready to be configured, writing the image to it, then doing whatever
+ * post-configuration steps necessary.  This code assumes the caller got the
+ * mgr pointer from of_fpga_mgr_get() and checked that it is not an error code.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags, const char *buf,
+		      size_t count)
+{
+	struct page **pages;
+	struct sg_table sgt;
+	const void *p;
+	int nr_pages;
+	int index;
+	int rc;
+
+	if (!mgr->mops->write_init_sg || !mgr->mops->write_sg)
+		return fpga_mgr_buf_load_mapped(mgr, flags, buf, count);
+
+	/*
+	 * Convert the linear kernel pointer into a sg_table of pages for use
+	 * by the driver.
+	 */
+	nr_pages = DIV_ROUND_UP((unsigned long)buf + count, PAGE_SIZE) -
+		   (unsigned long)buf / PAGE_SIZE;
+	pages = kmalloc_array(nr_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	p = (buf - offset_in_page(p));
+	for (index = 0; index < nr_pages; index++) {
+		if (is_vmalloc_addr(p))
+			pages[index] = vmalloc_to_page(p);
+		else
+			pages[index] = kmap_to_page((void *)p);
+		p += PAGE_SIZE;
+	}
+
+	/*
+	 * The temporary pages list is used to code share the merging algorithm
+	 * in sg_alloc_table_from_pages
+	 */
+	rc = sg_alloc_table_from_pages(&sgt, pages, index, offset_in_page(buf),
+				       count, GFP_KERNEL);
+	kfree(pages);
+	if (rc)
+		return rc;
+
+	rc = fpga_mgr_buf_load_sg(mgr, flags, &sgt);
+	sg_free_table(&sgt);
+
+	return rc;
+}
 EXPORT_SYMBOL_GPL(fpga_mgr_buf_load);
 
 /**
@@ -256,8 +368,9 @@ int fpga_mgr_register(struct device *dev, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->write_init || !mops->write ||
-	    !mops->write_complete || !mops->state) {
+	if (!mops || !mops->write_complete || !mops->state ||
+	    ((!mops->write_init || !mops->write) &&
+	     (!mops->write_init_sg || !mops->write_sg))) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
 		return -EINVAL;
 	}
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 0940bf45e2f2..371b30ea60eb 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -22,6 +22,7 @@
 #define _LINUX_FPGA_MGR_H
 
 struct fpga_manager;
+struct sg_table;
 
 /**
  * enum fpga_mgr_states - fpga framework states
@@ -71,8 +72,11 @@ enum fpga_mgr_states {
 /**
  * struct fpga_manager_ops - ops for low level fpga manager drivers
  * @state: returns an enum value of the FPGA's state
- * @write_init: prepare the FPGA to receive confuration data
+ * @write_init: prepare the FPGA to receive confuration data (linear memory)
  * @write: write count bytes of configuration data to the FPGA
+ * @write_init_sg: prepare the FPGA to receive confuration data (scatter list
+ *                 table)
+ * @write_sg: write count bytes of configuration data to the FPGA
  * @write_complete: set FPGA to operating state after writing is done
  * @fpga_remove: optional: Set FPGA into a specific state during driver remove
  *
@@ -85,6 +89,9 @@ struct fpga_manager_ops {
 	int (*write_init)(struct fpga_manager *mgr, u32 flags,
 			  const char *buf, size_t count);
 	int (*write)(struct fpga_manager *mgr, const char *buf, size_t count);
+	int (*write_init_sg)(struct fpga_manager *mgr, u32 flags,
+			     struct sg_table *sgt);
+	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
 	int (*write_complete)(struct fpga_manager *mgr, u32 flags);
 	void (*fpga_remove)(struct fpga_manager *mgr);
 };
-- 
2.1.4
