From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 10 Mar 2015 15:18:52 +0000
Subject: [PATCH 2/5] arm-cci: Abstract the CCI400 PMU speicific definitions
In-Reply-To: <1426000735-14375-1-git-send-email-suzuki.poulose@arm.com>
References: <1426000735-14375-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1426000735-14375-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

CCI400 has different event specifications for PMU, for revsion
0 and revision 1. As of now, we check the revision every single
time before using the parameters for the PMU. This patch abstracts
the details of the pmu models in a struct (cci_pmu_model) and
stores the information in cci_pmu at initialisation time, avoiding
multiple probe operations.

Changes since V2:
 - Cleanup event validation(pmu_validate_hw_event). Get rid of
   helper functions:
	pmu_is_valid_slave_event
	pmu_is_valid_master_event

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |  141 ++++++++++++++++++++++++++++---------------------
 1 file changed, 81 insertions(+), 60 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index ea39fc2..f88383e 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -79,19 +79,38 @@ static const struct of_device_id arm_cci_matches[] = {
 
 #define CCI_PMU_MAX_HW_EVENTS 5   /* CCI PMU has 4 counters + 1 cycle counter */
 
+/* Types of interfaces that can generate events */
+enum {
+	CCI_IF_SLAVE,
+	CCI_IF_MASTER,
+	CCI_IF_MAX,
+};
+
+struct event_range {
+	u32 min;
+	u32 max;
+};
+
 struct cci_pmu_hw_events {
 	struct perf_event *events[CCI_PMU_MAX_HW_EVENTS];
 	unsigned long used_mask[BITS_TO_LONGS(CCI_PMU_MAX_HW_EVENTS)];
 	raw_spinlock_t pmu_lock;
 };
 
+struct cci_pmu_model {
+	char *name;
+	struct event_range event_ranges[CCI_IF_MAX];
+};
+
+static struct cci_pmu_model cci_pmu_models[];
+
 struct cci_pmu {
 	void __iomem *base;
 	struct pmu pmu;
 	int nr_irqs;
 	int irqs[CCI_PMU_MAX_HW_EVENTS];
 	unsigned long active_irqs;
-	struct pmu_port_event_ranges *port_ranges;
+	const struct cci_pmu_model *model;
 	struct cci_pmu_hw_events hw_events;
 	struct platform_device *plat_device;
 	int num_events;
@@ -152,53 +171,11 @@ enum cci400_perf_events {
 #define CCI_REV_R1_MASTER_PORT_MIN_EV	0x00
 #define CCI_REV_R1_MASTER_PORT_MAX_EV	0x11
 
-struct pmu_port_event_ranges {
-	u8 slave_min;
-	u8 slave_max;
-	u8 master_min;
-	u8 master_max;
-};
-
-static struct pmu_port_event_ranges port_event_range[] = {
-	[CCI_REV_R0] = {
-		.slave_min = CCI_REV_R0_SLAVE_PORT_MIN_EV,
-		.slave_max = CCI_REV_R0_SLAVE_PORT_MAX_EV,
-		.master_min = CCI_REV_R0_MASTER_PORT_MIN_EV,
-		.master_max = CCI_REV_R0_MASTER_PORT_MAX_EV,
-	},
-	[CCI_REV_R1] = {
-		.slave_min = CCI_REV_R1_SLAVE_PORT_MIN_EV,
-		.slave_max = CCI_REV_R1_SLAVE_PORT_MAX_EV,
-		.master_min = CCI_REV_R1_MASTER_PORT_MIN_EV,
-		.master_max = CCI_REV_R1_MASTER_PORT_MAX_EV,
-	},
-};
-
-/*
- * Export different PMU names for the different revisions so userspace knows
- * because the event ids are different
- */
-static char *const pmu_names[] = {
-	[CCI_REV_R0] = "CCI_400",
-	[CCI_REV_R1] = "CCI_400_r1",
-};
-
-static int pmu_is_valid_slave_event(u8 ev_code)
-{
-	return pmu->port_ranges->slave_min <= ev_code &&
-		ev_code <= pmu->port_ranges->slave_max;
-}
-
-static int pmu_is_valid_master_event(u8 ev_code)
-{
-	return pmu->port_ranges->master_min <= ev_code &&
-		ev_code <= pmu->port_ranges->master_max;
-}
-
 static int pmu_validate_hw_event(u8 hw_event)
 {
 	u8 ev_source = CCI_PMU_EVENT_SOURCE(hw_event);
 	u8 ev_code = CCI_PMU_EVENT_CODE(hw_event);
+	int if_type;
 
 	switch (ev_source) {
 	case CCI_PORT_S0:
@@ -207,18 +184,22 @@ static int pmu_validate_hw_event(u8 hw_event)
 	case CCI_PORT_S3:
 	case CCI_PORT_S4:
 		/* Slave Interface */
-		if (pmu_is_valid_slave_event(ev_code))
-			return hw_event;
+		if_type = CCI_IF_SLAVE;
 		break;
 	case CCI_PORT_M0:
 	case CCI_PORT_M1:
 	case CCI_PORT_M2:
 		/* Master Interface */
-		if (pmu_is_valid_master_event(ev_code))
-			return hw_event;
+		if_type = CCI_IF_MASTER;
 		break;
+	default:
+		return -ENOENT;
 	}
 
+	if (ev_code >= pmu->model->event_ranges[if_type].min &&
+		ev_code <= pmu->model->event_ranges[if_type].max)
+		return hw_event;
+
 	return -ENOENT;
 }
 
@@ -234,11 +215,9 @@ static int probe_cci_revision(void)
 		return CCI_REV_R1;
 }
 
-static struct pmu_port_event_ranges *port_range_by_rev(void)
+static const struct cci_pmu_model *probe_cci_model(struct platform_device *pdev)
 {
-	int rev = probe_cci_revision();
-
-	return &port_event_range[rev];
+	return &cci_pmu_models[probe_cci_revision()];
 }
 
 static int pmu_is_valid_counter(struct cci_pmu *cci_pmu, int idx)
@@ -807,9 +786,9 @@ static const struct attribute_group *pmu_attr_groups[] = {
 
 static int cci_pmu_init(struct cci_pmu *cci_pmu, struct platform_device *pdev)
 {
-	char *name = pmu_names[probe_cci_revision()];
+	char *name = cci_pmu->model->name;
 	cci_pmu->pmu = (struct pmu) {
-		.name		= pmu_names[probe_cci_revision()],
+		.name		= cci_pmu->model->name,
 		.task_ctx_nr	= perf_invalid_context,
 		.pmu_enable	= cci_pmu_enable,
 		.pmu_disable	= cci_pmu_disable,
@@ -862,6 +841,35 @@ static struct notifier_block cci_pmu_cpu_nb = {
 	.priority	= CPU_PRI_PERF + 1,
 };
 
+static struct cci_pmu_model cci_pmu_models[] = {
+	[CCI_REV_R0] = {
+		.name = "CCI_400",
+		.event_ranges = {
+			[CCI_IF_SLAVE] = {
+				CCI_REV_R0_SLAVE_PORT_MIN_EV,
+				CCI_REV_R0_SLAVE_PORT_MAX_EV,
+			},
+			[CCI_IF_MASTER] = {
+				CCI_REV_R0_MASTER_PORT_MIN_EV,
+				CCI_REV_R0_MASTER_PORT_MAX_EV,
+			},
+		},
+	},
+	[CCI_REV_R1] = {
+		.name = "CCI_400_r1",
+		.event_ranges = {
+			[CCI_IF_SLAVE] = {
+				CCI_REV_R1_SLAVE_PORT_MIN_EV,
+				CCI_REV_R1_SLAVE_PORT_MAX_EV,
+			},
+			[CCI_IF_MASTER] = {
+				CCI_REV_R1_MASTER_PORT_MIN_EV,
+				CCI_REV_R1_MASTER_PORT_MAX_EV,
+			},
+		},
+	},
+};
+
 static const struct of_device_id arm_cci_pmu_matches[] = {
 	{
 		.compatible = "arm,cci-400-pmu",
@@ -869,6 +877,16 @@ static const struct of_device_id arm_cci_pmu_matches[] = {
 	{},
 };
 
+static inline const struct cci_pmu_model *get_cci_model(struct platform_device *pdev)
+{
+	const struct of_device_id *match = of_match_node(arm_cci_pmu_matches,
+							pdev->dev.of_node);
+	if (!match)
+		return NULL;
+
+	return probe_cci_model(pdev);
+}
+
 static bool is_duplicate_irq(int irq, int *irqs, int nr_irqs)
 {
 	int i;
@@ -884,11 +902,19 @@ static int cci_pmu_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int i, ret, irq;
+	const struct cci_pmu_model *model;
+
+	model = get_cci_model(pdev);
+	if (!model) {
+		dev_warn(&pdev->dev, "CCI PMU version not supported\n");
+		return -ENODEV;
+	}
 
 	pmu = devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);
 	if (!pmu)
 		return -ENOMEM;
 
+	pmu->model = model;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pmu->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(pmu->base))
@@ -920,12 +946,6 @@ static int cci_pmu_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pmu->port_ranges = port_range_by_rev();
-	if (!pmu->port_ranges) {
-		dev_warn(&pdev->dev, "CCI PMU version not supported\n");
-		return -EINVAL;
-	}
-
 	raw_spin_lock_init(&pmu->hw_events.pmu_lock);
 	mutex_init(&pmu->reserve_mutex);
 	atomic_set(&pmu->active_events, 0);
@@ -939,6 +959,7 @@ static int cci_pmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pr_info("ARM %s PMU driver probed", pmu->model->name);
 	return 0;
 }
 
-- 
1.7.9.5
