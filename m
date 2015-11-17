From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 17 Nov 2015 18:30:39 +0000
Subject: [PATCH 1/2] arm-cci500: Rearrange PMU driver for code sharing with
 CCI-550 PMU
In-Reply-To: <1447785040-18599-1-git-send-email-suzuki.poulose@arm.com>
References: <1447785040-18599-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1447785040-18599-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CCI-550 PMU shares most of the CCI-500 PMU attributes including the
event format, PMU event codes. The only difference is an additional
master interface (MI6 - 0xe). Hence we share the driver code for both,
except for a model specific event validate method.
This patch renames the common CCI500 symbols to CCI5xx, including the
Kconfig symbol.

No functional changes to the PMU driver.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/Kconfig   |    2 +-
 drivers/bus/arm-cci.c |  218 +++++++++++++++++++++++++------------------------
 2 files changed, 112 insertions(+), 108 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 116b363..3793f4e 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -34,7 +34,7 @@ config ARM_CCI400_PORT_CTRL
 	  Low level power management driver for CCI400 cache coherent
 	  interconnect for ARM platforms.
 
-config ARM_CCI500_PMU
+config ARM_CCI5xx_PMU
 	bool "ARM CCI500 PMU support"
 	depends on (ARM && CPU_V7) || ARM64
 	depends on PERF_EVENTS
diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 6020a02..95e210e 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -52,7 +52,7 @@ static const struct of_device_id arm_cci_matches[] = {
 #ifdef CONFIG_ARM_CCI400_COMMON
 	{.compatible = "arm,cci-400", .data = CCI400_PORTS_DATA },
 #endif
-#ifdef CONFIG_ARM_CCI500_PMU
+#ifdef CONFIG_ARM_CCI5xx_PMU
 	{ .compatible = "arm,cci-500", },
 #endif
 	{},
@@ -92,7 +92,7 @@ static const struct of_device_id arm_cci_matches[] = {
 enum {
 	CCI_IF_SLAVE,
 	CCI_IF_MASTER,
-#ifdef CONFIG_ARM_CCI500_PMU
+#ifdef CONFIG_ARM_CCI5xx_PMU
 	CCI_IF_GLOBAL,
 #endif
 	CCI_IF_MAX,
@@ -154,7 +154,7 @@ enum cci_models {
 	CCI400_R0,
 	CCI400_R1,
 #endif
-#ifdef CONFIG_ARM_CCI500_PMU
+#ifdef CONFIG_ARM_CCI5xx_PMU
 	CCI500_R0,
 #endif
 	CCI_MODEL_MAX
@@ -424,73 +424,67 @@ static inline struct cci_pmu_model *probe_cci_model(struct platform_device *pdev
 }
 #endif	/* CONFIG_ARM_CCI400_PMU */
 
-#ifdef CONFIG_ARM_CCI500_PMU
+#ifdef CONFIG_ARM_CCI5xx_PMU
 
 /*
- * CCI500 provides 8 independent event counters that can count
- * any of the events available.
- *
- * CCI500 PMU event id is an 9-bit value made of two parts.
+ * CCI5xx PMU event id is an 9-bit value made of two parts.
  *	 bits [8:5] - Source for the event
- *		      0x0-0x6 - Slave interfaces
- *		      0x8-0xD - Master interfaces
- *		      0xf     - Global Events
- *		      0x7,0xe - Reserved
- *
  *	 bits [4:0] - Event code (specific to type of interface)
+ *
+ *
  */
 
 /* Port ids */
-#define CCI500_PORT_S0			0x0
-#define CCI500_PORT_S1			0x1
-#define CCI500_PORT_S2			0x2
-#define CCI500_PORT_S3			0x3
-#define CCI500_PORT_S4			0x4
-#define CCI500_PORT_S5			0x5
-#define CCI500_PORT_S6			0x6
-
-#define CCI500_PORT_M0			0x8
-#define CCI500_PORT_M1			0x9
-#define CCI500_PORT_M2			0xa
-#define CCI500_PORT_M3			0xb
-#define CCI500_PORT_M4			0xc
-#define CCI500_PORT_M5			0xd
-
-#define CCI500_PORT_GLOBAL 		0xf
-
-#define CCI500_PMU_EVENT_MASK		0x1ffUL
-#define CCI500_PMU_EVENT_SOURCE_SHIFT	0x5
-#define CCI500_PMU_EVENT_SOURCE_MASK	0xf
-#define CCI500_PMU_EVENT_CODE_SHIFT	0x0
-#define CCI500_PMU_EVENT_CODE_MASK	0x1f
-
-#define CCI500_PMU_EVENT_SOURCE(event)	\
-	((event >> CCI500_PMU_EVENT_SOURCE_SHIFT) & CCI500_PMU_EVENT_SOURCE_MASK)
-#define CCI500_PMU_EVENT_CODE(event)	\
-	((event >> CCI500_PMU_EVENT_CODE_SHIFT) & CCI500_PMU_EVENT_CODE_MASK)
-
-#define CCI500_SLAVE_PORT_MIN_EV	0x00
-#define CCI500_SLAVE_PORT_MAX_EV	0x1f
-#define CCI500_MASTER_PORT_MIN_EV	0x00
-#define CCI500_MASTER_PORT_MAX_EV	0x06
-#define CCI500_GLOBAL_PORT_MIN_EV	0x00
-#define CCI500_GLOBAL_PORT_MAX_EV	0x0f
-
-
-#define CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(_name, _config) \
-	CCI_EXT_ATTR_ENTRY(_name, cci500_pmu_global_event_show, \
+#define CCI5xx_PORT_S0			0x0
+#define CCI5xx_PORT_S1			0x1
+#define CCI5xx_PORT_S2			0x2
+#define CCI5xx_PORT_S3			0x3
+#define CCI5xx_PORT_S4			0x4
+#define CCI5xx_PORT_S5			0x5
+#define CCI5xx_PORT_S6			0x6
+
+#define CCI5xx_PORT_M0			0x8
+#define CCI5xx_PORT_M1			0x9
+#define CCI5xx_PORT_M2			0xa
+#define CCI5xx_PORT_M3			0xb
+#define CCI5xx_PORT_M4			0xc
+#define CCI5xx_PORT_M5			0xd
+
+#define CCI5xx_PORT_GLOBAL		0xf
+
+#define CCI5xx_PMU_EVENT_MASK		0x1ffUL
+#define CCI5xx_PMU_EVENT_SOURCE_SHIFT	0x5
+#define CCI5xx_PMU_EVENT_SOURCE_MASK	0xf
+#define CCI5xx_PMU_EVENT_CODE_SHIFT	0x0
+#define CCI5xx_PMU_EVENT_CODE_MASK	0x1f
+
+#define CCI5xx_PMU_EVENT_SOURCE(event)	\
+	((event >> CCI5xx_PMU_EVENT_SOURCE_SHIFT) & CCI5xx_PMU_EVENT_SOURCE_MASK)
+#define CCI5xx_PMU_EVENT_CODE(event)	\
+	((event >> CCI5xx_PMU_EVENT_CODE_SHIFT) & CCI5xx_PMU_EVENT_CODE_MASK)
+
+#define CCI5xx_SLAVE_PORT_MIN_EV	0x00
+#define CCI5xx_SLAVE_PORT_MAX_EV	0x1f
+#define CCI5xx_MASTER_PORT_MIN_EV	0x00
+#define CCI5xx_MASTER_PORT_MAX_EV	0x06
+#define CCI5xx_GLOBAL_PORT_MIN_EV	0x00
+#define CCI5xx_GLOBAL_PORT_MAX_EV	0x0f
+
+
+#define CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(_name, _config) \
+	CCI_EXT_ATTR_ENTRY(_name, cci5xx_pmu_global_event_show, \
 					(unsigned long) _config)
 
-static ssize_t cci500_pmu_global_event_show(struct device *dev,
+static ssize_t cci5xx_pmu_global_event_show(struct device *dev,
 				struct device_attribute *attr, char *buf);
 
-static struct attribute *cci500_pmu_format_attrs[] = {
+static struct attribute *cci5xx_pmu_format_attrs[] = {
 	CCI_FORMAT_EXT_ATTR_ENTRY(event, "config:0-4"),
 	CCI_FORMAT_EXT_ATTR_ENTRY(source, "config:5-8"),
 	NULL,
 };
 
-static struct attribute *cci500_pmu_event_attrs[] = {
+static struct attribute *cci5xx_pmu_event_attrs[] = {
 	/* Slave events */
 	CCI_EVENT_EXT_ATTR_ENTRY(si_rrq_hs_arvalid, 0x0),
 	CCI_EVENT_EXT_ATTR_ENTRY(si_rrq_dev, 0x1),
@@ -535,64 +529,73 @@ static struct attribute *cci500_pmu_event_attrs[] = {
 	CCI_EVENT_EXT_ATTR_ENTRY(mi_w_resp_stall, 0x6),
 
 	/* Global events */
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_filter_bank_0_1, 0x0),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_filter_bank_2_3, 0x1),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_filter_bank_4_5, 0x2),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_filter_bank_6_7, 0x3),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_miss_filter_bank_0_1, 0x4),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_miss_filter_bank_2_3, 0x5),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_miss_filter_bank_4_5, 0x6),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_miss_filter_bank_6_7, 0x7),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_back_invalidation, 0x8),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_stall_alloc_busy, 0x9),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_stall_tt_full, 0xA),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_wrq, 0xB),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_cd_hs, 0xC),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_rq_stall_addr_hazard, 0xD),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snopp_rq_stall_tt_full, 0xE),
-	CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_rq_tzmp1_prot, 0xF),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_filter_bank_0_1, 0x0),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_filter_bank_2_3, 0x1),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_filter_bank_4_5, 0x2),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_filter_bank_6_7, 0x3),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_miss_filter_bank_0_1, 0x4),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_miss_filter_bank_2_3, 0x5),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_miss_filter_bank_4_5, 0x6),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_access_miss_filter_bank_6_7, 0x7),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_back_invalidation, 0x8),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_stall_alloc_busy, 0x9),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_stall_tt_full, 0xA),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_wrq, 0xB),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_cd_hs, 0xC),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_rq_stall_addr_hazard, 0xD),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snopp_rq_stall_tt_full, 0xE),
+	CCI5xx_GLOBAL_EVENT_EXT_ATTR_ENTRY(cci_snoop_rq_tzmp1_prot, 0xF),
 	NULL
 };
 
-static ssize_t cci500_pmu_global_event_show(struct device *dev,
+static ssize_t cci5xx_pmu_global_event_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct dev_ext_attribute *eattr = container_of(attr,
 					struct dev_ext_attribute, attr);
 	/* Global events have single fixed source code */
 	return snprintf(buf, PAGE_SIZE, "event=0x%lx,source=0x%x\n",
-				(unsigned long)eattr->var, CCI500_PORT_GLOBAL);
+				(unsigned long)eattr->var, CCI5xx_PORT_GLOBAL);
 }
 
+/*
+ * CCI500 provides 8 independent event counters that can count
+ * any of the events available.
+ * CCI500 PMU event source ids
+ *	0x0-0x6 - Slave interfaces
+ *	0x8-0xD - Master interfaces
+ *	0xf     - Global Events
+ *	0x7,0xe - Reserved
+ */
 static int cci500_validate_hw_event(struct cci_pmu *cci_pmu,
 					unsigned long hw_event)
 {
-	u32 ev_source = CCI500_PMU_EVENT_SOURCE(hw_event);
-	u32 ev_code = CCI500_PMU_EVENT_CODE(hw_event);
+	u32 ev_source = CCI5xx_PMU_EVENT_SOURCE(hw_event);
+	u32 ev_code = CCI5xx_PMU_EVENT_CODE(hw_event);
 	int if_type;
 
-	if (hw_event & ~CCI500_PMU_EVENT_MASK)
+	if (hw_event & ~CCI5xx_PMU_EVENT_MASK)
 		return -ENOENT;
 
 	switch (ev_source) {
-	case CCI500_PORT_S0:
-	case CCI500_PORT_S1:
-	case CCI500_PORT_S2:
-	case CCI500_PORT_S3:
-	case CCI500_PORT_S4:
-	case CCI500_PORT_S5:
-	case CCI500_PORT_S6:
+	case CCI5xx_PORT_S0:
+	case CCI5xx_PORT_S1:
+	case CCI5xx_PORT_S2:
+	case CCI5xx_PORT_S3:
+	case CCI5xx_PORT_S4:
+	case CCI5xx_PORT_S5:
+	case CCI5xx_PORT_S6:
 		if_type = CCI_IF_SLAVE;
 		break;
-	case CCI500_PORT_M0:
-	case CCI500_PORT_M1:
-	case CCI500_PORT_M2:
-	case CCI500_PORT_M3:
-	case CCI500_PORT_M4:
-	case CCI500_PORT_M5:
+	case CCI5xx_PORT_M0:
+	case CCI5xx_PORT_M1:
+	case CCI5xx_PORT_M2:
+	case CCI5xx_PORT_M3:
+	case CCI5xx_PORT_M4:
+	case CCI5xx_PORT_M5:
 		if_type = CCI_IF_MASTER;
 		break;
-	case CCI500_PORT_GLOBAL:
+	case CCI5xx_PORT_GLOBAL:
 		if_type = CCI_IF_GLOBAL;
 		break;
 	default:
@@ -605,7 +608,8 @@ static int cci500_validate_hw_event(struct cci_pmu *cci_pmu,
 
 	return -ENOENT;
 }
-#endif	/* CONFIG_ARM_CCI500_PMU */
+
+#endif	/* CONFIG_ARM_CCI5xx_PMU */
 
 static ssize_t cci_pmu_format_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
@@ -835,7 +839,7 @@ static void __pmu_write_counter(struct cci_pmu *cci_pmu, u32 value, int idx)
 	pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
 }
 
-#ifdef CONFIG_ARM_CCI500_PMU
+#ifdef CONFIG_ARM_CCI5xx_PMU
 
 /*
  * CCI-500 has advanced power saving policies, which could gate the
@@ -860,16 +864,16 @@ static void __pmu_write_counter(struct cci_pmu *cci_pmu, u32 value, int idx)
  * assigned a valid code for step(2). We use the highest possible
  * event code (0x1f) for the master interface 0.
  */
-#define CCI500_INVALID_EVENT	((CCI500_PORT_M0 << CCI500_PMU_EVENT_SOURCE_SHIFT) | \
-				 (CCI500_PMU_EVENT_CODE_MASK << CCI500_PMU_EVENT_CODE_SHIFT))
-static void cci500_pmu_write_counter(struct cci_pmu *cci_pmu, u32 value, int idx)
+#define CCI5xx_INVALID_EVENT	((CCI5xx_PORT_M0 << CCI5xx_PMU_EVENT_SOURCE_SHIFT) | \
+				 (CCI5xx_PMU_EVENT_CODE_MASK << CCI5xx_PMU_EVENT_CODE_SHIFT))
+static void cci5xx_pmu_write_counter(struct cci_pmu *cci_pmu, u32 value, int idx)
 {
 	unsigned long mask[BITS_TO_LONGS(cci_pmu->num_cntrs)];
 	u32 event;
 
 	pmu_disable_counters(cci_pmu, mask);
 	event = pmu_get_event(cci_pmu, idx);
-	pmu_set_event(cci_pmu, idx, CCI500_INVALID_EVENT);
+	pmu_set_event(cci_pmu, idx, CCI5xx_INVALID_EVENT);
 	pmu_enable_counter(cci_pmu, idx);
 	__cci_pmu_enable();
 	__pmu_write_counter(cci_pmu, value, idx);
@@ -879,7 +883,7 @@ static void cci500_pmu_write_counter(struct cci_pmu *cci_pmu, u32 value, int idx
 	pmu_restore_counters(cci_pmu, mask);
 }
 
-#endif	/* CONFIG_ARM_CCI500_PMU */
+#endif	/* CONFIG_ARM_CCI5xx_PMU */
 
 static void pmu_write_counter(struct perf_event *event, u32 value)
 {
@@ -1445,30 +1449,30 @@ static struct cci_pmu_model cci_pmu_models[] = {
 		.get_event_idx = cci400_get_event_idx,
 	},
 #endif
-#ifdef CONFIG_ARM_CCI500_PMU
+#ifdef CONFIG_ARM_CCI5xx_PMU
 	[CCI500_R0] = {
 		.name = "CCI_500",
 		.fixed_hw_cntrs = 0,
 		.num_hw_cntrs = 8,
 		.cntr_size = SZ_64K,
-		.format_attrs = cci500_pmu_format_attrs,
-		.event_attrs = cci500_pmu_event_attrs,
+		.format_attrs = cci5xx_pmu_format_attrs,
+		.event_attrs = cci5xx_pmu_event_attrs,
 		.event_ranges = {
 			[CCI_IF_SLAVE] = {
-				CCI500_SLAVE_PORT_MIN_EV,
-				CCI500_SLAVE_PORT_MAX_EV,
+				CCI5xx_SLAVE_PORT_MIN_EV,
+				CCI5xx_SLAVE_PORT_MAX_EV,
 			},
 			[CCI_IF_MASTER] = {
-				CCI500_MASTER_PORT_MIN_EV,
-				CCI500_MASTER_PORT_MAX_EV,
+				CCI5xx_MASTER_PORT_MIN_EV,
+				CCI5xx_MASTER_PORT_MAX_EV,
 			},
 			[CCI_IF_GLOBAL] = {
-				CCI500_GLOBAL_PORT_MIN_EV,
-				CCI500_GLOBAL_PORT_MAX_EV,
+				CCI5xx_GLOBAL_PORT_MIN_EV,
+				CCI5xx_GLOBAL_PORT_MAX_EV,
 			},
 		},
 		.validate_hw_event = cci500_validate_hw_event,
-		.write_counter	= cci500_pmu_write_counter,
+		.write_counter	= cci5xx_pmu_write_counter,
 	},
 #endif
 };
@@ -1488,7 +1492,7 @@ static const struct of_device_id arm_cci_pmu_matches[] = {
 		.data	= &cci_pmu_models[CCI400_R1],
 	},
 #endif
-#ifdef CONFIG_ARM_CCI500_PMU
+#ifdef CONFIG_ARM_CCI5xx_PMU
 	{
 		.compatible = "arm,cci-500-pmu,r0",
 		.data = &cci_pmu_models[CCI500_R0],
-- 
1.7.9.5
