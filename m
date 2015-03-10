From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 10 Mar 2015 15:18:51 +0000
Subject: [PATCH 1/5] arm-cci: Rearrange code for splitting PMU vs driver code
In-Reply-To: <1426000735-14375-1-git-send-email-suzuki.poulose@arm.com>
References: <1426000735-14375-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1426000735-14375-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

No functional changes, only code re-arrangements for easier split of the
PMU code vs low level driver code. Extracts the port handling code
to cci_probe_ports().

Change since V2:
 - Removed unnecessary goto. (Suggested-by: Sudeep Holla)

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |  326 ++++++++++++++++++++++++-------------------------
 1 file changed, 163 insertions(+), 163 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 84fd660..ea39fc2 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -29,42 +29,29 @@
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 
-#define DRIVER_NAME		"CCI-400"
-#define DRIVER_NAME_PMU		DRIVER_NAME " PMU"
-
-#define CCI_PORT_CTRL		0x0
-#define CCI_CTRL_STATUS		0xc
-
-#define CCI_ENABLE_SNOOP_REQ	0x1
-#define CCI_ENABLE_DVM_REQ	0x2
-#define CCI_ENABLE_REQ		(CCI_ENABLE_SNOOP_REQ | CCI_ENABLE_DVM_REQ)
+static void __iomem *cci_ctrl_base;
+static unsigned long cci_ctrl_phys;
 
 struct cci_nb_ports {
 	unsigned int nb_ace;
 	unsigned int nb_ace_lite;
 };
 
-enum cci_ace_port_type {
-	ACE_INVALID_PORT = 0x0,
-	ACE_PORT,
-	ACE_LITE_PORT,
+static const struct cci_nb_ports cci400_ports = {
+	.nb_ace = 2,
+	.nb_ace_lite = 3
 };
 
-struct cci_ace_port {
-	void __iomem *base;
-	unsigned long phys;
-	enum cci_ace_port_type type;
-	struct device_node *dn;
+static const struct of_device_id arm_cci_matches[] = {
+	{.compatible = "arm,cci-400", .data = &cci400_ports },
+	{},
 };
 
-static struct cci_ace_port *ports;
-static unsigned int nb_cci_ports;
-
-static void __iomem *cci_ctrl_base;
-static unsigned long cci_ctrl_phys;
-
 #ifdef CONFIG_HW_PERF_EVENTS
 
+#define DRIVER_NAME		"CCI-400"
+#define DRIVER_NAME_PMU		DRIVER_NAME " PMU"
+
 #define CCI_PMCR		0x0100
 #define CCI_PID2		0x0fe8
 
@@ -75,6 +62,47 @@ static unsigned long cci_ctrl_phys;
 #define CCI_PID2_REV_MASK	0xf0
 #define CCI_PID2_REV_SHIFT	4
 
+#define CCI_PMU_EVT_SEL		0x000
+#define CCI_PMU_CNTR		0x004
+#define CCI_PMU_CNTR_CTRL	0x008
+#define CCI_PMU_OVRFLW		0x00c
+
+#define CCI_PMU_OVRFLW_FLAG	1
+
+#define CCI_PMU_CNTR_BASE(idx)	((idx) * SZ_4K)
+
+#define CCI_PMU_CNTR_MASK	((1ULL << 32) -1)
+
+#define CCI_PMU_EVENT_MASK		0xff
+#define CCI_PMU_EVENT_SOURCE(event)	((event >> 5) & 0x7)
+#define CCI_PMU_EVENT_CODE(event)	(event & 0x1f)
+
+#define CCI_PMU_MAX_HW_EVENTS 5   /* CCI PMU has 4 counters + 1 cycle counter */
+
+struct cci_pmu_hw_events {
+	struct perf_event *events[CCI_PMU_MAX_HW_EVENTS];
+	unsigned long used_mask[BITS_TO_LONGS(CCI_PMU_MAX_HW_EVENTS)];
+	raw_spinlock_t pmu_lock;
+};
+
+struct cci_pmu {
+	void __iomem *base;
+	struct pmu pmu;
+	int nr_irqs;
+	int irqs[CCI_PMU_MAX_HW_EVENTS];
+	unsigned long active_irqs;
+	struct pmu_port_event_ranges *port_ranges;
+	struct cci_pmu_hw_events hw_events;
+	struct platform_device *plat_device;
+	int num_events;
+	atomic_t active_events;
+	struct mutex reserve_mutex;
+	cpumask_t cpus;
+};
+static struct cci_pmu *pmu;
+
+#define to_cci_pmu(c)	(container_of(c, struct cci_pmu, pmu))
+
 /* Port ids */
 #define CCI_PORT_S0	0
 #define CCI_PORT_S1	1
@@ -89,17 +117,6 @@ static unsigned long cci_ctrl_phys;
 #define CCI_REV_R1		1
 #define CCI_REV_R1_PX		5
 
-#define CCI_PMU_EVT_SEL		0x000
-#define CCI_PMU_CNTR		0x004
-#define CCI_PMU_CNTR_CTRL	0x008
-#define CCI_PMU_OVRFLW		0x00c
-
-#define CCI_PMU_OVRFLW_FLAG	1
-
-#define CCI_PMU_CNTR_BASE(idx)	((idx) * SZ_4K)
-
-#define CCI_PMU_CNTR_MASK	((1ULL << 32) -1)
-
 /*
  * Instead of an event id to monitor CCI cycles, a dedicated counter is
  * provided. Use 0xff to represent CCI cycles and hope that no future revisions
@@ -109,12 +126,6 @@ enum cci400_perf_events {
 	CCI_PMU_CYCLES = 0xff
 };
 
-#define CCI_PMU_EVENT_MASK		0xff
-#define CCI_PMU_EVENT_SOURCE(event)	((event >> 5) & 0x7)
-#define CCI_PMU_EVENT_CODE(event)	(event & 0x1f)
-
-#define CCI_PMU_MAX_HW_EVENTS 5   /* CCI PMU has 4 counters + 1 cycle counter */
-
 #define CCI_PMU_CYCLE_CNTR_IDX		0
 #define CCI_PMU_CNTR0_IDX		1
 #define CCI_PMU_CNTR_LAST(cci_pmu)	(CCI_PMU_CYCLE_CNTR_IDX + cci_pmu->num_events - 1)
@@ -172,60 +183,6 @@ static char *const pmu_names[] = {
 	[CCI_REV_R1] = "CCI_400_r1",
 };
 
-struct cci_pmu_hw_events {
-	struct perf_event *events[CCI_PMU_MAX_HW_EVENTS];
-	unsigned long used_mask[BITS_TO_LONGS(CCI_PMU_MAX_HW_EVENTS)];
-	raw_spinlock_t pmu_lock;
-};
-
-struct cci_pmu {
-	void __iomem *base;
-	struct pmu pmu;
-	int nr_irqs;
-	int irqs[CCI_PMU_MAX_HW_EVENTS];
-	unsigned long active_irqs;
-	struct pmu_port_event_ranges *port_ranges;
-	struct cci_pmu_hw_events hw_events;
-	struct platform_device *plat_device;
-	int num_events;
-	atomic_t active_events;
-	struct mutex reserve_mutex;
-	cpumask_t cpus;
-};
-static struct cci_pmu *pmu;
-
-#define to_cci_pmu(c)	(container_of(c, struct cci_pmu, pmu))
-
-static bool is_duplicate_irq(int irq, int *irqs, int nr_irqs)
-{
-	int i;
-
-	for (i = 0; i < nr_irqs; i++)
-		if (irq == irqs[i])
-			return true;
-
-	return false;
-}
-
-static int probe_cci_revision(void)
-{
-	int rev;
-	rev = readl_relaxed(cci_ctrl_base + CCI_PID2) & CCI_PID2_REV_MASK;
-	rev >>= CCI_PID2_REV_SHIFT;
-
-	if (rev < CCI_REV_R1_PX)
-		return CCI_REV_R0;
-	else
-		return CCI_REV_R1;
-}
-
-static struct pmu_port_event_ranges *port_range_by_rev(void)
-{
-	int rev = probe_cci_revision();
-
-	return &port_event_range[rev];
-}
-
 static int pmu_is_valid_slave_event(u8 ev_code)
 {
 	return pmu->port_ranges->slave_min <= ev_code &&
@@ -265,6 +222,25 @@ static int pmu_validate_hw_event(u8 hw_event)
 	return -ENOENT;
 }
 
+static int probe_cci_revision(void)
+{
+	int rev;
+	rev = readl_relaxed(cci_ctrl_base + CCI_PID2) & CCI_PID2_REV_MASK;
+	rev >>= CCI_PID2_REV_SHIFT;
+
+	if (rev < CCI_REV_R1_PX)
+		return CCI_REV_R0;
+	else
+		return CCI_REV_R1;
+}
+
+static struct pmu_port_event_ranges *port_range_by_rev(void)
+{
+	int rev = probe_cci_revision();
+
+	return &port_event_range[rev];
+}
+
 static int pmu_is_valid_counter(struct cci_pmu *cci_pmu, int idx)
 {
 	return CCI_PMU_CYCLE_CNTR_IDX <= idx &&
@@ -893,6 +869,17 @@ static const struct of_device_id arm_cci_pmu_matches[] = {
 	{},
 };
 
+static bool is_duplicate_irq(int irq, int *irqs, int nr_irqs)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++)
+		if (irq == irqs[i])
+			return true;
+
+	return false;
+}
+
 static int cci_pmu_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -963,8 +950,65 @@ static int cci_platform_probe(struct platform_device *pdev)
 	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
 }
 
+static struct platform_driver cci_pmu_driver = {
+	.driver = {
+		   .name = DRIVER_NAME_PMU,
+		   .of_match_table = arm_cci_pmu_matches,
+		  },
+	.probe = cci_pmu_probe,
+};
+
+static struct platform_driver cci_platform_driver = {
+	.driver = {
+		   .name = DRIVER_NAME,
+		   .of_match_table = arm_cci_matches,
+		  },
+	.probe = cci_platform_probe,
+};
+
+static int __init cci_platform_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&cci_pmu_driver);
+	if (ret)
+		return ret;
+
+	return platform_driver_register(&cci_platform_driver);
+}
+
+#else /* !CONFIG_HW_PERF_EVENTS */
+
+static int __init cci_platform_init(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_HW_PERF_EVENTS */
 
+#define CCI_PORT_CTRL		0x0
+#define CCI_CTRL_STATUS		0xc
+
+#define CCI_ENABLE_SNOOP_REQ	0x1
+#define CCI_ENABLE_DVM_REQ	0x2
+#define CCI_ENABLE_REQ		(CCI_ENABLE_SNOOP_REQ | CCI_ENABLE_DVM_REQ)
+
+enum cci_ace_port_type {
+	ACE_INVALID_PORT = 0x0,
+	ACE_PORT,
+	ACE_LITE_PORT,
+};
+
+struct cci_ace_port {
+	void __iomem *base;
+	unsigned long phys;
+	enum cci_ace_port_type type;
+	struct device_node *dn;
+};
+
+static struct cci_ace_port *ports;
+static unsigned int nb_cci_ports;
+
 struct cpu_port {
 	u64 mpidr;
 	u32 port;
@@ -1284,36 +1328,20 @@ int notrace __cci_control_port_by_index(u32 port, bool enable)
 }
 EXPORT_SYMBOL_GPL(__cci_control_port_by_index);
 
-static const struct cci_nb_ports cci400_ports = {
-	.nb_ace = 2,
-	.nb_ace_lite = 3
-};
-
-static const struct of_device_id arm_cci_matches[] = {
-	{.compatible = "arm,cci-400", .data = &cci400_ports },
-	{},
-};
-
 static const struct of_device_id arm_cci_ctrl_if_matches[] = {
 	{.compatible = "arm,cci-400-ctrl-if", },
 	{},
 };
 
-static int cci_probe(void)
+static int cci_probe_ports(struct device_node *np)
 {
 	struct cci_nb_ports const *cci_config;
 	int ret, i, nb_ace = 0, nb_ace_lite = 0;
-	struct device_node *np, *cp;
+	struct device_node *cp;
 	struct resource res;
 	const char *match_str;
 	bool is_ace;
 
-	np = of_find_matching_node(NULL, arm_cci_matches);
-	if (!np)
-		return -ENODEV;
-
-	if (!of_device_is_available(np))
-		return -ENODEV;
 
 	cci_config = of_match_node(arm_cci_matches, np)->data;
 	if (!cci_config)
@@ -1325,17 +1353,6 @@ static int cci_probe(void)
 	if (!ports)
 		return -ENOMEM;
 
-	ret = of_address_to_resource(np, 0, &res);
-	if (!ret) {
-		cci_ctrl_base = ioremap(res.start, resource_size(&res));
-		cci_ctrl_phys =	res.start;
-	}
-	if (ret || !cci_ctrl_base) {
-		WARN(1, "unable to ioremap CCI ctrl\n");
-		ret = -ENXIO;
-		goto memalloc_err;
-	}
-
 	for_each_child_of_node(np, cp) {
 		if (!of_match_node(arm_cci_ctrl_if_matches, cp))
 			continue;
@@ -1395,12 +1412,31 @@ static int cci_probe(void)
 	sync_cache_w(&cpu_port);
 	__sync_cache_range_w(ports, sizeof(*ports) * nb_cci_ports);
 	pr_info("ARM CCI driver probed\n");
+
 	return 0;
+}
 
-memalloc_err:
+static int cci_probe(void)
+{
+	int ret;
+	struct device_node *np;
+	struct resource res;
 
-	kfree(ports);
-	return ret;
+	np = of_find_matching_node(NULL, arm_cci_matches);
+	if(!np || !of_device_is_available(np))
+		return -ENODEV;
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (!ret) {
+		cci_ctrl_base = ioremap(res.start, resource_size(&res));
+		cci_ctrl_phys =	res.start;
+	}
+	if (ret || !cci_ctrl_base) {
+		WARN(1, "unable to ioremap CCI ctrl\n");
+		return -ENXIO;
+	}
+
+	return cci_probe_ports(np);
 }
 
 static int cci_init_status = -EAGAIN;
@@ -1418,42 +1454,6 @@ static int cci_init(void)
 	return cci_init_status;
 }
 
-#ifdef CONFIG_HW_PERF_EVENTS
-static struct platform_driver cci_pmu_driver = {
-	.driver = {
-		   .name = DRIVER_NAME_PMU,
-		   .of_match_table = arm_cci_pmu_matches,
-		  },
-	.probe = cci_pmu_probe,
-};
-
-static struct platform_driver cci_platform_driver = {
-	.driver = {
-		   .name = DRIVER_NAME,
-		   .of_match_table = arm_cci_matches,
-		  },
-	.probe = cci_platform_probe,
-};
-
-static int __init cci_platform_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&cci_pmu_driver);
-	if (ret)
-		return ret;
-
-	return platform_driver_register(&cci_platform_driver);
-}
-
-#else
-
-static int __init cci_platform_init(void)
-{
-	return 0;
-}
-
-#endif
 /*
  * To sort out early init calls ordering a helper function is provided to
  * check if the CCI driver has beed initialized. Function check if the driver
-- 
1.7.9.5
