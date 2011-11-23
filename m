From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 23 Nov 2011 11:09:00 -0500 (EST)
Subject: [PATCH] ARM: Add optimised swahb32() byteswap helper for v6 and
 above
In-Reply-To: <1322059345-18842-1-git-send-email-dave.martin@linaro.org>
References: <1322059345-18842-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.02.1111231108330.17904@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Nov 2011, Dave Martin wrote:

> ARMv6 and later processors have the REV16 instruction, which swaps
> the bytes within each halfword of a register value.
> 
> This is already used to implement swab16(), but since the native
> operation performaed by REV16 is actually swahb32(), this patch
> renames the existing swab16() helper accordingly and defines
> __arch_swab16() in terms of it.  This allows calls to both swab16()
> and swahb32() to be optimised.
> 
> The compiler's generated code might improve someday, but as of
> 4.5.2 the code generated for pure C implementing these 16-bit
> bytesswaps remains pessimal.
> 
> swahb32() is useful for converting 32-bit Thumb instructions
> between integer and memory representation on BE8 platforms (among
> other uses).
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Reviewed-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/include/asm/swab.h |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/swab.h b/arch/arm/include/asm/swab.h
> index 9997ad2..32ee164 100644
> --- a/arch/arm/include/asm/swab.h
> +++ b/arch/arm/include/asm/swab.h
> @@ -24,12 +24,13 @@
>  
>  #if defined(__KERNEL__) && __LINUX_ARM_ARCH__ >= 6
>  
> -static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
> +static inline __attribute_const__ __u32 __arch_swahb32(__u32 x)
>  {
>  	__asm__ ("rev16 %0, %1" : "=r" (x) : "r" (x));
>  	return x;
>  }
> -#define __arch_swab16 __arch_swab16
> +#define __arch_swahb32 __arch_swahb32
> +#define __arch_swab16(x) ((__u16)__arch_swahb32(x))
>  
>  static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
>  {
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
