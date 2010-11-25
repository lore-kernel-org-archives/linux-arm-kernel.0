From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 26 Nov 2010 00:32:37 +0100
Subject: [PATCH v5 04/12] spi: add ti-ssp spi master driver
In-Reply-To: <20101118054611.GB13567@suse.de>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<20101117161130.GC5757@angua.secretlab.ca>
	<20101118054611.GB13567@suse.de>
Message-ID: <201011260032.38154.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 18, 2010, Greg KH wrote:
> On Wed, Nov 17, 2010 at 09:11:30AM -0700, Grant Likely wrote:
> > Also, any dependency tracking must work across bus_types.  It is not
> > sufficient to only handle the platform_devices use-case.  All bus
> > types have this need.
> 
> Agreed.
> 
> > I see a few potential approaches.
> > 
> > Option 1: Add a list of prerequisite devices to struct device and
> > modify driver core so that it defers binding to a driver until all the
> > prerequisites are already bound.  This can probably be implemented
> > in a way that works for all bus types transparently.  Before binding
> > a driver, the driver core would increase the ref count on each of the
> > prereq devices, and decrease it again when the driver is removed.
> 
> I see loops happening easily that prevent any device from being bound.
> That could get tricky to debug :(
> 
> > Option 2: On a per-bus_type basis have a separate registration and the
> > bus type code would hold the device unregistered in a pending list.
> > This option would also add a prerequisites list to struct device.
> 
> When would we process the "pending list"?
> 
> I can see something like this working, up to a point.  Once device (or
> driver) registration is complete, we would walk the lists of busses and
> see if anything new wants to be bound again, now that something new has
> shown up, instead of just walking the single bus.
> 
> But then we have the issue of devices that never are bound to anything,
> it could get a little "noisy" with them never binding, but we can't rely
> on the fact that not all devices are not bound to know when to stop
> trying.
> 
> This might be the simplest to try out as we do almost all of this today
> in the driver core (walk the list and try to bind all unbound devices to
> a new driver.)  Just extend that walking to walk all other busses as
> well.  But this would require that the drivers know when they can't bind
> to a device due to something not being set up properly, which I don't
> know if is always true.
> 
> > Option 3: Don't try to handle it in the bus_type or driver core code
> > at all, but rather provide board support code with helpers to make
> > waiting for other devices easy.  Even in this case I think it is
> > probably still a good idea for the dependant devices to increment
> > the refcount of the prereq devices.

That's necessary IMO.

> > Perhaps something that is used like:
> > 
> > void do_second_registration(void)
> > {
> > 	/* register list of dependant devices */
> > }
> > 
> > and then in the primary registration function:
> > 	...
> > 	device_notify_when_bound(&prereq_pdev->dev,
> > 				 do_second_registration);
> > 	platform_device_add(prereq_pdev);
> > 	...
> > 
> > which would reduce the boilerplate, but remain flexible.  However,
> > while flexable, option 3 doesn't solve the dependency tracking
> > problem, and it still requires some gymnastics to handle multiple
> > dependencies.
> > 
> > On a related issue, it may also be desirable for each device to
> > maintain a list of devices that have claimed dependency on it for the
> > purpose of debugability.
> 
> That might be the simplest as each "board type" knows which devices it
> wants to register and in what order, right?

Ironically enough, we also have this problem in ACPI where there are power
resources that "regular" devices may depend on in pretty much the same way
as discussed here.  Those power resources are represented as devices, so the
problem is really analogous.

In ACPI, though, basically all devices are registered by the same routine that
walks the namespace (which is a tree-like structure) and registers all devices
it finds there.  Before registering a device it examines its properties and,
among other things, it finds what power resources the device depends on.  Then,
it may invoke itself in a recursive way to register those power resources before
registering the device (the recurrence is one-level only, because power
resources cannot depend on anything else).  Since the driver for power
resources has been already registered at that point, we know it will bind to
the power resource device objects as soon as they are registered.  This is done
in a patch series I posted yesterday, actaully.

I'm not sure if this approach can be generalized somehow, but in the ACPI
case it works just fine.

Thanks,
Rafael
