From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Jul 2013 12:18:41 +0100
Subject: [PATCH 4/6] ARM: locks: prefetch the destination word for write
 prior to strex
In-Reply-To: <alpine.LFD.2.03.1307231609170.15022@syhkavp.arg>
References: <1374579389-32704-1-git-send-email-will.deacon@arm.com>
 <1374579389-32704-5-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1307231609170.15022@syhkavp.arg>
Message-ID: <20130724111841.GD11072@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 09:10:33PM +0100, Nicolas Pitre wrote:
> On Tue, 23 Jul 2013, Will Deacon wrote:
> 
> > The cost of changing a cacheline from shared to exclusive state can be
> > significant, especially when this is triggered by an exclusive store,
> > since it may result in having to retry the transaction.
> > 
> > This patch prefixes our {spin,read,write}_[try]lock implementations with
> > pldw instructions (on CPUs which support them) to try and grab the line
> > in exclusive state from the start.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/include/asm/spinlock.h | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
> > index 0de7bec..3e1cc9d 100644
> > --- a/arch/arm/include/asm/spinlock.h
> > +++ b/arch/arm/include/asm/spinlock.h
> > @@ -5,7 +5,7 @@
> >  #error SMP not supported on pre-ARMv6 CPUs
> >  #endif
> >  
> > -#include <asm/processor.h>
> > +#include <linux/prefetch.h>
> >  
> >  /*
> >   * sev and wfe are ARMv6K extensions.  Uniprocessor ARMv6 may not have the K
> > @@ -70,6 +70,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
> >  	u32 newval;
> >  	arch_spinlock_t lockval;
> >  
> > +	prefetchw((const void *)&lock->slock);
> 
> Couldn't that cast be carried in the definition of prefetchw() instead?

I think that would mean implementing prefetchw as a macro rather than an
inline function, since the core code expects to pass a const pointer and GCC
gets angry if the type signatures don't match.

I'll have a go at doing that for v2.

Cheers,

Will
