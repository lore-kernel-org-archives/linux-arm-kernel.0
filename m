From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Fri, 24 Aug 2018 20:15:25 +0530
Subject: [RFC PATCH v2 1/3] tracing: Add support for logging data to uncached
 buffer
In-Reply-To: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
Message-ID: <99bf205dd499ff916ce330f9a05c4d28f42c19e3.1535119711.git.saiprakash.ranjan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add RTB trace support to write data to a small uncached buffer.
When a system reset occurs, valuable data may still be remaining
in the cache (e.g. last printks) and this data will probably
be lost, giving an incomplete picture of what the system was last
doing. By logging useful information to this uncached region
(e.g. read/write{b,w,l,q}, last printk), a better picture of what the
system was last doing can be obtained.

Dummy platform device is created to use dma api to allocate
uncached memory. Also initialize dma_mask and coherent_dma_mask after
commit 4d8bde883bfb ("OF: Don't set default coherent DMA mask").

We add an additional property called rtb-size in ramoops device
tree node for pstore RTB buffer size and use the same in the
trace module. DT documentation has been modified to include this.

Information logged in this buffer include log type(read/write{b,w,l,q}),
timestamp, extra data from the caller, caller ip and name.
This can be extented as needed to include more options(e.g. cpu)
for better debugging.

Also RTB panic notifier with high priority is used to make sure that RTB
is disabled right after a kernel panic so that log buffer could be
prevented from being flooded with some I/O operations.

This is based on RTB driver in CAF. Link below:
  * https://source.codeaurora.org/quic/la/kernel/msm-4.9
Modified to support pstore for viewing traces.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 .../bindings/reserved-memory/ramoops.txt      |   7 +-
 include/linux/rtb.h                           |  24 +++
 kernel/trace/Kconfig                          |   7 +
 kernel/trace/Makefile                         |   2 +
 kernel/trace/trace_rtb.c                      | 143 ++++++++++++++++++
 5 files changed, 181 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/rtb.h
 create mode 100644 kernel/trace/trace_rtb.c

diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
index 0eba562fe5c6..f99019d1119b 100644
--- a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
@@ -14,8 +14,8 @@ Any remaining space will be used for a circular buffer of oops and panic
 records.  These records have a configurable size, with a size of 0 indicating
 that they should be disabled.
 
-At least one of "record-size", "console-size", "ftrace-size", or "pmsg-size"
-must be set non-zero, but are otherwise optional as listed below.
+At least one of "record-size", "console-size", "ftrace-size", "pmsg-size" or
+"rtb-size" must be set non-zero, but are otherwise optional as listed below.
 
 
 Required properties:
@@ -42,6 +42,9 @@ Optional properties:
 - pmsg-size: size in bytes of log buffer reserved for userspace messages
   (defaults to 0: disabled)
 
+- rtb-size: size in bytes of log buffer reserved for RTB buffer traces.
+  (defaults to 0: disabled)
+
 - unbuffered: if present, use unbuffered mappings to map the reserved region
   (defaults to buffered mappings)
 
diff --git a/include/linux/rtb.h b/include/linux/rtb.h
new file mode 100644
index 000000000000..a969bd020466
--- /dev/null
+++ b/include/linux/rtb.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _RTB_H
+#define _RTB_H
+
+struct rtb_layout {
+	const char *log_type;
+	u32 idx;
+	u64 caller;
+	u64 data;
+	u64 timestamp;
+} __attribute__ ((__packed__));
+
+#if defined(CONFIG_RTB)
+void uncached_logk(const char *log_type, void *data);
+int rtb_init(void);
+void rtb_exit(void);
+#else
+static inline void uncached_logk(const char *log_type,
+				void *data) { }
+static inline int rtb_init(void) { return 0; }
+static inline void rtb_exit(void) { }
+#endif
+
+#endif /* _RTB_H */
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index c042a455afc6..fd46c7e0016f 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -774,6 +774,13 @@ config TRACING_EVENTS_GPIO
 	help
 	  Enable tracing events for gpio subsystem
 
+config RTB
+	bool "Register Trace Buffer"
+	help
+	  Add support for logging different events to a small uncached
+	  region. This is designed to aid in debugging reset cases where the
+	  caches may not be flushed before the target resets.
+
 endif # FTRACE
 
 endif # TRACING_SUPPORT
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 98d53b39a8ee..0b8167124354 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -78,4 +78,6 @@ obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 
+obj-$(CONFIG_RTB) += trace_rtb.o
+
 libftrace-y := ftrace.o
diff --git a/kernel/trace/trace_rtb.c b/kernel/trace/trace_rtb.c
new file mode 100644
index 000000000000..3e0a85e7b504
--- /dev/null
+++ b/kernel/trace/trace_rtb.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 The Linux Foundation. All rights reserved.
+ */
+#include <linux/atomic.h>
+#include <linux/dma-mapping.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/rtb.h>
+#include <linux/sched/clock.h>
+
+static struct platform_device *rtb_dev;
+static atomic_t rtb_idx;
+
+struct rtb_state {
+	struct rtb_layout *rtb;
+	phys_addr_t phys;
+	unsigned int nentries;
+	unsigned int size;
+	int enabled;
+};
+
+/* RTB is enabled after pstore is registered, so let enabled flag be 0 */
+static struct rtb_state rtb;
+
+static int rtb_panic_notifier(struct notifier_block *this,
+					unsigned long event, void *ptr)
+{
+	rtb.enabled = 0;
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block rtb_panic_blk = {
+	.notifier_call  = rtb_panic_notifier,
+	.priority = INT_MAX,
+};
+
+static void uncached_logk_pc_idx(const char *log_type, u64 caller,
+				u64 data, int idx)
+{
+	struct rtb_layout *start;
+
+	start = &rtb.rtb[idx & (rtb.nentries - 1)];
+
+	start->log_type = log_type;
+	start->caller = caller;
+	start->data = data;
+	start->timestamp = sched_clock();
+	/* Make sure data is written */
+	mb();
+}
+
+static int rtb_get_idx(void)
+{
+	int i, offset;
+
+	i = atomic_inc_return(&rtb_idx);
+	i--;
+
+	/* Check if index has wrapped around */
+	offset = (i & (rtb.nentries - 1)) -
+		 ((i - 1) & (rtb.nentries - 1));
+	if (offset < 0) {
+		i = atomic_inc_return(&rtb_idx);
+		i--;
+	}
+
+	return i;
+}
+
+noinline void uncached_logk(const char *log_type, void *data)
+{
+	int i;
+
+	if (!rtb.enabled)
+		return;
+
+	i = rtb_get_idx();
+	uncached_logk_pc_idx(log_type, (u64)(__builtin_return_address(0)),
+				(u64)(data), i);
+}
+EXPORT_SYMBOL(uncached_logk);
+
+int rtb_init(void)
+{
+	struct device_node *np;
+	u64 rtb_dmamask = DMA_BIT_MASK(32);
+	u32 size;
+	int ret;
+
+	np = of_find_node_by_name(NULL, "ramoops");
+	if (!np)
+		return -ENODEV;
+
+	ret = of_property_read_u32(np, "rtb-size", &size);
+	if (ret) {
+		of_node_put(np);
+		return ret;
+	}
+
+	rtb.size = size;
+
+	/* Create a dummy platform device to use dma api */
+	rtb_dev = platform_device_register_simple("rtb", -1, NULL, 0);
+	if (IS_ERR(rtb_dev))
+		return PTR_ERR(rtb_dev);
+
+	/* Initialize dma_mask and coherent_dma_mask to 32-bits */
+	rtb_dev->dev.dma_mask = &rtb_dmamask;
+	rtb_dev->dev.coherent_dma_mask = rtb_dmamask;
+
+	/*
+	 * The device is a dummy, so arch_setup_dma_ops
+	 * is not called, thus leaving the device with dummy DMA ops
+	 * which returns null in case of arm64.
+	 */
+	of_dma_configure(&rtb_dev->dev, NULL, true);
+	rtb.rtb = dma_alloc_coherent(&rtb_dev->dev, rtb.size,
+					&rtb.phys, GFP_KERNEL);
+	if (!rtb.rtb)
+		return -ENOMEM;
+
+	rtb.nentries = rtb.size / sizeof(struct rtb_layout);
+	/* Round this down to a power of 2 */
+	rtb.nentries = __rounddown_pow_of_two(rtb.nentries);
+
+	memset(rtb.rtb, 0, rtb.size);
+	atomic_set(&rtb_idx, 0);
+
+	atomic_notifier_chain_register(&panic_notifier_list,
+						&rtb_panic_blk);
+	rtb.enabled = 1;
+	return 0;
+}
+
+void rtb_exit(void)
+{
+	dma_free_coherent(&rtb_dev->dev, rtb.size, rtb.rtb, rtb.phys);
+	platform_device_unregister(rtb_dev);
+}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
