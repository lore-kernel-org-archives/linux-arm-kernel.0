From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Feb 2016 12:26:15 +0000
Subject: [RFC PATCH 10/10] arm64: mm: restrict __pa() translations to
 linear virtual addresses
In-Reply-To: <1456174472-30028-11-git-send-email-ard.biesheuvel@linaro.org>
References: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456174472-30028-11-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160223122615.GJ3966@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 09:54:32PM +0100, Ard Biesheuvel wrote:
> Now that we have replaced all occurrences of __pa() translations
> involving virtual addresses that are covered by the kernel text,
> we can redefine __virt_to_phys and __pa() etc to only take virtual
> address that are covered by the linear mapping. This means we can
> remove the comparison with PAGE_OFFSET in the definition of
> __virt_to_phys().
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/memory.h | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 56d6739430f3..3b5dc5b243ac 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -86,11 +86,14 @@
>   * private definitions which should NOT be used outside memory.h
>   * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
>   */
> -#define __virt_to_phys(x) ({						\
> +#ifndef CONFIG_DEBUG_VM
> +#define __virt_to_phys(x)	(((phys_addr_t)(x) & ~PAGE_OFFSET) + PHYS_OFFSET)
> +#else
> +#define __virt_to_phys(x)	({					\
>  	phys_addr_t __x = (phys_addr_t)(x);				\
> -	__x & BIT(VA_BITS - 1) ? (__x & ~PAGE_OFFSET) + PHYS_OFFSET :	\
> -				 (__x - kimage_voffset); })
> -
> +	BUG_ON(__x < PAGE_OFFSET);					\
> +	(((phys_addr_t)__x & ~PAGE_OFFSET) + PHYS_OFFSET); })

What's the #include-hell like if you try to use VM_BUG_ON instead?

Will
