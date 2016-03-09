From: peter@korsgaard.com (Peter Korsgaard)
Date: Wed, 09 Mar 2016 14:20:16 +0100
Subject: [linux-sunxi] [PATCH 1/4] gpio: Add AXP209 GPIO driver
In-Reply-To: <1457520614-32239-2-git-send-email-maxime.ripard@free-electrons.com>
 (Maxime Ripard's message of "Wed, 9 Mar 2016 11:50:11 +0100")
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
 <1457520614-32239-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <87io0v23fz.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Maxime" == Maxime Ripard <maxime.ripard@free-electrons.com> writes:

 > The AXP209 PMIC has a bunch of GPIOs accessible, that are usually used to
 > control LEDs or backlight.

Do you find 3 'a bunch'? ;)

 > +static int axp20x_gpio_probe(struct platform_device *pdev)
 > +{
 > +	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 > +	struct axp20x_gpio *gpio;
 > +	int ret;
 > +
 > +	if (!of_device_is_available(pdev->dev.of_node))
 > +		return -ENODEV;
 > +
 > +	if (!axp20x) {
 > +		dev_err(&pdev->dev, "Parent drvdata not set\n");
 > +		return -EINVAL;
 > +	}
 > +
 > +	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
 > +	if (!gpio)
 > +		return -ENOMEM;
 > +
 > +	gpio->chip.base			= -1;
 > +	gpio->chip.can_sleep		= true;
 > +	gpio->chip.dev			= &pdev->dev;
 > +	gpio->chip.label		= dev_name(&pdev->dev);
 > +	gpio->chip.owner		= THIS_MODULE;
 > +	gpio->chip.get			= axp20x_gpio_get;
 > +	gpio->chip.set			= axp20x_gpio_set;
 > +	gpio->chip.direction_input	= axp20x_gpio_input;
 > +	gpio->chip.direction_output	= axp20x_gpio_output;
 > +	gpio->chip.ngpio		= 3;
 > +
 > +	gpio->regmap = axp20x->regmap;

This could just use dev_get_regmap(pdev.dev->parent, NULL) instead of
fiddling in the parent driver data.

 > +
 > +	ret = gpiochip_add(&gpio->chip);
 > +	if (ret) {
 > +		dev_err(&pdev->dev, "Failed to register GPIO chip\n");
 > +		return ret;
 > +	}
 > +
 > +	dev_info(&pdev->dev, "AXP209 GPIO driver loaded\n");

Any reason to be so noisy?

-- 
Bye, Peter Korsgaard
