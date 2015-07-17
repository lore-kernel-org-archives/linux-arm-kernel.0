From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Fri, 17 Jul 2015 11:24:59 -0500
Subject: [PATCH V5 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup sources
In-Reply-To: <1437150300-8134-1-git-send-email-shenwei.wang@freescale.com>
References: <1437150300-8134-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1437150300-8134-2-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IMX7D contains a new version of GPC IP block (GPCv2). It has two
major functions: power management and wakeup source management.
This patch adds a new irqchip driver to manage the interrupt wakeup
sources on IMX7D.
When the system is in WFI (wait for interrupt) mode, this GPC block
will be the first block on the platform to be activated and signaled.
Under normal wait mode during cpu idle, the system can be woke up
by any enabled interrupts. Under standby or suspend mode, the system
can only be woke up by the pre-defined wakeup sources.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 drivers/irqchip/Kconfig         |   7 +
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-imx-gpcv2.c | 311 ++++++++++++++++++++++++++++++++++++++++
 include/soc/imx/gpcv2.h         | 137 ++++++++++++++++++
 4 files changed, 456 insertions(+)
 create mode 100644 drivers/irqchip/irq-imx-gpcv2.c
 create mode 100644 include/soc/imx/gpcv2.h

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
index 0000000..ab64e94
--- /dev/null
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -0,0 +1,311 @@
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
+#include "irqchip.h"
+
+#include <soc/imx/gpcv2.h>
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
+	     data = data->parent_data) {
+		if (!data->domain)
+			continue;
+
+		if (!strcmp(data->domain->name, "GPCv2"))
+			return data->chip_data;
+	}
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
+static int __init imx_gpcv2_irqchip_init(struct device_node *node,
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
+	/* Mask the wakeup sources in M/F power domain */
+	cd->mfmix_mask[0] = 0x54010000;
+	cd->mfmix_mask[1] = 0xc00;
+	cd->mfmix_mask[2] = 0x0;
+	cd->mfmix_mask[3] = 0x400010;
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
+IRQCHIP_DECLARE(imx_gpcv2, "fsl,imx7d-gpc", imx_gpcv2_irqchip_init);
+
+
diff --git a/include/soc/imx/gpcv2.h b/include/soc/imx/gpcv2.h
new file mode 100644
index 0000000..aec862cd
--- /dev/null
+++ b/include/soc/imx/gpcv2.h
@@ -0,0 +1,137 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __SOC_IMX_GPCV2_H__
+#define __SOC_IMX_GPCV2_H__
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
+
+	void (*suspend_fn_in_ocram)(void __iomem *ocram_vbase);
+	void __iomem *ocram_vbase;
+};
+
+void ca7_cpu_resume(void);
+void imx7_suspend(void __iomem *ocram_vbase);
+
+#endif  /* __SOC_IMX_GPCV2_H__ */
-- 
2.5.0.rc2
