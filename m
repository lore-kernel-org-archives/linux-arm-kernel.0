From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 6 Jun 2011 10:02:16 +0200
Subject: [PATCH 1/2] gpio/mxs: save the unnecessary function
	mxs_gpio_to_irq
In-Reply-To: <1307341247-26382-1-git-send-email-shawn.guo@linaro.org>
References: <1307341247-26382-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110606080216.GB32632@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Jun 06, 2011 at 02:20:46PM +0800, Shawn Guo wrote:
> The irq number can be easily calculated from the sum of
> MXS_GPIO_IRQ_START and gpio number.  The patch directly defines
> gpio_to_irq for it and removes mxs_gpio_to_irq to simplify the
> the driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-mxs/include/mach/gpio.h |    2 +-
>  drivers/gpio/gpio-mxs.c               |    9 ---------
>  2 files changed, 1 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/include/mach/gpio.h b/arch/arm/mach-mxs/include/mach/gpio.h
> index 828cccc..18017c5 100644
> --- a/arch/arm/mach-mxs/include/mach/gpio.h
> +++ b/arch/arm/mach-mxs/include/mach/gpio.h
> @@ -28,8 +28,8 @@
>  #define gpio_get_value		__gpio_get_value
>  #define gpio_set_value		__gpio_set_value
>  #define gpio_cansleep		__gpio_cansleep
> -#define gpio_to_irq		__gpio_to_irq
>  
>  #define irq_to_gpio(irq)	((irq) - MXS_GPIO_IRQ_START)
> +#define gpio_to_irq(gpio)	(MXS_GPIO_IRQ_START + (gpio))

NACK

This is no good idea. __gpio_to_irq also works correctly for i2c gpio
expanders and the like whereas your patch limits the gio_to_irq usage to
internal gpios. Better to keep it like it is.

Sascha

>  
>  #endif /* __MACH_MXS_GPIO_H__ */
> diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
> index a287614..d01f046 100644
> --- a/drivers/gpio/gpio-mxs.c
> +++ b/drivers/gpio/gpio-mxs.c
> @@ -236,14 +236,6 @@ static void mxs_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>  		writel(1 << offset, pin_addr + MXS_CLR);
>  }
>  
> -static int mxs_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> -{
> -	struct mxs_gpio_port *port =
> -		container_of(chip, struct mxs_gpio_port, chip);
> -
> -	return port->virtual_irq_start + offset;
> -}
> -
>  static int mxs_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
>  {
>  	mxs_set_gpio_direction(chip, offset, 0);
> @@ -327,7 +319,6 @@ static int __devinit mxs_gpio_probe(struct platform_device *pdev)
>  	port->chip.direction_output = mxs_gpio_direction_output;
>  	port->chip.get = mxs_gpio_get;
>  	port->chip.set = mxs_gpio_set;
> -	port->chip.to_irq = mxs_gpio_to_irq;
>  	port->chip.base = port->id * 32;
>  	port->chip.ngpio = 32;
>  
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
