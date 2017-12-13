From: yixun.lan@amlogic.com (Yixun Lan)
Date: Wed, 13 Dec 2017 21:52:50 +0800
Subject: [PATCH v2 2/5] i2c: meson: add configurable divider factors
In-Reply-To: <20171120145415.6581-3-yixun.lan@amlogic.com>
References: <20171120145415.6581-1-yixun.lan@amlogic.com>
 <20171120145415.6581-3-yixun.lan@amlogic.com>
Message-ID: <eb304da4-a9e7-154c-6198-c195c04849d5@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram

On 11/20/2017 10:54 PM, Yixun Lan wrote:
> From: Jian Hu <jian.hu@amlogic.com>
> 
> This patch try to add support for I2C controller in Meson-AXG SoC,
> Due to the IP changes between I2C controller, we need to introduce
> a compatible data to make the divider factor configurable.
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/i2c/busses/i2c-meson.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
> index 88d15b92ec35..37c4aa76f37a 100644
> --- a/drivers/i2c/busses/i2c-meson.c
> +++ b/drivers/i2c/busses/i2c-meson.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
>  
> @@ -57,6 +58,10 @@ enum {
>  	STATE_WRITE,
>  };
>  
> +struct meson_i2c_data {
> +	unsigned char div_factor;
> +};
> +
>  /**
>   * struct meson_i2c - Meson I2C device private data
>   *
> @@ -93,6 +98,8 @@ struct meson_i2c {
>  	struct completion	done;
>  	u32			tokens[2];
>  	int			num_tokens;
> +
> +	const struct meson_i2c_data *data;
>  };
>  
>  static void meson_i2c_set_mask(struct meson_i2c *i2c, int reg, u32 mask,
> @@ -128,7 +135,7 @@ static void meson_i2c_set_clk_div(struct meson_i2c *i2c, unsigned int freq)
>  	unsigned long clk_rate = clk_get_rate(i2c->clk);
>  	unsigned int div;
>  
> -	div = DIV_ROUND_UP(clk_rate, freq * 4);
> +	div = DIV_ROUND_UP(clk_rate, freq * i2c->data->div_factor);
>  
>  	/* clock divider has 12 bits */
>  	if (div >= (1 << 12)) {
> @@ -376,6 +383,9 @@ static int meson_i2c_probe(struct platform_device *pdev)
>  	spin_lock_init(&i2c->lock);
>  	init_completion(&i2c->done);
>  
> +	i2c->data = (const struct meson_i2c_data *)
> +		of_device_get_match_data(&pdev->dev);
> +
>  	i2c->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(i2c->clk)) {
>  		dev_err(&pdev->dev, "can't get device clock\n");
> @@ -440,11 +450,25 @@ static int meson_i2c_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct meson_i2c_data i2c_meson6_data = {
> +	.div_factor = 4,
> +};
> +
> +static const struct meson_i2c_data i2c_gxbb_data = {
> +	.div_factor = 4,
> +};
> +
> +static const struct meson_i2c_data i2c_axg_data = {
> +	.div_factor = 3,
> +};
> +
>  static const struct of_device_id meson_i2c_match[] = {
> -	{ .compatible = "amlogic,meson6-i2c" },
> -	{ .compatible = "amlogic,meson-gxbb-i2c" },
> -	{ },
> +	{ .compatible = "amlogic,meson6-i2c", .data = &i2c_meson6_data },
> +	{ .compatible = "amlogic,meson-gxbb-i2c", .data = &i2c_gxbb_data },
> +	{ .compatible = "amlogic,meson-axg-i2c", .data = &i2c_axg_data },
> +	{},
>  };
> +
>  MODULE_DEVICE_TABLE(of, meson_i2c_match);
>  
>  static struct platform_driver meson_i2c_driver = {
> 


this is merely a ping, do you have any comment on this patch?
or could you take this patch along with patch 1 [1](with Rob's Ack) if
you think it's ready/good?

thanks

[1]
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005405.html
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005417.html

Yixun
