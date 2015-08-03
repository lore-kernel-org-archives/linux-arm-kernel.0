From: mpe@ellerman.id.au (Michael Ellerman)
Date: Mon, 03 Aug 2015 11:41:58 +1000
Subject: [PATCH v2] arch: use WRITE_ONCE/READ_ONCE in
 smp_store_release/smp_load_acquire
In-Reply-To: <1438528264-714-1-git-send-email-andreyknvl@google.com>
References: <1438528264-714-1-git-send-email-andreyknvl@google.com>
Message-ID: <1438566118.8863.3.camel@ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-08-02 at 17:11 +0200, Andrey Konovalov wrote:
> Replace ACCESS_ONCE() macro in smp_store_release() and smp_load_acquire()
> with WRITE_ONCE() and READ_ONCE() on x86, arm, arm64, ia64, metag, mips,
> powerpc, s390, sparc and asm-generic since ACCESS_ONCE does not work
> reliably on non-scalar types.

.. and there are no restrictions on the argument to smp_load_acquire(), so it
may be a non-scalar type.

Though from a quick grep it looks like no one is doing that at the moment?

> WRITE_ONCE() and READ_ONCE() were introduced in the commits 230fa253df63
> ("kernel: Provide READ_ONCE and ASSIGN_ONCE") and 43239cbe79fc ("kernel:
> Change ASSIGN_ONCE(val, x) to WRITE_ONCE(x, val)").
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
> Changed in v2:
>   - Other archs besides x86.
> 
>  arch/powerpc/include/asm/barrier.h  | 4 ++--

> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> index 51ccc72..0eca6ef 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -76,12 +76,12 @@
>  do {									\
>  	compiletime_assert_atomic_type(*p);				\
>  	smp_lwsync();							\
> -	ACCESS_ONCE(*p) = (v);						\
> +	WRITE_ONCE(*p, v);						\
>  } while (0)
>  
>  #define smp_load_acquire(p)						\
>  ({									\
> -	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> +	typeof(*p) ___p1 = READ_ONCE(*p);				\
>  	compiletime_assert_atomic_type(*p);				\
>  	smp_lwsync();							\
>  	___p1;								\

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
