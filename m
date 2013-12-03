From: Peter.Chen@freescale.com (Peter Chen)
Date: Tue, 3 Dec 2013 14:09:15 +0000
Subject: [PATCH v4 02/17] usb: phy-mxs: Add platform judgement code
In-Reply-To: <20131203102416.GB27635@pengutronix.de>
References: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
 <1386056231-17258-3-git-send-email-peter.chen@freescale.com>
 <20131203102416.GB27635@pengutronix.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A64980414134F@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> > +
> > +static const struct mxs_phy_data imx23_phy_data = {
> > +	.flags = MXS_PHY_ABNORAML_IN_SUSPEND | MXS_PHY_SENDING_SOF_TOO_FAST,
> > +};
> 
> ABNORAML? -> ABNORMAL
> 

My careless, will change. Thanks.

Peter 

> > +
> > +static const struct mxs_phy_data imx6q_phy_data = {
> > +	.flags = MXS_PHY_SENDING_SOF_TOO_FAST |
> > +		MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS,
> > +};
> > +
> > +static const struct mxs_phy_data imx6sl_phy_data = {
> > +	.flags = MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS,
> > +};
> > +
> > +static const struct of_device_id mxs_phy_dt_ids[] = {
> > +	{ .compatible = "fsl,imx6sl-usbphy", .data = &imx6sl_phy_data, },
> > +	{ .compatible = "fsl,imx6q-usbphy", .data = &imx6q_phy_data, },
> > +	{ .compatible = "fsl,imx23-usbphy", .data = &imx23_phy_data, },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mxs_phy_dt_ids);
> > +
> >  struct mxs_phy {
> >  	struct usb_phy phy;
> >  	struct clk *clk;
> > +	const struct mxs_phy_data *data;
> >  };
> >
> > -#define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)
> > -
> >  static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
> >  {
> >  	int ret;
> > @@ -131,6 +174,8 @@ static int mxs_phy_probe(struct platform_device
> *pdev)
> >  	struct clk *clk;
> >  	struct mxs_phy *mxs_phy;
> >  	int ret;
> > +	const struct of_device_id *of_id =
> > +			of_match_device(mxs_phy_dt_ids, &pdev->dev);
> >
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	base = devm_ioremap_resource(&pdev->dev, res);
> > @@ -163,6 +208,7 @@ static int mxs_phy_probe(struct platform_device
> *pdev)
> >  	ATOMIC_INIT_NOTIFIER_HEAD(&mxs_phy->phy.notifier);
> >
> >  	mxs_phy->clk = clk;
> > +	mxs_phy->data = of_id->data;
> >
> >  	platform_set_drvdata(pdev, mxs_phy);
> >
> > @@ -182,12 +228,6 @@ static int mxs_phy_remove(struct platform_device
> *pdev)
> >  	return 0;
> >  }
> >
> > -static const struct of_device_id mxs_phy_dt_ids[] = {
> > -	{ .compatible = "fsl,imx23-usbphy", },
> > -	{ /* sentinel */ }
> > -};
> > -MODULE_DEVICE_TABLE(of, mxs_phy_dt_ids);
> > -
> >  static struct platform_driver mxs_phy_driver = {
> >  	.probe = mxs_phy_probe,
> >  	.remove = mxs_phy_remove,
> > --
> > 1.7.8
> >
> >
> >
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |
