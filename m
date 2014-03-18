From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 18 Mar 2014 09:50:02 +0000
Subject: [PATCH v2 3/8] input: misc: Add driver for AXP20x Power Enable Key
In-Reply-To: <20140318090013.GU27873@lukather>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-4-git-send-email-carlo@caione.org>
 <20140318090013.GU27873@lukather>
Message-ID: <20140318095002.GM25478@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > This patch add support for the Power Enable Key found on MFD AXP202 and
> > AXP209. Besides the basic support for the button, the driver adds two
> > entries in sysfs to configure the time delay for power on/off.
> > 
> > Signed-off-by: Carlo Caione <carlo@caione.org>
> > ---
> >  drivers/input/misc/Kconfig      |  11 ++
> >  drivers/input/misc/Makefile     |   1 +
> >  drivers/input/misc/axp20x-pek.c | 267 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 279 insertions(+)
> >  create mode 100644 drivers/input/misc/axp20x-pek.c
> 
> From what I understood of the MFD framework, you usually have a MFD
> core driver that gets loaded from the DT and instantiate its various
> functions through sub-devices, that are registered through
> mfd_add_devices, and the drivers for these sub-devices are supported
> in sub-drivers that are located in the driver/mfd, alongside the core
> driver.
> 
> I believe that such a pattern allows for two interesting things:
>   - You don't have to search around the whole kernel tree to find
>     where a given sub-feature is supported.
>   - You don't have to cripple your DT with instantiation of all the
>     subcomponents, while you only really have one device.
> 
> Do you have a reason for not following this pattern?

Sorry Maxime, this is not the case.

If an MFD contains Regulators and USB & GPIO Controllers, I'd expect
to see the device represented in the following way:

  drivers/mfd/<id>.c
  drivers/{gpio,pinctrl}/{gpio,pinctrl}-<id>.c
  drivers/regulator/<id>-regulator.c
  drivers/usb/host/<id>.c

> > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> > index 7904ab0..87244fb 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -393,6 +393,17 @@ config INPUT_RETU_PWRBUTTON
> >  	  To compile this driver as a module, choose M here. The module will
> >  	  be called retu-pwrbutton.
> >  
> > +config INPUT_AXP20X_PEK
> > +	tristate "X-Powers AXP20X power button driver"
> > +	depends on MFD_AXP20X
> > +	help
> > +	  Say Y here if you want to enable power key reporting via the
> > +	  AXP20X PMIC.
> > +
> > +	  To compile this driver as a module, choose M here. The module will
> > +	  be called axp20x-pek.
> > +
> > +
> >  config INPUT_TWL4030_PWRBUTTON
> >  	tristate "TWL4030 Power button Driver"
> >  	depends on TWL4030_CORE
> > diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> > index cda71fc..624abf5 100644
> > --- a/drivers/input/misc/Makefile
> > +++ b/drivers/input/misc/Makefile
> > @@ -50,6 +50,7 @@ obj-$(CONFIG_INPUT_POWERMATE)		+= powermate.o
> >  obj-$(CONFIG_INPUT_PWM_BEEPER)		+= pwm-beeper.o
> >  obj-$(CONFIG_INPUT_RB532_BUTTON)	+= rb532_button.o
> >  obj-$(CONFIG_INPUT_RETU_PWRBUTTON)	+= retu-pwrbutton.o
> > +obj-$(CONFIG_INPUT_AXP20X_PEK)		+= axp20x-pek.o
> >  obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+= rotary_encoder.o
> >  obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
> >  obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
> > diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
> > new file mode 100644
> > index 0000000..060212f
> > --- /dev/null
> > +++ b/drivers/input/misc/axp20x-pek.c
> > @@ -0,0 +1,267 @@
> > +/*
> > + * axp20x power button driver.
> > + *
> > + * Copyright (C) 2013 Carlo Caione <carlo@caione.org>
> > + *
> > + * This file is subject to the terms and conditions of the GNU General
> > + * Public License. See the file "COPYING" in the main directory of this
> > + * archive for more details.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/errno.h>
> > +#include <linux/irq.h>
> > +#include <linux/init.h>
> > +#include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/axp20x.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +#define AXP20X_PEK_STARTUP_MASK		(0xc0)
> > +#define AXP20X_PEK_SHUTDOWN_MASK	(0x03)
> > +
> > +static const char const *startup_time[] = { "128ms", "3s" , "1s", "2s" };
> > +static const char const *shutdown_time[] = { "4s", "6s" , "8s", "10s" };
> > +
> > +struct axp20x_pek {
> > +	struct axp20x_dev *axp20x;
> > +	struct input_dev *input;
> > +	int irq_dbr;
> > +	int irq_dbf;
> > +};
> > +
> > +struct axp20x_pek_ext_attr {
> > +	const char const **str;
> > +	unsigned int mask;
> > +};
> > +
> > +static struct axp20x_pek_ext_attr axp20x_pek_startup_ext_attr = {
> > +	.str	= startup_time,
> > +	.mask	= AXP20X_PEK_STARTUP_MASK,
> > +};
> > +
> > +static struct axp20x_pek_ext_attr axp20x_pek_shutdown_ext_attr = {
> > +	.str	= shutdown_time,
> > +	.mask	= AXP20X_PEK_SHUTDOWN_MASK,
> > +};
> > +
> > +static struct axp20x_pek_ext_attr *get_axp_ext_attr(struct device_attribute *attr)
> > +{
> > +	return container_of(attr, struct dev_ext_attribute, attr)->var;
> > +}
> > +
> > +static ssize_t axp20x_show_ext_attr(struct device *dev, struct device_attribute *attr,
> > +			     char *buf)
> > +{
> > +	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
> > +	struct axp20x_pek_ext_attr *axp20x_ea = get_axp_ext_attr(attr);
> > +	unsigned int val;
> > +	int ret, i;
> > +	int cnt = 0;
> > +
> > +	ret = regmap_read(axp20x_pek->axp20x->regmap, AXP20X_PEK_KEY, &val);
> > +	if (ret != 0)
> > +		return ret;
> > +
> > +	val &= axp20x_ea->mask;
> > +	val >>= ffs(axp20x_ea->mask) - 1;
> > +
> > +	for (i = 0; i < 4; i++) {
> > +		if (val == i)
> > +			cnt += sprintf(buf + cnt, "[%s] ", axp20x_ea->str[i]);
> > +		else
> > +			cnt += sprintf(buf + cnt, "%s ", axp20x_ea->str[i]);
> > +	}
> > +
> > +	cnt += sprintf(buf + cnt, "\n");
> > +
> > +	return cnt;
> > +}
> > +
> > +static ssize_t axp20x_store_ext_attr(struct device *dev, struct device_attribute *attr,
> > +			      const char *buf, size_t count)
> > +{
> > +	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
> > +	struct axp20x_pek_ext_attr *axp20x_ea = get_axp_ext_attr(attr);
> > +	char val_str[20];
> > +	int ret, i;
> > +	size_t len;
> > +
> > +	val_str[sizeof(val_str) - 1] = '\0';
> > +	strncpy(val_str, buf, sizeof(val_str) - 1);
> > +	len = strlen(val_str);
> > +
> > +	if (len && val_str[len - 1] == '\n')
> > +		val_str[len - 1] = '\0';
> > +
> > +	for (i = 0; i < 4; i++) {
> > +		if (!strcmp(val_str, axp20x_ea->str[i])) {
> > +
> > +			i <<= ffs(axp20x_ea->mask) - 1;
> > +			ret = regmap_update_bits(axp20x_pek->axp20x->regmap,
> > +						 AXP20X_PEK_KEY,
> > +						 axp20x_ea->mask, i);
> > +			if (ret != 0)
> > +				return -EINVAL;
> > +			return count;
> > +		}
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static struct dev_ext_attribute axp20x_dev_attr_startup = {
> > +	.attr	= __ATTR(startup, 0644, axp20x_show_ext_attr, axp20x_store_ext_attr),
> > +	.var	= &axp20x_pek_startup_ext_attr
> > +};
> > +
> > +static struct dev_ext_attribute axp20x_dev_attr_shutdown = {
> > +	__ATTR(shutdown, 0644, axp20x_show_ext_attr, axp20x_store_ext_attr),
> > +	&axp20x_pek_shutdown_ext_attr
> > +};
> > +
> > +static struct attribute *dev_attrs[] = {
> > +	&axp20x_dev_attr_startup.attr.attr,
> > +	&axp20x_dev_attr_shutdown.attr.attr,
> > +	NULL,
> > +};
> > +
> > +static struct attribute_group dev_attr_group = {
> > +	.attrs	= dev_attrs,
> > +};
> > +
> > +static const struct attribute_group *dev_attr_groups[] = {
> > +	&dev_attr_group,
> > +	NULL,
> > +};
> > +
> > +static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
> > +{
> > +	struct input_dev *idev = pwr;
> > +	struct axp20x_pek *axp20x_pek = input_get_drvdata(idev);
> > +
> > +	if (irq == axp20x_pek->irq_dbr)
> > +		input_report_key(idev, KEY_POWER, true);
> > +	else if (irq == axp20x_pek->irq_dbf)
> > +		input_report_key(idev, KEY_POWER, false);
> > +
> > +	input_sync(idev);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int axp20x_pek_probe(struct platform_device *pdev)
> > +{
> > +	struct axp20x_pek *axp20x_pek;
> > +	struct axp20x_dev *axp20x;
> > +	struct input_dev *idev;
> > +	int error;
> > +
> > +	axp20x_pek = devm_kzalloc(&pdev->dev, sizeof(struct axp20x_pek),
> > +				  GFP_KERNEL);
> > +	if (!axp20x_pek)
> > +		return -ENOMEM;
> > +
> > +	axp20x_pek->axp20x = dev_get_drvdata(pdev->dev.parent);
> > +	axp20x = axp20x_pek->axp20x;
> > +
> > +	axp20x_pek->irq_dbr = platform_get_irq_byname(pdev, "PEK_DBR");
> > +	if (axp20x_pek->irq_dbr < 0) {
> > +		dev_err(&pdev->dev, "No IRQ for PEK_DBR, error=%d\n",
> > +				axp20x_pek->irq_dbr);
> > +		return axp20x_pek->irq_dbr;
> > +	}
> > +	axp20x_pek->irq_dbr = regmap_irq_get_virq(axp20x->regmap_irqc,
> > +						  axp20x_pek->irq_dbr);
> > +
> > +	axp20x_pek->irq_dbf = platform_get_irq_byname(pdev, "PEK_DBF");
> > +	if (axp20x_pek->irq_dbf < 0) {
> > +		dev_err(&pdev->dev, "No IRQ for PEK_DBF, error=%d\n",
> > +				axp20x_pek->irq_dbf);
> > +		return axp20x_pek->irq_dbf;
> > +	}
> > +	axp20x_pek->irq_dbf = regmap_irq_get_virq(axp20x->regmap_irqc,
> > +						  axp20x_pek->irq_dbf);
> > +
> > +	axp20x_pek->input = devm_input_allocate_device(&pdev->dev);
> > +	if (!axp20x_pek->input)
> > +		return -ENOMEM;
> > +
> > +	idev = axp20x_pek->input;
> > +
> > +	idev->name = "axp20x-pek";
> > +	idev->phys = "m1kbd/input2";
> > +	idev->dev.parent = &pdev->dev;
> > +
> > +	input_set_capability(idev, EV_KEY, KEY_POWER);
> > +
> > +	input_set_drvdata(idev, axp20x_pek);
> > +
> > +	error = devm_request_threaded_irq(&pdev->dev, axp20x_pek->irq_dbr,
> > +					  NULL, axp20x_pek_irq, 0,
> > +					  "axp20x-pek-dbr", idev);
> > +	if (error) {
> > +		dev_err(axp20x->dev, "Failed to request dbr IRQ#%d: %d\n",
> > +			axp20x_pek->irq_dbr, error);
> > +
> > +		return error;
> > +	}
> > +
> > +	error = devm_request_threaded_irq(&pdev->dev, axp20x_pek->irq_dbf,
> > +					  NULL, axp20x_pek_irq, 0,
> > +					  "axp20x-pek-dbf", idev);
> > +	if (error) {
> > +		dev_err(axp20x->dev, "Failed to request dbf IRQ#%d: %d\n",
> > +			axp20x_pek->irq_dbf, error);
> > +		return error;
> > +	}
> > +
> > +	idev->dev.groups = dev_attr_groups;
> > +	error = input_register_device(idev);
> > +	if (error) {
> > +		dev_err(axp20x->dev, "Can't register input device: %d\n", error);
> > +		return error;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, axp20x_pek);
> > +
> > +	return 0;
> > +}
> > +
> > +static int axp20x_pek_remove(struct platform_device *pdev)
> > +{
> > +	struct axp20x_pek *axp20x_pek = platform_get_drvdata(pdev);
> > +
> > +	input_unregister_device(axp20x_pek->input);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id axp20x_pek_match[] = {
> > +	{ .compatible = "x-powers,axp20x-pek", },
> 
> No pattern-matching compatible strings please.
> 
> Thanks!
> Maxime
> 



-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
