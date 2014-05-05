From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 05 May 2014 17:14:44 +0200
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <20140502174301.GE3805@e103592.cambridge.arm.com>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <6555552.UqkKQIAsih@wuerfel>
 <20140502174301.GE3805@e103592.cambridge.arm.com>
Message-ID: <4735818.FvYoTFuExd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 May 2014 18:43:01 Dave Martin wrote:
> On Fri, May 02, 2014 at 05:19:44PM +0200, Arnd Bergmann wrote:
> > On Friday 02 May 2014 15:23:29 Thierry Reding wrote:
> > > To some degree this also depends on how we want to handle IOMMUs. If
> > > they should remain transparently handled via dma_map_ops, then it makes
> > > sense to set this up at device instantiation time. But how can we handle
> > > this in situations where one device needs to master on two IOMMUs at the
> > > same time? Or if the device needs physically contiguous memory for
> > > purposes other than device I/O. Using dma_map_ops we can't control which
> > > allocations get mapped via the IOMMU and which don't.
> > 
> > I still hope we can handle this in common code by selecting the right
> > dma_map_ops when the devices are instantiated, at least for 99% of the
> > cases. I'm not convinced we really need to handle the 'multiple IOMMUs
> > on one device' case in a generic way. If there are no common use cases
> > for that, we can probably get away with having multiple device nodes
> > and an ugly driver for the exception, instead of making life complicated
> > for everybody.
> 
> Multiple IOMMUs certainly seems an unusual case for now.
> 
> Being able to describe that in the DT doesn't necessarily mean the
> kernel has to support it: just as the kernel doesn't need to support
> all the features of a crazy hardware platform just someone was crazy
> enough to build it.

Right.

> My expectation was that we do some check when probing a device to figure
> out the path from the device to main memory, thus figuring out the dma
> mask, the IOMMU (if any) and any relevant device ID.  This is a bit more
> complex than the existing situation, but I still think we could have
> common code for the bulk of it.

I'd still prefer if we could keep following just "dma-ranges" to find
a path from device to memory, with an extension to handle IOMMUs etc,
but not describe the things to the extend that your proposal does.

We already pretend that things are a tree for the purposes of MMIO,
which is probably still close enough for the vast majority of cases.
For simplicity, I'd actually prefer keeping the illusion that MMIO
and DMA are two different things, which matches how operating systems
see things even if it's no longer true for the hardware.

> If a device has different roles with completely different paths to
> memory, one option could be for the driver to instantiate two devices in
> the kernel.  This puts the burden on the driver for the device, instead
> of the core framework.

Yes, this is what I suggested earlier as well.

	ARnd
