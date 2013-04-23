From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 23 Apr 2013 09:45:51 +0200
Subject: [PATCH] ARM: mm: Get rid of
 =?UTF-8?Q?L=5FPTE=5FUSER=20ref=20from=20P?=
 =?UTF-8?Q?AGE=5FS=32=5FDEVICE?=
In-Reply-To: <1366683430-24328-1-git-send-email-cdall@cs.columbia.edu>
References: <1366683430-24328-1-git-send-email-cdall@cs.columbia.edu>
Message-ID: <062dea0374552dcb48be3687ae95262d@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Apr 2013 19:17:10 -0700, Christoffer Dall
<cdall@cs.columbia.edu> wrote:
> THe L_PTE_USER actually has nothing to do with stage 2 mappings and the
> L_PTE_S2_RDONLY value sets the readable bit, which was what L_PTE_USER
> was used for before proper handling of stage 2 memory defines.
> 
> Signed-off-by: Christoffer Dall <cdall@cs.columbia.edu>
> ---
>  arch/arm/include/asm/pgtable.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/pgtable.h
> b/arch/arm/include/asm/pgtable.h
> index 80d6fc4..1d1f97f 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -88,7 +88,7 @@ extern pgprot_t		pgprot_s2_device;
>  #define PAGE_HYP		_MOD_PROT(pgprot_kernel, L_PTE_HYP)
>  #define PAGE_HYP_DEVICE		_MOD_PROT(pgprot_hyp_device, L_PTE_HYP)
>  #define PAGE_S2			_MOD_PROT(pgprot_s2, L_PTE_S2_RDONLY)
> -#define PAGE_S2_DEVICE		_MOD_PROT(pgprot_s2_device, L_PTE_USER |
> L_PTE_S2_RDONLY)
> +#define PAGE_S2_DEVICE		_MOD_PROT(pgprot_s2_device, L_PTE_S2_RDONLY)
>  
>  #define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_RDONLY | L_PTE_XN
|
>  L_PTE_NONE)
>  #define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)

Good catch.

While we're at it, why not directly set it to be RW instead of RO? The
only use of PAGE_S2_DEVICE immediately sets the writeable bit anyway.

        M.
-- 
Fast, cheap, reliable. Pick two.
