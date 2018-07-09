From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 Jul 2018 12:32:51 +0100
Subject: [RESEND PATCH v2 3/9] asm-generic: Move some macros from
 linux/bitops.h to a new bits.h file
In-Reply-To: <20180706173049.e28171504c745934a280dee8@linux-foundation.org>
References: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
 <1529412794-17720-4-git-send-email-will.deacon@arm.com>
 <20180706173049.e28171504c745934a280dee8@linux-foundation.org>
Message-ID: <20180709113250.GA26377@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Fri, Jul 06, 2018 at 05:30:49PM -0700, Andrew Morton wrote:
> On Tue, 19 Jun 2018 13:53:08 +0100 Will Deacon <will.deacon@arm.com> wrote:
> 
> > In preparation for implementing the asm-generic atomic bitops in terms
> > of atomic_long_*, we need to prevent asm/atomic.h implementations from
> > pulling in linux/bitops.h. A common reason for this include is for the
> > BITS_PER_BYTE definition, so move this and some other BIT() and masking
> > macros into a new header file, linux/bits.h
> > 
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -2,29 +2,9 @@
> >  #ifndef _LINUX_BITOPS_H
> >  #define _LINUX_BITOPS_H
> >  #include <asm/types.h>
> > +#include <linux/bits.h>
> >  
> > -#ifdef	__KERNEL__
> > -#define BIT(nr)			(1UL << (nr))
> > -#define BIT_ULL(nr)		(1ULL << (nr))
> > -#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
> > -#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> > -#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
> > -#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
> > -#define BITS_PER_BYTE		8
> >  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
> > -#endif
> 
> Why does it leave BITS_TO_LONGS() in place?
> 
> That becomes unfortunate with Chris's patch, so I'm moving
> BITS_TO_LONGS() into bits.h.

The reason I avoided that was because it would pull in the dreaded
kernel.h for DIV_ROUND_UP, and then we're back to circular include hell :(

Will


> From: Chris Wilson <chris@chris-wilson.co.uk>
> Subject: include/linux/bitops.h: introduce BITS_PER_TYPE
> 
> net_dim.h has a rather useful extension to BITS_PER_BYTE to compute the
> number of bits in a type (BITS_PER_BYTE * sizeof(T)), so promote the macro
> to bitops.h, alongside BITS_PER_BYTE, for wider usage.
> 
> Link: http://lkml.kernel.org/r/20180706094458.14116-1-chris at chris-wilson.co.uk
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andy Gospodarek <gospo@broadcom.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  include/linux/bitops.h  |    3 ++-
>  include/linux/net_dim.h |    1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN include/linux/bitops.h~bitops-introduce-bits_per_type include/linux/bitops.h
> --- a/include/linux/bitops.h~bitops-introduce-bits_per_type
> +++ a/include/linux/bitops.h
> @@ -11,7 +11,8 @@
>  #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
>  #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
>  #define BITS_PER_BYTE		8
> -#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
> +#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
> +#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
>  #endif
>  
>  /*
> diff -puN include/linux/net_dim.h~bitops-introduce-bits_per_type include/linux/net_dim.h
> --- a/include/linux/net_dim.h~bitops-introduce-bits_per_type
> +++ a/include/linux/net_dim.h
> @@ -363,7 +363,6 @@ static inline void net_dim_sample(u16 ev
>  }
>  
>  #define NET_DIM_NEVENTS 64
> -#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
>  #define BIT_GAP(bits, end, start) ((((end) - (start)) + BIT_ULL(bits)) & (BIT_ULL(bits) - 1))
>  
>  static inline void net_dim_calc_stats(struct net_dim_sample *start,
> _
> 
