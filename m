From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 20 Oct 2016 11:30:40 +0200
Subject: [PATCH v3 4/5] arm64: perf: Cavium ThunderX LMC uncore support
In-Reply-To: <1476955841-27898-1-git-send-email-jglauber@cavium.com>
References: <1476955841-27898-1-git-send-email-jglauber@cavium.com>
Message-ID: <1476955841-27898-5-git-send-email-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support counters on the DRAM controllers.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/perf/uncore/Makefile            |   3 +-
 drivers/perf/uncore/uncore_cavium.c     |   1 +
 drivers/perf/uncore/uncore_cavium.h     |   1 +
 drivers/perf/uncore/uncore_cavium_lmc.c | 118 ++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/uncore/uncore_cavium_lmc.c

diff --git a/drivers/perf/uncore/Makefile b/drivers/perf/uncore/Makefile
index d5ef3db..ef04a2b9 100644
--- a/drivers/perf/uncore/Makefile
+++ b/drivers/perf/uncore/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_UNCORE_PMU_CAVIUM) += uncore_cavium.o		\
 				   uncore_cavium_l2c_tad.o	\
-				   uncore_cavium_l2c_cbc.o
+				   uncore_cavium_l2c_cbc.o	\
+				   uncore_cavium_lmc.o
diff --git a/drivers/perf/uncore/uncore_cavium.c b/drivers/perf/uncore/uncore_cavium.c
index 051f0fa..fd9e49e 100644
--- a/drivers/perf/uncore/uncore_cavium.c
+++ b/drivers/perf/uncore/uncore_cavium.c
@@ -348,6 +348,7 @@ static int __init thunder_uncore_init(void)
 
 	thunder_uncore_l2c_tad_setup();
 	thunder_uncore_l2c_cbc_setup();
+	thunder_uncore_lmc_setup();
 	return 0;
 }
 late_initcall(thunder_uncore_init);
diff --git a/drivers/perf/uncore/uncore_cavium.h b/drivers/perf/uncore/uncore_cavium.h
index 91d674a..3897586 100644
--- a/drivers/perf/uncore/uncore_cavium.h
+++ b/drivers/perf/uncore/uncore_cavium.h
@@ -71,3 +71,4 @@ ssize_t thunder_events_sysfs_show(struct device *dev,
 				  char *page);
 int thunder_uncore_l2c_tad_setup(void);
 int thunder_uncore_l2c_cbc_setup(void);
+int thunder_uncore_lmc_setup(void);
diff --git a/drivers/perf/uncore/uncore_cavium_lmc.c b/drivers/perf/uncore/uncore_cavium_lmc.c
new file mode 100644
index 0000000..c7df89b
--- /dev/null
+++ b/drivers/perf/uncore/uncore_cavium_lmc.c
@@ -0,0 +1,118 @@
+/*
+ * Cavium Thunder uncore PMU support, Local memory controller (LMC) counters.
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
+struct thunder_uncore *thunder_uncore_lmc;
+
+#define LMC_CONFIG_OFFSET		0x188
+#define LMC_CONFIG_RESET_BIT		BIT_ULL(17)
+
+/* LMC event list */
+#define LMC_EVENT_IFB_CNT		0x1d0
+#define LMC_EVENT_OPS_CNT		0x1d8
+#define LMC_EVENT_DCLK_CNT		0x1e0
+#define LMC_EVENT_BANK_CONFLICT1	0x360
+#define LMC_EVENT_BANK_CONFLICT2	0x368
+
+/* map counter numbers to register offsets */
+static int lmc_events[] = {
+	LMC_EVENT_IFB_CNT,
+	LMC_EVENT_OPS_CNT,
+	LMC_EVENT_DCLK_CNT,
+	LMC_EVENT_BANK_CONFLICT1,
+	LMC_EVENT_BANK_CONFLICT2,
+};
+
+static int thunder_uncore_add_lmc(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	return thunder_uncore_add(event, flags,
+				  LMC_CONFIG_OFFSET,
+				  lmc_events[get_id(hwc->config)]);
+}
+
+PMU_FORMAT_ATTR(event, "config:0-2");
+
+static struct attribute *thunder_lmc_format_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_node.attr,
+	NULL,
+};
+
+static struct attribute_group thunder_lmc_format_group = {
+	.name = "format",
+	.attrs = thunder_lmc_format_attr,
+};
+
+static struct attribute *thunder_lmc_events_attr[] = {
+	UC_EVENT_ENTRY(ifb_cnt, 0),
+	UC_EVENT_ENTRY(ops_cnt, 1),
+	UC_EVENT_ENTRY(dclk_cnt, 2),
+	UC_EVENT_ENTRY(bank_conflict1, 3),
+	UC_EVENT_ENTRY(bank_conflict2, 4),
+	NULL,
+};
+
+static struct attribute_group thunder_lmc_events_group = {
+	.name = "events",
+	.attrs = thunder_lmc_events_attr,
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
+	.name		= "thunder_lmc",
+	.task_ctx_nr    = perf_sw_context,
+	.event_init	= thunder_uncore_event_init,
+	.add		= thunder_uncore_add_lmc,
+	.del		= thunder_uncore_del,
+	.start		= thunder_uncore_start,
+	.stop		= thunder_uncore_stop,
+	.read		= thunder_uncore_read,
+	.attr_groups	= thunder_lmc_attr_groups,
+};
+
+static bool event_valid(u64 config)
+{
+	if (config < ARRAY_SIZE(lmc_events))
+		return true;
+
+	return false;
+}
+
+int __init thunder_uncore_lmc_setup(void)
+{
+	int ret = -ENOMEM;
+
+	thunder_uncore_lmc = kzalloc(sizeof(*thunder_uncore_lmc), GFP_KERNEL);
+	if (!thunder_uncore_lmc)
+		goto fail_nomem;
+
+	ret = thunder_uncore_setup(thunder_uncore_lmc, 0xa022,
+				   &thunder_lmc_pmu,
+				   ARRAY_SIZE(lmc_events));
+	if (ret)
+		goto fail;
+
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
