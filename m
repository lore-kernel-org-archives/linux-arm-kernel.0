From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 May 2014 13:15:25 +0200
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <20140509103309.GA3875@e103592.cambridge.arm.com>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <4735818.FvYoTFuExd@wuerfel>
 <20140509103309.GA3875@e103592.cambridge.arm.com>
Message-ID: <4887391.D8xENWD7FA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 May 2014 11:33:18 Dave Martin wrote:
> On Mon, May 05, 2014 at 05:14:44PM +0200, Arnd Bergmann wrote:
> > On Friday 02 May 2014 18:43:01 Dave Martin wrote:
> > > My expectation was that we do some check when probing a device to figure
> > > out the path from the device to main memory, thus figuring out the dma
> > > mask, the IOMMU (if any) and any relevant device ID.  This is a bit more
> > > complex than the existing situation, but I still think we could have
> > > common code for the bulk of it.
> > 
> > I'd still prefer if we could keep following just "dma-ranges" to find
> > a path from device to memory, with an extension to handle IOMMUs etc,
> > but not describe the things to the extend that your proposal does.
> 
> This is really a simplification.  If we only had to consider the path
> from devices to memory, and if the pretence that the memory is at /
> works (almost always true, at least for general-purpose memory), then
> we often have a simpler problem.  It is still not always solvable
> though, since a device could still have a unique access path with
> unique mappings that cannot be described in terms of any of the other
> paths.
> 
> However, this is not just about DMA any more.  Devices also master onto
> interrupt controllers to generate MSIs, onto IOMMUs to provide them
> with address space remapping, onto other devices via IOMMUs; and GPUs
> can master onto all kinds of things.
> 
> The alternative to a completely generic description of bus mastering
> would be to consider the specific things that we are interested in
> allowing devices to master on, and describe the whole end-to-end
> link for each in the bus master's node.
> 
>  * memory
>  * interrupt controllers (for MSIs)
>  * IOMMUs

Right. The "memory" and "IOMMU" targets are really variations of the
same theme here: The one place we need to know about how to access
main memory is when we set up the dma_map_ops, and we already need
to know a number of things there:

- coherency
- bus offsets
- swiotlb range, if needed
- which IOMMU, if any

MSI also seems like something that is worth treating special, in
particular since the ARM implementation so much unlike everybody
else's and we need to have a way to give a consistent API to device
drivers.

> This could lead to combinatorial blow-up as the number of target
> devices grows, since these linkages have to be re-described for
> every bus master -- especially for GPUs which could do a fair amount of
> device control by themselves.  It could also lead to fragmentation
> as each binding solves common problems in different ways.

If the linkage is the same for multiple devices on the same bus,
I think we can always do it the traditional way using dma-ranges
on the parent bus.

> The downside is that is any path flows through a dynamically
> configurable component, such as an IOMMU or a bridge that can be
> remapped, turned off etc., then unless we describe how the path is
> really linked together the kernel will need all sorts of baked-in
> knowledge in order to manage the system safely.  The _effect_ of the
> problem component on the path is not static, so we can't describe 
> that effect directly in the DT.  For truly weird features that are
> unique to a particular platform that's OK, but "how devices are
> linked together" seems a much more general and useful concept than that.

My feeling is that this belongs in the same category as for example
PCI bus windows or pin control: while in theory we could describe
in DT exactly what the hardware is capable of and let the kernel
decide how to do it, this is much too complicated in practice, so
we are better off describing in DT how we /want/ things to be set up,
or how things are already set up by the firmware and not to be
touched.

> > We already pretend that things are a tree for the purposes of MMIO,
> > which is probably still close enough for the vast majority of cases.
> > For simplicity, I'd actually prefer keeping the illusion that MMIO
> > and DMA are two different things, which matches how operating systems
> > see things even if it's no longer true for the hardware.
> > 
> > > If a device has different roles with completely different paths to
> > > memory, one option could be for the driver to instantiate two devices in
> > > the kernel.  This puts the burden on the driver for the device, instead
> > > of the core framework.
> > 
> > Yes, this is what I suggested earlier as well.
> 
> I may have missed your point slightly before.  Anyway, I think the
> "multiple master roles" issue is sufficiently unusual that describing 
> them using multiple device nodes in the DT is reasonable.  So I think
> I'm happy to get rid of the ability to specify and distinguish multiple
> roles within a single device node.

Ok.

	Arnd
