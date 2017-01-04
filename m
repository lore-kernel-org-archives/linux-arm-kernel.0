From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Jan 2017 11:46:13 +0000
Subject: [PATCH v2 2/2] arm: perf: Mark as non-removable
In-Reply-To: <20170104114056.GO14217@n2100.armlinux.org.uk>
References: <20161221150340.25657-1-alexander.stein@systec-electronic.com>
 <20161221150340.25657-3-alexander.stein@systec-electronic.com>
 <20161222224547.GA30170@remoulade> <2559413.O5mI12kdOo@ws-stein>
 <20170104113025.GE8329@leverpostej>
 <20170104114056.GO14217@n2100.armlinux.org.uk>
Message-ID: <20170104114612.GF8329@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 11:40:56AM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 04, 2017 at 11:30:25AM +0000, Mark Rutland wrote:
> > On Wed, Jan 04, 2017 at 10:19:46AM +0100, Alexander Stein wrote:
> > > I'm not sure if the change above works with remove functions set in struct 
> > > bus_type too.
> > > But on the other hand this would hide errors in drivers which are actually 
> > > removable but do not cleanup properly which DEBUG_TEST_DRIVER_REMOVE tries to 
> > > detect.
> > > By setting .suppress_bind_attrs = true explicitely you state "This 
> > > driver cannot be removed!", so the remove callback is not missing by accident.
> > 
> > I'm not sure I follow. If the remove callback is accidentally missing,
> > the driver is not "actually removable" today -- there's either no remove
> > code, or it's not been wired up (the latter of which will likely result
> > in a compiler warning about an unused function).
> > 
> > Aborting the remove early in those cases is much safer than forcefully
> > removing a driver without a remove callback.
> 
> Drivers without a remove function may be removable - there's more layers
> than just the driver - there's the bus layer as well, which may or may
> not direct to a private-bus pointer.

Sure; which is why I initially suggested doing something at the bus
layer. That way, each layer could do any necessary check, and/or
delegate to a callback for the layer below.

> There's no real way for the core driver model code to know whether the
> lack of the ->remove in the struct device_driver is something that
> prevents a driver being removed, or whether it's handled via some other
> method.  Eg, platform drivers.

While true today, my suggestion is to add the infrastrucutre such that
it can. That seems nicer to me than each driver having to retain
(redundant) state.

Regardless, this patch itself is fine.

Thanks,
Mark.
