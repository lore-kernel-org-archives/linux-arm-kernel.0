From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 9 Jul 2018 15:10:06 -0700
Subject: [RESEND PATCH v2 3/9] asm-generic: Move some macros from
 linux/bitops.h to a new bits.h file
In-Reply-To: <20180709113250.GA26377@arm.com>
References: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
 <1529412794-17720-4-git-send-email-will.deacon@arm.com>
 <20180706173049.e28171504c745934a280dee8@linux-foundation.org>
 <20180709113250.GA26377@arm.com>
Message-ID: <20180709151006.370112d321c8f3df06bf231b@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 Jul 2018 12:32:51 +0100 Will Deacon <will.deacon@arm.com> wrote:

> Hi Andrew,
> 
> On Fri, Jul 06, 2018 at 05:30:49PM -0700, Andrew Morton wrote:
> > On Tue, 19 Jun 2018 13:53:08 +0100 Will Deacon <will.deacon@arm.com> wrote:
> > 
> > > In preparation for implementing the asm-generic atomic bitops in terms
> > > of atomic_long_*, we need to prevent asm/atomic.h implementations from
> > > pulling in linux/bitops.h. A common reason for this include is for the
> > > BITS_PER_BYTE definition, so move this and some other BIT() and masking
> > > macros into a new header file, linux/bits.h
> > > 
> > > --- a/include/linux/bitops.h
> > > +++ b/include/linux/bitops.h
> > > @@ -2,29 +2,9 @@
> > >  #ifndef _LINUX_BITOPS_H
> > >  #define _LINUX_BITOPS_H
> > >  #include <asm/types.h>
> > > +#include <linux/bits.h>
> > >  
> > > -#ifdef	__KERNEL__
> > > -#define BIT(nr)			(1UL << (nr))
> > > -#define BIT_ULL(nr)		(1ULL << (nr))
> > > -#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
> > > -#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> > > -#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
> > > -#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
> > > -#define BITS_PER_BYTE		8
> > >  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
> > > -#endif
> > 
> > Why does it leave BITS_TO_LONGS() in place?
> > 
> > That becomes unfortunate with Chris's patch, so I'm moving
> > BITS_TO_LONGS() into bits.h.
> 
> The reason I avoided that was because it would pull in the dreaded
> kernel.h for DIV_ROUND_UP, and then we're back to circular include hell :(
> 

Well we should comment that so every reader doesn't wonder what I
wondered.

Refactoring works well.  I suppose DIV_ROUND_UP and friends await a new
<arithmacros.h>.

Also, all these macros no longer `#ifdef __KERNEL__' protection, which
wasn't mentioned in the changelog.  Deliberate?
