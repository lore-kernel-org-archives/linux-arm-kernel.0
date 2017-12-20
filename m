From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 20 Dec 2017 00:15:56 -0800
Subject: [PATCH 3/3] [v6] pinctrl: qcom: qdf2xxx: add support for new
 ACPI HID QCOM8002
In-Reply-To: <d511f096-bad4-c7b3-d7d4-11b1fa3b1cce@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
 <1513189818-7384-4-git-send-email-timur@codeaurora.org>
 <20171213230155.GS7997@codeaurora.org>
 <6ca3b4a6-90b9-0481-beb8-29a95c86f07c@codeaurora.org>
 <615426d4-7c46-9671-87ef-790fb5733385@codeaurora.org>
 <20171219023935.GA17456@codeaurora.org>
 <735d4316-9b18-2903-aabd-46ead1db5233@codeaurora.org>
 <20171220022626.GH7997@codeaurora.org>
 <d511f096-bad4-c7b3-d7d4-11b1fa3b1cce@codeaurora.org>
Message-ID: <20171220081556.GA30524@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19, Timur Tabi wrote:
> Frankly, I thought I had everything resolved already, and it sounds
> like you want me to start over from scratch anyway.
> 

Here's the patch. I get a hang when dumping debugfs, but at least
sysfs expose fails when trying to request blocked gpios. I need
to check if we need to say "yes" to pins that are above the gpio
max for pinctrl. I'll do that tomorrow.

---
 drivers/gpio/gpiolib.c             |  4 +-
 drivers/pinctrl/qcom/pinctrl-msm.c | 98 ++++++++++++++++++++++++++++++++++++--
 include/linux/gpio/driver.h        |  3 ++
 3 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8db2680bf872..5f118f044caa 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1475,8 +1475,8 @@ static void gpiochip_irqchip_free_valid_mask(struct gpio_chip *gpiochip)
 	gpiochip->irq_valid_mask = NULL;
 }
 
-static bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gpiochip,
-				       unsigned int offset)
+bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gpiochip,
+				unsigned int offset)
 {
 	/* No mask means all valid */
 	if (likely(!gpiochip->irq_valid_mask))
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 273badd92561..4c2ce1f7d449 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -105,6 +105,17 @@ static const struct pinctrl_ops msm_pinctrl_ops = {
 	.dt_free_map		= pinctrl_utils_free_map,
 };
 
+static int msm_pinmux_request(struct pinctrl_dev *pctldev, unsigned offset)
+{
+	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	struct gpio_chip *chip = &pctrl->chip;
+
+	if (gpiochip_irqchip_irq_valid(chip, offset))
+		return 0;
+
+	return -EINVAL;
+}
+
 static int msm_get_functions_count(struct pinctrl_dev *pctldev)
 {
 	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
@@ -166,6 +177,7 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 }
 
 static const struct pinmux_ops msm_pinmux_ops = {
+	.request		= msm_pinmux_request,
 	.get_functions_count	= msm_get_functions_count,
 	.get_function_name	= msm_get_function_name,
 	.get_function_groups	= msm_get_function_groups,
@@ -493,6 +505,9 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 		"pull up"
 	};
 
+	if (!gpiochip_irqchip_irq_valid(chip, offset))
+		return;
+
 	g = &pctrl->soc->groups[offset];
 	ctl_reg = readl(pctrl->regs + g->ctl_reg);
 
@@ -503,7 +518,7 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 
 	seq_printf(s, " %-8s: %-3s %d", g->name, is_out ? "out" : "in", func);
 	seq_printf(s, " %dmA", msm_regval_to_drive(drive));
-	seq_printf(s, " %s", pulls[pull]);
+	seq_printf(s, " %s\n", pulls[pull]);
 }
 
 static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
@@ -511,10 +526,8 @@ static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	unsigned gpio = chip->base;
 	unsigned i;
 
-	for (i = 0; i < chip->ngpio; i++, gpio++) {
+	for (i = 0; i < chip->ngpio; i++, gpio++)
 		msm_gpio_dbg_show_one(s, NULL, chip, i, gpio);
-		seq_puts(s, "\n");
-	}
 }
 
 #else
@@ -795,6 +808,76 @@ static void msm_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static int msm_gpio_init_irq_valid_mask(struct gpio_chip *chip,
+					struct msm_pinctrl *pctrl)
+{
+	int ret;
+	unsigned int len, i;
+	unsigned int max_gpios = pctrl->soc->ngpios;
+	struct device_node *np = pctrl->dev->of_node;
+
+	/* The number of GPIOs in the ACPI tables */
+	ret = device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0);
+	if (ret > 0 && ret < max_gpios) {
+		u16 *tmp;
+
+		len = ret;
+		tmp = kmalloc_array(len, sizeof(tmp[0]), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+
+		ret = device_property_read_u16_array(pctrl->dev, "gpios", tmp,
+						     len);
+		if (ret < 0) {
+			dev_err(pctrl->dev, "could not read list of GPIOs\n");
+			kfree(tmp);
+			return ret;
+		}
+
+		bitmap_zero(chip->irq_valid_mask, max_gpios);
+		for (i = 0; i < len; i++)
+			set_bit(tmp[i], chip->irq_valid_mask);
+
+		return 0;
+	}
+
+	/* If there's a DT ngpios-ranges property then add those ranges */
+	ret = of_property_count_u32_elems(np,  "ngpios-ranges");
+	if (ret > 0 && ret % 2 == 0 && ret / 2 < max_gpios) {
+		u32 start;
+		u32 count;
+
+		len = ret / 2;
+		bitmap_zero(chip->irq_valid_mask, max_gpios);
+
+		for (i = 0; i < len; i++) {
+			of_property_read_u32_index(np, "ngpios-ranges",
+						   i * 2, &start);
+			of_property_read_u32_index(np, "ngpios-ranges",
+						   i * 2 + 1, &count);
+			bitmap_set(chip->irq_valid_mask, start, count);
+		}
+	}
+
+	return 0;
+}
+
+static bool msm_gpio_needs_irq_valid_mask(struct msm_pinctrl *pctrl)
+{
+	int ret;
+	struct device_node *np = pctrl->dev->of_node;
+
+	ret = device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0);
+	if (ret > 0)
+		return true;
+
+	ret = of_property_count_u32_elems(np,  "ngpios-ranges");
+	if (ret > 0 && ret % 2 == 0)
+		return true;
+
+	return false;
+}
+
 static int msm_gpio_init(struct msm_pinctrl *pctrl)
 {
 	struct gpio_chip *chip;
@@ -811,6 +894,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	chip->parent = pctrl->dev;
 	chip->owner = THIS_MODULE;
 	chip->of_node = pctrl->dev->of_node;
+	chip->irq_need_valid_mask = msm_gpio_needs_irq_valid_mask(pctrl);
 
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
@@ -818,6 +902,12 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 		return ret;
 	}
 
+	ret = msm_gpio_init_irq_valid_mask(chip, pctrl);
+	if (ret) {
+		dev_err(pctrl->dev, "Failed to setup irq valid bits\n");
+		return ret;
+	}
+
 	ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev), 0, 0, chip->ngpio);
 	if (ret) {
 		dev_err(pctrl->dev, "Failed to add pin range\n");
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index af20369ec8e7..be977c1c7498 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -262,6 +262,9 @@ int gpiochip_irqchip_add_key(struct gpio_chip *gpiochip,
 			     bool nested,
 			     struct lock_class_key *lock_key);
 
+bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gpiochip,
+				unsigned int offset);
+
 #ifdef CONFIG_LOCKDEP
 
 /*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
