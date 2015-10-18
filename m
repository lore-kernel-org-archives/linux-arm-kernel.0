From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:37 -0600
Subject: [PATCH V2 20/30] coresight: etb10: implementing buffer set/reset() API
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-21-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing perf related APIs to activate and terminate
a trace session.  More specifically dealing with the sink
buffer's internal mechanic along with perf's API to start
and stop interactions with the ring buffers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 58 +++++++++++++++++++++++++++
 include/linux/coresight.h                     |  9 +++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 7f34e7af465e..ca2c4b42464d 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -28,6 +28,7 @@
 #include <linux/amba/bus.h>
 #include <linux/clk.h>
 #include <linux/mm.h>
+#include <linux/perf_event.h>
 
 #include <asm/local.h>
 
@@ -306,10 +307,67 @@ static void *etb_setup_aux(struct coresight_device *csdev, int cpu,
 	return buf;
 }
 
+static int etb_set_buffer(struct coresight_device *csdev,
+			  struct perf_output_handle *handle,
+			  void *sink_config)
+{
+	int ret = 0;
+	unsigned long head;
+	struct cs_buffers *buf = sink_config;
+	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	/* This sink can only be used by a single session */
+	if (local_xchg(&drvdata->in_use, 1))
+		return -EBUSY;
+
+	/* how much space do we have in this session */
+	buf->size = handle->size;
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
+	local_set(&buf->head, head);
+	local_set(&buf->data_size, 0);
+
+	return ret;
+}
+
+static void etb_reset_buffer(struct coresight_device *csdev,
+			     struct perf_output_handle *handle,
+			     void *sink_config)
+{
+	struct cs_buffers *buf = sink_config;
+	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
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
+
+		perf_aux_output_end(handle, local_xchg(&buf->data_size, 0),
+				    local_xchg(&buf->lost, 0));
+	}
+
+	local_set(&drvdata->in_use, 0);
+}
+
 static const struct coresight_ops_sink etb_sink_ops = {
 	.enable		= etb_enable,
 	.disable	= etb_disable,
 	.setup_aux	= etb_setup_aux,
+	.set_buffer	= etb_set_buffer,
+	.reset_buffer	= etb_reset_buffer,
 };
 
 static const struct coresight_ops etb_cs_ops = {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index b1c25eba83b4..78202d5ea58a 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -15,6 +15,7 @@
 
 #include <linux/device.h>
 #include <linux/sched.h>
+#include <linux/perf_event.h>
 
 /* Peripheral id registers (0xFD0-0xFEC) */
 #define CORESIGHT_PERIPHIDR4	0xfd0
@@ -188,12 +189,20 @@ struct coresight_device {
  * @enable:	enables the sink.
  * @disable:	disables the sink.
  * @setup_aux:	initialises perf's ring buffer for trace collection.
+ * @set_buffer:	initialises buffer mechanic before a trace session.
+ * @reset_buffer: finalises buffer mechanic after a trace session.
  */
 struct coresight_ops_sink {
 	int (*enable)(struct coresight_device *csdev);
 	void (*disable)(struct coresight_device *csdev);
 	void *(*setup_aux)(struct coresight_device *csdev, int cpu,
 			   void **pages, int nr_pages, bool overwrite);
+	int (*set_buffer)(struct coresight_device *csdev,
+			  struct perf_output_handle *handle,
+			  void *sink_config);
+	void (*reset_buffer)(struct coresight_device *csdev,
+			     struct perf_output_handle *handle,
+			     void *sink_config);
 };
 
 /**
-- 
1.9.1
