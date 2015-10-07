From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 07 Oct 2015 10:37:42 +0900
Subject: [PATCH 5/6] ARM: s3c64xx: hmt: Use PWM lookup table
In-Reply-To: <1444049237-29878-6-git-send-email-thierry.reding@gmail.com>
References: <1444049237-29878-1-git-send-email-thierry.reding@gmail.com>
 <1444049237-29878-6-git-send-email-thierry.reding@gmail.com>
Message-ID: <56147766.6010703@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.10.2015 21:47, Thierry Reding wrote:
> Use a PWM lookup table to provide the PWM to the pwm-backlight device.
> The driver has a legacy code path that is required only because boards
> still use the legacy method of requesting PWMs by global ID. Replacing
> these usages allows that legacy fallback to be removed.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/mach-hmt.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
> index e4b087c58ee6..816b39d1e6d1 100644
> --- a/arch/arm/mach-s3c64xx/mach-hmt.c
> +++ b/arch/arm/mach-s3c64xx/mach-hmt.c
> @@ -19,6 +19,7 @@
>  #include <linux/gpio.h>
>  #include <linux/delay.h>
>  #include <linux/leds.h>
> +#include <linux/pwm.h>
>  #include <linux/pwm_backlight.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> @@ -73,6 +74,11 @@ static struct s3c2410_uartcfg hmt_uartcfgs[] __initdata = {
>  	},
>  };
>  
> +static struct pwm_lookup hmt_pwm_lookup[] = {
> +	PWM_LOOKUP("samsung-pwm", 1, "pwm-backlight.0", NULL,

Same questions as in patch 2 - why suffix ".0" for "pwm-backlight"?

Best regards,
Krzysztof

> +		   1000000000 / (100 * 256 * 20), PWM_POLARITY_NORMAL),
> +};
> +
>  static int hmt_bl_init(struct device *dev)
>  {
>  	int ret;
> @@ -110,10 +116,8 @@ static void hmt_bl_exit(struct device *dev)
>  }
>  
>  static struct platform_pwm_backlight_data hmt_backlight_data = {
> -	.pwm_id		= 1,
>  	.max_brightness	= 100 * 256,
>  	.dft_brightness	= 40 * 256,
> -	.pwm_period_ns	= 1000000000 / (100 * 256 * 20),
>  	.enable_gpio	= -1,
>  	.init		= hmt_bl_init,
>  	.notify		= hmt_bl_notify,
> @@ -268,6 +272,7 @@ static void __init hmt_machine_init(void)
>  	gpio_request(S3C64XX_GPF(13), "usb power");
>  	gpio_direction_output(S3C64XX_GPF(13), 1);
>  
> +	pwm_add_table(hmt_pwm_lookup, ARRAY_SIZE(hmt_pwm_lookup));
>  	platform_add_devices(hmt_devices, ARRAY_SIZE(hmt_devices));
>  }
>  
> 
