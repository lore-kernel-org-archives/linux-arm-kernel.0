From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 4 Feb 2014 17:43:08 +0100
Subject: [PATCH 1/2] arm64: atomics: fix use of acquire + release for
 full barrier semantics
In-Reply-To: <1391516953-14541-1-git-send-email-will.deacon@arm.com>
References: <1391516953-14541-1-git-send-email-will.deacon@arm.com>
Message-ID: <20140204164308.GA5002@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 12:29:12PM +0000, Will Deacon wrote:
> @@ -112,17 +114,20 @@ static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
>  	unsigned long tmp;
>  	int oldval;
>  
> +	smp_mb();
> +
>  	asm volatile("// atomic_cmpxchg\n"
> -"1:	ldaxr	%w1, %2\n"
> +"1:	ldxr	%w1, %2\n"
>  "	cmp	%w1, %w3\n"
>  "	b.ne	2f\n"
> -"	stlxr	%w0, %w4, %2\n"
> +"	stxr	%w0, %w4, %2\n"
>  "	cbnz	%w0, 1b\n"
>  "2:"
>  	: "=&r" (tmp), "=&r" (oldval), "+Q" (ptr->counter)
>  	: "Ir" (old), "r" (new)
>  	: "cc", "memory");
>  
> +	smp_mb();
>  	return oldval;
>  }
>  

Any particular reason atomic_cmpxchg() doesn't use the proposed rel + mb
scheme? It would be a waste to have atomic_cmpxchg() be more expensive
than it needs to be.
