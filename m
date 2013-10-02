From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 02 Oct 2013 17:10:32 +0200
Subject: [PATCH 06/11] USB: OHCI: Properly handle ohci-exynos suspend
In-Reply-To: <Pine.LNX.4.44L0.1310021036360.1293-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1310021036360.1293-100000@iolanthe.rowland.org>
Message-ID: <2706834.Eq1ry5ZFL1@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wednesday, October 02, 2013 10:38:58 AM Alan Stern wrote:
> On Wed, 2 Oct 2013, Bartlomiej Zolnierkiewicz wrote:
> 
> > Maybe it would make sense to cleanup ohci_suspend() first (before adding
> > new ohci_suspend() users) and remove unused do_wakeup parameter?
> 
> Not possible.  The do_wakeup parameter is part of a function prototype
> shared by other callback routines (such as ehci_suspend()) that _do_
> use the parameter.

If you mean ohci-pci.c usage (which is currently the only usage of
ohci_suspend() looking at the latest -next kernel) than it is enough
to add a simple wrapper for it in ohci-pci.c:

...
static int ohci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
{
	ohci_suspend(hcd);
}
...
    ohci_pci_hc_driver.pci_suspend = ohci_pci_suspend;
...


Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
