From: punit.agrawal@arm.com (Punit Agrawal)
Date: Sun, 11 Aug 2013 03:00:31 -0000
Subject: [PATCH] drivers: CCI: add ARM CCI PMU support
Message-ID: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CCI PMU can profile bus transactions at the master and slave
interfaces of the CCI. The PMU can be used to observe an aggregated view
of the bus traffic between the various components connected to the CCI.

Extend the existing CCI driver to support the PMU by registering a perf
backend for it.

Document the device tree binding to describe the CCI PMU.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Dave Martin <dave.martin@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/devicetree/bindings/arm/cci.txt |   38 ++
 drivers/bus/arm-cci.c                         |  642 +++++++++++++++++++++++++
 2 files changed, 680 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
index 92d36e2..5bc95e5 100644
--- a/Documentation/devicetree/bindings/arm/cci.txt
+++ b/Documentation/devicetree/bindings/arm/cci.txt
@@ -79,6 +79,34 @@ specific to ARM.
 				    corresponding interface programming
 				    registers.
 
+	- CCI PMU node
+
+		Node name must be "pmu".
+		Parent node must be CCI interconnect node.
+
+		A CCI pmu node must contain the following properties:
+
+		- compatible
+			Usage: required
+			Value type: <string>
+			Definition: must be set to one of
+				    "arm,cci-400-pmu"
+				    "arm,cci-400-pmu,rev0"
+				    "arm,cci-400-pmu,rev1"
+
+		- reg:
+			Usage: required
+			Value type: <prop-encoded-array>
+			Definition: the base address and size of the
+				    corresponding interface programming
+				    registers.
+
+		- interrupts:
+			Usage: required
+			Value type: <prop-encoded-array>
+			Definition: comma-separated list of unique PMU
+				    interrupts
+
 * CCI interconnect bus masters
 
 	Description: masters in the device tree connected to a CCI port
@@ -163,6 +191,16 @@ Example:
 			interface-type = "ace";
 			reg = <0x5000 0x1000>;
 		};
+
+		pmu at 9000 {
+			 compatible = "arm,cci-400-pmu,rev0";
+			 reg = <0x9000 0x5000>;
+			 interrupts = <0 101 4>,
+				      <0 102 4>,
+				      <0 103 4>,
+				      <0 104 4>,
+				      <0 105 4>;
+		};
 	};
 
 This CCI node corresponds to a CCI component whose control registers sits
diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 7332889..cc5a923 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -18,11 +18,21 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #include <asm/cacheflush.h>
+#include <asm/irq_regs.h>
+#include <asm/pmu.h>
 #include <asm/smp_plat.h>
 
+#define DRIVER_NAME		"CCI-400"
+#define DRIVER_NAME_PMU		DRIVER_NAME " PMU"
+#define PMU_NAME		"CCI_400"
+
 #define CCI_PORT_CTRL		0x0
 #define CCI_CTRL_STATUS		0xc
 
@@ -54,6 +64,601 @@ static unsigned int nb_cci_ports;
 static void __iomem *cci_ctrl_base;
 static unsigned long cci_ctrl_phys;
 
+#ifdef CONFIG_HW_PERF_EVENTS
+
+#define CCI_PMCR		0x0100
+#define CCI_PID2		0x0fe8
+
+#define CCI_PMCR_CEN		0x00000001
+#define CCI_PMCR_NCNT_MASK	0x0000f800
+#define CCI_PMCR_NCNT_SHIFT	11
+
+#define CCI_PID2_REV_MASK	0xf0
+#define CCI_PID2_REV_SHIFT	4
+
+/* Port ids */
+#define CCI_PORT_S0	0
+#define CCI_PORT_S1	1
+#define CCI_PORT_S2	2
+#define CCI_PORT_S3	3
+#define CCI_PORT_S4	4
+#define CCI_PORT_M0	5
+#define CCI_PORT_M1	6
+#define CCI_PORT_M2	7
+
+#define CCI_REV_R0		0
+#define CCI_REV_R1		1
+#define CCI_REV_R0_P4		4
+#define CCI_REV_R1_P2		6
+
+#define CCI_PMU_EVT_SEL		0x000
+#define CCI_PMU_CNTR		0x004
+#define CCI_PMU_CNTR_CTRL	0x008
+#define CCI_PMU_OVRFLW		0x00c
+
+#define CCI_PMU_OVRFLW_FLAG	1
+
+#define CCI_PMU_CNTR_BASE(idx)	((idx) * SZ_4K)
+
+/*
+ * Instead of an event id to monitor CCI cycles, a dedicated counter is
+ * provided. Use 0xff to represent CCI cycles and hope that no future revisions
+ * make use of this event in hardware.
+ */
+enum cci400_perf_events {
+	CCI_PMU_CYCLES = 0xff
+};
+
+#define CCI_PMU_EVENT_MASK		0xff
+#define CCI_PMU_EVENT_SOURCE(event)	((event >> 5) & 0x7)
+#define CCI_PMU_EVENT_CODE(event)	(event & 0x1f)
+
+#define CCI_PMU_MAX_HW_EVENTS 5   /* CCI PMU has 4 counters + 1 cycle counter */
+
+#define CCI_PMU_CYCLE_CNTR_IDX		0
+#define CCI_PMU_CNTR0_IDX		1
+#define CCI_PMU_CNTR_LAST(cci_pmu)	(CCI_PMU_CYCLE_CNTR_IDX + cci_pmu->num_events - 1)
+
+/*
+ * CCI PMU event id is an 8-bit value made of two parts - bits 7:5 for one of 8
+ * ports and bits 4:0 are event codes. There are different event codes
+ * associated with each port type.
+ *
+ * Additionally, the range of events associated with the port types changed
+ * between Rev0 and Rev1.
+ *
+ * The constants below define the range of valid codes for each port type for
+ * the different revisions and are used to validate the event to be monitored.
+ */
+
+#define CCI_REV_R0_SLAVE_PORT_MIN_EV	0x00
+#define CCI_REV_R0_SLAVE_PORT_MAX_EV	0x13
+#define CCI_REV_R0_MASTER_PORT_MIN_EV	0x14
+#define CCI_REV_R0_MASTER_PORT_MAX_EV	0x1a
+
+#define CCI_REV_R1_SLAVE_PORT_MIN_EV	0x00
+#define CCI_REV_R1_SLAVE_PORT_MAX_EV	0x14
+#define CCI_REV_R1_MASTER_PORT_MIN_EV	0x00
+#define CCI_REV_R1_MASTER_PORT_MAX_EV	0x11
+
+struct pmu_port_event_ranges {
+	u8 slave_min;
+	u8 slave_max;
+	u8 master_min;
+	u8 master_max;
+};
+
+static struct pmu_port_event_ranges port_event_range[] = {
+	[CCI_REV_R0] = {
+		.slave_min = CCI_REV_R0_SLAVE_PORT_MIN_EV,
+		.slave_max = CCI_REV_R0_SLAVE_PORT_MAX_EV,
+		.master_min = CCI_REV_R0_MASTER_PORT_MIN_EV,
+		.master_max = CCI_REV_R0_MASTER_PORT_MAX_EV,
+	},
+	[CCI_REV_R1] = {
+		.slave_min = CCI_REV_R1_SLAVE_PORT_MIN_EV,
+		.slave_max = CCI_REV_R1_SLAVE_PORT_MAX_EV,
+		.master_min = CCI_REV_R1_MASTER_PORT_MIN_EV,
+		.master_max = CCI_REV_R1_MASTER_PORT_MAX_EV,
+	},
+};
+
+struct cci_pmu_drv_data {
+	void __iomem *base;
+	struct arm_pmu *cci_pmu;
+	int nr_irqs;
+	int irqs[CCI_PMU_MAX_HW_EVENTS];
+	unsigned long active_irqs;
+	struct perf_event *events[CCI_PMU_MAX_HW_EVENTS];
+	unsigned long used_mask[BITS_TO_LONGS(CCI_PMU_MAX_HW_EVENTS)];
+	struct pmu_port_event_ranges *port_ranges;
+	struct pmu_hw_events hw_events;
+};
+static struct cci_pmu_drv_data *pmu;
+
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
+static int probe_cci_revision(void)
+{
+	int rev;
+	rev = readl_relaxed(cci_ctrl_base + CCI_PID2) & CCI_PID2_REV_MASK;
+	rev >>= CCI_PID2_REV_SHIFT;
+
+	if (rev <= CCI_REV_R0_P4)
+		return CCI_REV_R0;
+	else if (rev <= CCI_REV_R1_P2)
+		return CCI_REV_R1;
+
+	return -ENOENT;
+}
+
+static struct pmu_port_event_ranges *port_range_by_rev(void)
+{
+	int rev = probe_cci_revision();
+
+	if (rev < 0)
+		return NULL;
+
+	return &port_event_range[rev];
+}
+
+static int pmu_is_valid_slave_event(u8 ev_code)
+{
+	return pmu->port_ranges->slave_min <= ev_code &&
+		ev_code <= pmu->port_ranges->slave_max;
+}
+
+static int pmu_is_valid_master_event(u8 ev_code)
+{
+	return pmu->port_ranges->master_min <= ev_code &&
+		ev_code <= pmu->port_ranges->master_max;
+}
+
+static int pmu_validate_hw_event(u8 hw_event)
+{
+	u8 ev_source = CCI_PMU_EVENT_SOURCE(hw_event);
+	u8 ev_code = CCI_PMU_EVENT_CODE(hw_event);
+
+	switch (ev_source) {
+	case CCI_PORT_S0:
+	case CCI_PORT_S1:
+	case CCI_PORT_S2:
+	case CCI_PORT_S3:
+	case CCI_PORT_S4:
+		/* Slave Interface */
+		if (pmu_is_valid_slave_event(ev_code))
+			return hw_event;
+		break;
+	case CCI_PORT_M0:
+	case CCI_PORT_M1:
+	case CCI_PORT_M2:
+		/* Master Interface */
+		if (pmu_is_valid_master_event(ev_code))
+			return hw_event;
+		break;
+	}
+
+	return -ENOENT;
+}
+
+static int pmu_is_valid_counter(struct arm_pmu *cci_pmu, int idx)
+{
+	return CCI_PMU_CYCLE_CNTR_IDX <= idx &&
+		idx <= CCI_PMU_CNTR_LAST(cci_pmu);
+}
+
+static u32 pmu_read_register(int idx, unsigned int offset)
+{
+	return readl_relaxed(pmu->base + CCI_PMU_CNTR_BASE(idx) + offset);
+}
+
+static void pmu_write_register(u32 value, int idx, unsigned int offset)
+{
+	return writel_relaxed(value, pmu->base + CCI_PMU_CNTR_BASE(idx) + offset);
+}
+
+static void pmu_disable_counter(int idx)
+{
+	pmu_write_register(0, idx, CCI_PMU_CNTR_CTRL);
+}
+
+static void pmu_enable_counter(int idx)
+{
+	pmu_write_register(1, idx, CCI_PMU_CNTR_CTRL);
+}
+
+static void pmu_set_event(int idx, unsigned long event)
+{
+	event &= CCI_PMU_EVENT_MASK;
+	pmu_write_register(event, idx, CCI_PMU_EVT_SEL);
+}
+
+static u32 pmu_get_max_counters(void)
+{
+	u32 n_cnts = (readl_relaxed(cci_ctrl_base + CCI_PMCR) &
+		      CCI_PMCR_NCNT_MASK) >> CCI_PMCR_NCNT_SHIFT;
+
+	/* add 1 for cycle counter */
+	return n_cnts + 1;
+}
+
+static struct pmu_hw_events *pmu_get_hw_events(void)
+{
+	return &pmu->hw_events;
+}
+
+static int pmu_get_event_idx(struct pmu_hw_events *hw, struct perf_event *event)
+{
+	struct arm_pmu *cci_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hw_event = &event->hw;
+	unsigned long cci_event = hw_event->config_base & CCI_PMU_EVENT_MASK;
+	int idx;
+
+	if (cci_event == CCI_PMU_CYCLES) {
+		if (test_and_set_bit(CCI_PMU_CYCLE_CNTR_IDX, hw->used_mask))
+			return -EAGAIN;
+
+		return CCI_PMU_CYCLE_CNTR_IDX;
+	}
+
+	for (idx = CCI_PMU_CNTR0_IDX; idx <= CCI_PMU_CNTR_LAST(cci_pmu); ++idx)
+		if (!test_and_set_bit(idx, hw->used_mask))
+			return idx;
+
+	/* No counters available */
+	return -EAGAIN;
+}
+
+static int pmu_map_event(struct perf_event *event)
+{
+	int mapping;
+	u8 config = event->attr.config & CCI_PMU_EVENT_MASK;
+
+	if (event->attr.type < PERF_TYPE_MAX)
+		return -ENOENT;
+
+	if (config == CCI_PMU_CYCLES)
+		mapping = config;
+	else
+		mapping = pmu_validate_hw_event(config);
+
+	return mapping;
+}
+
+static int pmu_request_irq(struct arm_pmu *cci_pmu, irq_handler_t handler)
+{
+	int i;
+	struct platform_device *pmu_device = cci_pmu->plat_device;
+
+	if (unlikely(!pmu_device))
+		return -ENODEV;
+
+	if (pmu->nr_irqs < 1) {
+		dev_err(&pmu_device->dev, "no irqs for CCI PMUs defined\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Register all available CCI PMU interrupts. In the interrupt handler
+	 * we iterate over the counters checking for interrupt source (the
+	 * overflowing counter) and clear it.
+	 *
+	 * This should allow handling of non-unique interrupt for the counters.
+	 */
+	for (i = 0; i < pmu->nr_irqs; i++) {
+		int err = request_irq(pmu->irqs[i], handler, IRQF_SHARED,
+				"arm-cci-pmu", cci_pmu);
+		if (err) {
+			dev_err(&pmu_device->dev, "unable to request IRQ%d for ARM CCI PMU counters\n",
+				pmu->irqs[i]);
+			return err;
+		}
+
+		set_bit(i, &pmu->active_irqs);
+	}
+
+	return 0;
+}
+
+static irqreturn_t pmu_handle_irq(int irq_num, void *dev)
+{
+	unsigned long flags;
+	struct arm_pmu *cci_pmu = (struct arm_pmu *)dev;
+	struct pmu_hw_events *events = cci_pmu->get_hw_events();
+	struct perf_sample_data data;
+	struct pt_regs *regs;
+	int idx, handled = IRQ_NONE;
+
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+	regs = get_irq_regs();
+	/*
+	 * Iterate over counters and update the corresponding perf events.
+	 * This should work regardless of whether we have per-counter overflow
+	 * interrupt or a combined overflow interrupt.
+	 */
+	for (idx = CCI_PMU_CYCLE_CNTR_IDX; idx <= CCI_PMU_CNTR_LAST(cci_pmu); idx++) {
+		struct perf_event *event = events->events[idx];
+		struct hw_perf_event *hw_counter;
+
+		if (!event)
+			continue;
+
+		hw_counter = &event->hw;
+
+		/* Did this counter overflow? */
+		if (!pmu_read_register(idx, CCI_PMU_OVRFLW) & CCI_PMU_OVRFLW_FLAG)
+			continue;
+
+		pmu_write_register(CCI_PMU_OVRFLW_FLAG, idx, CCI_PMU_OVRFLW);
+
+		handled = IRQ_HANDLED;
+
+		armpmu_event_update(event);
+		perf_sample_data_init(&data, 0, hw_counter->last_period);
+		if (!armpmu_event_set_period(event))
+			continue;
+
+		if (perf_event_overflow(event, &data, regs))
+			cci_pmu->disable(event);
+	}
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+
+	return IRQ_RETVAL(handled);
+}
+
+static void pmu_free_irq(struct arm_pmu *cci_pmu)
+{
+	int i;
+
+	for (i = 0; i < pmu->nr_irqs; i++) {
+		if (!test_and_clear_bit(i, &pmu->active_irqs))
+			continue;
+
+		free_irq(pmu->irqs[i], cci_pmu);
+	}
+}
+
+static void pmu_enable_event(struct perf_event *event)
+{
+	unsigned long flags;
+	struct arm_pmu *cci_pmu = to_arm_pmu(event->pmu);
+	struct pmu_hw_events *events = cci_pmu->get_hw_events();
+	struct hw_perf_event *hw_counter = &event->hw;
+	int idx = hw_counter->idx;
+
+	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx))) {
+		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
+		return;
+	}
+
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+	/* Configure the event to count, unless you are counting cycles */
+	if (idx != CCI_PMU_CYCLE_CNTR_IDX)
+		pmu_set_event(idx, hw_counter->config_base);
+
+	pmu_enable_counter(idx);
+
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static void pmu_disable_event(struct perf_event *event)
+{
+	struct arm_pmu *cci_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hw_counter = &event->hw;
+	int idx = hw_counter->idx;
+
+	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx))) {
+		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
+		return;
+	}
+
+	pmu_disable_counter(idx);
+}
+
+static void pmu_start(struct arm_pmu *cci_pmu)
+{
+	u32 val;
+	unsigned long flags;
+	struct pmu_hw_events *events = cci_pmu->get_hw_events();
+
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+	/* Enable all the PMU counters. */
+	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) | CCI_PMCR_CEN;
+	writel(val, cci_ctrl_base + CCI_PMCR);
+
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static void pmu_stop(struct arm_pmu *cci_pmu)
+{
+	u32 val;
+	unsigned long flags;
+	struct pmu_hw_events *events = cci_pmu->get_hw_events();
+
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+	/* Disable all the PMU counters. */
+	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) & ~CCI_PMCR_CEN;
+	writel(val, cci_ctrl_base + CCI_PMCR);
+
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static u32 pmu_read_counter(struct perf_event *event)
+{
+	struct arm_pmu *cci_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hw_counter = &event->hw;
+	int idx = hw_counter->idx;
+	u32 value;
+
+	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx))) {
+		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
+		return 0;
+	}
+	value = pmu_read_register(idx, CCI_PMU_CNTR);
+
+	return value;
+}
+
+static void pmu_write_counter(struct perf_event *event, u32 value)
+{
+	struct arm_pmu *cci_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hw_counter = &event->hw;
+	int idx = hw_counter->idx;
+
+	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx)))
+		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
+	else
+		pmu_write_register(value, idx, CCI_PMU_CNTR);
+}
+
+static int cci_pmu_init(struct arm_pmu *cci_pmu, struct platform_device *pdev)
+{
+	*cci_pmu = (struct arm_pmu){
+		.name             = PMU_NAME,
+		.max_period       = (1LLU << 32) - 1,
+		.get_hw_events    = pmu_get_hw_events,
+		.get_event_idx    = pmu_get_event_idx,
+		.map_event        = pmu_map_event,
+		.request_irq      = pmu_request_irq,
+		.handle_irq       = pmu_handle_irq,
+		.free_irq         = pmu_free_irq,
+		.enable           = pmu_enable_event,
+		.disable          = pmu_disable_event,
+		.start            = pmu_start,
+		.stop             = pmu_stop,
+		.read_counter     = pmu_read_counter,
+		.write_counter    = pmu_write_counter,
+	};
+
+	cci_pmu->plat_device = pdev;
+	cci_pmu->num_events = pmu_get_max_counters();
+
+	return armpmu_register(cci_pmu, -1);
+}
+
+static const struct of_device_id arm_cci_pmu_matches[] = {
+	{
+		.compatible = "arm,cci-400-pmu,rev0",
+		.data = &port_event_range[CCI_REV_R0]
+	},
+	{
+		.compatible = "arm,cci-400-pmu,rev1",
+		.data = &port_event_range[CCI_REV_R1]
+	},
+	{
+		.compatible = "arm,cci-400-pmu",
+	},
+	{},
+};
+
+static int cci_pmu_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id;
+	struct resource *res;
+	struct device_node *node = pdev->dev.of_node;
+	int i, ret, irq;
+
+	pmu = devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_warn(&pdev->dev, "Failed to get mem resource\n");
+		ret = -EINVAL;
+		goto memalloc_err;
+	};
+
+	pmu->base = devm_ioremap_resource(&pdev->dev, res);
+	if (!pmu->base) {
+		dev_warn(&pdev->dev, "Failed to ioremap\n");
+		ret = -ENOMEM;
+		goto memalloc_err;
+	}
+
+	/*
+	 * CCI PMU has 5 overflow lines - one per counter; but all may not be
+	 * available as interrupts
+	 */
+	pmu->nr_irqs = 0;
+	for (i = 0; i < CCI_PMU_MAX_HW_EVENTS; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			break;
+
+		if (is_duplicate_irq(irq, pmu->irqs, pmu->nr_irqs)) {
+			dev_warn(&pdev->dev, "Skipping duplicate irq: %d\n", irq);
+			continue;
+		}
+
+		pmu->irqs[pmu->nr_irqs++] = irq;
+	}
+
+	/*
+	 * Based on CCI PMU revision from DT choose the appropriate port event
+	 * ranges for validation
+	 */
+	if (node && (of_id = of_match_node(arm_cci_pmu_matches, node)))
+		pmu->port_ranges = (struct pmu_port_event_ranges *)of_id->data;
+
+	/*
+	 * If no revision was specified in the DT, then try looking at supported
+	 * revs using peripheral id registers
+	 */
+	if (!pmu->port_ranges)
+		pmu->port_ranges = port_range_by_rev();
+
+	if (!pmu->port_ranges) {
+		dev_warn(&pdev->dev, "CCI PMU version not supported\n");
+		ret = -EINVAL;
+		goto memalloc_err;
+	}
+
+	pmu->cci_pmu = devm_kzalloc(&pdev->dev, sizeof(*(pmu->cci_pmu)), GFP_KERNEL);
+	if (!pmu->cci_pmu) {
+		ret = -ENOMEM;
+		goto memalloc_err;
+	}
+
+	pmu->hw_events.events = pmu->events;
+	pmu->hw_events.used_mask = pmu->used_mask;
+	raw_spin_lock_init(&pmu->hw_events.pmu_lock);
+
+	ret = cci_pmu_init(pmu->cci_pmu, pdev);
+	if (ret)
+		goto pmuinit_err;
+
+	return 0;
+
+pmuinit_err:
+	kfree(pmu->cci_pmu);
+memalloc_err:
+	kfree(pmu);
+	return ret;
+}
+
+static int cci_platform_probe(struct platform_device *pdev)
+{
+	if (!cci_probed())
+		return -ENODEV;
+
+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+}
+
+#endif /* CONFIG_HW_PERF_EVENTS */
+
 struct cpu_port {
 	u64 mpidr;
 	u32 port;
@@ -516,6 +1121,42 @@ static int __init cci_init(void)
 	return cci_init_status;
 }
 
+#ifdef CONFIG_HW_PERF_EVENTS
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
+#else
+
+static int __init cci_platform_init(void)
+{
+	return 0;
+}
+
+#endif
 /*
  * To sort out early init calls ordering a helper function is provided to
  * check if the CCI driver has beed initialized. Function check if the driver
@@ -529,5 +1170,6 @@ bool __init cci_probed(void)
 EXPORT_SYMBOL_GPL(cci_probed);
 
 early_initcall(cci_init);
+core_initcall(cci_platform_init);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ARM CCI support");
-- 
1.7.10.4
