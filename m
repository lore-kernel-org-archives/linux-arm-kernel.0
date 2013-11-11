From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 11 Nov 2013 10:47:23 +0100
Subject: Report from 2013 ARM kernel summit
In-Reply-To: <CACxGe6stYhZOc=MfGj8BgtG8zp6eh=jRFGUbFn1SSYRtw+zryA@mail.gmail.com>
References: <CACxGe6stYhZOc=MfGj8BgtG8zp6eh=jRFGUbFn1SSYRtw+zryA@mail.gmail.com>
Message-ID: <20131111.114723.1885845500744256130.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Missed some MLs. Resending....

Grant Likely <grant.likely@secretlab.ca> wrote @ Fri, 8 Nov 2013 14:20:46 +0100:

> Early Init, Deferred Probe and Init Order
...
> The big problem with deferring to initcalls is that the kernel doesn?t
> have any information about dependencies between devices and so doesn?t
> know what order to call modules in. Right now driver probe order is
> roughly determined by kernel link order first, and registration order
> second for devices populated during or after initcalls. Olof commented
> that the current driver model is based on the assumption that devices
> live in a single hierarchy. There is no easy way to add in dependency
> data with the current structure, and in most cases dependencies aren?t
> specifically on other devices, but rather on the service provided by
> another device (ie, a GPIO line).

I think that an IOMMU device is also the service provider for other
devices, where an single IOMMU device resides in the bus to provide
the address translation to the bus children.

> Kumar is concerned that deferred probe won?t work in all situations. For
> instance, what about a device that has an optional dependency? Does it
> fail to probe in the hope that the dependency will show up later? It was

Other devices don't know if the system has IOMMU or not. IOMMU'able
devices' population can be deferred till IOMMU device is populated,
but they don't know if there's really IOMMU device exists or not at
their population time.

....
> The suggestion was made that it would be a really nice to have the core
> kernel sort out probe order rather than using deferred probe. Grant
> replied that deferred probe was designed as the simplest possible
> solution to the problem, and by no means is he attached to it if someone
> can come up with a better approach. He did consider other options that
> put dependency resolution into the core, but it ended up pulling all
> kinds of GPIO, IRQ, Clock and DMA details into the core which made it
> quite complex.

I have a problem to control the poplution order for IOMMU in Tegra
SoC, and currently I haven't found any framework so that I inserted an
IOMMU hook in the driver core[1] since I discussed with Stephen Warren
and we thought that the number of those subsystem which requires this
kind of control isn't so many. This patch depends on a certain DT
bindings("#stream-id-cells") if a device has an dependency on IOMMU or
not. But at least this doesn't require anything for a client driver
side at all. The exsiting driver can be used as they are. The current
design is:

1, When a device is populated, it checks if that device is IOMMU'able
   or not. This is identified by "#stream-id-cells" in DT. If
   a device is normal(non IOMMU), a device is populated. If a device
   is IOMMU'able, it continues to be checked.

2, When an IOMMU device has been already populated,
   "dev->bus->iommu_ops" is set. If so a device(client) is registered
   as IOMMU'able, and the rest of population process continues. If not
   set yet, a device population would be deferred til
   "dev->bus->iommu_ops" is set.

3, After an IOMMU device has been already populated, deferred
   population will be continued.

I'm not so sure if this dependecy on "#stream-id-cells" is acceptable
or not, but I haven't any better idea right now.

Any suggestion/hint would be really appreciated.

[1]
http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006933.html
