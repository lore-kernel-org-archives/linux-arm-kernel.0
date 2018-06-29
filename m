From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Jun 2018 18:46:23 +0100
Subject: Clarifying dma_wmb behavior in presence of non-coherent masters
 and outer caches
In-Reply-To: <1530292490.22468.76.camel@pengutronix.de>
References: <1530275290.22468.69.camel@pengutronix.de>
 <20180629142539.GH17271@n2100.armlinux.org.uk>
 <20180629162248.GB20010@arm.com>
 <1530292490.22468.76.camel@pengutronix.de>
Message-ID: <20180629174622.GB20909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 07:14:50PM +0200, Lucas Stach wrote:
> Am Freitag, den 29.06.2018, 17:22 +0100 schrieb Will Deacon:
> > You're right that cacheability and shareability are different things. For
> > the purposes of ordering and coherence, we care about shareability. Normal
> > non-cacheable is outer-shareable (which is a superset of inner-shareable),
> > so DMB OSH is sufficient to order accesses to that buffer from the
> > perspective of all observers.
> 
> Can you point me to something where this mapping from normal, non-
> cacheable to outer-sharable is defined? Why is there a distinction
> between OSH and SY in the barriers, if all non-coherent masters are in
> the outer sharable domain?
> 
> /me is still confused

Hopefully my reply to Russell will help you here. The distinction between
OSH and SY is for handling masters that are not coherent at all, even when
using non-cacheable mappings. But as I mentioned to Russell, I think this
is largely theoretical and nobody builds systems like this.

> >  Since we use Normal non-cacheable mappings
> > for non-coherent DMA buffers (and there is no such thing as a
> > system-shareable memory type), then these barriers are sufficient to provide
> > ordering in this case too.
> > 
> > Ideally, we'd limit the DMA barriers to the inner-shareable domain when
> > dealing with coherent devices, but there's no way to determine that from
> > the barrier macros.
> > 
> > Lucas -- did changing the shareability of the DMA barriers actually solve
> > your problem?
> 
> There isn't enough data at this point to conclusively answer this. But
> reading the code, this struck me as being odd enough to warrant some
> clarifications from experts.

Have you checked that you have bit 22 set in the PL310 aux ctrl register?

Will
