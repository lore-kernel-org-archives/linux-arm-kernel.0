From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 8 Jul 2013 14:27:26 -0400 (EDT)
Subject: [PATCH 1/2] USB: OHCI: make ohci-ep93xx a separate driver
In-Reply-To: <CAJFYCKH4xMgG7XTy_Fz8J6F8ussR_NtfKJ1CnOG-N9xG1CcYKA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1307081424310.879-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Jul 2013, Manjunath Goudar wrote:

> > > @@ -79,7 +93,10 @@ static int usb_hcd_ep93xx_probe(const struct
> > hc_driver *driver,
> > >
> > >       ep93xx_start_hc(&pdev->dev);
> > >
> > > -     ohci_hcd_init(hcd_to_ohci(hcd));
> > > +     ohci = hcd_to_ohci(hcd);
> > > +     ohci->next_statechange = jiffies;
> > > +     spin_lock_init(&ohci->lock);
> > > +     INIT_LIST_HEAD(&ohci->pending);
> > >
> > >       retval = usb_add_hcd(hcd, pdev->resource[1].start, 0);
> > >       if (retval == 0)
> >
> 
> Instead of ohci_hcd_ini() function call,wrote above code.

You ought to be aware that usb_add_hcd() will call ohci_setup(), which
calls ohci_hcd_init() -- after all, _you_ wrote ohci_setup()!

So what reason is there for doing these things a second time?

Alan Stern
