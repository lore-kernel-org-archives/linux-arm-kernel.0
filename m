From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 2 Feb 2015 20:31:54 +0100
Subject: [RFC] change non-atomic bitops method
In-Reply-To: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
Message-ID: <20150202193154.GC10842@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 11:55:03AM +0800, Wang, Yalin wrote:
> This patch change non-atomic bitops,
> add a if() condition to test it, before set/clear the bit.
> so that we don't need dirty the cache line, if this bit
> have been set or clear. On SMP system, dirty cache line will
> need invalidate other processors cache line, this will have
> some impact on SMP systems.
> 
> Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
> ---
>  include/asm-generic/bitops/non-atomic.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
> index 697cc2b..e4ef18a 100644
> --- a/include/asm-generic/bitops/non-atomic.h
> +++ b/include/asm-generic/bitops/non-atomic.h
> @@ -17,7 +17,9 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
>  
> -	*p  |= mask;
> +	if ((*p & mask) == 0)
> +		*p  |= mask;
Care to fix the double space here while touching the code?

I think the more natural check here is:

	if ((~*p & mask) != 0)
		*p |= mask;

Might be a matter of taste, but this check is equivalent to

	*p != (*p | mask)

which is what you really want to test for. (Your check only has this
property for values of mask that have a single bit set, which is ok here
of course.)

> +
>  }
>  
>  static inline void __clear_bit(int nr, volatile unsigned long *addr)
> @@ -25,7 +27,8 @@ static inline void __clear_bit(int nr, volatile unsigned long *addr)
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
>  
> -	*p &= ~mask;
> +	if ((*p & mask) != 0)
> +		*p &= ~mask;
This is already fine.

>  }
>  
>  /**
> @@ -60,7 +63,8 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
>  	unsigned long old = *p;
>  
> -	*p = old | mask;
> +	if ((old & mask) == 0)
> +		*p = old | mask;
Here it would be:

	if ((~old & mask) != 0)
	
>  	return (old & mask) != 0;
>  }

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
