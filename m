From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 21 Aug 2011 22:53:42 +0800
Subject: [PATCH 1/4 v4] drivers: create a pin control subsystem
In-Reply-To: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
References: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAGsJ_4yoE=ndOFApoHqG+zCWn+t66W+qrhsQqb9MfHCVjO79gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +Pinmux board/machine configuration
> +==================================
> +
> +Boards and machines define how a certain complete running system is put
> +together, including how GPIOs and devices are muxed, how regulators are
> +constrained and how the clock tree looks. Of course pinmux settings are also
> +part of this.
> +
> +A pinmux config for a machine looks pretty much like a simple regulator
> +configuration, so for the example array above we want to enable i2c and
> +spi on the second function mapping:
> +
> +#include <linux/pinctrl/machine.h>
> +
> +static struct pinmux_map pmx_mapping[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .function = "spi0-1",
> + ? ? ? ? ? ? ? .dev_name = "foo-spi.0",
> + ? ? ? ? ? ? ? .ctrl_dev_name = "pinctrl.0",
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .function = "i2c0",
> + ? ? ? ? ? ? ? .dev_name = "foo-i2c.0",
> + ? ? ? ? ? ? ? .ctrl_dev_name = "pinctrl.0",
> + ? ? ? },
> + ? ? ? {
> + ? ? ? ? ? ? ? .function = "mmc0-4bit",
> + ? ? ? ? ? ? ? .dev_name = "foo-mmc.0",
> + ? ? ? ? ? ? ? .ctrl_dev_name = "pinctrl.0",
> + ? ? ? },
> +};
> +
I have a little worry about how will this map work after all foo-spi,
foo-i2c, foo-mmc use DT. they will lose those simple name just
foo-spi.0, foo-spi.1, foo-spi.2 except that we use OF_DEV_AUXDATA_ID.
the actual device name might be foo-spi.200fee or something like that.
then this map will have the same problem with the current clock/device
mapping.
could we have a way to define the connection between device and pinmux
in DTS directly?

Thanks
barry
