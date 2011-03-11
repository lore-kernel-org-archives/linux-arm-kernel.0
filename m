From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 11 Mar 2011 22:37:43 +0100
Subject: [PATCH 6/8] ARM: PXA: Z2: Fix libertas init/tear down sequences
In-Reply-To: <1299839023-16601-6-git-send-email-anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<1299839023-16601-6-git-send-email-anarsoul@gmail.com>
Message-ID: <201103112237.43566.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011 11:23:41 Vasily Khoruzhick wrote:
> GPIO15 seems to be not related to WiFi, so don't touch it.
> 

What's GPIO14 then? Also check Z2 kernel sources aeronix released, iirc that's 
where I found gpio14.

Cheers

> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-pxa/include/mach/z2.h |    3 +--
>  arch/arm/mach-pxa/z2.c              |   31 ++++++++-----------------------
>  2 files changed, 9 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/include/mach/z2.h
> b/arch/arm/mach-pxa/include/mach/z2.h index 8835c16..7b0f71e 100644
> --- a/arch/arm/mach-pxa/include/mach/z2.h
> +++ b/arch/arm/mach-pxa/include/mach/z2.h
> @@ -25,8 +25,7 @@
>  #define	GPIO98_ZIPITZ2_LID_BUTTON	98
> 
>  /* Libertas GSPI8686 WiFi */
> -#define	GPIO14_ZIPITZ2_WIFI_RESET	14
> -#define	GPIO15_ZIPITZ2_WIFI_POWER	15
> +#define	GPIO14_ZIPITZ2_WIFI_POWER	14
>  #define	GPIO24_ZIPITZ2_WIFI_CS		24
>  #define	GPIO36_ZIPITZ2_WIFI_IRQ		36
> 
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index f1bb98a..d1e40ba 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -141,8 +141,7 @@ static unsigned long z2_pin_config[] = {
>  	GPIO1_GPIO,		/* Power button */
>  	GPIO37_GPIO,		/* Headphone detect */
>  	GPIO98_GPIO,		/* Lid switch */
> -	GPIO14_GPIO,		/* WiFi Reset */
> -	GPIO15_GPIO,		/* WiFi Power */
> +	GPIO14_GPIO,		/* WiFi Power */
>  	GPIO24_GPIO,		/* WiFi CS */
>  	GPIO36_GPIO,		/* WiFi IRQ */
>  	GPIO88_GPIO,		/* LCD CS */
> @@ -504,26 +503,16 @@ static int z2_lbs_spi_setup(struct spi_device *spi)
>  {
>  	int ret = 0;
> 
> -	ret = gpio_request(GPIO15_ZIPITZ2_WIFI_POWER, "WiFi Power");
> +	ret = gpio_request(GPIO14_ZIPITZ2_WIFI_POWER, "WiFi Power");
>  	if (ret)
>  		goto err;
> 
> -	ret = gpio_direction_output(GPIO15_ZIPITZ2_WIFI_POWER, 1);
> +	ret = gpio_direction_output(GPIO14_ZIPITZ2_WIFI_POWER, 1);
>  	if (ret)
>  		goto err2;
> 
> -	ret = gpio_request(GPIO14_ZIPITZ2_WIFI_RESET, "WiFi Reset");
> -	if (ret)
> -		goto err2;
> -
> -	ret = gpio_direction_output(GPIO14_ZIPITZ2_WIFI_RESET, 0);
> -	if (ret)
> -		goto err3;
> -
> -	/* Reset the card */
> +	/* Wait until card is powered on */
>  	mdelay(180);
> -	gpio_set_value(GPIO14_ZIPITZ2_WIFI_RESET, 1);
> -	mdelay(20);
> 
>  	spi->bits_per_word = 16;
>  	spi->mode = SPI_MODE_2,
> @@ -532,22 +521,18 @@ static int z2_lbs_spi_setup(struct spi_device *spi)
> 
>  	return 0;
> 
> -err3:
> -	gpio_free(GPIO14_ZIPITZ2_WIFI_RESET);
>  err2:
> -	gpio_free(GPIO15_ZIPITZ2_WIFI_POWER);
> +	gpio_free(GPIO14_ZIPITZ2_WIFI_POWER);
>  err:
>  	return ret;
>  };
> 
>  static int z2_lbs_spi_teardown(struct spi_device *spi)
>  {
> -	gpio_set_value(GPIO14_ZIPITZ2_WIFI_RESET, 0);
> -	gpio_set_value(GPIO15_ZIPITZ2_WIFI_POWER, 0);
> -	gpio_free(GPIO14_ZIPITZ2_WIFI_RESET);
> -	gpio_free(GPIO15_ZIPITZ2_WIFI_POWER);
> -	return 0;
> +	gpio_set_value(GPIO14_ZIPITZ2_WIFI_POWER, 0);
> +	gpio_free(GPIO14_ZIPITZ2_WIFI_POWER);
> 
> +	return 0;
>  };
> 
>  static struct pxa2xx_spi_chip z2_lbs_chip_info = {
