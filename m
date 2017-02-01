From: oss@buserror.net (Scott Wood)
Date: Wed, 01 Feb 2017 16:51:05 -0600
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
In-Reply-To: <3cc42823-0fc9-ed3e-1738-bf6e314dd569@arm.com>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
 <VI1PR0401MB2430DA6BD2F857C30EC86A50917F0@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <HE1PR0401MB263638F320470CA216990BCC86720@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <5414359.8GMja3pNrI@wuerfel>
 <VI1PR0401MB24303C4A5C0042005E17F1A391770@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <CAK8P3a1Gd4bd7GjEp_a9WXc_mTPk0XmP7DH8aPWhbn2K3MMuDQ@mail.gmail.com>
 <1485570872.9266.22.camel@buserror.net>
 <d5ca6bcd-1d1a-2a61-1f5c-9086a67f629a@arm.com>
 <HE1PR0401MB2636FF4D977DDA6888616A26864B0@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <3cc42823-0fc9-ed3e-1738-bf6e314dd569@arm.com>
Message-ID: <1485989465.24433.12.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-02-01 at 13:03 +0000, Robin Murphy wrote:
> On 30/01/17 19:04, Roy Pledge wrote:
> > 
> > On 1/30/2017 10:31 AM, Robin Murphy wrote:
> > > 
> > > On 28/01/17 02:34, Scott Wood wrote:
> > > > 
> > > > On Fri, 2017-01-27 at 17:41 +0100, Arnd Bergmann wrote:
> > > > > 
> > > > > On Thu, Jan 26, 2017 at 6:08 AM, Scott Wood <scott.wood@nxp.com>
> > > > > wrote:
> > > > > > 
> > > > > > On 01/25/2017 03:20 PM, Arnd Bergmann wrote:
> > > > > > > 
> > > > > > > On Monday, January 23, 2017 7:24:59 PM CET Roy Pledge wrote:
> > > > > > > If this is normal RAM, you should be able to just write zeroes,
> > > > > > > and then
> > > > > > > do a dma_map_single() for initialization.
> > > > > > The DMA API on PPC currently has no way of knowing that the device
> > > > > > accesses this memory incoherently.
> > > > > Ah, this is because PPC doesn't use the 'dma-coherent' property on
> > > > > devices
> > > > > but just assumes that coherency is a global property of the
> > > > > platform,right?
> > > > Right.
> > > > 
> > > > > 
> > > > > > 
> > > > > > If that were somehow fixed, we still couldn't use dma_map_single()
> > > > > > as it
> > > > > > doesn't accept virtual addresses that come from memremap() or
> > > > > > similar
> > > > > > dynamic mappings.??We'd have to convert the physical address to an
> > > > > > array
> > > > > > of struct pages and pass each one to dma_map_page().
> > > > > Sorry for my ignorance, but where does the memory come from to start
> > > > > with? Is this in the normal linearly mapped RAM, in a carveout
> > > > > outside
> > > > > of the linear mapping but the same memory, or in some on-chip
> > > > > buffer?
> > > > It's RAM that comes from the device tree reserved memory mechanism
> > > > (drivers/of/of_reserved_mem.c).??On a 32-bit kernel it is not
> > > > guaranteed (or
> > > > likely) to be lowmem.
> > > Wouldn't dma_declare_coherent_memory() be the appropriate tool for that
> > > job, then (modulo the PPC issue)? On ARM that should result in
> > > dma_alloc_coherent() giving back a non-cacheable mapping if the device
> > > is non-coherent, wherein a dmb_wmb() after writing the data from the CPU
> > > side should be enough to ensure it is published to the device.
> > I think there is some confusion here (and it may very well be mine).
> > 
> > My understanding is that the dma_declare_coherent_memory() API sets up a
> > region of memory that will be managed by dma_alloc_coherent() and
> > friends.??This is useful if the driver needs to manage a region of on
> > device memory but that isn't what this specific region is used for.
> It's a bit more general than that - dma_alloc_coherent() can essentially
> be considered "give me some memory for this device to use". We already
> have use-cases where such buffers are only ever accessed by the device
> (e.g. some display controllers, and future NVMe devices), hence
> DMA_ATTR_NO_KERNEL_MAPPING on ARM to save the vmalloc space.

That doesn't deal with the fact that on PPC the DMA API will assume that DMA
is coherent -- and in fact providing non-cacheable memory is difficult on PPC
because the memory is covered by large-page cacheable mappings and mixing
cacheable and non-cacheable mappings is strictly forbidden (not just in terms
of coherence -- I've seen mysterious machine checks generated).

The idea behind the DMA API is that the platform knows better than the driver
how DMA needs to be handled, and usually that's correct -- but sometimes, with
integrated SoC devices whose programming model was designed from the
perspective of the entire platform, it isn't.

> A DMA allocation also inherently guarantees appropriate alignment,
> regardless of whether you're using a per-device reservation or just
> regular CMA, 

When "appropriate alignment" is many megabytes, you're more likely to waste
memory when you try to guarantee alignment on a secondary allocation than when
you're doing the aligned allocation directly from the main memory pool.

And how exactly does the DMA API know what alignment this particular
allocation needs? ?dma_alloc_coherent() doesn't take alignment as a parameter.

> and will also zero the underlying memory (and for a
> non-coherent device perform whatever cache maintenance is necessary, if
> the clearing isn't already done via a non-cacheable mapping).
> 
> All you need to do in the driver is allocate your buffer and hand the
> resulting address off to the device at probe (after optionally checking
> for a reservation in DT and declaring it), then free it at remove, which
> also ends up far more self-documenting (IMO)

It might be more self-documenting but as I pointed out earlier in this thread
it doesn't *work* without PPC arch work, and due to the mapping issues
mentioned above fixing the PPC arch (and in particular, this subarch) to
handle this would be difficult.

>  than a bunch of open-coded remapping and #ifdef'ed architecture-private
> cache shenanigans.

The only reason for the ifdefs is because arches can't agree on what to call
the function that actually does an unconditional cache flush.

And as I also pointed out earlier, this is not the only place where this
driver needs to do cache flushing.

-Scott
