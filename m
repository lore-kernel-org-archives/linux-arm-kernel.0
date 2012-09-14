From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 14 Sep 2012 18:53:17 +0800
Subject: [PATCH v2 06/11] USB: mxs-phy: add basic otg support
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803C81A63@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
 <1346137397-32374-7-git-send-email-richard.zhao@freescale.com>
 <F281D0F91ED19E4D8E63A7504E8A649803C81A63@039-SN2MPN1-022.039d.mgd.msft.net>
Message-ID: <20120914102043.GA13530@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 04:56:13PM +0800, Chen Peter-B29397 wrote:
>  
> > diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
> > index c1a67cb..6a03e97 100644
> > --- a/drivers/usb/otg/mxs-phy.c
> > +++ b/drivers/usb/otg/mxs-phy.c
> > @@ -97,12 +97,24 @@ static int mxs_phy_on_disconnect(struct usb_phy *phy,
> > int port)
> >  	return 0;
> >  }
> > 
> > +static int mxs_phy_set_host(struct usb_otg *otg, struct usb_bus *host)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int mxs_phy_set_peripheral(struct usb_otg *otg,
> > +					struct usb_gadget *gadget)
> > +{
> > +	return 0;
> > +}
> > +
> >  static int mxs_phy_probe(struct platform_device *pdev)
> >  {
> >  	struct resource *res;
> >  	void __iomem *base;
> >  	struct clk *clk;
> >  	struct mxs_phy *mxs_phy;
> > +	struct usb_otg *otg;
> > 
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	if (!res) {
> > @@ -139,6 +151,15 @@ static int mxs_phy_probe(struct platform_device
> > *pdev)
> > 
> >  	mxs_phy->clk = clk;
> > 
> > +	otg = devm_kzalloc(&pdev->dev, sizeof(struct usb_otg), GFP_KERNEL);
> > +	if (!otg)
> > +		return -ENOMEM;
> > +	otg->phy = &mxs_phy->phy;
> > +	otg->set_host = mxs_phy_set_host;
> > +	otg->set_peripheral = mxs_phy_set_peripheral;
> > +
> > +	mxs_phy->phy.otg = otg;
> > +
> 
> Put otg struct at PHY driver is not a good practice.
> Only OTG driver who handles ID interrupt cases about host and gadget struct.
> PHY is a transceiver, it not cares otg, host and device at all.
I understand your concern, but this patch don't mean to restructure
common code.

Thanks
Richard
> 
> >  	platform_set_drvdata(pdev, &mxs_phy->phy);
> > 
> >  	return 0;
> > --
> > 1.7.9.5
> 
