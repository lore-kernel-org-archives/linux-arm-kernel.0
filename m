From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 09 Mar 2015 11:16:26 +0100
Subject: [PATCH v2 03/10] reset: berlin: convert to a platform driver
In-Reply-To: <1425654328-26298-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425654328-26298-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425896186.3152.25.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

Am Freitag, den 06.03.2015, 16:05 +0100 schrieb Antoine Tenart:
> The Berlin reset controller was introduced without being a platform
> driver because of a needed DT rework: the node describing the reset
> controller also describes the pinctrl and clk controllers...
> 
> The DT issue being solved thanks to the addition of the Berlin
> controller mfd driver, it is now possible to convert the Berlin reset
> driver to a plaftorm driver.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Looks good to me. Do you want to merge this together with the rest of
the series, or should I queue the reset patch?

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

> ---
>  drivers/reset/reset-berlin.c | 71 +++++++++++++++++---------------------------
>  1 file changed, 27 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/reset/reset-berlin.c b/drivers/reset/reset-berlin.c
> index f8b48a13cf0b..5f414fa142ff 100644
> --- a/drivers/reset/reset-berlin.c
> +++ b/drivers/reset/reset-berlin.c
> @@ -12,10 +12,12 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset-controller.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  
> @@ -25,8 +27,7 @@
>  	container_of((p), struct berlin_reset_priv, rcdev)
>  
>  struct berlin_reset_priv {
> -	void __iomem			*base;
> -	unsigned int			size;
> +	struct regmap			*regmap;
>  	struct reset_controller_dev	rcdev;
>  };
>  
> @@ -37,7 +38,7 @@ static int berlin_reset_reset(struct reset_controller_dev *rcdev,
>  	int offset = id >> 8;
>  	int mask = BIT(id & 0x1f);
>  
> -	writel(mask, priv->base + offset);
> +	regmap_write(priv->regmap, offset, mask);
>  
>  	/* let the reset be effective */
>  	udelay(10);
> @@ -52,7 +53,6 @@ static struct reset_control_ops berlin_reset_ops = {
>  static int berlin_reset_xlate(struct reset_controller_dev *rcdev,
>  			      const struct of_phandle_args *reset_spec)
>  {
> -	struct berlin_reset_priv *priv = to_berlin_reset_priv(rcdev);
>  	unsigned offset, bit;
>  
>  	if (WARN_ON(reset_spec->args_count != rcdev->of_reset_n_cells))
> @@ -61,71 +61,54 @@ static int berlin_reset_xlate(struct reset_controller_dev *rcdev,
>  	offset = reset_spec->args[0];
>  	bit = reset_spec->args[1];
>  
> -	if (offset >= priv->size)
> -		return -EINVAL;
> -
>  	if (bit >= BERLIN_MAX_RESETS)
>  		return -EINVAL;
>  
>  	return (offset << 8) | bit;
>  }
>  
> -static int __berlin_reset_init(struct device_node *np)
> +static int berlin2_reset_probe(struct platform_device *pdev)
>  {
> +	struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
>  	struct berlin_reset_priv *priv;
> -	struct resource res;
> -	resource_size_t size;
> -	int ret;
>  
> -	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	ret = of_address_to_resource(np, 0, &res);
> -	if (ret)
> -		goto err;
> -
> -	size = resource_size(&res);
> -	priv->base = ioremap(res.start, size);
> -	if (!priv->base) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> -	priv->size = size;
> +	priv->regmap = syscon_node_to_regmap(parent_np);
> +	of_node_put(parent_np);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
>  
>  	priv->rcdev.owner = THIS_MODULE;
>  	priv->rcdev.ops = &berlin_reset_ops;
> -	priv->rcdev.of_node = np;
> +	priv->rcdev.of_node = pdev->dev.of_node;
>  	priv->rcdev.of_reset_n_cells = 2;
>  	priv->rcdev.of_xlate = berlin_reset_xlate;
>  
>  	reset_controller_register(&priv->rcdev);
>  
>  	return 0;
> -
> -err:
> -	kfree(priv);
> -	return ret;
>  }
>  
> -static const struct of_device_id berlin_reset_of_match[] __initconst = {
> -	{ .compatible = "marvell,berlin2-chip-ctrl" },
> -	{ .compatible = "marvell,berlin2cd-chip-ctrl" },
> -	{ .compatible = "marvell,berlin2q-chip-ctrl" },
> +static const struct of_device_id berlin_reset_of_match[] = {
> +	{ .compatible = "marvell,berlin2-reset" },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, berlin_reset_of_match);
>  
> -static int __init berlin_reset_init(void)
> -{
> -	struct device_node *np;
> -	int ret;
> +static struct platform_driver berlin_reset_driver = {
> +	.probe	= berlin2_reset_probe,
> +	.driver	= {
> +		.name = "berlin2-reset",
> +		.of_match_table = berlin_reset_of_match,
> +	},
>  
> -	for_each_matching_node(np, berlin_reset_of_match) {
> -		ret = __berlin_reset_init(np);
> -		if (ret)
> -			return ret;
> -	}
> +};
> +module_platform_driver(berlin_reset_driver);
>  
> -	return 0;
> -}
> -arch_initcall(berlin_reset_init);
> +MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
> +MODULE_AUTHOR("Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>");
> +MODULE_DESCRIPTION("Marvell Berlin reset driver");
> +MODULE_LICENSE("GPL");
