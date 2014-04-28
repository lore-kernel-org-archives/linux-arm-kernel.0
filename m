From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 28 Apr 2014 14:49:14 +0200
Subject: [PATCH v12 11/31] documentation: iommu: add binding document of
 Exynos System MMU
In-Reply-To: <4780885.JaktFvJeC7@wuerfel>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <6544270.ddFBoY6LMm@wuerfel> <20140428111802.GI19455@ulmo>
 <4780885.JaktFvJeC7@wuerfel>
Message-ID: <20140428124912.GL19455@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 02:05:30PM +0200, Arnd Bergmann wrote:
> On Monday 28 April 2014 13:18:03 Thierry Reding wrote:
> > On Mon, Apr 28, 2014 at 12:56:03PM +0200, Arnd Bergmann wrote:
> > > On Monday 28 April 2014 12:39:20 Thierry Reding wrote:
> > > > And possibly with a iommu-names property to go along with that. The idea
> > > > being that a device can be a master on possibly multiple IOMMUs. Using
> > > > the above it would also be possible to have one device be multiple
> > > > masters on the same IOMMU.
> > > 
> > > Yes, that seems reasonable. Just one question: How would you represent a
> > > device that has multiple masters, with at least one connected to an IOMMU
> > > and another one connected to memory directly, without going to the IOMMU?
> > 
> > Heh, I don't think I've ever thought about that use-case. I guess I was
> > always assuming that in the absence of an IOMMU the device would simply
> > access memory directly. From what I can tell that's how Tegra works at
> > least. If the IOMMU is not enabled for a given client, that client will
> > access physical memory untranslated.
> > 
> > I suppose if that really must be represented then a global dummy IOMMU
> > could be introduced to help with these cases.
> 
> It's actually not too uncommon: you can have e.g. the lower 2GB mapped
> directly from the device address space into the host memory, but have
> an iommu that translates accesses from some range in the upper 2GB of
> the 32-bit address space into full 64-bit addresses.
> 
> This use case makes no sense if you use the IOMMU for isolation
> or virtualization, but it gives better performance for lowmem access
> when the only reason to have the IOMMU is to map highmem addresses.

Thinking about this some more, isn't the non-IOMMU master something we
can completely ignore in the DT? Or at least it shouldn't be handled by
the IOMMU bindings because, well, it's not an IOMMU to begin with.

Perhaps it's something that should be described using dma-ranges?

> > > A lot of drivers probably only support one
> > > master, so they can just set #iommu-cells=<0>, others might require
> > > IDs that do not fit into one cell.
> > 
> > You mean "#iommu-cells = <1>" for devices that only require one master?
> 
> I meant an IOMMU device that acts as the slave for exactly one device,
> even if that device has multiple master ports.

Okay, makes sense. I guess depending on the nature of the IOMMU it might
make sense not to expose it as an IOMMU at all. For example if it lives
completely within the register space of its master device. In that case
it could be directly programmed from the device's driver.

> > There still has to be one cell to specify which master. Unless perhaps
> > if they can be arbitrarily assigned. I guess even if there's a fixed
> > mapping that applies to one SoC generation, it might be good to still
> > employ a specifier and have the mapping in DT for flexibility.
> 
> let me clarify by example:
> 
> 	iommu at 1 {
> 		compatible = "some,simple-iommu";
> 		reg = <1>;
> 		#iommu-cells = <0>; /* supports only one master */
> 	};
> 
> 	iommu at 2 {
> 		compatible = "some,other-iommu";
> 		reg = <3>;
> 		#iommu-cells = <1>; /* contains master ID */
> 	};
> 
> 	iommu at 3 {
> 		compatible = "some,windowed-iommu";
> 		reg = <2>;
> 		#iommu-cells = <2>; /* contains dma-window */
> 	};
> 
> 	device at 4 {
> 		compatible = "some,ethernet";
> 		iommus = <&/iommu@1>;
> 	};
> 
> 	device at 5 {
> 		compatible = "some,dmaengine";
> 		iommus = <&/iommu@2 0x40000000 0x1000000>,
> 			 <&/iommu@3 0x101>;
> 	};
> 
> The device at address 4 has a one-one relationship with iommu at 1, so there
> is no need for any data. device at 5 has two master ports. One is connected to
> an IOMMU that has a per-device aperture, device at 5 can only issue transfers
> to the 256MB area at 0x40000000, and the IOMMU will have to put entries for
> this device into that address. The second master port is connected to
> iommu at 3, which uses a master ID that gets passed along with each transfer,
> so that needs to be put into the IOTLBs.

The above sounds reasonable to me with the exception of the DMA window
specifier. Isn't that precisely the information that we currently
describe using the dma-ranges property?

> A variation would be to not use #iommu-cells at all, but provide a
> #address-cells / #size-cells pair in the IOMMU, and have a translation
> as we do for dma-ranges. This is probably most flexible.

I'm not sure I follow. Wouldn't that require masters to be children of
the IOMMU DT nodes for that to work out? Also how would that work for
cases where more data than the address ranges (such as the master ID) is
needed to operate the IOMMU?

> One completely open question that I just noticed is how the kernel should
> deal with the case of multiple IOMMUs attached to one master: the
> data structures we have assume that we know exactly how to do DMA by
> setting the per-device dma_map_ops (iommu or not, coherent or not),
> and by setting a pointer to at most one IOMMU.

Perhaps we need something more fine-grained than what we currently have.
I can imagine that rather than having it all abstracted away and handled
transparently (which undoubtedly has a lot of advantages), we need to
expose a client API of sorts that drivers can use.

I'm mostly brainstorming here and not thinking of any concrete use-case:

	struct iommu_master *master = iommu_get(dev, "foo");

	iommu_master_set_range(master, 0, SZ_256M);

	pages = alloc_pages(...);

	iova = iommu_master_map(master, pages);

The above would essentially obtain a handle to the "foo" IOMMUs master,
set the valid DMA range (hard-coded in the driver or obtained from a
dma-ranges property), allocates some pages of memory and then maps them
into the device's address space via the IOMMU.

The reason why I think what we have isn't going to work is that it is
assumed that either there is an IOMMU or there isn't. So memory gets
either mapped through an IOMMU or it doesn't. Furthermore IOMMU usage is
likely very use-case dependent and it's probably not easy to determine
automatically which IOMMU is to be used for individual allocations.

Allowing more fine-grained control of the IOMMU from drivers should
increase the flexibility of users since they have more context to make
the right decisions.

But then again, I have only a very sketchy idea of what an IOMMU needs
to be able to do, so maybe the above doesn't make sense at all.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/ae69f285/attachment-0001.sig>
