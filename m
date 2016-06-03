From: irodriguez@cemitec.com (Iban Rodriguez)
Date: Fri, 3 Jun 2016 14:54:41 +0200
Subject: [PATCH] gpio: xilinx: Add support to set multiple GPIO at once
Message-ID: <1464958481-672-1-git-send-email-irodriguez@cemitec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add function to set multiple GPIO of the same chip at the same time
and register it

Signed-off-by: Iban Rodriguez <irodriguez@cemitec.com>
---
 drivers/gpio/gpio-xilinx.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index d0fbb7f..4b0cf51 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -133,6 +133,53 @@ static void xgpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 }
 
 /**
+ * xgpio_set_multiple - Write the specified signals of the GPIO device.
+ * @gc:     Pointer to gpio_chip device structure.
+ * @mask:   Mask of the GPIOS to modify.
+ * @bits:   Value to be wrote on each GPIO
+ *
+ * This function writes the specified values into the specified signals of the
+ * GPIO devices.
+ */
+static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
+			       unsigned long *bits)
+{
+	unsigned long flags;
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct xgpio_instance *chip = gpiochip_get_data(gc);
+	int index = xgpio_index(chip, 0);
+	int offset, i;
+
+	spin_lock_irqsave(&chip->gpio_lock[index], flags);
+
+	/* Write to GPIO signals */
+	for (i = 0; i < gc->ngpio; i++) {
+		if (*mask == 0)
+			break;
+		if (index !=  xgpio_index(chip, i)) {
+			xgpio_writereg(mm_gc->regs + XGPIO_DATA_OFFSET +
+				       xgpio_regoffset(chip, i),
+				       chip->gpio_state[index]);
+			spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
+			index =  xgpio_index(chip, i);
+			spin_lock_irqsave(&chip->gpio_lock[index], flags);
+		}
+		if (__test_and_clear_bit(i, mask)) {
+			offset =  xgpio_offset(chip, i);
+			if (test_bit(i, bits))
+				chip->gpio_state[index] |= BIT(offset);
+			else
+				chip->gpio_state[index] &= ~BIT(offset);
+		}
+	}
+
+	xgpio_writereg(mm_gc->regs + XGPIO_DATA_OFFSET +
+		       xgpio_regoffset(chip, i), chip->gpio_state[index]);
+
+	spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
+}
+
+/**
  * xgpio_dir_in - Set the direction of the specified GPIO signal as input.
  * @gc:     Pointer to gpio_chip device structure.
  * @gpio:   GPIO signal number.
@@ -306,6 +353,7 @@ static int xgpio_probe(struct platform_device *pdev)
 	chip->mmchip.gc.direction_output = xgpio_dir_out;
 	chip->mmchip.gc.get = xgpio_get;
 	chip->mmchip.gc.set = xgpio_set;
+	chip->mmchip.gc.set_multiple = xgpio_set_multiple;
 
 	chip->mmchip.save_regs = xgpio_save_regs;
 
-- 
1.9.1
