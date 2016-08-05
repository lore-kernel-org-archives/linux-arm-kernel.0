From: zhengyu.shen@nxp.com (Zhengyu Shen)
Date: Fri, 5 Aug 2016 09:35:25 -0500
Subject: [PATCH] Added perf functionality to mmdc driver
Message-ID: <20160805143525.28765-1-zhengyu.shen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

$ perf stat -e mmdc/busy-cycles/,mmdc/read-accesses/,mmdc/read-bytes/,mmdc/total-cycles/,mmdc/write-accesses/,mmdc/write-bytes/ dd if=/dev/zero of=/dev/null bs=1M count=5000
Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=1M count=5000':

         898021787      mmdc/busy-cycles/
          14819600      mmdc/read-accesses/
            471.30 MB   mmdc/read-bytes/
        2815419216      mmdc/total-cycles/
          13367354      mmdc/write-accesses/
            427.76 MB   mmdc/write-bytes/

       5.334757334 seconds time elapsed

Signed-off-by: Zhengyu Shen <zhengyu.shen@nxp.com>
---
 arch/arm/mach-imx/mmdc.c | 206 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 205 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index db9621c..48f3a0b 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011,2016 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  *
  * The code contained herein is licensed under the GNU General Public
@@ -16,6 +16,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
 
 #include "common.h"
 
@@ -27,12 +29,198 @@
 #define BM_MMDC_MDMISC_DDR_TYPE	0x18
 #define BP_MMDC_MDMISC_DDR_TYPE	0x3
 
+#define TOTAL_CYCLES	0x1
+#define BUSY_CYCLES		0x2
+#define READ_ACCESSES	0x3
+#define WRITE_ACCESSES	0x4
+#define READ_BYTES		0x5
+#define WRITE_BYTES		0x6
+
+#define DBG_EN			0x1
+#define DBG_RST			0x2
+#define PRF_FRZ			0x4
+#define CYC_OVF 		0x8
+
+#define MMDC_MADPCR0	0x410
+#define MMDC_MADPSR0	0x418
+#define MMDC_MADPSR1	0x41C
+#define MMDC_MADPSR2	0x420
+#define MMDC_MADPSR3	0x424
+#define MMDC_MADPSR4	0x428
+#define MMDC_MADPSR5	0x42C
+
+#define to_mmdc_pmu(p) (container_of(p, struct mmdc_pmu, pmu))
+
 static int ddr_type;
 
+PMU_EVENT_ATTR_STRING(total-cycles, evattr_total_cycles, "event=0x01")
+PMU_EVENT_ATTR_STRING(busy-cycles, evattr_busy_cycles, "event=0x02")
+PMU_EVENT_ATTR_STRING(read-accesses, evattr_read_accesses, "event=0x03")
+PMU_EVENT_ATTR_STRING(write-accesses, evattr_write_accesses, "config=0x04")
+PMU_EVENT_ATTR_STRING(read-bytes, evattr_read_bytes, "event=0x05")
+PMU_EVENT_ATTR_STRING(read-bytes.unit, evattr_read_bytes_unit, "MB");
+PMU_EVENT_ATTR_STRING(read-bytes.scale, evattr_read_bytes_scale, "0.000001");
+PMU_EVENT_ATTR_STRING(write-bytes, evattr_write_bytes, "event=0x06")
+PMU_EVENT_ATTR_STRING(write-bytes.unit, evattr_write_bytes_unit, "MB");
+PMU_EVENT_ATTR_STRING(write-bytes.scale, evattr_write_bytes_scale, "0.000001");
+
+struct mmdc_pmu
+{
+	struct pmu pmu;
+	void __iomem *mmdc_base;
+};
+
+static struct attribute *events_attrs[] = {
+	&evattr_total_cycles.attr.attr,
+	&evattr_busy_cycles.attr.attr,
+	&evattr_read_accesses.attr.attr,
+	&evattr_write_accesses.attr.attr,
+	&evattr_read_bytes.attr.attr,
+	&evattr_read_bytes_unit.attr.attr,
+	&evattr_read_bytes_scale.attr.attr,
+	&evattr_write_bytes.attr.attr,
+	&evattr_write_bytes_unit.attr.attr,
+	&evattr_write_bytes_scale.attr.attr,
+	NULL,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-63");
+static struct attribute *format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group format_attr_group = {
+	.name = "format",
+	.attrs = format_attrs,
+};
+
+static struct attribute_group events_attr_group = {
+	.name = "events",
+	.attrs = events_attrs,
+};
+
+static const struct attribute_group * attr_groups[] = {
+	&events_attr_group,
+	&format_attr_group,
+	NULL,
+};
+
+static inline u64 mmdc_read_counter(struct perf_event *event)
+{
+	unsigned int val;
+	u64 ret;
+	int cfg = (int) event->attr.config;
+	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
+	void __iomem *mmdc_base, *reg;
+
+	mmdc_base = pmu_mmdc->mmdc_base;
+
+	writel_relaxed(PRF_FRZ, mmdc_base + MMDC_MADPCR0);
+
+	switch (cfg)
+	{
+		case TOTAL_CYCLES:
+			reg = mmdc_base + MMDC_MADPSR0;
+			break;
+		case BUSY_CYCLES:
+			reg = mmdc_base + MMDC_MADPSR1;
+			break;
+		case READ_ACCESSES:
+			reg = mmdc_base + MMDC_MADPSR2;
+			break;
+		case WRITE_ACCESSES:
+			reg = mmdc_base + MMDC_MADPSR3;
+			break;
+		case READ_BYTES:
+			reg = mmdc_base + MMDC_MADPSR4;
+			break;
+		case WRITE_BYTES:
+			reg = mmdc_base + MMDC_MADPSR5;
+			break;
+		default:
+			return -1;
+	}
+	val = readl_relaxed(reg);
+	writel_relaxed(DBG_EN, mmdc_base + MMDC_MADPCR0);
+	ret = val;
+	return ret;
+}
+
+static void mmdc_enable_profiling(struct perf_event *event)
+{
+	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
+	void __iomem *mmdc_base, *reg;
+
+	mmdc_base = pmu_mmdc->mmdc_base;
+	reg = mmdc_base + MMDC_MADPCR0;
+	writel_relaxed(CYC_OVF | DBG_RST, reg);
+	writel_relaxed(DBG_EN, reg);
+}
+
+static int mmdc_event_init(struct perf_event *event)
+{
+	u64 val;
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+	mmdc_enable_profiling(event);
+	val = mmdc_read_counter(event);
+	local64_set(&event->hw.prev_count, val);
+	return 0;
+}
+
+static void mmdc_event_update(struct perf_event * event)
+{
+	u64 val;
+	val = mmdc_read_counter(event);
+	local64_set(&event->count, val);
+}
+
+static void mmdc_event_start(struct perf_event *event, int flags)
+{
+	mmdc_event_update(event);
+}
+
+static int mmdc_event_add(struct perf_event *event, int flags)
+{
+	if (flags & PERF_EF_START)
+		mmdc_event_start(event, flags);
+	return 0;
+}
+
+static void mmdc_event_stop(struct perf_event *event, int flags)
+{
+	mmdc_event_update(event);
+}
+
+static void mmdc_event_del(struct perf_event *event, int flags)
+{
+	mmdc_event_stop(event, PERF_EF_UPDATE);
+}
+
+static void mmdc_pmu_init(struct mmdc_pmu *pmu_mmdc, void __iomem *mmdc_base)
+{
+	*pmu_mmdc = (struct mmdc_pmu) {
+		.pmu = (struct pmu) {
+			.task_ctx_nr    = perf_sw_context,
+			.attr_groups    = attr_groups,
+			.event_init     = mmdc_event_init,
+			.add            = mmdc_event_add,
+			.del            = mmdc_event_del,
+			.start          = mmdc_event_start,
+			.stop           = mmdc_event_stop,
+			.read           = mmdc_event_update,
+			.capabilities   = PERF_PMU_CAP_NO_INTERRUPT,
+		},
+		.mmdc_base = mmdc_base,
+	};
+}
+
 static int imx_mmdc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	void __iomem *mmdc_base, *reg;
+	struct mmdc_pmu *pmu_mmdc;
 	u32 val;
 	int timeout = 0x400;
 
@@ -61,7 +249,22 @@ static int imx_mmdc_probe(struct platform_device *pdev)
 			__func__);
 		return -EBUSY;
 	}
+	pmu_mmdc = kzalloc(sizeof(struct mmdc_pmu), GFP_KERNEL);
+	if (!pmu_mmdc) {
+		pr_err("failed to allocate PMU device!\n");
+		return -ENOMEM;
+    }
+	mmdc_pmu_init(pmu_mmdc, mmdc_base);
+	platform_set_drvdata(pdev, pmu_mmdc);
+	perf_pmu_register(&(pmu_mmdc->pmu), "mmdc", -1);
+	return 0;
+}
 
+static int imx_mmdc_remove(struct platform_device *pdev)
+{
+	struct mmdc_pmu *pmu_mmdc = platform_get_drvdata(pdev);
+	perf_pmu_unregister(&pmu_mmdc->pmu);
+	kfree(pmu_mmdc);
 	return 0;
 }
 
@@ -81,6 +284,7 @@ static struct platform_driver imx_mmdc_driver = {
 		.of_match_table = imx_mmdc_dt_ids,
 	},
 	.probe		= imx_mmdc_probe,
+	.remove		= imx_mmdc_remove,
 };
 
 static int __init imx_mmdc_init(void)
-- 
2.9.2
