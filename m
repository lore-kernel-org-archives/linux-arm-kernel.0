From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Nov 2012 10:38:06 -0700
Subject: [PATCH v3 1/3] power: Add simple poweroff-gpio driver
In-Reply-To: <1353142266-1289-2-git-send-email-andrew@lunn.ch>
References: <1353142266-1289-1-git-send-email-andrew@lunn.ch>
 <1353142266-1289-2-git-send-email-andrew@lunn.ch>
Message-ID: <50AA6E7E.5060501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2012 01:51 AM, Andrew Lunn wrote:
> Given appropriate devicetree bindings, this driver registers a
> pm_power_off function to set a GPIO line high/low to power down
> your board.

> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig

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

I assume CONFIG_POWER_RESET won't really provide any/much
infra-structure itself. So, does it make sense to put all the individual
drives inside "if POWER_RESET" or a menu definition, so they don't all
have to depend on POWER_RESET explicitly?

> diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c

> +static void gpio_poweroff_do_poweroff(void)
> +{
> +	BUG_ON(gpio_num == -1);

Perhaps use gpio_is_valid() here?

> +	/* drive it active */
> +	gpio_direction_output(gpio_num, !gpio_active_low);

The rest of the code below doesn't make a lot of sense to me. From
reading the binding documentation, it seems like the GPIO is expected to
be level-sensitive, and as such the above gpio_direction_output() call
should be all that's needed. What is the code below doing? If this
driver supports either a level-sensitive GPIO or generating a pulse on a
GPIO, I think the binding should be enhanced to specify which signalling
type is required. Also, all the delays should be specified as DT properties.

> +	mdelay(100);
> +	/* rising edge or drive inactive */

You can't assume that an active->inactive edge is a rising edge if you
allow the polarity to be configurable; I would remove that part of the
comment. Same below for "falling edge".

> +	gpio_set_value(gpio_num, gpio_active_low);
> +	mdelay(100);
> +	/* falling edge */
> +	gpio_set_value(gpio_num, !gpio_active_low);
> +
> +	/* give it some time */
> +	mdelay(3000);

> +static int __devinit gpio_poweroff_probe(struct platform_device *pdev)

> +	gpio_num = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
> +	if (gpio_num < 0) {

Perhaps use gpio_is_valid() here?

> +		pr_err("%s: Could not get GPIO configuration: %d",
> +		       __func__, gpio_num);
> +		return -ENODEV;
> +	}

This doesn't handle deferred probe correctly; if gpio_num ==
-EPROBE_DEFER, then this function needs to return -EPROBE_DEFER too; why
not "return gpio_num" rather than "return -ENODEV" above?

> +	gpio_active_low = flags & OF_GPIO_ACTIVE_LOW;
> +
> +	if (of_get_property(pdev->dev.of_node, "input", NULL))
> +		input = true;

Perhaps use of_property_read_bool() here.

> +static int __devexit gpio_poweroff_remove(struct platform_device *pdev)
> +{
> +	if (gpio_num != -1)
> +		gpio_free(gpio_num);

Perhaps use gpio_is_valid() here? Actually, how could this happen;
presumably if the GPIO is valid, probe() never succeeded, so you should
always just free the GPIO.

> +static struct platform_driver gpio_poweroff_driver = {
> +	.probe = gpio_poweroff_probe,
> +	.remove = __devexit_p(gpio_poweroff_remove),
> +	.driver = {
> +		   .name = "poweroff-gpio",
> +		   .owner = THIS_MODULE,
> +		   .of_match_table = of_gpio_poweroff_match,
> +		   },

There seems to be a mix of TAB/space indents there, and the closing }
should probably be aligned with the start of ".driver"?

> +MODULE_LICENSE("GPL");

That should be "GPL v2".
