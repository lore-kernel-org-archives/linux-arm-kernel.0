From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:22 -0600
Subject: [RFC PATCH 08/20] coresight: etb10: implementing buffer set and unset
 APIs
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing perf related APIs to activate and terminate
a trace session.  More specifically dealing with the sink
buffer's internal mechanic along with perf's API to start
and stop interactions with the ring buffers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 42 +++++++++++++++++++++++++++
 include/linux/coresight.h                     |  8 +++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index ca2fbf65a454..3239036f4609 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -28,6 +28,7 @@
 #include <linux/amba/bus.h>
 #include <linux/clk.h>
 #include <linux/mm.h>
+#include <linux/perf_event.h>
 
 #include <asm/local.h>
 
@@ -306,10 +307,51 @@ static void *etb_setup_aux(struct coresight_device *csdev, int cpu,
 	return buf;
 }
 
+static int etb_set_buffer(struct coresight_device *csdev,
+			  struct perf_event *event,
+			  struct perf_output_handle *handle)
+{
+	unsigned long head;
+	struct cs_buffers *buf;
+
+	buf = perf_aux_output_begin(handle, event);
+	if (!buf)
+		return -EINVAL;
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
+	return 0;
+}
+
+static void etb_unset_buffer(struct coresight_device *csdev,
+			     struct perf_output_handle *handle)
+{
+	struct cs_buffers *buf = perf_get_aux(handle);
+
+	if (buf)
+		perf_aux_output_end(handle, local_xchg(&buf->data_size, 0),
+				    local_xchg(&buf->lost, 0));
+}
+
 static const struct coresight_ops_sink etb_sink_ops = {
 	.enable		= etb_enable,
 	.disable	= etb_disable,
 	.setup_aux	= etb_setup_aux,
+	.set_buffer	= etb_set_buffer,
+	.unset_buffer	= etb_unset_buffer,
 };
 
 static const struct coresight_ops etb_cs_ops = {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 71cc23709422..25bdce345ec3 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -15,6 +15,7 @@
 
 #include <linux/device.h>
 #include <linux/sched.h>
+#include <linux/perf_event.h>
 
 /* Peripheral id registers (0xFD0-0xFEC) */
 #define CORESIGHT_PERIPHIDR4	0xfd0
@@ -186,12 +187,19 @@ struct coresight_device {
  * @enable:	enables the sink.
  * @disable:	disables the sink.
  * @setup_aux:	initialises perf's ring buffer for trace collection.
+ * @set_buffer:	initialises buffer mechanic before a trace session.
+ * @unset_buffer: finalises buffer mechanic after a trace session.
  */
 struct coresight_ops_sink {
 	int (*enable)(struct coresight_device *csdev);
 	void (*disable)(struct coresight_device *csdev);
 	void *(*setup_aux)(struct coresight_device *csdev, int cpu,
 			   void **pages, int nr_pages, bool overwrite);
+	int (*set_buffer)(struct coresight_device *csdev,
+			  struct perf_event *event,
+			  struct perf_output_handle *handle);
+	void (*unset_buffer)(struct coresight_device *csdev,
+			     struct perf_output_handle *handle);
 };
 
 /**
-- 
1.9.1
