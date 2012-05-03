From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 3 May 2012 10:48:25 +0200
Subject: [PATCH] gpio: Add simple poweroff-gpio driver
In-Reply-To: <1336033446-18949-1-git-send-email-jm@lentin.co.uk>
References: <20120501195603.GW25584@lunn.ch>
 <1336033446-18949-1-git-send-email-jm@lentin.co.uk>
Message-ID: <20120503084825.GD13023@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The main issue is where to put it. I'm not convinced that drivers/gpio
> is an appropriate home, however drivers/power and drivers/hwmon (where
> drivers with similar purpose live) contain frameworks this is not part
> of. drivers/mfd has some modules that can power off, but this is hardly
> multifunction :) Could also give in and use drivers/misc.
> 
> Feedback appreciated.

Humm, sorry, no idea...

> +static int __devinit gpio_poweroff_probe(struct platform_device *pdev)
> +{
> +	enum of_gpio_flags flags;
> +
> +	gpio_num = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
> +	if (gpio_num < 0) {
> +		pr_err("%s: Could not get GPIO configuration: %d",
> +		       __func__, gpio_num);
> +		return -ENODEV;
> +	}
> +	gpio_active_low = flags & OF_GPIO_ACTIVE_LOW;

If you look at the Kirkwood/Orion5x, most systems that could use this
are currently not DT enabled. So i think it needs old style
platform_data as well as OF.

> +static int __devexit gpio_poweroff_remove(struct platform_device *pdev)
> +{
> +	if (gpio_num)
> +		gpio_free(gpio_num);

GPIO 0 is a valid GPIO number. You should not need this check, since
if the probe function succeeded, you have a valid GPIO.

    Andrew
