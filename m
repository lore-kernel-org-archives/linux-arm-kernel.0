From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Jun 2016 13:32:48 +0100
Subject: [RFC v2 4/4] ARM: keystone: dma-coherent with safe fallback
In-Reply-To: <20160607100142.GA2633@leverpostej>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
 <1465183229-24147-5-git-send-email-wmills@ti.com>
 <20160606085627.GA6831@leverpostej>
 <20160606114321.GJ1041@n2100.armlinux.org.uk>
 <20160606115918.GG6831@leverpostej>
 <20160606123210.GL1041@n2100.armlinux.org.uk>
 <20160607100142.GA2633@leverpostej>
Message-ID: <20160607123248.GO1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 11:01:43AM +0100, Mark Rutland wrote:
> So, if we codify the dma-coherent semantics as only matching the working
> case today, then it becomes consistent and independent of kernel
> configuration, and we can add properties to cater for the other cases,
> independent of kernel configuration.

That's where our points of view differ.  You claim that it becomes
independent of the kernel configuration.  I'm saying that's total
rubbish, because it's dependent on the kernel setting the CPU page
tables up as it does today.

If we set them up differently, then it doesn't work so well.  This
is evidenced by Marvell Armada uniprocessor platforms, where they
are DMA coherent provided that the S bit is set.  However, because
they are uniprocessor platforms, the kernel sets the page tables up
with the S bit clear.  That means that the kernel configures the
system in a way which results in it being non-coherent.

So here, we have an example of why your position is actually incorrect.
dma-coherent does *not* give a "consistent and independent of kernel
configuration" property - it's inherently tied to how the kernel has
setup the page tables.

So, dma-coherent is coherent _provided_ the kernel sets the page tables
up as we currently expect it to - the S bit set on non-LPAE systems, on
LPAE systems, inner-sharable.  If we deviate from that, (eg by clearing
the S bit on non-LPAE systems) we end up with a non-coherent system,
even if dma-coherent is specified.

The Keystone II case is no different - Keystone II is coherent if the
correct conditions are met with the CPU page tables.  The only difference
is that it's a slightly different set of conditions.

> > For example, if you clear the shared bit in the page tables on non-LPAE
> > SoCs, devices are no longer coherent.
> 
> Yes. This is a problem, but one that we already face. If we clarified
> the semantics as above, we would know that the device is simply not
> coherent.

How?  We would need to introduce some flag which is passed from the
architecture code into the OF code to disable the effect of dma-coherent,
making of_dma_is_coherent() return false if the S bit is clear.

> > Whether devices are DMA coherent is a combination of two things:
> >  * is the device connected to a coherent bus.
> >  * is the system setup to allow coherency on that bus to work.
> > 
> > We capture the first through the dma-coherent property, which is clearly
> > a per-device property.  We ignore the second because we assume everyone
> > is going to configure the CPU side correctly.  That's untrue today, and
> > it's untrue not only because of Keystone II, but also because of other
> > SoCs as well which pre-date Keystone II.  We currently miss out on
> > considering that, because if we ignore it, we get something that works
> > for most platforms.
> > 
> > I don't see that adding a dma-outer-coherent property helps this - it's
> > muddying the waters somewhat - and it's also forcing additional complexity
> > into places where we shouldn't have it.  We would need to parse two
> > properties in the DMA API code, and then combine it with knowledge as
> > to how the system page tables have been setup.  If they've been setup
> > as inner sharable, then dma-coherent identifies whether the device is
> > coherent.  If they've been setup as outer sharable, then
> > dma-outer-coherent specifies that and dma-coherent is meaningless.
> 
> I think that at minimum, the attributes devices require needs to be
> describe to the kernel, rather than being something we hope just
> happened to match.

Yuck.  Seriously?  What happens when we have two devices which have
different required attributes for the CPU mapping?  Should architecture
code have to parse the entire DT tree to work out what attributes each
device needs, and try to then work out how the CPU page tables should
be setup?

I really don't think that's a good idea.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
