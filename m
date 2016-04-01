From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 1 Apr 2016 09:56:35 +0100
Subject: [PATCH V3 1/1] ARM : missing corrupted reg in __div64_32
In-Reply-To: <BLU436-SMTP267D09D3249FC3AAF122B999A0@phx.gbl>
References: <20160331114106.GI3701@e103592.cambridge.arm.com>
 <BLU436-SMTP267D09D3249FC3AAF122B999A0@phx.gbl>
Message-ID: <20160401085631.GJ3701@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 12:22:11PM +0800, chengang wrote:
> __xl(R0 in little endian system, or R1 in big endian system) is corrupted
> after calling __do_div64 and compiler is not informed about this.
> If n is used again afterwards, __xl won't be reloaded and n will
> contain incorrect value.

You should briefly explain the fix here.

> 
> Signed-off-by: Chen Gang <gangchen@rdamicro.com>
> Signed-off-by: Chen Gang <changeang.beijing@outlook.com>
> ---
>  arch/arm/include/asm/div64.h | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> index e1f0776..8d1b49a 100644
> --- a/arch/arm/include/asm/div64.h
> +++ b/arch/arm/include/asm/div64.h
> @@ -21,30 +21,24 @@
>   * for arguments and results (beware).
>   */
>  
> -#ifdef __ARMEB__
> -#define __xh "r0"
> -#define __xl "r1"
> -#else
> -#define __xl "r0"
> -#define __xh "r1"
> -#endif

These defines aren't used by anything else, right?

I grepped for them, but I didn't see any other matches.

>  
>  static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
>  {
>  	register unsigned int __base      asm("r4") = base;
>  	register unsigned long long __n   asm("r0") = *n;
>  	register unsigned long long __res asm("r2");
> -	register unsigned int __rem       asm(__xh);
> -	asm(	__asmeq("%0", __xh)
> +	asm(	__asmeq("%0", "r0")
>  		__asmeq("%1", "r2")
> -		__asmeq("%2", "r0")
> -		__asmeq("%3", "r4")
> +		__asmeq("%2", "r4")
>  		"bl	__do_div64"
> -		: "=r" (__rem), "=r" (__res)
> -		: "r" (__n), "r" (__base)
> +		: "+r" (__n), "=r" (__res)
> +		: "r" (__base)
>  		: "ip", "lr", "cc");
>  	*n = __res;
> -	return __rem;
> +	/*
> +	 * rem is saved at the up half of __n, see __do_div64 for more
> +	 */

Minor nit:

It's useful to have a comment here, but rem is gone, and you might want
to say "upper half", e.g., something like:

	/* __do_div returns the remainder in the upper word of __n: */

> +	return __n >> 32;
>  }
>  #define __div64_32 __div64_32
>  
> -- 
> 2.4.3

Cheers
---Dave
