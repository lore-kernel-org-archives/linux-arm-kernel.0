From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Jan 2017 11:30:25 +0000
Subject: [PATCH v2 2/2] arm: perf: Mark as non-removable
In-Reply-To: <2559413.O5mI12kdOo@ws-stein>
References: <20161221150340.25657-1-alexander.stein@systec-electronic.com>
 <20161221150340.25657-3-alexander.stein@systec-electronic.com>
 <20161222224547.GA30170@remoulade> <2559413.O5mI12kdOo@ws-stein>
Message-ID: <20170104113025.GE8329@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 10:19:46AM +0100, Alexander Stein wrote:
> On Thursday 22 December 2016 22:48:32, Mark Rutland wrote:
> > On Wed, Dec 21, 2016 at 04:03:40PM +0100, Alexander Stein wrote:

> > More generally, updating each and every driver in this manner seems like a
> > scattergun approach that is tiresome and error prone.
> > 
> > IMO, it would be vastly better for a higher layer to enforce that we don't
> > attempt to unbind drivers where the driver does not have a remove callback,
> > as is the case here (and I suspect most over cases where
> > DEBUG_TEST_DRIVER_REMOVE is blowing up).
> 
> You mean something like this?
> > diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> > index 4eabfe2..3b6c1a2d 100644
> > --- a/drivers/base/driver.c
> > +++ b/drivers/base/driver.c
> > @@ -158,6 +158,9 @@ int driver_register(struct device_driver *drv)
> > 
> >                 printk(KERN_WARNING "Driver '%s' needs updating - please use
> >                 "
> >                 
> >                         "bus_type methods\n", drv->name);
> > 
> > +       if (!drv->remove)
> > +               drv->suppress_bind_attrs = true;
> > +
> > 
> >         other = driver_find(drv->name, drv->bus);
> >         if (other) {
> >         
> >                 printk(KERN_ERR "Error: Driver '%s' is already registered, "

Something of that sort, yes. Or have a bus-level callback so that the
bus can reject it dynamically (without having to alter the drv attrs).

> > Is there any reason that can't be enforced at the bus layer, say?
> 
> I'm not sure if the change above works with remove functions set in struct 
> bus_type too.
> But on the other hand this would hide errors in drivers which are actually 
> removable but do not cleanup properly which DEBUG_TEST_DRIVER_REMOVE tries to 
> detect.
> By setting .suppress_bind_attrs = true explicitely you state "This 
> driver cannot be removed!", so the remove callback is not missing by accident.

I'm not sure I follow. If the remove callback is accidentally missing,
the driver is not "actually removable" today -- there's either no remove
code, or it's not been wired up (the latter of which will likely result
in a compiler warning about an unused function).

Aborting the remove early in those cases is much safer than forcefully
removing a driver without a remove callback.

Thanks,
Mark.
