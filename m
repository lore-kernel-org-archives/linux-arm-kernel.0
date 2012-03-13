From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 Mar 2012 08:30:39 -0700
Subject: [PATCH v3 08/12] ARM: EXYNOS: support EINT for EXYNOS4 and EXYNOS5
In-Reply-To: <1331652643-12626-1-git-send-email-kgene.kim@samsung.com>
References: <1331652643-12626-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1331652643-12626-9-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eunki Kim <eunki_kim@samsung.com>

The GPIOs of EXYNOS4 and EXYNOS5 are changed to use
ioremap instead of static mapping. It alse causes the
change of external interrupt IO mapping. This patch
changes EXYNOS4 to EXYNOS for common use and changes
EINT_x macros for supporting dynamic IO mapping.

Signed-off-by: Eunki Kim <eunki_kim@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/common.c                 |  102 ++++++++++++-------------
 arch/arm/mach-exynos/include/mach/gpio.h      |   29 +++++++
 arch/arm/mach-exynos/include/mach/regs-gpio.h |   20 ++---
 3 files changed, 86 insertions(+), 65 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 0b53018..72f21e4 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -665,6 +665,8 @@ static void __init exynos_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 		s3c24xx_init_uartdevs("exynos4210-uart", exynos4_uart_resources, cfg, no);
 }
 
+static void __iomem *exynos_eint_base;
+
 static DEFINE_SPINLOCK(eint_lock);
 
 static unsigned int eint0_15_data[16];
@@ -706,41 +708,41 @@ static unsigned int exynos5_eint0_15_src_int[16] = {
 	EXYNOS5_IRQ_EINT14,
 	EXYNOS5_IRQ_EINT15,
 };
-static inline void exynos4_irq_eint_mask(struct irq_data *data)
+static inline void exynos_irq_eint_mask(struct irq_data *data)
 {
 	u32 mask;
 
 	spin_lock(&eint_lock);
-	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(data->irq)));
-	mask |= eint_irq_to_bit(data->irq);
-	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(data->irq)));
+	mask = __raw_readl(EINT_MASK(exynos_eint_base, data->irq));
+	mask |= EINT_OFFSET_BIT(data->irq);
+	__raw_writel(mask, EINT_MASK(exynos_eint_base, data->irq));
 	spin_unlock(&eint_lock);
 }
 
-static void exynos4_irq_eint_unmask(struct irq_data *data)
+static void exynos_irq_eint_unmask(struct irq_data *data)
 {
 	u32 mask;
 
 	spin_lock(&eint_lock);
-	mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(data->irq)));
-	mask &= ~(eint_irq_to_bit(data->irq));
-	__raw_writel(mask, S5P_EINT_MASK(EINT_REG_NR(data->irq)));
+	mask = __raw_readl(EINT_MASK(exynos_eint_base, data->irq));
+	mask &= ~(EINT_OFFSET_BIT(data->irq));
+	__raw_writel(mask, EINT_MASK(exynos_eint_base, data->irq));
 	spin_unlock(&eint_lock);
 }
 
-static inline void exynos4_irq_eint_ack(struct irq_data *data)
+static inline void exynos_irq_eint_ack(struct irq_data *data)
 {
-	__raw_writel(eint_irq_to_bit(data->irq),
-		     S5P_EINT_PEND(EINT_REG_NR(data->irq)));
+	__raw_writel(EINT_OFFSET_BIT(data->irq),
+		     EINT_PEND(exynos_eint_base, data->irq));
 }
 
-static void exynos4_irq_eint_maskack(struct irq_data *data)
+static void exynos_irq_eint_maskack(struct irq_data *data)
 {
-	exynos4_irq_eint_mask(data);
-	exynos4_irq_eint_ack(data);
+	exynos_irq_eint_mask(data);
+	exynos_irq_eint_ack(data);
 }
 
-static int exynos4_irq_eint_set_type(struct irq_data *data, unsigned int type)
+static int exynos_irq_eint_set_type(struct irq_data *data, unsigned int type)
 {
 	int offs = EINT_OFFSET(data->irq);
 	int shift;
@@ -777,39 +779,24 @@ static int exynos4_irq_eint_set_type(struct irq_data *data, unsigned int type)
 	mask = 0x7 << shift;
 
 	spin_lock(&eint_lock);
-	ctrl = __raw_readl(S5P_EINT_CON(EINT_REG_NR(data->irq)));
+	ctrl = __raw_readl(EINT_CON(exynos_eint_base, data->irq));
 	ctrl &= ~mask;
 	ctrl |= newvalue << shift;
-	__raw_writel(ctrl, S5P_EINT_CON(EINT_REG_NR(data->irq)));
+	__raw_writel(ctrl, EINT_CON(exynos_eint_base, data->irq));
 	spin_unlock(&eint_lock);
 
-	switch (offs) {
-	case 0 ... 7:
-		s3c_gpio_cfgpin(EINT_GPIO_0(offs & 0x7), EINT_MODE);
-		break;
-	case 8 ... 15:
-		s3c_gpio_cfgpin(EINT_GPIO_1(offs & 0x7), EINT_MODE);
-		break;
-	case 16 ... 23:
-		s3c_gpio_cfgpin(EINT_GPIO_2(offs & 0x7), EINT_MODE);
-		break;
-	case 24 ... 31:
-		s3c_gpio_cfgpin(EINT_GPIO_3(offs & 0x7), EINT_MODE);
-		break;
-	default:
-		printk(KERN_ERR "No such irq number %d", offs);
-	}
+	s3c_gpio_cfgpin(irq_to_gpio(data->irq), S3C_GPIO_SFN(0xf));
 
 	return 0;
 }
 
-static struct irq_chip exynos4_irq_eint = {
-	.name		= "exynos4-eint",
-	.irq_mask	= exynos4_irq_eint_mask,
-	.irq_unmask	= exynos4_irq_eint_unmask,
-	.irq_mask_ack	= exynos4_irq_eint_maskack,
-	.irq_ack	= exynos4_irq_eint_ack,
-	.irq_set_type	= exynos4_irq_eint_set_type,
+static struct irq_chip exynos_irq_eint = {
+	.name		= "exynos-eint",
+	.irq_mask	= exynos_irq_eint_mask,
+	.irq_unmask	= exynos_irq_eint_unmask,
+	.irq_mask_ack	= exynos_irq_eint_maskack,
+	.irq_ack	= exynos_irq_eint_ack,
+	.irq_set_type	= exynos_irq_eint_set_type,
 #ifdef CONFIG_PM
 	.irq_set_wake	= s3c_irqext_wake,
 #endif
@@ -824,12 +811,12 @@ static struct irq_chip exynos4_irq_eint = {
  *
  * Each EINT pend/mask registers handle eight of them.
  */
-static inline void exynos4_irq_demux_eint(unsigned int start)
+static inline void exynos_irq_demux_eint(unsigned int start)
 {
 	unsigned int irq;
 
-	u32 status = __raw_readl(S5P_EINT_PEND(EINT_REG_NR(start)));
-	u32 mask = __raw_readl(S5P_EINT_MASK(EINT_REG_NR(start)));
+	u32 status = __raw_readl(EINT_PEND(exynos_eint_base, start));
+	u32 mask = __raw_readl(EINT_MASK(exynos_eint_base, start));
 
 	status &= ~mask;
 	status &= 0xff;
@@ -841,16 +828,16 @@ static inline void exynos4_irq_demux_eint(unsigned int start)
 	}
 }
 
-static void exynos4_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
+static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_get_chip(irq);
 	chained_irq_enter(chip, desc);
-	exynos4_irq_demux_eint(IRQ_EINT(16));
-	exynos4_irq_demux_eint(IRQ_EINT(24));
+	exynos_irq_demux_eint(IRQ_EINT(16));
+	exynos_irq_demux_eint(IRQ_EINT(24));
 	chained_irq_exit(chip, desc);
 }
 
-static void exynos4_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
+static void exynos_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 {
 	u32 *irq_data = irq_get_handler_data(irq);
 	struct irq_chip *chip = irq_get_chip(irq);
@@ -867,20 +854,27 @@ static void exynos4_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int __init exynos4_init_irq_eint(void)
+static int __init exynos_init_irq_eint(void)
 {
 	int irq;
 
 	if (soc_is_exynos5250())
-		return 0;
+		exynos_eint_base = ioremap(EXYNOS5_PA_GPIO1, SZ_4K);
+	else
+		exynos_eint_base = ioremap(EXYNOS4_PA_GPIO2, SZ_4K);
+
+	if (exynos_eint_base == NULL) {
+		pr_err("unable to ioremap for EINT base address\n");
+		return -ENOMEM;
+	}
 
 	for (irq = 0 ; irq <= 31 ; irq++) {
-		irq_set_chip_and_handler(IRQ_EINT(irq), &exynos4_irq_eint,
+		irq_set_chip_and_handler(IRQ_EINT(irq), &exynos_irq_eint,
 					 handle_level_irq);
 		set_irq_flags(IRQ_EINT(irq), IRQF_VALID);
 	}
 
-	irq_set_chained_handler(EXYNOS_IRQ_EINT16_31, exynos4_irq_demux_eint16_31);
+	irq_set_chained_handler(EXYNOS_IRQ_EINT16_31, exynos_irq_demux_eint16_31);
 
 	for (irq = 0 ; irq <= 15 ; irq++) {
 		eint0_15_data[irq] = IRQ_EINT(irq);
@@ -889,15 +883,15 @@ static int __init exynos4_init_irq_eint(void)
 			irq_set_handler_data(exynos4_eint0_15_src_int[irq],
 					     &eint0_15_data[irq]);
 			irq_set_chained_handler(exynos4_eint0_15_src_int[irq],
-						exynos4_irq_eint0_15);
+						exynos_irq_eint0_15);
 		} else {
 			irq_set_handler_data(exynos5_eint0_15_src_int[irq],
 					     &eint0_15_data[irq]);
 			irq_set_chained_handler(exynos5_eint0_15_src_int[irq],
-					exynos4_irq_eint0_15);
+					exynos_irq_eint0_15);
 		}
 	}
 
 	return 0;
 }
-arch_initcall(exynos4_init_irq_eint);
+arch_initcall(exynos_init_irq_eint);
diff --git a/arch/arm/mach-exynos/include/mach/gpio.h b/arch/arm/mach-exynos/include/mach/gpio.h
index 80523ca..c09deb6 100644
--- a/arch/arm/mach-exynos/include/mach/gpio.h
+++ b/arch/arm/mach-exynos/include/mach/gpio.h
@@ -146,4 +146,33 @@ enum s5p_gpio_number {
 #define ARCH_NR_GPIOS		(EXYNOS4_GPZ(EXYNOS4_GPIO_Z_NR) +	\
 				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
 
+#include <linux/types.h>
+#include <linux/err.h>
+#include <mach/irqs.h>
+#include <plat/cpu.h>
+
+static inline int irq_to_gpio(unsigned int irq)
+{
+	if (irq < IRQ_EINT(0))
+		return -EINVAL;
+
+	irq -= IRQ_EINT(0);
+	if (irq < 8)
+		return soc_is_exynos5250() ?  EXYNOS5_GPX0(irq) :
+					 EXYNOS4_GPX0(irq);
+	irq -= 8;
+	if (irq < 8)
+		return soc_is_exynos5250() ?  EXYNOS5_GPX1(irq) :
+					 EXYNOS4_GPX1(irq);
+	irq -= 8;
+	if (irq < 8)
+		return soc_is_exynos5250() ?  EXYNOS5_GPX2(irq) :
+					 EXYNOS4_GPX2(irq);
+	irq -= 8;
+	if (irq < 8)
+		return soc_is_exynos5250() ?  EXYNOS5_GPX3(irq) :
+					 EXYNOS4_GPX3(irq);
+	return -EINVAL;
+}
+
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-exynos/include/mach/regs-gpio.h b/arch/arm/mach-exynos/include/mach/regs-gpio.h
index 1401b21..e4b5b60 100644
--- a/arch/arm/mach-exynos/include/mach/regs-gpio.h
+++ b/arch/arm/mach-exynos/include/mach/regs-gpio.h
@@ -16,6 +16,15 @@
 #include <mach/map.h>
 #include <mach/irqs.h>
 
+#define EINT_REG_NR(x)			(EINT_OFFSET(x) >> 3)
+#define EINT_CON(b, x)			(b + 0xE00 + (EINT_REG_NR(x) * 4))
+#define EINT_FLTCON(b, x)		(b + 0xE80 + (EINT_REG_NR(x) * 4))
+#define EINT_MASK(b, x)			(b + 0xF00 + (EINT_REG_NR(x) * 4))
+#define EINT_PEND(b, x)			(b + 0xF40 + (EINT_REG_NR(x) * 4))
+
+#define EINT_OFFSET_BIT(x)		(1 << (EINT_OFFSET(x) & 0x7))
+
+/* compatibility for plat-s5p/irq-pm.c */
 #define EXYNOS4_EINT40CON		(S5P_VA_GPIO2 + 0xE00)
 #define S5P_EINT_CON(x)			(EXYNOS4_EINT40CON + ((x) * 0x4))
 
@@ -28,15 +37,4 @@
 #define EXYNOS4_EINT40PEND		(S5P_VA_GPIO2 + 0xF40)
 #define S5P_EINT_PEND(x)		(EXYNOS4_EINT40PEND + ((x) * 0x4))
 
-#define EINT_REG_NR(x)			(EINT_OFFSET(x) >> 3)
-
-#define eint_irq_to_bit(irq)		(1 << (EINT_OFFSET(irq) & 0x7))
-
-#define EINT_MODE			S3C_GPIO_SFN(0xf)
-
-#define EINT_GPIO_0(x)			EXYNOS4_GPX0(x)
-#define EINT_GPIO_1(x)			EXYNOS4_GPX1(x)
-#define EINT_GPIO_2(x)			EXYNOS4_GPX2(x)
-#define EINT_GPIO_3(x)			EXYNOS4_GPX3(x)
-
 #endif /* __ASM_ARCH_REGS_GPIO_H */
-- 
1.7.4.4
