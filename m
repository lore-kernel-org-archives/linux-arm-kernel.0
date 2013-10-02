From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 2 Oct 2013 11:52:13 -0400 (EDT)
Subject: [PATCH 06/11] USB: OHCI: Properly handle ohci-exynos suspend
In-Reply-To: <2706834.Eq1ry5ZFL1@amdc1032>
Message-ID: <Pine.LNX.4.44L0.1310021149110.1293-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Oct 2013, Bartlomiej Zolnierkiewicz wrote:

> 
> Hi,
> 
> On Wednesday, October 02, 2013 10:38:58 AM Alan Stern wrote:
> > On Wed, 2 Oct 2013, Bartlomiej Zolnierkiewicz wrote:
> > 
> > > Maybe it would make sense to cleanup ohci_suspend() first (before adding
> > > new ohci_suspend() users) and remove unused do_wakeup parameter?
> > 
> > Not possible.  The do_wakeup parameter is part of a function prototype
> > shared by other callback routines (such as ehci_suspend()) that _do_
> > use the parameter.
> 
> If you mean ohci-pci.c usage (which is currently the only usage of
> ohci_suspend() looking at the latest -next kernel) than it is enough
> to add a simple wrapper for it in ohci-pci.c:
> 
> ...
> static int ohci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
> {
> 	ohci_suspend(hcd);
> }
> ...
>     ohci_pci_hc_driver.pci_suspend = ohci_pci_suspend;
> ...

Ah, now I see your point.  Yes, it's true; that parameter could be 
eliminated.

Manjunath, would you like to update your patch series to get rid of the 
do_wakeup argument to ohci_suspend()?

Alan Stern
