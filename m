From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 21 Dec 2017 16:20:12 +0800
Subject: [PATCH v3 3/6] coresight: Support panic kdump functionality
In-Reply-To: <1513844415-11427-1-git-send-email-leo.yan@linaro.org>
References: <1513844415-11427-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1513844415-11427-4-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After kernel panic happens, coresight has many useful info can be used
for analysis.  For example, the trace info from ETB RAM can be used to
check the CPU execution flows before crash.  So we can save the tracing
data from sink devices, and rely on kdump to save DDR content and uses
"crash" tool to extract coresight dumping from vmcore file.

This patch is to add a simple framework to support panic dump
functionality; it registers panic notifier, and provide the general APIs
{coresight_kdump_add|coresight_kdump_del} as helper functions so any
coresight device can add itself into dump list or delete as needed.

This driver provides helper function coresight_kdump_update() to update
the dump buffer base address and buffer size.  This function can be used
by coresight driver, e.g. it can be used to save ETM meta data info at
runtime and these info can be prepared pre panic happening.

When kernel panic happens, the notifier iterates dump list and calls
callback function to dump device specific info.  The panic dump is
mainly used to dump trace data so we can get to know the execution flow
before the panic happens.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig                |   9 ++
 drivers/hwtracing/coresight/Makefile               |   1 +
 .../hwtracing/coresight/coresight-panic-kdump.c    | 154 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-priv.h       |  13 ++
 include/linux/coresight.h                          |   7 +
 5 files changed, 184 insertions(+)
 create mode 100644 drivers/hwtracing/coresight/coresight-panic-kdump.c

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index ef9cb3c..4812529 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -103,4 +103,13 @@ config CORESIGHT_CPU_DEBUG
 	  properly, please refer Documentation/trace/coresight-cpu-debug.txt
 	  for detailed description and the example for usage.
 
+config CORESIGHT_PANIC_KDUMP
+	bool "CoreSight Panic Kdump driver"
+	depends on ARM || ARM64
+	help
+	  This driver provides panic kdump functionality for CoreSight
+	  devices.  When a kernel panic happen a device supplied callback function
+	  is used to save trace data to memory. From there we rely on kdump to extract
+	  the trace data from kernel dump file.
+
 endif
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 61db9dd..946fe19 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
 obj-$(CONFIG_CORESIGHT_DYNAMIC_REPLICATOR) += coresight-dynamic-replicator.o
 obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
 obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
+obj-$(CONFIG_CORESIGHT_PANIC_KDUMP) += coresight-panic-kdump.o
diff --git a/drivers/hwtracing/coresight/coresight-panic-kdump.c b/drivers/hwtracing/coresight/coresight-panic-kdump.c
new file mode 100644
index 0000000..c21d20b
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-panic-kdump.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Linaro Limited.
+#include <linux/coresight.h>
+#include <linux/coresight-pmu.h>
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "coresight-priv.h"
+
+typedef void (*coresight_cb_t)(void *data);
+
+/**
+ * struct coresight_kdump_node - Node information for dump
+ * @cpu:	The cpu this node is affined to.
+ * @csdev:	Handler for coresight device.
+ * @buf:	Pointer for dump buffer.
+ * @buf_size:	Length of dump buffer.
+ * @list:	Hook to the list.
+ */
+struct coresight_kdump_node {
+	int cpu;
+	struct coresight_device *csdev;
+	char *buf;
+	unsigned int buf_size;
+	struct list_head list;
+};
+
+static DEFINE_SPINLOCK(coresight_kdump_lock);
+static LIST_HEAD(coresight_kdump_list);
+static struct notifier_block coresight_kdump_nb;
+
+int coresight_kdump_update(struct coresight_device *csdev, char *buf,
+			   unsigned int buf_size)
+{
+	struct coresight_kdump_node *node = csdev->dump_node;
+
+	if (!node) {
+		dev_err(&csdev->dev, "Failed to update dump node.\n");
+		return -EINVAL;
+	}
+
+	node->buf = buf;
+	node->buf_size = buf_size;
+	return 0;
+}
+
+int coresight_kdump_add(struct coresight_device *csdev, int cpu)
+{
+	struct coresight_kdump_node *node;
+	unsigned long flags;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	csdev->dump_node = (void *)node;
+	node->cpu = cpu;
+	node->csdev = csdev;
+
+	spin_lock_irqsave(&coresight_kdump_lock, flags);
+	list_add_tail(&node->list, &coresight_kdump_list);
+	spin_unlock_irqrestore(&coresight_kdump_lock, flags);
+	return 0;
+}
+
+void coresight_kdump_del(struct coresight_device *csdev)
+{
+	struct coresight_kdump_node *node, *next;
+	unsigned long flags;
+
+	spin_lock_irqsave(&coresight_kdump_lock, flags);
+	list_for_each_entry_safe(node, next, &coresight_kdump_list, list) {
+		if (node->csdev == csdev) {
+			list_del(&node->list);
+			kfree(node);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&coresight_kdump_lock, flags);
+}
+
+static coresight_cb_t
+coresight_kdump_get_cb(struct coresight_device *csdev)
+{
+	coresight_cb_t cb = NULL;
+
+	switch (csdev->type) {
+	case CORESIGHT_DEV_TYPE_SINK:
+	case CORESIGHT_DEV_TYPE_LINKSINK:
+		cb = sink_ops(csdev)->panic_cb;
+		break;
+	case CORESIGHT_DEV_TYPE_SOURCE:
+		cb = source_ops(csdev)->panic_cb;
+		break;
+	case CORESIGHT_DEV_TYPE_LINK:
+		cb = link_ops(csdev)->panic_cb;
+		break;
+	default:
+		dev_info(&csdev->dev, "Unsupport panic dump\n");
+		break;
+	}
+
+	return cb;
+}
+
+/**
+ * coresight_kdump_notify - Invoke panic dump callbacks, this is
+ * the main function to fulfill the panic dump.  It distinguishs
+ * to two types: one is pre panic dump which the callback function
+ * handler is NULL and coresight drivers can use function
+ * coresight_kdump_update() to directly update dump buffer base
+ * address and buffer size, for this case this function does nothing
+ * and directly bail out; another case is for post panic dump so
+ * invoke callback on alive CPU.
+ *
+ * Returns: 0 on success.
+ */
+static int coresight_kdump_notify(struct notifier_block *nb,
+				  unsigned long mode, void *_unused)
+{
+	struct coresight_kdump_node *node;
+	struct coresight_device *csdev;
+	coresight_cb_t cb;
+	unsigned long flags;
+
+	spin_lock_irqsave(&coresight_kdump_lock, flags);
+
+	list_for_each_entry(node, &coresight_kdump_list, list) {
+		csdev = node->csdev;
+		cb = coresight_kdump_get_cb(csdev);
+		if (cb)
+			cb(csdev);
+	}
+
+	spin_unlock_irqrestore(&coresight_kdump_lock, flags);
+	return 0;
+}
+
+static int __init coresight_kdump_init(void)
+{
+	int ret;
+
+	coresight_kdump_nb.notifier_call = coresight_kdump_notify;
+	ret = atomic_notifier_chain_register(&panic_notifier_list,
+					     &coresight_kdump_nb);
+	return ret;
+}
+late_initcall(coresight_kdump_init);
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index f1d0e21d..937750e 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -151,4 +151,17 @@ static inline int etm_readl_cp14(u32 off, unsigned int *val) { return 0; }
 static inline int etm_writel_cp14(u32 off, u32 val) { return 0; }
 #endif
 
+#ifdef CONFIG_CORESIGHT_PANIC_KDUMP
+extern int coresight_kdump_add(struct coresight_device *csdev, int cpu);
+extern void coresight_kdump_del(struct coresight_device *csdev);
+extern int coresight_kdump_update(struct coresight_device *csdev,
+				  char *buf, unsigned int buf_size);
+#else
+static inline int
+coresight_kdump_add(struct coresight_device *csdev, int cpu) { return 0; }
+static inline void coresight_kdump_del(struct coresight_device *csdev) {}
+static inline int coresight_kdump_update(struct coresight_device *csdev,
+	char *buf, unsigned int buf_size) { return 0; }
+#endif
+
 #endif
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index d950dad..43e40fa 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -171,6 +171,7 @@ struct coresight_device {
 	bool orphan;
 	bool enable;	/* true only if configured as part of a path */
 	bool activated;	/* true only if a sink is part of a path */
+	void *dump_node;
 };
 
 #define to_coresight_device(d) container_of(d, struct coresight_device, dev)
@@ -189,6 +190,7 @@ struct coresight_device {
  * @set_buffer:		initialises buffer mechanic before a trace session.
  * @reset_buffer:	finalises buffer mechanic after a trace session.
  * @update_buffer:	update buffer pointers after a trace session.
+ * @panic_cb:		hook function for panic notifier.
  */
 struct coresight_ops_sink {
 	int (*enable)(struct coresight_device *csdev, u32 mode);
@@ -205,6 +207,7 @@ struct coresight_ops_sink {
 	void (*update_buffer)(struct coresight_device *csdev,
 			      struct perf_output_handle *handle,
 			      void *sink_config);
+	void (*panic_cb)(void *data);
 };
 
 /**
@@ -212,10 +215,12 @@ struct coresight_ops_sink {
  * Operations available for links.
  * @enable:	enables flow between iport and oport.
  * @disable:	disables flow between iport and oport.
+ * @panic_cb:	hook function for panic notifier.
  */
 struct coresight_ops_link {
 	int (*enable)(struct coresight_device *csdev, int iport, int oport);
 	void (*disable)(struct coresight_device *csdev, int iport, int oport);
+	void (*panic_cb)(void *data);
 };
 
 /**
@@ -227,6 +232,7 @@ struct coresight_ops_link {
  *		to the HW.
  * @enable:	enables tracing for a source.
  * @disable:	disables tracing for a source.
+ * @panic_cb:	hook function for panic notifier.
  */
 struct coresight_ops_source {
 	int (*cpu_id)(struct coresight_device *csdev);
@@ -235,6 +241,7 @@ struct coresight_ops_source {
 		      struct perf_event *event,  u32 mode);
 	void (*disable)(struct coresight_device *csdev,
 			struct perf_event *event);
+	void (*panic_cb)(void *data);
 };
 
 struct coresight_ops {
-- 
2.7.4
