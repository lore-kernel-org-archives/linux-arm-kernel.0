From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 2 Feb 2015 15:29:09 -0800
Subject: [RFC] change non-atomic bitops method
In-Reply-To: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
Message-ID: <20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Feb 2015 11:55:03 +0800 "Wang, Yalin" <Yalin.Wang@sonymobile.com> wrote:

> This patch change non-atomic bitops,
> add a if() condition to test it, before set/clear the bit.
> so that we don't need dirty the cache line, if this bit
> have been set or clear. On SMP system, dirty cache line will
> need invalidate other processors cache line, this will have
> some impact on SMP systems.
> 
> --- a/include/asm-generic/bitops/non-atomic.h
> +++ b/include/asm-generic/bitops/non-atomic.h
> @@ -17,7 +17,9 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
>  	unsigned long mask = BIT_MASK(nr);
>  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
>  
> -	*p  |= mask;
> +	if ((*p & mask) == 0)
> +		*p  |= mask;
> +
>  }

hm, maybe.

It will speed up set_bit on an already-set bit.  But it will slow down
set_bit on a not-set bit.  And the latter case is presumably much, much
more common.

How do we know the patch is a net performance gain?
