From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 Apr 2012 19:28:59 +0000
Subject: [PATCH RFC] gpio: Device tree support for LPC32xx
In-Reply-To: <1333376464-25712-1-git-send-email-stigge@antcom.de>
References: <1333376464-25712-1-git-send-email-stigge@antcom.de>
Message-ID: <201204021929.00107.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 April 2012, Roland Stigge wrote:

> 
> I'm adding device tree support to the LPC32xx platform. Currently struggling
> with GPIO, see patch below.
> 
> Generally, it works - GPIOs registered successfully like before:
> 
> ================================================================
> gpiochip_add: registered GPIOs 0 to 7 on device: gpio_p0
> gpiochip_add: registered GPIOs 8 to 31 on device: gpio_p1
> gpiochip_add: registered GPIOs 32 to 44 on device: gpio_p2
> gpiochip_add: registered GPIOs 45 to 50 on device: gpio_p3
> gpiochip_add: registered GPIOs 51 to 78 on device: gpi_p3
> gpiochip_add: registered GPIOs 79 to 102 on device: gpo_p3
> ================================================================
> 
> But in connection with gpio-leds which I'm using like this:
> 
>         leds {
>                 compatible = "gpio-leds";
>                 led0 {
>                         gpios = <&gpio 0x50 1>; /* GPIO 80, active low */
>                         linux,default-trigger = "heartbeat";
>                         default-state = "keep";
>                 };
>         };
> 
> I get the following error:

The gpio number must be local to the gpio_chip.
> 
> I suspect the strategy to do several gpiochip_add()s, ported from the non-DT
> platform code, doesn't work well with the of_* registration - e.g.,
> gpiochip_find() compares the static structs I'm registering with gpiochip_add()
> with another (of_node's) one not in the registeded list. Should the various
> GPIO areas be moved from lpc32xx_gpiochip[] to a dts file? So many callbacks
> and memory references in there...

Well, in the end, you need to do exactly one gpiochip_add() per of_node,
and you can get there either by increasing the number of of_nodes, or
by registering only one gpio_chip.

Given the design of your hardware, I would recommend doing the first.
If you don't want to fully describe all the differences between the
chips using DT properties, you can keep the array you have now, and
use sub-nodes that do not get turned into a platform_device, like

/ {
	gpio-controller at 40028000 {
		compatible = "nxp,lpc3250-gpio", "nxp,lpc32xx-gpio";
		/* create a private address space for enumeration */
		#address-cells = 1;
		#size-cells = 0;

		reg = <0x40028000 0x1000>;

		gpio-bank at 0 {
			gpio-controller;
			#gpio-cells = <2>;
			gpio-lines = <8>;
			reg = <0>;
			status = "okay";
		};
		
		gpio-bank at 1 {
			gpio-controller;
			#gpio-cells = <2>;
			gpio-lines = <24>;
			reg = <1>;
			status = "okay";
		};
		
		gpio-bank at 2 {
			gpio-controller;
			#gpio-cells = <2>;
			gpio-lines = <13>;
			reg = <2>;
			status = "okay";
		};
		
		gpio-bank at 3 {
			gpio-controller;
			#gpio-cells = <2>;
			gpio-lines = <6>;
			reg = <3>;
			status = "okay";
		};
		
		gpo-bank at 4 {
			gpio-controller;
			#gpio-cells = <2>;
			gpio-lines = <28>;
			reg = <4>;
			status = "okay";
		};
		
		gpi-bank at 5 {
			gpio-controller;
			#gpio-cells = <2>;
			gpio-lines = <24>;
			reg = <5>;
			status = "okay";
		};
	};
};

> -void __init lpc32xx_gpio_init(void)
> +static int __devinit lpc32xx_gpio_probe(struct platform_device *pdev)
>  {
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(lpc32xx_gpiochip); i++)
> +	for (i = 0; i < ARRAY_SIZE(lpc32xx_gpiochip); i++) {
> +#ifdef CONFIG_OF_GPIO
> +		lpc32xx_gpiochip[i].chip.of_node = pdev->dev.of_node;
> +#endif
>  		gpiochip_add(&lpc32xx_gpiochip[i].chip);
> +	}
> +
> +	return 0;

Then this can become

	for_each_child_of_node(pdev->dev.of_node, node) {
		if (of_device_is_available(node)) {
			u32 index;
			struct gpio_chip *chip;
			if (of_property_read_u32(node, reg, &index) < 0)
				continue; 
			if (index >= ARRAY_SIZE(lpc32xx_gpiochip)
				continue;
			chip = &lpc32xx_gpiochip[index].chip;
			chip->of_node = of_node_get(node);
			gpiochip_add(chip);
		}
	}

	Arnd
