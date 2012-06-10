From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 10 Jun 2012 13:18:49 -0400
Subject: [PATCH 8/9] ARM: Kirkwood: Add DT support for GPIO controllers
In-Reply-To: <1339324322-29388-9-git-send-email-andrew@lunn.ch>
References: <1339324322-29388-9-git-send-email-andrew@lunn.ch>
Message-ID: <20120610171848.GZ14756@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 12:32:00PM +0200, Andrew Lunn wrote:
> The GPIO controllers can now be described in DT. Origionally GPIO
> controllers were instantiated during IRQ setup. The origional none-DT

nit.  "non-DT"

> code has been split out, and is only called if no DT GPIO controllers
> are found.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Jason Cooper <jason@lakedaemon.net>

> ---
>  .../devicetree/bindings/gpio/mrvl-gpio.txt         |   25 +++++++
>  arch/arm/boot/dts/kirkwood.dtsi                    |   20 ++++++
>  arch/arm/mach-kirkwood/irq.c                       |   20 ++++--
>  arch/arm/plat-orion/gpio.c                         |   68 +++++++++++++++++++-
>  arch/arm/plat-orion/include/plat/gpio.h            |    2 +
>  5 files changed, 126 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
> index 05428f3..d94ebc1 100644
> --- a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
> @@ -27,3 +27,28 @@ Example:
>  		interrupt-controller;
>  		#interrupt-cells = <1>;
>        };
> +
> +* Marvell Orion GPIO Controller
> +
> +Required properties:
> +- compatible         : Should be "marvell,orion-gpio"
> +- reg                : Address and length of the register set for controller.
> +- gpio-controller    : So we know this is a gpio controller.
> +- gpio-base          : Number of first gpio pin.
> +- ngpio              : How many gpios this controller has.
> +- secondary-irq-base : IRQ number base
> +
> +Optional properties:
> +- mask-offset        : For SMP Orions, offset for Nth CPU
> +
> +Example:
> +
> +	gpio0: gpio at 10100 {
> +		compatible = "marvell,orion-gpio";
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		reg = <0x10100 0x40>;
> +		gpio-base = <0>;
> +		ngpio = <32>;
> +		secondary-irq-base = <64>;
> +	};
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 3091c01..6de66dc 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -18,6 +18,26 @@
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  
> +		gpio0: gpio at 10100 {
> +			compatible = "marvell,orion-gpio";
> +			#gpio-cells = <2>;
> +			gpio-controller;
> +			reg = <0x10100 0x40>;
> +			gpio-base = <0>;
> +			ngpio = <32>;
> +			secondary-irq-base = <64>;
> +		};
> +
> +		gpio1: gpio at 10140 {
> +			compatible = "marvell,orion-gpio";
> +			#gpio-cells = <2>;
> +			gpio-controller;
> +			reg = <0x10140 0x40>;
> +			gpio-base = <32>;
> +			ngpio = <18>;
> +			secondary-irq-base = <96>;
> +		};
> +
>  		serial at 12000 {
>  			compatible = "ns16550a";
>  			reg = <0x12000 0x100>;
> diff --git a/arch/arm/mach-kirkwood/irq.c b/arch/arm/mach-kirkwood/irq.c
> index c4c68e5..81340c2 100644
> --- a/arch/arm/mach-kirkwood/irq.c
> +++ b/arch/arm/mach-kirkwood/irq.c
> @@ -24,25 +24,33 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  	orion_gpio_irq_handler((irq - IRQ_KIRKWOOD_GPIO_LOW_0_7) << 3);
>  }
>  
> -void __init kirkwood_init_irq(void)
> +static void __init kirkwood_init_gpio(void)
>  {
> -	orion_irq_init(0, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF));
> -	orion_irq_init(32, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF));
> -
>  	/*
>  	 * Initialize gpiolib for GPIOs 0-49.
>  	 */
>  	orion_gpio_init(0, 32, GPIO_LOW_VIRT_BASE, 0,
>  			IRQ_KIRKWOOD_GPIO_START);
> +	orion_gpio_init(32, 18, GPIO_HIGH_VIRT_BASE, 0,
> +			IRQ_KIRKWOOD_GPIO_START + 32);
> +}
> +void __init kirkwood_init_irq(void)
> +{
> +	orion_irq_init(0, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF));
> +	orion_irq_init(32, (void __iomem *)(IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF));
> +
>  	irq_set_chained_handler(IRQ_KIRKWOOD_GPIO_LOW_0_7, gpio_irq_handler);
>  	irq_set_chained_handler(IRQ_KIRKWOOD_GPIO_LOW_8_15, gpio_irq_handler);
>  	irq_set_chained_handler(IRQ_KIRKWOOD_GPIO_LOW_16_23, gpio_irq_handler);
>  	irq_set_chained_handler(IRQ_KIRKWOOD_GPIO_LOW_24_31, gpio_irq_handler);
>  
> -	orion_gpio_init(32, 18, GPIO_HIGH_VIRT_BASE, 0,
> -			IRQ_KIRKWOOD_GPIO_START + 32);
>  	irq_set_chained_handler(IRQ_KIRKWOOD_GPIO_HIGH_0_7, gpio_irq_handler);
>  	irq_set_chained_handler(IRQ_KIRKWOOD_GPIO_HIGH_8_15, gpio_irq_handler);
>  	irq_set_chained_handler(IRQ_KIRKWOOD_GPIO_HIGH_16_23,
>  				gpio_irq_handler);
> +
> +	/* Try initializing the GPIO controllers via DT.  If zero
> +	   controllers are found, fall back to hard coded values */
> +	if (orion_gpio_init_dt() == 0)
> +		kirkwood_init_gpio();
>  }
> diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
> index af95af2..cc29367 100644
> --- a/arch/arm/plat-orion/gpio.c
> +++ b/arch/arm/plat-orion/gpio.c
> @@ -17,6 +17,9 @@
>  #include <linux/io.h>
>  #include <linux/gpio.h>
>  #include <linux/leds.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <plat/gpio.h>
>  
>  /*
>   * GPIO unit register offsets.
> @@ -401,8 +404,9 @@ static int gpio_irq_set_type(struct irq_data *d, u32 type)
>  	return 0;
>  }
>  
> -void __init orion_gpio_init(int gpio_base, int ngpio,
> -			    u32 base, int mask_offset, int secondary_irq_base)
> +void __init _orion_gpio_init(int gpio_base, int ngpio,
> +			    void __iomem *base, int mask_offset,
> +			     int secondary_irq_base, struct device_node *np)
>  {
>  	struct orion_gpio_chip *ochip;
>  	struct irq_chip_generic *gc;
> @@ -426,8 +430,11 @@ void __init orion_gpio_init(int gpio_base, int ngpio,
>  	ochip->chip.base = gpio_base;
>  	ochip->chip.ngpio = ngpio;
>  	ochip->chip.can_sleep = 0;
> +#ifdef CONFIG_OF
> +	ochip->chip.of_node = np;
> +#endif
>  	spin_lock_init(&ochip->lock);
> -	ochip->base = (void __iomem *)base;
> +	ochip->base = base;
>  	ochip->valid_input = 0;
>  	ochip->valid_output = 0;
>  	ochip->mask_offset = mask_offset;
> @@ -469,6 +476,15 @@ void __init orion_gpio_init(int gpio_base, int ngpio,
>  			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
>  }
>  
> +/* None DT version */
> +void __init orion_gpio_init(int gpio_base, int ngpio,
> +			    u32 base, int mask_offset, int secondary_irq_base)
> +
> +{
> +	_orion_gpio_init(gpio_base, ngpio, (void __iomem *)base,
> +			 mask_offset, secondary_irq_base, NULL);
> +}
> +
>  void orion_gpio_irq_handler(int pinoff)
>  {
>  	struct orion_gpio_chip *ochip;
> @@ -502,3 +518,49 @@ void orion_gpio_irq_handler(int pinoff)
>  		generic_handle_irq(irq);
>  	}
>  }
> +
> +/* Configure all the gpio chips we can find. Return the number
> + * actually configured, so that we can fall back to the old way,
> + * for none-DT platforms.*/
> +#ifdef CONFIG_OF
> +int __init orion_gpio_init_dt(void)
> +{
> +	int chips = 0;
> +
> +	struct device_node *np = NULL;
> +	int gpio_base, ngpio, mask_offset, secondary_irq_base;
> +	void __iomem *base;
> +	int ret;
> +
> +	for_each_compatible_node(np, NULL, "marvell,orion-gpio") {
> +		ret = of_property_read_u32(np, "gpio-base", &gpio_base);
> +		if (ret)
> +			continue;
> +		ret = of_property_read_u32(np, "ngpio", &ngpio);
> +		if (ret)
> +			continue;
> +		ret = of_property_read_u32(np, "mask-offset", &mask_offset);
> +		if (ret == -EINVAL)
> +			mask_offset = 0;
> +		else
> +			continue;
> +		ret = of_property_read_u32(np, "secondary-irq-base",
> +					   &secondary_irq_base);
> +		if (ret)
> +			continue;
> +		base = of_iomap(np, 0);
> +		if (!base)
> +			continue;
> +
> +		_orion_gpio_init(gpio_base, ngpio, base, mask_offset,
> +				 secondary_irq_base, np);
> +		chips++;
> +	}
> +	return chips;
> +}
> +#else
> +int __init orion_gpio_init_dt(void)
> +{
> +	return 0;
> +}
> +#endif
> diff --git a/arch/arm/plat-orion/include/plat/gpio.h b/arch/arm/plat-orion/include/plat/gpio.h
> index bec0c98..68039de 100644
> --- a/arch/arm/plat-orion/include/plat/gpio.h
> +++ b/arch/arm/plat-orion/include/plat/gpio.h
> @@ -30,6 +30,8 @@ void orion_gpio_set_valid(unsigned pin, int mode);
>  void __init orion_gpio_init(int gpio_base, int ngpio,
>  			    u32 base, int mask_offset, int secondary_irq_base);
>  
> +/* Initialize gpiolib using DT. */
> +int __init orion_gpio_init_dt(void);
>  /*
>   * GPIO interrupt handling.
>   */
> -- 
> 1.7.10
> 
