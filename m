From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Aug 2013 10:20:33 +0100
Subject: [PATCH v3 1/3] ARM: Introduce atomic MMIO modify
In-Reply-To: <20130830091534.GA62188@MacBook-Pro.local>
References: <1377253445-2842-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377253445-2842-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130823103802.GO4600@tarshish> <20130823110748.GD2389@localhost>
 <20130823113225.GF2389@localhost> <20130823114805.GF10971@arm.com>
 <20130830090807.GB25628@mudshark.cambridge.arm.com>
 <20130830091534.GA62188@MacBook-Pro.local>
Message-ID: <20130830092032.GD25628@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 10:15:36AM +0100, Catalin Marinas wrote:
> On Fri, Aug 30, 2013 at 10:08:07AM +0100, Will Deacon wrote:
> > On Fri, Aug 23, 2013 at 12:48:05PM +0100, Catalin Marinas wrote:
> > > On Fri, Aug 23, 2013 at 12:32:26PM +0100, Ezequiel Garcia wrote:
> > > > ... or maybe yes. I'm not seeing {readl,writel}_relaxed as guaranteed
> > > > to exist in every architecture. So, indeed, this seems to be ARM-dependent.
> > > 
> > > There was a discussion couple of years ago to make these part of the IO
> > > specification since many architectures define them:
> > > 
> > > http://thread.gmane.org/gmane.linux.ports.arm.kernel/117626
> > > 
> > > (and some older threads on linux-arch which I haven't searched)
> > > 
> > > We could have some default implementation pointing to readl/writel while
> > > letting the arch code to define more optimised variants.
> > 
> > The main thing I dislike about that is the back-to-back dsbs that you will
> > get from the read-(modify)-write. It really makes the non-optimised version
> > needlessly expensive.
> 
> Yes, it's pretty bad. But we don't have relaxed (write) accessors on
> other architectures and I'm not sure about their semantics either. I
> guess here it's a data dependency so you cannot write the value before
> reading it, especially since sane architectures should speculate reads
> or writes to device memory.
> 
> What about making it always use *_relaxed() accessors if the
> architecture provides them? No need for atomic_io_modify_relaxed().

The only potential problem there is if somebody uses this function to kick
off a DMA. That would require explicit barriers to enforce ordering against
population of normal, cacheable buffers, which isn't usually the case in
driver code (since we have the dsb/outer_sync in the accessor).

Perhaps we should just bit the bullet and define relaxed accessors for all
architectures? It's not difficult to default them to the non-relaxed
variants if the architecture doesn't provide an optimised implementation.

Will
