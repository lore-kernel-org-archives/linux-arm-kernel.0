From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 25 Jul 2013 16:24:48 -0400 (EDT)
Subject: [PATCH 4/6] ARM: locks: prefetch the destination word for write
 prior to strex
In-Reply-To: <20130725174555.GK12827@mudshark.cambridge.arm.com>
References: <1374579389-32704-1-git-send-email-will.deacon@arm.com>
 <1374579389-32704-5-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1307231609170.15022@syhkavp.arg>
 <20130724111841.GD11072@mudshark.cambridge.arm.com>
 <51F160EA.6030800@codeaurora.org> <51F1626C.3050008@codeaurora.org>
 <20130725174555.GK12827@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1307251622320.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Jul 2013, Will Deacon wrote:

> On Thu, Jul 25, 2013 at 06:37:48PM +0100, Stephen Boyd wrote:
> > On 07/25/13 10:31, Stephen Boyd wrote:
> > > On 07/24/13 04:18, Will Deacon wrote:
> > >> On Tue, Jul 23, 2013 at 09:10:33PM +0100, Nicolas Pitre wrote:
> > >>> On Tue, 23 Jul 2013, Will Deacon wrote:
> > >>>
> > >>>> The cost of changing a cacheline from shared to exclusive state can be
> > >>>> significant, especially when this is triggered by an exclusive store,
> > >>>> since it may result in having to retry the transaction.
> > >>>>
> > >>>> This patch prefixes our {spin,read,write}_[try]lock implementations with
> > >>>> pldw instructions (on CPUs which support them) to try and grab the line
> > >>>> in exclusive state from the start.
> > >>>>
> > >>>> Signed-off-by: Will Deacon <will.deacon@arm.com>
> > >>>> ---
> > >>>>  arch/arm/include/asm/spinlock.h | 9 ++++++++-
> > >>>>  1 file changed, 8 insertions(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
> > >>>> index 0de7bec..3e1cc9d 100644
> > >>>> --- a/arch/arm/include/asm/spinlock.h
> > >>>> +++ b/arch/arm/include/asm/spinlock.h
> > >>>> @@ -5,7 +5,7 @@
> > >>>>  #error SMP not supported on pre-ARMv6 CPUs
> > >>>>  #endif
> > >>>>  
> > >>>> -#include <asm/processor.h>
> > >>>> +#include <linux/prefetch.h>
> > >>>>  
> > >>>>  /*
> > >>>>   * sev and wfe are ARMv6K extensions.  Uniprocessor ARMv6 may not have the K
> > >>>> @@ -70,6 +70,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
> > >>>>  	u32 newval;
> > >>>>  	arch_spinlock_t lockval;
> > >>>>  
> > >>>> +	prefetchw((const void *)&lock->slock);
> > >>> Couldn't that cast be carried in the definition of prefetchw() instead?
> > >> I think that would mean implementing prefetchw as a macro rather than an
> > >> inline function, since the core code expects to pass a const pointer and GCC
> > >> gets angry if the type signatures don't match.
> > > Maybe I'm wrong, but can't you just remove the casts and leave the
> > > function as static inline? const void * is pretty much telling the
> > > compiler to turn off type checking.
> > >
> > 
> > Oh joy. Why is rwlock's lock member marked volatile?
> 
> Yeah, that was the problematic guy. However, I had to fix that anyway in
> this patch because otherwise the definition for prefetchw when
> !ARCH_HAS_PREFETCHW (which expands to __builtin_prefetch(x,1)) will explode.

Why not always keep ARCH_HAS_PREFETCHW defined then, and have 
__builtin_prefetch([const volatile void *)x,1)) when we can't do better?

Or why not adding this cast to the generic definition?


Nicolas
