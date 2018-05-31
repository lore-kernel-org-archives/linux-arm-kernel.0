From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 May 2018 12:52:49 +0100
Subject: [PATCH v2 3/6] arm64: KVM: Avoid marking pages as XN in Stage-2
 if CTR_EL0.DIC is set
In-Reply-To: <20180530124706.25284-4-marc.zyngier@arm.com>
References: <20180530124706.25284-1-marc.zyngier@arm.com>
 <20180530124706.25284-4-marc.zyngier@arm.com>
Message-ID: <20180531115249.uit7ndw22ki32wm3@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 01:47:03PM +0100, Marc Zyngier wrote:
> On systems where CTR_EL0.DIC is set, we don't need to perform
> icache invalidation to guarantee that we'll fetch the right
> instruction stream.
> 
> This also means that taking a permission fault to invalidate the
> icache is an unnecessary overhead.
> 
> On such systems, we can safely leave the page as being executable.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/pgtable-prot.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index c66c3047400e..78b942c1bea4 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -77,8 +77,18 @@
>  		__val;							\
>  	 })
>  
> -#define PAGE_S2			__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(NORMAL) | PTE_S2_RDONLY | PTE_S2_XN)
> -#define PAGE_S2_DEVICE		__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_S2_XN)
> +#define PAGE_S2_XN							\
> +	({								\
> +		u64 __val;						\
> +		if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))		\
> +			__val = 0;					\
> +		else							\
> +			__val = PTE_S2_XN;				\
> +		__val;							\
> +	})
> +
> +#define PAGE_S2			__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(NORMAL) | PTE_S2_RDONLY | PAGE_S2_XN)
> +#define PAGE_S2_DEVICE		__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(DEVICE_nGnRE) | PTE_S2_RDONLY | PAGE_S2_XN)
>  
>  #define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
>  #define PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
> -- 
> 2.17.1
> 
