From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 31 Jul 2013 16:44:43 -0400 (EDT)
Subject: [PATCH v2 6/8] usb: host: ohci-s3c2410 Use
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <6370497.apKG6kIlfT@flatron>
Message-ID: <Pine.LNX.4.44L0.1307311643110.1546-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Jul 2013, Tomasz Figa wrote:

> Alan, Greg,
> 
> On Tuesday 23 of July 2013 01:49:23 Tomasz Figa wrote:
> > This patch modifies the ohci-s3c2410 driver to prepare and unprepare
> > clocks in addition to enabling and disabling, since it is required
> > by common clock framework.
> > 
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > ---
> >  drivers/usb/host/ohci-s3c2410.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/host/ohci-s3c2410.c
> > b/drivers/usb/host/ohci-s3c2410.c index e125770..db096bf 100644
> > --- a/drivers/usb/host/ohci-s3c2410.c
> > +++ b/drivers/usb/host/ohci-s3c2410.c
> > @@ -47,10 +47,10 @@ static void s3c2410_start_hc(struct platform_device
> > *dev, struct usb_hcd *hcd)
> > 
> >  	dev_dbg(&dev->dev, "s3c2410_start_hc:\n");
> > 
> > -	clk_enable(usb_clk);
> > +	clk_prepare_enable(usb_clk);
> >  	mdelay(2);			/* let the bus clock stabilise */
> > 
> > -	clk_enable(clk);
> > +	clk_prepare_enable(clk);
> > 
> >  	if (info != NULL) {
> >  		info->hcd	= hcd;
> > @@ -75,8 +75,8 @@ static void s3c2410_stop_hc(struct platform_device
> > *dev) (info->enable_oc)(info, 0);
> >  	}
> > 
> > -	clk_disable(clk);
> > -	clk_disable(usb_clk);
> > +	clk_disable_unprepare(clk);
> > +	clk_disable_unprepare(usb_clk);
> >  }
> > 
> >  /* ohci_s3c2410_hub_status_data
> 
> Any chance to get your ack on this?

Sorry, this must have slipped past.  It's fine with me.

Alan Stern
