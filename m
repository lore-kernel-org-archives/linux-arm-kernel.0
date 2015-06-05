From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Fri, 5 Jun 2015 14:29:25 -0500
Subject: [PATCH V2 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup sources
Message-ID: <1433532565-11249-1-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IMX7D contains a new version of GPC IP block (GPCv2). It has two
major functions: power management and wakeup source management.
This patch adds a new irqchip driver to manage the interrupt wakeup
sources and power management on IMX7D.
When the system is in WFI (wait for interrupt) mode, this GPC block
will be the first block on the platform to be activated and signaled.
Under normal wait mode during cpu idle, the system can be woke up
by any enabled interrupts. Under standby or suspend mode, the system
can only be woke up by the pre-defined wakeup sources.

GPCv2 also provides low power mode control for Cortex-A7 and Cortex-M4
domains. And it can support WAIT, STOP, and DSM(Deep Sleep Mode) modes.
After configuring the GPCv2 module, the platform can enter into a
selected mode either automatically triggered by ARM WFI instruction or
manually by software.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
Change Log:
Patch V2:
	Added the basic driver APIs for power management.
	Supported the STANDBY power mode.
Patch V1:
	Implemented the driver for IRQ wakeup sources.

 arch/arm/mach-imx/Kconfig       |   1 +
 drivers/irqchip/Kconfig         |   7 +
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-imx-gpcv2.c | 749 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 758 insertions(+)
 create mode 100644 drivers/irqchip/irq-imx-gpcv2.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 5ccc9ea..4269c1e 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -552,6 +552,7 @@ config SOC_IMX7D
 	bool "i.MX7 Dual support"
 	select PINCTRL_IMX7D
 	select ARM_GIC
+	select IMX_GPCV2
 	select HAVE_IMX_ANATOP
 	select HAVE_IMX_MMDC
 	help
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 6de62a9..6a68cd5 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -158,3 +158,10 @@ config KEYSTONE_IRQ
 config MIPS_GIC
 	bool
 	select MIPS_CM
+
+config IMX_GPCV2
+	bool
+	select IRQ_DOMAIN
+	help
+	  Enables the wakeup IRQs for IMX platforms with GPCv2 block
+
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index dda4927..e6f4495 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -47,3 +47,4 @@ obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
 obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o
 obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
+obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
new file mode 100644
index 0000000..dd8d910
--- /dev/null
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -0,0 +1,749 @@
+
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+#include <linux/syscore_ops.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include "irqchip.h"
+
+#include <linux/suspend.h>
+#include <asm/suspend.h>
+
+
+#define IMR_NUM			4
+#define GPC_MAX_IRQS            (IMR_NUM * 32)
+
+#define GPC_LPCR_A7_BSC		0x0
+#define GPC_LPCR_M4		0x8
+
+#define GPC_IMR1_CORE0		0x30
+#define GPC_IMR1_CORE1		0x40
+
+#define GPC_PGC_CPU_MAPPING	0xec
+#define GPC_PGC_SCU_TIMING	0x890
+
+#define BM_LPCR_A7_BSC_IRQ_SRC_A7_WAKEUP	0x70000000
+#define BM_LPCR_M4_MASK_DSM_TRIGGER		0x80000000
+
+
+#define GPC_LPCR_A7_AD		0x4
+#define GPC_SLPCR		0x14
+#define GPC_PGC_ACK_SEL_A7	0x24
+
+#define GPC_SLOT0_CFG		0xb0
+
+#define GPC_PGC_C0		0x800
+#define GPC_PGC_SCU_TIMING	0x890
+#define GPC_PGC_C1		0x840
+#define GPC_PGC_SCU		0x880
+#define GPC_PGC_FM		0xa00
+
+#define BM_LPCR_A7_BSC_CPU_CLK_ON_LPM		0x4000
+#define BM_LPCR_A7_BSC_LPM1			0xc
+#define BM_LPCR_A7_BSC_LPM0			0x3
+#define BP_LPCR_A7_BSC_LPM1			2
+#define BP_LPCR_A7_BSC_LPM0			0
+
+#define BM_SLPCR_EN_DSM				0x80000000
+#define BM_SLPCR_RBC_EN				0x40000000
+#define BM_SLPCR_VSTBY				0x4
+#define BM_SLPCR_SBYOS				0x2
+#define BM_SLPCR_BYPASS_PMIC_READY		0x1
+
+
+#define BM_LPCR_A7_AD_L2PGE			0x10000
+#define BM_LPCR_A7_AD_EN_C1_PUP			0x800
+#define BM_LPCR_A7_AD_EN_C1_IRQ_PUP		0x400
+#define BM_LPCR_A7_AD_EN_C0_PUP			0x200
+#define BM_LPCR_A7_AD_EN_C0_IRQ_PUP		0x100
+#define BM_LPCR_A7_AD_EN_PLAT_PDN		0x10
+#define BM_LPCR_A7_AD_EN_C1_PDN			0x8
+#define BM_LPCR_A7_AD_EN_C1_WFI_PDN		0x4
+#define BM_LPCR_A7_AD_EN_C0_PDN			0x2
+#define BM_LPCR_A7_AD_EN_C0_WFI_PDN		0x1
+
+#define BM_GPC_PGC_ACK_SEL_A7_DUMMY_PUP_ACK	0x80000000
+#define BM_GPC_PGC_ACK_SEL_A7_DUMMY_PDN_ACK	0x8000
+
+#define MAX_SLOT_NUMBER				10
+#define A7_LPM_WAIT				0x5
+#define A7_LPM_STOP				0xa
+
+
+#define REG_SET		0x4
+#define REG_CLR		0x8
+
+#define ANADIG_ARM_PLL		0x60
+#define ANADIG_DDR_PLL		0x70
+#define ANADIG_SYS_PLL		0xb0
+#define ANADIG_ENET_PLL		0xe0
+#define ANADIG_AUDIO_PLL	0xf0
+#define ANADIG_VIDEO_PLL	0x130
+
+
+
+enum gpcv2_mode {
+	WAIT_CLOCKED,		/* wfi only */
+	WAIT_UNCLOCKED,		/* WAIT */
+	WAIT_UNCLOCKED_POWER_OFF,	/* WAIT + SRPG */
+	STOP_POWER_ON,		/* just STOP */
+	STOP_POWER_OFF,		/* STOP + SRPG */
+};
+
+enum gpcv2_slot {
+	CORE0_A7,
+	CORE1_A7,
+	SCU_A7,
+	FAST_MEGA_MIX,
+	MIPI_PHY,
+	PCIE_PHY,
+	USB_OTG1_PHY,
+	USB_OTG2_PHY,
+	USB_HSIC_PHY,
+	CORE0_M4,
+};
+
+struct imx_irq_gpcv2 {
+	spinlock_t lock;
+	void __iomem *gpc_base;
+	struct regmap *anatop;
+	struct regmap *imx_src;
+	u32 wakeup_sources[IMR_NUM];
+	u32 enabled_irqs[IMR_NUM];
+	u32 mfmix_mask[IMR_NUM];
+	u32 wakeupmix_mask[IMR_NUM];
+	u32 lpsrmix_mask[IMR_NUM];
+	u32 cpu2wakeup;
+	void (*lpm_env_setup)(struct imx_irq_gpcv2 *);
+	void (*lpm_env_clean)(struct imx_irq_gpcv2 *);
+	void (*lpm_cpu_power_gate)(struct imx_irq_gpcv2 *, u32, bool);
+	void (*lpm_plat_power_gate)(struct imx_irq_gpcv2 *, bool);
+	void (*set_mode)(struct imx_irq_gpcv2 *, enum gpcv2_mode mode);
+	void (*standby)(struct imx_irq_gpcv2 *);
+	void (*suspend)(struct imx_irq_gpcv2 *);
+	void (*set_slot)(struct imx_irq_gpcv2 *cd, u32 index,
+			enum gpcv2_slot m_core, bool mode, bool ack);
+	void (*clear_slots)(struct imx_irq_gpcv2 *);
+	void (*lpm_enable_core)(struct imx_irq_gpcv2 *,
+			bool enable, u32 offset);
+
+};
+
+static struct imx_irq_gpcv2 *gpcv2_get_chip_data(void)
+{
+	struct irq_data *data;
+	int virq;
+
+	/* Since GPCv2 is the default IRQ domain, its private data can
+	 * be gotten from any irq descriptor. Here we use interrupt #19
+	 * which is for snvs-rtc.
+	 */
+	virq = irq_find_mapping(0, 19);
+
+	for (data = irq_get_irq_data(virq); data;
+	     data = data->parent_data)
+		if (!strcmp(data->domain->name, "GPCv2"))
+			return data->chip_data;
+
+	return 0;
+}
+
+static int gpcv2_wakeup_source_save(void)
+{
+	struct imx_irq_gpcv2 *cd;
+	void __iomem *reg;
+	int i;
+
+	cd = gpcv2_get_chip_data();
+	if (!cd)
+		return 0;
+
+	for (i = 0; i < IMR_NUM; i++) {
+		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
+		cd->enabled_irqs[i] = readl_relaxed(reg);
+		writel_relaxed(cd->wakeup_sources[i], reg);
+	}
+
+	pr_devel("%s ----\r\n", __func__);
+	pr_devel("Enabled IRQ:\t %08X %08X %08X %08X\r\n",
+			cd->enabled_irqs[0],
+			cd->enabled_irqs[1],
+			cd->enabled_irqs[2],
+			cd->enabled_irqs[3]);
+	pr_devel("Wakeup Sources:\t %08X %08X %08X %08X\r\n",
+			cd->wakeup_sources[0],
+			cd->wakeup_sources[1],
+			cd->wakeup_sources[2],
+			cd->wakeup_sources[3]);
+	return 0;
+}
+
+static void gpcv2_wakeup_source_restore(void)
+{
+	struct imx_irq_gpcv2 *cd;
+	void __iomem *reg;
+	int i;
+
+	cd = gpcv2_get_chip_data();
+	if (!cd)
+		return;
+
+	for (i = 0; i < IMR_NUM; i++) {
+		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
+		writel_relaxed(cd->enabled_irqs[i], reg);
+		cd->wakeup_sources[i] = ~0;
+	}
+
+	pr_devel("%s ----\r\n", __func__);
+	pr_devel("Enabled IRQ:\t %08X %08X %08X %08X\r\n",
+			cd->enabled_irqs[0],
+			cd->enabled_irqs[1],
+			cd->enabled_irqs[2],
+			cd->enabled_irqs[3]);
+	pr_devel("Wakeup Sources:\t %08X %08X %08X %08X\r\n",
+			cd->wakeup_sources[0],
+			cd->wakeup_sources[1],
+			cd->wakeup_sources[2],
+			cd->wakeup_sources[3]);
+}
+
+static struct syscore_ops imx_gpcv2_syscore_ops = {
+	.suspend	= gpcv2_wakeup_source_save,
+	.resume		= gpcv2_wakeup_source_restore,
+};
+
+static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	unsigned int idx = d->hwirq / 32;
+	struct imx_irq_gpcv2 *cd = d->chip_data;
+	u32 mask, val;
+	unsigned long flags;
+	void __iomem *reg;
+
+	spin_lock_irqsave(&cd->lock, flags);
+	reg = cd->gpc_base + cd->cpu2wakeup + idx * 4;
+	mask = 1 << d->hwirq % 32;
+	val = cd->wakeup_sources[idx];
+
+	cd->wakeup_sources[idx] = on ? (val & ~mask) : (val | mask);
+	spin_unlock_irqrestore(&cd->lock, flags);
+
+	/*
+	 * Do *not* call into the parent, as the GIC doesn't have any
+	 * wake-up facility...
+	 */
+
+	return 0;
+}
+
+
+static void imx_gpcv2_irq_unmask(struct irq_data *d)
+{
+	void __iomem *reg;
+	struct imx_irq_gpcv2 *cd = d->chip_data;
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cd->lock, flags);
+	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
+	val = readl_relaxed(reg);
+	val &= ~(1 << d->hwirq % 32);
+	writel_relaxed(val, reg);
+	irq_chip_unmask_parent(d);
+	spin_unlock_irqrestore(&cd->lock, flags);
+}
+
+static void imx_gpcv2_irq_mask(struct irq_data *d)
+{
+	void __iomem *reg;
+	struct imx_irq_gpcv2 *cd = d->chip_data;
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cd->lock, flags);
+	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
+	val = readl_relaxed(reg);
+	val |= 1 << (d->hwirq % 32);
+	writel_relaxed(val, reg);
+
+	irq_chip_mask_parent(d);
+	spin_unlock_irqrestore(&cd->lock, flags);
+}
+
+
+static struct irq_chip imx_gpcv2_irq_chip = {
+	.name			= "GPCv2",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_mask		= imx_gpcv2_irq_mask,
+	.irq_unmask		= imx_gpcv2_irq_unmask,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_wake		= imx_gpcv2_irq_set_wake,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+#endif
+};
+
+static int imx_gpcv2_domain_xlate(struct irq_domain *domain,
+				struct device_node *controller,
+				const u32 *intspec,
+				unsigned int intsize,
+				unsigned long *out_hwirq,
+				unsigned int *out_type)
+{
+	if (domain->of_node != controller)
+		return -EINVAL;	/* Shouldn't happen, really... */
+	if (intsize != 3)
+		return -EINVAL;	/* Not GIC compliant */
+	if (intspec[0] != 0)
+		return -EINVAL;	/* No PPI should point to this domain */
+
+	*out_hwirq = intspec[1];
+	*out_type = intspec[2];
+	return 0;
+}
+
+static int imx_gpcv2_domain_alloc(struct irq_domain *domain,
+				  unsigned int irq,
+				  unsigned int nr_irqs, void *data)
+{
+	struct of_phandle_args *args = data;
+	struct of_phandle_args parent_args;
+	irq_hw_number_t hwirq;
+	int i;
+
+	if (args->args_count != 3)
+		return -EINVAL;	/* Not GIC compliant */
+	if (args->args[0] != 0)
+		return -EINVAL;	/* No PPI should point to this domain */
+
+	hwirq = args->args[1];
+	if (hwirq >= GPC_MAX_IRQS)
+		return -EINVAL;	/* Can't deal with this */
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_hwirq_and_chip(domain, irq + i, hwirq + i,
+				&imx_gpcv2_irq_chip, domain->host_data);
+	}
+	parent_args = *args;
+	parent_args.np = domain->parent->of_node;
+	return irq_domain_alloc_irqs_parent(domain, irq, nr_irqs, &parent_args);
+}
+
+static struct irq_domain_ops imx_gpcv2_irq_domain_ops = {
+	.xlate	= imx_gpcv2_domain_xlate,
+	.alloc	= imx_gpcv2_domain_alloc,
+	.free	= irq_domain_free_irqs_common,
+};
+
+
+
+static int __init imx_gpcv2_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	struct irq_domain *parent_domain, *domain;
+	int i, val;
+	struct imx_irq_gpcv2 *cd;
+
+	if (!parent) {
+		pr_err("%s: no parent, giving up\n", node->full_name);
+		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%s: unable to obtain parent domain\n", node->full_name);
+		return -ENXIO;
+	}
+
+	cd = kzalloc(sizeof(struct imx_irq_gpcv2), GFP_KERNEL);
+	BUG_ON(!cd);
+
+	cd->gpc_base = of_iomap(node, 0);
+	if (!cd->gpc_base) {
+		pr_err("fsl-gpcv2: unable to map gpc registers\n");
+		kzfree(cd);
+		return -ENOMEM;
+	}
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, GPC_MAX_IRQS,
+				node, &imx_gpcv2_irq_domain_ops, cd);
+	if (!domain) {
+		iounmap(cd->gpc_base);
+		kzfree(cd);
+		return -ENOMEM;
+	}
+	irq_set_default_host(domain);
+
+	/* Initially mask all interrupts */
+	for (i = 0; i < IMR_NUM; i++) {
+		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE0 + i * 4);
+		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE1 + i * 4);
+		cd->wakeup_sources[i] = ~0;
+	}
+
+	/* Let CORE0 as the default CPU to wake up by GPC */
+	cd->cpu2wakeup = GPC_IMR1_CORE0;
+
+	/*
+	 * Due to hardware design requirement, need to make sure GPR
+	 * interrupt(#32) is unmasked during RUN mode to avoid entering
+	 * DSM by mistake.
+	 */
+	writel_relaxed(~0x1, cd->gpc_base + cd->cpu2wakeup);
+
+	/* Read supported wakeup source in M/F power domain */
+	of_property_read_u32_index(node, "fsl,mf-mix-wakeup-irq", 0,
+			&cd->mfmix_mask[0]);
+	of_property_read_u32_index(node, "fsl,mf-mix-wakeup-irq", 1,
+			&cd->mfmix_mask[1]);
+	of_property_read_u32_index(node, "fsl,mf-mix-wakeup-irq", 2,
+			&cd->mfmix_mask[2]);
+	of_property_read_u32_index(node, "fsl,mf-mix-wakeup-irq", 3,
+			&cd->mfmix_mask[3]);
+
+	/* only external IRQs to wake up LPM and core 0/1 */
+	val = readl_relaxed(cd->gpc_base + GPC_LPCR_A7_BSC);
+	val |= BM_LPCR_A7_BSC_IRQ_SRC_A7_WAKEUP;
+	writel_relaxed(val, cd->gpc_base + GPC_LPCR_A7_BSC);
+	/* mask m4 dsm trigger */
+	writel_relaxed(readl_relaxed(cd->gpc_base + GPC_LPCR_M4) |
+		BM_LPCR_M4_MASK_DSM_TRIGGER, cd->gpc_base + GPC_LPCR_M4);
+	/* set mega/fast mix in A7 domain */
+	writel_relaxed(0x1, cd->gpc_base + GPC_PGC_CPU_MAPPING);
+	/* set SCU timing */
+	writel_relaxed((0x59 << 10) | 0x5B | (0x51 << 20),
+		cd->gpc_base + GPC_PGC_SCU_TIMING);
+
+	register_syscore_ops(&imx_gpcv2_syscore_ops);
+
+	return 0;
+}
+
+
+IRQCHIP_DECLARE(imx_gpcv2, "fsl,imx7d-gpc", imx_gpcv2_init);
+
+
+/* The following are the driver APIs for GPCv2 power management */
+
+
+static void imx_gpcv2_lpm_clear_slots(struct imx_irq_gpcv2 *cd)
+{
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cd->lock, flags);
+	for (i = 0; i < MAX_SLOT_NUMBER; i++)
+		writel_relaxed(0x0, cd->gpc_base + GPC_SLOT0_CFG + i * 0x4);
+	writel_relaxed(BM_GPC_PGC_ACK_SEL_A7_DUMMY_PUP_ACK |
+		BM_GPC_PGC_ACK_SEL_A7_DUMMY_PDN_ACK,
+		cd->gpc_base + GPC_PGC_ACK_SEL_A7);
+
+	spin_unlock_irqrestore(&cd->lock, flags);
+}
+
+static void imx_gpcv2_lpm_enable_core(struct imx_irq_gpcv2 *cd,
+			bool enable, u32 offset)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cd->lock, flags);
+	writel_relaxed(enable, cd->gpc_base + offset);
+	spin_unlock_irqrestore(&cd->lock, flags);
+}
+
+static void imx_gpcv2_lpm_slot_setup(struct imx_irq_gpcv2 *cd,
+		u32 index, enum gpcv2_slot m_core, bool mode, bool ack)
+{
+	u32 val;
+	unsigned long flags;
+
+	if (index >= MAX_SLOT_NUMBER)
+		pr_err("Invalid slot index!\n");
+
+	spin_lock_irqsave(&cd->lock, flags);
+	/* set slot */
+	writel_relaxed((mode + 1) << (m_core * 2), cd->gpc_base +
+		GPC_SLOT0_CFG + index * 4);
+
+	if (ack) {
+		/* set ack */
+		val = readl_relaxed(cd->gpc_base + GPC_PGC_ACK_SEL_A7);
+		/* clear dummy ack */
+		val &= ~(1 << (15 + (mode ? 16 : 0)));
+		val |= 1 << (m_core + (mode ? 16 : 0));
+		writel_relaxed(val, cd->gpc_base + GPC_PGC_ACK_SEL_A7);
+	}
+
+	spin_unlock_irqrestore(&cd->lock, flags);
+}
+
+static void imx_gpcv2_lpm_env_setup(struct imx_irq_gpcv2 *cd)
+{
+	/* PLL and PFDs overwrite set */
+	regmap_write(cd->anatop, ANADIG_ARM_PLL + REG_SET, 1 << 20);
+	regmap_write(cd->anatop, ANADIG_DDR_PLL + REG_SET, 1 << 19);
+	regmap_write(cd->anatop, ANADIG_SYS_PLL + REG_SET, 0x1ff << 17);
+	regmap_write(cd->anatop, ANADIG_ENET_PLL + REG_SET, 1 << 13);
+	regmap_write(cd->anatop, ANADIG_AUDIO_PLL + REG_SET, 1 << 24);
+	regmap_write(cd->anatop, ANADIG_VIDEO_PLL + REG_SET, 1 << 24);
+}
+
+static void imx_gpcv2_lpm_env_clean(struct imx_irq_gpcv2 *cd)
+{
+	/* PLL and PFDs overwrite clear */
+	regmap_write(cd->anatop, ANADIG_ARM_PLL + REG_CLR, 1 << 20);
+	regmap_write(cd->anatop, ANADIG_DDR_PLL + REG_CLR, 1 << 19);
+	regmap_write(cd->anatop, ANADIG_SYS_PLL + REG_CLR, 0x1ff << 17);
+	regmap_write(cd->anatop, ANADIG_ENET_PLL + REG_CLR, 1 << 13);
+	regmap_write(cd->anatop, ANADIG_AUDIO_PLL + REG_CLR, 1 << 24);
+	regmap_write(cd->anatop, ANADIG_VIDEO_PLL + REG_CLR, 1 << 24);
+}
+
+static void imx_gpcv2_lpm_set_mode(struct imx_irq_gpcv2 *cd, enum gpcv2_mode mode)
+{
+
+	unsigned long flags;
+	u32 val1, val2;
+
+	spin_lock_irqsave(&cd->lock, flags);
+
+	val1 = readl_relaxed(cd->gpc_base + GPC_LPCR_A7_BSC);
+	val2 = readl_relaxed(cd->gpc_base + GPC_SLPCR);
+
+	/* all cores' LPM settings must be same */
+	val1 &= ~(BM_LPCR_A7_BSC_LPM0 | BM_LPCR_A7_BSC_LPM1);
+
+	val1 |= BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
+
+	val2 &= ~(BM_SLPCR_EN_DSM | BM_SLPCR_VSTBY | BM_SLPCR_RBC_EN |
+		BM_SLPCR_SBYOS | BM_SLPCR_BYPASS_PMIC_READY);
+	/*
+	 * GPCv2: When improper low-power sequence is used,
+	 * the SoC enters low power mode before the ARM core executes WFI.
+	 *
+	 * Software workaround:
+	 * 1) Software should trigger IRQ #32 (IOMUX) to be always pending
+	 *    by setting IOMUX_GPR1_IRQ.
+	 * 2) Software should then unmask IRQ #32 in GPC before setting GPC
+	 *    Low-Power mode.
+	 * 3) Software should mask IRQ #32 right after GPC Low-Power mode
+	 *    is set.
+	 */
+	switch (mode) {
+	case WAIT_CLOCKED:
+		break;
+	case WAIT_UNCLOCKED:
+		val1 |= A7_LPM_WAIT << BP_LPCR_A7_BSC_LPM0;
+		val1 &= ~BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
+		break;
+	case STOP_POWER_ON:
+		val1 |= A7_LPM_STOP << BP_LPCR_A7_BSC_LPM0;
+		val1 &= ~BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
+		val2 |= BM_SLPCR_EN_DSM;
+		val2 |= BM_SLPCR_RBC_EN;
+		val2 |= BM_SLPCR_BYPASS_PMIC_READY;
+		break;
+	case STOP_POWER_OFF:
+		val1 |= A7_LPM_STOP << BP_LPCR_A7_BSC_LPM0;
+		val1 &= ~BM_LPCR_A7_BSC_CPU_CLK_ON_LPM;
+		val2 |= BM_SLPCR_EN_DSM;
+		val2 |= BM_SLPCR_RBC_EN;
+		val2 |= BM_SLPCR_SBYOS;
+		val2 |= BM_SLPCR_VSTBY;
+		val2 |= BM_SLPCR_BYPASS_PMIC_READY;
+		break;
+	default:
+		return;
+	}
+	writel_relaxed(val1, cd->gpc_base + GPC_LPCR_A7_BSC);
+	writel_relaxed(val2, cd->gpc_base + GPC_SLPCR);
+
+	spin_unlock_irqrestore(&cd->lock, flags);
+}
+
+
+static void imx_gpcv2_lpm_cpu_power_gate(struct imx_irq_gpcv2 *cd,
+				u32 cpu, bool pdn)
+{
+
+	unsigned long flags;
+	u32 val;
+	const u32 val_pdn[2] = {
+		BM_LPCR_A7_AD_EN_C0_PDN | BM_LPCR_A7_AD_EN_C0_PUP,
+		BM_LPCR_A7_AD_EN_C1_PDN | BM_LPCR_A7_AD_EN_C1_PUP,
+	};
+
+	spin_lock_irqsave(&cd->lock, flags);
+
+	val = readl_relaxed(cd->gpc_base + GPC_LPCR_A7_AD);
+	if (pdn)
+		val |= val_pdn[cpu];
+	else
+		val &= ~val_pdn[cpu];
+
+	writel_relaxed(val, cd->gpc_base + GPC_LPCR_A7_AD);
+	spin_unlock_irqrestore(&cd->lock, flags);
+}
+
+static void imx_lpm_plat_power_gate(struct imx_irq_gpcv2 *cd, bool pdn)
+{
+	unsigned long flags;
+	u32 val = readl_relaxed(cd->gpc_base + GPC_LPCR_A7_AD);
+
+	spin_lock_irqsave(&cd->lock, flags);
+	val &= ~(BM_LPCR_A7_AD_EN_PLAT_PDN | BM_LPCR_A7_AD_L2PGE);
+	if (pdn)
+		val |= BM_LPCR_A7_AD_EN_PLAT_PDN | BM_LPCR_A7_AD_L2PGE;
+
+	writel_relaxed(val, cd->gpc_base + GPC_LPCR_A7_AD);
+	spin_unlock_irqrestore(&cd->lock, flags);
+}
+
+static void imx_gpcv2_lpm_standby(struct imx_irq_gpcv2 *cd)
+{
+
+	cd->lpm_env_setup(cd);
+	cd->set_mode(cd, STOP_POWER_OFF);
+	/* cd->set_mode(cd, WAIT_UNCLOCKED);  */
+
+	pr_err("[GPCv2] %s %d\r\n", __func__, __LINE__);
+	/* Zzz ... */
+	cpu_do_idle();
+
+	cd->set_mode(cd, WAIT_CLOCKED);
+	cd->lpm_env_clean(cd);
+}
+
+static void imx_gpcv2_lpm_suspend(struct imx_irq_gpcv2 *cd)
+{
+
+	cd->lpm_env_setup(cd);
+	cd->set_mode(cd, STOP_POWER_OFF);
+
+	/* enable core0 power down/up with low power mode */
+	cd->lpm_cpu_power_gate(cd, 0, true);
+
+	/* enable plat power down with low power mode */
+	cd->lpm_plat_power_gate(cd, true);
+
+
+	/*
+	 * To avoid confuse, we use slot 0~4 for power down,
+	 * slot 5~9 for power up.
+	 *
+	 * Power down slot sequence:
+	 * Slot0 -> CORE0
+	 * Slot1 -> Mega/Fast MIX
+	 * Slot2 -> SCU
+	 *
+	 * Power up slot sequence:
+	 * Slot5 -> Mega/Fast MIX
+	 * Slot6 -> SCU
+	 * Slot7 -> CORE0
+	 */
+	cd->set_slot(cd, 0, CORE0_A7, false, false);
+	cd->set_slot(cd, 2, SCU_A7, false, true);
+
+	/* imx_gpcv2_mf_mix_off(); */
+
+	cd->set_slot(cd, 6, SCU_A7, true, false);
+	cd->set_slot(cd, 7, CORE0_A7, true, true);
+
+	/* enable core0, scu */
+	cd->lpm_enable_core(cd, true, GPC_PGC_C0);
+	cd->lpm_enable_core(cd, true, GPC_PGC_SCU);
+
+	/* Suspend to MEM has not been implemented yet */
+	/* cpu_suspend(cd, gpcv2_suspend_finish); */
+
+	cd->lpm_env_clean(cd);
+	cd->set_mode(cd, WAIT_CLOCKED);
+	cd->lpm_cpu_power_gate(cd, 0, false);
+	cd->lpm_plat_power_gate(cd, false);
+
+	cd->lpm_enable_core(cd, false, GPC_PGC_C0);
+	cd->lpm_enable_core(cd, false, GPC_PGC_SCU);
+	cd->lpm_enable_core(cd, false, GPC_PGC_FM);
+	cd->clear_slots(cd);
+}
+
+static int imx_gpcv2_pm_enter(suspend_state_t state)
+{
+	struct imx_irq_gpcv2 *cd;
+
+	cd = gpcv2_get_chip_data();
+	BUG_ON(!cd);
+
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		cd->standby(cd);
+		break;
+
+	case PM_SUSPEND_MEM:
+		cd->suspend(cd);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+static int imx_gpcv2_pm_valid(suspend_state_t state)
+{
+	/* So far the driver can only support STANDBY mode */
+	return state == PM_SUSPEND_STANDBY;
+
+	/* return state == PM_SUSPEND_MEM || state == PM_SUSPEND_STANDBY; */
+}
+
+static const struct platform_suspend_ops imx_gpcv2_pm_ops = {
+	.enter = imx_gpcv2_pm_enter,
+	.valid = imx_gpcv2_pm_valid,
+};
+
+
+static int __init imx_gpcv2_pm_init(void)
+{
+	struct imx_irq_gpcv2 *cd;
+
+	cd = gpcv2_get_chip_data();
+	BUG_ON(!cd);
+
+	cd->lpm_env_setup = imx_gpcv2_lpm_env_setup;
+	cd->lpm_env_clean = imx_gpcv2_lpm_env_clean;
+	cd->set_mode = imx_gpcv2_lpm_set_mode;
+	cd->standby = imx_gpcv2_lpm_standby;
+
+	cd->lpm_cpu_power_gate = imx_gpcv2_lpm_cpu_power_gate;
+	cd->lpm_plat_power_gate = imx_lpm_plat_power_gate;
+	cd->suspend = imx_gpcv2_lpm_suspend;
+	cd->set_slot = imx_gpcv2_lpm_slot_setup;
+
+	cd->clear_slots = imx_gpcv2_lpm_clear_slots;
+	cd->lpm_enable_core = imx_gpcv2_lpm_enable_core;
+
+
+	pr_err("[GPCv2] %s \r\n", __func__);
+	cd->anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
+	WARN_ON(!cd->anatop);
+	cd->imx_src = syscon_regmap_lookup_by_compatible("fsl,imx7d-src");
+	WARN_ON(!cd->imx_src);
+
+	suspend_set_ops(&imx_gpcv2_pm_ops);
+
+	return 0;
+}
+
+device_initcall(imx_gpcv2_pm_init);
+
--
1.9.1
