From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 8 Jul 2015 14:30:50 +0100
Subject: Master-aware devices and sideband ID data
In-Reply-To: <20150609101515.GA28474@leverpostej>
References: <20150324155007.GC23005@leverpostej>
 <26BE36EF-2C5B-4DA6-8950-8FEBB031ED1B@caviumnetworks.com>
 <20150527173953.GC23176@leverpostej>
 <E342D737-5DD5-48C7-BB01-B83C29CB6E31@caviumnetworks.com>
 <20150601102208.GD22406@leverpostej>
 <158EFC9F-FCAF-44D3-AD40-804EDFE0CE25@caviumnetworks.com>
 <20150605090534.GC1198@arm.com>
 <20150609101515.GA28474@leverpostej>
Message-ID: <20150708133049.GD7025@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 11:17:54AM +0100, Mark Rutland wrote:
> On Fri, Jun 05, 2015 at 10:05:34AM +0100, Will Deacon wrote:
> > On Thu, Jun 04, 2015 at 11:19:30PM +0100, Chalamarla, Tirumalesh wrote:
> > > > On Jun 1, 2015, at 3:22 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > It's possible to specify that the paths exist. I expect that software
> > > > would select which to use at runtime.
> > > > 
> > > My worry is how to define any priorities/preferences between masters. 
> > > in general the proposal looks reasonable.
> > 
> > I agree that the proposal looks reasonable (in terms of the ability to
> > describe the sort of topologies that we will face) but I still don't
> > understand what I need to do in e.g. my IOMMU driver to support this
> > binding whilst continuing to support the existing iommus binding, which
> > is relied upon to configure dma-mapping.
> > 
> > Mark: how do you see this co-existing/merging with the current bindings?
> 
> As I mentioned in my initial mail, it's not clear to me how this can be
> reconciled with the current bindings. Everything I've been able to come
> up with so far at best ends up describing the same thing repeatedly.
> 
> I'll see what I can come up with. Any sugestions are welcome!

I can't see a way of keeping the ID transformations explicit with the
existing bindings, but I think we can simply fold these down into
properties in the master nodes, given we expect each ID to be derived
from some initial master ID anyway.

So, to cater for the ITS we would need to pass master IDs along with the
MSI parent information, which we could do by extending msi-parent or by
introducing a new msis property which behaves similarly to the iommus
property, describing the MSI controllers the device can address (via any
IOMMUs), along with any controller-specific identification data.

Which means we'd have DT fragments like the following for an arbitrary
platform device:

its0: its {
	...
	msi-controller;
	#msi-cells = <1>; // DeviceId
};

its1: its {
	...
	msi-controller;
	#msi-cells = <1>; // DeviceId
};

smmu: smmu {
	...
	iommu-cells = <1>; // StreamId
};

device {
	...
	iommus = <&its 0>;
	/* Can use either ITS, but has a different ID at each */
	msis = <&its0 0x0>, <&its1 0x400>;
};

That doesn't allow you to describe a device with multiple mater ports
where each master port might want to generate MSIs, but I'm not sure if
that's a real case.

For PCIe root complexes, we'd need to describe the BDF -> iommu-cells
and BDF -> msi-cells translations separately with new properties on the
node for the root complex itself.

Is there anything obviously broken with the above approach?

Thanks,
Mark.
