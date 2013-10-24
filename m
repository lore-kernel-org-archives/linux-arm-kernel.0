From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 24 Oct 2013 20:11:40 +0800
Subject: [Patch v2 09/10] usb: chipidea: host: add ehci quirk for imx
 controller
In-Reply-To: <20131024120411.GA31897@gimli>
References: <20131023180657.GI25954@gimli>
 <Pine.LNX.4.44L0.1310231433390.1326-100000@iolanthe.rowland.org>
 <20131024013325.GC32138@shlinux1.ap.freescale.net>
 <20131024120411.GA31897@gimli>
Message-ID: <20131024121140.GA31284@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 07:04:11AM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Oct 24, 2013 at 09:33:26AM +0800, Peter Chen wrote:
> > On Wed, Oct 23, 2013 at 02:45:39PM -0400, Alan Stern wrote:
> > > On Wed, 23 Oct 2013, Felipe Balbi wrote:
> > > 
> > > > Hi,
> > > > 
> > > > On Wed, Oct 23, 2013 at 10:46:09AM -0400, Alan Stern wrote:
> > > > > On Tue, 22 Oct 2013, Peter Chen wrote:
> > > > > 
> > > > > > When the port goes to suspend or finishes resme, it needs to
> > > > > > notify PHY, it is not a standard EHCI operation, so we add a
> > > > > > quirk for it.
> > > > > 
> > > > > Actually, this _should_ be a standard EHCI operation.  But we have to
> > > > > figure out a way to do it that will work on all platforms.
> > > > > 
> > > > > Felipe, any ideas?
> > > > 
> > > > isn't it enough to call usb_phy_set_suspend() at apropriate places ?
> > > > 
> > > > This should work on all platforms if the PHY driver is implemented
> > > > correctly.
> > > 
> > > On Tue, 22 Oct 2013, Peter Chen wrote:
> > > 
> > > > +				/*
> > > > +				 * notify the USB PHY, it is for global
> > > > +				 * suspend case.
> > > > +				 */
> > > > +				usb_phy_notify_suspend(hcd->phy,
> > > > +					USB_SPEED_HIGH);
> > > 
> > > Hmmm.  This calls usb_phy_notify_suspend(), and later on, 
> > > usb_phy_notify_resume().  AFAICT, those routines don't exist.
> > > 
> > 
> > Hi Alan and Felipe,
> > 
> > It is at my another patchset: "Add power management support for MXS PHY"
> > http://marc.info/?l=linux-usb&m=138242248913823&w=2
> > Since they are two things, one is from PHY, the other is for controller.
> > I split them to two patchset.
> > 
> > For these two notifications, please see:
> > [Patch v2 07/14] usb: phy: add notify suspend and resume callback
> > http://marc.info/?l=linux-usb&m=138242252713848&w=2
> > 
> > [Patch v2 08/14] usb: phy-mxs: Add implementation of
> > nofity_suspend and notify_resume
> > http://marc.info/?l=linux-usb&m=138242253313856&w=2
> > 
> > > Instead we have usb_phy_set_suspend(), as Felipe mentioned.  It has a
> > > different interface, because the second argument specifies whether we
> > > are entering or leaving suspend, not the connection speed.
> > > 
> > > Peter, you need to straighten this out.
> > 
> > .set_suspend is different with .notify_suspend.
> > 
> > .set_suspend is called when the PHY enters suspend.
> > .notify_suspend is called when port enters suspends (setting portsc.suspendM,
> > and stop sending SOF).
> > 
> > After calling .notify_suspend, the PHY may still need to access,
> > eg, set PHY wakeup setting, etc.
> 
> right, this just means we need usage counters for the PHY layer. So that
> usb_phy_set_suspend() only decreaments a counter and will only suspend
> the PHY when said counter reaches zero.
> 
> Also, why can't you *always* setup wakeup events for the PHY ? Everytime
> you're about to suspend the PHY, enable its wakeup events.

Most of cases, the user doesn't want USB wakeup event. At these cases,
if the PHY's wakeup is set, when external signal changes (id/vbus/dpdm),
the PHY will be woken up and more power consumption will be.

> 
> > The .notify_suspend is in ehci operation, .set_suspend can be at
> > controller driver, since when to put the PHY enters suspend may
> > platform specific.
> 
> not really, what's platform specific is *HOW* to suspend the PHY.
> *WHERE* to tell it to suspend is really more of a policy decision.
> 

How to suspend the PHY is indeed platform specific, but sometimes,
the whole suspend PHY operation may not only include PHY register, but also
needs controller register, Eg, for chipidea controller, if we have not used
chipidea PHY, we need to control both controller register (portsc.phcd)
and PHY's register (Different register mapping), so it is hard
to include two operations at usb_phy_set_suspend, we have to put them
at controller's suspend.

> > > Also, there's the question of where are the appropriate places to make
> > > the calls?  After the root hub goes into suspend, I suppose.  But when
> > > is the right time during resume?
> > > 
> > 
> > If we can take it as standard EHCI operation, we need to put it at below
> > places:
> > 	
> > For .notify_suspend, we need to put it after set portsc.suspendM.
> 
> why do you need this notification for suspendM ? PHY should
> automatically enter a lower power state automatically when suspendM
> signal is asserted.
> 

For some PHYs, it may correct. For chipidea controller, it needs to set
portsc.phcd to let the PHY enter suspend. The software needs to control it.

-- 

Best Regards,
Peter Chen
