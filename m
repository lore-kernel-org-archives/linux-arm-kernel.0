From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jun 2016 13:32:10 +0100
Subject: [RFC v2 4/4] ARM: keystone: dma-coherent with safe fallback
In-Reply-To: <20160606115918.GG6831@leverpostej>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
 <1465183229-24147-5-git-send-email-wmills@ti.com>
 <20160606085627.GA6831@leverpostej>
 <20160606114321.GJ1041@n2100.armlinux.org.uk>
 <20160606115918.GG6831@leverpostej>
Message-ID: <20160606123210.GL1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 12:59:18PM +0100, Mark Rutland wrote:
> I agree that whether or not devices are coherent in practice depends on
> the kernel's configuration. The flip side, as you point out, is that
> devices are coherent when a specific set of attributes are used.
> 
> i.e. that if you read dma-coherent as meaning "coherent iff Normal,
> Inner Shareable, Inner WB Cacheable, Outer WB Cacheable", then
> dma-coherent consistently describes the same thing, rather than
> depending on the configuration of the OS.
> 
> DT is a datastructure provided to the kernel, potentially without deep
> internal knowledge of that kernel configuration. Having a consistent
> rule that is independent of the kernel configuration seems worth aiming
> for.

I think you've missed the point.  dma-coherent is _already_ dependent on
the kernel configuration.  "Having a consistent rule that is independent
of the kernel configuration" is already an impossibility, as I illustrated
in my previous message concerning Marvell Armada SoCs, and you also said
in your preceding paragraph!

For example, if you clear the shared bit in the page tables on non-LPAE
SoCs, devices are no longer coherent.

DMA coherence on ARM _is_ already tightly linked with the kernel
configuration.  You already can't get away from that, so I think you
should give up trying to argue that point. :)

Whether devices are DMA coherent is a combination of two things:
 * is the device connected to a coherent bus.
 * is the system setup to allow coherency on that bus to work.

We capture the first through the dma-coherent property, which is clearly
a per-device property.  We ignore the second because we assume everyone
is going to configure the CPU side correctly.  That's untrue today, and
it's untrue not only because of Keystone II, but also because of other
SoCs as well which pre-date Keystone II.  We currently miss out on
considering that, because if we ignore it, we get something that works
for most platforms.

I don't see that adding a dma-outer-coherent property helps this - it's
muddying the waters somewhat - and it's also forcing additional complexity
into places where we shouldn't have it.  We would need to parse two
properties in the DMA API code, and then combine it with knowledge as
to how the system page tables have been setup.  If they've been setup
as inner sharable, then dma-coherent identifies whether the device is
coherent.  If they've been setup as outer sharable, then
dma-outer-coherent specifies that and dma-coherent is meaningless.

Sounds like a recipe for confusion.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
