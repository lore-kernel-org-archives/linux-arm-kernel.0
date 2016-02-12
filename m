From: jglauber@cavium.com (Jan Glauber)
Date: Fri, 12 Feb 2016 17:55:08 +0100
Subject: [RFC PATCH 3/7] arm64/perf: Cavium ThunderX L2C CBC uncore support
In-Reply-To: <cover.1455295032.git.jglauber@cavium.com>
References: <cover.1455295032.git.jglauber@cavium.com>
Message-ID: <c3cf1244e1d635fa84ddb830f7dbb29bc6f88eea.1455295032.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support counters of the L2 cache crossbar connect.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 arch/arm64/kernel/uncore/Makefile                |   3 +-
 arch/arm64/kernel/uncore/uncore_cavium.c         |   3 +
 arch/arm64/kernel/uncore/uncore_cavium.h         |   4 +
 arch/arm64/kernel/uncore/uncore_cavium_l2c_cbc.c | 239 +++++++++++++++++++++++
 4 files changed, 248 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/uncore/uncore_cavium_l2c_cbc.c

diff --git a/arch/arm64/kernel/uncore/Makefile b/arch/arm64/kernel/uncore/Makefile
index 6a16caf..d52ecc9 100644
--- a/arch/arm64/kernel/uncore/Makefile
+++ b/arch/arm64/kernel/uncore/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ARCH_THUNDER) += uncore_cavium.o		\
-			      uncore_cavium_l2c_tad.o
+			      uncore_cavium_l2c_tad.o	\
+			      uncore_cavium_l2c_cbc.o
diff --git a/arch/arm64/kernel/uncore/uncore_cavium.c b/arch/arm64/kernel/uncore/uncore_cavium.c
index b625caf..0304c60 100644
--- a/arch/arm64/kernel/uncore/uncore_cavium.c
+++ b/arch/arm64/kernel/uncore/uncore_cavium.c
@@ -24,6 +24,8 @@ struct thunder_uncore *event_to_thunder_uncore(struct perf_event *event)
 {
 	if (event->pmu->type == thunder_l2c_tad_pmu.type)
 		return thunder_uncore_l2c_tad;
+	else if (event->pmu->type == thunder_l2c_cbc_pmu.type)
+		return thunder_uncore_l2c_cbc;
 	else
 		return NULL;
 }
@@ -209,6 +211,7 @@ static int __init thunder_uncore_init(void)
 	pr_info("PMU version: %d\n", thunder_uncore_version);
 
 	thunder_uncore_l2c_tad_setup();
+	thunder_uncore_l2c_cbc_setup();
 	return 0;
 }
 late_initcall(thunder_uncore_init);
diff --git a/arch/arm64/kernel/uncore/uncore_cavium.h b/arch/arm64/kernel/uncore/uncore_cavium.h
index 90e6a2d..74f44d7 100644
--- a/arch/arm64/kernel/uncore/uncore_cavium.h
+++ b/arch/arm64/kernel/uncore/uncore_cavium.h
@@ -14,6 +14,7 @@
 
 enum uncore_type {
 	L2C_TAD_TYPE,
+	L2C_CBC_TYPE,
 };
 
 extern int thunder_uncore_version;
@@ -60,7 +61,9 @@ static inline void __iomem *map_offset(unsigned long addr,
 
 extern struct attribute_group thunder_uncore_attr_group;
 extern struct thunder_uncore *thunder_uncore_l2c_tad;
+extern struct thunder_uncore *thunder_uncore_l2c_cbc;
 extern struct pmu thunder_l2c_tad_pmu;
+extern struct pmu thunder_l2c_cbc_pmu;
 
 /* Prototypes */
 struct thunder_uncore *event_to_thunder_uncore(struct perf_event *event);
@@ -75,3 +78,4 @@ ssize_t thunder_events_sysfs_show(struct device *dev,
 				  char *page);
 
 int thunder_uncore_l2c_tad_setup(void);
+int thunder_uncore_l2c_cbc_setup(void);
diff --git a/arch/arm64/kernel/uncore/uncore_cavium_l2c_cbc.c b/arch/arm64/kernel/uncore/uncore_cavium_l2c_cbc.c
new file mode 100644
index 0000000..f1ba9be
--- /dev/null
+++ b/arch/arm64/kernel/uncore/uncore_cavium_l2c_cbc.c
@@ -0,0 +1,239 @@
+/*
+ * Cavium Thunder uncore PMU support, L2C CBC counters.
+ *
+ * Copyright 2016 Cavium Inc.
+ * Author: Jan Glauber <jan.glauber@cavium.com>
+ */
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/io.h>
+#include <linux/perf_event.h>
+#include <linux/pci.h>
+
+#include <asm/cpufeature.h>
+#include <asm/cputype.h>
+
+#include "uncore_cavium.h"
+
+#ifndef PCI_DEVICE_ID_THUNDER_L2C_CBC
+#define PCI_DEVICE_ID_THUNDER_L2C_CBC	0xa02f
+#endif
+
+#define L2C_CBC_NR_COUNTERS             16
+
+/* L2C CBC event list */
+#define L2C_CBC_EVENT_XMC0		0x00
+#define L2C_CBC_EVENT_XMD0		0x01
+#define L2C_CBC_EVENT_RSC0		0x02
+#define L2C_CBC_EVENT_RSD0		0x03
+#define L2C_CBC_EVENT_INV0		0x04
+#define L2C_CBC_EVENT_IOC0		0x05
+#define L2C_CBC_EVENT_IOR0		0x06
+
+#define L2C_CBC_EVENT_XMC1		0x08	/* 0x40 */
+#define L2C_CBC_EVENT_XMD1		0x09
+#define L2C_CBC_EVENT_RSC1		0x0a
+#define L2C_CBC_EVENT_RSD1		0x0b
+#define L2C_CBC_EVENT_INV1		0x0c
+
+#define L2C_CBC_EVENT_XMC2		0x10	/* 0x80 */
+#define L2C_CBC_EVENT_XMD2		0x11
+#define L2C_CBC_EVENT_RSC2		0x12
+#define L2C_CBC_EVENT_RSD2		0x13
+
+struct thunder_uncore *thunder_uncore_l2c_cbc;
+
+int l2c_cbc_events[L2C_CBC_NR_COUNTERS] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c,
+	0x10, 0x11, 0x12, 0x13
+};
+
+static void thunder_uncore_start(struct perf_event *event, int flags)
+{
+	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev;
+	int i;
+
+	/* restore counter value divided by units into all counters */
+	if (flags & PERF_EF_RELOAD) {
+		prev = local64_read(&hwc->prev_count);
+		prev = prev / uncore->nr_units;
+		for (i = 0; i < uncore->nr_units; i++)
+			writeq(prev, map_offset(hwc->event_base, uncore, i));
+	}
+
+	hwc->state = 0;
+	perf_event_update_userpage(event);
+}
+
+static void thunder_uncore_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
+		thunder_uncore_read(event);
+		hwc->state |= PERF_HES_UPTODATE;
+	}
+}
+
+static int thunder_uncore_add(struct perf_event *event, int flags)
+	{
+	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
+	struct hw_perf_event *hwc = &event->hw;
+	int i;
+
+	WARN_ON_ONCE(!uncore);
+
+	/* are we already assigned? */
+	if (hwc->idx != -1 && uncore->events[hwc->idx] == event)
+		goto out;
+
+	for (i = 0; i < uncore->num_counters; i++) {
+		if (uncore->events[i] == event) {
+			hwc->idx = i;
+			goto out;
+		}
+	}
+
+	/* these counters are self-sustained so idx must match the counter! */
+	hwc->idx = -1;
+	for (i = 0; i < uncore->num_counters; i++) {
+		if (l2c_cbc_events[i] == hwc->config) {
+			if (cmpxchg(&uncore->events[i], NULL, event) == NULL) {
+				hwc->idx = i;
+				break;
+			}
+		}
+	}
+
+out:
+	if (hwc->idx == -1)
+		return -EBUSY;
+
+	hwc->event_base = hwc->config * sizeof(unsigned long long);
+
+	/* counter is not stoppable so avoiding PERF_HES_STOPPED */
+	hwc->state = PERF_HES_UPTODATE;
+
+	if (flags & PERF_EF_START)
+		thunder_uncore_start(event, 0);
+
+	return 0;
+}
+
+PMU_FORMAT_ATTR(event, "config:0-4");
+
+static struct attribute *thunder_l2c_cbc_format_attr[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group thunder_l2c_cbc_format_group = {
+	.name = "format",
+	.attrs = thunder_l2c_cbc_format_attr,
+};
+
+EVENT_ATTR(xmc0,	L2C_CBC_EVENT_XMC0);
+EVENT_ATTR(xmd0,	L2C_CBC_EVENT_XMD0);
+EVENT_ATTR(rsc0,	L2C_CBC_EVENT_RSC0);
+EVENT_ATTR(rsd0,	L2C_CBC_EVENT_RSD0);
+EVENT_ATTR(inv0,	L2C_CBC_EVENT_INV0);
+EVENT_ATTR(ioc0,	L2C_CBC_EVENT_IOC0);
+EVENT_ATTR(ior0,	L2C_CBC_EVENT_IOR0);
+EVENT_ATTR(xmc1,	L2C_CBC_EVENT_XMC1);
+EVENT_ATTR(xmd1,	L2C_CBC_EVENT_XMD1);
+EVENT_ATTR(rsc1,	L2C_CBC_EVENT_RSC1);
+EVENT_ATTR(rsd1,	L2C_CBC_EVENT_RSD1);
+EVENT_ATTR(inv1,	L2C_CBC_EVENT_INV1);
+EVENT_ATTR(xmc2,	L2C_CBC_EVENT_XMC2);
+EVENT_ATTR(xmd2,	L2C_CBC_EVENT_XMD2);
+EVENT_ATTR(rsc2,	L2C_CBC_EVENT_RSC2);
+EVENT_ATTR(rsd2,	L2C_CBC_EVENT_RSD2);
+
+static struct attribute *thunder_l2c_cbc_events_attr[] = {
+	EVENT_PTR(xmc0),
+	EVENT_PTR(xmd0),
+	EVENT_PTR(rsc0),
+	EVENT_PTR(rsd0),
+	EVENT_PTR(inv0),
+	EVENT_PTR(ioc0),
+	EVENT_PTR(ior0),
+	EVENT_PTR(xmc1),
+	EVENT_PTR(xmd1),
+	EVENT_PTR(rsc1),
+	EVENT_PTR(rsd1),
+	EVENT_PTR(inv1),
+	EVENT_PTR(xmc2),
+	EVENT_PTR(xmd2),
+	EVENT_PTR(rsc2),
+	EVENT_PTR(rsd2),
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
+	.attr_groups	= thunder_l2c_cbc_attr_groups,
+	.name		= "thunder_l2c_cbc",
+	.event_init	= thunder_uncore_event_init,
+	.add		= thunder_uncore_add,
+	.del		= thunder_uncore_del,
+	.start		= thunder_uncore_start,
+	.stop		= thunder_uncore_stop,
+	.read		= thunder_uncore_read,
+};
+
+static int event_valid(u64 config)
+{
+	if (config <= L2C_CBC_EVENT_IOR0 ||
+	    (config >= L2C_CBC_EVENT_XMC1 && config <= L2C_CBC_EVENT_INV1) ||
+	    (config >= L2C_CBC_EVENT_XMC2 && config <= L2C_CBC_EVENT_RSD2))
+		return 1;
+	else
+		return 0;
+}
+
+int __init thunder_uncore_l2c_cbc_setup(void)
+{
+	int ret;
+
+	thunder_uncore_l2c_cbc = kzalloc(sizeof(struct thunder_uncore),
+					 GFP_KERNEL);
+	if (!thunder_uncore_l2c_cbc) {
+		ret = -ENOMEM;
+		goto fail_nomem;
+	}
+
+	ret = thunder_uncore_setup(thunder_uncore_l2c_cbc,
+				   PCI_DEVICE_ID_THUNDER_L2C_CBC,
+				   0,
+				   0x100,
+				   &thunder_l2c_cbc_pmu);
+	if (ret)
+		goto fail;
+
+	thunder_uncore_l2c_cbc->type = L2C_CBC_TYPE;
+	thunder_uncore_l2c_cbc->num_counters = L2C_CBC_NR_COUNTERS;
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
