From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 3 Oct 2013 10:31:53 -0400 (EDT)
Subject: [PATCH 06/11] USB: OHCI: Properly handle ohci-exynos suspend
In-Reply-To: <CAKsNYyws1m1kT4KiJ6GFcTSo0cT=cu+0nA0vwx=wu_SuRhAfhA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1310031027190.1287-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Oct 2013, manju goudar wrote:

> On Wed, Oct 2, 2013 at 9:22 PM, Alan Stern <stern@rowland.harvard.edu>wrote:
> 
> > On Wed, 2 Oct 2013, Bartlomiej Zolnierkiewicz wrote:
> >
> > >
> > > Hi,
> > >
> > > On Wednesday, October 02, 2013 10:38:58 AM Alan Stern wrote:
> > > > On Wed, 2 Oct 2013, Bartlomiej Zolnierkiewicz wrote:
> > > >
> > > > > Maybe it would make sense to cleanup ohci_suspend() first (before
> > adding
> > > > > new ohci_suspend() users) and remove unused do_wakeup parameter?
> > > >
> > > > Not possible.  The do_wakeup parameter is part of a function prototype
> > > > shared by other callback routines (such as ehci_suspend()) that _do_
> > > > use the parameter.
> > >
> > > If you mean ohci-pci.c usage (which is currently the only usage of
> > > ohci_suspend() looking at the latest -next kernel) than it is enough
> > > to add a simple wrapper for it in ohci-pci.c:
> > >
> > > ...
> > > static int ohci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
> > > {
> > >       ohci_suspend(hcd);
> > > }
> > > ...
> > >     ohci_pci_hc_driver.pci_suspend = ohci_pci_suspend;
> > > ...
> >
> > Ah, now I see your point.  Yes, it's true; that parameter could be
> > eliminated.
> >
> > Manjunath, would you like to update your patch series to get rid of the
> > do_wakeup argument to ohci_suspend()?
> >
> > Yes I will do. I think we can also rid of ehci_suspend() do_wakeup
> argument.

Arrgh!  Manjunath, I was wrong.  I'm sorry to make you do all this
extra work -- your original patch series was correct.

Bartlomiej, we both failed to notice that the 1/11 patch in the 
original series adds a usage of do_wakeup.  Therefore that argument 
cannot be removed.

Greg, please ignore Manjunath's V2 series (sent today) and merge the 
original 11-patch series posted on October 2.

Alan Stern
