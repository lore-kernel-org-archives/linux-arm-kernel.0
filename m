From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jun 2016 16:29:12 +0100
Subject: [PATCH 5/5] arm/arm64: KVM: Make default HYP mappings
 non-excutable
In-Reply-To: <1465826449-14349-6-git-send-email-marc.zyngier@arm.com>
References: <1465826449-14349-1-git-send-email-marc.zyngier@arm.com>
 <1465826449-14349-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160613152911.GC29783@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Nit: typo in subject "excutable" is missing an 'e'.

Mark.

On Mon, Jun 13, 2016 at 03:00:49PM +0100, Marc Zyngier wrote:
> Structures that can be generally written to don't have any requirement
> to be executable (quite the opposite). This includes the kvm and vcpu
> structures, as well as the stacks.
> 
> Let's change the default to incorporate the XN flag.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/pgtable.h        | 2 +-
>  arch/arm64/include/asm/pgtable-prot.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 7487bf9..e0d76ba 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -97,7 +97,7 @@ extern pgprot_t		pgprot_s2_device;
>  #define PAGE_READONLY_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY)
>  #define PAGE_KERNEL		_MOD_PROT(pgprot_kernel, L_PTE_XN)
>  #define PAGE_KERNEL_EXEC	pgprot_kernel
> -#define PAGE_HYP		_MOD_PROT(pgprot_kernel, L_PTE_HYP)
> +#define PAGE_HYP		_MOD_PROT(pgprot_kernel, L_PTE_HYP | L_PTE_XN)
>  #define PAGE_HYP_EXEC		_MOD_PROT(pgprot_kernel, L_PTE_HYP | L_PTE_RDONLY)
>  #define PAGE_HYP_RO		_MOD_PROT(pgprot_kernel, L_PTE_HYP | L_PTE_RDONLY | L_PTE_XN)
>  #define PAGE_HYP_DEVICE		_MOD_PROT(pgprot_hyp_device, L_PTE_HYP)
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index 3802048..39f5252 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -55,7 +55,7 @@
>  #define PAGE_KERNEL_EXEC	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
>  #define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
>  
> -#define PAGE_HYP		__pgprot(_PAGE_DEFAULT | PTE_HYP)
> +#define PAGE_HYP		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_HYP_XN)
>  #define PAGE_HYP_EXEC		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
>  #define PAGE_HYP_RO		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY | PTE_HYP_XN)
>  #define PAGE_HYP_DEVICE		__pgprot(PROT_DEVICE_nGnRE | PTE_HYP)
> -- 
> 2.1.4
> 
