From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jun 2018 19:01:04 +0100
Subject: Clarifying dma_wmb behavior in presence of non-coherent masters
 and outer caches
In-Reply-To: <20180629174321.GA20909@arm.com>
References: <1530275290.22468.69.camel@pengutronix.de>
 <20180629142539.GH17271@n2100.armlinux.org.uk>
 <20180629162248.GB20010@arm.com>
 <20180629164801.GJ17271@n2100.armlinux.org.uk>
 <20180629174321.GA20909@arm.com>
Message-ID: <20180629180104.GK17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 06:43:22PM +0100, Will Deacon wrote:
> Hi Russell,
> 
> On Fri, Jun 29, 2018 at 05:48:01PM +0100, Russell King - ARM Linux wrote:
> > On Fri, Jun 29, 2018 at 05:22:48PM +0100, Will Deacon wrote:
> > > On Fri, Jun 29, 2018 at 03:25:39PM +0100, Russell King - ARM Linux wrote:
> > > > Maybe Will can shed some light on this topic.
> > > 
> > > You're right that cacheability and shareability are different things. For
> > > the purposes of ordering and coherence, we care about shareability. Normal
> > > non-cacheable is outer-shareable (which is a superset of inner-shareable),
> > 
> > What does it mean when the "implementation" doesn't define two shareable
> > domains - does it mean that inner and outer shareable are combined into
> > just one "shareable" domain, or is outer shareable always treated as
> > "everything but inner shareable"?
> 
> If there is only one shareability domain, then the inner and outer shareable
> domains refer to that domain (i.e. they're the same).
> 
> > From the paragraph I quoted from the ARM ARM, it seems that the former
> > applies, which should also mean that "dmb ish*" and "dmb osh*" are
> > functionally equivalent, and only touch the inner shareable domain.
> 
> In this case, yes. In practice, there is usually one inner-shareable domain
> which contains the CPUs and coherent DMA devices, and there is one
> outer-shareable domain containing that inner-shareable domain, where
> non-coherent DMA lives only in the outer-shareable domain. I don't know
> of any systems where that isn't the case, and I'm not sure that our
> interconnects even permit building anything else (I'd need to check).
> 
> > You also seem to be saying that PRRR.NOSn is ignored for any mapping
> > that indicates non-cacheable normal memory - I've not found that stated
> > in the ARM ARM.  It does say that NOSn doesn't apply if the region is
> > mapped as strongly-ordered, but that isn't the case for our DMA
> > coherent mappings.
> 
> Ah, it looks like it's not the case for short-descriptor without TEX remap,
> where the S bit determines the shareability (i.e. shared or non-shared).
> However, in Armv8 or short-descriptor using TEX remapping then non-cacheable
> mappings are outer-shareable:
> 
> G4.7.3	Short-descriptor format memory region attributes, with TEX remap
> 
> If the TEX[0], C and B bits determine that the region is a Device memory
> type, or is Normal Inner Non-cacheable, Outer Non-cacheable, then the
> region is Outer Shareable.

I think this is a danger of using the "latest" ARM ARM - the fact this
comes from Appendix G tells me that you're quoting from the ARMv8 ARM
ARM, and it's probably the differences to ARMv7 appendix.

The ARMv7 ARM ARMs do not state this - in DDI0406C, the section you
refer to is:

B3.8.3   Short-descriptor format memory region attributes, with TEX remap

which makes no mention of this.  There is an explicit section on the NOS
bits:

"Interpretation of the NOSn fields in the PRRR, with TEX remap

When all of the following apply, the NOSn fields in the PRRR distinguish
between Inner Shareable and Outer Shareable memory regions:

?     the SCTLR.TRE bit is set to 1
?     the region is mapped as Normal memory, or the implementation does
      not include the Large Physical Address Extension and the region is
      mapped as Device memory
?     the Normal memory remapping or Device memory remapping of the S bit
      value for the entry makes the region Shareable
?     the implementation supports the distinction between Inner Shareable
      and Outer Shareable.

...
The values of the NOSn fields in the PRRR have no effect if any of the
following apply:

?     the SCTLR.TRE bit is set to 0 and the IMPLEMENTATION DEFINED
      mechanism has not been invoked
?     the region is mapped as Strongly-ordered memory
?     the implementation includes the Large Physical Address Extension,
      and the region is mapped as Device memory
?     the Normal memory remapping or Device memory remapping of the S bit
      value for the entry makes the region Non-shareable.

The NOSn fields in the PRRR are RAZ/WI if the implementation does not
support the distinction between Inner Shareable and Outer Shareable
memory regions."

This seems to be pretty explicit, and in disagreement with what you
quote from G4.7.3.

I'm more likely to believe the ARM ARM produced for the ARMv7 architecture
rather than a later version, since that's the document that would've been
used at the time for such implementations.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
