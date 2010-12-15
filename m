From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 03:02:33 +0100
Subject: [PATCH 02/16] ARM: Remove dependency of plat-orion GPIO code on mach
	directory includes.
In-Reply-To: <cover.1292377339.git.buytenh@wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
Message-ID: <20101215020233.GU15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the various mach dirs that use the plat-orion GPIO
code pass in GPIO-related platform info (GPIO controller base address,
secondary base IRQ number, etc) explicitly, instead of having
plat-orion get those values by including a mach dir include file --
the latter mechanism is problematic if you want to support multiple
ARM platforms in the same kernel image.

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-dove/include/mach/dove.h         |    3 +-
 arch/arm/mach-dove/include/mach/gpio.h         |   40 --
 arch/arm/mach-dove/irq.c                       |   27 +-
 arch/arm/mach-kirkwood/include/mach/gpio.h     |   29 --
 arch/arm/mach-kirkwood/include/mach/kirkwood.h |    2 +
 arch/arm/mach-kirkwood/irq.c                   |   22 +-
 arch/arm/mach-kirkwood/mpp.c                   |    3 -
 arch/arm/mach-mv78xx0/include/mach/gpio.h      |   31 --
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h   |    1 +
 arch/arm/mach-mv78xx0/irq.c                    |   22 +-
 arch/arm/mach-mv78xx0/mpp.c                    |    3 -
 arch/arm/mach-orion5x/include/mach/gpio.h      |   28 --
 arch/arm/mach-orion5x/include/mach/orion5x.h   |    1 +
 arch/arm/mach-orion5x/irq.c                    |   19 +-
 arch/arm/mach-orion5x/mpp.c                    |    3 -
 arch/arm/plat-orion/gpio.c                     |  475 ++++++++++++++++--------
 arch/arm/plat-orion/include/plat/gpio.h        |    5 +-
 17 files changed, 354 insertions(+), 360 deletions(-)

diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-dove/include/mach/dove.h
index f6a0839..df51131 100644
--- a/arch/arm/mach-dove/include/mach/dove.h
+++ b/arch/arm/mach-dove/include/mach/dove.h
@@ -130,7 +130,8 @@
 #define DOVE_PMU_MPP_GENERAL_CTRL (DOVE_MPP_VIRT_BASE + 0x10)
 #define DOVE_RESET_SAMPLE_LO	(DOVE_MPP_VIRT_BASE | 0x014)
 #define DOVE_RESET_SAMPLE_HI	(DOVE_MPP_VIRT_BASE | 0x018)
-#define DOVE_GPIO_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xd0400)
+#define DOVE_GPIO_LO_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xd0400)
+#define DOVE_GPIO_HI_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xd0420)
 #define DOVE_MPP_GENERAL_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xe803c)
 #define  DOVE_AU1_SPDIFO_GPIO_EN	(1 << 1)
 #define  DOVE_NAND_GPIO_EN		(1 << 0)
diff --git a/arch/arm/mach-dove/include/mach/gpio.h b/arch/arm/mach-dove/include/mach/gpio.h
index 0ee70ff..e7e5101 100644
--- a/arch/arm/mach-dove/include/mach/gpio.h
+++ b/arch/arm/mach-dove/include/mach/gpio.h
@@ -6,44 +6,4 @@
  * warranty of any kind, whether express or implied.
  */
 
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H
-
-#include <asm/errno.h>
-#include <mach/irqs.h>
 #include <plat/gpio.h>
-#include <asm-generic/gpio.h>		/* cansleep wrappers */
-
-#define GPIO_MAX	64
-
-#define GPIO_BASE_LO		(DOVE_GPIO_VIRT_BASE + 0x00)
-#define GPIO_BASE_HI		(DOVE_GPIO_VIRT_BASE + 0x20)
-
-#define GPIO_BASE(pin)		((pin < 32) ? GPIO_BASE_LO : GPIO_BASE_HI)
-
-#define GPIO_OUT(pin)		(GPIO_BASE(pin) + 0x00)
-#define GPIO_IO_CONF(pin)	(GPIO_BASE(pin) + 0x04)
-#define GPIO_BLINK_EN(pin)	(GPIO_BASE(pin) + 0x08)
-#define GPIO_IN_POL(pin)	(GPIO_BASE(pin) + 0x0c)
-#define GPIO_DATA_IN(pin)	(GPIO_BASE(pin) + 0x10)
-#define GPIO_EDGE_CAUSE(pin)	(GPIO_BASE(pin) + 0x14)
-#define GPIO_EDGE_MASK(pin)	(GPIO_BASE(pin) + 0x18)
-#define GPIO_LEVEL_MASK(pin)	(GPIO_BASE(pin) + 0x1c)
-
-static inline int gpio_to_irq(int pin)
-{
-	if (pin < NR_GPIO_IRQS)
-		return pin + IRQ_DOVE_GPIO_START;
-
-	return -EINVAL;
-}
-
-static inline int irq_to_gpio(int irq)
-{
-	if (IRQ_DOVE_GPIO_START < irq && irq < NR_IRQS)
-		return irq - IRQ_DOVE_GPIO_START;
-
-	return -EINVAL;
-}
-
-#endif
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index 61bfcb3..a6e9c63 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -99,11 +99,18 @@ void __init dove_init_irq(void)
 	orion_irq_init(32, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF));
 
 	/*
-	 * Mask and clear GPIO IRQ interrupts.
+	 * Initialize gpiolib for GPIOs 0-63.
 	 */
-	writel(0, GPIO_LEVEL_MASK(0));
-	writel(0, GPIO_EDGE_MASK(0));
-	writel(0, GPIO_EDGE_CAUSE(0));
+	orion_gpio_init(0, 32, DOVE_GPIO_LO_VIRT_BASE, 0,
+			IRQ_DOVE_GPIO_START);
+	set_irq_chained_handler(IRQ_DOVE_GPIO_0_7, gpio_irq_handler);
+	set_irq_chained_handler(IRQ_DOVE_GPIO_8_15, gpio_irq_handler);
+	set_irq_chained_handler(IRQ_DOVE_GPIO_16_23, gpio_irq_handler);
+	set_irq_chained_handler(IRQ_DOVE_GPIO_24_31, gpio_irq_handler);
+
+	orion_gpio_init(32, 32, DOVE_GPIO_HI_VIRT_BASE, 0,
+			IRQ_DOVE_GPIO_START + 32);
+	set_irq_chained_handler(IRQ_DOVE_HIGH_GPIO, gpio_irq_handler);
 
 	/*
 	 * Mask and clear PMU interrupts
@@ -111,18 +118,6 @@ void __init dove_init_irq(void)
 	writel(0, PMU_INTERRUPT_MASK);
 	writel(0, PMU_INTERRUPT_CAUSE);
 
-	for (i = IRQ_DOVE_GPIO_START; i < IRQ_DOVE_PMU_START; i++) {
-		set_irq_chip(i, &orion_gpio_irq_chip);
-		set_irq_handler(i, handle_level_irq);
-		irq_desc[i].status |= IRQ_LEVEL;
-		set_irq_flags(i, IRQF_VALID);
-	}
-	set_irq_chained_handler(IRQ_DOVE_GPIO_0_7, gpio_irq_handler);
-	set_irq_chained_handler(IRQ_DOVE_GPIO_8_15, gpio_irq_handler);
-	set_irq_chained_handler(IRQ_DOVE_GPIO_16_23, gpio_irq_handler);
-	set_irq_chained_handler(IRQ_DOVE_GPIO_24_31, gpio_irq_handler);
-	set_irq_chained_handler(IRQ_DOVE_HIGH_GPIO, gpio_irq_handler);
-
 	for (i = IRQ_DOVE_PMU_START; i < NR_IRQS; i++) {
 		set_irq_chip(i, &pmu_irq_chip);
 		set_irq_handler(i, handle_level_irq);
diff --git a/arch/arm/mach-kirkwood/include/mach/gpio.h b/arch/arm/mach-kirkwood/include/mach/gpio.h
index 81b335e..84f340b 100644
--- a/arch/arm/mach-kirkwood/include/mach/gpio.h
+++ b/arch/arm/mach-kirkwood/include/mach/gpio.h
@@ -6,33 +6,4 @@
  * warranty of any kind, whether express or implied.
  */
 
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H
-
-#include <mach/irqs.h>
 #include <plat/gpio.h>
-#include <asm-generic/gpio.h>		/* cansleep wrappers */
-
-#define GPIO_MAX		50
-#define GPIO_OFF(pin)		(((pin) >> 5) ? 0x0140 : 0x0100)
-#define GPIO_OUT(pin)		(DEV_BUS_VIRT_BASE + GPIO_OFF(pin) + 0x00)
-#define GPIO_IO_CONF(pin)	(DEV_BUS_VIRT_BASE + GPIO_OFF(pin) + 0x04)
-#define GPIO_BLINK_EN(pin)	(DEV_BUS_VIRT_BASE + GPIO_OFF(pin) + 0x08)
-#define GPIO_IN_POL(pin)	(DEV_BUS_VIRT_BASE + GPIO_OFF(pin) + 0x0c)
-#define GPIO_DATA_IN(pin)	(DEV_BUS_VIRT_BASE + GPIO_OFF(pin) + 0x10)
-#define GPIO_EDGE_CAUSE(pin)	(DEV_BUS_VIRT_BASE + GPIO_OFF(pin) + 0x14)
-#define GPIO_EDGE_MASK(pin)	(DEV_BUS_VIRT_BASE + GPIO_OFF(pin) + 0x18)
-#define GPIO_LEVEL_MASK(pin)	(DEV_BUS_VIRT_BASE + GPIO_OFF(pin) + 0x1c)
-
-static inline int gpio_to_irq(int pin)
-{
-	return pin + IRQ_KIRKWOOD_GPIO_START;
-}
-
-static inline int irq_to_gpio(int irq)
-{
-	return irq - IRQ_KIRKWOOD_GPIO_START;
-}
-
-
-#endif
diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
index 6e924b3..010bdeb 100644
--- a/arch/arm/mach-kirkwood/include/mach/kirkwood.h
+++ b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
@@ -69,6 +69,8 @@
 #define DEV_BUS_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE | 0x10000)
 #define  SAMPLE_AT_RESET	(DEV_BUS_VIRT_BASE | 0x0030)
 #define  DEVICE_ID		(DEV_BUS_VIRT_BASE | 0x0034)
+#define  GPIO_LOW_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x0100)
+#define  GPIO_HIGH_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x0140)
 #define  RTC_PHYS_BASE		(DEV_BUS_PHYS_BASE | 0x0300)
 #define  SPI_PHYS_BASE		(DEV_BUS_PHYS_BASE | 0x0600)
 #define  I2C_PHYS_BASE		(DEV_BUS_PHYS_BASE | 0x1000)
diff --git a/arch/arm/mach-kirkwood/irq.c b/arch/arm/mach-kirkwood/irq.c
index 28020ab..cbdb586 100644
--- a/arch/arm/mach-kirkwood/irq.c
+++ b/arch/arm/mach-kirkwood/irq.c
@@ -27,31 +27,21 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 void __init kirkwood_init_irq(void)
 {
-	int i;
-
 	orion_irq_init(0, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF));
 	orion_irq_init(32, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF));
 
 	/*
-	 * Mask and clear GPIO IRQ interrupts.
+	 * Initialize gpiolib for GPIOs 0-49.
 	 */
-	writel(0, GPIO_LEVEL_MASK(0));
-	writel(0, GPIO_EDGE_MASK(0));
-	writel(0, GPIO_EDGE_CAUSE(0));
-	writel(0, GPIO_LEVEL_MASK(32));
-	writel(0, GPIO_EDGE_MASK(32));
-	writel(0, GPIO_EDGE_CAUSE(32));
-
-	for (i = IRQ_KIRKWOOD_GPIO_START; i < NR_IRQS; i++) {
-		set_irq_chip(i, &orion_gpio_irq_chip);
-		set_irq_handler(i, handle_level_irq);
-		irq_desc[i].status |= IRQ_LEVEL;
-		set_irq_flags(i, IRQF_VALID);
-	}
+	orion_gpio_init(0, 32, GPIO_LOW_VIRT_BASE, 0,
+			IRQ_KIRKWOOD_GPIO_START);
 	set_irq_chained_handler(IRQ_KIRKWOOD_GPIO_LOW_0_7, gpio_irq_handler);
 	set_irq_chained_handler(IRQ_KIRKWOOD_GPIO_LOW_8_15, gpio_irq_handler);
 	set_irq_chained_handler(IRQ_KIRKWOOD_GPIO_LOW_16_23, gpio_irq_handler);
 	set_irq_chained_handler(IRQ_KIRKWOOD_GPIO_LOW_24_31, gpio_irq_handler);
+
+	orion_gpio_init(32, 18, GPIO_HIGH_VIRT_BASE, 0,
+			IRQ_KIRKWOOD_GPIO_START + 32);
 	set_irq_chained_handler(IRQ_KIRKWOOD_GPIO_HIGH_0_7, gpio_irq_handler);
 	set_irq_chained_handler(IRQ_KIRKWOOD_GPIO_HIGH_8_15, gpio_irq_handler);
 	set_irq_chained_handler(IRQ_KIRKWOOD_GPIO_HIGH_16_23, gpio_irq_handler);
diff --git a/arch/arm/mach-kirkwood/mpp.c b/arch/arm/mach-kirkwood/mpp.c
index 27901f7..7ce2018 100644
--- a/arch/arm/mach-kirkwood/mpp.c
+++ b/arch/arm/mach-kirkwood/mpp.c
@@ -49,9 +49,6 @@ void __init kirkwood_mpp_conf(unsigned int *mpp_list)
 	if (!variant_mask)
 		return;
 
-	/* Initialize gpiolib. */
-	orion_gpio_init();
-
 	printk(KERN_DEBUG "initial MPP regs:");
 	for (i = 0; i < MPP_NR_REGS; i++) {
 		mpp_ctrl[i] = readl(MPP_CTRL(i));
diff --git a/arch/arm/mach-mv78xx0/include/mach/gpio.h b/arch/arm/mach-mv78xx0/include/mach/gpio.h
index d9d1535..77e1b84 100644
--- a/arch/arm/mach-mv78xx0/include/mach/gpio.h
+++ b/arch/arm/mach-mv78xx0/include/mach/gpio.h
@@ -6,35 +6,4 @@
  * warranty of any kind, whether express or implied.
  */
 
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H
-
-#include <mach/irqs.h>
 #include <plat/gpio.h>
-#include <asm-generic/gpio.h>		/* cansleep wrappers */
-
-extern int mv78xx0_core_index(void);
-
-#define GPIO_MAX		32
-#define GPIO_OUT(pin)		(DEV_BUS_VIRT_BASE + 0x0100)
-#define GPIO_IO_CONF(pin)	(DEV_BUS_VIRT_BASE + 0x0104)
-#define GPIO_BLINK_EN(pin)	(DEV_BUS_VIRT_BASE + 0x0108)
-#define GPIO_IN_POL(pin)	(DEV_BUS_VIRT_BASE + 0x010c)
-#define GPIO_DATA_IN(pin)	(DEV_BUS_VIRT_BASE + 0x0110)
-#define GPIO_EDGE_CAUSE(pin)	(DEV_BUS_VIRT_BASE + 0x0114)
-#define GPIO_MASK_OFF		(mv78xx0_core_index() ? 0x18 : 0)
-#define GPIO_EDGE_MASK(pin)	(DEV_BUS_VIRT_BASE + 0x0118 + GPIO_MASK_OFF)
-#define GPIO_LEVEL_MASK(pin)	(DEV_BUS_VIRT_BASE + 0x011c + GPIO_MASK_OFF)
-
-static inline int gpio_to_irq(int pin)
-{
-	return pin + IRQ_MV78XX0_GPIO_START;
-}
-
-static inline int irq_to_gpio(int irq)
-{
-	return irq - IRQ_MV78XX0_GPIO_START;
-}
-
-
-#endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
index 788bdac..e02506e 100644
--- a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
+++ b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
@@ -71,6 +71,7 @@
 #define DEV_BUS_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE | 0x10000)
 #define  SAMPLE_AT_RESET_LOW	(DEV_BUS_VIRT_BASE | 0x0030)
 #define  SAMPLE_AT_RESET_HIGH	(DEV_BUS_VIRT_BASE | 0x0034)
+#define  GPIO_VIRT_BASE		(DEV_BUS_VIRT_BASE | 0x0100)
 #define  I2C_0_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x1000)
 #define  I2C_1_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x1100)
 #define  UART0_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x2000)
diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
index 22b4ff8..08da497 100644
--- a/arch/arm/mach-mv78xx0/irq.c
+++ b/arch/arm/mach-mv78xx0/irq.c
@@ -26,28 +26,18 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 void __init mv78xx0_init_irq(void)
 {
-	int i;
-
-	/* Initialize gpiolib. */
-	orion_gpio_init();
-
 	orion_irq_init(0, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF));
 	orion_irq_init(32, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF));
 	orion_irq_init(64, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_ERR_OFF));
 
 	/*
-	 * Mask and clear GPIO IRQ interrupts.
+	 * Initialize gpiolib for GPIOs 0-31.  (The GPIO interrupt mask
+	 * registers for core #1 are at an offset of 0x18 from those of
+	 * core #0.)
 	 */
-	writel(0, GPIO_LEVEL_MASK(0));
-	writel(0, GPIO_EDGE_MASK(0));
-	writel(0, GPIO_EDGE_CAUSE(0));
-
-	for (i = IRQ_MV78XX0_GPIO_START; i < NR_IRQS; i++) {
-		set_irq_chip(i, &orion_gpio_irq_chip);
-		set_irq_handler(i, handle_level_irq);
-		irq_desc[i].status |= IRQ_LEVEL;
-		set_irq_flags(i, IRQF_VALID);
-	}
+	orion_gpio_init(0, 32, GPIO_VIRT_BASE,
+			mv78xx0_core_index() ? 0x18 : 0,
+			IRQ_MV78XX0_GPIO_START);
 	set_irq_chained_handler(IRQ_MV78XX0_GPIO_0_7, gpio_irq_handler);
 	set_irq_chained_handler(IRQ_MV78XX0_GPIO_8_15, gpio_irq_handler);
 	set_irq_chained_handler(IRQ_MV78XX0_GPIO_16_23, gpio_irq_handler);
diff --git a/arch/arm/mach-mv78xx0/mpp.c b/arch/arm/mach-mv78xx0/mpp.c
index 84db2df..65b72c4 100644
--- a/arch/arm/mach-mv78xx0/mpp.c
+++ b/arch/arm/mach-mv78xx0/mpp.c
@@ -44,9 +44,6 @@ void __init mv78xx0_mpp_conf(unsigned int *mpp_list)
 	if (!variant_mask)
 		return;
 
-	/* Initialize gpiolib. */
-	orion_gpio_init();
-
 	printk(KERN_DEBUG "initial MPP regs:");
 	for (i = 0; i < MPP_NR_REGS; i++) {
 		mpp_ctrl[i] = readl(MPP_CTRL(i));
diff --git a/arch/arm/mach-orion5x/include/mach/gpio.h b/arch/arm/mach-orion5x/include/mach/gpio.h
index d8182e8..a1d0b78 100644
--- a/arch/arm/mach-orion5x/include/mach/gpio.h
+++ b/arch/arm/mach-orion5x/include/mach/gpio.h
@@ -6,32 +6,4 @@
  * warranty of any kind, whether express or implied.
  */
 
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H
-
-#include <mach/irqs.h>
 #include <plat/gpio.h>
-#include <asm-generic/gpio.h>		/* cansleep wrappers */
-
-#define GPIO_MAX		32
-#define GPIO_OUT(pin)		ORION5X_DEV_BUS_REG(0x100)
-#define GPIO_IO_CONF(pin)	ORION5X_DEV_BUS_REG(0x104)
-#define GPIO_BLINK_EN(pin)	ORION5X_DEV_BUS_REG(0x108)
-#define GPIO_IN_POL(pin)	ORION5X_DEV_BUS_REG(0x10c)
-#define GPIO_DATA_IN(pin)	ORION5X_DEV_BUS_REG(0x110)
-#define GPIO_EDGE_CAUSE(pin)	ORION5X_DEV_BUS_REG(0x114)
-#define GPIO_EDGE_MASK(pin)	ORION5X_DEV_BUS_REG(0x118)
-#define GPIO_LEVEL_MASK(pin)	ORION5X_DEV_BUS_REG(0x11c)
-
-static inline int gpio_to_irq(int pin)
-{
-	return pin + IRQ_ORION5X_GPIO_START;
-}
-
-static inline int irq_to_gpio(int irq)
-{
-	return irq - IRQ_ORION5X_GPIO_START;
-}
-
-
-#endif
diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach-orion5x/include/mach/orion5x.h
index 2d87665..0a28bbc 100644
--- a/arch/arm/mach-orion5x/include/mach/orion5x.h
+++ b/arch/arm/mach-orion5x/include/mach/orion5x.h
@@ -73,6 +73,7 @@
 #define ORION5X_DEV_BUS_PHYS_BASE	(ORION5X_REGS_PHYS_BASE | 0x10000)
 #define ORION5X_DEV_BUS_VIRT_BASE	(ORION5X_REGS_VIRT_BASE | 0x10000)
 #define ORION5X_DEV_BUS_REG(x)		(ORION5X_DEV_BUS_VIRT_BASE | (x))
+#define  GPIO_VIRT_BASE			ORION5X_DEV_BUS_REG(0x0100)
 #define  SPI_PHYS_BASE			(ORION5X_DEV_BUS_PHYS_BASE | 0x0600)
 #define  I2C_PHYS_BASE			(ORION5X_DEV_BUS_PHYS_BASE | 0x1000)
 #define  UART0_PHYS_BASE		(ORION5X_DEV_BUS_PHYS_BASE | 0x2000)
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index d7512b9..ed85891 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -28,27 +28,12 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 void __init orion5x_init_irq(void)
 {
-	int i;
-
 	orion_irq_init(0, (void __iomem *)MAIN_IRQ_MASK);
 
 	/*
-	 * Mask and clear GPIO IRQ interrupts
-	 */
-	writel(0x0, GPIO_LEVEL_MASK(0));
-	writel(0x0, GPIO_EDGE_MASK(0));
-	writel(0x0, GPIO_EDGE_CAUSE(0));
-
-	/*
-	 * Register chained level handlers for GPIO IRQs by default.
-	 * User can use set_type() if he wants to use edge types handlers.
+	 * Initialize gpiolib for GPIOs 0-31.
 	 */
-	for (i = IRQ_ORION5X_GPIO_START; i < NR_IRQS; i++) {
-		set_irq_chip(i, &orion_gpio_irq_chip);
-		set_irq_handler(i, handle_level_irq);
-		irq_desc[i].status |= IRQ_LEVEL;
-		set_irq_flags(i, IRQF_VALID);
-	}
+	orion_gpio_init(0, 32, GPIO_VIRT_BASE, 0, IRQ_ORION5X_GPIO_START);
 	set_irq_chained_handler(IRQ_ORION5X_GPIO_0_7, gpio_irq_handler);
 	set_irq_chained_handler(IRQ_ORION5X_GPIO_8_15, gpio_irq_handler);
 	set_irq_chained_handler(IRQ_ORION5X_GPIO_16_23, gpio_irq_handler);
diff --git a/arch/arm/mach-orion5x/mpp.c b/arch/arm/mach-orion5x/mpp.c
index db485d3..2288207 100644
--- a/arch/arm/mach-orion5x/mpp.c
+++ b/arch/arm/mach-orion5x/mpp.c
@@ -124,9 +124,6 @@ void __init orion5x_mpp_conf(struct orion5x_mpp_mode *mode)
 	u32 mpp_8_15_ctrl = readl(MPP_8_15_CTRL);
 	u32 mpp_16_19_ctrl = readl(MPP_16_19_CTRL);
 
-	/* Initialize gpiolib. */
-	orion_gpio_init();
-
 	for ( ; mode->mpp >= 0; mode++) {
 		u32 *reg;
 		int num_type;
diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index e814803..078894b 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -17,55 +17,123 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
-static DEFINE_SPINLOCK(gpio_lock);
-static unsigned long gpio_valid_input[BITS_TO_LONGS(GPIO_MAX)];
-static unsigned long gpio_valid_output[BITS_TO_LONGS(GPIO_MAX)];
+/*
+ * GPIO unit register offsets.
+ */
+#define GPIO_OUT_OFF		0x0000
+#define GPIO_IO_CONF_OFF	0x0004
+#define GPIO_BLINK_EN_OFF	0x0008
+#define GPIO_IN_POL_OFF		0x000c
+#define GPIO_DATA_IN_OFF	0x0010
+#define GPIO_EDGE_CAUSE_OFF	0x0014
+#define GPIO_EDGE_MASK_OFF	0x0018
+#define GPIO_LEVEL_MASK_OFF	0x001c
+
+struct orion_gpio_chip {
+	struct gpio_chip	chip;
+	spinlock_t		lock;
+	void __iomem		*base;
+	unsigned long		valid_input;
+	unsigned long		valid_output;
+	int			mask_offset;
+	int			secondary_irq_base;
+};
+
+static void __iomem *GPIO_OUT(struct orion_gpio_chip *ochip)
+{
+	return ochip->base + GPIO_OUT_OFF;
+}
+
+static void __iomem *GPIO_IO_CONF(struct orion_gpio_chip *ochip)
+{
+	return ochip->base + GPIO_IO_CONF_OFF;
+}
 
-static inline void __set_direction(unsigned pin, int input)
+static void __iomem *GPIO_BLINK_EN(struct orion_gpio_chip *ochip)
+{
+	return ochip->base + GPIO_BLINK_EN_OFF;
+}
+
+static void __iomem *GPIO_IN_POL(struct orion_gpio_chip *ochip)
+{
+	return ochip->base + GPIO_IN_POL_OFF;
+}
+
+static void __iomem *GPIO_DATA_IN(struct orion_gpio_chip *ochip)
+{
+	return ochip->base + GPIO_DATA_IN_OFF;
+}
+
+static void __iomem *GPIO_EDGE_CAUSE(struct orion_gpio_chip *ochip)
+{
+	return ochip->base + GPIO_EDGE_CAUSE_OFF;
+}
+
+static void __iomem *GPIO_EDGE_MASK(struct orion_gpio_chip *ochip)
+{
+	return ochip->base + ochip->mask_offset + GPIO_EDGE_MASK_OFF;
+}
+
+static void __iomem *GPIO_LEVEL_MASK(struct orion_gpio_chip *ochip)
+{
+	return ochip->base + ochip->mask_offset + GPIO_LEVEL_MASK_OFF;
+}
+
+
+static struct orion_gpio_chip orion_gpio_chips[2];
+static int orion_gpio_chip_count;
+
+static inline void
+__set_direction(struct orion_gpio_chip *ochip, unsigned pin, int input)
 {
 	u32 u;
 
-	u = readl(GPIO_IO_CONF(pin));
+	u = readl(GPIO_IO_CONF(ochip));
 	if (input)
-		u |= 1 << (pin & 31);
+		u |= 1 << pin;
 	else
-		u &= ~(1 << (pin & 31));
-	writel(u, GPIO_IO_CONF(pin));
+		u &= ~(1 << pin);
+	writel(u, GPIO_IO_CONF(ochip));
 }
 
-static void __set_level(unsigned pin, int high)
+static void __set_level(struct orion_gpio_chip *ochip, unsigned pin, int high)
 {
 	u32 u;
 
-	u = readl(GPIO_OUT(pin));
+	u = readl(GPIO_OUT(ochip));
 	if (high)
-		u |= 1 << (pin & 31);
+		u |= 1 << pin;
 	else
-		u &= ~(1 << (pin & 31));
-	writel(u, GPIO_OUT(pin));
+		u &= ~(1 << pin);
+	writel(u, GPIO_OUT(ochip));
 }
 
-static inline void __set_blinking(unsigned pin, int blink)
+static inline void
+__set_blinking(struct orion_gpio_chip *ochip, unsigned pin, int blink)
 {
 	u32 u;
 
-	u = readl(GPIO_BLINK_EN(pin));
+	u = readl(GPIO_BLINK_EN(ochip));
 	if (blink)
-		u |= 1 << (pin & 31);
+		u |= 1 << pin;
 	else
-		u &= ~(1 << (pin & 31));
-	writel(u, GPIO_BLINK_EN(pin));
+		u &= ~(1 << pin);
+	writel(u, GPIO_BLINK_EN(ochip));
 }
 
-static inline int orion_gpio_is_valid(unsigned pin, int mode)
+static inline int
+orion_gpio_is_valid(struct orion_gpio_chip *ochip, unsigned pin, int mode)
 {
-	if (pin < GPIO_MAX) {
-		if ((mode & GPIO_INPUT_OK) && !test_bit(pin, gpio_valid_input))
-			goto err_out;
-		if ((mode & GPIO_OUTPUT_OK) && !test_bit(pin, gpio_valid_output))
-			goto err_out;
-		return true;
-	}
+	if (pin >= ochip->chip.ngpio)
+		goto err_out;
+
+	if ((mode & GPIO_INPUT_OK) && !test_bit(pin, &ochip->valid_input))
+		goto err_out;
+
+	if ((mode & GPIO_OUTPUT_OK) && !test_bit(pin, &ochip->valid_output))
+		goto err_out;
+
+	return 1;
 
 err_out:
 	pr_debug("%s: invalid GPIO %d\n", __func__, pin);
@@ -75,134 +143,155 @@ err_out:
 /*
  * GENERIC_GPIO primitives.
  */
+static int orion_gpio_request(struct gpio_chip *chip, unsigned pin)
+{
+	struct orion_gpio_chip *ochip =
+		container_of(chip, struct orion_gpio_chip, chip);
+
+	if (orion_gpio_is_valid(ochip, pin, GPIO_INPUT_OK) ||
+	    orion_gpio_is_valid(ochip, pin, GPIO_OUTPUT_OK))
+		return 0;
+
+	return -EINVAL;
+}
+
 static int orion_gpio_direction_input(struct gpio_chip *chip, unsigned pin)
 {
+	struct orion_gpio_chip *ochip =
+		container_of(chip, struct orion_gpio_chip, chip);
 	unsigned long flags;
 
-	if (!orion_gpio_is_valid(pin, GPIO_INPUT_OK))
+	if (!orion_gpio_is_valid(ochip, pin, GPIO_INPUT_OK))
 		return -EINVAL;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-
-	/* Configure GPIO direction. */
-	__set_direction(pin, 1);
-
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	spin_lock_irqsave(&ochip->lock, flags);
+	__set_direction(ochip, pin, 1);
+	spin_unlock_irqrestore(&ochip->lock, flags);
 
 	return 0;
 }
 
-static int orion_gpio_get_value(struct gpio_chip *chip, unsigned pin)
+static int orion_gpio_get(struct gpio_chip *chip, unsigned pin)
 {
+	struct orion_gpio_chip *ochip =
+		container_of(chip, struct orion_gpio_chip, chip);
 	int val;
 
-	if (readl(GPIO_IO_CONF(pin)) & (1 << (pin & 31)))
-		val = readl(GPIO_DATA_IN(pin)) ^ readl(GPIO_IN_POL(pin));
-	else
-		val = readl(GPIO_OUT(pin));
+	if (readl(GPIO_IO_CONF(ochip)) & (1 << pin)) {
+		val = readl(GPIO_DATA_IN(ochip)) ^ readl(GPIO_IN_POL(ochip));
+	} else {
+		val = readl(GPIO_OUT(ochip));
+	}
 
-	return (val >> (pin & 31)) & 1;
+	return (val >> pin) & 1;
 }
 
-static int orion_gpio_direction_output(struct gpio_chip *chip, unsigned pin,
-	int value)
+static int
+orion_gpio_direction_output(struct gpio_chip *chip, unsigned pin, int value)
 {
+	struct orion_gpio_chip *ochip =
+		container_of(chip, struct orion_gpio_chip, chip);
 	unsigned long flags;
 
-	if (!orion_gpio_is_valid(pin, GPIO_OUTPUT_OK))
+	if (!orion_gpio_is_valid(ochip, pin, GPIO_OUTPUT_OK))
 		return -EINVAL;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-
-	/* Disable blinking. */
-	__set_blinking(pin, 0);
-
-	/* Configure GPIO output value. */
-	__set_level(pin, value);
-
-	/* Configure GPIO direction. */
-	__set_direction(pin, 0);
-
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	spin_lock_irqsave(&ochip->lock, flags);
+	__set_blinking(ochip, pin, 0);
+	__set_level(ochip, pin, value);
+	__set_direction(ochip, pin, 0);
+	spin_unlock_irqrestore(&ochip->lock, flags);
 
 	return 0;
 }
 
-static void orion_gpio_set_value(struct gpio_chip *chip, unsigned pin,
-	int value)
+static void orion_gpio_set(struct gpio_chip *chip, unsigned pin, int value)
 {
+	struct orion_gpio_chip *ochip =
+		container_of(chip, struct orion_gpio_chip, chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-
-	/* Configure GPIO output value. */
-	__set_level(pin, value);
-
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	spin_lock_irqsave(&ochip->lock, flags);
+	__set_level(ochip, pin, value);
+	spin_unlock_irqrestore(&ochip->lock, flags);
 }
 
-static int orion_gpio_request(struct gpio_chip *chip, unsigned pin)
+static int orion_gpio_to_irq(struct gpio_chip *chip, unsigned pin)
 {
-	if (orion_gpio_is_valid(pin, GPIO_INPUT_OK) ||
-	    orion_gpio_is_valid(pin, GPIO_OUTPUT_OK))
-		return 0;
-	return -EINVAL;
-}
+	struct orion_gpio_chip *ochip =
+		container_of(chip, struct orion_gpio_chip, chip);
 
-static struct gpio_chip orion_gpiochip = {
-	.label			= "orion_gpio",
-	.direction_input	= orion_gpio_direction_input,
-	.get			= orion_gpio_get_value,
-	.direction_output	= orion_gpio_direction_output,
-	.set			= orion_gpio_set_value,
-	.request		= orion_gpio_request,
-	.base			= 0,
-	.ngpio			= GPIO_MAX,
-	.can_sleep		= 0,
-};
-
-void __init orion_gpio_init(void)
-{
-	gpiochip_add(&orion_gpiochip);
+	return ochip->secondary_irq_base + pin;
 }
 
+
 /*
  * Orion-specific GPIO API extensions.
  */
+static struct orion_gpio_chip *orion_gpio_chip_find(int pin)
+{
+	int i;
+
+	for (i = 0; i < orion_gpio_chip_count; i++) {
+		struct orion_gpio_chip *ochip = orion_gpio_chips + i;
+		struct gpio_chip *chip = &ochip->chip;
+
+		if (pin >= chip->base && pin < chip->base + chip->ngpio)
+			return ochip;
+	}
+
+	return NULL;
+}
+
 void __init orion_gpio_set_unused(unsigned pin)
 {
+	struct orion_gpio_chip *ochip = orion_gpio_chip_find(pin);
+
+	if (ochip == NULL)
+		return;
+
+	pin -= ochip->chip.base;
+
 	/* Configure as output, drive low. */
-	__set_level(pin, 0);
-	__set_direction(pin, 0);
+	__set_level(ochip, pin, 0);
+	__set_direction(ochip, pin, 0);
 }
 
 void __init orion_gpio_set_valid(unsigned pin, int mode)
 {
+	struct orion_gpio_chip *ochip = orion_gpio_chip_find(pin);
+
+	if (ochip == NULL)
+		return;
+
+	pin -= ochip->chip.base;
+
 	if (mode == 1)
 		mode = GPIO_INPUT_OK | GPIO_OUTPUT_OK;
+
 	if (mode & GPIO_INPUT_OK)
-		__set_bit(pin, gpio_valid_input);
+		__set_bit(pin, &ochip->valid_input);
 	else
-		__clear_bit(pin, gpio_valid_input);
+		__clear_bit(pin, &ochip->valid_input);
+
 	if (mode & GPIO_OUTPUT_OK)
-		__set_bit(pin, gpio_valid_output);
+		__set_bit(pin, &ochip->valid_output);
 	else
-		__clear_bit(pin, gpio_valid_output);
+		__clear_bit(pin, &ochip->valid_output);
 }
 
 void orion_gpio_set_blink(unsigned pin, int blink)
 {
+	struct orion_gpio_chip *ochip = orion_gpio_chip_find(pin);
 	unsigned long flags;
 
-	spin_lock_irqsave(&gpio_lock, flags);
-
-	/* Set output value to zero. */
-	__set_level(pin, 0);
+	if (ochip == NULL)
+		return;
 
-	/* Set blinking. */
-	__set_blinking(pin, blink);
-
-	spin_unlock_irqrestore(&gpio_lock, flags);
+	spin_lock_irqsave(&ochip->lock, flags);
+	__set_level(ochip, pin, 0);
+	__set_blinking(ochip, pin, blink);
+	spin_unlock_irqrestore(&ochip->lock, flags);
 }
 EXPORT_SYMBOL(orion_gpio_set_blink);
 
@@ -232,62 +321,80 @@ EXPORT_SYMBOL(orion_gpio_set_blink);
  *        polarity    LEVEL          mask
  *
  ****************************************************************************/
-
-static void gpio_irq_ack(u32 irq)
+static void gpio_irq_ack(struct irq_data *d)
 {
-	int type = irq_desc[irq].status & IRQ_TYPE_SENSE_MASK;
+	struct orion_gpio_chip *ochip = irq_data_get_irq_chip_data(d);
+	int type;
+
+	type = irq_desc[d->irq].status & IRQ_TYPE_SENSE_MASK;
 	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)) {
-		int pin = irq_to_gpio(irq);
-		writel(~(1 << (pin & 31)), GPIO_EDGE_CAUSE(pin));
+		int pin = d->irq - ochip->secondary_irq_base;
+
+		writel(~(1 << pin), GPIO_EDGE_CAUSE(ochip));
 	}
 }
 
-static void gpio_irq_mask(u32 irq)
+static void gpio_irq_mask(struct irq_data *d)
 {
-	int pin = irq_to_gpio(irq);
-	int type = irq_desc[irq].status & IRQ_TYPE_SENSE_MASK;
-	u32 reg = (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)) ?
-		GPIO_EDGE_MASK(pin) : GPIO_LEVEL_MASK(pin);
-	u32 u = readl(reg);
-	u &= ~(1 << (pin & 31));
-	writel(u, reg);
+	struct orion_gpio_chip *ochip = irq_data_get_irq_chip_data(d);
+	int type;
+	void __iomem *reg;
+	int pin;
+
+	type = irq_desc[d->irq].status & IRQ_TYPE_SENSE_MASK;
+	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
+		reg = GPIO_EDGE_MASK(ochip);
+	else
+		reg = GPIO_LEVEL_MASK(ochip);
+
+	pin = d->irq - ochip->secondary_irq_base;
+
+	writel(readl(reg) & ~(1 << pin), reg);
 }
 
-static void gpio_irq_unmask(u32 irq)
+static void gpio_irq_unmask(struct irq_data *d)
 {
-	int pin = irq_to_gpio(irq);
-	int type = irq_desc[irq].status & IRQ_TYPE_SENSE_MASK;
-	u32 reg = (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)) ?
-		GPIO_EDGE_MASK(pin) : GPIO_LEVEL_MASK(pin);
-	u32 u = readl(reg);
-	u |= 1 << (pin & 31);
-	writel(u, reg);
+	struct orion_gpio_chip *ochip = irq_data_get_irq_chip_data(d);
+	int type;
+	void __iomem *reg;
+	int pin;
+
+	type = irq_desc[d->irq].status & IRQ_TYPE_SENSE_MASK;
+	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
+		reg = GPIO_EDGE_MASK(ochip);
+	else
+		reg = GPIO_LEVEL_MASK(ochip);
+
+	pin = d->irq - ochip->secondary_irq_base;
+
+	writel(readl(reg) | (1 << pin), reg);
 }
 
-static int gpio_irq_set_type(u32 irq, u32 type)
+static int gpio_irq_set_type(struct irq_data *d, u32 type)
 {
-	int pin = irq_to_gpio(irq);
-	struct irq_desc *desc;
+	struct orion_gpio_chip *ochip = irq_data_get_irq_chip_data(d);
+	int pin;
 	u32 u;
 
-	u = readl(GPIO_IO_CONF(pin)) & (1 << (pin & 31));
+	pin = d->irq - ochip->secondary_irq_base;
+
+	u = readl(GPIO_IO_CONF(ochip)) & (1 << pin);
 	if (!u) {
 		printk(KERN_ERR "orion gpio_irq_set_type failed "
-				"(irq %d, pin %d).\n", irq, pin);
+				"(irq %d, pin %d).\n", d->irq, pin);
 		return -EINVAL;
 	}
 
-	desc = irq_desc + irq;
-
 	/*
 	 * Set edge/level type.
 	 */
 	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)) {
-		desc->handle_irq = handle_edge_irq;
+		set_irq_handler(d->irq, handle_edge_irq);
 	} else if (type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW)) {
-		desc->handle_irq = handle_level_irq;
+		set_irq_handler(d->irq, handle_level_irq);
 	} else {
-		printk(KERN_ERR "failed to set irq=%d (type=%d)\n", irq, type);
+		printk(KERN_ERR "failed to set irq=%d (type=%d)\n",
+		       d->irq, type);
 		return -EINVAL;
 	}
 
@@ -295,65 +402,121 @@ static int gpio_irq_set_type(u32 irq, u32 type)
 	 * Configure interrupt polarity.
 	 */
 	if (type == IRQ_TYPE_EDGE_RISING || type == IRQ_TYPE_LEVEL_HIGH) {
-		u = readl(GPIO_IN_POL(pin));
-		u &= ~(1 << (pin & 31));
-		writel(u, GPIO_IN_POL(pin));
+		u = readl(GPIO_IN_POL(ochip));
+		u &= ~(1 << pin);
+		writel(u, GPIO_IN_POL(ochip));
 	} else if (type == IRQ_TYPE_EDGE_FALLING || type == IRQ_TYPE_LEVEL_LOW) {
-		u = readl(GPIO_IN_POL(pin));
-		u |= 1 << (pin & 31);
-		writel(u, GPIO_IN_POL(pin));
+		u = readl(GPIO_IN_POL(ochip));
+		u |= 1 << pin;
+		writel(u, GPIO_IN_POL(ochip));
 	} else if (type == IRQ_TYPE_EDGE_BOTH) {
 		u32 v;
 
-		v = readl(GPIO_IN_POL(pin)) ^ readl(GPIO_DATA_IN(pin));
+		v = readl(GPIO_IN_POL(ochip)) ^ readl(GPIO_DATA_IN(ochip));
 
 		/*
 		 * set initial polarity based on current input level
 		 */
-		u = readl(GPIO_IN_POL(pin));
-		if (v & (1 << (pin & 31)))
-			u |= 1 << (pin & 31);		/* falling */
+		u = readl(GPIO_IN_POL(ochip));
+		if (v & (1 << pin))
+			u |= 1 << pin;		/* falling */
 		else
-			u &= ~(1 << (pin & 31));	/* rising */
-		writel(u, GPIO_IN_POL(pin));
+			u &= ~(1 << pin);	/* rising */
+		writel(u, GPIO_IN_POL(ochip));
 	}
 
-	desc->status = (desc->status & ~IRQ_TYPE_SENSE_MASK) | type;
-
 	return 0;
 }
 
 struct irq_chip orion_gpio_irq_chip = {
 	.name		= "orion_gpio_irq",
-	.ack		= gpio_irq_ack,
-	.mask		= gpio_irq_mask,
-	.unmask		= gpio_irq_unmask,
-	.set_type	= gpio_irq_set_type,
+	.irq_ack	= gpio_irq_ack,
+	.irq_mask	= gpio_irq_mask,
+	.irq_unmask	= gpio_irq_unmask,
+	.irq_set_type	= gpio_irq_set_type,
 };
 
+void __init orion_gpio_init(int gpio_base, int ngpio,
+			    u32 base, int mask_offset, int secondary_irq_base)
+{
+	struct orion_gpio_chip *ochip;
+	int i;
+
+	if (orion_gpio_chip_count == ARRAY_SIZE(orion_gpio_chips))
+		return;
+
+	ochip = orion_gpio_chips + orion_gpio_chip_count;
+	ochip->chip.label = "orion_gpio";
+	ochip->chip.request = orion_gpio_request;
+	ochip->chip.direction_input = orion_gpio_direction_input;
+	ochip->chip.get = orion_gpio_get;
+	ochip->chip.direction_output = orion_gpio_direction_output;
+	ochip->chip.set = orion_gpio_set;
+	ochip->chip.to_irq = orion_gpio_to_irq;
+	ochip->chip.base = gpio_base;
+	ochip->chip.ngpio = ngpio;
+	ochip->chip.can_sleep = 0;
+	spin_lock_init(&ochip->lock);
+	ochip->base = (void __iomem *)base;
+	ochip->valid_input = 0;
+	ochip->valid_output = 0;
+	ochip->mask_offset = mask_offset;
+	ochip->secondary_irq_base = secondary_irq_base;
+
+	gpiochip_add(&ochip->chip);
+
+	orion_gpio_chip_count++;
+
+	/*
+	 * Mask and clear GPIO interrupts.
+	 */
+	writel(0, GPIO_EDGE_CAUSE(ochip));
+	writel(0, GPIO_EDGE_MASK(ochip));
+	writel(0, GPIO_LEVEL_MASK(ochip));
+
+	for (i = 0; i < ngpio; i++) {
+		unsigned int irq = secondary_irq_base + i;
+
+		set_irq_chip(irq, &orion_gpio_irq_chip);
+		set_irq_handler(irq, handle_level_irq);
+		set_irq_chip_data(irq, ochip);
+		irq_desc[irq].status |= IRQ_LEVEL;
+		set_irq_flags(irq, IRQF_VALID);
+	}
+}
+
 void orion_gpio_irq_handler(int pinoff)
 {
+	struct orion_gpio_chip *ochip;
 	u32 cause;
-	int pin;
+	int i;
 
-	cause = readl(GPIO_DATA_IN(pinoff)) & readl(GPIO_LEVEL_MASK(pinoff));
-	cause |= readl(GPIO_EDGE_CAUSE(pinoff)) & readl(GPIO_EDGE_MASK(pinoff));
+	ochip = orion_gpio_chip_find(pinoff);
+	if (ochip == NULL)
+		return;
 
-	for (pin = pinoff; pin < pinoff + 8; pin++) {
-		int irq = gpio_to_irq(pin);
-		struct irq_desc *desc = irq_desc + irq;
+	cause = readl(GPIO_DATA_IN(ochip)) & readl(GPIO_LEVEL_MASK(ochip));
+	cause |= readl(GPIO_EDGE_CAUSE(ochip)) & readl(GPIO_EDGE_MASK(ochip));
 
-		if (!(cause & (1 << (pin & 31))))
+	for (i = 0; i < ochip->chip.ngpio; i++) {
+		int irq;
+		struct irq_desc *desc;
+
+		irq = ochip->secondary_irq_base + i;
+
+		if (!(cause & (1 << i)))
 			continue;
 
+		desc = irq_desc + irq;
 		if ((desc->status & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
 			/* Swap polarity (race with GPIO line) */
 			u32 polarity;
 
-			polarity = readl(GPIO_IN_POL(pin));
-			polarity ^= 1 << (pin & 31);
-			writel(polarity, GPIO_IN_POL(pin));
+			polarity = readl(GPIO_IN_POL(ochip));
+			polarity ^= 1 << i;
+			writel(polarity, GPIO_IN_POL(ochip));
 		}
+
 		desc_handle_irq(irq, desc);
 	}
 }
diff --git a/arch/arm/plat-orion/include/plat/gpio.h b/arch/arm/plat-orion/include/plat/gpio.h
index 07c430f..5578b98 100644
--- a/arch/arm/plat-orion/include/plat/gpio.h
+++ b/arch/arm/plat-orion/include/plat/gpio.h
@@ -12,6 +12,7 @@
 #define __PLAT_GPIO_H
 
 #include <linux/init.h>
+#include <asm-generic/gpio.h>
 
 /*
  * GENERIC_GPIO primitives.
@@ -19,6 +20,7 @@
 #define gpio_get_value  __gpio_get_value
 #define gpio_set_value  __gpio_set_value
 #define gpio_cansleep   __gpio_cansleep
+#define gpio_to_irq     __gpio_to_irq
 
 /*
  * Orion-specific GPIO API extensions.
@@ -31,7 +33,8 @@ void orion_gpio_set_blink(unsigned pin, int blink);
 void orion_gpio_set_valid(unsigned pin, int mode);
 
 /* Initialize gpiolib. */
-void __init orion_gpio_init(void);
+void __init orion_gpio_init(int gpio_base, int ngpio,
+			    u32 base, int mask_offset, int secondary_irq_base);
 
 /*
  * GPIO interrupt handling.
-- 
1.7.1
