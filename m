From: gmbnomis@gmail.com (Simon Baatz)
Date: Fri, 16 Nov 2012 20:25:25 +0100
Subject: [PATCH v2 1/3] power: Add simple poweroff-gpio driver
In-Reply-To: <1352821485-10032-2-git-send-email-andrew@lunn.ch>
References: <1352821485-10032-1-git-send-email-andrew@lunn.ch>
 <1352821485-10032-2-git-send-email-andrew@lunn.ch>
Message-ID: <20121116192525.GA25838@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tue, Nov 13, 2012 at 04:44:43PM +0100, Andrew Lunn wrote:
> From: Jamie Lentin <jm@lentin.co.uk>
> 
> Given appropriate devicetree bindings, this driver registers a
> pm_power_off function to set a GPIO line high/low to power down
> your board.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/gpio/gpio-poweroff.txt     |   22 ++++
>  drivers/power/Kconfig                              |    3 +
>  drivers/power/Makefile                             |    1 +
>  drivers/power/reset/Kconfig                        |   15 +++
>  drivers/power/reset/Makefile                       |    1 +
>  drivers/power/reset/gpio-poweroff.c                |  129 ++++++++++++++++++++
>  6 files changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
>  create mode 100644 drivers/power/reset/Kconfig
>  create mode 100644 drivers/power/reset/Makefile
>  create mode 100644 drivers/power/reset/gpio-poweroff.c
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt b/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
> new file mode 100644
> index 0000000..558cdf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
> @@ -0,0 +1,22 @@
> +GPIO line that should be set high/low to power off a device
> +
> +Required properties:
> +- compatible : should be "gpio-poweroff".
> +- gpios : The GPIO to set high/low, see "gpios property" in
> +  Documentation/devicetree/bindings/gpio/gpio.txt. If the pin should be
> +  low to power down the board set it to "Active Low", otherwise set
> +  gpio to "Active High".
> +
> +Optional properties:
> +- input : Initially configure the GPIO line as an input. Only reconfigure
> +  it to an output when the pm_power_off function is called. If this optional
> +  property is not specified, the GPIO is initialized as an output in its
> +  inactive state.
> +
> +
> +Examples:
> +
> +gpio-poweroff {
> +	compatible = "gpio-poweroff";
> +	gpios = <&gpio 4 0>; /* GPIO 4 Active Low */
> +};
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 49a8939..b1d956d 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -335,6 +335,9 @@ config AB8500_BATTERY_THERM_ON_BATCTRL
>  	help
>  	  Say Y to enable battery temperature measurements using
>  	  thermistor connected on BATCTRL ADC.
> +
> +source "drivers/power/reset/Kconfig"
> +
>  endif # POWER_SUPPLY
>  
>  source "drivers/power/avs/Kconfig"
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index b949cf8..f1d99f4 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -49,3 +49,4 @@ obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
>  obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
>  obj-$(CONFIG_POWER_AVS)		+= avs/
>  obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
> +obj-$(CONFIG_POWER_RESET)	+= reset/
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> new file mode 100644
> index 0000000..6461b48
> --- /dev/null
> +++ b/drivers/power/reset/Kconfig
> @@ -0,0 +1,15 @@
> +menuconfig POWER_RESET
> +	bool "Board level reset or power off"
> +	help
> +	  Provides a number of drivers which either reset a complete board
> +	  or shut it down, by manipulating the main power supply on the board.
> +
> +	  Say Y here to enable board reset and power off
> +
> +config POWER_RESET_GPIO
> +	bool "GPIO power-off driver"
> +	depends on OF_GPIO && POWER_RESET
> +	help
> +	  This driver supports turning off your board via a GPIO line.
> +	  If your board needs a GPIO high/low to power down, say Y and
> +	  create a binding in your devicetree.
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> new file mode 100644
> index 0000000..751488a
> --- /dev/null
> +++ b/drivers/power/reset/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
> diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
> new file mode 100644
> index 0000000..101ad57
> --- /dev/null
> +++ b/drivers/power/reset/gpio-poweroff.c
> @@ -0,0 +1,129 @@
> +/*
> + * Toggles a GPIO pin to power down a device
> + *
> + * Jamie Lentin <jm@lentin.co.uk>
> + * Andrew Lunn <andrew@lunn.ch>
> + *
> + * Copyright (C) 2012 Jamie Lentin
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_gpio.h>
> +#include <linux/module.h>
> +
> +/*
> + * Hold configuration here, cannot be more than one instance of the driver
> + * since pm_power_off itself is global.
> + */
> +static int gpio_num = -1;
> +static int gpio_active_low;
> +
> +static void gpio_poweroff_do_poweroff(void)
> +{
> +	BUG_ON(gpio_num == -1);
> +
> +	/* drive it active */
> +	gpio_direction_output(gpio_num, !gpio_active_low);
> +	mdelay(100);
> +	/* rising edge or drive inactive */
> +	gpio_set_value(gpio_num, gpio_active_low);
> +	mdelay(100);
> +	/* falling edge */
> +	gpio_set_value(gpio_num, !gpio_active_low);
> +
> +	/* give it some time */
> +	mdelay(100);

On the IB-NAS 6210 I need to increase this delay to a whopping 3000
milliseconds to suppress the warning (2000 is not enough).  Is it
acceptable to increase this to such a high value or do we need
another solution?

> +
> +	WARN_ON(1);
> ...

- Simon
