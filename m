From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 17 Nov 2014 16:44:56 -0500 (EST)
Subject: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
In-Reply-To: <20141117211117.GD5258@dtor-ws>
Message-ID: <Pine.LNX.4.44L0.1411171641170.855-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Nov 2014, Dmitry Torokhov wrote:

> > When the runtime PM core invokes a power domain's callback routine,
> > what does the domain's routine usually do?  Does it go ahead and invoke
> > the driver's callback?  Or does it try to invoke the subsystem's
> > callback?
> > 
> > Obviously this depends on how the power domain code is written.  But
> > suppose every power domain would always use the same strategy as the PM
> > core: Invoke the subsystem's callback if there is one; otherwise invoke
> > the driver's callback.
> > 
> > Then there wouldn't be a problem.  Even when a runtime-resume went via
> > the power domain, the subsystem would still be able to protect the
> > not-yet-bound driver from being called.
> > 
> > (... Unless the subsystem itself was incapable of doing this the right 
> > way.  But subsystems can be fixed.)
> 
> The genpd code currently starts by powering on the domain (if it is not
> on already) and then does "device restore" which is:
> 
> /**
>  * pm_genpd_default_restore_state - Default PM domians "restore device state".
>  * @dev: Device to handle.
>  */
> static int pm_genpd_default_restore_state(struct device *dev)
> {
> 	int (*cb)(struct device *__dev);
> 
> 	cb = dev_gpd_data(dev)->ops.restore_state;
> 	if (cb)
> 		return cb(dev);
> 
> 	if (dev->type && dev->type->pm)
> 		cb = dev->type->pm->runtime_resume;
> 	else if (dev->class && dev->class->pm)
> 		cb = dev->class->pm->runtime_resume;
> 	else if (dev->bus && dev->bus->pm)
> 		cb = dev->bus->pm->runtime_resume;
> 	else
> 		cb = NULL;
> 
> 	if (!cb && dev->driver && dev->driver->pm)
> 		cb = dev->driver->pm->runtime_resume;
> 
> 	return cb ? cb(dev) : 0;
> }
> 
> So I guess bus (or class or type) can take care of it.

The bus could.  I don't think the class or type knows when a driver is 
being probed.

>  Except buses
> usually call pm_generic_runtime_resume() which ends up fetching driver's
> callbacks. Maybe pm_generic_runtime_*() need be a bit smarter?

No, the bus subsystem needs to be smarter.  It shouldn't call 
pm_generic_runtime_resume() if the driver hasn't been probed yet, or if 
the driver has already been unbound from the device.

Alan Stern
