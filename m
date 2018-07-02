From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 02 Jul 2018 15:49:26 +0200
Subject: Clarifying dma_wmb behavior in presence of non-coherent masters
 and outer caches
In-Reply-To: <20180629174321.GA20909@arm.com>
References: <1530275290.22468.69.camel@pengutronix.de>
 <20180629142539.GH17271@n2100.armlinux.org.uk>
 <20180629162248.GB20010@arm.com>
 <20180629164801.GJ17271@n2100.armlinux.org.uk>
 <20180629174321.GA20909@arm.com>
Message-ID: <1530539366.22468.89.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Am Freitag, den 29.06.2018, 18:43 +0100 schrieb Will Deacon:
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
Sorry for not citing from the ARM ARM, but [1] seems to partly
contradict what you said above. Especially the table detailing the
shareability domains and the related picture seem to clash with the
above statement that most systems just have an outer-shareable domain
covering the whole system.

Also the section "External caches", "Before AMBA4 ACE" seems to suggest
that the barriers aren't fully propagated to the PL310 write-caches and
master ports. I'm unsure if this is just an artifact of the mentioned
MMIO access, so handling of normal vs. device memory transactions in
the PL310.

Regards,
Lucas

[1] https://community.arm.com/processors/b/blog/posts/memory-access-ordering-part-3---memory-access-ordering-in-the-arm-architecture
