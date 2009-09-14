From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 15 Sep 2009 00:16:18 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <1252930881.16853.99.camel@pc1117.cambridge.arm.com>
References: <1250870319.10642.23.camel@pc1117.cambridge.arm.com>
	<1250890146.29685.18.camel@david-laptop>
	<1251128692.28977.17.camel@pc1117.cambridge.arm.com>
	<1251134043.31975.23.camel@david-laptop>
	<1251135709.28977.40.camel@pc1117.cambridge.arm.com>
	<20090914014353.GA4762@shareable.org>
	<20090914100056.GC16644@n2100.arm.linux.org.uk>
	<1252922773.16853.62.camel@pc1117.cambridge.arm.com>
	<1252928832.16853.96.camel@pc1117.cambridge.arm.com>
	<1252930881.16853.99.camel@pc1117.cambridge.arm.com>
Message-ID: <20090914231618.GA28427@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
>  #define atomic_read(v)	((v)->counter)
> +#define atomic_set(v,i)	(((v)->counter) = (i))
>  
>  #if __LINUX_ARM_ARCH__ >= 6
>  
>  /*
>   * ARMv6 UP and SMP safe atomic ops.  We use load exclusive and
>   * store exclusive to ensure that these are atomic.  We may loop
> - * to ensure that the update happens.  Writing to 'v->counter'
> - * without using the following operations WILL break the atomic
> - * nature of these ops.
> + * to ensure that the update happens.
>   */
> -static inline void atomic_set(atomic_t *v, int i)
> -{
> -	unsigned long tmp;
> -
> -	__asm__ __volatile__("@ atomic_set\n"
> -"1:	ldrex	%0, [%1]\n"
> -"	strex	%0, %2, [%1]\n"
> -"	teq	%0, #0\n"
> -"	bne	1b"
> -	: "=&r" (tmp)
> -	: "r" (&v->counter), "r" (i)
> -	: "cc");
> -}

I was going to say this won't work, because I'd read this in
<asm/atomic.h>:

    /* Atomic operations are already serializing on ARM */
    #define smp_mb__before_atomic_dec()    barrier()
    [etc]

and imagined that atomic_set() needed to provide the same.

But then but then I spotted Documentation/atomic_ops.txt:

    *** WARNING: atomic_read() and atomic_set() DO NOT IMPLY BARRIERS! ***

So that's alright then.

Besides, it turns out the comment in <asm/atomic.h> was wrong, and was
removed recently, with explicit barrier instructions being added where
expected.

Regarding the patch, a command saying _why_ it's ok for atomic_set()
to be a simple assignment would be good:

    /*
     * On ARM, ordinary assignment (str instruction) doesn't clear the
     * _local_ strex/ldrex monitor on some implementations.  The
     * reason we can use it for atomic_set() is the clrex or dummy
     * strex done on every exception return and context switch.
     */

-- Jamie
