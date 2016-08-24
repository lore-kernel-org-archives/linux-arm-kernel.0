From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 24 Aug 2016 14:27:02 +0200
Subject: [PATCH 2/2] reset: uniphier: use of_device_get_match_data() to
 get matched data
In-Reply-To: <1472020830-16059-3-git-send-email-yamada.masahiro@socionext.com>
References: <1472020830-16059-1-git-send-email-yamada.masahiro@socionext.com>
 <1472020830-16059-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1472041622.5335.32.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

Am Mittwoch, den 24.08.2016, 15:40 +0900 schrieb Masahiro Yamada:
> Use of_device_get_match_data() instead of of_match_node().  With
> this, we can retrieve the .data field of the OF match table more
> easily.  No more need to define (or declare) the match table before
> the probe callback.  I prefer to collect boilerplates at the bottom
> of the file, so moved it below.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/reset/reset-uniphier.c | 81 +++++++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
> index 41c62af..9b3f2cd 100644
> --- a/drivers/reset/reset-uniphier.c
> +++ b/drivers/reset/reset-uniphier.c
> @@ -16,6 +16,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> @@ -285,6 +286,45 @@ static const struct reset_control_ops uniphier_reset_ops = {
>  	.status = uniphier_reset_status,
>  };
>  
> +static int uniphier_reset_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uniphier_reset_priv *priv;
> +	const struct uniphier_reset_data *p, *data;
> +	struct regmap *regmap;
> +	struct device_node *parent;
> +	unsigned int nr_resets = 0;
> +
> +	data = of_device_get_match_data(dev);
> +	WARN_ON(!data);

I know right now this can't happen anyway, but you did return -EINVAL
here before. Maybe use:

	if (WARN_ON(!data))
		return -EINVAL;

instead? I can fix it up if you agree.

> +	parent = of_get_parent(dev->of_node); /* parent should be syscon node */
> +	regmap = syscon_node_to_regmap(parent);
> +	of_node_put(parent);
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "failed to get regmap (error %ld)\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	for (p = data; p->id != UNIPHIER_RESET_ID_END; p++)

If in the future somebody forgets to set OF match data, this would be a
NULL pointer dereference.

regards
Philipp
