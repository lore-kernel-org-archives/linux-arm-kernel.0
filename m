From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 22 Mar 2016 14:23:21 -0600
Subject: [PATCH 13/14] coresight: tmc: implementing TMC-ETR AUX space API
In-Reply-To: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1458678202-3447-14-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implement the AUX area interfaces required to
use the TMC (configured as an ETR) from the Perf sub-system.

The heuristic is heavily borrowed from the ETB10 and TMC-ETF
implementation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c |   6 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 141 ++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h     |   3 +
 3 files changed, 147 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 79762b2c6114..64b4b4f8df12 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -364,9 +364,9 @@ static unsigned long tmc_reset_etf_buffer(struct coresight_device *csdev,
 	return size;
 }
 
-static void tmc_update_etf_buffer(struct coresight_device *csdev,
-				  struct perf_output_handle *handle,
-				  void *sink_config)
+void tmc_update_etf_buffer(struct coresight_device *csdev,
+			   struct perf_output_handle *handle,
+			   void *sink_config)
 {
 	int i, cur;
 	u32 *buf_ptr;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 50a2e0a83714..6ba261277316 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -15,12 +15,30 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/circ_buf.h>
 #include <linux/coresight.h>
 #include <linux/dma-mapping.h>
+#include <linux/slab.h>
 
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
 
+/**
+ * struct cs_etr_buffer - keep track of a recording session' specifics
+ * @tmc:	generic portion of the TMC buffers
+ * @paddr:	the physical address of a DMA'able contiguous memory area
+ * @vaddr:	the virtual address associated to @paddr
+ * @size:	how much memory we have, starting at @paddr
+ * @dev:	the device @vaddr has been tied to
+ */
+struct cs_etr_buffers {
+	struct cs_tmc_buffers	tmc;
+	dma_addr_t		paddr;
+	void __iomem		*vaddr;
+	u32			size;
+	struct device		*dev;
+};
+
 void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
 	u32 axictl;
@@ -226,9 +244,132 @@ out:
 	dev_info(drvdata->dev, "TMC-ETR disabled\n");
 }
 
+static void *tmc_alloc_etr_buffer(struct coresight_device *csdev, int cpu,
+				  void **pages, int nr_pages, bool overwrite)
+{
+	int node;
+	struct cs_etr_buffers *buf;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (cpu == -1)
+		cpu = smp_processor_id();
+	node = cpu_to_node(cpu);
+
+	/* Allocate memory structure for interaction with Perf */
+	buf = kzalloc_node(sizeof(struct cs_etr_buffers), GFP_KERNEL, node);
+	if (!buf)
+		return NULL;
+
+	buf->dev = drvdata->dev;
+	buf->size = drvdata->size;
+	buf->vaddr = dma_alloc_coherent(buf->dev, buf->size,
+					&buf->paddr, GFP_KERNEL);
+	if (!buf->vaddr) {
+		kfree(buf);
+		return NULL;
+	}
+
+	buf->tmc.snapshot = overwrite;
+	buf->tmc.nr_pages = nr_pages;
+	buf->tmc.data_pages = pages;
+
+	return buf;
+}
+
+static void tmc_free_etr_buffer(void *config)
+{
+	struct cs_etr_buffers *buf = config;
+
+	dma_free_coherent(buf->dev, buf->size, buf->vaddr, buf->paddr);
+	kfree(buf);
+}
+
+static int tmc_set_etr_buffer(struct coresight_device *csdev,
+			      struct perf_output_handle *handle,
+			      void *sink_config)
+{
+	int ret = 0;
+	unsigned long head;
+	struct cs_etr_buffers *buf = sink_config;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	/* wrap head around to the amount of space we have */
+	head = handle->head & ((buf->tmc.nr_pages << PAGE_SHIFT) - 1);
+
+	/* find the page to write to */
+	buf->tmc.cur = head / PAGE_SIZE;
+
+	/* and offset within that page */
+	buf->tmc.offset = head % PAGE_SIZE;
+
+	local_set(&buf->tmc.data_size, 0);
+
+	/* Tell the HW where to put the trace data */
+	drvdata->vaddr = buf->vaddr;
+	drvdata->paddr = buf->paddr;
+	memset(drvdata->vaddr, 0, drvdata->size);
+
+	return ret;
+}
+
+static unsigned long tmc_reset_etr_buffer(struct coresight_device *csdev,
+					  struct perf_output_handle *handle,
+					  void *sink_config, bool *lost)
+{
+	unsigned long size = 0;
+	struct cs_etr_buffers *buf = sink_config;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (buf) {
+		/*
+		 * In snapshot mode ->data_size holds the new address of the
+		 * ring buffer's head.  The size itself is the whole address
+		 * range since we want the latest information.
+		 */
+		if (buf->tmc.snapshot) {
+			size = buf->tmc.nr_pages << PAGE_SHIFT;
+			handle->head = local_xchg(&buf->tmc.data_size, size);
+		}
+
+		/*
+		 * Tell the tracer PMU how much we got in this run and if
+		 * something went wrong along the way.  Nobody else can use
+		 * this cs_etr_buffers instance until we are done.  As such
+		 * resetting parameters here and squaring off with the ring
+		 * buffer API in the tracer PMU is fine.
+		 */
+		*lost = !!local_xchg(&buf->tmc.lost, 0);
+		size = local_xchg(&buf->tmc.data_size, 0);
+	}
+
+	/* Get ready for another run */
+	drvdata->vaddr = NULL;
+	drvdata->paddr = 0;
+
+	return size;
+}
+
+static void tmc_update_etr_buffer(struct coresight_device *csdev,
+				  struct perf_output_handle *handle,
+				  void *sink_config)
+{
+	struct cs_etr_buffers *buf = sink_config;
+
+	/*
+	 * An ETR configured to work in contiguous memory mode works the same
+	 * was as an ETB or ETF.
+	 */
+	tmc_update_etf_buffer(csdev, handle, &buf->tmc);
+}
+
 static const struct coresight_ops_sink tmc_etr_sink_ops = {
 	.enable		= tmc_enable_etr_sink,
 	.disable	= tmc_disable_etr_sink,
+	.alloc_buffer	= tmc_alloc_etr_buffer,
+	.free_buffer	= tmc_free_etr_buffer,
+	.set_buffer	= tmc_set_etr_buffer,
+	.reset_buffer	= tmc_reset_etr_buffer,
+	.update_buffer	= tmc_update_etr_buffer,
 };
 
 const struct coresight_ops tmc_etr_cs_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 3de442f15be7..12f1bd8ccdc9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -154,6 +154,9 @@ void tmc_disable_hw(struct tmc_drvdata *drvdata);
 /* ETB/ETF functions */
 int tmc_read_prepare_etf(struct tmc_drvdata *drvdata);
 int tmc_read_unprepare_etf(struct tmc_drvdata *drvdata);
+void tmc_update_etf_buffer(struct coresight_device *csdev,
+			   struct perf_output_handle *handle,
+			   void *sink_config);
 extern const struct coresight_ops tmc_etb_cs_ops;
 extern const struct coresight_ops tmc_etf_cs_ops;
 
-- 
2.1.4
