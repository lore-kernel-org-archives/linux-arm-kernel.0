From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Nov 2013 20:42:32 +0100
Subject: Physical memory start contraints in the Linux kernel (Was: Re:
 Xen osstest on Calxeda midway progress (Was: Re: [Xen-devel] [xen-unstable
 test] 21486: tolerable FAIL - PUSHED))
In-Reply-To: <alpine.DEB.2.02.1311131417030.4714@kaball.uk.xensource.com>
References: <osstest-21486-mainreport@xen.org>
 <1384339849.5406.52.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311131417030.4714@kaball.uk.xensource.com>
Message-ID: <201311132042.32725.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 November 2013, Stefano Stabellini wrote:
>  
> -#define xchg_xen_ulong(ptr, val) atomic64_xchg(container_of((ptr),	\
> +#ifdef CONFIG_GENERIC_ATOMIC64
> +/* if CONFIG_GENERIC_ATOMIC64 is defined we cannot use the generic
> + * atomic64_xchg function because it is implemented using spin locks.
> + * Here we need proper atomic instructions to read and write memory
> + * shared with the hypervisor.
> + */
> +static inline u64 xen_atomic64_xchg(atomic64_t *ptr, u64 new)
> +{
> +	u64 result;
> +	unsigned long tmp;
> +
> +	smp_mb();
> +
> +	__asm__ __volatile__("@ xen_atomic64_xchg\n"
> +"1:	ldrexd	%0, %H0, [%3]\n"
> +"	strexd	%1, %4, %H4, [%3]\n"
> +"	teq	%1, #0\n"
> +"	bne	1b"
> +	: "=&r" (result), "=&r" (tmp), "+Qo" (ptr->counter)
> +	: "r" (&ptr->counter), "r" (new)
> +	: "cc");
> +
> +	smp_mb();
> +
> +	return result;
> +}
> +#else
> +#define xen_atomic64_xchg atomic64_xchg
> +#endif

I would prefer not duplicating this code. Maybe we can instead change
the ARM code to always provide this function under the name of
armv7_atomic64_xchg() and conditionally defining atomic64_xchg
to use it. Let's see if Russell has an opinion on this, or perhaps
a better solution.

> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> index 62ccf54..d668c3c 100644
> --- a/drivers/xen/grant-table.c
> +++ b/drivers/xen/grant-table.c
> @@ -33,6 +33,14 @@
>  
>  #define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
>  
> +/* This is required because cmpxchg only support 32-bits operands on
> + * ARMv6, so if CONFIG_CPU_V6 is defined the cmpxchg implemention will
> + * be limited to 32-bits operands.
> + * However we know for sure that if Linux is running on Xen, the
> + * platform is >= ARMv7, so here we can safely undef CONFIG_CPU_V6.
> + */
> +#undef CONFIG_CPU_V6
> +
>  #include <linux/module.h>
>  #include <linux/sched.h>
>  #include <linux/mm.h>
> 

Same here: I'd prefer making this more explicit by changing the cmpxchg
implementation: we could split out the 16-bit cmpxchg case into a separate
function with "armv7" in the name and only call that from the main
cmpxchg() implementations when building an armv7-only kernel, but still
let you call it from Xen code that is known to run only on armv7.

	Arnd 
