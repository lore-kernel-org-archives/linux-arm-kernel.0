From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 21 Jul 2018 13:06:09 +0000
Subject: [PATCH v4 4/4] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <20180721114009.flgmof3pfimu6v5m@pengutronix.de>
References: <20180718071251.8857-1-o.rempel@pengutronix.de>
 <20180718071251.8857-5-o.rempel@pengutronix.de>
 <87a4624e-35a6-3529-90ce-71ea9fb1cf7e@mentor.com>
 <20180721114009.flgmof3pfimu6v5m@pengutronix.de>
Message-ID: <AM0PR04MB42116B2B6DF7EB02238BCF7980500@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksij,

> -----Original Message-----
> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
> Sent: Saturday, July 21, 2018 7:40 PM
> To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>;
> kernel at pengutronix.de; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v4 4/4] mailbox: Add support for i.MX7D messaging unit
> 

[...]

> > > +
> > > +static int imx_mu_remove(struct platform_device *pdev) {
> > > +	struct imx_mu_priv *priv = platform_get_drvdata(pdev);
> > > +
> > > +	mbox_controller_unregister(&priv->mbox);
> > > +	clk_disable_unprepare(priv->clk);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void imx_mu_init_generic(struct imx_mu_priv *priv) {
> > > +	if (priv->side_b)
> > > +		return;
> > > +
> > > +	/* Set default MU configuration */
> > > +	imx_mu_write(priv, 0, IMX_MU_xCR); }
> > > +
> > > +static const struct imx_mu_cfg imx_mu_cfg_generic = {
> > > +	.chans = IMX_MU_MAX_CHANS,
> >
> > Here IMX_MU_MAX_CHANS macro name is questionable, see my top
> comment.
> > For clarity here 'MAX' is not expected, it shall be the exact
> > controller specific value, something like s/MAX/NUM/ may be considered.
> 
> this MU provide 4+4 interrupts for TX/RX registers and 4 general purpose
> interrupts which can be reused for mailbox with shared memory or as irq
> controller.
> The NXP implementation of SCU on i.MX8 is using one MU as one channel.
> 
> I'm not sure how many channels should be defined as it is endproduct
> specific. So far MAX == 4 until other already existing implementations go
> upstream.
> 

4 is ok to me currently.

> > > +	.init_hw = imx_mu_init_generic,
> > > +};
> > > +
> > > +static const struct of_device_id imx_mu_dt_ids[] = {
> > > +	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_generic },
> > > +	{ .compatible = "fsl,imx7d-mu", .data = &imx_mu_cfg_generic },
> > > +	{ .compatible = "fsl,imx7s-mu", .data = &imx_mu_cfg_generic },
> > > +	{ .compatible = "fsl,imx7ulp-mu", .data = &imx_mu_cfg_generic },
> > > +	{ .compatible = "fsl,imx8qm-mu", .data = &imx_mu_cfg_generic },
> > > +	{ .compatible = "fsl,imx8qxp-mu", .data = &imx_mu_cfg_generic },
> >
> > It sounds like the list will be constantly extending. Is there any
> > chance to introduce just one generic compatible in the driver, and
> > describe the whole set of compatibles in documentation section only?
> 
> Experience with iMX* IPs showed - it is worth do describe each IP in each SoC
> with SoC specific name. See SPI, UART and other iMX driver. Why we should
> make here an exception?
> 

Even SPI, UART driver you mentioned here do not describe all the SoC compatible
strings. New ones are usually added when we need different SoC specific .data.
But here all SoC specific .data actually is the same one which seems like an
unnecessary thing in driver.

Regards
Dong Aisheng

> > > +	{ },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
> > > +
> > > +static struct platform_driver imx_mu_driver = {
> > > +	.probe		= imx_mu_probe,
> > > +	.remove		= imx_mu_remove,
> > > +	.driver = {
> > > +		.name	= "imx_mu",
> > > +		.of_match_table = imx_mu_dt_ids,
> > > +	},
> > > +};
> > > +module_platform_driver(imx_mu_driver);
> > > +
> > > +MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
> > > +MODULE_DESCRIPTION("Message Unit driver for i.MX");
> > > +MODULE_LICENSE("GPL v2");
> > >
> >
> > --
> > Best wishes,
> > Vladimir
> >
> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
