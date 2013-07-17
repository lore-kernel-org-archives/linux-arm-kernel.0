From: damien.riegel.ext@parrot.com (Damien Riegel)
Date: Wed, 17 Jul 2013 11:45:32 +0200
Subject: Issue with gpio and pinmux
Message-ID: <51E667BC.3070804@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


In our ARM-based SoC, we can multiplex up to 4 functions on each pin,
but we have an issue when using a pin as a gpio: it can still be muxed
as another function.

In the gpio driver, we delegate calls to "request" to
"pinctrl_request_gpio":

	static int p7gpio_request(struct gpio_chip *chip, unsigned int offset)
	{
		return pinctrl_request_gpio(chip->base + offset);
	}

	static const struct gpio_chip p7gpio_chip_defaults = {
		.request            = p7gpio_request,
		[...]
	};

pinctrl_request_gpio will result in a call to pin_request, which behaves
differently if we request a gpio or another function, so at kernel
level they are not exclusive, but at hardware level they must be.

To avoid conflicts, the workaround I use is to implement "request" and
"gpio_request_enable" as below in a pinctrl driver to make mux and gpio
exclusive. But I really feel like I should not do so and let the kernel
do this for me.

	static int p7ctl_enable_gpio(struct pinctrl_dev* pctl,
					struct pinctrl_gpio_range* range,
					unsigned int gpio)
	{
		struct pin_desc *desc;
		desc = pin_desc_get(pctl, gpio);
		if (desc->mux_owner)
			return -EBUSY;
		
		[...]
	}

	static int p7ctl_request(struct pinctrl_dev* pctl, unsigned int pin)
	{
		struct pin_desc *desc;
		desc = pin_desc_get(pctl, pin);
		if (desc->gpio_owner)
			return -EBUSY;

		return 0;
	}

	static struct pinmux_ops p7ctl_mux_ops = {
		.request                = p7ctl_request,
		.gpio_request_enable    = p7ctl_enable_gpio,
		[...]
	};

Is this solution correct or is there a better way to claim the mux when
using a pin as a gpio ?

Note: we are using a kernel based on 3.4.11, but as far as I can tell,
pinctrl_request_gpio have the same behavior in the upstream kernel.


Thanks,
Damien
