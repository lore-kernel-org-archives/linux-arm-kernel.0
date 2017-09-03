From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Sun, 3 Sep 2017 19:58:49 +0200
Subject: [PATCH v2 2/4] ARM: ep93xx: simone: let the mmc_spi driver handle
 the card detect
In-Reply-To: <20170903174347.6148-3-f.fainelli@gmail.com>
References: <20170903174347.6148-1-f.fainelli@gmail.com>
 <20170903174347.6148-3-f.fainelli@gmail.com>
Message-ID: <a2d3466c-a6d3-c984-b88e-00258e60ab30@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 03/09/17 19:43, Florian Fainelli wrote:
> From: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> This board uses a GPIO for the MMC card detect. Let the mmc_spi
> driver handle it instead of the platform code.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  arch/arm/mach-ep93xx/simone.c | 54 +++----------------------------------------
>  1 file changed, 3 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
> index c7a40f245892..1c353868f211 100644
> --- a/arch/arm/mach-ep93xx/simone.c
> +++ b/arch/arm/mach-ep93xx/simone.c
> @@ -43,60 +43,12 @@ static struct ep93xxfb_mach_info __initdata simone_fb_info = {
>  	.flags		= EP93XXFB_USE_SDCSN0 | EP93XXFB_PCLK_FALLING,
>  };
>  
> -/*
> - * GPIO lines used for MMC card detection.
> - */
> -#define MMC_CARD_DETECT_GPIO EP93XX_GPIO_LINE_EGPIO0
> -
> -/*
> - * MMC card detection GPIO setup.
> - */
> -
> -static int simone_mmc_spi_init(struct device *dev,
> -	irqreturn_t (*irq_handler)(int, void *), void *mmc)
> -{
> -	unsigned int gpio = MMC_CARD_DETECT_GPIO;
> -	int irq, err;
> -
> -	err = gpio_request(gpio, dev_name(dev));
> -	if (err)
> -		return err;
> -
> -	err = gpio_direction_input(gpio);
> -	if (err)
> -		goto fail;
> -
> -	irq = gpio_to_irq(gpio);
> -	if (irq < 0)
> -		goto fail;
> -
> -	err = request_irq(irq, irq_handler, IRQF_TRIGGER_FALLING,
> -			  "MMC card detect", mmc);
> -	if (err)
> -		goto fail;
> -
> -	printk(KERN_INFO "%s: using irq %d for MMC card detection\n",
> -	       dev_name(dev), irq);
> -
> -	return 0;
> -fail:
> -	gpio_free(gpio);
> -	return err;
> -}
> -
> -static void simone_mmc_spi_exit(struct device *dev, void *mmc)
> -{
> -	unsigned int gpio = MMC_CARD_DETECT_GPIO;
> -
> -	free_irq(gpio_to_irq(gpio), mmc);
> -	gpio_free(gpio);
> -}
> -
>  static struct mmc_spi_platform_data simone_mmc_spi_data = {
> -	.init		= simone_mmc_spi_init,
> -	.exit		= simone_mmc_spi_exit,
>  	.detect_delay	= 500,
>  	.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
> +	.flags		= MMC_SPI_USE_CD_GPIO,
> +	.cd_gpio	= EP93XX_GPIO_LINE_EGPIO0,
> +	.cd_debounce	= 1,
>  };
>  
>  static struct spi_board_info simone_spi_devices[] __initdata = {
