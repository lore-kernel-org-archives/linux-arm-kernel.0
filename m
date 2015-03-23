From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Mar 2015 10:17:58 +0000
Subject: [PATCH V2] arm64: percpu: Make this_cpu accessors pre-empt safe
In-Reply-To: <1427035911-10585-1-git-send-email-steve.capper@linaro.org>
References: <20150320180228.GI1474@arm.com>
 <1427035911-10585-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20150323101758.GB11189@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 22, 2015 at 02:51:51PM +0000, Steve Capper wrote:
> this_cpu operations were implemented for arm64 in:
>  5284e1b arm64: xchg: Implement cmpxchg_double
>  f97fc81 arm64: percpu: Implement this_cpu operations
> 
> Unfortunately, it is possible for pre-emption to take place between
> address generation and data access. This can lead to cases where data
> is being manipulated by this_cpu for a different CPU than it was
> called on. Which effectively breaks the spec.
> 
> This patch disables pre-emption for the this_cpu operations
> guaranteeing that address generation and data manipulation take place
> without a pre-emption in-between.
> 
> Fixes: 5284e1b4bc8a ("arm64: xchg: Implement cmpxchg_double")
> Fixes: f97fc810798c ("arm64: percpu: Implement this_cpu operations")
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
> Changed in V2, moved over to preempt_enable() completely.
> Corrected the "Fixes" tag.
> 
> Mark, I've dropped your Reviewed-by as I've changed some logic, please
> let me know if I should re-add it.
> 
> Cheers,
> -- 
> Steve
> ---
>  arch/arm64/include/asm/cmpxchg.h | 32 +++++++++++++++++++++--------
>  arch/arm64/include/asm/percpu.h  | 44 ++++++++++++++++++++++++++++++----------
>  2 files changed, 57 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index cb95930..d8c25b7 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -246,14 +246,30 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
>  	__ret; \
>  })
>  
> -#define this_cpu_cmpxchg_1(ptr, o, n) cmpxchg_local(raw_cpu_ptr(&(ptr)), o, n)
> -#define this_cpu_cmpxchg_2(ptr, o, n) cmpxchg_local(raw_cpu_ptr(&(ptr)), o, n)
> -#define this_cpu_cmpxchg_4(ptr, o, n) cmpxchg_local(raw_cpu_ptr(&(ptr)), o, n)
> -#define this_cpu_cmpxchg_8(ptr, o, n) cmpxchg_local(raw_cpu_ptr(&(ptr)), o, n)
> -
> -#define this_cpu_cmpxchg_double_8(ptr1, ptr2, o1, o2, n1, n2) \
> -	cmpxchg_double_local(raw_cpu_ptr(&(ptr1)), raw_cpu_ptr(&(ptr2)), \
> -				o1, o2, n1, n2)
> +#define _protect_cmpxchg_local(pcp, o, n)			\
> +({								\
> +	typeof(*raw_cpu_ptr(&(pcp))) __ret;			\
> +	preempt_disable();					\
> +	__ret = cmpxchg_local(raw_cpu_ptr(&(pcp)), o, n);	\
> +	preempt_enable();					\
> +	__ret;							\
> +})
> +
> +#define this_cpu_cmpxchg_1(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> +#define this_cpu_cmpxchg_2(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> +#define this_cpu_cmpxchg_4(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> +#define this_cpu_cmpxchg_8(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> +
> +#define this_cpu_cmpxchg_double_8(ptr1, ptr2, o1, o2, n1, n2)		\
> +({									\
> +	int __ret;							\
> +	preempt_disable();						\
> +	__ret = cmpxchg_double_local(	raw_cpu_ptr(&(ptr1)),		\

Weird whitespace here, but the patch looks fine to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Thanks, Steve.

Will
