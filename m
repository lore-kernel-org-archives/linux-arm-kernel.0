From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 09 May 2013 10:32:12 +0100
Subject: [PATCH] arm64: KVM: Add bits for specifying memory type in stage2
 PTE
In-Reply-To: <1368078813-16904-1-git-send-email-anup.patel@linaro.org>
References: <1368078813-16904-1-git-send-email-anup.patel@linaro.org>
Message-ID: <518B6D1C.3020603@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Looping in Catalin, as we just had an interesting discussion about this]

Hi Anup,

On 09/05/13 06:53, Anup Patel wrote:
> We cannot use existing stage1 PTE_ATTRINDX() macro for specifying
> stage2 memory type because stage1 ATTRINDX = PTE[4:2] and stage2
> MEMATTR = PTE[5:2].

You're right, this is a bug. But...

> This patch adds bit definetions for specifying device, noncacheable,
> writethrough, and writeback memory types in stage2 PTE and also uses
> it in PAGE_S2 and PAGE_S2_DEVICE.

... I have the feeling we don't need most of this:

Stage-2 memory attributes can only restrict what the guest puts in its
Stage-1. Which means that unless we really need to play some ugly tricks
on the guest (which we don't), it is probably best to leave everything
as Normal, Outer Write-Back, Inner Write-Back.

So I think the right fix is to get rid of of PAGE_S2_DEVICE, use PAGE_S2
for everything, and set MemAttr[3:0] to 0b1111.

I'll try that and cook a separate patch if it looks good enough (it is
likely to impact the 32bit code as well...).

> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm64/include/asm/pgtable-hwdef.h |    4 ++++
>  arch/arm64/include/asm/pgtable.h       |    6 ++++--
>  arch/arm64/mm/mmu.c                    |    9 +++++++++
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index c49cd61..555babb 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -73,6 +73,10 @@
>   */
>  #define PTE_S2_RDONLY		 (_AT(pteval_t, 1) << 6)   /* HAP[1]   */
>  #define PTE_S2_RDWR		 (_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
> +#define PTE_S2_MT_DEVICE	 (_AT(pteval_t, 0x0) << 2) /* MemAttr[3:0] */
> +#define PTE_S2_MT_UNCACHED	 (_AT(pteval_t, 0x5) << 2) /* MemAttr[3:0] */
> +#define PTE_S2_MT_WRITETHROUGH	 (_AT(pteval_t, 0xa) << 2) /* MemAttr[3:0] */
> +#define PTE_S2_MT_WRITEBACK	 (_AT(pteval_t, 0xf) << 2) /* MemAttr[3:0] */
>  
>  /*
>   * EL2/HYP PTE/PMD definitions
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 43ce724..3003fd0 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -60,6 +60,8 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
>  #define _PAGE_DEFAULT		PTE_TYPE_PAGE | PTE_AF
>  
>  extern pgprot_t pgprot_default;
> +extern pgprot_t pgprot_s2;
> +extern pgprot_t pgprot_s2_device;
>  
>  #define __pgprot_modify(prot,mask,bits) \
>  	__pgprot((pgprot_val(prot) & ~(mask)) | (bits))
> @@ -79,8 +81,8 @@ extern pgprot_t pgprot_default;
>  #define PAGE_HYP		_MOD_PROT(pgprot_default, PTE_HYP)
>  #define PAGE_HYP_DEVICE		_MOD_PROT(__pgprot(PROT_DEVICE_nGnRE), PTE_HYP)
>  
> -#define PAGE_S2			_MOD_PROT(pgprot_default, PTE_S2_RDONLY)
> -#define PAGE_S2_DEVICE		__pgprot_modify(__pgprot(PROT_DEVICE_nGnRE), PTE_PXN, PTE_S2_RDWR)
> +#define PAGE_S2			_MOD_PROT(pgprot_s2, PTE_USER | PTE_S2_RDONLY)
> +#define PAGE_S2_DEVICE		_MOD_PROT(pgprot_s2_device, PTE_USER | PTE_S2_RDWR)

Beware, you are reintroducing a bug I fixed a while ago (Stage-2 has no
USER bit).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
