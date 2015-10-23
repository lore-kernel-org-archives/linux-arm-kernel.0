From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Oct 2015 12:20:44 -0700
Subject: MUSB peripheral DMA regression caused by driver core runtime PM
 change
In-Reply-To: <Pine.LNX.4.44L0.1510231406200.1644-100000@iolanthe.rowland.org>
References: <562A7549.3070400@ti.com>
 <Pine.LNX.4.44L0.1510231406200.1644-100000@iolanthe.rowland.org>
Message-ID: <20151023192044.GX3078@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alan Stern <stern@rowland.harvard.edu> [151023 11:27]:
> On Fri, 23 Oct 2015, Grygorii Strashko wrote:
> 
> > Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > 
> > It always fun when DD/PM core is updated to fix some driver/subsystem's
> > specific PM issue :(
> > 
> > > 
> > >> --- a/drivers/usb/musb/omap2430.c
> > >> +++ b/drivers/usb/musb/omap2430.c
> > >> @@ -391,9 +391,20 @@ static int omap2430_musb_init(struct musb *musb)
> > >>   	}
> > >>   	musb->isr = omap2430_musb_interrupt;
> > >>   
> > >> +	/*
> > >> +	 * Enable runtime PM for musb parent (this driver). We can't
> > >> +	 * do it earlier as struct musb is not yet allocated and we
> > >> +	 * need to touch the musb registers for runtime PM.
> > >> +	 */
> > >> +	pm_runtime_enable(glue->dev);
> > >> +	status = pm_runtime_get_sync(glue->dev);
> > >> +	if (status < 0)
> > >> +		goto err1;
> > >> +
> > >>   	status = pm_runtime_get_sync(dev);
> > 
> > Hm. My assumption was that *Parent* device (omap2430) will be enabled
> > here :( But as I can see this will not happen:

Yes the parent child stuff here is very confusing right now :)

> > static int rpm_resume(struct device *dev, int rpmflags)
> > {...
> > 	if (!parent && dev->parent) {
> > 		/*
> > 		 * Increment the parent's usage counter and resume it if
> > 		 * necessary.  Not needed if dev is irq-safe; then the
> > 		 * parent is permanently resumed.
> > 		 */
> > 		parent = dev->parent;
> > 		if (dev->power.irq_safe)
> > 			goto skip_parent;
> > 
> > ^^^ and musb device is irq_safe :( 
> 
> This way of doing things looks very strange.
> 
> If the omap2430 is the parent of the musb device, and
> pm_runtime_irq_safe() has been called for the musb device, then after
> that the omap2430 will never be runtime suspended.  Therefore it
> doesn't matter whether you enable it for runtime PM or not.
> 
> It seems to me that the real problem must be that the musb device gets
> runtime-enabled and marked irq_safe too early.  These things should 
> happen before the musb device gets registered and exposed to userspace, 
> but not before the omap2430 parent is runtime-enabled.
> 
> Thus the sequence of events should be:
> 
> 	Allocate the musb device;
> 	Runtime-enable the omap2430 (since it is now safe to do so);
> 	Runtime-enable the musb and declare it irq_safe (this will
> 		automatically runtime-resume the omap2430);
> 	Register the musb.
> 
> If things are done this way, no special action needs to be taken.

Yes good point, that requires changing the init for the whole
drivers/musb though. Also, we should reorganize the whole musb and make
the platform glue and musb core drivers completely separate using a
shared interrupt where needed.

For the regression for the -rc series? Do you see any better
alternatives to what I posted?

Regards,

Tony
