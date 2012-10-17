From: stigge@antcom.de (Roland Stigge)
Date: Wed, 17 Oct 2012 14:31:45 +0200
Subject: [PATCH RFC 13/15 v5] gpio-xilinx: Add block GPIO API
In-Reply-To: <1350477107-26512-1-git-send-email-stigge@antcom.de>
References: <1350477107-26512-1-git-send-email-stigge@antcom.de>
Message-ID: <1350477107-26512-14-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds block GPIO API support to the gpio-xilinx driver.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 drivers/gpio/gpio-xilinx.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

--- linux-2.6.orig/drivers/gpio/gpio-xilinx.c
+++ linux-2.6/drivers/gpio/gpio-xilinx.c
@@ -49,6 +49,21 @@ static int xgpio_get(struct gpio_chip *g
 }
 
 /**
+ * xgpio_get_block - Read a block of specified signals of the GPIO device.
+ * @gc:     Pointer to gpio_chip device structure.
+ * @mask:   Bit mask (bit 0 == 0th GPIO) for GPIOs to get
+ *
+ * This function reads a block of specified signal of the GPIO device, returned
+ * as a bit mask, each bit representing a GPIO
+ */
+static unsigned long xgpio_get_block(struct gpio_chip *gc, unsigned long mask)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+
+	return in_be32(mm_gc->regs + XGPIO_DATA_OFFSET) & mask;
+}
+
+/**
  * xgpio_set - Write the specified signal of the GPIO device.
  * @gc:     Pointer to gpio_chip device structure.
  * @gpio:   GPIO signal number.
@@ -77,6 +92,33 @@ static void xgpio_set(struct gpio_chip *
 }
 
 /**
+ * xgpio_set_block - Write a block of specified signals of the GPIO device.
+ * @gc:     Pointer to gpio_chip device structure.
+ * @mask:   Bit mask (bit 0 == 0th GPIO) for GPIOs to set
+ * @values: Bit mapped values
+ *
+ * This function writes the specified values in to the specified signals of the
+ * GPIO device.
+ */
+static void xgpio_set_block(struct gpio_chip *gc, unsigned long mask,
+			    unsigned long values)
+{
+	unsigned long flags;
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct xgpio_instance *chip =
+	    container_of(mm_gc, struct xgpio_instance, mmchip);
+
+	spin_lock_irqsave(&chip->gpio_lock, flags);
+
+	chip->gpio_state &= ~mask;
+	chip->gpio_state |= mask & values;
+
+	out_be32(mm_gc->regs + XGPIO_DATA_OFFSET, chip->gpio_state);
+
+	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+}
+
+/**
  * xgpio_dir_in - Set the direction of the specified GPIO signal as input.
  * @gc:     Pointer to gpio_chip device structure.
  * @gpio:   GPIO signal number.
@@ -195,6 +237,8 @@ static int __devinit xgpio_of_probe(stru
 	chip->mmchip.gc.direction_output = xgpio_dir_out;
 	chip->mmchip.gc.get = xgpio_get;
 	chip->mmchip.gc.set = xgpio_set;
+	chip->mmchip.gc.get_block = xgpio_get_block;
+	chip->mmchip.gc.set_block = xgpio_set_block;
 
 	chip->mmchip.save_regs = xgpio_save_regs;
 
