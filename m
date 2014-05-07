From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 7 May 2014 11:38:48 +0200
Subject: [PATCH v3 01/20] usb: ehci-orion: Fix clock reference leaking
In-Reply-To: <Pine.LNX.4.44L0.1405061027490.1312-100000@iolanthe.rowland.org>
References: <1399335255-589-2-git-send-email-gregory.clement@free-electrons.com>
 <Pine.LNX.4.44L0.1405061027490.1312-100000@iolanthe.rowland.org>
Message-ID: <20140507113848.037bb94d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alan Stern,

On Tue, 6 May 2014 10:30:57 -0400 (EDT), Alan Stern wrote:

> >  err2:
> > -	if (!IS_ERR(clk))
> > -		clk_disable_unprepare(clk);
> > +	usb_put_hcd(hcd);
> 
> At this point, priv has just become a dangling pointer, because it
> points to something that was allocated along with hcd.

Right.

> > +
> > +	if (!IS_ERR(priv->clk))
> > +		clk_disable_unprepare(priv->clk);
> 
> And now you are dereferencing memory that has been deallocated.  The
> real problem is that you get and enable the clock _after_ creating hcd,
> but you don't disable it _before_ deallocating hcd.

Correct.

> 
> >  err1:
> >  	dev_err(&pdev->dev, "init %s fail, %d\n",
> >  		dev_name(&pdev->dev), err);
> > @@ -260,14 +273,14 @@ err1:
> >  static int ehci_orion_drv_remove(struct platform_device *pdev)
> >  {
> >  	struct usb_hcd *hcd = platform_get_drvdata(pdev);
> > -	struct clk *clk;
> > +	struct orion_ehci_hcd *priv = hcd_to_orion_priv(hcd);
> >  
> >  	usb_remove_hcd(hcd);
> >  	usb_put_hcd(hcd);
> >  
> > -	clk = devm_clk_get(&pdev->dev, NULL);
> > -	if (!IS_ERR(clk))
> > -		clk_disable_unprepare(clk);
> > +	if (!IS_ERR(priv->clk))
> > +		clk_disable_unprepare(priv->clk);
> 
> This has the same problem as above.

Indeed. Will fix in v4.

> Also, for both this patch and 02/20, it would be better to replace the
> "errN" labels with something more descriptive, so that it's not
> necessary to renumber them every time something changes.

Sure. I've added an additional commit prior to this patch that renames
the goto labels to something more meaningful. This will be part of v4.

Thanks for the review!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
