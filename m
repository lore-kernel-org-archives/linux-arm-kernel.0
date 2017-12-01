From: timur@codeaurora.org (Timur Tabi)
Date: Fri,  1 Dec 2017 17:28:22 -0600
Subject: [PATCH 2/4] [v2] gpiolib: add bitmask for valid GPIO lines
In-Reply-To: <1512170904-4749-1-git-send-email-timur@codeaurora.org>
References: <1512170904-4749-1-git-send-email-timur@codeaurora.org>
Message-ID: <1512170904-4749-3-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for specifying that some GPIOs within a range are unavailable.
Some systems have a sparse list of GPIOs, where a range of GPIOs is
specified (usually 0 to n-1), but some subset within that range is
absent or unavailable for whatever reason.

To support this, allow drivers to specify a bitmask of GPIOs that
are present or absent.  Gpiolib will then block access to those that
are absent.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/gpio/gpiolib.c      | 47 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/gpio/driver.h |  3 +++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 168dd831551d..2c71e8db95a3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -191,6 +191,28 @@ static int gpiochip_find_base(int ngpio)
 	}
 }
 
+static int gpiochip_init_valid_mask(struct gpio_chip *chip)
+{
+	if (!chip->need_valid_mask)
+		return 0;
+
+	chip->valid_mask = kmalloc_array(BITS_TO_LONGS(chip->ngpio),
+					 sizeof(long), GFP_KERNEL);
+	if (!chip->valid_mask)
+		return -ENOMEM;
+
+	/* Assume by default all GPIOs are valid */
+	bitmap_fill(chip->valid_mask, chip->ngpio);
+
+	return 0;
+}
+
+static void gpiochip_remove_valid_mask(struct gpio_chip *chip)
+{
+	kfree(chip->valid_mask);
+	chip->valid_mask = NULL;
+}
+
 /**
  * gpiod_get_direction - return the current direction of a GPIO
  * @desc:	GPIO to get the direction of
@@ -1225,10 +1247,14 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 	if (status)
 		goto err_remove_from_list;
 
-	status = gpiochip_irqchip_init_valid_mask(chip);
+	status = gpiochip_init_valid_mask(chip);
 	if (status)
 		goto err_remove_from_list;
 
+	status = gpiochip_irqchip_init_valid_mask(chip);
+	if (status)
+		goto err_remove_valid_mask;
+
 	status = gpiochip_add_irqchip(chip, key);
 	if (status)
 		goto err_remove_chip;
@@ -1259,6 +1285,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 	gpiochip_free_hogs(chip);
 	of_gpiochip_remove(chip);
 	gpiochip_irqchip_free_valid_mask(chip);
+err_remove_valid_mask:
+	gpiochip_remove_valid_mask(chip);
 err_remove_from_list:
 	spin_lock_irqsave(&gpio_lock, flags);
 	list_del(&gdev->list);
@@ -1311,6 +1339,7 @@ void gpiochip_remove(struct gpio_chip *chip)
 	/* Numb the device, cancelling all outstanding operations */
 	gdev->chip = NULL;
 	gpiochip_irqchip_remove(chip);
+	gpiochip_remove_valid_mask(chip);
 	acpi_gpiochip_remove(chip);
 	gpiochip_remove_pin_ranges(chip);
 	of_gpiochip_remove(chip);
@@ -1500,6 +1529,18 @@ static bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gpiochip,
 	return test_bit(offset, gpiochip->irq.valid_mask);
 }
 
+static bool gpiochip_available(const struct gpio_chip *gpiochip,
+			   unsigned int offset)
+{
+	pr_info("%s:%u offset=%u\n", __func__, __LINE__, offset);
+
+	/* No mask means all valid */
+	if (likely(!gpiochip->valid_mask))
+		return true;
+
+	return test_bit(offset, gpiochip->valid_mask);
+}
+
 /**
  * gpiochip_set_cascaded_irqchip() - connects a cascaded irqchip to a gpiochip
  * @gpiochip: the gpiochip to set the irqchip chain to
@@ -3597,6 +3638,10 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 		return desc;
 	}
 
+	/* Check if the GPIO line itself is valid */
+	if (!gpiochip_available(desc->gdev->chip, idx))
+		return ERR_PTR(-EACCES);
+
 	status = gpiod_request(desc, con_id);
 	if (status < 0)
 		return ERR_PTR(status);
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 55e672592fa9..b68450caf554 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -316,6 +316,9 @@ struct gpio_chip {
 	int (*of_xlate)(struct gpio_chip *gc,
 			const struct of_phandle_args *gpiospec, u32 *flags);
 #endif
+
+	bool			need_valid_mask;
+	unsigned long		*valid_mask;
 };
 
 extern const char *gpiochip_is_requested(struct gpio_chip *chip,
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
