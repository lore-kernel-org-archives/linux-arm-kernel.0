From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Oct 2013 12:31:04 -0600
Subject: [PATCH 05/10] ARM: SAMSUNG: Initialize PWM backlight enable_gpio
 field
In-Reply-To: <1379972467-11243-6-git-send-email-treding@nvidia.com>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <1379972467-11243-6-git-send-email-treding@nvidia.com>
Message-ID: <524B14E8.5040302@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2013 03:41 PM, Thierry Reding wrote:
> The GPIO API defines 0 as being a valid GPIO number, so this field needs
> to be initialized explicitly.

>  static void __init smdkv210_map_io(void)

> @@ -70,6 +70,7 @@ static struct samsung_bl_drvdata samsung_dfl_bl_data __initdata = {
>  		.max_brightness = 255,
>  		.dft_brightness = 255,
>  		.pwm_period_ns  = 78770,
> +		.enable_gpio    = -1,
>  		.init           = samsung_bl_init,
>  		.exit           = samsung_bl_exit,
>  	},
> @@ -121,6 +122,10 @@ void __init samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
>  		samsung_bl_data->lth_brightness = bl_data->lth_brightness;
>  	if (bl_data->pwm_period_ns)
>  		samsung_bl_data->pwm_period_ns = bl_data->pwm_period_ns;
> +	if (bl_data->enable_gpio)
> +		samsung_bl_data->enable_gpio = bl_data->enable_gpio;
> +	if (bl_data->enable_gpio_flags)
> +		samsung_bl_data->enable_gpio_flags = bl_data->enable_gpio_flags;

Won't this cause the core pwm_bl driver to request/manipulate the GPIO,
whereas this driver already does that inside the samsung_bl_init/exit
callbacks? I think you either need to adjust those callbacks, or not set
the new standard GPIO property in samsung_bl_data.
