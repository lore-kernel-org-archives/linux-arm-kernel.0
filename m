From: leochen@broadcom.com (Leo Chen)
Date: Fri, 9 Oct 2009 10:21:31 -0700
Subject: [PATCH] bcmring: add gpio support
Message-ID: <mailman.64.1255122785.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add gpio.c and gpio_irq.c

Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
---
 arch/arm/mach-bcmring/gpio.c     |  291 +++++++++++++++++++++++++++++
 arch/arm/mach-bcmring/gpio_irq.c |  381 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 672 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-bcmring/gpio.c
 create mode 100644 arch/arm/mach-bcmring/gpio_irq.c

diff --git a/arch/arm/mach-bcmring/gpio.c b/arch/arm/mach-bcmring/gpio.c
new file mode 100644
index 0000000..161e519
--- /dev/null
+++ b/arch/arm/mach-bcmring/gpio.c
@@ -0,0 +1,291 @@
+/*****************************************************************************
+* Copyright 2004 - 2008 Broadcom Corporation.  All rights reserved.
+*
+* Unless you and Broadcom execute a separate written software license
+* agreement governing use of this software, this software is licensed to you
+* under the terms of the GNU General Public License version 2, available at
+* http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
+*
+* Notwithstanding the above, under no circumstances may you combine this
+* software in any way with any other Broadcom software provided under a
+* license other than the GPL, without Broadcom's express prior written
+* consent.
+*****************************************************************************/
+
+/****************************************************************************
+*
+*  gpio.c
+*
+*  PURPOSE:
+*
+*       This file implements the GPIO chips required to support the onchip
+*       gpio pins, as per gpiolib
+*
+*****************************************************************************/
+
+/* ---- Include Files ---------------------------------------------------- */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/seq_file.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+
+#include <mach/gpio_defs.h>
+#include <mach/csp/gpiomux.h>
+#include <mach/csp/chipcHw_inline.h>
+
+/* ---- Public Variables ------------------------------------------------- */
+
+/* ---- Private Constants and Types -------------------------------------- */
+
+typedef struct {
+	struct gpio_chip chip;
+	volatile GPIOHW_REG_t *reg;
+
+} bcmring_gpio_chip;
+
+/* ---- Private Function Prototypes -------------------------------------- */
+
+/* ---- Private Variables ------------------------------------------------ */
+
+/* ---- Functions -------------------------------------------------------- */
+
+/****************************************************************************
+*
+*  Called whenever gpio_request is called. This will force the pin to be
+*  a GPIO pin. If you want it to be something else, then gpiomux_request
+*  should be called instead.
+*
+*****************************************************************************/
+
+static int gpio_bcmring_request(struct gpio_chip *chip, unsigned offset)
+{
+	unsigned gpio;
+	bcmring_gpio_chip *bcmring_chip =
+	    container_of(chip, bcmring_gpio_chip, chip);
+
+	gpio = bcmring_chip->chip.base + offset;
+
+	/*
+	 * Ensure that the pin is actually configured as a GPIO. If it isn't then
+	 * that means that somebody called chipcHW_setGpioPinFunction directly
+	 * which is a no-no.
+	 */
+
+	if (chipcHw_getGpioPinFunction(gpio) != chipcHw_GPIO_FUNCTION_GPIO) {
+		printk(KERN_ERR
+		       "%s: Error - gpio %d not configured as a GPIO pin\n",
+		       __FUNCTION__, gpio);
+		return -EBUSY;
+	}
+
+	return 0;
+
+}				/* gpio_bcmring_request */
+
+/****************************************************************************
+*
+*  Configure a GPIO pin as an input pin
+*
+*****************************************************************************/
+
+static int gpio_bcmring_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	bcmring_gpio_chip *bcmring_chip =
+	    container_of(chip, bcmring_gpio_chip, chip);
+
+	GpioHwReg_SetDirInput(bcmring_chip->reg, offset);
+
+	return 0;
+
+}				/* gpio_bcmring_direction_input */
+
+/****************************************************************************
+*
+*  Configure a GPIO pin as an output pin and sets its initial value.
+*
+*****************************************************************************/
+
+static int gpio_bcmring_direction_output(struct gpio_chip *chip,
+					 unsigned offset, int value)
+{
+	bcmring_gpio_chip *bcmring_chip =
+	    container_of(chip, bcmring_gpio_chip, chip);
+
+	GpioHwReg_SetValDirOutput(bcmring_chip->reg, offset, value);
+
+	return 0;
+
+}				/* gpio_bcmring_direction_output */
+
+/****************************************************************************
+*
+*  Retrieve the value of a GPIO pin. Note that this returns zero or the raw
+*   value.
+*
+*****************************************************************************/
+
+static int gpio_bcmring_get(struct gpio_chip *chip, unsigned offset)
+{
+	bcmring_gpio_chip *bcmring_chip =
+	    container_of(chip, bcmring_gpio_chip, chip);
+	int val;
+
+	val = GpioHwReg_GetVal(bcmring_chip->reg, offset);
+
+	return val;
+
+}				/* gpio_bcmring_get */
+
+/****************************************************************************
+*
+*  Set the value of a GPIO pin
+*
+*****************************************************************************/
+
+static void gpio_bcmring_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	bcmring_gpio_chip *bcmring_chip =
+	    container_of(chip, bcmring_gpio_chip, chip);
+
+	GpioHwReg_SetVal(bcmring_chip->reg, offset, value);
+
+}				/* gpio_bcmring_set */
+
+/****************************************************************************
+*
+*  gpiolib chip description
+*
+*****************************************************************************/
+
+/*
+ * Note: If you need to add a field, like a register base, then create a new
+ *       structure which includes the gpio_chip as the first element and has
+ *       the custom fields after. See asm-arm/arch-pxa/gpio.c for an example.
+ */
+
+static bcmring_gpio_chip gpio_bcmring_chip[] = {
+	[0] = {
+	       .reg = gpioRegP(0),
+	       .chip = {
+			.label = "bcmring-low",
+			.request = gpio_bcmring_request,
+			.direction_input = gpio_bcmring_direction_input,
+			.direction_output = gpio_bcmring_direction_output,
+			.get = gpio_bcmring_get,
+			.set = gpio_bcmring_set,
+			.base = 0,
+			.ngpio = GPIOHW_NUM_PINS_LOWER_BLOCK,
+			},
+	       },
+	[1] = {
+	       .reg = gpioRegP(1),
+	       .chip = {
+			.label = "bcmring-high",
+			.request = gpio_bcmring_request,
+			.direction_input = gpio_bcmring_direction_input,
+			.direction_output = gpio_bcmring_direction_output,
+			.get = gpio_bcmring_get,
+			.set = gpio_bcmring_set,
+			.base = GPIOHW_NUM_PINS_LOWER_BLOCK,
+			.ngpio = GPIOHW_NUM_PINS_HIGHER_BLOCK,
+			},
+	       },
+};
+
+/****************************************************************************/
+/**
+*  @brief   mux_isRequested
+*
+*  Find out if a gpio pin has already been requested in the gpiolib sense.
+*
+*  @return
+*     none
+*/
+/****************************************************************************/
+static const char *mux_isRequested(gpio_defs_e pin)
+{
+	int i;
+
+	/*
+	 * For now, convert pin number to chip and offset.  Later, convert this
+	 * into a gpiomux register/chip array structure. Since this is typically
+	 * init time code, it may not be worth worrying about for this one case.
+	 */
+	for (i = 0; i < ARRAY_LEN(gpio_bcmring_chip); i++) {
+		struct gpio_chip *chipp = &gpio_bcmring_chip[i].chip;
+		int base = chipp->base;
+		if ((pin >= base) && (pin < base + chipp->ngpio)) {
+			return gpiochip_is_requested(chipp, pin - base);
+		}
+	}
+	return NULL;
+
+}				/* mux_isRequested */
+
+/****************************************************************************/
+/**
+*  @brief   mux_request
+*
+*  Request a pin from gpiolib.
+*
+*/
+/****************************************************************************/
+static int mux_request(gpio_defs_e pin, const char *label)
+{
+	return gpio_request(pin, label);
+
+}				/* mux_request */
+
+/****************************************************************************/
+/**
+*  @brief   mux_free
+*
+*  Free a pin from gpiolib.
+*
+*/
+/****************************************************************************/
+static void mux_free(gpio_defs_e pin)
+{
+	return gpio_free(pin);
+
+}				/* mux_free */
+
+/****************************************************************************
+*
+*  brcm_init_gpio
+*
+*   Sets up gpiolib so that it's aware of how to manipulate our GPIOs
+*
+*****************************************************************************/
+
+void __init brcm_init_gpio(void)
+{
+	gpiomux_init_t initstruct;
+
+	gpiochip_add(&gpio_bcmring_chip[0].chip);
+	gpiochip_add(&gpio_bcmring_chip[1].chip);
+
+	/* Initialize callbacks for gpiomux function calls into gpiolib */
+	initstruct.request_gpio = mux_request;
+	initstruct.free_gpio = mux_free;
+	initstruct.is_requested = mux_isRequested;
+	gpiomux_Init(&initstruct);
+
+	/*
+	 * gpiomux_Init skips pins 14 and 15 (which makes sense when gpiomux_Init
+	 * is called from within the bootloaders.
+	 *
+	 * However, from this point forward in the code, gpiolib "owns" the pins. So
+	 * if you want these pins to be UART1, then you should call gpiomux_request
+	 * after this so that the pins gets reserved inside gpiolib.
+	 */
+
+	chipcHw_setGpioPinFunction(GPIO14_UART1_TXD,
+				   chipcHw_GPIO_FUNCTION_GPIO);
+	chipcHw_setGpioPinFunction(GPIO15_UART1_RXD,
+				   chipcHw_GPIO_FUNCTION_GPIO);
+
+}				/* brcm_init_gpio */
diff --git a/arch/arm/mach-bcmring/gpio_irq.c b/arch/arm/mach-bcmring/gpio_irq.c
new file mode 100644
index 0000000..a9b8892
--- /dev/null
+++ b/arch/arm/mach-bcmring/gpio_irq.c
@@ -0,0 +1,381 @@
+/*****************************************************************************
+* Copyright 2004 - 2008 Broadcom Corporation.  All rights reserved.
+*
+* Unless you and Broadcom execute a separate written software license
+* agreement governing use of this software, this software is licensed to you
+* under the terms of the GNU General Public License version 2, available at
+* http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
+*
+* Notwithstanding the above, under no circumstances may you combine this
+* software in any way with any other Broadcom software provided under a
+* license other than the GPL, without Broadcom's express prior written
+* consent.
+*****************************************************************************/
+
+/*
+*
+*****************************************************************************
+*
+*  gpio_irq.c
+*
+*  PURPOSE:
+*
+*     This implements the gpio driver interrupt rising/falling edge driver.
+*
+*  NOTES:
+*
+*****************************************************************************/
+
+/* ---- Include Files ---------------------------------------------------- */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/sysctl.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+
+#include <mach/gpio_irq.h>
+#include <asm/gpio.h>
+#include <asm/mach/irq.h>
+
+#include <mach/gpio.h>
+#include <mach/gpio_defs.h>
+#include <mach/csp/chipcHw_inline.h>
+#include <csp/gpioHw.h>
+#include <mach/csp/gpioHw_inline.h>
+
+/* ---- Public Variables ------------------------------------------------- */
+
+/* ---- Private Constants and Types -------------------------------------- */
+
+/* Debug logging */
+#ifdef DEBUG
+#undef DEBUG
+#endif
+#define DEBUG 1
+
+#define DBG_ERROR	0x01
+#define DBG_INFO	0x02
+#define DBG_TRACE	0x04
+#define DBG_TRACE2	0x08
+#define DBG_DATA	0x10
+#define DBG_DATA2	0x20
+
+#define DBG_DEFAULT_LEVEL	(DBG_ERROR | DBG_INFO)
+
+#if DEBUG
+#	define GPIO_DEBUG(level, x) {if (level & gLevel) printk x; }
+#else
+#	define GPIO_DEBUG(level, x)
+#endif
+
+static char banner[] __initdata =
+    KERN_INFO "GPIO Control Driver: 1.00 (built on " __DATE__ " " __TIME__
+    ")\n";
+static int gLevel = DBG_DEFAULT_LEVEL;
+
+/* ---- Private Variables ------------------------------------------------ */
+
+/* ---- Functions -------------------------------------------------------- */
+
+/****************************************************************************
+*
+*  gpio_irq_ack
+*
+*     Called by the interrupt handler to acknowledge (i.e. clear)
+*     the interrupt.
+*
+***************************************************************************/
+
+static void gpio_irq_ack(unsigned irq)
+{
+	/*
+	 * Since this function is ONLY called with interrupts disabled, we don't
+	 * need to disable irqs around the following
+	 */
+
+	GpioHw_IrqClear(irq_to_gpio(irq));
+}
+
+/****************************************************************************
+*
+*  gpio_irq_mask
+*
+*     Called to mask (i.e. disable) an interrupt.
+*
+***************************************************************************/
+
+static void gpio_irq_mask(unsigned irq)
+{
+	/*
+	 * Since this function is ONLY called with interrupts disabled, we don't
+	 * need to disable irqs around the following
+	 */
+
+	GpioHw_IrqDisable(irq_to_gpio(irq));
+}
+
+/****************************************************************************
+*
+*  gpio_irq_unmask
+*
+*     Called to unmask (i.e. enable) an interrupt.
+*
+***************************************************************************/
+
+static void gpio_irq_unmask(unsigned irq)
+{
+	/*
+	 * Since this function is ONLY called with interrupts disabled, we don't
+	 * need to disable irqs around the following
+	 */
+
+	GpioHw_IrqEnable(irq_to_gpio(irq));
+}
+
+/****************************************************************************
+*
+*  gpio_irq_type
+*
+*     Sets the type of the GPIO irq.
+*
+***************************************************************************/
+
+static int gpio_irq_set_type(unsigned irq, unsigned type)
+{
+	int gpio;
+
+	gpio = irq_to_gpio(irq);
+
+	/*
+	 * Since this function is ONLY called with interrupts disabled, we don't
+	 * need to disable irqs around the following
+	 */
+
+	if (type == IRQ_TYPE_PROBE) {
+		/* Don't mess GPIOs which already have interrupt handlers registered. */
+
+		if (GpioHw_IsIrqEnabled(gpio) == GPIOHW_IRQ_UNMASKED_INTERRUPT) {
+			return 0;
+		}
+
+		type = IRQ_TYPE_EDGE_BOTH;
+	}
+
+	printk(KERN_INFO "IRQ%d (gpio%d): ", irq, gpio);
+
+	GpioHw_IrqDisable(gpio);
+	GpioHw_SetDirInput(gpio);
+	GpioHw_IrqClear(gpio);
+	GpioHw_IrqEnable(gpio);
+
+	if (type & IRQ_TYPE_EDGE_RISING) {
+		if (type & IRQ_TYPE_EDGE_FALLING) {
+			printk(KERN_INFO "both edges\n");
+			GpioHw_SetIrqType(gpio,
+					  GPIOHW_INTERRUPT_TYPE_EDGE_BOTH);
+		} else {
+			printk(KERN_INFO "rising edges\n");
+			GpioHw_SetIrqType(gpio,
+					  GPIOHW_INTERRUPT_TYPE_EDGE_RISING);
+		}
+	} else if (type & IRQ_TYPE_EDGE_FALLING) {
+		printk(KERN_INFO "falling edges\n");
+		GpioHw_SetIrqType(gpio, GPIOHW_INTERRUPT_TYPE_EDGE_FALLING);
+	} else if (type & IRQ_TYPE_LEVEL_HIGH) {
+		printk(KERN_INFO "high level\n");
+		GpioHw_SetIrqType(gpio, GPIOHW_INTERRUPT_TYPE_LEVEL_HIGH);
+	} else if (type & IRQ_TYPE_LEVEL_LOW) {
+		printk(KERN_INFO "low level\n");
+		GpioHw_SetIrqType(gpio, GPIOHW_INTERRUPT_TYPE_LEVEL_LOW);
+	} else {
+		printk(KERN_ERR "no edges\n");
+		printk(KERN_ERR "%s: Failed to set type for IRQ%d (gpio%d): ",
+		       __func__, irq, gpio);
+		GpioHw_IrqDisable(gpio);
+		return -EINVAL;
+	}
+
+	return 0;
+
+}				/* gpio_irq_set_type */
+
+/****************************************************************************
+*
+*  gpio_isr_handler0
+*
+*     Figures out which GPIO caused the interrupt and calls the register
+*     handler to deal with it.
+*
+*     The handler function will in all likelyhood be do_edge_IRQ.
+*
+***************************************************************************/
+
+static void gpio_isr_handler0(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned mask;
+	int loop;
+
+	do {
+		loop = 0;
+
+		mask = GpioHw_GetMaskIrqRegStatus(GPIOHW_BLOCK_LOW);
+		if (mask) {
+			/* Clear the interrupts */
+
+			GpioHw_IrqClearReg(GPIOHW_BLOCK_LOW, mask);
+
+			irq = gpio_to_irq(0);
+			desc = irq_desc + irq;
+			do {
+				if (mask & 1) {
+					desc->handle_irq(irq, desc);
+				}
+				irq++;
+				desc++;
+				mask >>= 1;
+
+			} while (mask);
+
+			loop = 1;
+		}
+
+	} while (loop);
+
+}				/* gpio_isr_handler0 */
+
+/****************************************************************************
+*
+*  gpio_isr_handler1
+*
+*     Figures out which GPIO caused the interrupt and calls the register
+*     handler to deal with it.
+*
+*     The handler function will in all likelyhood be do_edge_IRQ.
+*
+***************************************************************************/
+
+static void gpio_isr_handler1(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned mask;
+	int loop;
+
+	do {
+		loop = 0;
+
+		mask = GpioHw_GetMaskIrqRegStatus(GPIOHW_BLOCK_HIGH);
+		if (mask) {
+			/* Clear the interrupts */
+
+			GpioHw_IrqClearReg(GPIOHW_BLOCK_HIGH, mask);
+
+			irq = gpio_to_irq(32);
+			desc = irq_desc + irq;
+			do {
+				if (mask & 1) {
+					desc->handle_irq(irq, desc);
+				}
+				irq++;
+				desc++;
+				mask >>= 1;
+
+			} while (mask);
+
+			loop = 1;
+		}
+
+	} while (loop);
+
+}				/* gpio_isr_handler1 */
+
+/****************************************************************************
+*
+*  gpio_chip data structure.
+*
+***************************************************************************/
+
+static struct irq_chip gpio_chip = {
+	.typename = "GPIO-IRQ",
+	.ack = gpio_irq_ack,
+	.mask = gpio_irq_mask,
+	.unmask = gpio_irq_unmask,
+	.disable = gpio_irq_mask,
+	.enable = gpio_irq_unmask,
+	.set_type = gpio_irq_set_type,
+};
+
+/****************************************************************************
+*
+*  gpio_cleanup
+*
+*       Called to perform module cleanup when the module is unloaded.
+*
+***************************************************************************/
+static void gpio_cleanup(void)
+{
+	GPIO_DEBUG(DBG_TRACE, ("gpio_cleanup()\n"));
+
+}
+
+/****************************************************************************
+*
+*  gpio_init
+*
+*     Called to perform module initialization when the module is loaded
+*
+***************************************************************************/
+
+static int __init gpio_init(void)
+{
+	/* Initialize debug level */
+	gLevel = DBG_DEFAULT_LEVEL;
+
+	GPIO_DEBUG(DBG_INFO, ("gpio_init called\n"));
+
+	printk(banner);
+	{
+		int irq;
+
+		for (irq = gpio_to_irq(0);
+		     irq <= gpio_to_irq(NUM_GPIO_IRQS - 1); irq++) {
+			set_irq_chip(irq, &gpio_chip);
+			set_irq_handler(irq, handle_edge_irq);
+			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		}
+		set_irq_chained_handler(IRQ_GPIO0, gpio_isr_handler0);
+		set_irq_chained_handler(IRQ_GPIO1, gpio_isr_handler1);
+	}
+
+	return 0;
+}				/* gpio_init */
+
+/****************************************************************************
+*
+*  gpio_exit
+*
+*       Called to perform module cleanup when the module is unloaded.
+*
+***************************************************************************/
+
+static void __exit gpio_exit(void)
+{
+	GPIO_DEBUG(DBG_INFO, ("gpio_exit called\n"));
+
+	gpio_cleanup();
+}				/* gpio_exit */
+
+/* Changed from module_init to fs_initcall so that GPIO driver
+ * is loaded before the any of the PMU drivers were loaded on
+ * other products - leave it this way for future.
+ */
+
+fs_initcall(gpio_init);
+module_exit(gpio_exit);
+
+MODULE_AUTHOR("Broadcom");
+MODULE_DESCRIPTION("GPIO Control Driver");
-- 
1.6.0.6

Leo Chen
