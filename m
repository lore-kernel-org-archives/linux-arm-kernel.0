From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 14 Dec 2010 22:55:26 +0100
Subject: [PATCH 2/3] ARM: S5P: irq_data conversion.
In-Reply-To: <929a34e7a1cc775b36e3196b3e10d8cf591a7c03.1292364161.git.buytenh@wantstofly.org>
References: <929a34e7a1cc775b36e3196b3e10d8cf591a7c03.1292364161.git.buytenh@wantstofly.org>
Message-ID: <3b3ece8f65ea00f9d3758929a723aaa71cde2167.1292364161.git.buytenh@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-s5pv310/irq-combiner.c |   26 ++++++-----
 arch/arm/mach-s5pv310/irq-eint.c     |   53 +++++++++++-----------
 arch/arm/plat-s5p/irq-eint.c         |   82 +++++++++++++++++----------------
 arch/arm/plat-s5p/irq-gpioint.c      |   50 ++++++++++----------
 arch/arm/plat-s5p/irq-pm.c           |    6 +-
 5 files changed, 111 insertions(+), 106 deletions(-)

diff --git a/arch/arm/mach-s5pv310/irq-combiner.c b/arch/arm/mach-s5pv310/irq-combiner.c
index c3f88c3..9cdd1e4 100644
--- a/arch/arm/mach-s5pv310/irq-combiner.c
+++ b/arch/arm/mach-s5pv310/irq-combiner.c
@@ -29,24 +29,26 @@ struct combiner_chip_data {
 
 static struct combiner_chip_data combiner_data[MAX_COMBINER_NR];
 
-static inline void __iomem *combiner_base(unsigned int irq)
+static inline void __iomem *combiner_base(struct irq_data *data)
 {
-	struct combiner_chip_data *combiner_data = get_irq_chip_data(irq);
+	struct combiner_chip_data *combiner_data =
+		irq_data_get_irq_chip_data(data);
+
 	return combiner_data->base;
 }
 
-static void combiner_mask_irq(unsigned int irq)
+static void combiner_mask_irq(struct irq_data *data)
 {
-	u32 mask = 1 << (irq % 32);
+	u32 mask = 1 << (data->irq % 32);
 
-	__raw_writel(mask, combiner_base(irq) + COMBINER_ENABLE_CLEAR);
+	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_CLEAR);
 }
 
-static void combiner_unmask_irq(unsigned int irq)
+static void combiner_unmask_irq(struct irq_data *data)
 {
-	u32 mask = 1 << (irq % 32);
+	u32 mask = 1 << (data->irq % 32);
 
-	__raw_writel(mask, combiner_base(irq) + COMBINER_ENABLE_SET);
+	__raw_writel(mask, combiner_base(data) + COMBINER_ENABLE_SET);
 }
 
 static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
@@ -57,7 +59,7 @@ static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 	unsigned long status;
 
 	/* primary controller ack'ing */
-	chip->ack(irq);
+	chip->irq_ack(&desc->irq_data);
 
 	spin_lock(&irq_controller_lock);
 	status = __raw_readl(chip_data->base + COMBINER_INT_STATUS);
@@ -76,13 +78,13 @@ static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 
  out:
 	/* primary controller unmasking */
-	chip->unmask(irq);
+	chip->irq_unmask(&desc->irq_data);
 }
 
 static struct irq_chip combiner_chip = {
 	.name		= "COMBINER",
-	.mask		= combiner_mask_irq,
-	.unmask		= combiner_unmask_irq,
+	.irq_mask	= combiner_mask_irq,
+	.irq_unmask	= combiner_unmask_irq,
 };
 
 void __init combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq)
diff --git a/arch/arm/mach-s5pv310/irq-eint.c b/arch/arm/mach-s5pv310/irq-eint.c
index f5a415e..477bd9e 100644
--- a/arch/arm/mach-s5pv310/irq-eint.c
+++ b/arch/arm/mach-s5pv310/irq-eint.c
@@ -48,42 +48,43 @@ static unsigned int s5pv310_get_irq_nr(unsigned int number)
 	return ret;
 }
 
-static inline void s5pv310_irq_eint_mask(unsigned int irq)
+static inline void s5pv310_irq_eint_mask(struct irq_data *data)
 {
 	u32 mask;
 
 	spin_lock(&eint_lock);
-	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(irq)));
-	mask |= eint_irq_to_bit(irq);
-	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(irq)));
+	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(data->irq)));
+	mask |= eint_irq_to_bit(data->irq);
+	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(data->irq)));
 	spin_unlock(&eint_lock);
 }
 
-static void s5pv310_irq_eint_unmask(unsigned int irq)
+static void s5pv310_irq_eint_unmask(struct irq_data *data)
 {
 	u32 mask;
 
 	spin_lock(&eint_lock);
-	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(irq)));
-	mask &= ~(eint_irq_to_bit(irq));
-	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(irq)));
+	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(data->irq)));
+	mask &= ~(eint_irq_to_bit(data->irq));
+	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(data->irq)));
 	spin_unlock(&eint_lock);
 }
 
-static inline void s5pv310_irq_eint_ack(unsigned int irq)
+static inline void s5pv310_irq_eint_ack(struct irq_data *data)
 {
-	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(EINT_REG_NR(irq)));
+	__raw_writel(eint_irq_to_bit(data->irq),
+		     S5P_EINT_PEND(EINT_REG_NR(data->irq)));
 }
 
-static void s5pv310_irq_eint_maskack(unsigned int irq)
+static void s5pv310_irq_eint_maskack(struct irq_data *data)
 {
-	s5pv310_irq_eint_mask(irq);
-	s5pv310_irq_eint_ack(irq);
+	s5pv310_irq_eint_mask(data);
+	s5pv310_irq_eint_ack(data);
 }
 
-static int s5pv310_irq_eint_set_type(unsigned int irq, unsigned int type)
+static int s5pv310_irq_eint_set_type(struct irq_data *data, unsigned int type)
 {
-	int offs = EINT_OFFSET(irq);
+	int offs = EINT_OFFSET(data->irq);
 	int shift;
 	u32 ctrl, mask;
 	u32 newvalue = 0;
@@ -118,10 +119,10 @@ static int s5pv310_irq_eint_set_type(unsigned int irq, unsigned int type)
 	mask = 0x7 << shift;
 
 	spin_lock(&eint_lock);
-	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(irq)));
+	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(data->irq)));
 	ctrl &= ~mask;
 	ctrl |= newvalue << shift;
-	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(irq)));
+	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(data->irq)));
 	spin_unlock(&eint_lock);
 
 	switch (offs) {
@@ -146,11 +147,11 @@ static int s5pv310_irq_eint_set_type(unsigned int irq, unsigned int type)
 
 static struct irq_chip s5pv310_irq_eint = {
 	.name		= "s5pv310-eint",
-	.mask		= s5pv310_irq_eint_mask,
-	.unmask		= s5pv310_irq_eint_unmask,
-	.mask_ack	= s5pv310_irq_eint_maskack,
-	.ack		= s5pv310_irq_eint_ack,
-	.set_type	= s5pv310_irq_eint_set_type,
+	.irq_mask	= s5pv310_irq_eint_mask,
+	.irq_unmask	= s5pv310_irq_eint_unmask,
+	.irq_mask_ack	= s5pv310_irq_eint_maskack,
+	.irq_ack	= s5pv310_irq_eint_ack,
+	.irq_set_type	= s5pv310_irq_eint_set_type,
 #ifdef CONFIG_PM
 	.irq_set_wake	= s3c_irqext_wake,
 #endif
@@ -192,14 +193,14 @@ static void s5pv310_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 	u32 *irq_data = get_irq_data(irq);
 	struct irq_chip *chip = get_irq_chip(irq);
 
-	chip->mask(irq);
+	chip->irq_mask(&desc->irq_data);
 
-	if (chip->ack)
-		chip->ack(irq);
+	if (chip->irq_ack)
+		chip->irq_ack(&desc->irq_data);
 
 	generic_handle_irq(*irq_data);
 
-	chip->unmask(irq);
+	chip->irq_unmask(&desc->irq_data);
 }
 
 int __init s5pv310_init_irq_eint(void)
diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
index f2f2e1c..225aa25 100644
--- a/arch/arm/plat-s5p/irq-eint.c
+++ b/arch/arm/plat-s5p/irq-eint.c
@@ -28,39 +28,40 @@
 #include <plat/gpio-cfg.h>
 #include <mach/regs-gpio.h>
 
-static inline void s5p_irq_eint_mask(unsigned int irq)
+static inline void s5p_irq_eint_mask(struct irq_data *data)
 {
 	u32 mask;
 
-	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(irq)));
-	mask |= eint_irq_to_bit(irq);
-	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(irq)));
+	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(data->irq)));
+	mask |= eint_irq_to_bit(data->irq);
+	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(data->irq)));
 }
 
-static void s5p_irq_eint_unmask(unsigned int irq)
+static void s5p_irq_eint_unmask(struct irq_data *data)
 {
 	u32 mask;
 
-	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(irq)));
-	mask &= ~(eint_irq_to_bit(irq));
-	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(irq)));
+	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(data->irq)));
+	mask &= ~(eint_irq_to_bit(data->irq));
+	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(data->irq)));
 }
 
-static inline void s5p_irq_eint_ack(unsigned int irq)
+static inline void s5p_irq_eint_ack(struct irq_data *data)
 {
-	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(EINT_REG_NR(irq)));
+	__raw_writel(eint_irq_to_bit(data->irq),
+		     S5P_EINT_PEND(EINT_REG_NR(data->irq)));
 }
 
-static void s5p_irq_eint_maskack(unsigned int irq)
+static void s5p_irq_eint_maskack(struct irq_data *data)
 {
 	/* compiler should in-line these */
-	s5p_irq_eint_mask(irq);
-	s5p_irq_eint_ack(irq);
+	s5p_irq_eint_mask(data);
+	s5p_irq_eint_ack(data);
 }
 
-static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
+static int s5p_irq_eint_set_type(struct irq_data *data, unsigned int type)
 {
-	int offs = EINT_OFFSET(irq);
+	int offs = EINT_OFFSET(data->irq);
 	int shift;
 	u32 ctrl, mask;
 	u32 newvalue = 0;
@@ -94,10 +95,10 @@ static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
 	shift = (offs & 0x7) * 4;
 	mask = 0x7 << shift;
 
-	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(irq)));
+	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(data->irq)));
 	ctrl &= ~mask;
 	ctrl |= newvalue << shift;
-	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(irq)));
+	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(data->irq)));
 
 	if ((0 <= offs) && (offs < 8))
 		s3c_gpio_cfgpin(EINT_GPIO_0(offs & 0x7), EINT_MODE);
@@ -119,11 +120,11 @@ static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
 
 static struct irq_chip s5p_irq_eint = {
 	.name		= "s5p-eint",
-	.mask		= s5p_irq_eint_mask,
-	.unmask		= s5p_irq_eint_unmask,
-	.mask_ack	= s5p_irq_eint_maskack,
-	.ack		= s5p_irq_eint_ack,
-	.set_type	= s5p_irq_eint_set_type,
+	.irq_mask	= s5p_irq_eint_mask,
+	.irq_unmask	= s5p_irq_eint_unmask,
+	.irq_mask_ack	= s5p_irq_eint_maskack,
+	.irq_ack	= s5p_irq_eint_ack,
+	.irq_set_type	= s5p_irq_eint_set_type,
 #ifdef CONFIG_PM
 	.irq_set_wake	= s3c_irqext_wake,
 #endif
@@ -159,40 +160,41 @@ static void s5p_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 	s5p_irq_demux_eint(IRQ_EINT(24));
 }
 
-static inline void s5p_irq_vic_eint_mask(unsigned int irq)
+static inline void s5p_irq_vic_eint_mask(struct irq_data *data)
 {
-	void __iomem *base = get_irq_chip_data(irq);
+	void __iomem *base = irq_data_get_irq_chip_data(data);
 
-	s5p_irq_eint_mask(irq);
-	writel(1 << EINT_OFFSET(irq), base + VIC_INT_ENABLE_CLEAR);
+	s5p_irq_eint_mask(data);
+	writel(1 << EINT_OFFSET(data->irq), base + VIC_INT_ENABLE_CLEAR);
 }
 
-static void s5p_irq_vic_eint_unmask(unsigned int irq)
+static void s5p_irq_vic_eint_unmask(struct irq_data *data)
 {
-	void __iomem *base = get_irq_chip_data(irq);
+	void __iomem *base = irq_data_get_irq_chip_data(data);
 
-	s5p_irq_eint_unmask(irq);
-	writel(1 << EINT_OFFSET(irq), base + VIC_INT_ENABLE);
+	s5p_irq_eint_unmask(data);
+	writel(1 << EINT_OFFSET(data->irq), base + VIC_INT_ENABLE);
 }
 
-static inline void s5p_irq_vic_eint_ack(unsigned int irq)
+static inline void s5p_irq_vic_eint_ack(struct irq_data *data)
 {
-	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(EINT_REG_NR(irq)));
+	__raw_writel(eint_irq_to_bit(data->irq),
+		     S5P_EINT_PEND(EINT_REG_NR(data->irq)));
 }
 
-static void s5p_irq_vic_eint_maskack(unsigned int irq)
+static void s5p_irq_vic_eint_maskack(struct irq_data *data)
 {
-	s5p_irq_vic_eint_mask(irq);
-	s5p_irq_vic_eint_ack(irq);
+	s5p_irq_vic_eint_mask(data);
+	s5p_irq_vic_eint_ack(data);
 }
 
 static struct irq_chip s5p_irq_vic_eint = {
 	.name		= "s5p_vic_eint",
-	.mask		= s5p_irq_vic_eint_mask,
-	.unmask		= s5p_irq_vic_eint_unmask,
-	.mask_ack	= s5p_irq_vic_eint_maskack,
-	.ack		= s5p_irq_vic_eint_ack,
-	.set_type	= s5p_irq_eint_set_type,
+	.irq_mask	= s5p_irq_vic_eint_mask,
+	.irq_unmask	= s5p_irq_vic_eint_unmask,
+	.irq_mask_ack	= s5p_irq_vic_eint_maskack,
+	.irq_ack	= s5p_irq_vic_eint_ack,
+	.irq_set_type	= s5p_irq_eint_set_type,
 #ifdef CONFIG_PM
 	.irq_set_wake	= s3c_irqext_wake,
 #endif
diff --git a/arch/arm/plat-s5p/irq-gpioint.c b/arch/arm/plat-s5p/irq-gpioint.c
index 0e5dc8c..3b6bf89 100644
--- a/arch/arm/plat-s5p/irq-gpioint.c
+++ b/arch/arm/plat-s5p/irq-gpioint.c
@@ -30,9 +30,9 @@
 
 static struct s3c_gpio_chip *irq_chips[S5P_GPIOINT_GROUP_MAXNR];
 
-static int s5p_gpioint_get_group(unsigned int irq)
+static int s5p_gpioint_get_group(struct irq_data *data)
 {
-	struct gpio_chip *chip = get_irq_data(irq);
+	struct gpio_chip *chip = irq_data_get_irq_data(data);
 	struct s3c_gpio_chip *s3c_chip = container_of(chip,
 			struct s3c_gpio_chip, chip);
 	int group;
@@ -44,22 +44,22 @@ static int s5p_gpioint_get_group(unsigned int irq)
 	return group;
 }
 
-static int s5p_gpioint_get_offset(unsigned int irq)
+static int s5p_gpioint_get_offset(struct irq_data *data)
 {
-	struct gpio_chip *chip = get_irq_data(irq);
+	struct gpio_chip *chip = irq_data_get_irq_data(data);
 	struct s3c_gpio_chip *s3c_chip = container_of(chip,
 			struct s3c_gpio_chip, chip);
 
-	return irq - s3c_chip->irq_base;
+	return data->irq - s3c_chip->irq_base;
 }
 
-static void s5p_gpioint_ack(unsigned int irq)
+static void s5p_gpioint_ack(struct irq_data *data)
 {
 	int group, offset, pend_offset;
 	unsigned int value;
 
-	group = s5p_gpioint_get_group(irq);
-	offset = s5p_gpioint_get_offset(irq);
+	group = s5p_gpioint_get_group(data);
+	offset = s5p_gpioint_get_offset(data);
 	pend_offset = group << 2;
 
 	value = __raw_readl(S5P_GPIOREG(GPIOINT_PEND_OFFSET) + pend_offset);
@@ -67,13 +67,13 @@ static void s5p_gpioint_ack(unsigned int irq)
 	__raw_writel(value, S5P_GPIOREG(GPIOINT_PEND_OFFSET) + pend_offset);
 }
 
-static void s5p_gpioint_mask(unsigned int irq)
+static void s5p_gpioint_mask(struct irq_data *data)
 {
 	int group, offset, mask_offset;
 	unsigned int value;
 
-	group = s5p_gpioint_get_group(irq);
-	offset = s5p_gpioint_get_offset(irq);
+	group = s5p_gpioint_get_group(data);
+	offset = s5p_gpioint_get_offset(data);
 	mask_offset = group << 2;
 
 	value = __raw_readl(S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
@@ -81,13 +81,13 @@ static void s5p_gpioint_mask(unsigned int irq)
 	__raw_writel(value, S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
 }
 
-static void s5p_gpioint_unmask(unsigned int irq)
+static void s5p_gpioint_unmask(struct irq_data *data)
 {
 	int group, offset, mask_offset;
 	unsigned int value;
 
-	group = s5p_gpioint_get_group(irq);
-	offset = s5p_gpioint_get_offset(irq);
+	group = s5p_gpioint_get_group(data);
+	offset = s5p_gpioint_get_offset(data);
 	mask_offset = group << 2;
 
 	value = __raw_readl(S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
@@ -95,19 +95,19 @@ static void s5p_gpioint_unmask(unsigned int irq)
 	__raw_writel(value, S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
 }
 
-static void s5p_gpioint_mask_ack(unsigned int irq)
+static void s5p_gpioint_mask_ack(struct irq_data *data)
 {
-	s5p_gpioint_mask(irq);
-	s5p_gpioint_ack(irq);
+	s5p_gpioint_mask(data);
+	s5p_gpioint_ack(data);
 }
 
-static int s5p_gpioint_set_type(unsigned int irq, unsigned int type)
+static int s5p_gpioint_set_type(struct irq_data *data, unsigned int type)
 {
 	int group, offset, con_offset;
 	unsigned int value;
 
-	group = s5p_gpioint_get_group(irq);
-	offset = s5p_gpioint_get_offset(irq);
+	group = s5p_gpioint_get_group(data);
+	offset = s5p_gpioint_get_offset(data);
 	con_offset = group << 2;
 
 	switch (type) {
@@ -142,11 +142,11 @@ static int s5p_gpioint_set_type(unsigned int irq, unsigned int type)
 
 struct irq_chip s5p_gpioint = {
 	.name		= "s5p_gpioint",
-	.ack		= s5p_gpioint_ack,
-	.mask		= s5p_gpioint_mask,
-	.mask_ack	= s5p_gpioint_mask_ack,
-	.unmask		= s5p_gpioint_unmask,
-	.set_type	= s5p_gpioint_set_type,
+	.irq_ack	= s5p_gpioint_ack,
+	.irq_mask	= s5p_gpioint_mask,
+	.irq_mask_ack	= s5p_gpioint_mask_ack,
+	.irq_unmask	= s5p_gpioint_unmask,
+	.irq_set_type	= s5p_gpioint_set_type,
 };
 
 static void s5p_gpioint_handler(unsigned int irq, struct irq_desc *desc)
diff --git a/arch/arm/plat-s5p/irq-pm.c b/arch/arm/plat-s5p/irq-pm.c
index dc33b9e..5259ad4 100644
--- a/arch/arm/plat-s5p/irq-pm.c
+++ b/arch/arm/plat-s5p/irq-pm.c
@@ -37,14 +37,14 @@
 unsigned long s3c_irqwake_intallow	= 0x00000006L;
 unsigned long s3c_irqwake_eintallow	= 0xffffffffL;
 
-int s3c_irq_wake(unsigned int irqno, unsigned int state)
+int s3c_irq_wake(struct irq_data *data, unsigned int state)
 {
 	unsigned long irqbit;
 
-	switch (irqno) {
+	switch (data->irq) {
 	case IRQ_RTC_TIC:
 	case IRQ_RTC_ALARM:
-		irqbit = 1 << (irqno + 1 - IRQ_RTC_ALARM);
+		irqbit = 1 << (data->irq + 1 - IRQ_RTC_ALARM);
 		if (!state)
 			s3c_irqwake_intmask |= irqbit;
 		else
-- 
1.7.1


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0003-ARM-plat-samsung-some-GENERIC_HARDIRQS_NO_DEPRECATED.patch"
