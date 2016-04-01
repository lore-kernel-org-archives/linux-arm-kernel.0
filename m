From: Dave.Martin@arm.com (Dave P Martin)
Date: Fri, 1 Apr 2016 12:34:13 +0100
Subject: [PATCH V5 1/1] ARM : missing corrupted reg in __div64_32
In-Reply-To: <BLU436-SMTP2480AEC0BAAAECEC0C70276999A0@phx.gbl>
References: <20160401110315.GK3701@e103592.cambridge.arm.com>
 <BLU436-SMTP2480AEC0BAAAECEC0C70276999A0@phx.gbl>
Message-ID: <20160401113412.GJ24713@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 07:25:34PM +0800, chengang wrote:
> __xl(R0 in little endian system, or R1 in big endian system) is corrupted
> by the call to  __do_div64(). The  compiler is not aware of this, so if
> n is used afterwards __xl won't be reloaded and n will contain incorrect value.
> 
> Mark 64bits variable __n as input/output to inform compiler both r0 and r1
> are changed by the funciton call.

Looks good for me now.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> 
> Signed-off-by: Chen Gang <gangchen@rdamicro.com>
> Signed-off-by: Chen Gang <changeang.beijing@outlook.com>
> ---
>  arch/arm/include/asm/div64.h | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> index e1f0776..ba3a5fc 100644
> --- a/arch/arm/include/asm/div64.h
> +++ b/arch/arm/include/asm/div64.h
> @@ -21,30 +21,22 @@
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
> +	/* __do_div64 returns the remainder in the upper word of __n */
> +	return __n >> 32;
>  }
>  #define __div64_32 __div64_32
