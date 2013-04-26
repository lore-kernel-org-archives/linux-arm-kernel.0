From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Apr 2013 18:01:52 +0100
Subject: [PATCH v3 02/32] arm64: KVM: define HYP and Stage-2
 translation page flags
In-Reply-To: <1365437854-30214-3-git-send-email-marc.zyngier@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130426170152.GD11311@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 05:17:04PM +0100, Marc Zyngier wrote:
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 75fd13d..acb4ee5 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -68,6 +69,18 @@
>  #define PTE_ATTRINDX_MASK	(_AT(pteval_t, 7) << 2)
>  
>  /*
> + * 2nd stage PTE definitions
> + */
> +#define PTE_S2_RDONLY		 (_AT(pteval_t, 1) << 6)   /* HAP[1]   */
> +#define PTE_S2_RDWR		 (_AT(pteval_t, 2) << 6)   /* HAP[2:1] */

RDWR should be 3 here (already the case in arch/arm). BTW, I would use
HAP[2:1] comment in both cases since that's the attribute field.

> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index e333a24..7c84ab4 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -76,6 +76,12 @@ extern pgprot_t pgprot_default;
>  #define PAGE_KERNEL		_MOD_PROT(pgprot_default, PTE_PXN | PTE_UXN | PTE_DIRTY)
>  #define PAGE_KERNEL_EXEC	_MOD_PROT(pgprot_default, PTE_UXN | PTE_DIRTY)
>  
> +#define PAGE_HYP		_MOD_PROT(pgprot_default, PTE_HYP)
> +#define PAGE_HYP_DEVICE		_MOD_PROT(__pgprot(PROT_DEVICE_nGnRE), PTE_HYP)
> +
> +#define PAGE_S2			_MOD_PROT(pgprot_default, PTE_USER | PTE_S2_RDONLY)

Why is this one read-only by default?

> +#define PAGE_S2_DEVICE		_MOD_PROT(__pgprot(PROT_DEVICE_nGnRE), PTE_USER | PTE_S2_RDWR)

You could write it directly as __pgprot(PROT_DEVICE_nGnRE | PTE_USER | PTE_S2_RDWR)

-- 
Catalin
