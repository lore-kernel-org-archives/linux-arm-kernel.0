From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Jun 2016 11:01:43 +0100
Subject: [RFC v2 4/4] ARM: keystone: dma-coherent with safe fallback
In-Reply-To: <20160606123210.GL1041@n2100.armlinux.org.uk>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
 <1465183229-24147-5-git-send-email-wmills@ti.com>
 <20160606085627.GA6831@leverpostej>
 <20160606114321.GJ1041@n2100.armlinux.org.uk>
 <20160606115918.GG6831@leverpostej>
 <20160606123210.GL1041@n2100.armlinux.org.uk>
Message-ID: <20160607100142.GA2633@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 01:32:10PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 06, 2016 at 12:59:18PM +0100, Mark Rutland wrote:
> > I agree that whether or not devices are coherent in practice depends on
> > the kernel's configuration. The flip side, as you point out, is that
> > devices are coherent when a specific set of attributes are used.
> > 
> > i.e. that if you read dma-coherent as meaning "coherent iff Normal,
> > Inner Shareable, Inner WB Cacheable, Outer WB Cacheable", then
> > dma-coherent consistently describes the same thing, rather than
> > depending on the configuration of the OS.
> > 
> > DT is a datastructure provided to the kernel, potentially without deep
> > internal knowledge of that kernel configuration. Having a consistent
> > rule that is independent of the kernel configuration seems worth aiming
> > for.
> 
> I think you've missed the point.  dma-coherent is _already_ dependent on
> the kernel configuration. 

I understood this point. Please, allow me to clarify below, as I've
evidently not done a good job so far.

> "Having a consistent rule that is independent of the kernel
> configuration" is already an impossibility, as I illustrated in my
> previous message concerning Marvell Armada SoCs, and you also said in
> your preceding paragraph!

That's not quite what I said. What I said was that whether or not you
end up with coherency depends on the kernel's configuration. That's why
I pointed out that in practice, the only cases that work with today's
mainline kernels are this for which the devices which are coherent with
the kernel's usual memory attributes in an SMP configuration.

If you grep for dma-coherent in arch/arm/boot/dts, you'll find that
appears in:

arch/arm/boot/dts/artpec6.dtsi
arch/arm/boot/dts/ecx-common.dtsi
arch/arm/boot/dts/ls1021a.dtsi

Which are all SMP Cortex-{A7,A9,A15} platforms, and:

arch/arm/boot/dts/k2e.dtsi
arch/arm/boot/dts/k2e-netcp.dtsi
arch/arm/boot/dts/k2hk-netcp.dtsi
arch/arm/boot/dts/k2l-netcp.dtsi
arch/arm/boot/dts/keystone.dtsi

For which, as far as I am aware, the dma-coherent property does not
yield coherency with a mainline kernel, due to the requirement of Outer
Shareable attributes.

So, if we codify the dma-coherent semantics as only matching the working
case today, then it becomes consistent and independent of kernel
configuration, and we can add properties to cater for the other cases,
independent of kernel configuration.

> For example, if you clear the shared bit in the page tables on non-LPAE
> SoCs, devices are no longer coherent.

Yes. This is a problem, but one that we already face. If we clarified
the semantics as above, we would know that the device is simply not
coherent.

> DMA coherence on ARM _is_ already tightly linked with the kernel
> configuration.  You already can't get away from that, so I think you
> should give up trying to argue that point. :)

I hope that I've clarified my position w.r.t. coherence vs specification
thereof. :)

> Whether devices are DMA coherent is a combination of two things:
>  * is the device connected to a coherent bus.
>  * is the system setup to allow coherency on that bus to work.
> 
> We capture the first through the dma-coherent property, which is clearly
> a per-device property.  We ignore the second because we assume everyone
> is going to configure the CPU side correctly.  That's untrue today, and
> it's untrue not only because of Keystone II, but also because of other
> SoCs as well which pre-date Keystone II.  We currently miss out on
> considering that, because if we ignore it, we get something that works
> for most platforms.
> 
> I don't see that adding a dma-outer-coherent property helps this - it's
> muddying the waters somewhat - and it's also forcing additional complexity
> into places where we shouldn't have it.  We would need to parse two
> properties in the DMA API code, and then combine it with knowledge as
> to how the system page tables have been setup.  If they've been setup
> as inner sharable, then dma-coherent identifies whether the device is
> coherent.  If they've been setup as outer sharable, then
> dma-outer-coherent specifies that and dma-coherent is meaningless.

I think that at minimum, the attributes devices require needs to be
describe to the kernel, rather than being something we hope just
happened to match.

> Sounds like a recipe for confusion.

Unfortunately, I think everything in this area leads to confusion. :(

Thanks,
Mark.
