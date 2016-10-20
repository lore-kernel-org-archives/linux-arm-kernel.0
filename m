From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 20 Oct 2016 11:30:39 +0200
Subject: [PATCH v3 3/5] arm64: perf: Cavium ThunderX L2C CBC uncore support
In-Reply-To: <1476955841-27898-1-git-send-email-jglauber@cavium.com>
References: <1476955841-27898-1-git-send-email-jglauber@cavium.com>
Message-ID: <1476955841-27898-4-git-send-email-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support counters of the L2 cache crossbar connect.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/perf/uncore/Makefile                |   3 +-
 drivers/perf/uncore/uncore_cavium.c         |   1 +
 drivers/perf/uncore/uncore_cavium.h         |   1 +
 drivers/perf/uncore/uncore_cavium_l2c_cbc.c | 148 ++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/uncore/uncore_cavium_l2c_cbc.c

diff --git a/drivers/perf/uncore/Makefile b/drivers/perf/uncore/Makefile
index 90850a2..d5ef3db 100644
--- a/drivers/perf/uncore/Makefile
+++ b/drivers/perf/uncore/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_UNCORE_PMU_CAVIUM) += uncore_cavium.o		\
-				   uncore_cavium_l2c_tad.o
+				   uncore_cavium_l2c_tad.o	\
+				   uncore_cavium_l2c_cbc.o
diff --git a/drivers/perf/uncore/uncore_cavium.c b/drivers/perf/uncore/uncore_cavium.c
index 15e1aec..051f0fa 100644
--- a/drivers/perf/uncore/uncore_cavium.c
+++ b/drivers/perf/uncore/uncore_cavium.c
@@ -347,6 +347,7 @@ static int __init thunder_uncore_init(void)
 		return ret;
 
 	thunder_uncore_l2c_tad_setup();
+	thunder_uncore_l2c_cbc_setup();
 	return 0;
 }
 late_initcall(thunder_uncore_init);
diff --git a/drivers/perf/uncore/uncore_cavium.h b/drivers/perf/uncore/uncore_cavium.h
index 70a8214..91d674a 100644
--- a/drivers/perf/uncore/uncore_cavium.h
+++ b/drivers/perf/uncore/uncore_cavium.h
@@ -70,3 +70,4 @@ ssize_t thunder_events_sysfs_show(struct device *dev,
 				  struct device_attribute *attr,
 				  char *page);
 int thunder_uncore_l2c_tad_setup(void);
+int thunder_uncore_l2c_cbc_setup(void);
diff --git a/drivers/perf/uncore/uncore_cavium_l2c_cbc.c b/drivers/perf/uncore/uncore_cavium_l2c_cbc.c
new file mode 100644
index 0000000..4d6c2c4
--- /dev/null
+++ b/drivers/perf/uncore/uncore_cavium_l2c_cbc.c
@@ -0,0 +1,148 @@
+/*
+ * Cavium Thunder uncore PMU support, L2 Cache,
+ * Crossbar connect (CBC) counters.
+ *
+ * Copyright 2016 Cavium Inc.
+ * Author: Jan Glauber <jan.glauber@cavium.com>
+ */
+
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+
+#include "uncore_cavium.h"
+
+struct thunder_uncore *thunder_uncore_l2c_cbc;
+
+/* L2C CBC event list */
+#define L2C_CBC_EVENT_XMC0		0x00
+#define L2C_CBC_EVENT_XMD0		0x08
+#define L2C_CBC_EVENT_RSC0		0x10
+#define L2C_CBC_EVENT_RSD0		0x18
+#define L2C_CBC_EVENT_INV0		0x20
+#define L2C_CBC_EVENT_IOC0		0x28
+#define L2C_CBC_EVENT_IOR0		0x30
+#define L2C_CBC_EVENT_XMC1		0x40
+#define L2C_CBC_EVENT_XMD1		0x48
+#define L2C_CBC_EVENT_RSC1		0x50
+#define L2C_CBC_EVENT_RSD1		0x58
+#define L2C_CBC_EVENT_INV1		0x60
+#define L2C_CBC_EVENT_XMC2		0x80
+#define L2C_CBC_EVENT_XMD2		0x88
+#define L2C_CBC_EVENT_RSC2		0x90
+#define L2C_CBC_EVENT_RSD2		0x98
+
+static int l2c_cbc_events[] = {
+	L2C_CBC_EVENT_XMC0,
+	L2C_CBC_EVENT_XMD0,
+	L2C_CBC_EVENT_RSC0,
+	L2C_CBC_EVENT_RSD0,
+	L2C_CBC_EVENT_INV0,
+	L2C_CBC_EVENT_IOC0,
+	L2C_CBC_EVENT_IOR0,
+	L2C_CBC_EVENT_XMC1,
+	L2C_CBC_EVENT_XMD1,
+	L2C_CBC_EVENT_RSC1,
+	L2C_CBC_EVENT_RSD1,
+	L2C_CBC_EVENT_INV1,
+	L2C_CBC_EVENT_XMC2,
+	L2C_CBC_EVENT_XMD2,
+	L2C_CBC_EVENT_RSC2,
+	L2C_CBC_EVENT_RSD2,
+};
+
+static int thunder_uncore_add_l2c_cbc(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	return thunder_uncore_add(event, flags, 0,
+				  l2c_cbc_events[get_id(hwc->config)]);
+}
+
+PMU_FORMAT_ATTR(event, "config:0-4");
+
+static struct attribute *thunder_l2c_cbc_format_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_node.attr,
+	NULL,
+};
+
+static struct attribute_group thunder_l2c_cbc_format_group = {
+	.name = "format",
+	.attrs = thunder_l2c_cbc_format_attr,
+};
+
+static struct attribute *thunder_l2c_cbc_events_attr[] = {
+	UC_EVENT_ENTRY(xmc0, 0),
+	UC_EVENT_ENTRY(xmd0, 1),
+	UC_EVENT_ENTRY(rsc0, 2),
+	UC_EVENT_ENTRY(rsd0, 3),
+	UC_EVENT_ENTRY(inv0, 4),
+	UC_EVENT_ENTRY(ioc0, 5),
+	UC_EVENT_ENTRY(ior0, 6),
+	UC_EVENT_ENTRY(xmc1, 7),
+	UC_EVENT_ENTRY(xmd1, 8),
+	UC_EVENT_ENTRY(rsc1, 9),
+	UC_EVENT_ENTRY(rsd1, 10),
+	UC_EVENT_ENTRY(inv1, 11),
+	UC_EVENT_ENTRY(xmc2, 12),
+	UC_EVENT_ENTRY(xmd2, 13),
+	UC_EVENT_ENTRY(rsc2, 14),
+	UC_EVENT_ENTRY(rsd2, 15),
+	NULL,
+};
+
+static struct attribute_group thunder_l2c_cbc_events_group = {
+	.name = "events",
+	.attrs = thunder_l2c_cbc_events_attr,
+};
+
+static const struct attribute_group *thunder_l2c_cbc_attr_groups[] = {
+	&thunder_uncore_attr_group,
+	&thunder_l2c_cbc_format_group,
+	&thunder_l2c_cbc_events_group,
+	NULL,
+};
+
+struct pmu thunder_l2c_cbc_pmu = {
+	.name		= "thunder_l2c_cbc",
+	.task_ctx_nr    = perf_sw_context,
+	.event_init	= thunder_uncore_event_init,
+	.add		= thunder_uncore_add_l2c_cbc,
+	.del		= thunder_uncore_del,
+	.start		= thunder_uncore_start,
+	.stop		= thunder_uncore_stop,
+	.read		= thunder_uncore_read,
+	.attr_groups	= thunder_l2c_cbc_attr_groups,
+};
+
+static bool event_valid(u64 config)
+{
+	if (config < ARRAY_SIZE(l2c_cbc_events))
+		return true;
+
+	return false;
+}
+
+int __init thunder_uncore_l2c_cbc_setup(void)
+{
+	int ret = -ENOMEM;
+
+	thunder_uncore_l2c_cbc = kzalloc(sizeof(*thunder_uncore_l2c_cbc),
+					 GFP_KERNEL);
+	if (!thunder_uncore_l2c_cbc)
+		goto fail_nomem;
+
+	ret = thunder_uncore_setup(thunder_uncore_l2c_cbc, 0xa02f,
+				   &thunder_l2c_cbc_pmu,
+				   ARRAY_SIZE(l2c_cbc_events));
+	if (ret)
+		goto fail;
+
+	thunder_uncore_l2c_cbc->event_valid = event_valid;
+	return 0;
+
+fail:
+	kfree(thunder_uncore_l2c_cbc);
+fail_nomem:
+	return ret;
+}
-- 
1.9.1
