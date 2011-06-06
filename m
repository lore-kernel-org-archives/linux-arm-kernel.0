From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 6 Jun 2011 02:19:35 -0600
Subject: [PATCH 2/2] gpio/mxs: convert gpio-mxs to use basic_mmio_gpio
	library
In-Reply-To: <1307341247-26382-2-git-send-email-shawn.guo@linaro.org>
References: <1307341247-26382-1-git-send-email-shawn.guo@linaro.org>
	<1307341247-26382-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110606081935.GG10410@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 02:20:47PM +0800, Shawn Guo wrote:
> The gpio-mxs controller complies with basic_mmio_gpio library.  This
> patch converts the driver to use the library.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Given that patch 1 was nacked, I'm assuming I should ignore this patch?

g.

> ---
>  drivers/gpio/Kconfig    |    1 +
>  drivers/gpio/gpio-mxs.c |   73 +++++++++--------------------------------------
>  2 files changed, 15 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index daaef0f..0b858e5 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -96,6 +96,7 @@ config GPIO_EXYNOS4
>  config GPIO_MXS
>  	def_bool y
>  	depends on ARCH_MXS
> +	select GPIO_BASIC_MMIO_CORE
>  
>  config GPIO_PLAT_SAMSUNG
>  	bool "Samsung SoCs GPIO library support"
> diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
> index d01f046..9897641 100644
> --- a/drivers/gpio/gpio-mxs.c
> +++ b/drivers/gpio/gpio-mxs.c
> @@ -27,6 +27,7 @@
>  #include <linux/gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/basic_mmio_gpio.h>
>  #include <mach/mxs.h>
>  
>  #define MXS_SET		0x4
> @@ -54,7 +55,7 @@ struct mxs_gpio_port {
>  	int irq;
>  	int irq_high;
>  	int virtual_irq_start;
> -	struct gpio_chip chip;
> +	struct bgpio_chip bgc;
>  };
>  
>  /* Note: This driver assumes 32 GPIOs are handled in one register */
> @@ -99,8 +100,6 @@ static void mxs_gpio_unmask_irq(struct irq_data *d)
>  	set_gpio_irqenable(port, gpio & 0x1f, 1);
>  }
>  
> -static int mxs_gpio_get(struct gpio_chip *chip, unsigned offset);
> -
>  static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
>  {
>  	u32 gpio = irq_to_gpio(d->irq);
> @@ -203,53 +202,6 @@ static struct irq_chip gpio_irq_chip = {
>  	.irq_set_wake = mxs_gpio_set_wake_irq,
>  };
>  
> -static void mxs_set_gpio_direction(struct gpio_chip *chip, unsigned offset,
> -				int dir)
> -{
> -	struct mxs_gpio_port *port =
> -		container_of(chip, struct mxs_gpio_port, chip);
> -	void __iomem *pin_addr = port->base + PINCTRL_DOE(port->id);
> -
> -	if (dir)
> -		writel(1 << offset, pin_addr + MXS_SET);
> -	else
> -		writel(1 << offset, pin_addr + MXS_CLR);
> -}
> -
> -static int mxs_gpio_get(struct gpio_chip *chip, unsigned offset)
> -{
> -	struct mxs_gpio_port *port =
> -		container_of(chip, struct mxs_gpio_port, chip);
> -
> -	return (readl(port->base + PINCTRL_DIN(port->id)) >> offset) & 1;
> -}
> -
> -static void mxs_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> -{
> -	struct mxs_gpio_port *port =
> -		container_of(chip, struct mxs_gpio_port, chip);
> -	void __iomem *pin_addr = port->base + PINCTRL_DOUT(port->id);
> -
> -	if (value)
> -		writel(1 << offset, pin_addr + MXS_SET);
> -	else
> -		writel(1 << offset, pin_addr + MXS_CLR);
> -}
> -
> -static int mxs_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
> -{
> -	mxs_set_gpio_direction(chip, offset, 0);
> -	return 0;
> -}
> -
> -static int mxs_gpio_direction_output(struct gpio_chip *chip,
> -				     unsigned offset, int value)
> -{
> -	mxs_gpio_set(chip, offset, value);
> -	mxs_set_gpio_direction(chip, offset, 1);
> -	return 0;
> -}
> -
>  static int __devinit mxs_gpio_probe(struct platform_device *pdev)
>  {
>  	static void __iomem *base;
> @@ -314,20 +266,23 @@ static int __devinit mxs_gpio_probe(struct platform_device *pdev)
>  	irq_set_chained_handler(port->irq, mxs_gpio_irq_handler);
>  	irq_set_handler_data(port->irq, port);
>  
> -	/* register gpio chip */
> -	port->chip.direction_input = mxs_gpio_direction_input;
> -	port->chip.direction_output = mxs_gpio_direction_output;
> -	port->chip.get = mxs_gpio_get;
> -	port->chip.set = mxs_gpio_set;
> -	port->chip.base = port->id * 32;
> -	port->chip.ngpio = 32;
> -
> -	err = gpiochip_add(&port->chip);
> +	err = bgpio_init(&port->bgc, &pdev->dev, 4,
> +			 port->base + PINCTRL_DIN(port->id),
> +			 port->base + PINCTRL_DOUT(port->id), NULL,
> +			 port->base + PINCTRL_DOE(port->id), NULL, false);
>  	if (err)
>  		goto out_iounmap;
>  
> +	port->bgc.gc.base = port->id * 32;
> +
> +	err = gpiochip_add(&port->bgc.gc);
> +	if (err)
> +		goto out_bgpio_remove;
> +
>  	return 0;
>  
> +out_bgpio_remove:
> +	bgpio_remove(&port->bgc);
>  out_iounmap:
>  	if (iores)
>  		iounmap(port->base);
> -- 
> 1.7.4.1
> 
