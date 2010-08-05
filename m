From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 05 Aug 2010 18:03:15 +0900
Subject: [RFC PATCH] ARM: S5PC110: Remove VA_GPIO dependency from GPIO	related
	functions
Message-ID: <20100805090315.GA20274@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To Ben,

Now I'm working on remove the dependency from VA_GPIO for the S5PC210 GPIOs.

S5PC210 has three GPIOs and has differnet address spaces.

Basic idea is remove static io mapping from iodesc and ioremap at each SoCs for their purpose. and pass the required information to external interrupt.
The same mechanism is used to implement the GPIO interrupt features.

How do you think?

Note that some gpio interrupt codes are included but no problem to test it.

Thank you,
Kyungmin Park
---
diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
index 9ea8972..f4bb967 100644
--- a/arch/arm/mach-s5pv210/gpiolib.c
+++ b/arch/arm/mach-s5pv210/gpiolib.c
@@ -31,10 +31,18 @@ static struct s3c_gpio_cfg gpio_cfg_noint = {
 	.get_pull	= s3c_gpio_getpull_updown,
 };
 
+static struct s3c_gpio_cfg gpio_cfg_extint = {
+	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
+	.set_pull	= s3c_gpio_setpull_updown,
+	.get_pull	= s3c_gpio_getpull_updown,
+};
+
 /* GPIO bank's base address given the index of the bank in the
  * list of all gpio banks.
  */
-#define S5PV210_BANK_BASE(bank_nr)	(S5P_VA_GPIO + ((bank_nr) * 0x20))
+#define S5PV210_BANK_BASE(base, bank_nr)	((base) + ((bank_nr) * 0x20))
+
+#define EXTINT_OFFSET			(0xC00)
 
 /*
  * Following are the gpio banks in v210.
@@ -150,6 +158,7 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 			.label	= "GPG3",
 		},
 	}, {
+		.config	= &gpio_cfg_noint,
 		.chip	= {
 			.base	= S5PV210_GPI(0),
 			.ngpio	= S5PV210_GPIO_I_NR,
@@ -207,32 +216,28 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 			.label	= "MP03",
 		},
 	}, {
-		.base	= (S5P_VA_GPIO + 0xC00),
-		.config	= &gpio_cfg_noint,
+		.config	= &gpio_cfg_extint,
 		.chip	= {
 			.base	= S5PV210_GPH0(0),
 			.ngpio	= S5PV210_GPIO_H0_NR,
 			.label	= "GPH0",
 		},
 	}, {
-		.base	= (S5P_VA_GPIO + 0xC20),
-		.config	= &gpio_cfg_noint,
+		.config	= &gpio_cfg_extint,
 		.chip	= {
 			.base	= S5PV210_GPH1(0),
 			.ngpio	= S5PV210_GPIO_H1_NR,
 			.label	= "GPH1",
 		},
 	}, {
-		.base	= (S5P_VA_GPIO + 0xC40),
-		.config	= &gpio_cfg_noint,
+		.config	= &gpio_cfg_extint,
 		.chip	= {
 			.base	= S5PV210_GPH2(0),
 			.ngpio	= S5PV210_GPIO_H2_NR,
 			.label	= "GPH2",
 		},
 	}, {
-		.base	= (S5P_VA_GPIO + 0xC60),
-		.config	= &gpio_cfg_noint,
+		.config	= &gpio_cfg_extint,
 		.chip	= {
 			.base	= S5PV210_GPH3(0),
 			.ngpio	= S5PV210_GPIO_H3_NR,
@@ -241,21 +246,56 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 	},
 };
 
+static int s5pv210_extint_to_irq(struct gpio_chip *gpio, unsigned int offset)
+{
+	struct s3c_gpio_chip *chip = to_s3c_gpio(gpio);
+	int irq;
+
+	irq = (chip->group * 8) + offset;
+	return IRQ_EINT(irq);
+}
+
 static __init int s5pv210_gpiolib_init(void)
 {
+	struct samsung_irq_gpio_info gpio[1];
 	struct s3c_gpio_chip *chip = s5pv210_gpio_4bit;
 	int nr_chips = ARRAY_SIZE(s5pv210_gpio_4bit);
 	int i = 0;
+	int extint = 0;
+	int group = 0;
+	void __iomem *base;
+
+	base = ioremap(S5P_PA_GPIO, SZ_4K);
+	if (!base)
+		panic("Can't ioremap the GPIO address\n");
 
 	for (i = 0; i < nr_chips; i++, chip++) {
-		if (chip->config == NULL)
+		if (chip->config == NULL) {
 			chip->config = &gpio_cfg;
+			/* Assign the GPIO interrupt group */
+			chip->group = group++;
+			samsung_irq_gpio_add(chip);
+		}
+		if (chip->config == &gpio_cfg_extint) {
+			chip->base = S5PV210_BANK_BASE(base, extint) + EXTINT_OFFSET;
+			/* Assign the External GPIO interrupt group */
+			chip->group = extint++;
+			chip->chip.to_irq = s5pv210_extint_to_irq;
+		}
 		if (chip->base == NULL)
-			chip->base = S5PV210_BANK_BASE(i);
+			chip->base = S5PV210_BANK_BASE(base, i);
 	}
 
 	samsung_gpiolib_add_4bit_chips(s5pv210_gpio_4bit, nr_chips);
 
+	s5p_init_irq_eint(base);
+
+	gpio[0].irq = IRQ_GPIOINT;
+	gpio[0].sig.nr_groups = SAMSUNG_IRQ_GPIO_NR_GROUPS;
+	gpio[0].sig.base = base;
+	gpio[0].handler = NULL;
+	samsung_irq_gpio_register(gpio, ARRAY_SIZE(gpio));
+
 	return 0;
 }
 core_initcall(s5pv210_gpiolib_init);
diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index 9689537..d5a5221 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -51,11 +51,12 @@
 #define IRQ_UART2		S5P_IRQ_VIC1(12)
 #define IRQ_UART3		S5P_IRQ_VIC1(13)
 #define IRQ_IIC			S5P_IRQ_VIC1(14)
+#define S5PV210_IRQ_I2C0	S5P_IRQ_VIC1(14)
 #define IRQ_SPI0		S5P_IRQ_VIC1(15)
 #define IRQ_SPI1		S5P_IRQ_VIC1(16)
 #define IRQ_SPI2		S5P_IRQ_VIC1(17)
 #define IRQ_IRDA		S5P_IRQ_VIC1(18)
-#define IRQ_CAN0		S5P_IRQ_VIC1(19)
+#define S5PV210_IRQ_I2C2	S5P_IRQ_VIC1(19)
 #define IRQ_CAN1		S5P_IRQ_VIC1(20)
 #define IRQ_HSIRX		S5P_IRQ_VIC1(21)
 #define IRQ_HSITX		S5P_IRQ_VIC1(22)
@@ -85,6 +86,7 @@
 #define IRQ_MIXER		S5P_IRQ_VIC2(11)
 #define IRQ_HDMI		S5P_IRQ_VIC2(12)
 #define IRQ_IIC1		S5P_IRQ_VIC2(13)
+#define S5PV210_IRQ_I2C1	S5P_IRQ_VIC2(13)
 #define IRQ_MFC			S5P_IRQ_VIC2(14)
 #define IRQ_TVENC		S5P_IRQ_VIC2(15)
 #define IRQ_I2S0		S5P_IRQ_VIC2(16)
@@ -121,8 +123,18 @@
 #define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
 #define S5P_EINT_BASE2		(IRQ_VIC_END + 1)
 
+#ifdef CONFIG_SAMSUNG_IRQ_GPIO
+/* GPIO interrupts */
+#define SAMSUNG_IRQ_GPIO_BASE	(IRQ_EINT(31) + 1)
+#define SAMSUNG_IRQ_GPIO_NR_GROUPS	(22)
+#define SAMSUNG_IRQ_GPIO_GROUP(x)	(SAMSUNG_IRQ_GPIO_BASE + ((x) * 8))
+#define SAMSUNG_IRQ_GPIO_END	(SAMSUNG_IRQ_GPIO_GROUP(SAMSUNG_IRQ_GPIO_NR_GROUPS) + 1)
+#else
+#define SAMSUNG_IRQ_GPIO_END	(IRQ_EINT(31) + 1)
+#endif
+
 /* Set the default NR_IRQS */
-#define NR_IRQS			(IRQ_EINT(31) + 1)
+#define NR_IRQS			(SAMSUNG_IRQ_GPIO_END)
 
 /* Compatibility */
 #define IRQ_LCD_FIFO		IRQ_LCD0
diff --git a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
index 49e029b..de0c899 100644
--- a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
@@ -31,13 +31,6 @@
 
 #define eint_irq_to_bit(irq)		(1 << (EINT_OFFSET(irq) & 0x7))
 
-/* values for S5P_EXTINT0 */
-#define S5P_EXTINT_LOWLEV		(0x00)
-#define S5P_EXTINT_HILEV		(0x01)
-#define S5P_EXTINT_FALLEDGE		(0x02)
-#define S5P_EXTINT_RISEEDGE		(0x03)
-#define S5P_EXTINT_BOTHEDGE		(0x04)
-
 #define EINT_MODE		S3C_GPIO_SFN(0xf)
 
 #define EINT_GPIO_0(x)		S5PV210_GPH0(x)
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index 75cb8c3..64660fd 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -98,11 +98,13 @@ static struct map_desc s5p_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(S5P_PA_TIMER),
 		.length		= SZ_16K,
 		.type		= MT_DEVICE,
+#if 0
 	}, {
 		.virtual	= (unsigned long)S5P_VA_GPIO,
 		.pfn		= __phys_to_pfn(S5P_PA_GPIO),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
+#endif
 	},
 };
 
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index 1482852..9eeacc6 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -14,7 +14,7 @@
 #define __ASM_PLAT_MAP_S5P_H __FILE__
 
 #define S5P_VA_CHIPID		S3C_ADDR(0x00700000)
-#define S5P_VA_GPIO		S3C_ADDR(0x00500000)
+//#define S5P_VA_GPIO		S3C_ADDR(0x00500000)
 #define S5P_VA_SYSTIMER		S3C_ADDR(0x01200000)
 #define S5P_VA_SROMC		S3C_ADDR(0x01100000)
 
diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
index f36cd33..04b4f65 100644
--- a/arch/arm/plat-s5p/irq-eint.c
+++ b/arch/arm/plat-s5p/irq-eint.c
@@ -25,30 +25,45 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
+#include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
 #include <mach/regs-gpio.h>
 
+#define CON_OFFSET(base)		((base) + 0xE00)
+#define MASK_OFFSET(base)		((base) + 0xF00)
+#define PEND_OFFSET(base)		((base) + 0xF40)
+
+#define REG_OFFSET(x)			((x) * 0x4)
+
 static inline void s5p_irq_eint_mask(unsigned int irq)
 {
-	u32 mask;
+	void __iomem *base = get_irq_data(irq);
+	u32 mask, offset;
 
-	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(irq)));
+	offset = REG_OFFSET(EINT_REG_NR(irq));
+	mask = __raw_readl(MASK_OFFSET(base) + offset);
 	mask |= eint_irq_to_bit(irq);
-	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(irq)));
+	__raw_writel(mask, MASK_OFFSET(base) + offset);
 }
 
 static void s5p_irq_eint_unmask(unsigned int irq)
 {
-	u32 mask;
+	void __iomem *base = get_irq_data(irq);
+	u32 mask, offset;
 
-	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(irq)));
+	offset = REG_OFFSET(EINT_REG_NR(irq));
+	mask = __raw_readl(MASK_OFFSET(base) + offset);
 	mask &= ~(eint_irq_to_bit(irq));
-	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(irq)));
+	__raw_writel(mask, MASK_OFFSET(base) + offset);
 }
 
 static inline void s5p_irq_eint_ack(unsigned int irq)
 {
-	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(EINT_REG_NR(irq)));
+	void __iomem *base = get_irq_data(irq);
+	u32 offset;
+
+	offset = REG_OFFSET(EINT_REG_NR(irq));
+	__raw_writel(eint_irq_to_bit(irq), PEND_OFFSET(base) + offset);
 }
 
 static void s5p_irq_eint_maskack(unsigned int irq)
@@ -60,30 +75,32 @@ static void s5p_irq_eint_maskack(unsigned int irq)
 
 static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
 {
+	void __iomem *base = get_irq_data(irq);
 	int offs = EINT_OFFSET(irq);
 	int shift;
 	u32 ctrl, mask;
 	u32 newvalue = 0;
+	u32 offset;
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
-		newvalue = S5P_EXTINT_RISEEDGE;
+		newvalue = S5P_GPIO_EDGE_RISING;
 		break;
 
 	case IRQ_TYPE_EDGE_FALLING:
-		newvalue = S5P_EXTINT_FALLEDGE;
+		newvalue = S5P_GPIO_EDGE_FALLING;
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
-		newvalue = S5P_EXTINT_BOTHEDGE;
+		newvalue = S5P_GPIO_EDGE_BOTH;
 		break;
 
 	case IRQ_TYPE_LEVEL_LOW:
-		newvalue = S5P_EXTINT_LOWLEV;
+		newvalue = GPIO_LEVEL_LOW;
 		break;
 
 	case IRQ_TYPE_LEVEL_HIGH:
-		newvalue = S5P_EXTINT_HILEV;
+		newvalue = GPIO_LEVEL_HIGH;
 		break;
 
 	default:
@@ -94,10 +111,11 @@ static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
 	shift = (offs & 0x7) * 4;
 	mask = 0x7 << shift;
 
-	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(irq)));
+	offset = REG_OFFSET(EINT_REG_NR(irq));
+	ctrl = __raw_readl(CON_OFFSET(base) + offset);
 	ctrl &= ~mask;
 	ctrl |= newvalue << shift;
-	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(irq)));
+	__raw_writel(ctrl, CON_OFFSET(base) + offset);
 
 	if ((0 <= offs) && (offs < 8))
 		s3c_gpio_cfgpin(EINT_GPIO_0(offs & 0x7), EINT_MODE);
@@ -118,7 +136,7 @@ static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
 }
 
 static struct irq_chip s5p_irq_eint = {
-	.name		= "s5p-eint",
+	.name		= "GPIO",
 	.mask		= s5p_irq_eint_mask,
 	.unmask		= s5p_irq_eint_unmask,
 	.mask_ack	= s5p_irq_eint_maskack,
@@ -137,30 +155,42 @@ static struct irq_chip s5p_irq_eint = {
  *
  * Each EINT pend/mask registers handle eight of them.
  */
-static inline void s5p_irq_demux_eint(unsigned int start)
+static inline void s5p_irq_demux_eint(unsigned int irq, unsigned int start)
 {
-	u32 status = __raw_readl(S5P_EINT_PEND(EINT_REG_NR(start)));
-	u32 mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(start)));
-	unsigned int irq;
+	/* The 'base' is virtual GPIO base */
+	void __iomem *base = get_irq_data(irq);
+	u32 offset;
+	u32 status, mask;
+	unsigned int n;
+
+	offset = REG_OFFSET(EINT_REG_NR(start));
+
+	status = __raw_readl(PEND_OFFSET(base) + offset);
+
+	/* No pending interrupt, just return */
+	if (!status)
+		return;
 
+	mask = __raw_readl(MASK_OFFSET(base) + offset);
 	status &= ~mask;
 	status &= 0xff;
 
 	while (status) {
-		irq = fls(status) - 1;
-		generic_handle_irq(irq + start);
-		status &= ~(1 << irq);
+		n = fls(status) - 1;
+		generic_handle_irq(n + start);
+		status &= ~BIT(n);
 	}
 }
 
 static void s5p_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 {
-	s5p_irq_demux_eint(IRQ_EINT(16));
-	s5p_irq_demux_eint(IRQ_EINT(24));
+	s5p_irq_demux_eint(irq, IRQ_EINT(16));
+	s5p_irq_demux_eint(irq, IRQ_EINT(24));
 }
 
 static inline void s5p_irq_vic_eint_mask(unsigned int irq)
 {
+	/* The 'base' is virtual VIC base */
 	void __iomem *base = get_irq_chip_data(irq);
 
 	s5p_irq_eint_mask(irq);
@@ -169,6 +199,7 @@ static inline void s5p_irq_vic_eint_mask(unsigned int irq)
 
 static void s5p_irq_vic_eint_unmask(unsigned int irq)
 {
+	/* The 'base' is virtual VIC base */
 	void __iomem *base = get_irq_chip_data(irq);
 
 	s5p_irq_eint_unmask(irq);
@@ -177,7 +208,12 @@ static void s5p_irq_vic_eint_unmask(unsigned int irq)
 
 static inline void s5p_irq_vic_eint_ack(unsigned int irq)
 {
-	__raw_writel(eint_irq_to_bit(irq), S5P_EINT_PEND(EINT_REG_NR(irq)));
+	/* The 'base' is virtual GPIO base */
+	void __iomem *base = get_irq_data(irq);
+	u32 offset;
+
+	offset = REG_OFFSET(EINT_REG_NR(irq));
+	__raw_writel(eint_irq_to_bit(irq), PEND_OFFSET(base) + offset);
 }
 
 static void s5p_irq_vic_eint_maskack(unsigned int irq)
@@ -187,7 +223,7 @@ static void s5p_irq_vic_eint_maskack(unsigned int irq)
 }
 
 static struct irq_chip s5p_irq_vic_eint = {
-	.name		= "s5p_vic_eint",
+	.name		= "VIC",
 	.mask		= s5p_irq_vic_eint_mask,
 	.unmask		= s5p_irq_vic_eint_unmask,
 	.mask_ack	= s5p_irq_vic_eint_maskack,
@@ -198,21 +234,27 @@ static struct irq_chip s5p_irq_vic_eint = {
 #endif
 };
 
-int __init s5p_init_irq_eint(void)
+/*
+ * Note that
+ * 	'get_irq_chip_data' returns the VIC base address
+ * 	'get_irq_data' returns the virtual GPIO base addres.
+ */
+void __init s5p_init_irq_eint(void __iomem *base)
 {
 	int irq;
 
-	for (irq = IRQ_EINT(0); irq <= IRQ_EINT(15); irq++)
+	for (irq = IRQ_EINT(0); irq <= IRQ_EINT(15); irq++) {
 		set_irq_chip(irq, &s5p_irq_vic_eint);
+		set_irq_data(irq, base);
+	}
 
 	for (irq = IRQ_EINT(16); irq <= IRQ_EINT(31); irq++) {
 		set_irq_chip(irq, &s5p_irq_eint);
+		set_irq_data(irq, base);
 		set_irq_handler(irq, handle_level_irq);
 		set_irq_flags(irq, IRQF_VALID);
 	}
 
 	set_irq_chained_handler(IRQ_EINT16_31, s5p_irq_demux_eint16_31);
-	return 0;
+	set_irq_data(IRQ_EINT16_31, base);
 }
-
-arch_initcall(s5p_init_irq_eint);
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index e358c7d..fde7a62 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -14,6 +14,17 @@
 #define GPIOCON_OFF	(0x00)
 #define GPIODAT_OFF	(0x04)
 
+#define GPIO_LEVEL_LOW			(0x00)
+#define GPIO_LEVEL_HIGH			(0x01)
+
+#define S3C_GPIO_EDGE_FALLING		(0x02)
+#define S3C_GPIO_EDGE_RISING		(0x04)
+#define S3C_GPIO_EDGE_BOTH		(0x06)
+
+#define S5P_GPIO_EDGE_FALLING		(0x02)
+#define S5P_GPIO_EDGE_RISING		(0x03)
+#define S5P_GPIO_EDGE_BOTH		(0x04)
+
 #define con_4bit_shift(__off) ((__off) * 4)
 
 /* Define the core gpiolib support functions that the s3c platforms may
@@ -45,6 +56,7 @@ struct s3c_gpio_cfg;
  * @base: The base pointer to the gpio configuration registers.
  * @config: special function and pull-resistor control information.
  * @lock: Lock for exclusive access to this gpio bank.
+ * @group: The interrupt group.
  * @pm_save: Save information for suspend/resume support.
  *
  * This wrapper provides the necessary information for the Samsung
@@ -64,6 +76,7 @@ struct s3c_gpio_chip {
 	struct s3c_gpio_pm	*pm;
 	void __iomem		*base;
 	spinlock_t		 lock;
+	int			group;
 #ifdef CONFIG_PM
 	u32			pm_save[4];
 #endif
@@ -118,6 +151,20 @@ extern void samsung_gpiolib_add_4bit2_chips(struct s3c_gpio_chip *chip,
 extern void samsung_gpiolib_add_4bit(struct s3c_gpio_chip *chip);
 extern void samsung_gpiolib_add_4bit2(struct s3c_gpio_chip *chip);
 
+#ifdef CONFIG_S5P_EXT_INT
+extern void s5p_init_irq_eint(void __iomem *base);
+#else
+#define s5p_init_irq_eint(base)			do { } while (0)
+#endif
+
+#ifdef CONFIG_SAMSUNG_IRQ_GPIO
+extern void samsung_irq_gpio_add(struct s3c_gpio_chip *chip);
+extern void samsung_irq_gpio_register(struct samsung_irq_gpio_info *gpios, int num);
+#else
+#define samsung_irq_gpio_add(x)			do { } while (0)
+#define samsung_irq_gpio_register(g, n)		do { } while (0)
+#endif
+
 /* exported for core SoC support to change */
 extern struct s3c_gpio_cfg s3c24xx_gpiocfg_default;
 
