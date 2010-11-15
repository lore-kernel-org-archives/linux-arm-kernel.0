From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 16 Nov 2010 11:38:09 +1300
Subject: [PATCH v5 08/12] gpio: add ti-ssp gpio driver
In-Reply-To: <1289848334-8695-9-git-send-email-cyril@ti.com>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-9-git-send-email-cyril@ti.com>
Message-ID: <4CE1B651.1060006@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2010 08:12 AM, Cyril Chemparathy wrote:
> TI's SSP controller pins can be directly read and written to behave like a
> GPIO.  This patch adds a GPIO driver that exposes such functionality.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> ---
>  drivers/mfd/Kconfig        |   10 ++
>  drivers/mfd/Makefile       |    1 +
>  drivers/mfd/ti-ssp-gpio.c  |  205 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/ti_ssp.h |    4 +
>  4 files changed, 220 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mfd/ti-ssp-gpio.c

Should go under drivers/gpio. This is not a multifunction driver.

> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/ti_ssp.h>
> +
> +struct ti_ssp_gpio {

This is a confusing name because it sounds like this struct maps to a
single gpio rather than bank. Perhaps a better name is ti_ssp_gpio_chip?

> +	struct gpio_chip		chip;
> +#define chip2gpio(chip)	container_of(chip, struct ti_ssp_gpio, chip)

Please don't put #define's in the middle of a struct. Move it either
before or after the structure definition. It is also confusingly named,
something like to_ti_ssp_gpio_chip might be better.

> +static int value_get(struct gpio_chip *chip, unsigned gpio_num)
> +{
> +	struct ti_ssp_gpio *gpio = chip2gpio(chip);
> +	int ret;
> +
> +	spin_lock(&gpio->lock);
> +
> +	ret = ti_ssp_raw_read(gpio->dev);
> +	if (ret >= 0)
> +		ret = (ret & BIT(gpio_num)) ? 1 : 0;

		ret = !!(ret & BIT(gpio_num));

> +
> +	spin_unlock(&gpio->lock);
> +	return ret;
> +}

> +static int __devinit ti_ssp_gpio_probe(struct platform_device *pdev)
> +{
> +	const struct ti_ssp_gpio_data *pdata = pdev->dev.platform_data;
> +	struct device *dev = &pdev->dev;
> +	struct ti_ssp_gpio *gpio;
> +	int error;
> +
> +	if (!pdata) {
> +		dev_err(dev, "platform data not found\n");
> +		return -EINVAL;
> +	}
> +
> +	gpio = kzalloc(sizeof(*gpio), GFP_KERNEL);
> +	if (!gpio) {
> +		dev_err(dev, "cannot allocate driver data\n");
> +		return -ENOMEM;
> +	}
> +
> +	gpio->dev = dev;
> +	gpio->iosel = SSP_PIN_SEL(0, SSP_IN) | SSP_PIN_SEL(1, SSP_IN) |
> +		      SSP_PIN_SEL(2, SSP_IN) | SSP_PIN_SEL(3, SSP_IN);
> +	error = ti_ssp_set_iosel(gpio->dev, gpio->iosel);
> +	if (error < 0) {
> +		dev_err(dev, "gpio io setup failed (%d)\n", error);
> +		goto error;
> +	}
> +
> +	spin_lock_init(&gpio->lock);
> +	platform_set_drvdata(pdev, gpio);
> +
> +	gpio->chip.base  = pdata->start;
> +	gpio->chip.ngpio = 4;

Is this always four or can the SSP peripheral be configured to have
varying numbers of gpios. Maybe the number of gpios should be passed via
platform data?

> +	gpio->chip.dev   = &pdev->dev;
> +	gpio->chip.label = "ti_ssp_gpio";
> +	gpio->chip.owner = THIS_MODULE;
> +	gpio->chip.get   = value_get;
> +	gpio->chip.set   = value_set;
> +	gpio->chip.direction_input  = direction_in;
> +	gpio->chip.direction_output = direction_out;
> +
> +	error = gpiochip_add(&gpio->chip);
> +	if (error < 0) {
> +		dev_err(dev, "gpio chip registration failed (%d)\n", error);
> +		goto error;
> +	}
> +
> +	dev_info(dev, "ssp gpio interface registered\n");
> +	return 0;
> +
> +error:
> +	kfree(gpio);
> +	return error;
> +}

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
