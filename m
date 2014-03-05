From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 5 Mar 2014 12:43:26 +0200
Subject: [PATCH] gpio: davinci: fix gpio selection for OF
In-Reply-To: <1393970762-5346-1-git-send-email-holler@ahsoftware.de>
References: <5315ED51.1000006@ti.com>
 <1393970762-5346-1-git-send-email-holler@ahsoftware.de>
Message-ID: <5316FFCE.1060603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2014 12:06 AM, Alexander Holler wrote:
> The driver missed an of_xlate function to translate gpio numbers
> as found in the DT to the correct chip and number.
>
> While there I've set #gpio_cells to a fixed value of 2.
>
> I've used gpio-pxa.c as template for those changes and tested my changes
> successfully on a da850 board using entries for gpio-leds in a DT. So I didn't
> reinvent the wheel but just copied and tested stuff.
>
> Thanks to Grygorii Strashko for the hint of the existing code in gpio-pxa.
>
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
> ---
>   drivers/gpio/gpio-davinci.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index 7629b4f..79f45c4 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -44,6 +44,9 @@ struct davinci_gpio_regs {
>
>   static void __iomem *gpio_base;
>
> +static struct davinci_gpio_controller *davinci_gpio_chips;
> +static int davinci_last_gpio;
> +
>   static struct davinci_gpio_regs __iomem *gpio2regs(unsigned gpio)
>   {
>   	void __iomem *ptr;
> @@ -172,6 +175,24 @@ of_err:
>   	return NULL;
>   }
>
> +#ifdef CONFIG_OF_GPIO
> +static int davinci_gpio_of_xlate(struct gpio_chip *gc,
> +			     const struct of_phandle_args *gpiospec,
> +			     u32 *flags)
> +{
> +	if (gpiospec->args[0] > davinci_last_gpio)
> +		return -EINVAL;
> +
> +	if (gc != &davinci_gpio_chips[gpiospec->args[0] / 32].chip)
> +		return -EINVAL;
> +
> +	if (flags)
> +		*flags = gpiospec->args[1];

Just one question here - Could we use gpio_chip-dev and hence, drop
static variables (davinci_gpio_chips, davinci_last_gpio)?

The Davinci device holds davinci_gpio_platform_data
in dev->platform_data and pointer on davinci_gpio_controller array
in dev->p->driver_data.

And looks like, dev_get_platdata(gc->dev) and
dev_get_drvdata(gc->dev) can be used here.

> +
> +	return gpiospec->args[0] % 32;
> +}
> +#endif
> +
>   static int davinci_gpio_probe(struct platform_device *pdev)
>   {
>   	int i, base;
> @@ -236,6 +257,8 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>   			chips[i].chip.ngpio = 32;
>

add here	chips[i].chip.dev = dev;

>   #ifdef CONFIG_OF_GPIO
> +		chips[i].chip.of_gpio_n_cells = 2;
> +		chips[i].chip.of_xlate = davinci_gpio_of_xlate;
>   		chips[i].chip.of_node = dev->of_node;
>   #endif
>   		spin_lock_init(&chips[i].lock);
> @@ -251,6 +274,10 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>
>   	platform_set_drvdata(pdev, chips);
>   	davinci_gpio_irq_setup(pdev);
> +
> +	davinci_gpio_chips = chips;
> +	davinci_last_gpio = ngpio;
> +
>   	return 0;
>   }

regards,
-grygorii
