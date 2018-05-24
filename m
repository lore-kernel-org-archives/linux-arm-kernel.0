From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 24 May 2018 14:44:10 +0200
Subject: [PATCH 6/9] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
In-Reply-To: <1527159586-8578-7-git-send-email-will.deacon@arm.com>
References: <1527159586-8578-1-git-send-email-will.deacon@arm.com>
 <1527159586-8578-7-git-send-email-will.deacon@arm.com>
Message-ID: <20180524124410.GF12198@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 11:59:43AM +0100, Will Deacon wrote:
> +static inline void set_bit(unsigned int nr, volatile unsigned long *p)
>  {
> +	p += BIT_WORD(nr);
> +	atomic_long_fetch_or_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
>  }
>  
> +static inline void clear_bit(unsigned int nr, volatile unsigned long *p)
>  {
> +	p += BIT_WORD(nr);
> +	atomic_long_fetch_andnot_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
>  }
>  
> +static inline void change_bit(unsigned int nr, volatile unsigned long *p)
>  {
> +	p += BIT_WORD(nr);
> +	atomic_long_fetch_xor_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
>  }

Why use the fetch variants here?
