From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 6 Jun 2016 12:42:56 +0100
Subject: [RFC v2 4/4] ARM: keystone: dma-coherent with safe fallback
In-Reply-To: <5480709.cGbSehIKrE@wuerfel>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
 <1465183229-24147-5-git-send-email-wmills@ti.com>
 <20160606085627.GA6831@leverpostej> <5480709.cGbSehIKrE@wuerfel>
Message-ID: <20160606114256.GF6831@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 11:09:07AM +0200, Arnd Bergmann wrote:
> On Monday, June 6, 2016 9:56:27 AM CEST Mark Rutland wrote:
> > [adding devicetree]
> > 
> > On Sun, Jun 05, 2016 at 11:20:29PM -0400, Bill Mills wrote:
> > > Keystone2 can do DMA coherency but only if:
> > > 1) DDR3A DMA buffers are in high physical addresses (0x8_0000_0000)
> > >     (DDR3B does not have this constraint)
> > > 2) Memory is marked outer shared
> > > 3) DMA Master marks transactions as outer shared
> > >     (This is taken care of in bootloader)
> > > 
> > > Use outer shared instead of inner shared.
> > > This choice is done at early init time and uses the attr_mod facility
> > > 
> > > If the kernel is not configured for LPAE and using high PA, or if the
> > > switch to outer shared fails, then we fail to meet this criteria.
> > > Under any of these conditions we veto any dma-coherent attributes in
> > > the DTB.
> > 
> > I very much do not like this. As I previously mentioned [1],
> > dma-coherent has de-facto semantics today. This series deliberately
> > changes that, and inverts the relationship between DT and kernel (as the
> > describption in the DT would now depend on the configuration of the
> > kernel).
> > 
> > I would prefer that we have a separate property (e.g.
> > "dma-outer-coherent") to describe when a device can be coherent with
> > Normal, Outer Shareable, Inner Write-Back, Outer Write-Back memory.
> > Then the kernel can figure out whether or not device can be used
> > coherently, depending on how it is configured.
> 
> I share your concern, but I don't think the dma-outer-coherent attribute
> would be a good solution either.
> 
> The problem really is that keystone is a platform that is sometimes
> coherent, depending purely on what kernel we run, and not at all on
> anything we can describe in devicetree, and I don't see any good way
> to capture the behavior of the hardware in generic DT bindings.

I think that above doesn't quite capture the situation:

Some DMA masters can be cache-coherent (only) with Outer Shareable
transactions. That is a property we could capture inthe DT (e.g.
dma-outer-coherent), and is independent of the kernel configuration.

Whether or not the devices are coherent with the kernel's chosen memory
attributes certainly depends on the kernel configuration, but that is
not what we capture in the DT.

> So far, the assumption has been:
> 
> - when running a non-LPAE kernel, keystone is not coherent, and we
>   must ignore both the dma-coherent properties in devices and the
>   dma-ranges properties in bus nodes.

I wasn't able to spot if/where that was enforced. Is it possible to boot
Keystone UP, !LPAE?

> - when running an LPAE kernel, keystone is coherent, and we must
>   respect both of those.

Similarly this has not been enforced either way. Currently I cannot see
how devices with dma-coherent could possibly work with Keystone.

I think we also need to be clear as to what we mean by "keystone is
coherent". With LPAE, CPUs can be coherent with each other, so long as
the appropriate physical addresses are used (with the magic to handle
that).

Devices being cache-coherent with CPUs is already something we manage
per-device.

> My interpretation of Bill's description above is that we now have
> an additional requirement that at least I was not aware of before,
> regarding the outer-sharable attribute. I don't think there is
> much value in making this a boot-time option, since everyone would
> want to run this platform in a cache-coherent way if at all possible.
>
> We already have special hacks to detect the case of keystone running
> in LPAE mode, in order to do the special rewrite-all-page-tables
> hack at boot time for relocating the physical address, and we could
> use the same hack to change the page table attributes.
> 
> The question is how to communicate the requirement for outer-sharable
> for a platform. If we think it's a safe assumption that there will
> not be future 32-bit platforms with this requirement (or maybe one
> or two more at most), we could leave it in the special keystone hack.
> Alternatively, a DT property in an appropriate node could indicate
> that a particular platform requires it.

As above, I think this must be specified per-device, following the usual
manner in which we describe Inner Shareable coherency using
dma-coherent.

Thanks,
Mark.
