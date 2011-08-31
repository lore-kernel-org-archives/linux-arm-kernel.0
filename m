From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 31 Aug 2011 17:45:20 +0800
Subject: [PATCH 1/4 v5] drivers: create a pin control subsystem v5
In-Reply-To: <1314609001-28052-1-git-send-email-linus.walleij@stericsson.com>
References: <1314609001-28052-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAGsJ_4yc+chiSh0wf_5sZk-Eh0vm-HSDZv+gFQi86LhCAUXTvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +Interaction with the GPIO subsystem
> +===================================
> +
> +The GPIO drivers may want to perform operations of various types on the
> same
> +physical pins that are also registered as GPIO pins.
> +
> +Since the pin controller subsystem have its pinspace local to the pin
> +controller we need a mapping so that the pin control subsystem can figure
> out
> +which pin controller handles control of a certain GPIO pin. Since a single
> +pin controller may be muxing several GPIO ranges (typically SoCs that have
> +one set of pins but internally several GPIO silicon blocks, each modeled as
> +a struct gpio_chip) any number of GPIO ranges can be added to a pin
> controller
> +instance like this:
> +
> +struct gpio_chip chip_a;
> +struct gpio_chip chip_b;
> +
> +static struct pinctrl_gpio_range gpio_range_a = {
> +	.name = "chip a",
> +	.id = 0,
> +	.base = 32,
> +	.npins = 16,
> +	.gc = &chip_a;
> +};
> +
> +static struct pinctrl_gpio_range gpio_range_a = {
> +	.name = "chip b",
> +	.id = 0,
> +	.base = 48,
> +	.npins = 8,
> +	.gc = &chip_b;
> +};
> +
> +
> +{
> +	struct pinctrl_dev *pctl;
> +	...
> +	pinctrl_add_gpio_range(pctl, &gpio_range_a);
> +	pinctrl_add_gpio_range(pctl, &gpio_range_b);

people might like a pinctrl_add_gpio_range*s* too.

-barry
