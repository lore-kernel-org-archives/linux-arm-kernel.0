From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 16 Jul 2018 21:23:57 +0200 (CEST)
Subject: [PATCHv4 02/12] atomics/x86: reduce arch_cmpxchg64*()
 instrumentation
In-Reply-To: <20180716113017.3909-3-mark.rutland@arm.com>
References: <20180716113017.3909-1-mark.rutland@arm.com>
 <20180716113017.3909-3-mark.rutland@arm.com>
Message-ID: <alpine.DEB.2.21.1807162123380.1693@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Jul 2018, Mark Rutland wrote:
> Currently x86's arch_cmpxchg64() and arch_cmpxchg64_local() are
> instrumented twice, as they call into instrumented atomics rather than
> their arch_ equivalents.
> 
> A call to cmpxchg64() results in:
> 
>   cmpxchg64()
>     kasan_check_write()
>     arch_cmpxchg64()
>       cmpxchg()
>         kasan_check_write()
>         arch_cmpxchg()
> 
> Let's fix this up and call the arch_ equivalents, resulting in:
> 
>   cmpxchg64()
>     kasan_check_write()
>     arch_cmpxchg64()
>       arch_cmpxchg()
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Will Deacon <will.deacon@arm.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
