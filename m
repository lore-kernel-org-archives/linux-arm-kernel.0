From: daniel.kiper@oracle.com (Daniel Kiper)
Date: Thu, 29 Oct 2015 17:36:55 +0100
Subject: arm64: iomem_resource doesn't contain all the region used
In-Reply-To: <563106C6.8000603@citrix.com>
References: <562A4B0F.2020603@citrix.com>
 <1445615112.2374.226.camel@citrix.com>
 <563106C6.8000603@citrix.com>
Message-ID: <20151029163655.GJ3489@olila.local.net-space.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 05:32:54PM +0000, Julien Grall wrote:
> (Adding David and Daniel)
>
> On 23/10/15 16:45, Ian Campbell wrote:
> > On Fri, 2015-10-23 at 15:58 +0100, Julien Grall wrote:
> >> Is there any way we could register the IO region used on ARM without
> >> having to enforce it in all the drivers?
> >
> > This seems like an uphill battle to me.
>
> I agree about it. However this is how x86 handle memory hotplug for xen
> ballooning. I'm wondering how this is cannot an problem for x86?
>
> Note that the problem is the same if a module is insert after hand.

Does ARM64 support memory hotplug on bare metal? If yes then check relevant
code and do what should be done as close as possible to bare metal case
on Xen guest.

> > Why not do as I suggested IRL yesterday and expose the map of "potential
> > RAM" addresses to the guest as well as the "actual RAM" addresses in the
> > regular memory properties.
> >
> > i.e. explicitly expose the holes where RAM can be hotplugged later.
>
> I was trying to find another solution because I find your suggestion
> fragile.
>
> Currently the device tree for a guest is set in stone after the creation
> of the domain. I.e it's not possible to modify the device tree later
> (I'm not speaking about hardcode value...).
>
> This means that the region for "balloon hotplug" and "PCI hotplug" must
> be static and can't overlapped. We may end up to run out of "PCI
> hotplug" address space while there is plenty of free space in the
> "balloon hotplug". However it's not possible to move from one to another.
>
> How do you define the size of those regions? In one side, we can't
> "hardcode" them because the user may not want to use either "balloon
> hotplug" or "PCI hoplug". On another side, we could expose them to the
> user but it's not nice.
>
> > This is even analogous to a native memory hotplug case, which AIUI
> > similarly involves the provisioning of specific address space where RAM
> > might plausibly appear in the future (I don't think physical memory hotplug
> > involves searching for free PA space and hoping for the best, although
> > strange things have happened I guess).
>
> I've looked at how Power PC handle native hotplug. From my
> understanding, when a new memory bank is added, the device tree will be
> updated by someone (firmware?) and an event will be sent to the Linux.
>
> Linux will then read the new DT node (see
> ibm,dynamic_reconfiguration-memory) and add the new memory region to Linux.

Make sense for me. It works more or less in the same way on bare metal x86.
Of course it uses ACPI instead of FDT.

> > With any luck you would be able to steal or define the bindings in terms of
> > the native hotplug case rather than inventing some Xen specific thing.
>
> I wasn't able to find the binding for ibm,dynamic-reconfiguration-memory
> in Linux.
>
> >
> > In terms of dom0 the "potential" RAM is the host's actual RAM banks.
>
> Your solution works for DOM0, but ...
>
> > In terms of domU the "potential" RAM is defined by the domain builder
> > layout (currently the two banks mentioned in Xen's arch-arm.h).
>
> ... the DOMU one is more complex (see above). Today the guest layout is
> static, I wouldn't be surprised to see it becoming dynamic very soon (I
> have in mind PCI hotplug) and therefore defining static hotplug region
> would not possible.

Please do not do that. I think that memory hotplug should not be limited
by anything but just a given platform limitations. By the way, could you
explain in details why linux/mm/memory_hotplug.c:register_memory_resource()
will not work on ARM64 guest?

Daniel
