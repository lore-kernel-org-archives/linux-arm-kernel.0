From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 19 Sep 2012 09:11:57 +0800
Subject: [PATCH v3] USB: mxs-phy: add basic otg support
In-Reply-To: <87pq5larqa.fsf@ashishki-desk.ger.corp.intel.com>
References: <1347872703-15167-1-git-send-email-richard.zhao@freescale.com>
 <87pq5larqa.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20120919011156.GD13530@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 01:06:21PM +0300, Alexander Shishkin wrote:
> Richard Zhao <richard.zhao@freescale.com> writes:
> 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > Acked-by: Felipe Balbi <balbi@ti.com>
> 
> Felipe said, 
> 
> > if you add a commit log you can add my:
> > 
> > Acked-by: Felipe Balbi <balbi@ti.com>
> 
> but the commit message is still totally missing. I would like to ask you
> to pay attention to the commit messages in the patches that you
> submit. They should explain the problem that your patch is solving, how
> you are solving it and why, so that anyone immediately knows what the
> patch is about without digging up mailing list conversations. There's
> also a nice blog entry [1] on how to write good commit messages.
> 
> [1] http://who-t.blogspot.com/2009/12/on-commit-messages.html
Will you agree to give ack if commit message changed to below?

    USB: mxs-phy: add fake otg support
    
    It has nothing to do with phy driver, but for now chipidea driver calls
    struct usb_otg callbacks. So we implement a fake one.
    
    When chipidea implement its own otg driver, this commit can be reverted.
    
    Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
    Acked-by: Felipe Balbi <balbi@ti.com

Thanks
Richard
> 
> > ---
> > Changes from v2:
> >  - assign host/gadget in mxs_phy_set_host/mxs_phy_set_peripheral
> >
> >  drivers/usb/otg/mxs-phy.c |   25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
> > index 88db976..3255112 100644
> > --- a/drivers/usb/otg/mxs-phy.c
> > +++ b/drivers/usb/otg/mxs-phy.c
> > @@ -129,12 +129,28 @@ static int mxs_phy_on_disconnect(struct usb_phy *phy, int port)
> >  	return 0;
> >  }
> >  
> > +static int mxs_phy_set_host(struct usb_otg *otg, struct usb_bus *host)
> > +{
> > +	otg->host = host;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mxs_phy_set_peripheral(struct usb_otg *otg,
> > +					struct usb_gadget *gadget)
> > +{
> > +	otg->gadget = gadget;
> > +
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
> > @@ -171,6 +187,15 @@ static int mxs_phy_probe(struct platform_device *pdev)
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
> >  	platform_set_drvdata(pdev, &mxs_phy->phy);
> >  
> >  	return 0;
> > -- 
> > 1.7.9.5
> 
