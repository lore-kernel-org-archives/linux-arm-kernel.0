From: mathieu.desnoyers@polymtl.ca (Mathieu Desnoyers)
Date: Fri, 6 Aug 2010 13:00:21 -0400
Subject: [PATCH] arm: add half-word __xchg
In-Reply-To: <1281034718-14499-1-git-send-email-virtuoso@slind.org>
References: <1281034718-14499-1-git-send-email-virtuoso@slind.org>
Message-ID: <20100806170021.GA31135@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alexander Shishkin (virtuoso at slind.org) wrote:
[...]
> +/*
> + * emulate __xchg() using 32-bit __cmpxchg()
> + *
> + * This is done by taking the word-aligned word that contains *ptr,
> + * calculating a mask which will cover the ptr part of said word and
> + * using it to replace *ptr with x in the word.
> + */
> +static inline unsigned long __xchg_generic(unsigned long x,
> +						 volatile void *ptr, int size)
> +{
> +	unsigned long *ptrbase, mask, new, ret;
> +	int shift;
> +
> +	ptrbase = object_align_floor((unsigned long *)ptr);
> +
> +#ifdef BIG_ENDIAN
> +	shift = (~(unsigned long)ptr & (4 - size)) * 8;

Sorry if I am slow on the uptake, but I still don't figure out exactly
how the line above works. Some more detailed explanation would be
welcome.

Thanks,

Mathieu

> +#else
> +	shift = ((unsigned long)ptr - (unsigned long)ptrbase) * 8;
> +#endif
> +
> +	mask = ~(((1 << (size * 8)) - 1) << shift);
> +	new = x << shift;
> +
> +	ret = *ptrbase;
> +	while (1) {
> +		unsigned long tmp = __cmpxchg(ptrbase, ret, (ret & mask) | new,
> +					      4);
> +		if (tmp == ret)
> +			break;
> +		ret = tmp;
> +	}
> +
> +	return ret;
> +}
> +#endif
> +
-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
