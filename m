From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Dec 2013 12:00:27 +0000
Subject: [PATCHv2 2/2] arm64: Correct virt_addr_valid
In-Reply-To: <1387220505-9799-2-git-send-email-lauraa@codeaurora.org>
References: <1387220505-9799-1-git-send-email-lauraa@codeaurora.org>
 <1387220505-9799-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <20131217120027.GD32118@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 07:01:45PM +0000, Laura Abbott wrote:
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 3776217..b8ec776 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -146,8 +146,9 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
>  
>  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
> -#define	virt_addr_valid(kaddr)	(((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
> -				 ((void *)(kaddr) < (void *)high_memory))
> +#define virt_addr_valid(kaddr)	(pfn_valid(__pa(kaddr) >> PAGE_SHIFT) && \
> +	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory))
> +

I still think the original patch was fine for arm64, no need for
additional checks since we don't have highmem and __pa() is always
linear.

-- 
Catalin
