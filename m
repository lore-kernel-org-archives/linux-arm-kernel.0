From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Jan 2018 17:13:59 -0800
Subject: [PATCH v2 2/3] gpiolib-of: Support 'reserved-gpio-ranges' property
In-Reply-To: <20180126011400.2191-1-sboyd@codeaurora.org>
References: <20180126011400.2191-1-sboyd@codeaurora.org>
Message-ID: <20180126011400.2191-3-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some qcom platforms make some GPIOs or pins unavailable for use
by non-secure operating systems, and thus reading or writing the
registers for those pins will cause access control issues.  Add
support for a DT property to describe the set of GPIOs that are
available for use so that higher level OSes are able to know what
pins to avoid reading/writing.

For now, we plumb this into the gpiochip irq APIs so that
GPIO/pinctrl drivers can use the gpiochip_irqchip_irq_valid() to
test validity of GPIOs.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Or this can move into a dedicated API and not be tied to the irq code.
Something like of_gpiochip_init_valid_mask?

 drivers/gpio/gpiolib-of.c | 28 ++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.c    |  9 +++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 564bb7a31da4..194b3306ef74 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -498,6 +498,32 @@ void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc)
 }
 EXPORT_SYMBOL(of_mm_gpiochip_remove);
 
+#ifdef CONFIG_GPIOLIB_IRQCHIP
+static void of_gpiochip_init_irq_valid_mask(struct gpio_chip *chip)
+{
+	int len, i;
+	u32 start, count;
+	struct device_node *np = chip->of_node;
+
+	len = of_property_count_u32_elems(np,  "reserved-gpio-ranges");
+	if (len < 0 || len % 2 != 0)
+		return;
+
+	for (i = 0; i < len; i += 2) {
+		of_property_read_u32_index(np, "reserved-gpio-ranges",
+					   i, &start);
+		of_property_read_u32_index(np, "reserved-gpio-ranges",
+					   i + 1, &count);
+		if (start >= chip->ngpio || start + count >= chip->ngpio)
+			continue;
+
+		bitmap_clear(chip->irq.valid_mask, start, count);
+	}
+};
+#else
+static void of_gpiochip_init_irq_valid_mask(struct gpio_chip *chip) { }
+#endif
+
 #ifdef CONFIG_PINCTRL
 static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 {
@@ -602,6 +628,8 @@ int of_gpiochip_add(struct gpio_chip *chip)
 	if (chip->of_gpio_n_cells > MAX_PHANDLE_ARGS)
 		return -EINVAL;
 
+	of_gpiochip_init_irq_valid_mask(chip);
+
 	status = of_gpiochip_add_pin_range(chip);
 	if (status)
 		return status;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 930676ec9847..8483850463e6 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1483,6 +1483,15 @@ static struct gpio_chip *find_chip_by_name(const char *name)
 
 static int gpiochip_irqchip_init_valid_mask(struct gpio_chip *gpiochip)
 {
+#ifdef CONFIG_OF_GPIO
+	int size;
+	struct device_node *np = gpiochip->of_node;
+
+	size = of_property_count_u32_elems(np,  "reserved-gpio-ranges");
+	if (size > 0 && size % 2 == 0)
+		gpiochip->irq.need_valid_mask = true;
+#endif
+
 	if (!gpiochip->irq.need_valid_mask)
 		return 0;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
