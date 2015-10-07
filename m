From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 07 Oct 2015 10:35:54 +0900
Subject: [PATCH 2/6] ARM: s3c24xx: rx1950: Use PWM lookup table
In-Reply-To: <1444049237-29878-3-git-send-email-thierry.reding@gmail.com>
References: <1444049237-29878-1-git-send-email-thierry.reding@gmail.com>
 <1444049237-29878-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <561476FA.4090209@samsung.com>
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
>  arch/arm/mach-s3c24xx/mach-rx1950.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
> index 1d35ff375a01..774c982a7b7e 100644
> --- a/arch/arm/mach-s3c24xx/mach-rx1950.c
> +++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
> @@ -375,6 +375,11 @@ static struct s3c2410fb_mach_info rx1950_lcd_cfg = {
>  
>  };
>  
> +static struct pwm_lookup rx1950_pwm_lookup[] = {
> +	PWM_LOOKUP("samsung-pwm", 0, "pwm-backlight.0", NULL, 48000,

Why the dev_id is "pwm-backlight.0"? Created platform device name is
"pwm-backlight".

Best regards,
Krzysztof

> +		   PWM_POLARITY_NORMAL),
> +};
> +
>  static struct pwm_device *lcd_pwm;
>  
>  static void rx1950_lcd_power(int enable)
> @@ -520,10 +525,8 @@ static int rx1950_backlight_notify(struct device *dev, int brightness)
>  }
>  
>  static struct platform_pwm_backlight_data rx1950_backlight_data = {
> -	.pwm_id = 0,
>  	.max_brightness = 24,
>  	.dft_brightness = 4,
> -	.pwm_period_ns = 48000,
>  	.enable_gpio = -1,
>  	.init = rx1950_backlight_init,
>  	.notify = rx1950_backlight_notify,
> @@ -792,6 +795,7 @@ static void __init rx1950_init_machine(void)
>  	gpio_direction_output(S3C2410_GPA(4), 0);
>  	gpio_direction_output(S3C2410_GPJ(6), 0);
>  
> +	pwm_add_table(rx1950_pwm_lookup, ARRAY_SIZE(rx1950_pwm_lookup));
>  	platform_add_devices(rx1950_devices, ARRAY_SIZE(rx1950_devices));
>  
>  	i2c_register_board_info(0, rx1950_i2c_devices,
> 
