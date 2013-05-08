From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 May 2013 13:46:40 +0100
Subject: [RFC] Bug in ARM v6+ implementation of cmpxchg64() ?
In-Reply-To: <CAGzjT4cikbZ4rRJxzMM4P0MZYpWumYC15qVW3OaPd7GESS5mwg@mail.gmail.com>
References: <CAGzjT4cikbZ4rRJxzMM4P0MZYpWumYC15qVW3OaPd7GESS5mwg@mail.gmail.com>
Message-ID: <20130508124639.GA339@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 01:14:40PM +0100, Jaccon Bastiaansen wrote:
> Hello,

Hi Jaccon,

> The ARM implementation of cmpxchg64() for ARM arch v6 and v7 casts
> parameter 2 and 3 (the old and new 64 values) to an unsigned long
> before calling the atomic_cmpxchg64() function:
> 
> #define cmpxchg64(ptr, o, n) \
> ((__typeof__(*(ptr)))atomic64_cmpxchg(container_of((ptr), \
> atomic64_t, \
> counter), \
>      (unsigned long)(o), \
>      (unsigned long)(n)))
> 
> 
> To me it seems that now the top 32 bits of the old and new value are
> stripped before calling atomic64_cmpxchg(), causing incorrect value to
> be "compare-exchanged". Is this correct?
> 
> Browsing in the git history, I found commit
> 
> 3e0f5a15f5003f4576c35498814f0f1567860449
> 
> which changed
> -#define cmpxchg64(ptr,o,n)                                             \
> -       ((__typeof__(*(ptr)))__cmpxchg64_mb((ptr),                      \
> -                                           (unsigned long long)(o),    \
> -                                           (unsigned long long)(n)))
> 
> 
> into
> 
> +#define cmpxchg64(ptr, o, n)                                           \
> +       ((__typeof__(*(ptr)))atomic64_cmpxchg(container_of((ptr),       \
> +                                               atomic64_t,             \
> +                                               counter),               \
> +                                             (unsigned long)(o),       \
> +                                             (unsigned long)(n)))

Damn, that's what happens when you work on arm and arm64 in parallel. Yes,
this is a bug.

Wondering why this hasn't been spotted until now, I grepped around and it
looks like the only user is sched_clock. Since ARM's sched_clock is 32-bit
only (patches are currently in the works iirc), it seems as though we've
managed to get away with this.

Are you happy to send a patch fixing the casts please?

Cheers,

Will
