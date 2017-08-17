From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Aug 2017 14:27:42 +0100
Subject: [PATCH 4/6] arm64: Move PTE_RDONLY bit handling out of
 set_pte_at()
In-Reply-To: <20170725135308.18173-5-catalin.marinas@arm.com>
References: <20170725135308.18173-1-catalin.marinas@arm.com>
 <20170725135308.18173-5-catalin.marinas@arm.com>
Message-ID: <20170817132742.GA29194@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 02:53:06PM +0100, Catalin Marinas wrote:
> Currently PTE_RDONLY is treated as a hardware only bit and not handled
> by the pte_mkwrite(), pte_wrprotect() or the user PAGE_* definitions.
> The set_pte_at() function is responsible for setting this bit based on
> the write permission or dirty state. This patch moves the PTE_RDONLY
> handling out of set_pte_at into the pte_mkwrite()/pte_wrprotect()
> functions. The PAGE_* definitions to need to be updated to explicitly
> include PTE_RDONLY when !PTE_WRITE.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/pgtable-prot.h | 12 ++++++------
>  arch/arm64/include/asm/pgtable.h      | 34 ++++++++++------------------------
>  arch/arm64/kernel/hibernate.c         |  4 ++--
>  arch/arm64/mm/fault.c                 |  6 +-----
>  4 files changed, 19 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index 2142c7726e76..9b7af598b375 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -63,14 +63,14 @@
>  #define PAGE_S2			__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY)
>  #define PAGE_S2_DEVICE		__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_UXN)
>  
> -#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_PXN | PTE_UXN)
> +#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_PXN | PTE_UXN)
>  #define PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
>  #define PAGE_SHARED_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_WRITE)
> -#define PAGE_COPY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
> -#define PAGE_COPY_EXEC		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
> -#define PAGE_READONLY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
> -#define PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN)
> -#define PAGE_EXECONLY		__pgprot(_PAGE_DEFAULT | PTE_NG | PTE_PXN)
> +#define PAGE_COPY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
> +#define PAGE_COPY_EXEC		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN)
> +#define PAGE_READONLY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
> +#define PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN)
> +#define PAGE_EXECONLY		__pgprot(_PAGE_DEFAULT | PTE_RDONLY | PTE_NG | PTE_PXN)

What's the point in keeping both the COPY and the READONLY variants of these
macros now that they're identical?

Will
