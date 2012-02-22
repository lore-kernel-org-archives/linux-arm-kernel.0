From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 22 Feb 2012 17:44:16 +0530
Subject: [PATCH v3 2/4] ARM: Exynos4: Add irq_domain support for gpio wakeup
 interrupts
In-Reply-To: <1329912858-32750-1-git-send-email-thomas.abraham@linaro.org>
References: <1329912858-32750-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1329912858-32750-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a irq_domain for all the 32 gpio external wakeup interrupt sources.
Since there are users of fixed linux irq numbers of the external wakeup
interrupts, the legacy mapping is used for the irq domain. The fixups
required to use irq domain based interrupt mapping is also included.

Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/common.c                 |  101 +++++++++++++++++--------
 arch/arm/mach-exynos/include/mach/regs-gpio.h |    4 +-
 2 files changed, 72 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 7dd9dd0..ed50185 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -547,9 +547,20 @@ void __init exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 	s3c24xx_init_uartdevs("exynos4210-uart", s5p_uart_resources, cfg, no);
 }
 
+/**
+ * struct exynos4_eint_data: runtime data for exynos4 gpio wakeup interrupts
+ * @irq_domain	: irq_domain representing the gpio wakeup interrupts sources.
+ * @gic_irq_base: base gic linux irq number for gpio wakeup interrupts.
+ */
+struct exynos4_eint_data {
+	struct irq_domain *irq_domain;
+	int gic_irq_base;
+};
+
 static DEFINE_SPINLOCK(eint_lock);
+static struct exynos4_eint_data eint_data;
 
-static unsigned int eint0_15_data[16];
+#define EXYNOS4_EINT_NR 32
 #define exynos4_irq_eint_to_gic_irq(number) (IRQ_EINT0 + number)
 
 static inline void exynos4_irq_eint_mask(struct irq_data *data)
@@ -557,9 +568,9 @@ static inline void exynos4_irq_eint_mask(struct irq_data *data)
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
 
@@ -568,16 +579,16 @@ static void exynos4_irq_eint_unmask(struct irq_data *data)
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
+		     S5P_EINT_PEND(EINT_REG_NR(data->hwirq)));
 }
 
 static void exynos4_irq_eint_maskack(struct irq_data *data)
@@ -588,7 +599,7 @@ static void exynos4_irq_eint_maskack(struct irq_data *data)
 
 static int exynos4_irq_eint_set_type(struct irq_data *data, unsigned int type)
 {
-	int offs = EINT_OFFSET(data->irq);
+	int offs = data->hwirq;
 	int shift;
 	u32 ctrl, mask;
 	u32 newvalue = 0;
@@ -623,10 +634,10 @@ static int exynos4_irq_eint_set_type(struct irq_data *data, unsigned int type)
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
@@ -670,19 +681,20 @@ static struct irq_chip exynos4_irq_eint = {
  *
  * Each EINT pend/mask registers handle eight of them.
  */
-static inline void exynos4_irq_demux_eint(unsigned int start)
+static inline void exynos4_irq_demux_eint(struct irq_domain *irq_domain,
+						unsigned int hwirq)
 {
 	unsigned int irq;
 
-	u32 status = __raw_readl(S5P_EINT_PEND(EINT_REG_NR(start)));
-	u32 mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(start)));
+	u32 status = __raw_readl(S5P_EINT_PEND(EINT_REG_NR(hwirq)));
+	u32 mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(hwirq)));
 
 	status &= ~mask;
 	status &= 0xff;
 
 	while (status) {
 		irq = fls(status) - 1;
-		generic_handle_irq(irq + start);
+		generic_handle_irq(irq_find_mapping(irq_domain, hwirq + irq));
 		status &= ~(1 << irq);
 	}
 }
@@ -690,16 +702,19 @@ static inline void exynos4_irq_demux_eint(unsigned int start)
 static void exynos4_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_get_chip(irq);
+	struct exynos4_eint_data *eint_data = irq_get_handler_data(irq);
+
 	chained_irq_enter(chip, desc);
-	exynos4_irq_demux_eint(IRQ_EINT(16));
-	exynos4_irq_demux_eint(IRQ_EINT(24));
+	exynos4_irq_demux_eint(eint_data->irq_domain, 16);
+	exynos4_irq_demux_eint(eint_data->irq_domain, 24);
 	chained_irq_exit(chip, desc);
 }
 
 static void exynos4_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 {
-	u32 *irq_data = irq_get_handler_data(irq);
+	struct exynos4_eint_data *eint_data = irq_get_handler_data(irq);
 	struct irq_chip *chip = irq_get_chip(irq);
+	int eint_irq;
 
 	chained_irq_enter(chip, desc);
 	chip->irq_mask(&desc->irq_data);
@@ -707,33 +722,57 @@ static void exynos4_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
 
-	generic_handle_irq(*irq_data);
+	eint_irq = irq_find_mapping(eint_data->irq_domain,
+					irq - eint_data->gic_irq_base);
+	generic_handle_irq(eint_irq);
 
 	chip->irq_unmask(&desc->irq_data);
 	chained_irq_exit(chip, desc);
 }
 
+static int exynos4_eint_irq_domain_map(struct irq_domain *d, unsigned int irq,
+					irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &exynos4_irq_eint, handle_level_irq);
+	set_irq_flags(irq, IRQF_VALID);
+	return 0;
+}
+
+static struct irq_domain_ops exynos4_eint_irq_domain_ops = {
+	.map = exynos4_eint_irq_domain_map,
+};
+
 static int __init exynos4_init_irq_eint(void)
 {
-	int irq;
+	int eint, irq_base;
+	struct irq_domain *irq_domain;
 
-	for (irq = 0 ; irq <= 31 ; irq++) {
-		irq_set_chip_and_handler(IRQ_EINT(irq), &exynos4_irq_eint,
-					 handle_level_irq);
-		set_irq_flags(IRQ_EINT(irq), IRQF_VALID);
+	irq_base = irq_alloc_descs(IRQ_EINT(0), 1, EXYNOS4_EINT_NR, 0);
+	if (IS_ERR_VALUE(irq_base)) {
+		irq_base = IRQ_EINT(0);
+		pr_warning("exynos4_init_irq_eint: irq desc alloc failed. "
+			"Continuing with %d as linux irq base\n", irq_base);
 	}
 
-	irq_set_chained_handler(IRQ_EINT16_31, exynos4_irq_demux_eint16_31);
+	irq_domain = irq_domain_add_legacy(NULL, EXYNOS4_EINT_NR, irq_base, 0,
+					&exynos4_eint_irq_domain_ops, NULL);
+	if (WARN_ON(!irq_domain)) {
+		pr_warning("exynos4_init_irq_eint: irq domain init failed\n");
+		return 0;
+	}
 
-	for (irq = 0 ; irq <= 15 ; irq++) {
-		eint0_15_data[irq] = IRQ_EINT(irq);
+	eint_data.irq_domain = irq_domain;
+	eint_data.gic_irq_base = exynos4_irq_eint_to_gic_irq(0);
 
-		irq_set_handler_data(exynos4_irq_eint_to_gic_irq(irq),
-				     &eint0_15_data[irq]);
-		irq_set_chained_handler(exynos4_irq_eint_to_gic_irq(irq),
+	for (eint = 0 ; eint <= 15 ; eint++) {
+		irq_set_handler_data(exynos4_irq_eint_to_gic_irq(eint),
+					&eint_data);
+		irq_set_chained_handler(exynos4_irq_eint_to_gic_irq(eint),
 					exynos4_irq_eint0_15);
 	}
 
+	irq_set_chained_handler(IRQ_EINT16_31, exynos4_irq_demux_eint16_31);
+	irq_set_handler_data(IRQ_EINT16_31, &eint_data);
 	return 0;
 }
 arch_initcall(exynos4_init_irq_eint);
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
 
-- 
1.6.6.rc2
