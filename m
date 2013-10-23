From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 23 Oct 2013 14:45:39 -0400 (EDT)
Subject: [Patch v2 09/10] usb: chipidea: host: add ehci quirk for imx
 controller
In-Reply-To: <20131023180657.GI25954@gimli>
Message-ID: <Pine.LNX.4.44L0.1310231433390.1326-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Oct 2013, Felipe Balbi wrote:

> Hi,
> 
> On Wed, Oct 23, 2013 at 10:46:09AM -0400, Alan Stern wrote:
> > On Tue, 22 Oct 2013, Peter Chen wrote:
> > 
> > > When the port goes to suspend or finishes resme, it needs to
> > > notify PHY, it is not a standard EHCI operation, so we add a
> > > quirk for it.
> > 
> > Actually, this _should_ be a standard EHCI operation.  But we have to
> > figure out a way to do it that will work on all platforms.
> > 
> > Felipe, any ideas?
> 
> isn't it enough to call usb_phy_set_suspend() at apropriate places ?
> 
> This should work on all platforms if the PHY driver is implemented
> correctly.

On Tue, 22 Oct 2013, Peter Chen wrote:

> +				/*
> +				 * notify the USB PHY, it is for global
> +				 * suspend case.
> +				 */
> +				usb_phy_notify_suspend(hcd->phy,
> +					USB_SPEED_HIGH);

Hmmm.  This calls usb_phy_notify_suspend(), and later on, 
usb_phy_notify_resume().  AFAICT, those routines don't exist.

Instead we have usb_phy_set_suspend(), as Felipe mentioned.  It has a
different interface, because the second argument specifies whether we
are entering or leaving suspend, not the connection speed.

Peter, you need to straighten this out.

Also, there's the question of where are the appropriate places to make
the calls?  After the root hub goes into suspend, I suppose.  But when
is the right time during resume?

And what if there is more than one port on the root hub?

Alan Stern
