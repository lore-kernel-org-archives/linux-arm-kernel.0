From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 22 Apr 2016 11:14:13 -0600
Subject: [PATCH V3 16/18] coresight: tmc: implementing TMC-ETF AUX space API
In-Reply-To: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
References: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1461345255-11758-17-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implement the AUX area interfaces required to
use the TMC (configured as an ETF) from the Perf sub-system.

The heuristic is heavily borrowed from the ETB10 implementation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 198 ++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h     |   1 +
 2 files changed, 199 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 981c5ca75e36..4f38e8d185bc 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -15,7 +15,9 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/circ_buf.h>
 #include <linux/coresight.h>
+#include <linux/perf_event.h>
 #include <linux/slab.h>
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
@@ -287,9 +289,205 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 	dev_info(drvdata->dev, "TMC disabled\n");
 }
 
+static void *tmc_alloc_etf_buffer(struct coresight_device *csdev, int cpu,
+				  void **pages, int nr_pages, bool overwrite)
+{
+	int node;
+	struct cs_buffers *buf;
+
+	if (cpu == -1)
+		cpu = smp_processor_id();
+	node = cpu_to_node(cpu);
+
+	/* Allocate memory structure for interaction with Perf */
+	buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
+	if (!buf)
+		return NULL;
+
+	buf->snapshot = overwrite;
+	buf->nr_pages = nr_pages;
+	buf->data_pages = pages;
+
+	return buf;
+}
+
+static void tmc_free_etf_buffer(void *config)
+{
+	struct cs_buffers *buf = config;
+
+	kfree(buf);
+}
+
+static int tmc_set_etf_buffer(struct coresight_device *csdev,
+			      struct perf_output_handle *handle,
+			      void *sink_config)
+{
+	int ret = 0;
+	unsigned long head;
+	struct cs_buffers *buf = sink_config;
+
+	/* wrap head around to the amount of space we have */
+	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
+
+	/* find the page to write to */
+	buf->cur = head / PAGE_SIZE;
+
+	/* and offset within that page */
+	buf->offset = head % PAGE_SIZE;
+
+	local_set(&buf->data_size, 0);
+
+	return ret;
+}
+
+static unsigned long tmc_reset_etf_buffer(struct coresight_device *csdev,
+					  struct perf_output_handle *handle,
+					  void *sink_config, bool *lost)
+{
+	long size = 0;
+	struct cs_buffers *buf = sink_config;
+
+	if (buf) {
+		/*
+		 * In snapshot mode ->data_size holds the new address of the
+		 * ring buffer's head.  The size itself is the whole address
+		 * range since we want the latest information.
+		 */
+		if (buf->snapshot)
+			handle->head = local_xchg(&buf->data_size,
+						  buf->nr_pages << PAGE_SHIFT);
+		/*
+		 * Tell the tracer PMU how much we got in this run and if
+		 * something went wrong along the way.  Nobody else can use
+		 * this cs_buffers instance until we are done.  As such
+		 * resetting parameters here and squaring off with the ring
+		 * buffer API in the tracer PMU is fine.
+		 */
+		*lost = !!local_xchg(&buf->lost, 0);
+		size = local_xchg(&buf->data_size, 0);
+	}
+
+	return size;
+}
+
+static void tmc_update_etf_buffer(struct coresight_device *csdev,
+				  struct perf_output_handle *handle,
+				  void *sink_config)
+{
+	int i, cur;
+	u32 *buf_ptr;
+	u32 read_ptr, write_ptr;
+	u32 status, to_read;
+	unsigned long offset;
+	struct cs_buffers *buf = sink_config;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (!buf)
+		return;
+
+	/* This shouldn't happen */
+	if (WARN_ON_ONCE(local_read(&drvdata->mode) != CS_MODE_PERF))
+		return;
+
+	CS_UNLOCK(drvdata->base);
+
+	tmc_flush_and_stop(drvdata);
+
+	read_ptr = readl_relaxed(drvdata->base + TMC_RRP);
+	write_ptr = readl_relaxed(drvdata->base + TMC_RWP);
+
+	/*
+	 * Get a hold of the status register and see if a wrap around
+	 * has occurred.  If so adjust things accordingly.
+	 */
+	status = readl_relaxed(drvdata->base + TMC_STS);
+	if (status & TMC_STS_FULL) {
+		local_inc(&buf->lost);
+		to_read = drvdata->size;
+	} else {
+		to_read = CIRC_CNT(write_ptr, read_ptr, drvdata->size);
+	}
+
+	/*
+	 * The TMC RAM buffer may be bigger than the space available in the
+	 * perf ring buffer (handle->size).  If so advance the RRP so that we
+	 * get the latest trace data.
+	 */
+	if (to_read > handle->size) {
+		u32 mask = 0;
+
+		/*
+		 * The value written to RRP must be byte-address aligned to
+		 * the width of the trace memory databus _and_ to a frame
+		 * boundary (16 byte), whichever is the biggest. For example,
+		 * for 32-bit, 64-bit and 128-bit wide trace memory, the four
+		 * LSBs must be 0s. For 256-bit wide trace memory, the five
+		 * LSBs must be 0s.
+		 */
+		switch (drvdata->memwidth) {
+		case TMC_MEM_INTF_WIDTH_32BITS:
+		case TMC_MEM_INTF_WIDTH_64BITS:
+		case TMC_MEM_INTF_WIDTH_128BITS:
+			mask = GENMASK(31, 5);
+			break;
+		case TMC_MEM_INTF_WIDTH_256BITS:
+			mask = GENMASK(31, 6);
+			break;
+		}
+
+		/*
+		 * Make sure the new size is aligned in accordance with the
+		 * requirement explained above.
+		 */
+		to_read = handle->size & mask;
+		/* Move the RAM read pointer up */
+		read_ptr = (write_ptr + drvdata->size) - to_read;
+		/* Make sure we are still within our limits */
+		read_ptr &= ~(drvdata->size - 1);
+		/* Tell the HW */
+		writel_relaxed(read_ptr, drvdata->base + TMC_RRP);
+		local_inc(&buf->lost);
+	}
+
+	cur = buf->cur;
+	offset = buf->offset;
+
+	/* for every byte to read */
+	for (i = 0; i < to_read; i += 4) {
+		buf_ptr = buf->data_pages[cur] + offset;
+		*buf_ptr = readl_relaxed(drvdata->base + TMC_RRD);
+
+		offset += 4;
+		if (offset >= PAGE_SIZE) {
+			offset = 0;
+			cur++;
+			/* wrap around at the end of the buffer */
+			cur &= buf->nr_pages - 1;
+		}
+	}
+
+	/*
+	 * In snapshot mode all we have to do is communicate to
+	 * perf_aux_output_end() the address of the current head.  In full
+	 * trace mode the same function expects a size to move rb->aux_head
+	 * forward.
+	 */
+	if (buf->snapshot)
+		local_set(&buf->data_size, (cur * PAGE_SIZE) + offset);
+	else
+		local_add(to_read, &buf->data_size);
+
+	CS_LOCK(drvdata->base);
+}
+
 static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.enable		= tmc_enable_etf_sink,
 	.disable	= tmc_disable_etf_sink,
+	.alloc_buffer	= tmc_alloc_etf_buffer,
+	.free_buffer	= tmc_free_etf_buffer,
+	.set_buffer	= tmc_set_etf_buffer,
+	.reset_buffer	= tmc_reset_etf_buffer,
+	.update_buffer	= tmc_update_etf_buffer,
 };
 
 static const struct coresight_ops_link tmc_etf_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 12a097f3d06c..bb88e1a84d00 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -52,6 +52,7 @@
 #define TMC_CTL_CAPT_EN		BIT(0)
 /* TMC_STS - 0x00C */
 #define TMC_STS_TMCREADY_BIT	2
+#define TMC_STS_FULL		BIT(0)
 #define TMC_STS_TRIGGERED	BIT(1)
 /* TMC_AXICTL - 0x110 */
 #define TMC_AXICTL_PROT_CTL_B0	BIT(0)
-- 
2.5.0
