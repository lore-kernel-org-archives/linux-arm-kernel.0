From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 11 Dec 2011 12:21:39 +0530
Subject: [PATCH v2 2/4] ARM: Exynos4: Add irq_domain support for wakeup
 interrupts
In-Reply-To: <1323586301-24537-2-git-send-email-thomas.abraham@linaro.org>
References: <1323586301-24537-1-git-send-email-thomas.abraham@linaro.org>
 <1323586301-24537-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1323586301-24537-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add irq_domain support for the 32 wakeup interrupt sources.

Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/include/mach/regs-gpio.h |    4 +-
 arch/arm/mach-exynos/irq-eint.c               |   71 ++++++++++++++++---------
 2 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/regs-gpio.h b/arch/arm/mach-exynos/include/mach/regs-gpio.h
index 1401b21..2e6ec6b 100644
--- a/arch/arm/mach-exynos/include/mach/regs-gpio.h
+++ b/arch/arm/mach-exynos/include/mach/regs-gpio.h
@@ -28,9 +28,9 @@
 #define EXYNOS4_EINT40PEND		(S5P_VA_GPIO2 + 0xF40)
 #define S5P_EINT_PEND(x)		(EXYNOS4_EINT40PEND + ((x) * 0x4))
 
-#define EINT_REG_NR(x)			(EINT_OFFSET(x) >> 3)
+#define EINT_REG_NR(x)			((x) >> 3)
 
-#define eint_irq_to_bit(irq)		(1 << (EINT_OFFSET(irq) & 0x7))
+#define eint_irq_to_bit(irq)		(1 << ((irq) & 0x7))
 
 #define EINT_MODE			S3C_GPIO_SFN(0xf)
 
diff --git a/arch/arm/mach-exynos/irq-eint.c b/arch/arm/mach-exynos/irq-eint.c
index 5e89412..41aaca8 100644
--- a/arch/arm/mach-exynos/irq-eint.c
+++ b/arch/arm/mach-exynos/irq-eint.c
@@ -16,6 +16,8 @@
 #include <linux/io.h>
 #include <linux/sysdev.h>
 #include <linux/gpio.h>
+#include <linux/irqdomain.h>
+#include <linux/export.h>
 
 #include <plat/pm.h>
 #include <plat/cpu.h>
@@ -28,17 +30,19 @@
 static DEFINE_SPINLOCK(eint_lock);
 
 static unsigned int eint0_15_data[16];
+static struct irq_domain exynos4_eint_irq_domain;
 
 #define exynos4_irq_eint_to_gic_irq(number) (IRQ_EINT0 + number)
+#define EXYNOS4_EINT_NR 32
 
 static inline void exynos4_irq_eint_mask(struct irq_data *data)
 {
 	u32 mask;
 
 	spin_lock(&eint_lock);
-	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(data->irq)));
-	mask |= eint_irq_to_bit(data->irq);
-	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(data->irq)));
+	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(data->hwirq)));
+	mask |= eint_irq_to_bit(data->hwirq);
+	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(data->hwirq)));
 	spin_unlock(&eint_lock);
 }
 
@@ -47,16 +51,16 @@ static void exynos4_irq_eint_unmask(struct irq_data *data)
 	u32 mask;
 
 	spin_lock(&eint_lock);
-	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(data->irq)));
-	mask &= ~(eint_irq_to_bit(data->irq));
-	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(data->irq)));
+	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(data->hwirq)));
+	mask &= ~(eint_irq_to_bit(data->hwirq));
+	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(data->hwirq)));
 	spin_unlock(&eint_lock);
 }
 
 static inline void exynos4_irq_eint_ack(struct irq_data *data)
 {
-	__raw_writel(eint_irq_to_bit(data->irq),
-		     S5P_EINT_PEND(EINT_REG_NR(data->irq)));
+	__raw_writel(eint_irq_to_bit(data->hwirq),
+			S5P_EINT_PEND(EINT_REG_NR(data->hwirq)));
 }
 
 static void exynos4_irq_eint_maskack(struct irq_data *data)
@@ -67,7 +71,7 @@ static void exynos4_irq_eint_maskack(struct irq_data *data)
 
 static int exynos4_irq_eint_set_type(struct irq_data *data, unsigned int type)
 {
-	int offs = EINT_OFFSET(data->irq);
+	int offs = data->hwirq;
 	int shift;
 	u32 ctrl, mask;
 	u32 newvalue = 0;
@@ -102,10 +106,10 @@ static int exynos4_irq_eint_set_type(struct irq_data *data, unsigned int type)
 	mask = 0x7 << shift;
 
 	spin_lock(&eint_lock);
-	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(data->irq)));
+	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(data->hwirq)));
 	ctrl &= ~mask;
 	ctrl |= newvalue << shift;
-	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(data->irq)));
+	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(data->hwirq)));
 	spin_unlock(&eint_lock);
 
 	switch (offs) {
@@ -148,19 +152,19 @@ static struct irq_chip exynos4_irq_eint = {
  *
  * Each EINT pend/mask registers handle eight of them.
  */
-static inline void exynos4_irq_demux_eint(unsigned int start)
+static inline void exynos4_irq_demux_eint(unsigned int base, unsigned int offs)
 {
 	unsigned int irq;
 
-	u32 status = __raw_readl(S5P_EINT_PEND(EINT_REG_NR(start)));
-	u32 mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(start)));
+	u32 status = __raw_readl(S5P_EINT_PEND(EINT_REG_NR(offs)));
+	u32 mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(offs)));
 
 	status &= ~mask;
 	status &= 0xff;
 
 	while (status) {
 		irq = fls(status) - 1;
-		generic_handle_irq(irq + start);
+		generic_handle_irq(irq + offs + base);
 		status &= ~(1 << irq);
 	}
 }
@@ -168,9 +172,11 @@ static inline void exynos4_irq_demux_eint(unsigned int start)
 static void exynos4_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_get_chip(irq);
+	u32 *irq_data = irq_get_handler_data(irq);
+
 	chained_irq_enter(chip, desc);
-	exynos4_irq_demux_eint(IRQ_EINT(16));
-	exynos4_irq_demux_eint(IRQ_EINT(24));
+	exynos4_irq_demux_eint(*irq_data, 16);
+	exynos4_irq_demux_eint(*irq_data, 24);
 	chained_irq_exit(chip, desc);
 }
 
@@ -193,22 +199,35 @@ static void exynos4_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 
 int __init exynos4_init_irq_eint(void)
 {
-	int irq;
+	int irq, hwirq;
+	struct irq_domain *domain = &exynos4_eint_irq_domain;
+
+	domain->irq_base = irq_alloc_descs(IRQ_EINT(0), IRQ_EINT(0),
+						EXYNOS4_EINT_NR, 0);
+	if (domain->irq_base < 0) {
+		pr_err("exynos4_init_irq_eint: Failed to alloc irq descs\n");
+		return -EBUSY;
+	}
+	domain->nr_irq = EXYNOS4_EINT_NR;
+	domain->ops = &irq_domain_simple_ops;
+	irq_domain_add(domain);
 
-	for (irq = 0 ; irq <= 31 ; irq++) {
-		irq_set_chip_and_handler(IRQ_EINT(irq), &exynos4_irq_eint,
+	irq_domain_for_each_irq(domain, hwirq, irq) {
+		irq_set_chip_and_handler(irq, &exynos4_irq_eint,
 					 handle_level_irq);
-		set_irq_flags(IRQ_EINT(irq), IRQF_VALID);
+		set_irq_flags(irq, IRQF_VALID);
 	}
 
 	irq_set_chained_handler(IRQ_EINT16_31, exynos4_irq_demux_eint16_31);
+	irq_set_handler_data(IRQ_EINT16_31, &domain->irq_base);
 
-	for (irq = 0 ; irq <= 15 ; irq++) {
-		eint0_15_data[irq] = IRQ_EINT(irq);
+	for (hwirq = 0 ; hwirq <= 15 ; hwirq++) {
+		irq = irq_domain_to_irq(domain, hwirq);
+		eint0_15_data[hwirq] = irq;
 
-		irq_set_handler_data(exynos4_irq_eint_to_gic_irq(irq),
-				     &eint0_15_data[irq]);
-		irq_set_chained_handler(exynos4_irq_eint_to_gic_irq(irq),
+		irq_set_handler_data(exynos4_irq_eint_to_gic_irq(hwirq),
+				     &eint0_15_data[hwirq]);
+		irq_set_chained_handler(exynos4_irq_eint_to_gic_irq(hwirq),
 					exynos4_irq_eint0_15);
 	}
 
-- 
1.6.6.rc2
