From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 03 Mar 2016 16:00:46 +0100
Subject: [PATCH 06/17] reset: Add PLX Technology Reset Controller driver
In-Reply-To: <56D84A49.4010400@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-7-git-send-email-narmstrong@baylibre.com>
 <1457014709.3425.53.camel@pengutronix.de> <56D84A49.4010400@baylibre.com>
Message-ID: <1457017246.3425.70.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 03.03.2016, 15:29 +0100 schrieb Neil Armstrong:
> >> +static int oxnas_reset_reset(struct reset_controller_dev *rcdev,
> >> +			      unsigned long id)
> >> +{
> >> +	struct oxnas_reset *data =
> >> +		container_of(rcdev, struct oxnas_reset, rcdev);
> >> +
> >> +	regmap_write(data->regmap, RST_SET_REGOFFSET, BIT(id));
> >> +	msleep(50);
> > 
> > Is this the right delay for all of the resets in this register?
> > If not, I'd drop the .reset callback.
> > 
> The delay is not strictly necessary, but better to avoid any HW issues.

Ok, maybe add a comment.

> And the .reset callback is needed since reset_control_reset
> does not assert -> deassert as fallback.

That's because some controllers don't even have manual
assertion/deassertion, and for some reset lines the drivers better know
the timing or they want to do other stuff while the reset is asserted.

[...]
> >> +static struct reset_control_ops oxnas_reset_ops = {
> > 
> > const
> > 
> Something checkpatch should report...

This is new in any case. rcdev->ops was not const* until recently.

> >> +	.reset		= oxnas_reset_reset,
> >> +	.assert		= oxnas_reset_assert,
> >> +	.deassert	= oxnas_reset_deassert,
> >> +};
> >> +
> >> +static const struct of_device_id oxnas_reset_dt_ids[] = {
> >> +	 { .compatible = "plxtech,nas782x-reset", },
> >> +	 { /* sentinel */ },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, oxnas_reset_dt_ids);
> >> +
> >> +static int oxnas_reset_probe(struct platform_device *pdev)
> >> +{
> >> +	struct oxnas_reset *data;
> >> +	struct device *parent;
> >> +
> >> +	parent = pdev->dev.parent;
> >> +	if (!parent) {
> >> +		dev_err(&pdev->dev, "no parent\n");
> > 
> > Can this even happen?
> > 
> It's to make sure parent->of_node is valid for syscon_node_to_regmap.

Since this is a platform device probed via device tree,
pdev->dev.parent should always be set (see of_device_alloc()).

regards
Philipp
