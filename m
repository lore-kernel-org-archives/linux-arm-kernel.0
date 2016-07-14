From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2016 13:11:34 +0200
Subject: [PATCH 6/7] ARM: nuc900: use SPARSE_IRQ
In-Reply-To: <20160714111135.2476095-1-arnd@arndb.de>
References: <20160714111135.2476095-1-arnd@arndb.de>
Message-ID: <20160714111135.2476095-6-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_MULTIPLATFORM implies sparse IRQs, so in we first have to make sure that actually
works. This enables CONFIG_SPARSE_IRQ for all of mach-w90x900.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                          |  1 +
 arch/arm/mach-w90x900/include/mach/irqs.h |  5 -----
 arch/arm/mach-w90x900/irq.c               | 22 +++++++++++++++++++++-
 drivers/irqchip/irq-nuc900.c              |  2 +-
 4 files changed, 23 insertions(+), 7 deletions(-)
 delete mode 100644 arch/arm/mach-w90x900/include/mach/irqs.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 908694886088..160dbf993660 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -504,6 +504,7 @@ config ARCH_W90X900
 	select GENERIC_CLOCKEVENTS
 	select GPIOLIB
 	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
 	help
 	  Support for Nuvoton (Winbond logic dept.) ARM9 processor,
 	  At present, the w90x900 has been renamed nuc900, regarding
diff --git a/arch/arm/mach-w90x900/include/mach/irqs.h b/arch/arm/mach-w90x900/include/mach/irqs.h
deleted file mode 100644
index 277903857030..000000000000
--- a/arch/arm/mach-w90x900/include/mach/irqs.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#if !defined(CONFIG_SOC_NUC900)
-#define NR_IRQS		(IRQ_ADC+1)
-#else
-#define NR_IRQS		62
-#endif
diff --git a/arch/arm/mach-w90x900/irq.c b/arch/arm/mach-w90x900/irq.c
index 42d9af897c42..726f646c992b 100644
--- a/arch/arm/mach-w90x900/irq.c
+++ b/arch/arm/mach-w90x900/irq.c
@@ -20,6 +20,7 @@
 #include <linux/ioport.h>
 #include <linux/ptrace.h>
 #include <linux/device.h>
+#include <linux/irqdomain.h>
 #include <linux/io.h>
 
 #include <asm/exception.h>
@@ -203,6 +204,8 @@ static struct irq_chip nuc900_irq_chip = {
 	.irq_unmask	= nuc900_irq_unmask,
 };
 
+static struct irq_domain *aic_domain;
+
 static void __exception_irq_entry nuc900_handle_irq(struct pt_regs *regs)
 {
 	int hwirq;
@@ -210,15 +213,32 @@ static void __exception_irq_entry nuc900_handle_irq(struct pt_regs *regs)
 	(void)readl(REG_AIC_IPER);
 	hwirq = readl(REG_AIC_ISNR);
 
-	handle_IRQ(hwirq, regs);
+	handle_domain_irq(aic_domain, hwirq, regs);
 }
 
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
 void __init nuc900_init_irq(void)
 {
 	int irqno;
 
 	set_handle_irq(nuc900_handle_irq);
 
+	aic_domain = irq_domain_add_simple(NULL, 31, 1,
+					   &aic_irq_domain_ops, NULL);
+
 	__raw_writel(0xFFFFFFFE, REG_AIC_MDCR);
 
 	for (irqno = IRQ_WDT; irqno <= IRQ_ADC; irqno++) {
diff --git a/drivers/irqchip/irq-nuc900.c b/drivers/irqchip/irq-nuc900.c
index c4b2e39f7662..a595139f2f9c 100644
--- a/drivers/irqchip/irq-nuc900.c
+++ b/drivers/irqchip/irq-nuc900.c
@@ -129,7 +129,7 @@ static int __init aic_of_init(struct device_node *node,
 	writel(0xFFFFFFFC, aic_base + REG_AIC_MDCR);
 	writel(0xFFFFFFFF, aic_base + REG_AIC_MDCRH);
 
-	aic_domain = irq_domain_add_linear(node, NR_IRQS,
+	aic_domain = irq_domain_add_linear(node, 64,
 					   &aic_irq_domain_ops, NULL);
 
 	if (!aic_domain) {
-- 
2.9.0
