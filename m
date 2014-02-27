From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Feb 2014 15:00:44 +0100
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <alpine.DEB.2.02.1402271229370.31489@kaball.uk.xensource.com>
References: <20140226183454.GA14639@cbox>
 <20140226214843.GD12169@bivouac.eciton.net>
 <alpine.DEB.2.02.1402271229370.31489@kaball.uk.xensource.com>
Message-ID: <11174980.YJ21cfsHoG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 12:31:55 Stefano Stabellini wrote:
> On Wed, 26 Feb 2014, Leif Lindholm wrote:
> > > >   no FDT.  In this case, the VM implementation must provide ACPI, and
> > > >   the OS must be able to locate the ACPI root pointer through the UEFI
> > > >   system table.
> > > > 
> > > > For more information about the arm and arm64 boot conventions, see
> > > > Documentation/arm/Booting and Documentation/arm64/booting.txt in the
> > > > Linux kernel source tree.
> > > > 
> > > > For more information about UEFI and ACPI booting, see [4] and [5].
> > > 
> > > What's the point of having ACPI in a virtual machine? You wouldn't
> > > need to abstract any of the hardware in AML since you already know
> > > what the virtual hardware is, so I can't see how this would help
> > > anyone.
> > 
> > The point is that if we need to share any real hw then we need to use
> > whatever the host has.

I would be more comfortable defining in the spec that you cannot share
hardware at all. Obviously that doesn't stop anyone from actually
sharing hardware with the guest, but at that point it would become
noncompliant with this spec, with the consequence that you couldn't
expect a compliant guest image to run on that hardware, but that is
exactly something we can't guarantee anyway because we don't know
what drivers might be needed.

Also, there is no way to generally do this with either FDT or ACPI:
In the former case, the hypervisor needs to modify any properties
that point to other device nodes so that they point to nodes visible
to the guest. That may be possible for simple things like IRQs
and reg properties, but as soon as you get into stuff like dmaengine,
pinctrl or PHY references, you just can't solve it in a generic way.

For ACPI it's probably worse: any AML methods that the host has
are unlikely to work in the guest, and it's impossible to translate
them at all.

Obviously things are different for Xen Dom0 where we share *all* devices
between host and guest, and we just use the host firmware interfaces.
That case again cannot be covered by the generic VM system specification.

> I dislike ACPI as much as the next guy, but unfortunately if the host
> only supports ACPI, the Linux driver for a particular device only works
> together with ACPI, and you want to assign that device to a VM, then we
> might be forced to use ACPI to describe it.

Can anyone think of an example where this would actually work?

The only case I can see where it's possible to share a device with
a guest without the hypervisor building up the description is for
PCI functions that are passed through with an IOMMU. Those won't
need ACPI or DT support however.

	Arnd
