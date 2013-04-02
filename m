From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 02 Apr 2013 23:47:08 +0200
Subject: [PATCH v2] ARM: kirkwood: extend the kirkwood i2s driver for
 DT usage
In-Reply-To: <20130402201348.4ab406fb@armhf>
References: <20130402201348.4ab406fb@armhf>
Message-ID: <515B51DC.7020002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2013 08:13 PM, Jean-Francois Moine wrote:
> The kirkwood i2s driver is used without DT in the Kirkwood machine.
> This patch adds a DT compatible definition for use in other Marvell
> machines as the Armada 88AP510 (Dove).
>
> Signed-off-by: Jean-Francois Moine<moinejf@free.fr>
> ---
[...]
> +Optional property:
> +
> +- marvell,burst-size: burst size which can be only 32 or 128.
> +  Default value is 128.

Jean-Francois,

I still think we don't need to expose burst-size at all. Is there
any SoC using a different burst-size of 128?

> +
> +Example:
> +
> +i2s1: audio-controller at b4000 {
> +	compatible = "marvell,kirkwood-i2s";
> +	reg =<0xb4000 0x2210>;
> +	interrupts =<21>,<22>;
> +	clocks =<&gate_clk 13>;
> +};
> diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
> index c74c890..37370b3 100644
> --- a/sound/soc/kirkwood/kirkwood-i2s.c
> +++ b/sound/soc/kirkwood/kirkwood-i2s.c
> @@ -12,7 +12,6 @@
>
>   #include<linux/init.h>
>   #include<linux/module.h>
> -#include<linux/platform_device.h>
>   #include<linux/io.h>
>   #include<linux/slab.h>
>   #include<linux/mbus.h>
> @@ -22,6 +21,8 @@
>   #include<sound/pcm_params.h>
>   #include<sound/soc.h>
>   #include<linux/platform_data/asoc-kirkwood.h>
> +#include<linux/of.h>
> +
>   #include "kirkwood.h"
>
>   #define DRV_NAME	"kirkwood-i2s"
> @@ -457,6 +458,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>   	struct snd_soc_dai_driver *soc_dai =&kirkwood_i2s_dai;
>   	struct kirkwood_dma_data *priv;
>   	struct resource *mem;
> +	struct device_node *np;

struct device_node *np = pdev->dev.of_node;

and remove the assignment below.

>   	int err;
>
>   	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> @@ -482,24 +484,41 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>   		return -ENXIO;
>   	}
>
> -	if (!data) {
> -		dev_err(&pdev->dev, "no platform data ?!\n");
> -		return -EINVAL;
> -	}
> +	/* get the DT or static parameters */
> +	np = pdev->dev.of_node;
> +	if (np) {
> +		u32 val;
> +
> +		if (of_property_read_u32(np, "marvell,burst-size",&val)) {
> +			val = 128;		/* default value */
> +		} else if (val != 32&&  val != 128) {
> +			dev_err(&pdev->dev,
> +				"'marvell,burst-size' can be only 32 or 128\n");
> +			return -EINVAL;
> +		}
> +		priv->burst = val;
> +		priv->clk = of_clk_get(np, 0);		/* internal clock */
> +		priv->extclk = of_clk_get(np, 1); /* optional external clock */
> +	} else {
> +		if (!data) {
> +			dev_err(&pdev->dev, "no platform data ?!\n");
> +			return -EINVAL;
> +		}
> +		priv->burst = data->burst;
>
> -	priv->burst = data->burst;
> +		priv->clk = clk_get(&pdev->dev, NULL);
> +		priv->extclk = clk_get(&pdev->dev, "extclk");
> +	}
>
> -	priv->clk = devm_clk_get(&pdev->dev, NULL);
>   	if (IS_ERR(priv->clk)) {
>   		dev_err(&pdev->dev, "no clock\n");
> -		return PTR_ERR(priv->clk);
> +		err = PTR_ERR(priv->clk);
> +		goto error;
>   	}
> -
>   	err = clk_prepare_enable(priv->clk);
>   	if (err<  0)
> -		return err;
> +		goto error;
>
> -	priv->extclk = clk_get(&pdev->dev, "extclk");
>   	if (!IS_ERR(priv->extclk)) {
>   		if (priv->extclk == priv->clk) {
>   			clk_put(priv->extclk);
> @@ -516,7 +535,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>   	priv->ctl_rec = KIRKWOOD_RECCTL_SIZE_24;
>
>   	/* Select the burst size */
> -	if (data->burst == 32) {
> +	if (priv->burst == 32) {
>   		priv->ctl_play |= KIRKWOOD_PLAYCTL_BURST_32;
>   		priv->ctl_rec |= KIRKWOOD_RECCTL_BURST_32;
>   	} else {
> @@ -528,12 +547,13 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>   	if (!err)
>   		return 0;
>   	dev_err(&pdev->dev, "snd_soc_register_dai failed\n");
> -
> +error:
>   	if (!IS_ERR(priv->extclk)) {
>   		clk_disable_unprepare(priv->extclk);
>   		clk_put(priv->extclk);
>   	}
>   	clk_disable_unprepare(priv->clk);
> +	clk_put(priv->clk);
>
>   	return err;
>   }
> @@ -549,16 +569,26 @@ static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
>   		clk_put(priv->extclk);
>   	}
>   	clk_disable_unprepare(priv->clk);
> +	clk_put(priv->clk);
>
>   	return 0;
>   }
>
> +#ifdef CONFIG_OF
> +static struct of_device_id kirkwood_i2s_of_match[] = {
> +	{ .compatible = "marvell,kirkwood-i2s" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, kirkwood_i2s_of_match);
> +#endif
> +

What about kirkwood-dma? We don't want to have that as another DT node.
IMHO both kirkwood-dma and kirkwood-i2s should be merged into one file,
then dma can be initialized by a common probe function.

Sebastian

>   static struct platform_driver kirkwood_i2s_driver = {
>   	.probe  = kirkwood_i2s_dev_probe,
>   	.remove = kirkwood_i2s_dev_remove,
>   	.driver = {
>   		.name = DRV_NAME,
>   		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(kirkwood_i2s_of_match),
>   	},
>   };
>
