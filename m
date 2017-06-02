From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  2 Jun 2017 16:23:17 +0200
Subject: [PATCH v2 10/11] gpio: mvebu: Add support for the Armada 7K/8K SoCs
In-Reply-To: <cover.8fe5f7c62a787452878ca071fa00b953e96988ef.1496413293.git-series.gregory.clement@free-electrons.com>
References: <cover.8fe5f7c62a787452878ca071fa00b953e96988ef.1496413293.git-series.gregory.clement@free-electrons.com>
Message-ID: <8666a1e32d95ecb6b2752cb68de6d988c1bd901c.1496413293.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 7K and 8K SoCs use the same gpio controller as most of the
other mvebu SoCs. However, the main difference is that the GPIO
controller is part of a bigger system controller, and a syscon is used to
control the overall system controller. Therefore, the driver needs to be
adjusted to retrieve the regmap of the syscon to access registers, and
account for the fact that registers are located at a certain offset
within the regmap.

This commit add the support of the syscon and introduce a new variant for
this case.

It was based on the preliminary work of Thomas Petazzoni.

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/gpio/gpio-mvebu.c | 212 +++++++++++++++++++++++++--------------
 1 file changed, 141 insertions(+), 71 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 3d03740a20e7..5edb04abd7d7 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -42,6 +42,7 @@
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/pinctrl/consumer.h>
@@ -88,6 +89,7 @@
 #define MVEBU_GPIO_SOC_VARIANT_ORION	0x1
 #define MVEBU_GPIO_SOC_VARIANT_MV78200	0x2
 #define MVEBU_GPIO_SOC_VARIANT_ARMADAXP 0x3
+#define MVEBU_GPIO_SOC_VARIANT_A8K	0x4
 
 #define MVEBU_MAX_GPIO_PER_BANK		32
 
@@ -108,6 +110,7 @@ struct mvebu_pwm {
 struct mvebu_gpio_chip {
 	struct gpio_chip   chip;
 	struct regmap     *regs;
+	u32		   offset;
 	struct regmap     *percpu_regs;
 	int		   irqbase;
 	struct irq_domain *domain;
@@ -139,8 +142,9 @@ static void mvebu_gpioreg_edge_cause(struct mvebu_gpio_chip *mvchip,
 	switch (mvchip->soc_variant) {
 	case MVEBU_GPIO_SOC_VARIANT_ORION:
 	case MVEBU_GPIO_SOC_VARIANT_MV78200:
+	case MVEBU_GPIO_SOC_VARIANT_A8K:
 		*map = mvchip->regs;
-		*offset = GPIO_EDGE_CAUSE_OFF;
+		*offset = GPIO_EDGE_CAUSE_OFF + mvchip->offset;
 		break;
 	case MVEBU_GPIO_SOC_VARIANT_ARMADAXP:
 		cpu = smp_processor_id();
@@ -183,8 +187,9 @@ mvebu_gpioreg_edge_mask(struct mvebu_gpio_chip *mvchip,
 
 	switch (mvchip->soc_variant) {
 	case MVEBU_GPIO_SOC_VARIANT_ORION:
+	case MVEBU_GPIO_SOC_VARIANT_A8K:
 		*map = mvchip->regs;
-		*offset = GPIO_EDGE_MASK_OFF;
+		*offset = GPIO_EDGE_MASK_OFF + mvchip->offset;
 		break;
 	case MVEBU_GPIO_SOC_VARIANT_MV78200:
 		cpu = smp_processor_id();
@@ -232,8 +237,9 @@ mvebu_gpioreg_level_mask(struct mvebu_gpio_chip *mvchip,
 
 	switch (mvchip->soc_variant) {
 	case MVEBU_GPIO_SOC_VARIANT_ORION:
+	case MVEBU_GPIO_SOC_VARIANT_A8K:
 		*map = mvchip->regs;
-		*offset = GPIO_LEVEL_MASK_OFF;
+		*offset = GPIO_LEVEL_MASK_OFF + mvchip->offset;
 		break;
 	case MVEBU_GPIO_SOC_VARIANT_MV78200:
 		cpu = smp_processor_id();
@@ -294,7 +300,7 @@ static void mvebu_gpio_set(struct gpio_chip *chip, unsigned int pin, int value)
 {
 	struct mvebu_gpio_chip *mvchip = gpiochip_get_data(chip);
 
-	regmap_update_bits(mvchip->regs, GPIO_OUT_OFF,
+	regmap_update_bits(mvchip->regs, GPIO_OUT_OFF + mvchip->offset,
 			   BIT(pin), value ? BIT(pin) : 0);
 }
 
@@ -303,16 +309,18 @@ static int mvebu_gpio_get(struct gpio_chip *chip, unsigned int pin)
 	struct mvebu_gpio_chip *mvchip = gpiochip_get_data(chip);
 	u32 u;
 
-	regmap_read(mvchip->regs, GPIO_IO_CONF_OFF, &u);
+	regmap_read(mvchip->regs, GPIO_IO_CONF_OFF + mvchip->offset, &u);
 
 	if (u & BIT(pin)) {
 		u32 data_in, in_pol;
 
-		regmap_read(mvchip->regs, GPIO_DATA_IN_OFF, &data_in);
-		regmap_read(mvchip->regs, GPIO_IN_POL_OFF, &in_pol);
+		regmap_read(mvchip->regs, GPIO_DATA_IN_OFF + mvchip->offset,
+			    &data_in);
+		regmap_read(mvchip->regs, GPIO_IN_POL_OFF + mvchip->offset,
+			    &in_pol);
 		u = data_in ^ in_pol;
 	} else {
-		regmap_read(mvchip->regs, GPIO_OUT_OFF, &u);
+		regmap_read(mvchip->regs, GPIO_OUT_OFF + mvchip->offset, &u);
 	}
 
 	return (u >> pin) & 1;
@@ -323,7 +331,7 @@ static void mvebu_gpio_blink(struct gpio_chip *chip, unsigned int pin,
 {
 	struct mvebu_gpio_chip *mvchip = gpiochip_get_data(chip);
 
-	regmap_update_bits(mvchip->regs, GPIO_BLINK_EN_OFF,
+	regmap_update_bits(mvchip->regs, GPIO_BLINK_EN_OFF + mvchip->offset,
 			   BIT(pin), value ? BIT(pin) : 0);
 }
 
@@ -340,7 +348,7 @@ static int mvebu_gpio_direction_input(struct gpio_chip *chip, unsigned int pin)
 	if (ret)
 		return ret;
 
-	regmap_update_bits(mvchip->regs, GPIO_IO_CONF_OFF,
+	regmap_update_bits(mvchip->regs, GPIO_IO_CONF_OFF + mvchip->offset,
 			   BIT(pin), 1);
 
 	return 0;
@@ -363,7 +371,7 @@ static int mvebu_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
 	mvebu_gpio_blink(chip, pin, 0);
 	mvebu_gpio_set(chip, pin, value);
 
-	regmap_update_bits(mvchip->regs, GPIO_IO_CONF_OFF,
+	regmap_update_bits(mvchip->regs, GPIO_IO_CONF_OFF + mvchip->offset,
 			   BIT(pin), 0);
 
 	return 0;
@@ -478,7 +486,7 @@ static int mvebu_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 
 	pin = d->hwirq;
 
-	regmap_read(mvchip->regs, GPIO_IO_CONF_OFF, &u);
+	regmap_read(mvchip->regs, GPIO_IO_CONF_OFF + mvchip->offset, &u);
 	if ((u & BIT(pin)) == 0)
 		return -EINVAL;
 
@@ -497,19 +505,23 @@ static int mvebu_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 	case IRQ_TYPE_LEVEL_HIGH:
-		regmap_update_bits(mvchip->regs, GPIO_IN_POL_OFF,
+		regmap_update_bits(mvchip->regs,
+				   GPIO_IN_POL_OFF + mvchip->offset,
 				   BIT(pin), 0);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
 	case IRQ_TYPE_LEVEL_LOW:
-		regmap_update_bits(mvchip->regs, GPIO_IN_POL_OFF,
+		regmap_update_bits(mvchip->regs,
+				   GPIO_IN_POL_OFF + mvchip->offset,
 				   BIT(pin), 1);
 		break;
 	case IRQ_TYPE_EDGE_BOTH: {
 		u32 data_in, in_pol, val;
 
-		regmap_read(mvchip->regs, GPIO_IN_POL_OFF, &in_pol);
-		regmap_read(mvchip->regs, GPIO_DATA_IN_OFF, &data_in);
+		regmap_read(mvchip->regs,
+			    GPIO_IN_POL_OFF + mvchip->offset, &in_pol);
+		regmap_read(mvchip->regs,
+			    GPIO_DATA_IN_OFF + mvchip->offset, &data_in);
 
 		/*
 		 * set initial polarity based on current input level
@@ -519,7 +531,8 @@ static int mvebu_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 		else
 			val = 0; /* raising */
 
-		regmap_update_bits(mvchip->regs, GPIO_IN_POL_OFF,
+		regmap_update_bits(mvchip->regs,
+				   GPIO_IN_POL_OFF + mvchip->offset,
 				   BIT(pin), val);
 		break;
 	}
@@ -539,7 +552,7 @@ static void mvebu_gpio_irq_handler(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	regmap_read(mvchip->regs, GPIO_DATA_IN_OFF, &data_in);
+	regmap_read(mvchip->regs, GPIO_DATA_IN_OFF + mvchip->offset, &data_in);
 	level_mask = mvebu_gpio_read_level_mask(mvchip);
 	edge_cause = mvebu_gpio_read_edge_cause(mvchip);
 	edge_mask  = mvebu_gpio_read_edge_mask(mvchip);
@@ -559,9 +572,13 @@ static void mvebu_gpio_irq_handler(struct irq_desc *desc)
 			/* Swap polarity (race with GPIO line) */
 			u32 polarity;
 
-			regmap_read(mvchip->regs, GPIO_IN_POL_OFF, &polarity);
+			regmap_read(mvchip->regs,
+				    GPIO_IN_POL_OFF + mvchip->offset,
+				    &polarity);
 			polarity ^= BIT(i);
-			regmap_write(mvchip->regs, GPIO_IN_POL_OFF, polarity);
+			regmap_write(mvchip->regs,
+				     GPIO_IN_POL_OFF + mvchip->offset,
+				     polarity);
 		}
 
 		generic_handle_irq(irq);
@@ -664,7 +681,7 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
 			state->period = 1;
 	}
 
-	regmap_read(mvchip->regs, GPIO_BLINK_EN_OFF, &u);
+	regmap_read(mvchip->regs, GPIO_BLINK_EN_OFF + mvchip->offset, &u);
 	if (u)
 		state->enabled = true;
 	else
@@ -727,7 +744,7 @@ static void __maybe_unused mvebu_pwm_suspend(struct mvebu_gpio_chip *mvchip)
 {
 	struct mvebu_pwm *mvpwm = mvchip->mvpwm;
 
-	regmap_read(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF,
+	regmap_read(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset,
 		    &mvpwm->blink_select);
 	mvpwm->blink_on_duration =
 		readl_relaxed(mvebu_pwmreg_blink_on_duration(mvpwm));
@@ -739,7 +756,7 @@ static void __maybe_unused mvebu_pwm_resume(struct mvebu_gpio_chip *mvchip)
 {
 	struct mvebu_pwm *mvpwm = mvchip->mvpwm;
 
-	regmap_write(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF,
+	regmap_write(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset,
 		     mvpwm->blink_select);
 	writel_relaxed(mvpwm->blink_on_duration,
 		       mvebu_pwmreg_blink_on_duration(mvpwm));
@@ -783,7 +800,8 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 		set = U32_MAX;
 	else
 		return -EINVAL;
-	regmap_write(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF, 0);
+	regmap_write(mvchip->regs,
+		     GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset, 0);
 
 	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
 	if (!mvpwm)
@@ -819,11 +837,11 @@ static void mvebu_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	u32 out, io_conf, blink, in_pol, data_in, cause, edg_msk, lvl_msk;
 	int i;
 
-	regmap_read(mvchip->regs, GPIO_OUT_OFF, &out);
-	regmap_read(mvchip->regs, GPIO_IO_CONF_OFF, &io_conf);
-	regmap_read(mvchip->regs, GPIO_BLINK_EN_OFF, &blink);
-	regmap_read(mvchip->regs, GPIO_IN_POL_OFF, &in_pol);
-	regmap_read(mvchip->regs, GPIO_DATA_IN_OFF, &data_in);
+	regmap_read(mvchip->regs, GPIO_OUT_OFF + mvchip->offset, &out);
+	regmap_read(mvchip->regs, GPIO_IO_CONF_OFF + mvchip->offset, &io_conf);
+	regmap_read(mvchip->regs, GPIO_BLINK_EN_OFF + mvchip->offset, &blink);
+	regmap_read(mvchip->regs, GPIO_IN_POL_OFF + mvchip->offset, &in_pol);
+	regmap_read(mvchip->regs, GPIO_DATA_IN_OFF + mvchip->offset, &data_in);
 	cause	= mvebu_gpio_read_edge_cause(mvchip);
 	edg_msk	= mvebu_gpio_read_edge_mask(mvchip);
 	lvl_msk	= mvebu_gpio_read_level_mask(mvchip);
@@ -885,6 +903,10 @@ static const struct of_device_id mvebu_gpio_of_match[] = {
 		.data	    = (void *) MVEBU_GPIO_SOC_VARIANT_ORION,
 	},
 	{
+		.compatible = "marvell,armada-8k-gpio",
+		.data       = (void *) MVEBU_GPIO_SOC_VARIANT_A8K,
+	},
+	{
 		/* sentinel */
 	},
 };
@@ -894,16 +916,21 @@ static int mvebu_gpio_suspend(struct platform_device *pdev, pm_message_t state)
 	struct mvebu_gpio_chip *mvchip = platform_get_drvdata(pdev);
 	int i;
 
-	regmap_read(mvchip->regs, GPIO_OUT_OFF, &mvchip->out_reg);
-	regmap_read(mvchip->regs, GPIO_IO_CONF_OFF, &mvchip->io_conf_reg);
-	regmap_read(mvchip->regs, GPIO_BLINK_EN_OFF, &mvchip->blink_en_reg);
-	regmap_read(mvchip->regs, GPIO_IN_POL_OFF, &mvchip->in_pol_reg);
+	regmap_read(mvchip->regs, GPIO_OUT_OFF + mvchip->offset,
+		    &mvchip->out_reg);
+	regmap_read(mvchip->regs, GPIO_IO_CONF_OFF + mvchip->offset,
+		    &mvchip->io_conf_reg);
+	regmap_read(mvchip->regs, GPIO_BLINK_EN_OFF + mvchip->offset,
+		    &mvchip->blink_en_reg);
+	regmap_read(mvchip->regs, GPIO_IN_POL_OFF + mvchip->offset,
+		    &mvchip->in_pol_reg);
 
 	switch (mvchip->soc_variant) {
 	case MVEBU_GPIO_SOC_VARIANT_ORION:
-		regmap_read(mvchip->regs, GPIO_EDGE_MASK_OFF,
+	case MVEBU_GPIO_SOC_VARIANT_A8K:
+		regmap_read(mvchip->regs, GPIO_EDGE_MASK_OFF + mvchip->offset,
 			    &mvchip->edge_mask_regs[0]);
-		regmap_read(mvchip->regs, GPIO_LEVEL_MASK_OFF,
+		regmap_read(mvchip->regs, GPIO_LEVEL_MASK_OFF + mvchip->offset,
 			    &mvchip->level_mask_regs[0]);
 		break;
 	case MVEBU_GPIO_SOC_VARIANT_MV78200:
@@ -941,16 +968,21 @@ static int mvebu_gpio_resume(struct platform_device *pdev)
 	struct mvebu_gpio_chip *mvchip = platform_get_drvdata(pdev);
 	int i;
 
-	regmap_write(mvchip->regs, GPIO_OUT_OFF, mvchip->out_reg);
-	regmap_write(mvchip->regs, GPIO_IO_CONF_OFF, mvchip->io_conf_reg);
-	regmap_write(mvchip->regs, GPIO_BLINK_EN_OFF, mvchip->blink_en_reg);
-	regmap_write(mvchip->regs, GPIO_IN_POL_OFF, mvchip->in_pol_reg);
+	regmap_write(mvchip->regs, GPIO_OUT_OFF + mvchip->offset,
+		     mvchip->out_reg);
+	regmap_write(mvchip->regs, GPIO_IO_CONF_OFF + mvchip->offset,
+		     mvchip->io_conf_reg);
+	regmap_write(mvchip->regs, GPIO_BLINK_EN_OFF + mvchip->offset,
+		     mvchip->blink_en_reg);
+	regmap_write(mvchip->regs, GPIO_IN_POL_OFF + mvchip->offset,
+		     mvchip->in_pol_reg);
 
 	switch (mvchip->soc_variant) {
 	case MVEBU_GPIO_SOC_VARIANT_ORION:
-		regmap_write(mvchip->regs, GPIO_EDGE_MASK_OFF,
+	case MVEBU_GPIO_SOC_VARIANT_A8K:
+		regmap_write(mvchip->regs, GPIO_EDGE_MASK_OFF + mvchip->offset,
 			     mvchip->edge_mask_regs[0]);
-		regmap_write(mvchip->regs, GPIO_LEVEL_MASK_OFF,
+		regmap_write(mvchip->regs, GPIO_LEVEL_MASK_OFF + mvchip->offset,
 			     mvchip->level_mask_regs[0]);
 		break;
 	case MVEBU_GPIO_SOC_VARIANT_MV78200:
@@ -990,15 +1022,68 @@ static const struct regmap_config mvebu_gpio_regmap_config = {
 	.fast_io = true,
 };
 
+static int mvebu_gpio_probe_raw(struct platform_device *pdev,
+				struct mvebu_gpio_chip *mvchip)
+{
+	struct resource *res;
+	void __iomem *base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	mvchip->regs = devm_regmap_init_mmio(&pdev->dev, base,
+					     &mvebu_gpio_regmap_config);
+	if (IS_ERR(mvchip->regs))
+		return PTR_ERR(mvchip->regs);
+
+	/*
+	 * For the legacy SoCs, the regmap directly maps to the GPIO
+	 * registers, so no offset is needed.
+	 */
+	mvchip->offset = 0;
+
+	/*
+	 * The Armada XP has a second range of registers for the
+	 * per-CPU registers
+	 */
+	if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_ARMADAXP) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(base))
+			return PTR_ERR(base);
+
+		mvchip->percpu_regs =
+			devm_regmap_init_mmio(&pdev->dev, base,
+					      &mvebu_gpio_regmap_config);
+		if (IS_ERR(mvchip->percpu_regs))
+			return PTR_ERR(mvchip->percpu_regs);
+	}
+
+	return 0;
+}
+
+static int mvebu_gpio_probe_syscon(struct platform_device *pdev,
+				   struct mvebu_gpio_chip *mvchip)
+{
+	mvchip->regs = syscon_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(mvchip->regs))
+		return PTR_ERR(mvchip->regs);
+
+	if (of_property_read_u32(pdev->dev.of_node, "offset", &mvchip->offset))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int mvebu_gpio_probe(struct platform_device *pdev)
 {
 	struct mvebu_gpio_chip *mvchip;
 	const struct of_device_id *match;
 	struct device_node *np = pdev->dev.of_node;
-	struct resource *res;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
-	void __iomem *base;
 	unsigned int ngpios;
 	bool have_irqs;
 	int soc_variant;
@@ -1054,41 +1139,26 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	mvchip->chip.of_node = np;
 	mvchip->chip.dbg_show = mvebu_gpio_dbg_show;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	mvchip->regs = devm_regmap_init_mmio(&pdev->dev, base,
-					     &mvebu_gpio_regmap_config);
-	if (IS_ERR(mvchip->regs))
-		return PTR_ERR(mvchip->regs);
+	if (soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K)
+		err = mvebu_gpio_probe_syscon(pdev, mvchip);
+	else
+		err = mvebu_gpio_probe_raw(pdev, mvchip);
 
-	/*
-	 * The Armada XP has a second range of registers for the
-	 * per-CPU registers
-	 */
-	if (soc_variant == MVEBU_GPIO_SOC_VARIANT_ARMADAXP) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		base = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(base))
-			return PTR_ERR(base);
-
-		mvchip->percpu_regs =
-			devm_regmap_init_mmio(&pdev->dev, base,
-					      &mvebu_gpio_regmap_config);
-		if (IS_ERR(mvchip->percpu_regs))
-			return PTR_ERR(mvchip->percpu_regs);
-	}
+	if (err)
+		return err;
 
 	/*
 	 * Mask and clear GPIO interrupts.
 	 */
 	switch (soc_variant) {
 	case MVEBU_GPIO_SOC_VARIANT_ORION:
-		regmap_write(mvchip->regs, GPIO_EDGE_CAUSE_OFF, 0);
-		regmap_write(mvchip->regs, GPIO_EDGE_MASK_OFF, 0);
-		regmap_write(mvchip->regs, GPIO_LEVEL_MASK_OFF, 0);
+	case MVEBU_GPIO_SOC_VARIANT_A8K:
+		regmap_write(mvchip->regs,
+			     GPIO_EDGE_CAUSE_OFF + mvchip->offset, 0);
+		regmap_write(mvchip->regs,
+			     GPIO_EDGE_MASK_OFF + mvchip->offset, 0);
+		regmap_write(mvchip->regs,
+			     GPIO_LEVEL_MASK_OFF + mvchip->offset, 0);
 		break;
 	case MVEBU_GPIO_SOC_VARIANT_MV78200:
 		regmap_write(mvchip->regs, GPIO_EDGE_CAUSE_OFF, 0);
-- 
git-series 0.9.1
