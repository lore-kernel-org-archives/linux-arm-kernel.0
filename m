From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Nov 2015 16:26:58 +0000
Subject: [PATCH v5] pwm-backlight: Avoid backlight flicker when probed
 from DT
In-Reply-To: <1447866745-21567-1-git-send-email-p.zabel@pengutronix.de>
References: <1447866745-21567-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20151124162658.GJ807@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Nov 2015, Philipp Zabel wrote:

> If the driver is probed from the device tree, and there is a phandle
> property set on it, and the enable GPIO is already configured as output,
> and the backlight is currently disabled, keep it disabled.
> If all these conditions are met, assume there will be some other driver
> that can enable the backlight at the appropriate time.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  - Rebased onto v4.4-rc1
>  - Added Heiko's Tested-by
> ---
>  drivers/video/backlight/pwm_bl.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index ae3c6b6..3daf9cc 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -199,6 +199,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	struct backlight_properties props;
>  	struct backlight_device *bl;
>  	struct pwm_bl_data *pb;
> +	phandle phandle = pdev->dev.of_node->phandle;
> +	int initial_blank = FB_BLANK_UNBLANK;
>  	int ret;
>  
>  	if (!data) {
> @@ -242,7 +244,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	pb->enabled = false;
>  
>  	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> -						  GPIOD_OUT_HIGH);
> +						  GPIOD_ASIS);
>  	if (IS_ERR(pb->enable_gpio)) {
>  		ret = PTR_ERR(pb->enable_gpio);
>  		goto err_alloc;
> @@ -264,12 +266,30 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  		pb->enable_gpio = gpio_to_desc(data->enable_gpio);
>  	}
>  
> +	if (pb->enable_gpio) {
> +		/*
> +		 * If the driver is probed from the device tree and there is a
> +		 * phandle link pointing to the backlight node, it is safe to
> +		 * assume that another driver will enable the backlight at the
> +		 * appropriate time. Therefore, if it is disabled, keep it so.
> +		 */
> +		if (phandle &&
> +		    gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_OUT &&
> +		    gpiod_get_value(pb->enable_gpio) == 0)
> +			initial_blank = FB_BLANK_POWERDOWN;
> +		else
> +			gpiod_direction_output(pb->enable_gpio, 1);
> +	}
> +
>  	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
>  	if (IS_ERR(pb->power_supply)) {
>  		ret = PTR_ERR(pb->power_supply);
>  		goto err_alloc;
>  	}
>  
> +	if (phandle && !regulator_is_enabled(pb->power_supply))
> +		initial_blank = FB_BLANK_POWERDOWN;
> +
>  	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) != -EPROBE_DEFER
>  	    && !pdev->dev.of_node) {
> @@ -320,6 +340,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	}
>  
>  	bl->props.brightness = data->dft_brightness;
> +	bl->props.power = initial_blank;
>  	backlight_update_status(bl);
>  
>  	platform_set_drvdata(pdev, bl);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
