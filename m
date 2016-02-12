From: jglauber@cavium.com (Jan Glauber)
Date: Fri, 12 Feb 2016 17:55:10 +0100
Subject: [RFC PATCH 5/7] arm64/perf: Cavium ThunderX OCX LNE uncore support
In-Reply-To: <cover.1455295032.git.jglauber@cavium.com>
References: <cover.1455295032.git.jglauber@cavium.com>
Message-ID: <19008f588c058ef63ed42cc5b8b242d3e2565622.1455295032.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support counters for the CCPI Interface controller (OCX) lanes.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 arch/arm64/kernel/uncore/Makefile                |   3 +-
 arch/arm64/kernel/uncore/uncore_cavium.c         |   3 +
 arch/arm64/kernel/uncore/uncore_cavium.h         |   4 +
 arch/arm64/kernel/uncore/uncore_cavium_ocx_lne.c | 270 +++++++++++++++++++++++
 4 files changed, 279 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/uncore/uncore_cavium_ocx_lne.c

diff --git a/arch/arm64/kernel/uncore/Makefile b/arch/arm64/kernel/uncore/Makefile
index 81479e8..da39f452 100644
--- a/arch/arm64/kernel/uncore/Makefile
+++ b/arch/arm64/kernel/uncore/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_ARCH_THUNDER) += uncore_cavium.o		\
 			      uncore_cavium_l2c_tad.o	\
 			      uncore_cavium_l2c_cbc.o	\
-			      uncore_cavium_lmc.o
+			      uncore_cavium_lmc.o	\
+			      uncore_cavium_ocx_lne.o
diff --git a/arch/arm64/kernel/uncore/uncore_cavium.c b/arch/arm64/kernel/uncore/uncore_cavium.c
index a972418..f2fbdea 100644
--- a/arch/arm64/kernel/uncore/uncore_cavium.c
+++ b/arch/arm64/kernel/uncore/uncore_cavium.c
@@ -28,6 +28,8 @@ struct thunder_uncore *event_to_thunder_uncore(struct perf_event *event)
 		return thunder_uncore_l2c_cbc;
 	else if (event->pmu->type == thunder_lmc_pmu.type)
 		return thunder_uncore_lmc;
+	else if (event->pmu->type == thunder_ocx_lne_pmu.type)
+		return thunder_uncore_ocx_lne;
 	else
 		return NULL;
 }
@@ -215,6 +217,7 @@ static int __init thunder_uncore_init(void)
 	thunder_uncore_l2c_tad_setup();
 	thunder_uncore_l2c_cbc_setup();
 	thunder_uncore_lmc_setup();
+	thunder_uncore_ocx_lne_setup();
 	return 0;
 }
 late_initcall(thunder_uncore_init);
diff --git a/arch/arm64/kernel/uncore/uncore_cavium.h b/arch/arm64/kernel/uncore/uncore_cavium.h
index 6e3beba..b9bcb42 100644
--- a/arch/arm64/kernel/uncore/uncore_cavium.h
+++ b/arch/arm64/kernel/uncore/uncore_cavium.h
@@ -16,6 +16,7 @@ enum uncore_type {
 	L2C_TAD_TYPE,
 	L2C_CBC_TYPE,
 	LMC_TYPE,
+	OCX_LNE_TYPE,
 };
 
 extern int thunder_uncore_version;
@@ -64,9 +65,11 @@ extern struct attribute_group thunder_uncore_attr_group;
 extern struct thunder_uncore *thunder_uncore_l2c_tad;
 extern struct thunder_uncore *thunder_uncore_l2c_cbc;
 extern struct thunder_uncore *thunder_uncore_lmc;
+extern struct thunder_uncore *thunder_uncore_ocx_lne;
 extern struct pmu thunder_l2c_tad_pmu;
 extern struct pmu thunder_l2c_cbc_pmu;
 extern struct pmu thunder_lmc_pmu;
+extern struct pmu thunder_ocx_lne_pmu;
 
 /* Prototypes */
 struct thunder_uncore *event_to_thunder_uncore(struct perf_event *event);
@@ -83,3 +86,4 @@ ssize_t thunder_events_sysfs_show(struct device *dev,
 int thunder_uncore_l2c_tad_setup(void);
 int thunder_uncore_l2c_cbc_setup(void);
 int thunder_uncore_lmc_setup(void);
+int thunder_uncore_ocx_lne_setup(void);
diff --git a/arch/arm64/kernel/uncore/uncore_cavium_ocx_lne.c b/arch/arm64/kernel/uncore/uncore_cavium_ocx_lne.c
new file mode 100644
index 0000000..c2981b9
--- /dev/null
+++ b/arch/arm64/kernel/uncore/uncore_cavium_ocx_lne.c
@@ -0,0 +1,270 @@
+/*
+ * Cavium Thunder uncore PMU support, OCX LNE counters.
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
+#ifndef PCI_DEVICE_ID_THUNDER_OCX
+#define PCI_DEVICE_ID_THUNDER_OCX		0xa013
+#endif
+
+#define OCX_LNE_NR_COUNTERS			15
+#define OCX_LNE_NR_UNITS			24
+#define OCX_LNE_UNIT_OFFSET			0x100
+#define OCX_LNE_CONTROL_OFFSET			0x8000
+#define OCX_LNE_COUNTER_OFFSET			0x40
+
+#define OCX_LNE_STAT_DISABLE			0
+#define OCX_LNE_STAT_ENABLE			1
+
+/* OCX LNE event list */
+#define OCX_LNE_EVENT_STAT00			0x00
+#define OCX_LNE_EVENT_STAT01			0x01
+#define OCX_LNE_EVENT_STAT02			0x02
+#define OCX_LNE_EVENT_STAT03			0x03
+#define OCX_LNE_EVENT_STAT04			0x04
+#define OCX_LNE_EVENT_STAT05			0x05
+#define OCX_LNE_EVENT_STAT06			0x06
+#define OCX_LNE_EVENT_STAT07			0x07
+#define OCX_LNE_EVENT_STAT08			0x08
+#define OCX_LNE_EVENT_STAT09			0x09
+#define OCX_LNE_EVENT_STAT10			0x0a
+#define OCX_LNE_EVENT_STAT11			0x0b
+#define OCX_LNE_EVENT_STAT12			0x0c
+#define OCX_LNE_EVENT_STAT13			0x0d
+#define OCX_LNE_EVENT_STAT14			0x0e
+
+struct thunder_uncore *thunder_uncore_ocx_lne;
+
+static inline void __iomem *map_offset_ocx_lne(unsigned long addr,
+				struct thunder_uncore *uncore, int unit)
+{
+	return (void __iomem *) (addr +
+				 uncore->pdevs[0].map +
+				 unit * OCX_LNE_UNIT_OFFSET);
+}
+
+/*
+ * Summarize counters across all LNE's. Different from the other uncore
+ * PMUs because all LNE's are on one PCI device.
+ */
+static void thunder_uncore_read_ocx_lne(struct perf_event *event)
+{
+	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev, new = 0;
+	s64 delta;
+	int i;
+
+	/*
+	 * since we do not enable counter overflow interrupts,
+	 * we do not have to worry about prev_count changing on us
+	 */
+
+	prev = local64_read(&hwc->prev_count);
+
+	/* read counter values from all units */
+	for (i = 0; i < OCX_LNE_NR_UNITS; i++)
+		new += readq(map_offset_ocx_lne(hwc->event_base, uncore, i));
+
+	local64_set(&hwc->prev_count, new);
+	delta = new - prev;
+	local64_add(delta, &event->count);
+}
+
+static void thunder_uncore_start(struct perf_event *event, int flags)
+{
+	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
+	struct hw_perf_event *hwc = &event->hw;
+	int i;
+
+	hwc->state = 0;
+
+	/* enable counters on all units */
+	for (i = 0; i < OCX_LNE_NR_UNITS; i++)
+		writeb(OCX_LNE_STAT_ENABLE,
+		       map_offset_ocx_lne(hwc->config_base, uncore, i));
+
+	perf_event_update_userpage(event);
+}
+
+static void thunder_uncore_stop(struct perf_event *event, int flags)
+{
+	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
+	struct hw_perf_event *hwc = &event->hw;
+	int i;
+
+	/* disable counters on all units */
+	for (i = 0; i < OCX_LNE_NR_UNITS; i++)
+		writeb(OCX_LNE_STAT_DISABLE,
+		       map_offset_ocx_lne(hwc->config_base, uncore, i));
+	hwc->state |= PERF_HES_STOPPED;
+
+	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
+		thunder_uncore_read_ocx_lne(event);
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
+	/* counters are 1:1 */
+	hwc->idx = -1;
+	if (cmpxchg(&uncore->events[hwc->config], NULL, event) == NULL)
+		hwc->idx = hwc->config;
+
+out:
+	if (hwc->idx == -1)
+		return -EBUSY;
+
+	hwc->config_base = 0;
+	hwc->event_base = OCX_LNE_COUNTER_OFFSET +
+			hwc->idx * sizeof(unsigned long long);
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_START)
+		/* counters are read-only, so avoid PERF_EF_RELOAD */
+		thunder_uncore_start(event, 0);
+
+	return 0;
+}
+
+PMU_FORMAT_ATTR(event, "config:0-3");
+
+static struct attribute *thunder_ocx_lne_format_attr[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group thunder_ocx_lne_format_group = {
+	.name = "format",
+	.attrs = thunder_ocx_lne_format_attr,
+};
+
+EVENT_ATTR(stat00,	OCX_LNE_EVENT_STAT00);
+EVENT_ATTR(stat01,	OCX_LNE_EVENT_STAT01);
+EVENT_ATTR(stat02,	OCX_LNE_EVENT_STAT02);
+EVENT_ATTR(stat03,	OCX_LNE_EVENT_STAT03);
+EVENT_ATTR(stat04,	OCX_LNE_EVENT_STAT04);
+EVENT_ATTR(stat05,	OCX_LNE_EVENT_STAT05);
+EVENT_ATTR(stat06,	OCX_LNE_EVENT_STAT06);
+EVENT_ATTR(stat07,	OCX_LNE_EVENT_STAT07);
+EVENT_ATTR(stat08,	OCX_LNE_EVENT_STAT08);
+EVENT_ATTR(stat09,	OCX_LNE_EVENT_STAT09);
+EVENT_ATTR(stat10,	OCX_LNE_EVENT_STAT10);
+EVENT_ATTR(stat11,	OCX_LNE_EVENT_STAT11);
+EVENT_ATTR(stat12,	OCX_LNE_EVENT_STAT12);
+EVENT_ATTR(stat13,	OCX_LNE_EVENT_STAT13);
+EVENT_ATTR(stat14,	OCX_LNE_EVENT_STAT14);
+
+static struct attribute *thunder_ocx_lne_events_attr[] = {
+	EVENT_PTR(stat00),
+	EVENT_PTR(stat01),
+	EVENT_PTR(stat02),
+	EVENT_PTR(stat03),
+	EVENT_PTR(stat04),
+	EVENT_PTR(stat05),
+	EVENT_PTR(stat06),
+	EVENT_PTR(stat07),
+	EVENT_PTR(stat08),
+	EVENT_PTR(stat09),
+	EVENT_PTR(stat10),
+	EVENT_PTR(stat11),
+	EVENT_PTR(stat12),
+	EVENT_PTR(stat13),
+	EVENT_PTR(stat14),
+	NULL,
+};
+
+static struct attribute_group thunder_ocx_lne_events_group = {
+	.name = "events",
+	.attrs = thunder_ocx_lne_events_attr,
+};
+
+static const struct attribute_group *thunder_ocx_lne_attr_groups[] = {
+	&thunder_uncore_attr_group,
+	&thunder_ocx_lne_format_group,
+	&thunder_ocx_lne_events_group,
+	NULL,
+};
+
+struct pmu thunder_ocx_lne_pmu = {
+	.attr_groups	= thunder_ocx_lne_attr_groups,
+	.name		= "thunder_ocx_lne",
+	.event_init	= thunder_uncore_event_init,
+	.add		= thunder_uncore_add,
+	.del		= thunder_uncore_del,
+	.start		= thunder_uncore_start,
+	.stop		= thunder_uncore_stop,
+	.read		= thunder_uncore_read_ocx_lne,
+};
+
+static int event_valid(u64 config)
+{
+	if (config <= OCX_LNE_EVENT_STAT14)
+		return 1;
+	else
+		return 0;
+}
+
+int __init thunder_uncore_ocx_lne_setup(void)
+{
+	int ret;
+
+	thunder_uncore_ocx_lne = kzalloc(sizeof(struct thunder_uncore),
+					 GFP_KERNEL);
+	if (!thunder_uncore_ocx_lne) {
+		ret = -ENOMEM;
+		goto fail_nomem;
+	}
+
+	ret = thunder_uncore_setup(thunder_uncore_ocx_lne,
+				   PCI_DEVICE_ID_THUNDER_OCX,
+				   OCX_LNE_CONTROL_OFFSET,
+				   OCX_LNE_COUNTER_OFFSET + OCX_LNE_NR_COUNTERS
+					* sizeof(unsigned long long),
+				   &thunder_ocx_lne_pmu);
+	if (ret)
+		goto fail;
+
+	thunder_uncore_ocx_lne->type = OCX_LNE_TYPE;
+	thunder_uncore_ocx_lne->num_counters = OCX_LNE_NR_COUNTERS;
+	thunder_uncore_ocx_lne->event_valid = event_valid;
+	return 0;
+
+fail:
+	kfree(thunder_uncore_ocx_lne);
+fail_nomem:
+	return ret;
+}
-- 
1.9.1
