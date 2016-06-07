From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Jun 2016 13:55:05 +0100
Subject: [RFC v2 4/4] ARM: keystone: dma-coherent with safe fallback
In-Reply-To: <20160607123248.GO1041@n2100.armlinux.org.uk>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
 <1465183229-24147-5-git-send-email-wmills@ti.com>
 <20160606085627.GA6831@leverpostej>
 <20160606114321.GJ1041@n2100.armlinux.org.uk>
 <20160606115918.GG6831@leverpostej>
 <20160606123210.GL1041@n2100.armlinux.org.uk>
 <20160607100142.GA2633@leverpostej>
 <20160607123248.GO1041@n2100.armlinux.org.uk>
Message-ID: <20160607125505.GE2633@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 01:32:48PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 07, 2016 at 11:01:43AM +0100, Mark Rutland wrote:
> > So, if we codify the dma-coherent semantics as only matching the working
> > case today, then it becomes consistent and independent of kernel
> > configuration, and we can add properties to cater for the other cases,
> > independent of kernel configuration.
> 
> That's where our points of view differ.  You claim that it becomes
> independent of the kernel configuration.  I'm saying that's total
> rubbish, because it's dependent on the kernel setting the CPU page
> tables up as it does today.

The key point is that *description* of the requirements for coherency
becomes independent of kernel configuration. Yes, whether or not a
kernel can support those depends on the configuration.

> If we set them up differently, then it doesn't work so well.  This
> is evidenced by Marvell Armada uniprocessor platforms, where they
> are DMA coherent provided that the S bit is set.  However, because
> they are uniprocessor platforms, the kernel sets the page tables up
> with the S bit clear.  That means that the kernel configures the
> system in a way which results in it being non-coherent.
> 
> So here, we have an example of why your position is actually incorrect.
> dma-coherent does *not* give a "consistent and independent of kernel
> configuration" property - it's inherently tied to how the kernel has
> setup the page tables.

Sorry, but that is not quite what I said.

I said that if you read dma-coherent as specifying *the requirements*
for coherency (i.e. "coherent iff Normal, Inner Shareable, Inner WB
Cacheable, Outer WB Cacheable"), rather than specifying that there is
coherency given some unspecified requirements, then it is possible to
use it in a manner which is consistent and independent of kernel
configuration. If the kernel uses memory attributes that don't meet
those requirements, it can know that the device cannot be used in a
coherent manner.

If we take that stance, then we can cater for other requirements (e.g.
Outer Shareable on Keystone) by having properties to specify those
requirements (e.g. dma-outer-coherent). The tricky part is how the
kernel decides how best to use that information, but that is a problem
regardless.

> > > For example, if you clear the shared bit in the page tables on non-LPAE
> > > SoCs, devices are no longer coherent.
> > 
> > Yes. This is a problem, but one that we already face. If we clarified
> > the semantics as above, we would know that the device is simply not
> > coherent.
> 
> How?  We would need to introduce some flag which is passed from the
> architecture code into the OF code to disable the effect of dma-coherent,
> making of_dma_is_coherent() return false if the S bit is clear.

Yes, we would need to either alter the OF code, or some code which makes
use of this. Surely it's possible to have this logic in an arch
callback?

> > > Whether devices are DMA coherent is a combination of two things:
> > >  * is the device connected to a coherent bus.
> > >  * is the system setup to allow coherency on that bus to work.
> > > 
> > > We capture the first through the dma-coherent property, which is clearly
> > > a per-device property.  We ignore the second because we assume everyone
> > > is going to configure the CPU side correctly.  That's untrue today, and
> > > it's untrue not only because of Keystone II, but also because of other
> > > SoCs as well which pre-date Keystone II.  We currently miss out on
> > > considering that, because if we ignore it, we get something that works
> > > for most platforms.
> > > 
> > > I don't see that adding a dma-outer-coherent property helps this - it's
> > > muddying the waters somewhat - and it's also forcing additional complexity
> > > into places where we shouldn't have it.  We would need to parse two
> > > properties in the DMA API code, and then combine it with knowledge as
> > > to how the system page tables have been setup.  If they've been setup
> > > as inner sharable, then dma-coherent identifies whether the device is
> > > coherent.  If they've been setup as outer sharable, then
> > > dma-outer-coherent specifies that and dma-coherent is meaningless.
> > 
> > I think that at minimum, the attributes devices require needs to be
> > describe to the kernel, rather than being something we hope just
> > happened to match.
> 
> Yuck.  Seriously?  What happens when we have two devices which have
> different required attributes for the CPU mapping?  Should architecture
> code have to parse the entire DT tree to work out what attributes each
> device needs, and try to then work out how the CPU page tables should
> be setup?

No, we do not necessarily have to try to dynamically handle every
possible case, especially as the vastly common case is the one I called
out above.

For those boards where we're going to have some code special-casing
those regardless, automatically deciding to have the kernel use the
preferred set of attributes is fine. However, to do this I don't think
we should provide board+kernel specific semantics to dma-coherent, and
should at least precisely specify the coherency requirements.

Thanks,
Mark.
