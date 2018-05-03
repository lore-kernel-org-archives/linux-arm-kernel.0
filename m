From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 3 May 2018 13:33:10 +0100
Subject: [PATCH] tty: implement a rx led trigger
In-Reply-To: <20180503100448.1350-1-u.kleine-koenig@pengutronix.de>
References: <20180503100448.1350-1-u.kleine-koenig@pengutronix.de>
Message-ID: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/18 11:04, Uwe Kleine-K?nig wrote:
[...]
> @@ -157,6 +158,18 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
>   
>   	tty_port_link_device(port, driver, index);
>   
> +	port->led_trigger_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
> +					      driver->name, index);
> +	if (!port->led_trigger_rx_name) {
> +		pr_err("Failed to allocate trigger name for %s%d\n",
> +		       driver->name, index);
> +		goto skip_trigger;

Hmm, isn't that a rather awkward way to spell "else"? ;)

Robin.

> +	}
> +
> +	led_trigger_register_simple(port->led_trigger_rx_name,
> +				    &port->led_trigger_rx);
> +
> +skip_trigger:
>   	dev = serdev_tty_port_register(port, device, driver, index);
>   	if (PTR_ERR(dev) != -ENODEV) {
>   		/* Skip creating cdev if we registered a serdev device */
