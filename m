From: zonque@gmail.com (Daniel Mack)
Date: Thu, 26 Jul 2012 21:16:24 +0200
Subject: [PATCH v2 4/7] ARM: pxa: add devicetree code for irq handling
In-Reply-To: <1343330187-20049-1-git-send-email-zonque@gmail.com>
References: <1343330187-20049-1-git-send-email-zonque@gmail.com>
Message-ID: <1343330187-20049-5-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Properly register on-chip interrupt using the irqdomain logic. The
number of interrupts is taken from the devicetree node.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/irq.c    | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/pxa3xx.c | 17 +++++++++--
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 5dae15e..7753d09 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -17,6 +17,8 @@
 #include <linux/syscore_ops.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <asm/exception.h>
 
@@ -202,3 +204,74 @@ struct syscore_ops pxa_irq_syscore_ops = {
 	.suspend	= pxa_irq_suspend,
 	.resume		= pxa_irq_resume,
 };
+
+#ifdef CONFIG_OF
+static struct irq_domain *pxa_irq_domain;
+
+static int pxa_irq_map(struct irq_domain *h, unsigned int virq,
+		       irq_hw_number_t hw)
+{
+	int irq, i = hw % 32;
+	void __iomem *base = irq_base(hw / 32);
+
+	/* initialize interrupt priority */
+	if (cpu_has_ipr())
+		__raw_writel(i | IPR_VALID, IRQ_BASE + IPR(i));
+
+	irq = PXA_IRQ(virq);
+	irq_set_chip_and_handler(irq, &pxa_internal_irq_chip,
+				 handle_level_irq);
+	irq_set_chip_data(virq, base);
+	set_irq_flags(virq, IRQF_VALID);
+
+	return 0;
+}
+
+static struct irq_domain_ops pxa_irq_ops = {
+	.map    = pxa_irq_map,
+	.xlate  = irq_domain_xlate_onecell,
+};
+
+static const struct of_device_id intc_ids[] __initconst = {
+	{ .compatible = "marvell,pxa-intc", .data = NULL },
+	{}
+};
+
+void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
+{
+	struct device_node *node;
+	const struct of_device_id *of_id;
+	struct pxa_intc_conf *conf;
+	int nr_irqs, irq_base, ret;
+
+	node = of_find_matching_node(NULL, intc_ids);
+	if (!node) {
+		pr_err("Failed to find interrupt controller in arch-pxa\n");
+		return;
+	}
+	of_id = of_match_node(intc_ids, node);
+	conf = of_id->data;
+
+	ret = of_property_read_u32(node, "mrvl,intc-nr-irqs", &nr_irqs);
+	if (ret) {
+		pr_err("Not found mrvl,intc-nr-irqs property\n");
+		return;
+	}
+
+	irq_base = irq_alloc_descs(-1, 0, nr_irqs, 0);
+	if (irq_base < 0) {
+		pr_err("Failed to allocate IRQ numbers\n");
+		return;
+	}
+
+	pxa_irq_domain = irq_domain_add_legacy(node, nr_irqs, 0, 0,
+					       &pxa_irq_ops, NULL);
+	if (!pxa_irq_domain)
+		panic("Unable to add PXA IRQ domain\n");
+
+	irq_set_default_host(pxa_irq_domain);
+	pxa_init_irq(nr_irqs, fn);
+
+	return;
+}
+#endif /* CONFIG_OF */
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index dffb7e8..1827d3c 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -40,6 +40,8 @@
 #define PECR_IE(n)	((1 << ((n) * 2)) << 28)
 #define PECR_IS(n)	((1 << ((n) * 2)) << 29)
 
+extern void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int));
+
 static DEFINE_PXA3_CKEN(pxa3xx_ffuart, FFUART, 14857000, 1);
 static DEFINE_PXA3_CKEN(pxa3xx_btuart, BTUART, 14857000, 1);
 static DEFINE_PXA3_CKEN(pxa3xx_stuart, STUART, 14857000, 1);
@@ -382,7 +384,7 @@ static void __init pxa_init_ext_wakeup_irq(int (*fn)(struct irq_data *,
 	pxa_ext_wakeup_chip.irq_set_wake = fn;
 }
 
-void __init pxa3xx_init_irq(void)
+static void __init __pxa3xx_init_irq(void)
 {
 	/* enable CP6 access */
 	u32 value;
@@ -390,10 +392,21 @@ void __init pxa3xx_init_irq(void)
 	value |= (1 << 6);
 	__asm__ __volatile__("mcr p15, 0, %0, c15, c1, 0\n": :"r"(value));
 
-	pxa_init_irq(56, pxa3xx_set_wake);
 	pxa_init_ext_wakeup_irq(pxa3xx_set_wake);
 }
 
+void __init pxa3xx_init_irq(void)
+{
+	__pxa3xx_init_irq();
+	pxa_init_irq(56, pxa3xx_set_wake);
+}
+
+void __init pxa3xx_dt_init_irq(void)
+{
+	__pxa3xx_init_irq();
+	pxa_dt_irq_init(pxa3xx_set_wake);
+}
+
 static struct map_desc pxa3xx_io_desc[] __initdata = {
 	{	/* Mem Ctl */
 		.virtual	= (unsigned long)SMEMC_VIRT,
-- 
1.7.11.2
