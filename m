From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 2 Jan 2012 00:34:06 -0700
Subject: [RFC][PATCH 4/4] lcd: platform-lcd: Add device tree support
In-Reply-To: <1325483675-21908-5-git-send-email-thomas.abraham@linaro.org>
References: <1325483675-21908-1-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-2-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-3-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-4-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-5-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120102073406.GG13015@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2012 at 11:24:35AM +0530, Thomas Abraham wrote:
> Add device tree based initialization for Hydis hv070wsa lcd panel.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/video/backlight/platform_lcd.c |   33 ++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backlight/platform_lcd.c
> index feb4fd0..ebdddfd 100644
> --- a/drivers/video/backlight/platform_lcd.c
> +++ b/drivers/video/backlight/platform_lcd.c
> @@ -18,6 +18,8 @@
>  #include <linux/lcd.h>
>  #include <linux/slab.h>
>  #include <linux/gpio.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
>  
>  #include <video/platform_lcd.h>
>  
> @@ -81,9 +83,18 @@ static struct lcd_ops platform_lcd_ops = {
>  	.check_fb	= platform_lcd_match,
>  };
>  
> +static const struct of_device_id platform_lcd_dt_match[];
> +
>  static inline struct plat_lcd_driver_data *platform_lcd_get_driver_data(
>  			struct platform_device *pdev)
>  {
> +#ifdef CONFIG_OF
> +	if (pdev->dev.of_node) {
> +		const struct of_device_id *match;
> +		match = of_match_node(platform_lcd_dt_match, pdev->dev.of_node);
> +		return (struct plat_lcd_driver_data *)match->data;

.data is already void*; the cast should not be necessary.

> +	}
> +#endif
>  	return (struct plat_lcd_driver_data *)
>  			platform_get_device_id(pdev)->driver_data;
>  }
> @@ -167,6 +178,19 @@ static int lcd_hv070wsa_init(struct platform_lcd *plcd)
>  	struct plat_lcd_hydis_hv070wsa_pdata *pdata = plcd->lcd_pdata;
>  	int err;
>  
> +#ifdef CONFIG_OF
> +	if (of_have_populated_dt()) {
> +		plcd->lcd_pdata = devm_kzalloc(plcd->us,
> +						sizeof(*pdata), GFP_KERNEL);
> +		if (!plcd->lcd_pdata) {
> +			dev_err(plcd->us, "mem alloc for pdata failed\n");
> +			return -ENOMEM;
> +		}
> +		pdata = plcd->lcd_pdata;
> +		pdata->gpio = of_get_gpio(plcd->us->of_node, 0);
> +	}
> +#endif
> +
>  	if (!pdata) {
>  		dev_err(plcd->us, "no platform data\n");
>  		return -EINVAL;
> @@ -214,10 +238,19 @@ static struct platform_device_id platform_lcd_driver_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, platform_lcd_driver_ids);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id platform_lcd_dt_match[] = {
> +	{ .compatible = "hydis,hv070wsa", .data = (void *)HV070WSA_DRV_DATA},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, platform_lcd_dt_match);
> +#endif
> +
>  static struct platform_driver platform_lcd_driver = {
>  	.driver		= {
>  		.name	= "platform-lcd",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(platform_lcd_dt_match),
>  	},
>  	.probe		= platform_lcd_probe,
>  	.remove		= __devexit_p(platform_lcd_remove),
> -- 
> 1.6.6.rc2
> 
