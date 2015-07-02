From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu,  2 Jul 2015 22:23:12 +0530
Subject: [RFC PATCH] pinctrl-single: Use of pinctrl-single for external device
 over I2C
Message-ID: <1435855992-10312-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disclaimer: This is just proof of concept, to trigger discussion on this.
As pinctrl-single driver is used by many platforms, we should be very careful
here.
I have kept couple of print statement delibrately to match regmap.

Summary:

In some usecases, the external device (in my case it PMIC over I2C)
does support pin in multiple configuration, we may need to control/configure them
during boot or runtime.

In my usecase of PMIC 88PM860, as per spec, 88PM860.GPIO_0 can be configured to

  000 = GPIO input mode
  001 = GPIO output mode
  010 = SLEEPOUTN mirror mode
  011 = Buck4 FPWM enable
  100 = 32 Khz output buffer mode
  101 = PMICINTN output mode
  110 = HW_RESET1 mode
  111 = HW_RESET2 mode

You can get more details on History or past discussion on this subject -
  https://lkml.org/lkml/2015/6/23/170

So we discussed about using pinctrl-single driver for this, but as we know,
pinctrl-single driver has some restrictions,
  - use raw read/write
  - use of raw spin lock api's

I started with writing fresh driver for pinctrl-i2c, but during that I felt
I am just duplicating all the code, so decided to see whether we can reuse
pinctrl-single driver.

So this patch is proof of concept for using pinctrl-single driver for external
devices, over I2C, SPI, etc...

The idea here is,
Represent external device as another 'pinctrl' device, and get hold of it's regmap
using dev_get_regmap() on parent. This works :)

Still I haven't figured out how to handle raw_spic_lock api's as I2C bus
may sleep and you can not disable preemption. So currently it does print anoying BUG
inside pcs_set_mux().

Testing:
  - I have tested this on BeagleBone Bloack
  - PXA1928 based platform for MMIO (PXA native muxing)
  - PMIC 88PM800 muxing (GPIO 0)

Comments are welcome...good, bad, accepted, nacked, acked, suggestions...

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 arch/arm64/boot/dts/marvell/pxa1928-helium.dts |  15 +++
 drivers/mfd/88pm800.c                          |  41 +++++++
 drivers/pinctrl/pinctrl-single.c               | 159 +++++++++++++------------
 3 files changed, 140 insertions(+), 75 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/pxa1928-helium.dts b/arch/arm64/boot/dts/marvell/pxa1928-helium.dts
index 91b7a1a..25967a6 100644
--- a/arch/arm64/boot/dts/marvell/pxa1928-helium.dts
+++ b/arch/arm64/boot/dts/marvell/pxa1928-helium.dts
@@ -138,6 +138,8 @@
 				status = "okay";
 				pmic1: 88pm860 at 30 {
 					compatible = "marvell,88pm800";
+					pinctrl-names = "default";
+					pinctrl-0 = <&gpio0_32khz_pins>;
 					reg = <0x30>;
 					interrupts = <0 77 0x4>;
 					interrupt-parent = <&gic>;
@@ -319,6 +321,19 @@
 							regulator-max-microvolt = <2800000>;
 						};
 					};
+					pinctrl-i2c {
+						compatible = "pinctrl-i2c";
+						status = "okay";
+
+						pinctrl-single,size = <0xff>;
+						pinctrl-single,function-mask = <0xff>;
+						pinctrl-single,register-width = <8>;
+
+						gpio0_32khz_pins: pinmux_gpio0_32khz_pins {
+							pinctrl-single,pins = <0x30 0x8>;
+						};
+
+					};
 					rtc {
 						compatible = "marvell,88pm80x-rtc";
 						status = "okay";
diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index ae2fbbd..3ca381e 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -128,6 +128,14 @@ static const struct of_device_id pm80x_of_match_table[] = {
 	{},
 };
 
+static struct mfd_cell pinctrl_devs[] = {
+	{
+	 .name = "pinctrl-i2c",
+	 .of_compatible = "pinctrl-i2c",
+	 .id = -1,
+	 },
+};
+
 static struct resource rtc_resources[] = {
 	{
 	 .name = "88pm80x-rtc",
@@ -338,6 +346,21 @@ static int device_onkey_init(struct pm80x_chip *chip,
 	return 0;
 }
 
+static int device_pinctrl_init(struct pm80x_chip *chip,
+					   struct pm80x_platform_data *pdata)
+{
+	int ret;
+
+	ret = mfd_add_devices(chip->dev, 0, &pinctrl_devs[0],
+			      ARRAY_SIZE(pinctrl_devs), NULL, 0, NULL);
+	if (ret) {
+		dev_err(chip->dev, "Failed to add pinctrl subdev\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int device_rtc_init(struct pm80x_chip *chip,
 				struct pm80x_platform_data *pdata)
 {
@@ -602,6 +625,12 @@ static int device_800_init(struct pm80x_chip *chip,
 		goto out_dev;
 	}
 
+	ret = device_pinctrl_init(chip, pdata);
+	if (ret) {
+		dev_err(chip->dev, "Failed to add pinctrl subdev\n");
+		goto out;
+	}
+
 	ret = device_rtc_init(chip, pdata);
 	if (ret) {
 		dev_err(chip->dev, "Failed to add rtc subdev\n");
@@ -751,6 +780,8 @@ static int pm800_probe(struct i2c_client *client,
 	struct pm80x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct device_node *np = client->dev.of_node;
 	struct pm80x_subchip *subchip;
+	struct pinctrl *p;
+	struct pinctrl_state *state_default;
 
 	if (!pdata && !np) {
 		dev_err(&client->dev,
@@ -775,6 +806,7 @@ static int pm800_probe(struct i2c_client *client,
 
 	chip = i2c_get_clientdata(client);
 
+	printk("%s:%d chip->regmap - %x\n", __func__, __LINE__, chip->regmap);
 	/* init subchip for PM800 */
 	subchip =
 	    devm_kzalloc(&client->dev, sizeof(struct pm80x_subchip),
@@ -811,6 +843,15 @@ static int pm800_probe(struct i2c_client *client,
 		goto err_device_init;
 	}
 
+	p = devm_pinctrl_get(&client->dev);
+	if (p) {
+		state_default = pinctrl_lookup_state(p, PINCTRL_STATE_DEFAULT);
+		if (IS_ERR(state_default))
+			dev_info(&client->dev, "missing default pinctrl state\n");
+		else
+			pinctrl_select_state(p, state_default);
+	}
+
 	/* System reboot notifier and shutdown callback */
 	chip->reboot_notifier.notifier_call = reboot_notifier_fn;
 	register_reboot_notifier(&(chip->reboot_notifier));
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index b2de09d..26042df 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>
+#include <linux/regmap.h>
 
 #include <linux/irqchip/chained_irq.h>
 
@@ -61,7 +62,7 @@ struct pcs_pingroup {
  * @val:	register value
  */
 struct pcs_func_vals {
-	void __iomem *reg;
+	unsigned int reg;
 	unsigned val;
 	unsigned mask;
 };
@@ -236,6 +237,8 @@ struct pcs_device {
 	unsigned ngroups;
 	unsigned nfuncs;
 	struct pinctrl_desc desc;
+	struct regmap *regmap;
+	struct regmap_config regmap_config;
 	unsigned (*read)(void __iomem *reg);
 	void (*write)(unsigned val, void __iomem *reg);
 };
@@ -263,34 +266,18 @@ static enum pin_config_param pcs_bias[] = {
  * does not help in this case.
  */
 
-static unsigned __maybe_unused pcs_readb(void __iomem *reg)
+static unsigned pcs_read(struct regmap *map, unsigned int reg)
 {
-	return readb(reg);
-}
+	unsigned int val;
 
-static unsigned __maybe_unused pcs_readw(void __iomem *reg)
-{
-	return readw(reg);
-}
-
-static unsigned __maybe_unused pcs_readl(void __iomem *reg)
-{
-	return readl(reg);
-}
-
-static void __maybe_unused pcs_writeb(unsigned val, void __iomem *reg)
-{
-	writeb(val, reg);
-}
+	regmap_read(map, reg, &val);
 
-static void __maybe_unused pcs_writew(unsigned val, void __iomem *reg)
-{
-	writew(val, reg);
+	return val;
 }
 
-static void __maybe_unused pcs_writel(unsigned val, void __iomem *reg)
+static void pcs_write(struct regmap *map, unsigned val, unsigned int reg)
 {
-	writel(val, reg);
+	regmap_write(map, reg, val);
 }
 
 static int pcs_get_groups_count(struct pinctrl_dev *pctldev)
@@ -351,7 +338,7 @@ static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
 	pcs = pinctrl_dev_get_drvdata(pctldev);
 
 	mux_bytes = pcs->width / BITS_PER_BYTE;
-	val = pcs->read(pcs->base + pin * mux_bytes);
+	val = pcs_read(pcs->regmap, pin * mux_bytes);
 
 	seq_printf(s, "%08x %s " , val, DRIVER_NAME);
 }
@@ -472,7 +459,7 @@ static int pcs_set_mux(struct pinctrl_dev *pctldev, unsigned fselector,
 
 		vals = &func->vals[i];
 		raw_spin_lock_irqsave(&pcs->lock, flags);
-		val = pcs->read(vals->reg);
+		val = pcs_read(pcs->regmap, vals->reg);
 
 		if (pcs->bits_per_mux)
 			mask = vals->mask;
@@ -481,7 +468,7 @@ static int pcs_set_mux(struct pinctrl_dev *pctldev, unsigned fselector,
 
 		val &= ~mask;
 		val |= (vals->val & mask);
-		pcs->write(val, vals->reg);
+		pcs_write(pcs->regmap, val, vals->reg);
 		raw_spin_unlock_irqrestore(&pcs->lock, flags);
 	}
 
@@ -507,9 +494,9 @@ static int pcs_request_gpio(struct pinctrl_dev *pctldev,
 			|| pin < frange->offset)
 			continue;
 		mux_bytes = pcs->width / BITS_PER_BYTE;
-		data = pcs->read(pcs->base + pin * mux_bytes) & ~pcs->fmask;
+		data = pcs_read(pcs->regmap, pin * mux_bytes) & ~pcs->fmask;
 		data |= frange->gpiofunc;
-		pcs->write(data, pcs->base + pin * mux_bytes);
+		pcs_write(pcs->regmap, data, pin * mux_bytes);
 		break;
 	}
 	return 0;
@@ -579,7 +566,7 @@ static int pcs_pinconf_get(struct pinctrl_dev *pctldev,
 		}
 
 		offset = pin * (pcs->width / BITS_PER_BYTE);
-		data = pcs->read(pcs->base + offset) & func->conf[i].mask;
+		data = pcs_read(pcs->regmap, offset) & func->conf[i].mask;
 		switch (func->conf[i].param) {
 		/* 4 parameters */
 		case PIN_CONFIG_BIAS_PULL_DOWN:
@@ -637,7 +624,7 @@ static int pcs_pinconf_set(struct pinctrl_dev *pctldev,
 				continue;
 
 			offset = pin * (pcs->width / BITS_PER_BYTE);
-			data = pcs->read(pcs->base + offset);
+			data = pcs_read(pcs->regmap, offset);
 			arg = pinconf_to_config_argument(configs[j]);
 			switch (func->conf[i].param) {
 			/* 2 parameters */
@@ -668,7 +655,7 @@ static int pcs_pinconf_set(struct pinctrl_dev *pctldev,
 			default:
 				return -ENOTSUPP;
 			}
-			pcs->write(data, pcs->base + offset);
+			pcs_write(pcs->regmap, data, offset);
 
 			break;
 		}
@@ -757,6 +744,7 @@ static int pcs_add_pin(struct pcs_device *pcs, unsigned offset,
 	struct pcs_soc_data *pcs_soc = &pcs->socdata;
 	struct pinctrl_pin_desc *pin;
 	struct pcs_name *pn;
+	resource_size_t start = 0;
 	int i;
 
 	i = pcs->pins.cur;
@@ -766,22 +754,25 @@ static int pcs_add_pin(struct pcs_device *pcs, unsigned offset,
 		return -ENOMEM;
 	}
 
+	if (pcs->res)
+		start = pcs->res->start;
+
 	if (pcs_soc->irq_enable_mask) {
 		unsigned val;
 
-		val = pcs->read(pcs->base + offset);
+		val = pcs_read(pcs->regmap, offset);
 		if (val & pcs_soc->irq_enable_mask) {
 			dev_dbg(pcs->dev, "irq enabled at boot for pin at %lx (%x), clearing\n",
-				(unsigned long)pcs->res->start + offset, val);
+				(unsigned long)start + offset, val);
 			val &= ~pcs_soc->irq_enable_mask;
-			pcs->write(val, pcs->base + offset);
+			pcs_write(pcs->regmap, val, offset);
 		}
 	}
 
 	pin = &pcs->pins.pa[i];
 	pn = &pcs->names[i];
 	sprintf(pn->name, "%lx.%u",
-		(unsigned long)pcs->res->start + offset, pin_pos);
+		(unsigned long)start + offset, pin_pos);
 	pin->name = pn->name;
 	pin->number = i;
 	pcs->pins.cur++;
@@ -1168,7 +1159,7 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 
 		offset = be32_to_cpup(mux + index++);
 		val = be32_to_cpup(mux + index++);
-		vals[found].reg = pcs->base + offset;
+		vals[found].reg = offset;
 		vals[found].val = val;
 
 		pin = pcs_get_pin_by_offset(pcs, offset);
@@ -1296,7 +1287,7 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 			}
 
 			vals[found].mask = submask;
-			vals[found].reg = pcs->base + offset;
+			vals[found].reg = offset;
 			vals[found].val = val_pos;
 
 			pin = pcs_get_pin_by_offset(pcs, offset);
@@ -1540,7 +1531,7 @@ static int pcs_add_gpio_func(struct device_node *node, struct pcs_device *pcs)
  * @node:	list node
  */
 struct pcs_interrupt {
-	void __iomem *reg;
+	unsigned int reg;
 	irq_hw_number_t hwirq;
 	unsigned int irq;
 	struct list_head node;
@@ -1570,12 +1561,12 @@ static inline void pcs_irq_set(struct pcs_soc_data *pcs_soc,
 
 		soc_mask = pcs_soc->irq_enable_mask;
 		raw_spin_lock(&pcs->lock);
-		mask = pcs->read(pcswi->reg);
+		mask = pcs_read(pcs->regmap, pcswi->reg);
 		if (enable)
 			mask |= soc_mask;
 		else
 			mask &= ~soc_mask;
-		pcs->write(mask, pcswi->reg);
+		pcs_write(pcs->regmap, mask, pcswi->reg);
 		raw_spin_unlock(&pcs->lock);
 	}
 
@@ -1644,7 +1635,7 @@ static int pcs_irq_handle(struct pcs_soc_data *pcs_soc)
 
 		pcswi = list_entry(pos, struct pcs_interrupt, node);
 		raw_spin_lock(&pcs->lock);
-		mask = pcs->read(pcswi->reg);
+		mask = pcs_read(pcs->regmap, pcswi->reg);
 		raw_spin_unlock(&pcs->lock);
 		if (mask & pcs_soc->irq_status_mask) {
 			generic_handle_irq(irq_find_mapping(pcs->domain,
@@ -1705,7 +1696,7 @@ static int pcs_irqdomain_map(struct irq_domain *d, unsigned int irq,
 	if (!pcswi)
 		return -ENOMEM;
 
-	pcswi->reg = pcs->base + hwirq;
+	pcswi->reg = hwirq;
 	pcswi->hwirq = hwirq;
 	pcswi->irq = irq;
 
@@ -1835,6 +1826,7 @@ static int pcs_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "could not allocate\n");
 		return -ENOMEM;
 	}
+
 	pcs->dev = &pdev->dev;
 	raw_spin_lock_init(&pcs->lock);
 	mutex_init(&pcs->mutex);
@@ -1868,47 +1860,63 @@ static int pcs_probe(struct platform_device *pdev)
 	pcs->bits_per_mux = of_property_read_bool(np,
 						  "pinctrl-single,bit-per-mux");
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(pcs->dev, "could not get resource\n");
-		return -ENODEV;
-	}
+	if (of_device_is_compatible(np, "pinctrl-i2c")) {
+		pcs->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 
-	pcs->res = devm_request_mem_region(pcs->dev, res->start,
-			resource_size(res), DRIVER_NAME);
-	if (!pcs->res) {
-		dev_err(pcs->dev, "could not get mem_region\n");
-		return -EBUSY;
-	}
+		PCS_GET_PROP_U32("pinctrl-single,size", &pcs->size,
+			 "size not specified\n");
+;
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res) {
+			dev_err(pcs->dev, "could not get resource\n");
+			return -ENODEV;
+		}
+
+		pcs->res = devm_request_mem_region(pcs->dev, res->start,
+				resource_size(res), DRIVER_NAME);
+		if (!pcs->res) {
+			dev_err(pcs->dev, "could not get mem_region\n");
+			return -EBUSY;
+		}
+
+		pcs->size = resource_size(pcs->res);
+		pcs->base = devm_ioremap(pcs->dev, pcs->res->start, pcs->size);
+		if (!pcs->base) {
+			dev_err(pcs->dev, "could not ioremap\n");
+			return -ENODEV;
+		}
+
+		switch (pcs->width) {
+			case 8:
+				pcs->regmap_config.reg_bits = 8;
+				pcs->regmap_config.val_bits = 8;
+				pcs->regmap_config.reg_stride = 1;
+				break;
+			case 16:
+				pcs->regmap_config.reg_bits = 16;
+				pcs->regmap_config.val_bits = 16;
+				pcs->regmap_config.reg_stride = 2;
+				break;
+			case 32:
+				pcs->regmap_config.reg_bits = 32;
+				pcs->regmap_config.val_bits = 32;
+				pcs->regmap_config.reg_stride = 4;
+				break;
+			default:
+				break;
+		}
+
+		pcs->regmap = regmap_init_mmio(&pdev->dev, pcs->base, &pcs->regmap_config);
 
-	pcs->size = resource_size(pcs->res);
-	pcs->base = devm_ioremap(pcs->dev, pcs->res->start, pcs->size);
-	if (!pcs->base) {
-		dev_err(pcs->dev, "could not ioremap\n");
-		return -ENODEV;
 	}
 
+	printk("%s:%d: regmap - %x size - %d\n", __func__ , __LINE__, pcs->regmap, pcs->size);
+
 	INIT_RADIX_TREE(&pcs->pgtree, GFP_KERNEL);
 	INIT_RADIX_TREE(&pcs->ftree, GFP_KERNEL);
 	platform_set_drvdata(pdev, pcs);
 
-	switch (pcs->width) {
-	case 8:
-		pcs->read = pcs_readb;
-		pcs->write = pcs_writeb;
-		break;
-	case 16:
-		pcs->read = pcs_readw;
-		pcs->write = pcs_writew;
-		break;
-	case 32:
-		pcs->read = pcs_readl;
-		pcs->write = pcs_writel;
-		break;
-	default:
-		break;
-	}
-
 	pcs->desc.name = DRIVER_NAME;
 	pcs->desc.pctlops = &pcs_pinctrl_ops;
 	pcs->desc.pmxops = &pcs_pinmux_ops;
@@ -2008,6 +2016,7 @@ static const struct of_device_id pcs_of_match[] = {
 	{ .compatible = "ti,am437-padconf", .data = &pinctrl_single_am437x },
 	{ .compatible = "pinctrl-single", .data = &pinctrl_single },
 	{ .compatible = "pinconf-single", .data = &pinconf_single },
+	{ .compatible = "pinctrl-i2c", .data = &pinctrl_single },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pcs_of_match);
-- 
1.9.1
