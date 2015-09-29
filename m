From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 29 Sep 2015 11:41:23 +0100
Subject: [PATCH] arm-cci: simplify sysfs attr handling
Message-ID: <1443523283-6248-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need to dynamically initialise attribute pointers when we can
get the compiler to do it for us. We also don't need a dev_ext_attribute
for the cpumask, as the drvdata for a PMU device is a pointer to struct
pmu.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Tested-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
---
 drivers/bus/arm-cci.c | 100 +++++++++++++-------------------------------------
 1 file changed, 25 insertions(+), 75 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 577cc4b..10511b0 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -121,10 +121,8 @@ struct cci_pmu_model {
 	u32 fixed_hw_cntrs;
 	u32 num_hw_cntrs;
 	u32 cntr_size;
-	u64 nformat_attrs;
-	u64 nevent_attrs;
-	struct dev_ext_attribute *format_attrs;
-	struct dev_ext_attribute *event_attrs;
+	struct attribute **format_attrs;
+	struct attribute **event_attrs;
 	struct event_range event_ranges[CCI_IF_MAX];
 	int (*validate_hw_event)(struct cci_pmu *, unsigned long);
 	int (*get_event_idx)(struct cci_pmu *, struct cci_pmu_hw_events *, unsigned long);
@@ -166,8 +164,10 @@ static ssize_t cci_pmu_format_show(struct device *dev,
 static ssize_t cci_pmu_event_show(struct device *dev,
 			struct device_attribute *attr, char *buf);
 
-#define CCI_EXT_ATTR_ENTRY(_name, _func, _config) \
-	{ __ATTR(_name, S_IRUGO, _func, NULL), (void *)_config }
+#define CCI_EXT_ATTR_ENTRY(_name, _func, _config) 				\
+	&((struct dev_ext_attribute[]) {					\
+		{ __ATTR(_name, S_IRUGO, _func, NULL), (void *)_config }	\
+	})[0].attr.attr
 
 #define CCI_FORMAT_EXT_ATTR_ENTRY(_name, _config) \
 	CCI_EXT_ATTR_ENTRY(_name, cci_pmu_format_show, (char *)_config)
@@ -242,12 +242,13 @@ enum cci400_perf_events {
 static ssize_t cci400_pmu_cycle_event_show(struct device *dev,
 			struct device_attribute *attr, char *buf);
 
-static struct dev_ext_attribute cci400_pmu_format_attrs[] = {
+static struct attribute *cci400_pmu_format_attrs[] = {
 	CCI_FORMAT_EXT_ATTR_ENTRY(event, "config:0-4"),
 	CCI_FORMAT_EXT_ATTR_ENTRY(source, "config:5-7"),
+	NULL
 };
 
-static struct dev_ext_attribute cci400_r0_pmu_event_attrs[] = {
+static struct attribute *cci400_r0_pmu_event_attrs[] = {
 	/* Slave events */
 	CCI_EVENT_EXT_ATTR_ENTRY(si_rrq_hs_any, 0x0),
 	CCI_EVENT_EXT_ATTR_ENTRY(si_rrq_hs_device, 0x01),
@@ -279,9 +280,10 @@ static struct dev_ext_attribute cci400_r0_pmu_event_attrs[] = {
 	CCI_EVENT_EXT_ATTR_ENTRY(mi_wrq_stall_tt_full, 0x1A),
 	/* Special event for cycles counter */
 	CCI400_CYCLE_EVENT_EXT_ATTR_ENTRY(cycles, 0xff),
+	NULL
 };
 
-static struct dev_ext_attribute cci400_r1_pmu_event_attrs[] = {
+static struct attribute *cci400_r1_pmu_event_attrs[] = {
 	/* Slave events */
 	CCI_EVENT_EXT_ATTR_ENTRY(si_rrq_hs_any, 0x0),
 	CCI_EVENT_EXT_ATTR_ENTRY(si_rrq_hs_device, 0x01),
@@ -325,6 +327,7 @@ static struct dev_ext_attribute cci400_r1_pmu_event_attrs[] = {
 	CCI_EVENT_EXT_ATTR_ENTRY(mi_wrq_unique_or_line_unique_addr_hazard, 0x11),
 	/* Special event for cycles counter */
 	CCI400_CYCLE_EVENT_EXT_ATTR_ENTRY(cycles, 0xff),
+	NULL
 };
 
 static ssize_t cci400_pmu_cycle_event_show(struct device *dev,
@@ -480,12 +483,13 @@ static inline struct cci_pmu_model *probe_cci_model(struct platform_device *pdev
 static ssize_t cci500_pmu_global_event_show(struct device *dev,
 				struct device_attribute *attr, char *buf);
 
-static struct dev_ext_attribute cci500_pmu_format_attrs[] = {
+static struct attribute *cci500_pmu_format_attrs[] = {
 	CCI_FORMAT_EXT_ATTR_ENTRY(event, "config:0-4"),
 	CCI_FORMAT_EXT_ATTR_ENTRY(source, "config:5-8"),
+	NULL
 };
 
-static struct dev_ext_attribute cci500_pmu_event_attrs[] = {
+static struct attribute *cci500_pmu_event_attrs[] = {
 	/* Slave events */
 	CCI_EVENT_EXT_ATTR_ENTRY(si_rrq_hs_arvalid, 0x0),
 	CCI_EVENT_EXT_ATTR_ENTRY(si_rrq_dev, 0x1),
@@ -546,6 +550,7 @@ static struct dev_ext_attribute cci500_pmu_event_attrs[] = {
 	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_rq_stall_addr_hazard, 0xD),
 	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snopp_rq_stall_tt_full, 0xE),
 	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_rq_tzmp1_prot, 0xF),
+	NULL
 };
 
 static ssize_t cci500_pmu_global_event_show(struct device *dev,
@@ -1176,9 +1181,8 @@ static int cci_pmu_event_init(struct perf_event *event)
 static ssize_t pmu_cpumask_attr_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	struct dev_ext_attribute *eattr = container_of(attr,
-					struct dev_ext_attribute, attr);
-	struct cci_pmu *cci_pmu = eattr->var;
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
 
 	int n = scnprintf(buf, PAGE_SIZE - 1, "%*pbl",
 			  cpumask_pr_args(&cci_pmu->cpus));
@@ -1187,13 +1191,11 @@ static ssize_t pmu_cpumask_attr_show(struct device *dev,
 	return n;
 }
 
-static struct dev_ext_attribute pmu_cpumask_attr = {
-	__ATTR(cpumask, S_IRUGO, pmu_cpumask_attr_show, NULL),
-	NULL,		/* Populated in cci_pmu_init */
-};
+static struct device_attribute pmu_cpumask_attr =
+	__ATTR(cpumask, S_IRUGO, pmu_cpumask_attr_show, NULL);
 
 static struct attribute *pmu_attrs[] = {
-	&pmu_cpumask_attr.attr.attr,
+	&pmu_cpumask_attr.attr,
 	NULL,
 };
 
@@ -1218,60 +1220,14 @@ static const struct attribute_group *pmu_attr_groups[] = {
 	NULL
 };
 
-static struct attribute **alloc_attrs(struct platform_device *pdev,
-				int n, struct dev_ext_attribute *source)
-{
-	int i;
-	struct attribute **attrs;
-
-	/* Alloc n + 1 (for terminating NULL) */
-	attrs  = devm_kcalloc(&pdev->dev, n + 1, sizeof(struct attribute *),
-								GFP_KERNEL);
-	if (!attrs)
-		return attrs;
-	for(i = 0; i < n; i++)
-		attrs[i] = &source[i].attr.attr;
-	return attrs;
-}
-
-static int cci_pmu_init_attrs(struct cci_pmu *cci_pmu, struct platform_device *pdev)
-{
-	const struct cci_pmu_model *model = cci_pmu->model;
-	struct attribute **attrs;
-
-	/*
-	 * All allocations below are managed, hence doesn't need to be
-	 * free'd explicitly in case of an error.
-	 */
-
-	if (model->nevent_attrs) {
-		attrs = alloc_attrs(pdev, model->nevent_attrs,
-						model->event_attrs);
-		if (!attrs)
-			return -ENOMEM;
-		pmu_event_attr_group.attrs = attrs;
-	}
-	if (model->nformat_attrs) {
-		attrs = alloc_attrs(pdev, model->nformat_attrs,
-						 model->format_attrs);
-		if (!attrs)
-			return -ENOMEM;
-		pmu_format_attr_group.attrs = attrs;
-	}
-	pmu_cpumask_attr.var = cci_pmu;
-
-	return 0;
-}
-
 static int cci_pmu_init(struct cci_pmu *cci_pmu, struct platform_device *pdev)
 {
-	char *name = cci_pmu->model->name;
+	const struct cci_pmu_model *model = cci_pmu->model;
+	char *name = model->name;
 	u32 num_cntrs;
-	int rc;
 
-	rc = cci_pmu_init_attrs(cci_pmu, pdev);
-	if (rc)
-		return rc;
+	pmu_event_attr_group.attrs = model->event_attrs;
+	pmu_format_attr_group.attrs = model->format_attrs;
 
 	cci_pmu->pmu = (struct pmu) {
 		.name		= cci_pmu->model->name,
@@ -1336,9 +1292,7 @@ static struct cci_pmu_model cci_pmu_models[] = {
 		.num_hw_cntrs = 4,
 		.cntr_size = SZ_4K,
 		.format_attrs = cci400_pmu_format_attrs,
-		.nformat_attrs = ARRAY_SIZE(cci400_pmu_format_attrs),
 		.event_attrs = cci400_r0_pmu_event_attrs,
-		.nevent_attrs = ARRAY_SIZE(cci400_r0_pmu_event_attrs),
 		.event_ranges = {
 			[CCI_IF_SLAVE] = {
 				CCI400_R0_SLAVE_PORT_MIN_EV,
@@ -1358,9 +1312,7 @@ static struct cci_pmu_model cci_pmu_models[] = {
 		.num_hw_cntrs = 4,
 		.cntr_size = SZ_4K,
 		.format_attrs = cci400_pmu_format_attrs,
-		.nformat_attrs = ARRAY_SIZE(cci400_pmu_format_attrs),
 		.event_attrs = cci400_r1_pmu_event_attrs,
-		.nevent_attrs = ARRAY_SIZE(cci400_r1_pmu_event_attrs),
 		.event_ranges = {
 			[CCI_IF_SLAVE] = {
 				CCI400_R1_SLAVE_PORT_MIN_EV,
@@ -1382,9 +1334,7 @@ static struct cci_pmu_model cci_pmu_models[] = {
 		.num_hw_cntrs = 8,
 		.cntr_size = SZ_64K,
 		.format_attrs = cci500_pmu_format_attrs,
-		.nformat_attrs = ARRAY_SIZE(cci500_pmu_format_attrs),
 		.event_attrs = cci500_pmu_event_attrs,
-		.nevent_attrs = ARRAY_SIZE(cci500_pmu_event_attrs),
 		.event_ranges = {
 			[CCI_IF_SLAVE] = {
 				CCI500_SLAVE_PORT_MIN_EV,
-- 
1.9.1
