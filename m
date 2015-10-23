From: ian.campbell@citrix.com (Ian Campbell)
Date: Fri, 23 Oct 2015 16:45:12 +0100
Subject: arm64: iomem_resource doesn't contain all the region used
In-Reply-To: <562A4B0F.2020603@citrix.com>
References: <562A4B0F.2020603@citrix.com>
Message-ID: <1445615112.2374.226.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-10-23 at 15:58 +0100, Julien Grall wrote:
> Is there any way we could register the IO region used on ARM without
> having to enforce it in all the drivers?

This seems like an uphill battle to me.

Why not do as I suggested IRL yesterday and expose the map of "potential
RAM" addresses to the guest as well as the "actual RAM" addresses in the
regular memory properties.

i.e. explicitly expose the holes where RAM can be hotplugged later.

This is even analogous to a native memory hotplug case, which AIUI
similarly involves the provisioning of specific address space where RAM
might plausibly appear in the future (I don't think physical memory hotplug
involves searching for free PA space and hoping for the best, although
strange things have happened I guess).

With any luck you would be able to steal or define the bindings in terms of
the native hotplug case rather than inventing some Xen specific thing.

In terms of dom0 the "potential" RAM is the host's actual RAM banks.

In terms of domU the "potential" RAM is defined by the domain builder
layout (currently the two banks mentioned in Xen's arch-arm.h).

Ian.
