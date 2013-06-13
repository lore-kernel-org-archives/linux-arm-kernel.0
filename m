From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 13 Jun 2013 11:08:12 -0400 (EDT)
Subject: [PATCh V10 04/12] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <CADApbegr5RBODJD=4UZ5Skn_N91oxwDFDxnS7Qqh5dot0EnU-Q@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306131106160.1561-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jun 2013, Chao Xie wrote:

> >> These operations sound generic enough to be done at HCD layer, no? So no need to
> >> replicate the same stuff in ohci, ehci, xhci, etc.
> >
> > The HCD layer handles suspend and resume only for PCI host controllers.
> > Not for other types.
> >
> > I don't know if the acquire/start and stop/release parts can be moved
> > into the USB core.  Maybe they can.
> >
> > Alan Stern
> >
> hi
> The following is my understanding.
> I think for PHY initialization and shutdown part, it is generic for
> other parts.
> PHY initialization need to be called before hc_driver->reset is called.
> I think it can be added at usb_add_hcd.
> For PHY shutdown, it can be added at usb_remove_hcd.

Yes, that should work.

> For suspend/resume, i do not know how to add it. For our EHCI driver,
> when system goes to deep idle states, we just directly shutdown the
> hcd and initialize it again when the system goes back.

You shut down the host controller?  Then how does it detect wakeup 
events?  And how does it know if a device was disconnected while the 
power was off?

Alan Stern
