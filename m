From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 18 May 2010 05:48:05 +0100
Subject: [PATCH v2 4/9] Input: s3c24xx_ts - Implements generic GPIO
	configuration function
In-Reply-To: <1273756034-3131-1-git-send-email-kgene.kim@samsung.com>
References: <1273756034-3131-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100518044805.GZ26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 13, 2010 at 10:07:14PM +0900, Kukjin Kim wrote:
> From: Naveen Krishna <ch.naveen@samsung.com>
> 
> This patch implements generic GPIO configuration function in Samsung
> touchscreen driver. And makes the touchscreen driver s3c24xx-ts.c
> generic to all the Samsung SoCs.
> 
> Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  drivers/input/touchscreen/Kconfig      |    1 -
>  drivers/input/touchscreen/s3c2410_ts.c |   23 +++--------------------
>  2 files changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 8a8fa4d..a5dcdac 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -160,7 +160,6 @@ config TOUCHSCREEN_FUJITSU
>  config TOUCHSCREEN_S3C2410
>  	tristate "Samsung S3C2410 touchscreen input driver"
>  	depends on ARCH_S3C2410
> -	select S3C24XX_ADC
>  	help
>  	  Say Y here if you have the s3c2410 touchscreen.


this looke like an unrelated change, please remove it.
  
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> index a2e1228..86086a4 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -39,8 +39,6 @@
>  #include <plat/regs-adc.h>
>  #include <plat/ts.h>
>  
> -#include <mach/regs-gpio.h>
> -
>  #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_PST(0))
>  
>  #define INT_DOWN	(0)
> @@ -88,21 +86,6 @@ struct s3c2410ts {
>  static struct s3c2410ts ts;
>  
>  /**
> - * s3c2410_ts_connect - configure gpio for s3c2410 systems
> - *
> - * Configure the GPIO for the S3C2410 system, where we have external FETs
> - * connected to the device (later systems such as the S3C2440 integrate
> - * these into the device).
> -*/
> -static inline void s3c2410_ts_connect(void)
> -{
> -	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
> -	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPG13_nXPON);
> -	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
> -	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
> -}
> -
> -/**
>   * get_down - return the down state of the pen
>   * @data0: The data read from ADCDAT0 register.
>   * @data1: The data read from ADCDAT1 register.
> @@ -296,9 +279,9 @@ static int __devinit s3c2410ts_probe(struct platform_device *pdev)
>  		goto err_clk;
>  	}
>  
> -	/* Configure the touchscreen external FETs on the S3C2410 */
> -	if (!platform_get_device_id(pdev)->driver_data)
> -		s3c2410_ts_connect();
> +	/* inititalise the gpio */
> +	if (info->cfg_gpio)
> +		info->cfg_gpio(to_platform_device(ts.dev));
>  
>  	ts.client = s3c_adc_register(pdev, s3c24xx_ts_select,
>  				     s3c24xx_ts_conversion, 1);
> -- 
> 1.6.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
