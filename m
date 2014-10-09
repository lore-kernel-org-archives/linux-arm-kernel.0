From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 09 Oct 2014 14:10:40 +0100
Subject: [PATCH 5/6] arm64: kvm: define PAGE_S2_DEVICE as read-only by
 default
In-Reply-To: <1410990981-665-6-git-send-email-ard.biesheuvel@linaro.org>
References: <1410990981-665-1-git-send-email-ard.biesheuvel@linaro.org>
 <1410990981-665-6-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <54368950.1070703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/09/14 22:56, Ard Biesheuvel wrote:
> Now that we support read-only memslots, we need to make sure that
> pass-through device mappings are not mapped writable if the guest
> has requested them to be read-only. The existing implementation
> already honours this by calling kvm_set_s2pte_writable() on the new
> pte in case of writable mappings, so all we need to do is define
> the default pgprot_t value used for devices to be PTE_S2_RDONLY.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

> ---
>  arch/arm64/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index ffe1ba0506d1..51f6f5284ce5 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -79,7 +79,7 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
>  #define PAGE_HYP_DEVICE		__pgprot(PROT_DEVICE_nGnRE | PTE_HYP)
>  
>  #define PAGE_S2			__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY)
> -#define PAGE_S2_DEVICE		__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDWR | PTE_UXN)
> +#define PAGE_S2_DEVICE		__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_UXN)
>  
>  #define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_TYPE_MASK) | PTE_PROT_NONE | PTE_PXN | PTE_UXN)
>  #define PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
> 


-- 
Jazz is not dead. It just smells funny...
