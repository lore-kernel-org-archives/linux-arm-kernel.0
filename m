From: Frank.Li@nxp.com (Frank Li)
Date: Wed, 2 Nov 2016 13:00:03 -0500
Subject: [PATCH v2 1/2] ARM: imx: mmdc perf function support i.MX6QP
Message-ID: <1478109604-18323-1-git-send-email-Frank.Li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6QP added new reigster bit PROFILE_SEL in MADPCR0.
need set it at perf start.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
V1 to V2: remove fsl_mmdc_devtype

 arch/arm/mach-imx/mmdc.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index d82d14c..032cbe0 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -44,6 +44,7 @@
 #define DBG_RST			0x2
 #define PRF_FRZ			0x4
 #define CYC_OVF			0x8
+#define PROFILE_SEL		0x10
 
 #define MMDC_MADPCR0	0x410
 #define MMDC_MADPSR0	0x418
@@ -55,10 +56,29 @@
 
 #define MMDC_NUM_COUNTERS	6
 
+#define FSL_MMDC_QUIRK_PROFILE_SEL	0x1
+
 #define to_mmdc_pmu(p) container_of(p, struct mmdc_pmu, pmu)
 
 static int ddr_type;
 
+struct fsl_mmdc_devtype_data {
+	int driver_data;
+};
+
+static struct fsl_mmdc_devtype_data imx6q_data = {
+};
+
+static struct fsl_mmdc_devtype_data imx6qp_data = {
+	.driver_data = FSL_MMDC_QUIRK_PROFILE_SEL,
+};
+
+static const struct of_device_id imx_mmdc_dt_ids[] = {
+	{ .compatible = "fsl,imx6q-mmdc", .data = (void *)&imx6q_data},
+	{ .compatible = "fsl,imx6qp-mmdc", .data = (void *)&imx6qp_data},
+	{ /* sentinel */ }
+};
+
 #ifdef CONFIG_PERF_EVENTS
 
 static DEFINE_IDA(mmdc_ida);
@@ -83,6 +103,7 @@ struct mmdc_pmu {
 	struct device *dev;
 	struct perf_event *mmdc_events[MMDC_NUM_COUNTERS];
 	struct hlist_node node;
+	struct fsl_mmdc_devtype_data *devtype_data;
 };
 
 /*
@@ -307,6 +328,7 @@ static void mmdc_pmu_event_start(struct perf_event *event, int flags)
 	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	void __iomem *mmdc_base, *reg;
+	int val;
 
 	mmdc_base = pmu_mmdc->mmdc_base;
 	reg = mmdc_base + MMDC_MADPCR0;
@@ -321,7 +343,12 @@ static void mmdc_pmu_event_start(struct perf_event *event, int flags)
 	local64_set(&hwc->prev_count, 0);
 
 	writel(DBG_RST, reg);
-	writel(DBG_EN, reg);
+
+	val = DBG_EN;
+	if (pmu_mmdc->devtype_data->driver_data & FSL_MMDC_QUIRK_PROFILE_SEL)
+		val |= PROFILE_SEL;
+
+	writel(val, reg);
 }
 
 static int mmdc_pmu_event_add(struct perf_event *event, int flags)
@@ -436,6 +463,8 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 	char *name;
 	int mmdc_num;
 	int ret;
+	const struct of_device_id *of_id =
+		of_match_device(imx_mmdc_dt_ids, &pdev->dev);
 
 	pmu_mmdc = kzalloc(sizeof(*pmu_mmdc), GFP_KERNEL);
 	if (!pmu_mmdc) {
@@ -450,6 +479,8 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 		name = devm_kasprintf(&pdev->dev,
 				GFP_KERNEL, "mmdc%d", mmdc_num);
 
+	pmu_mmdc->devtype_data = (struct fsl_mmdc_devtype_data *)of_id->data;
+
 	hrtimer_init(&pmu_mmdc->hrtimer, CLOCK_MONOTONIC,
 			HRTIMER_MODE_REL);
 	pmu_mmdc->hrtimer.function = mmdc_pmu_timer_handler;
@@ -524,11 +555,6 @@ int imx_mmdc_get_ddr_type(void)
 	return ddr_type;
 }
 
-static const struct of_device_id imx_mmdc_dt_ids[] = {
-	{ .compatible = "fsl,imx6q-mmdc", },
-	{ /* sentinel */ }
-};
-
 static struct platform_driver imx_mmdc_driver = {
 	.driver		= {
 		.name	= "imx-mmdc",
-- 
2.5.2
