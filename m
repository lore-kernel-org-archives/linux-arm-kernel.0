From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:21 -0600
Subject: [RFC PATCH 07/20] coresight: etb10: implementing the setup_aux() API
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding an ETB10 specific auxiliary area setup operation to be
used by the perf framework when events are initialised.

Part of this operation involves modeling the mmap'ed area based
on the specific ways a sink buffer gathers information.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 55 +++++++++++++++++++++++++++
 include/linux/coresight.h                     |  3 ++
 2 files changed, 58 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 77d0f9c1118d..ca2fbf65a454 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -27,6 +27,9 @@
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
 #include <linux/clk.h>
+#include <linux/mm.h>
+
+#include <asm/local.h>
 
 #include "coresight-priv.h"
 
@@ -64,6 +67,32 @@
 #define ETB_FRAME_SIZE_WORDS	4
 
 /**
+ * struct cs_buffer - keep track of a recording session' specifics
+ * @cur:	index of the current buffer
+ * @nr_pages:	max number of pages granted to us
+ * @nr_bufs:	number of clustered pages
+ * @offset:	offset within the current buffer
+ * @size:	how much space we have for this run
+ * @data_size:	how much we collected in this run
+ * @head:	head of the ring buffer
+ * @lost:	other than zero if we had a HW buffer wrap around
+ * @snapshot:	is this run in snapshot mode
+ * @addr:	virtual address this buffer starts at
+ */
+struct cs_buffers {
+	unsigned int		cur;
+	unsigned int		nr_pages;
+	unsigned int		nr_bufs;
+	unsigned long		offset;
+	unsigned long		size;
+	local_t			data_size;
+	local_t			head;
+	local_t			lost;
+	bool			snapshot;
+	void			*addr[0];
+};
+
+/**
  * struct etb_drvdata - specifics associated to an ETB component
  * @base:	memory mapped base address for this component.
  * @dev:	the device entity associated to this component.
@@ -252,9 +281,35 @@ static void etb_disable(struct coresight_device *csdev)
 	dev_info(drvdata->dev, "ETB disabled\n");
 }
 
+static void *etb_setup_aux(struct coresight_device *csdev, int cpu,
+			   void **pages, int nr_pages, bool overwrite)
+{
+	int node, pg;
+	struct cs_buffers *buf;
+
+	if (cpu == -1)
+		cpu = smp_processor_id();
+	node = cpu_to_node(cpu);
+
+	buf = kzalloc_node(offsetof(struct cs_buffers, addr[nr_pages]),
+			   GFP_KERNEL, node);
+	if (!buf)
+		return NULL;
+
+	buf->snapshot = overwrite;
+	buf->nr_pages = nr_pages;
+
+	/* Record information about buffers */
+	for (pg = 0; pg < buf->nr_pages; pg++)
+		buf->addr[pg] = pages[pg];
+
+	return buf;
+}
+
 static const struct coresight_ops_sink etb_sink_ops = {
 	.enable		= etb_enable,
 	.disable	= etb_disable,
+	.setup_aux	= etb_setup_aux,
 };
 
 static const struct coresight_ops etb_cs_ops = {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 9fe2ccf1cc36..71cc23709422 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -185,10 +185,13 @@ struct coresight_device {
  * Operations available for sinks
  * @enable:	enables the sink.
  * @disable:	disables the sink.
+ * @setup_aux:	initialises perf's ring buffer for trace collection.
  */
 struct coresight_ops_sink {
 	int (*enable)(struct coresight_device *csdev);
 	void (*disable)(struct coresight_device *csdev);
+	void *(*setup_aux)(struct coresight_device *csdev, int cpu,
+			   void **pages, int nr_pages, bool overwrite);
 };
 
 /**
-- 
1.9.1
