From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 11 Aug 2012 23:04:49 -0400 (EDT)
Subject: [PATCH v2 04/22] ARM: LPAE: use phys_addr_t on virt <--> phys
 conversion
In-Reply-To: <1344648306-15619-5-git-send-email-cyril@ti.com>
References: <1344648306-15619-1-git-send-email-cyril@ti.com>
 <1344648306-15619-5-git-send-email-cyril@ti.com>
Message-ID: <alpine.LFD.2.02.1208112304130.5231@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Aug 2012, Cyril Chemparathy wrote:

> This patch fixes up the types used when converting back and forth between
> physical and virtual addresses.
> 
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>

Reviewed-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/include/asm/memory.h |   26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 3d93779..81e1714 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -157,22 +157,32 @@ extern unsigned long	__pv_offset;
>  extern unsigned long	__pv_phys_offset;
>  #define PHYS_OFFSET	__virt_to_phys(PAGE_OFFSET)
>  
> -static inline unsigned long __virt_to_phys(unsigned long x)
> +static inline phys_addr_t __virt_to_phys(unsigned long x)
>  {
>  	unsigned long t;
>  	early_patch_imm8("add", t, x, __pv_offset, 0);
>  	return t;
>  }
>  
> -static inline unsigned long __phys_to_virt(unsigned long x)
> +static inline unsigned long __phys_to_virt(phys_addr_t x)
>  {
> -	unsigned long t;
> -	early_patch_imm8("sub", t, x, __pv_offset, 0);
> +	unsigned long t, xlo = x;
> +	early_patch_imm8("sub", t, xlo, __pv_offset, 0);
>  	return t;
>  }
> +
>  #else
> -#define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
> -#define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
> +
> +static inline phys_addr_t __virt_to_phys(unsigned long x)
> +{
> +	return (phys_addr_t)x - PAGE_OFFSET + PHYS_OFFSET;
> +}
> +
> +static inline unsigned long __phys_to_virt(phys_addr_t x)
> +{
> +	return x - PHYS_OFFSET + PAGE_OFFSET;
> +}
> +
>  #endif
>  #endif
>  
> @@ -207,14 +217,14 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
>  
>  static inline void *phys_to_virt(phys_addr_t x)
>  {
> -	return (void *)(__phys_to_virt((unsigned long)(x)));
> +	return (void *)__phys_to_virt(x);
>  }
>  
>  /*
>   * Drivers should NOT use these either.
>   */
>  #define __pa(x)			__virt_to_phys((unsigned long)(x))
> -#define __va(x)			((void *)__phys_to_virt((unsigned long)(x)))
> +#define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
>  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
>  
>  /*
> -- 
> 1.7.9.5
> 
