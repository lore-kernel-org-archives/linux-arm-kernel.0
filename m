From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 03:03:40 +0100
Subject: [PATCH 09/16] ARM: ep93xx: Switch over to gpiolib ->to_irq() and
	__gpio_to_irq().
In-Reply-To: <cover.1292377339.git.buytenh@wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
Message-ID: <20101215020340.GB15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-ep93xx/gpio.c              |   31 +++++++++++++++++++++--------
 arch/arm/mach-ep93xx/include/mach/gpio.h |    8 +++---
 arch/arm/mach-ep93xx/include/mach/irqs.h |    4 +++
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-ep93xx/gpio.c b/arch/arm/mach-ep93xx/gpio.c
index cf547ad..d2b8d77 100644
--- a/arch/arm/mach-ep93xx/gpio.c
+++ b/arch/arm/mach-ep93xx/gpio.c
@@ -258,6 +258,7 @@ struct ep93xx_gpio_chip {
 
 	void __iomem		*data_reg;
 	void __iomem		*data_dir_reg;
+	int			base_irq;
 };
 
 #define to_ep93xx_gpio_chip(c) container_of(c, struct ep93xx_gpio_chip, chip)
@@ -335,6 +336,16 @@ static void ep93xx_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
 	local_irq_restore(flags);
 }
 
+static int ep93xx_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct ep93xx_gpio_chip *ep93xx_chip = to_ep93xx_gpio_chip(chip);
+
+	if (ep93xx_chip->base_irq != NO_IRQ)
+		return ep93xx_chip->base_irq + offset;
+
+	return -EINVAL;
+}
+
 static void ep93xx_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 {
 	struct ep93xx_gpio_chip *ep93xx_chip = to_ep93xx_gpio_chip(chip);
@@ -396,7 +407,7 @@ static void ep93xx_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	}
 }
 
-#define EP93XX_GPIO_BANK(name, dr, ddr, base_gpio)			\
+#define EP93XX_GPIO_BANK(name, dr, ddr, base_gpio, _base_irq)		\
 	{								\
 		.chip = {						\
 			.label		  = name,			\
@@ -404,23 +415,25 @@ static void ep93xx_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 			.direction_output = ep93xx_gpio_direction_output, \
 			.get		  = ep93xx_gpio_get,		\
 			.set		  = ep93xx_gpio_set,		\
+			.to_irq		  = ep93xx_gpio_to_irq,		\
 			.dbg_show	  = ep93xx_gpio_dbg_show,	\
 			.base		  = base_gpio,			\
 			.ngpio		  = 8,				\
 		},							\
 		.data_reg	= EP93XX_GPIO_REG(dr),			\
 		.data_dir_reg	= EP93XX_GPIO_REG(ddr),			\
+		.base_irq	= _base_irq,				\
 	}
 
 static struct ep93xx_gpio_chip ep93xx_gpio_banks[] = {
-	EP93XX_GPIO_BANK("A", 0x00, 0x10, 0),
-	EP93XX_GPIO_BANK("B", 0x04, 0x14, 8),
-	EP93XX_GPIO_BANK("C", 0x08, 0x18, 40),
-	EP93XX_GPIO_BANK("D", 0x0c, 0x1c, 24),
-	EP93XX_GPIO_BANK("E", 0x20, 0x24, 32),
-	EP93XX_GPIO_BANK("F", 0x30, 0x34, 16),
-	EP93XX_GPIO_BANK("G", 0x38, 0x3c, 48),
-	EP93XX_GPIO_BANK("H", 0x40, 0x44, 56),
+	EP93XX_GPIO_BANK("A", 0x00, 0x10,  0, IRQ_EP93XX_GPIO_A),
+	EP93XX_GPIO_BANK("B", 0x04, 0x14,  8, IRQ_EP93XX_GPIO_B),
+	EP93XX_GPIO_BANK("C", 0x08, 0x18, 40, NO_IRQ),
+	EP93XX_GPIO_BANK("D", 0x0c, 0x1c, 24, NO_IRQ),
+	EP93XX_GPIO_BANK("E", 0x20, 0x24, 32, NO_IRQ),
+	EP93XX_GPIO_BANK("F", 0x30, 0x34, 16, IRQ_EP93XX_GPIO_F),
+	EP93XX_GPIO_BANK("G", 0x38, 0x3c, 48, NO_IRQ),
+	EP93XX_GPIO_BANK("H", 0x40, 0x44, 56, NO_IRQ),
 };
 
 void __init ep93xx_gpio_init(void)
diff --git a/arch/arm/mach-ep93xx/include/mach/gpio.h b/arch/arm/mach-ep93xx/include/mach/gpio.h
index c991b14..a43d992 100644
--- a/arch/arm/mach-ep93xx/include/mach/gpio.h
+++ b/arch/arm/mach-ep93xx/include/mach/gpio.h
@@ -5,6 +5,8 @@
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H
 
+#include <mach/irqs.h>
+
 /* GPIO port A.  */
 #define EP93XX_GPIO_LINE_A(x)		((x) + 0)
 #define EP93XX_GPIO_LINE_EGPIO0		EP93XX_GPIO_LINE_A(0)
@@ -108,15 +110,13 @@ extern void ep93xx_gpio_int_debounce(unsigned int irq, int enable);
 #define gpio_get_value	__gpio_get_value
 #define gpio_set_value	__gpio_set_value
 #define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
 
 /*
  * Map GPIO A0..A7  (0..7)  to irq 64..71,
  *          B0..B7  (7..15) to irq 72..79, and
  *          F0..F7 (16..24) to irq 80..87.
  */
-#define gpio_to_irq(gpio)	\
-	(((gpio) <= EP93XX_GPIO_LINE_MAX_IRQ) ? (64 + (gpio)) : -EINVAL)
-
-#define irq_to_gpio(irq)	((irq) - gpio_to_irq(0))
+#define irq_to_gpio(irq)	((irq) - IRQ_EP93XX_GPIO_A)
 
 #endif
diff --git a/arch/arm/mach-ep93xx/include/mach/irqs.h b/arch/arm/mach-ep93xx/include/mach/irqs.h
index ff98390..ee95ac5 100644
--- a/arch/arm/mach-ep93xx/include/mach/irqs.h
+++ b/arch/arm/mach-ep93xx/include/mach/irqs.h
@@ -67,6 +67,10 @@
 #define IRQ_EP93XX_SAI			60
 #define EP93XX_VIC2_VALID_IRQ_MASK	0x1fffffff
 
+#define IRQ_EP93XX_GPIO_A		64
+#define IRQ_EP93XX_GPIO_B		72
+#define IRQ_EP93XX_GPIO_F		80
+
 #define NR_EP93XX_IRQS			(64 + 24)
 
 #define EP93XX_BOARD_IRQ(x)		(NR_EP93XX_IRQS + (x))
-- 
1.7.1
