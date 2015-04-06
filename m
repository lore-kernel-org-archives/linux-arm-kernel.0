From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 6 Apr 2015 18:44:28 +0200
Subject: [PATCH] power: add poodle battery driver
In-Reply-To: <1427714679-27472-1-git-send-email-dbaryshkov@gmail.com>
References: <1427714679-27472-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150406164428.GB18145@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

On Mon, Mar 30, 2015 at 02:24:39PM +0300, Dmitry Eremin-Solenikov wrote:
> Add a driver supporting battery charging on Sharp SL-5600 (poodle).
> Voltage and temperature readings are provided through add7846 hwmon
> interface. Battery voltage is in1_input (mV) and temp in in0_input
> (values unknown, but should be less than 2441).

You may want to convert add7846 to iio interface, which can be
exposed via hwmon and requested by other kernel drivers (e.g. this
one).

> [...]
> +struct poodle_bat {
> +	int status;
> +	struct power_supply psy;
> +
> +	struct mutex work_lock; /* protects data */
> +
> +	bool (*is_present)(struct poodle_bat *bat);
> +	int technology;

why do you need this for a static type? You can simply set the type
directly in the get_property function?

> +};

> [...]

> +static struct gpio poodle_batt_gpios[] = {
> +	{ POODLE_GPIO_BAT_COVER,    GPIOF_IN,		"main battery cover" },
> +	{ POODLE_GPIO_CHRG_FULL,    GPIOF_IN,		"main battery full" },
> +	{ POODLE_GPIO_JK_B,	    GPIOF_OUT_INIT_LOW,	"main charge on" },
> +	{ POODLE_GPIO_CHRG_ON,	    GPIOF_OUT_INIT_LOW,	"main charge on" },
> +	{ POODLE_GPIO_BYPASS_ON,    GPIOF_OUT_INIT_LOW,	"main charge bypass" },
> +	/* on for now */
> +	{ POODLE_GPIO_ADC_TEMP_ON,  GPIOF_OUT_INIT_HIGH, "main battery temp" },
> +};

I would prefer if you use the "new" gpiod interface, see
include/linux/gpio/consumer.h

This obviously refers to the whole driver.

> [...]

> +static int poodle_battery_probe(struct platform_device *dev)
> +{
> +	int ret;
> +
> +	ret = gpio_request_array(poodle_batt_gpios,
> +				 ARRAY_SIZE(poodle_batt_gpios));
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&poodle_bat_main.work_lock);
> +
> +	INIT_WORK(&bat_work, poodle_bat_work);
> +
> +	ret = power_supply_register(&dev->dev, &poodle_bat_main.psy);
> +	if (ret)
> +		goto err_psy_reg_main;

we have devm_power_supply_register() now.

> +	ret = devm_request_irq(&dev->dev, gpio_to_irq(POODLE_GPIO_CHRG_FULL),
> +				poodle_bat_gpio_isr,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				"main full", NULL);
> +	if (ret)
> +		goto err_psy_irq;
> +
> +	ret = devm_request_irq(&dev->dev, gpio_to_irq(POODLE_GPIO_BAT_COVER),
> +				poodle_bat_gpio_isr,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				"battery cover", NULL);
> +	if (ret)
> +		goto err_psy_irq;
> +
> +	return 0;
> +
> +err_psy_irq:
> +	power_supply_unregister(&poodle_bat_main.psy);
> +
> +	cancel_work_sync(&bat_work);
> +err_psy_reg_main:
> +	gpio_free_array(poodle_batt_gpios, ARRAY_SIZE(poodle_batt_gpios));
> +
> +	return ret;
> +}

> [...]

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/9d42b504/attachment.sig>
