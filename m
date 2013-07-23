From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 23 Jul 2013 16:12:57 -0400 (EDT)
Subject: [PATCH 5/6] ARM: atomics: prefetch the destination word for
 write prior to strex
In-Reply-To: <1374579389-32704-6-git-send-email-will.deacon@arm.com>
References: <1374579389-32704-1-git-send-email-will.deacon@arm.com>
 <1374579389-32704-6-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.03.1307231611550.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jul 2013, Will Deacon wrote:

> The cost of changing a cacheline from shared to exclusive state can be
> significant, especially when this is triggered by an exclusive store,
> since it may result in having to retry the transaction.
> 
> This patch prefixes our atomic access implementations with pldw
> instructions (on CPUs which support them) to try and grab the line in
> exclusive state from the start. Only the barrier-less functions are
> updated, since memory barriers can limit the usefulness of prefetching
> data.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/atomic.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> index da1c77d..e3f052a 100644
> --- a/arch/arm/include/asm/atomic.h
> +++ b/arch/arm/include/asm/atomic.h
> @@ -12,6 +12,7 @@
>  #define __ASM_ARM_ATOMIC_H
>  
>  #include <linux/compiler.h>
> +#include <linux/prefetch.h>
>  #include <linux/types.h>
>  #include <linux/irqflags.h>
>  #include <asm/barrier.h>
> @@ -41,6 +42,7 @@ static inline void atomic_add(int i, atomic_t *v)
>  	unsigned long tmp;
>  	int result;
>  
> +	prefetchw((const void *)&v->counter);

Same comment as for the previous patch wrt the cast.  Even more so given 
it is spreading all over the place now.






>  	__asm__ __volatile__("@ atomic_add\n"
>  "1:	ldrex	%0, [%3]\n"
>  "	add	%0, %0, %4\n"
> @@ -79,6 +81,7 @@ static inline void atomic_sub(int i, atomic_t *v)
>  	unsigned long tmp;
>  	int result;
>  
> +	prefetchw((const void *)&v->counter);
>  	__asm__ __volatile__("@ atomic_sub\n"
>  "1:	ldrex	%0, [%3]\n"
>  "	sub	%0, %0, %4\n"
> @@ -138,6 +141,7 @@ static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
>  {
>  	unsigned long tmp, tmp2;
>  
> +	prefetchw((const void *)addr);
>  	__asm__ __volatile__("@ atomic_clear_mask\n"
>  "1:	ldrex	%0, [%3]\n"
>  "	bic	%0, %0, %4\n"
> @@ -283,6 +287,7 @@ static inline void atomic64_set(atomic64_t *v, u64 i)
>  {
>  	u64 tmp;
>  
> +	prefetchw((const void *)&v->counter);
>  	__asm__ __volatile__("@ atomic64_set\n"
>  "1:	ldrexd	%0, %H0, [%2]\n"
>  "	strexd	%0, %3, %H3, [%2]\n"
> @@ -299,6 +304,7 @@ static inline void atomic64_add(u64 i, atomic64_t *v)
>  	u64 result;
>  	unsigned long tmp;
>  
> +	prefetchw((const void *)&v->counter);
>  	__asm__ __volatile__("@ atomic64_add\n"
>  "1:	ldrexd	%0, %H0, [%3]\n"
>  "	adds	%0, %0, %4\n"
> @@ -339,6 +345,7 @@ static inline void atomic64_sub(u64 i, atomic64_t *v)
>  	u64 result;
>  	unsigned long tmp;
>  
> +	prefetchw((const void *)&v->counter);
>  	__asm__ __volatile__("@ atomic64_sub\n"
>  "1:	ldrexd	%0, %H0, [%3]\n"
>  "	subs	%0, %0, %4\n"
> -- 
> 1.8.2.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
