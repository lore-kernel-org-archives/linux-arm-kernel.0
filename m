From: jglauber@cavium.com (Jan Glauber)
Date: Fri, 12 Feb 2016 17:55:09 +0100
Subject: [RFC PATCH 4/7] arm64/perf: Cavium ThunderX LMC uncore support
In-Reply-To: <cover.1455295032.git.jglauber@cavium.com>
References: <cover.1455295032.git.jglauber@cavium.com>
Message-ID: <6b9e09796299c25e6e41b1732932e893123e0210.1455295032.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support counters on the DRAM controllers.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 arch/arm64/kernel/uncore/Makefile            |   3 +-
 arch/arm64/kernel/uncore/uncore_cavium.c     |   3 +
 arch/arm64/kernel/uncore/uncore_cavium.h     |   4 +
 arch/arm64/kernel/uncore/uncore_cavium_lmc.c | 201 +++++++++++++++++++++++++++
 4 files changed, 210 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/uncore/uncore_cavium_lmc.c

diff --git a/arch/arm64/kernel/uncore/Makefile b/arch/arm64/kernel/uncore/Makefile
index d52ecc9..81479e8 100644
--- a/arch/arm64/kernel/uncore/Makefile
+++ b/arch/arm64/kernel/uncore/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_ARCH_THUNDER) += uncore_cavium.o		\
 			      uncore_cavium_l2c_tad.o	\
-			      uncore_cavium_l2c_cbc.o
+			      uncore_cavium_l2c_cbc.o	\
+			      uncore_cavium_lmc.o
diff --git a/arch/arm64/kernel/uncore/uncore_cavium.c b/arch/arm64/kernel/uncore/uncore_cavium.c
index 0304c60..a972418 100644
--- a/arch/arm64/kernel/uncore/uncore_cavium.c
+++ b/arch/arm64/kernel/uncore/uncore_cavium.c
@@ -26,6 +26,8 @@ struct thunder_uncore *event_to_thunder_uncore(struct perf_event *event)
 		return thunder_uncore_l2c_tad;
 	else if (event->pmu->type == thunder_l2c_cbc_pmu.type)
 		return thunder_uncore_l2c_cbc;
+	else if (event->pmu->type == thunder_lmc_pmu.type)
+		return thunder_uncore_lmc;
 	else
 		return NULL;
 }
@@ -212,6 +214,7 @@ static int __init thunder_uncore_init(void)
 
 	thunder_uncore_l2c_tad_setup();
 	thunder_uncore_l2c_cbc_setup();
+	thunder_uncore_lmc_setup();
 	return 0;
 }
 late_initcall(thunder_uncore_init);
diff --git a/arch/arm64/kernel/uncore/uncore_cavium.h b/arch/arm64/kernel/uncore/uncore_cavium.h
index 74f44d7..6e3beba 100644
--- a/arch/arm64/kernel/uncore/uncore_cavium.h
+++ b/arch/arm64/kernel/uncore/uncore_cavium.h
@@ -15,6 +15,7 @@
 enum uncore_type {
 	L2C_TAD_TYPE,
 	L2C_CBC_TYPE,
+	LMC_TYPE,
 };
 
 extern int thunder_uncore_version;
@@ -62,8 +63,10 @@ static inline void __iomem *map_offset(unsigned long addr,
 extern struct attribute_group thunder_uncore_attr_group;
 extern struct thunder_uncore *thunder_uncore_l2c_tad;
 extern struct thunder_uncore *thunder_uncore_l2c_cbc;
+extern struct thunder_uncore *thunder_uncore_lmc;
 extern struct pmu thunder_l2c_tad_pmu;
 extern struct pmu thunder_l2c_cbc_pmu;
+extern struct pmu thunder_lmc_pmu;
 
 /* Prototypes */
 struct thunder_uncore *event_to_thunder_uncore(struct perf_event *event);
@@ -79,3 +82,4 @@ ssize_t thunder_events_sysfs_show(struct device *dev,
 
 int thunder_uncore_l2c_tad_setup(void);
 int thunder_uncore_l2c_cbc_setup(void);
+int thunder_uncore_lmc_setup(void);
diff --git a/arch/arm64/kernel/uncore/uncore_cavium_lmc.c b/arch/arm64/kernel/uncore/uncore_cavium_lmc.c
new file mode 100644
index 0000000..9667819
--- /dev/null
+++ b/arch/arm64/kernel/uncore/uncore_cavium_lmc.c
@@ -0,0 +1,201 @@
+/*
+ * Cavium Thunder uncore PMU support, LMC counters.
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
+#ifndef PCI_DEVICE_ID_THUNDER_LMC
+#define PCI_DEVICE_ID_THUNDER_LMC	0xa022
+#endif
+
+#define LMC_NR_COUNTERS			3
+#define LMC_PASS2_NR_COUNTERS		5
+#define LMC_MAX_NR_COUNTERS		LMC_PASS2_NR_COUNTERS
+
+/* LMC event list */
+#define LMC_EVENT_IFB_CNT		0
+#define LMC_EVENT_OPS_CNT		1
+#define LMC_EVENT_DCLK_CNT		2
+
+/* pass 2 added counters */
+#define LMC_EVENT_BANK_CONFLICT1	3
+#define LMC_EVENT_BANK_CONFLICT2	4
+
+#define LMC_COUNTER_START		LMC_EVENT_IFB_CNT
+#define LMC_COUNTER_END			(LMC_EVENT_BANK_CONFLICT2 + 8)
+
+struct thunder_uncore *thunder_uncore_lmc;
+
+int lmc_events[LMC_MAX_NR_COUNTERS] = { 0x1d0, 0x1d8, 0x1e0, 0x360, 0x368 };
+
+static void thunder_uncore_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
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
+{
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
+	if (cmpxchg(&uncore->events[hwc->config], NULL, event) == NULL)
+		hwc->idx = i;
+
+out:
+	if (hwc->idx == -1)
+		return -EBUSY;
+
+	hwc->event_base = lmc_events[hwc->config];
+	hwc->state = PERF_HES_UPTODATE;
+
+	/* counters are read-only, so avoid PERF_EF_RELOAD */
+	if (flags & PERF_EF_START)
+		thunder_uncore_start(event, 0);
+
+	return 0;
+}
+
+PMU_FORMAT_ATTR(event, "config:0-2");
+
+static struct attribute *thunder_lmc_format_attr[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group thunder_lmc_format_group = {
+	.name = "format",
+	.attrs = thunder_lmc_format_attr,
+};
+
+EVENT_ATTR(ifb_cnt,		LMC_EVENT_IFB_CNT);
+EVENT_ATTR(ops_cnt,		LMC_EVENT_OPS_CNT);
+EVENT_ATTR(dclk_cnt,		LMC_EVENT_DCLK_CNT);
+EVENT_ATTR(bank_conflict1,	LMC_EVENT_BANK_CONFLICT1);
+EVENT_ATTR(bank_conflict2,	LMC_EVENT_BANK_CONFLICT2);
+
+static struct attribute *thunder_lmc_events_attr[] = {
+	EVENT_PTR(ifb_cnt),
+	EVENT_PTR(ops_cnt),
+	EVENT_PTR(dclk_cnt),
+	NULL,
+};
+
+static struct attribute *thunder_lmc_pass2_events_attr[] = {
+	EVENT_PTR(ifb_cnt),
+	EVENT_PTR(ops_cnt),
+	EVENT_PTR(dclk_cnt),
+	EVENT_PTR(bank_conflict1),
+	EVENT_PTR(bank_conflict2),
+	NULL,
+};
+
+static struct attribute_group thunder_lmc_events_group = {
+	.name = "events",
+	.attrs = NULL,
+};
+
+static const struct attribute_group *thunder_lmc_attr_groups[] = {
+	&thunder_uncore_attr_group,
+	&thunder_lmc_format_group,
+	&thunder_lmc_events_group,
+	NULL,
+};
+
+struct pmu thunder_lmc_pmu = {
+	.attr_groups	= thunder_lmc_attr_groups,
+	.name		= "thunder_lmc",
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
+	if (config <= LMC_EVENT_DCLK_CNT)
+		return 1;
+
+	if (thunder_uncore_version == 1)
+		if (config == LMC_EVENT_BANK_CONFLICT1 ||
+		    config == LMC_EVENT_BANK_CONFLICT2)
+			return 1;
+	return 0;
+}
+
+int __init thunder_uncore_lmc_setup(void)
+{
+	int ret;
+
+	thunder_uncore_lmc = kzalloc(sizeof(struct thunder_uncore), GFP_KERNEL);
+	if (!thunder_uncore_lmc) {
+		ret = -ENOMEM;
+		goto fail_nomem;
+	}
+
+	thunder_lmc_events_group.attrs = (thunder_uncore_version == 1) ?
+		thunder_lmc_pass2_events_attr : thunder_lmc_events_attr;
+
+	ret = thunder_uncore_setup(thunder_uncore_lmc,
+				   PCI_DEVICE_ID_THUNDER_LMC,
+				   LMC_COUNTER_START,
+				   LMC_COUNTER_END - LMC_COUNTER_START,
+				   &thunder_lmc_pmu);
+	if (ret)
+		goto fail;
+
+	thunder_uncore_lmc->type = LMC_TYPE;
+	thunder_uncore_lmc->num_counters = (thunder_uncore_version == 1) ?
+		LMC_PASS2_NR_COUNTERS : LMC_NR_COUNTERS;
+	thunder_uncore_lmc->event_valid = event_valid;
+	return 0;
+
+fail:
+	kfree(thunder_uncore_lmc);
+fail_nomem:
+	return ret;
+}
-- 
1.9.1
