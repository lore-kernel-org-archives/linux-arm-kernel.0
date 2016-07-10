From: vw@iommu.org (Wan Zongshun)
Date: Sun, 10 Jul 2016 15:27:22 +0800
Subject: [PATCH v2 02/10] irqchip: add irqchip driver for nuc900
In-Reply-To: <1468135649-19980-1-git-send-email-vw@iommu.org>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
Message-ID: <1468135649-19980-3-git-send-email-vw@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add irqchip driver support for nuc900 plat,
current this driver only supports nuc970 SoC.

Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
---
 arch/arm/mach-w90x900/include/mach/irqs.h |   5 +
 drivers/irqchip/Makefile                  |   1 +
 drivers/irqchip/irq-nuc900.c              | 150 ++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 drivers/irqchip/irq-nuc900.c

diff --git a/arch/arm/mach-w90x900/include/mach/irqs.h b/arch/arm/mach-w90x900/include/mach/irqs.h
index 9d5cba3..3b035c6 100644
--- a/arch/arm/mach-w90x900/include/mach/irqs.h
+++ b/arch/arm/mach-w90x900/include/mach/irqs.h
@@ -59,7 +59,12 @@
 #define IRQ_KPI		W90X900_IRQ(29)
 #define IRQ_P2SGROUP	W90X900_IRQ(30)
 #define IRQ_ADC		W90X900_IRQ(31)
+
+#if !defined(CONFIG_SOC_NUC900)
 #define NR_IRQS		(IRQ_ADC+1)
+#else
+#define NR_IRQS		62
+#endif
 
 /*for irq group*/
 
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 38853a1..9ccd5af8a 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -69,3 +69,4 @@ obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
 obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
+obj-$(CONFIG_SOC_NUC970)		+= irq-nuc900.o
diff --git a/drivers/irqchip/irq-nuc900.c b/drivers/irqchip/irq-nuc900.c
new file mode 100644
index 0000000..c4b2e39
--- /dev/null
+++ b/drivers/irqchip/irq-nuc900.c
@@ -0,0 +1,150 @@
+/*
+ * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include <asm/exception.h>
+#include <asm/hardirq.h>
+
+#define	REG_AIC_SCR1	0x00
+#define	REG_AIC_SCR2	0x04
+#define	REG_AIC_SCR3	0x08
+#define	REG_AIC_SCR4	0x0C
+#define	REG_AIC_SCR5	0x10
+#define	REG_AIC_SCR6	0x14
+#define	REG_AIC_SCR7	0x18
+#define	REG_AIC_SCR8	0x1C
+#define	REG_AIC_SCR9	0x20
+#define	REG_AIC_SCR10	0x24
+#define	REG_AIC_SCR11	0x28
+#define	REG_AIC_SCR12	0x2C
+#define	REG_AIC_SCR13	0x30
+#define	REG_AIC_SCR14	0x34
+#define	REG_AIC_SCR15	0x38
+#define	REG_AIC_IRSR	0x100
+#define	REG_AIC_IRSRH	0x104
+#define	REG_AIC_IASR	0x108
+#define	REG_AIC_IASRH	0x10C
+#define	REG_AIC_ISR	0x110
+#define	REG_AIC_ISRH	0x114
+#define	REG_AIC_IPER	0x118
+#define	REG_AIC_ISNR	0x120
+#define	REG_AIC_OISR	0x124
+#define	REG_AIC_IMR	0x128
+#define	REG_AIC_IMRH	0x12C
+#define	REG_AIC_MECR	0x130
+#define	REG_AIC_MECRH	0x134
+#define	REG_AIC_MDCR	0x138
+#define	REG_AIC_MDCRH	0x13C
+#define	REG_AIC_SSCR	0x140
+#define	REG_AIC_SSCRH	0x144
+#define	REG_AIC_SCCR	0x148
+#define	REG_AIC_SCCRH	0x14C
+#define	REG_AIC_EOSCR	0x150
+
+static void __iomem *aic_base;
+static struct irq_domain *aic_domain;
+
+static void nuc900_irq_mask(struct irq_data *d)
+{
+	if (d->irq < 32)
+		writel(1 << (d->irq), aic_base + REG_AIC_MDCR);
+	else
+		writel(1 << (d->irq - 32), aic_base + REG_AIC_MDCRH);
+}
+
+static void nuc900_irq_ack(struct irq_data *d)
+{
+	writel(0x01, aic_base + REG_AIC_EOSCR);
+}
+
+static void nuc900_irq_unmask(struct irq_data *d)
+{
+	if (d->irq < 32)
+		writel(1 << (d->irq), aic_base + REG_AIC_MECR);
+	else
+		writel(1 << (d->irq - 32), aic_base + REG_AIC_MECRH);
+}
+
+static struct irq_chip nuc900_irq_chip = {
+	.irq_ack	= nuc900_irq_ack,
+	.irq_mask	= nuc900_irq_mask,
+	.irq_unmask	= nuc900_irq_unmask,
+};
+
+void __exception_irq_entry aic_handle_irq(struct pt_regs *regs)
+{
+	u32 hwirq;
+
+	hwirq = readl(aic_base + REG_AIC_IPER);
+	hwirq = readl(aic_base + REG_AIC_ISNR);
+	if (!hwirq)
+		writel(0x01, aic_base + REG_AIC_EOSCR);
+
+	handle_IRQ((irq_find_mapping(aic_domain, hwirq)), regs);
+}
+
+static int aic_irq_domain_map(struct irq_domain *d, unsigned int virq,
+			      irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(virq, &nuc900_irq_chip, handle_level_irq);
+	irq_clear_status_flags(virq, IRQ_NOREQUEST);
+
+	return 0;
+}
+
+static struct irq_domain_ops aic_irq_domain_ops = {
+	.map = aic_irq_domain_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int __init aic_of_init(struct device_node *node,
+			      struct device_node *parent)
+{
+	int ret;
+
+	aic_base = of_iomap(node, 0);
+	if (!aic_base) {
+		ret = -ENOMEM;
+		pr_err("%s: unable to map registers\n", node->full_name);
+		goto err_iomap;
+	}
+
+	writel(0xFFFFFFFC, aic_base + REG_AIC_MDCR);
+	writel(0xFFFFFFFF, aic_base + REG_AIC_MDCRH);
+
+	aic_domain = irq_domain_add_linear(node, NR_IRQS,
+					   &aic_irq_domain_ops, NULL);
+
+	if (!aic_domain) {
+		ret = -ENOMEM;
+		pr_err("%s: unable to create IRQ domain\n", node->full_name);
+		goto err_aic_domain;
+	}
+
+	set_handle_irq(aic_handle_irq);
+	return 0;
+
+err_aic_domain:
+	iounmap(aic_base);
+err_iomap:
+	return ret;
+}
+
+IRQCHIP_DECLARE(nuc900, "nuvoton,nuc900-aic", aic_of_init);
-- 
2.7.4
