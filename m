From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 30 Mar 2013 12:22:54 +0000
Subject: [PATCH v3 3/7] USB: EHCI: make ehci-s5p a separate driver
In-Reply-To: <Pine.LNX.4.44L0.1303291534190.1467-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1303291534190.1467-100000@iolanthe.rowland.org>
Message-ID: <201303301222.54337.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 March 2013, Alan Stern wrote:
> On Thu, 28 Mar 2013, Arnd Bergmann wrote:

> 
> Personally, I would have left these two functions the way they were and 
> relied on the compiler to inline them when appropriate.  Eliminating 
> them just makes the code more complicated.

Yes, makes sense. I'm leaving the change in now, because I don't
see a strong reason to undo the change, and the two functions
will likely get collapsed into a single line each after the move
to the phy subsystem is complete.

> >  static int s5p_ehci_probe(struct platform_device *pdev)
> >  {
> > +	struct usb_hcd *hcd ;
> >  	struct s5p_ehci_platdata *pdata = pdev->dev.platform_data;
> > +	const struct hc_driver *driver = &s5p_ehci_hc_driver;
> >  	struct s5p_ehci_hcd *s5p_ehci;
> > -	struct usb_hcd *hcd;
> 
> What's the reason for these changes?  There's no need for the "driver" 
> variable, and improper whitespace was added to the declaration of 
> "hcd".

I'll let Manjunath answer this, I have no idea. My suspicion is that
it was a misguided attempt to work around a checkpatch warning for
an overly long line.

I've reverted the above changes now for v4.

> > @@ -153,16 +117,12 @@ static int s5p_ehci_probe(struct platform_device *pdev)
> >  		s5p_ehci->otg = phy->otg;
> >  	}
> >  
> > -	s5p_ehci->dev = &pdev->dev;
> > -
> > -	hcd = usb_create_hcd(&s5p_ehci_hc_driver, &pdev->dev,
> > -					dev_name(&pdev->dev));
> > +	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
> 
> s5p_ehci is not initialized correctly.  The devm_kzalloc() call was 
> left in and to_s5p_ehci() was not called.

Oh crap.

I checked that Manjunath had fixed this bug in the other drivers, but
missed it here. I updated it for v4 now.

> Was anybody able to test this patch?

I thought that Manjunath had received hardware for it now, but it's pretty
evident that the patch was not tested. The Ack from Jingoo Han was for an
older version that did not contain the change to .extra_priv_size.

	Arnd
