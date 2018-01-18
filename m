From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 18 Jan 2018 13:44:08 +0100
Subject: [PATCH 2/2] pinctrl: imx: add driver for i.MX8MQ
In-Reply-To: <253551c30748ebcb3777baa4a232f656@agner.ch>
References: <20180117182804.26323-1-l.stach@pengutronix.de>
 <20180117182804.26323-2-l.stach@pengutronix.de>
 <253551c30748ebcb3777baa4a232f656@agner.ch>
Message-ID: <1516279448.19307.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Am Donnerstag, den 18.01.2018, 13:41 +0100 schrieb stefan at agner.ch:
> Hi Lucas,
> 
> On 17.01.2018 19:28, Lucas Stach wrote:
> > The i.MX8MQ pincontrol works in a similar way to the earlier i.MX
> > SoCs.
> > 
> > The driver code is largely copied from NXP's downstream driver
> > written
> > by Anson Huang. Only some small changes for upstream adaption are
> > done
> > by myself.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
[...]

> > +static struct imx_pinctrl_soc_info imx8mq_pinctrl_info = {
> > +	.pins = imx8mq_pinctrl_pads,
> > +	.npins = ARRAY_SIZE(imx8mq_pinctrl_pads),
> > +	.gpr_compatible = "nxp,imx8mq-iomuxc-gpr",
> > +};
> 
> I recently sent a patchset which allow to pass the struct
> imx_pinctrl_soc_info as const to imx_pinctrl_probe, hence this should
> be
> const.
> 
> See:
> https://lkml.org/lkml/2018/1/6/131
> 
> > +
> > +static struct of_device_id imx8mq_pinctrl_of_match[] = {
> > +	{ .compatible = "nxp,imx8mq-iomuxc", .data =
> > &imx8mq_pinctrl_info, },
> > +	{ /* sentinel */ }
> > +};
> > +
> > +static int imx8mq_pinctrl_probe(struct platform_device *pdev)
> > +{
> > +	const struct of_device_id *match;
> > +	struct imx_pinctrl_soc_info *pinctrl_info;
> > +
> > +	match = of_match_device(imx8mq_pinctrl_of_match, &pdev-
> > >dev);
> > +
> > +	if (!match)
> > +		return -ENODEV;
> > +
> > +	pinctrl_info = (struct imx_pinctrl_soc_info *) match-
> > >data;
> 
> ...and allow to make use of of_device_get_match_data?

Thanks for the hint, I'll change this for the next revision of this
patch.

Regards,
Lucas
