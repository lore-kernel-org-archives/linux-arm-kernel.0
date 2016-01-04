From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  4 Jan 2016 11:54:50 +0000
Subject: [PATCH v5 11/11] arm-cci: CoreLink CCI-550 PMU driver
In-Reply-To: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1451908490-2615-12-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARM CoreLink CCI-550  cache coherent interconnect PMU
driver support. The CCI-550 PMU shares all the attributes of CCI-500
PMU, except for an additional master interface (MI-6 - 0xe).
CCI-550 requires the same work around as for CCI-500 to
write to the PMU counter.

Acked-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 Documentation/devicetree/bindings/arm/cci.txt |    2 +
 drivers/bus/Kconfig                           |    8 +--
 drivers/bus/arm-cci.c                         |   85 ++++++++++++++++++++++++-
 3 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
index aef1d20..a1a5a7e 100644
--- a/Documentation/devicetree/bindings/arm/cci.txt
+++ b/Documentation/devicetree/bindings/arm/cci.txt
@@ -34,6 +34,7 @@ specific to ARM.
 		Definition: must contain one of the following:
 			    "arm,cci-400"
 			    "arm,cci-500"
+			    "arm,cci-550"
 
 	- reg
 		Usage: required
@@ -101,6 +102,7 @@ specific to ARM.
 				 "arm,cci-400-pmu"  - DEPRECATED, permitted only where OS has
 						      secure acces to CCI registers
 				 "arm,cci-500-pmu,r0"
+				 "arm,cci-550-pmu,r0"
 		- reg:
 			Usage: required
 			Value type: Integer cells. A register entry, expressed
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 3793f4e..54c030b 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -35,14 +35,14 @@ config ARM_CCI400_PORT_CTRL
 	  interconnect for ARM platforms.
 
 config ARM_CCI5xx_PMU
-	bool "ARM CCI500 PMU support"
+	bool "ARM CCI-500/CCI-550 PMU support"
 	depends on (ARM && CPU_V7) || ARM64
 	depends on PERF_EVENTS
 	select ARM_CCI_PMU
 	help
-	  Support for PMU events monitoring on the ARM CCI-500 cache coherent
-	  interconnect. CCI-500 provides 8 independent event counters, which
-	  can count events pertaining to the slave/master interfaces as well
+	  Support for PMU events monitoring on the ARM CCI-500/CCI-550 cache
+	  coherent interconnects. Both of them provide 8 independent event counters,
+	  which can count events pertaining to the slave/master interfaces as well
 	  as the internal events to the CCI.
 
 	  If unsure, say Y
diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 9180187..cfe2afe8 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -54,6 +54,7 @@ static const struct of_device_id arm_cci_matches[] = {
 #endif
 #ifdef CONFIG_ARM_CCI5xx_PMU
 	{ .compatible = "arm,cci-500", },
+	{ .compatible = "arm,cci-550", },
 #endif
 	{},
 };
@@ -164,6 +165,7 @@ enum cci_models {
 #endif
 #ifdef CONFIG_ARM_CCI5xx_PMU
 	CCI500_R0,
+	CCI550_R0,
 #endif
 	CCI_MODEL_MAX
 };
@@ -457,6 +459,7 @@ static inline struct cci_pmu_model *probe_cci_model(struct platform_device *pdev
 #define CCI5xx_PORT_M3			0xb
 #define CCI5xx_PORT_M4			0xc
 #define CCI5xx_PORT_M5			0xd
+#define CCI5xx_PORT_M6			0xe
 
 #define CCI5xx_PORT_GLOBAL		0xf
 
@@ -617,6 +620,58 @@ static int cci500_validate_hw_event(struct cci_pmu *cci_pmu,
 	return -ENOENT;
 }
 
+/*
+ * CCI550 provides 8 independent event counters that can count
+ * any of the events available.
+ * CCI550 PMU event source ids
+ *	0x0-0x6 - Slave interfaces
+ *	0x8-0xe - Master interfaces
+ *	0xf     - Global Events
+ *	0x7	- Reserved
+ */
+static int cci550_validate_hw_event(struct cci_pmu *cci_pmu,
+					unsigned long hw_event)
+{
+	u32 ev_source = CCI5xx_PMU_EVENT_SOURCE(hw_event);
+	u32 ev_code = CCI5xx_PMU_EVENT_CODE(hw_event);
+	int if_type;
+
+	if (hw_event & ~CCI5xx_PMU_EVENT_MASK)
+		return -ENOENT;
+
+	switch (ev_source) {
+	case CCI5xx_PORT_S0:
+	case CCI5xx_PORT_S1:
+	case CCI5xx_PORT_S2:
+	case CCI5xx_PORT_S3:
+	case CCI5xx_PORT_S4:
+	case CCI5xx_PORT_S5:
+	case CCI5xx_PORT_S6:
+		if_type = CCI_IF_SLAVE;
+		break;
+	case CCI5xx_PORT_M0:
+	case CCI5xx_PORT_M1:
+	case CCI5xx_PORT_M2:
+	case CCI5xx_PORT_M3:
+	case CCI5xx_PORT_M4:
+	case CCI5xx_PORT_M5:
+	case CCI5xx_PORT_M6:
+		if_type = CCI_IF_MASTER;
+		break;
+	case CCI5xx_PORT_GLOBAL:
+		if_type = CCI_IF_GLOBAL;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	if (ev_code >= cci_pmu->model->event_ranges[if_type].min &&
+		ev_code <= cci_pmu->model->event_ranges[if_type].max)
+		return hw_event;
+
+	return -ENOENT;
+}
+
 #endif	/* CONFIG_ARM_CCI5xx_PMU */
 
 static ssize_t cci_pmu_format_show(struct device *dev,
@@ -844,7 +899,7 @@ static void __pmu_write_counter(struct cci_pmu *cci_pmu, u32 value, int idx)
 #ifdef CONFIG_ARM_CCI5xx_PMU
 
 /*
- * CCI-500 has advanced power saving policies, which could gate the
+ * CCI-500/CCI-550 has advanced power saving policies, which could gate the
  * clocks to the PMU counters, which makes the writes to them ineffective.
  * The only way to write to those counters is when the global counters
  * are enabled and the particular counter is enabled.
@@ -1546,6 +1601,30 @@ static struct cci_pmu_model cci_pmu_models[] = {
 		.validate_hw_event = cci500_validate_hw_event,
 		.write_counters	= cci5xx_pmu_write_counters,
 	},
+	[CCI550_R0] = {
+		.name = "CCI_550",
+		.fixed_hw_cntrs = 0,
+		.num_hw_cntrs = 8,
+		.cntr_size = SZ_64K,
+		.format_attrs = cci5xx_pmu_format_attrs,
+		.event_attrs = cci5xx_pmu_event_attrs,
+		.event_ranges = {
+			[CCI_IF_SLAVE] = {
+				CCI5xx_SLAVE_PORT_MIN_EV,
+				CCI5xx_SLAVE_PORT_MAX_EV,
+			},
+			[CCI_IF_MASTER] = {
+				CCI5xx_MASTER_PORT_MIN_EV,
+				CCI5xx_MASTER_PORT_MAX_EV,
+			},
+			[CCI_IF_GLOBAL] = {
+				CCI5xx_GLOBAL_PORT_MIN_EV,
+				CCI5xx_GLOBAL_PORT_MAX_EV,
+			},
+		},
+		.validate_hw_event = cci550_validate_hw_event,
+		.write_counters	= cci5xx_pmu_write_counters,
+	},
 #endif
 };
 
@@ -1569,6 +1648,10 @@ static const struct of_device_id arm_cci_pmu_matches[] = {
 		.compatible = "arm,cci-500-pmu,r0",
 		.data = &cci_pmu_models[CCI500_R0],
 	},
+	{
+		.compatible = "arm,cci-550-pmu,r0",
+		.data = &cci_pmu_models[CCI550_R0],
+	},
 #endif
 	{},
 };
-- 
1.7.9.5
