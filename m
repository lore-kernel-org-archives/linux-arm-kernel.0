From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Jun 2018 18:43:22 +0100
Subject: Clarifying dma_wmb behavior in presence of non-coherent masters
 and outer caches
In-Reply-To: <20180629164801.GJ17271@n2100.armlinux.org.uk>
References: <1530275290.22468.69.camel@pengutronix.de>
 <20180629142539.GH17271@n2100.armlinux.org.uk>
 <20180629162248.GB20010@arm.com>
 <20180629164801.GJ17271@n2100.armlinux.org.uk>
Message-ID: <20180629174321.GA20909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jun 29, 2018 at 05:48:01PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 29, 2018 at 05:22:48PM +0100, Will Deacon wrote:
> > On Fri, Jun 29, 2018 at 03:25:39PM +0100, Russell King - ARM Linux wrote:
> > > Maybe Will can shed some light on this topic.
> > 
> > You're right that cacheability and shareability are different things. For
> > the purposes of ordering and coherence, we care about shareability. Normal
> > non-cacheable is outer-shareable (which is a superset of inner-shareable),
> 
> What does it mean when the "implementation" doesn't define two shareable
> domains - does it mean that inner and outer shareable are combined into
> just one "shareable" domain, or is outer shareable always treated as
> "everything but inner shareable"?

If there is only one shareability domain, then the inner and outer shareable
domains refer to that domain (i.e. they're the same).

> From the paragraph I quoted from the ARM ARM, it seems that the former
> applies, which should also mean that "dmb ish*" and "dmb osh*" are
> functionally equivalent, and only touch the inner shareable domain.

In this case, yes. In practice, there is usually one inner-shareable domain
which contains the CPUs and coherent DMA devices, and there is one
outer-shareable domain containing that inner-shareable domain, where
non-coherent DMA lives only in the outer-shareable domain. I don't know
of any systems where that isn't the case, and I'm not sure that our
interconnects even permit building anything else (I'd need to check).

> You also seem to be saying that PRRR.NOSn is ignored for any mapping
> that indicates non-cacheable normal memory - I've not found that stated
> in the ARM ARM.  It does say that NOSn doesn't apply if the region is
> mapped as strongly-ordered, but that isn't the case for our DMA
> coherent mappings.

Ah, it looks like it's not the case for short-descriptor without TEX remap,
where the S bit determines the shareability (i.e. shared or non-shared).
However, in Armv8 or short-descriptor using TEX remapping then non-cacheable
mappings are outer-shareable:

G4.7.3	Short-descriptor format memory region attributes, with TEX remap

If the TEX[0], C and B bits determine that the region is a Device memory
type, or is Normal Inner Non-cacheable, Outer Non-cacheable, then the
region is Outer Shareable.

Will
