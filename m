From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 30 Nov 2016 17:17:13 +0000
Subject: [PATCHv4 05/10] arm64: Use __pa_symbol for kernel symbols
In-Reply-To: <1480445729-27130-6-git-send-email-labbott@redhat.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <1480445729-27130-6-git-send-email-labbott@redhat.com>
Message-ID: <20161130171713.GE4439@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 10:55:24AM -0800, Laura Abbott wrote:
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -205,6 +205,8 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
>  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
>  #define virt_to_pfn(x)      __phys_to_pfn(__virt_to_phys((unsigned long)(x)))
> +#define sym_to_pfn(x)	    __phys_to_pfn(__pa_symbol(x))
> +#define lm_alias(x)		__va(__pa_symbol(x))
[...]
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -76,6 +76,10 @@ extern int mmap_rnd_compat_bits __read_mostly;
>  #define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
>  #endif
>  
> +#ifndef lm_alias
> +#define lm_alias(x)	__va(__pa_symbol(x))
> +#endif

You can drop the arm64-specific lm_alias macro as it's the same as the
generic one you introduced in the same patch.

-- 
Catalin
