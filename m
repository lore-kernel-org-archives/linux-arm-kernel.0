From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 10 May 2016 15:54:57 +0200
Subject: [RFC PATCH 12/21] reset: uniphier: add core support for
 UniPhier reset driver
In-Reply-To: <1462873862-30940-13-git-send-email-yamada.masahiro@socionext.com>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
 <1462873862-30940-13-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462888497.9155.9.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 10.05.2016, 18:50 +0900 schrieb Masahiro Yamada:
[...]
> +static int uniphier_reset_update(struct reset_controller_dev *rcdev,
> +				 unsigned long id, bool assert)
> +{
> +	struct uniphier_reset_priv *priv = to_uniphier_reset_priv(rcdev);
> +	const struct uniphier_reset_data *p;
> +	bool handled = false;
> +
> +	for (p = priv->data; p->id != UNIPHIER_RESET_ID_END; p++) {
> +		unsigned int val;
> +		int ret;
> +
> +		if (p->id != id)
> +			continue;
> +
> +		val = p->deassert_val;
> +		if (assert)
> +			val = ~val;
> +
> +		ret = regmap_write_bits(priv->regmap, p->reg, p->mask, val);

What is the difference between mask and deassert_val? Couldn't you just
assign
	val = assert ? 0 : p->mask;
?

> +static const struct reset_control_ops uniphier_reset_ops = {
> +	.assert = uniphier_reset_assert,
> +	.deassert = uniphier_reset_deassert,
> +	.status = uniphier_reset_status,
> +};
> +
> +int uniphier_reset_probe(struct platform_device *pdev,
> +			 const struct uniphier_reset_data *data)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uniphier_reset_priv *priv;
> +	const struct uniphier_reset_data *p;
> +	struct regmap *regmap;
> +	unsigned int nr_resets = 0;
> +
> +	/* parent should be MFD and syscon node */
> +	regmap = syscon_node_to_regmap(dev->parent->of_node);
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "failed to get regmap\n");

syscon_node_to_regmap can return different error codes. It might be
helpful to use
	dev_err(dev, "failed to get regmap: %d\n", PTR_ERR(regmap));
here.

regards
Philipp
