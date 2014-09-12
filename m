From: Peter.Chen@freescale.com (Peter Chen)
Date: Fri, 12 Sep 2014 00:05:55 +0000
Subject: [PATCH v4 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <20140911153119.GA11275@kwain>
References: <1409730511-16101-1-git-send-email-antoine.tenart@free-electrons.com>
 <1409730511-16101-8-git-send-email-antoine.tenart@free-electrons.com>
 <20140911010709.GE3609@peterchendt> <20140911153119.GA11275@kwain>
Message-ID: <600c4437f5d14520931aabc242fd69f4@BN1PR0301MB0772.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
> On Thu, Sep 11, 2014 at 09:07:10AM +0800, Peter Chen wrote:
> > On Wed, Sep 03, 2014 at 09:48:26AM +0200, Antoine Tenart wrote:
> > > +
> > > +static int ci_hdrc_usb2_dt_probe(struct device *dev,
> > > +				 struct ci_hdrc_platform_data *ci_pdata) {
> > > +	ci_pdata->phy = of_phy_get(dev->of_node, 0);
> > > +	if (IS_ERR(ci_pdata->phy)) {
> > > +		if (PTR_ERR(ci_pdata->phy) == -EPROBE_DEFER)
> > > +			return -EPROBE_DEFER;
> > > +
> > > +		/* PHY is optional */
> > > +		ci_pdata->phy = NULL;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> >
> > You may also need to consider usb_phy case.
> 
> Don't we try using the generic PHY framework for new drivers?
> 
> Since there is no need for supporting an usb_phy case I don't think we have to
> consider this case yet. And no doing so could encourage people to add PHY
> drivers to the common PHY framework.
> 

If the common PHY framework is the only right way in future, you don't
need to change it.

> > > +
> > > +	if (dev->of_node) {
> > > +		ret = ci_hdrc_usb2_dt_probe(dev, ci_pdata);
> > > +		if (ret)
> > > +			return ret;
> > > +	} else {
> > > +		ret = dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(32));
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> >
> > You may need to do clk_disable_unprepare for above error cases.
> 
> Sure, I'll fix that.
> 
> > > +
> > > +	ci_pdata->name = dev_name(&pdev->dev);
> > > +
> > > +	priv->ci_pdev = ci_hdrc_add_device(dev, pdev->resource,
> > > +					   pdev->num_resources, ci_pdata);
> > > +	if (IS_ERR(priv->ci_pdev)) {
> > > +		ret = PTR_ERR(priv->ci_pdev);
> > > +		if (ret != -EPROBE_DEFER)
> > > +			dev_err(dev,
> > > +				"failed to register ci_hdrc platform
> device: %d\n",
> > > +				ret);
> >
> > Why you don't want the error message for deferral probe?
> 
> A driver can return an EPROBE_DEFER error and still probe successfully later.
> This would be confusing to have this kind of error message in this case. And
> when a driver returns -EPROBE_DEFER, there is an error message already.
> 

OK, agree.

Peter
