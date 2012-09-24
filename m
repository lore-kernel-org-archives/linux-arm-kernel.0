From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Sep 2012 14:54:38 +0100
Subject: [PATCH v3 RESEND 06/17] ARM: LPAE: use signed arithmetic for
 mask definitions
In-Reply-To: <1348242975-19184-7-git-send-email-cyril@ti.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-7-git-send-email-cyril@ti.com>
Message-ID: <20120924135438.GC26454@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 11:56:04AM -0400, Cyril Chemparathy wrote:
> This patch applies to PAGE_MASK, PMD_MASK, and PGDIR_MASK, where forcing
> unsigned long math truncates the mask at the 32-bits.  This clearly does bad
> things on PAE systems.
> 
> This patch fixes this problem by defining these masks as signed quantities.
> We then rely on sign extension to do the right thing.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> Reviewed-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/include/asm/page.h           |    2 +-
>  arch/arm/include/asm/pgtable-3level.h |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
> index ecf9019..1e0fe08 100644
> --- a/arch/arm/include/asm/page.h
> +++ b/arch/arm/include/asm/page.h
> @@ -13,7 +13,7 @@
>  /* PAGE_SHIFT determines the page size */
>  #define PAGE_SHIFT		12
>  #define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
> -#define PAGE_MASK		(~(PAGE_SIZE-1))
> +#define PAGE_MASK		(~((1 << PAGE_SHIFT) - 1))

It's strange.  Every other platform in the kernel, including those with
PAE, manage to get away with defining PAGE_MASK as the original above
(see asm-generic/pgtable.h)  Why is ARM any different?

Note that PAGE_MASK gets used@the moment on ARM for both virtual and
physical addresses.  x86 has PHYSICAL_PAGE_MASK for masking physical
addresses.  Maybe we should adopt the same approach?

Whatever, I feel that we should not deviate from the established
definitions across every other architecture.

>  
>  #ifndef __ASSEMBLY__
>  
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index b249035..ae39d11 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -48,16 +48,16 @@
>  #define PMD_SHIFT		21
>  
>  #define PMD_SIZE		(1UL << PMD_SHIFT)
> -#define PMD_MASK		(~(PMD_SIZE-1))
> +#define PMD_MASK		(~((1 << PMD_SHIFT) - 1))
>  #define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
> -#define PGDIR_MASK		(~(PGDIR_SIZE-1))
> +#define PGDIR_MASK		(~((1 << PGDIR_SHIFT) - 1))
>  
>  /*
>   * section address mask and size definitions.
>   */
>  #define SECTION_SHIFT		21
>  #define SECTION_SIZE		(1UL << SECTION_SHIFT)
> -#define SECTION_MASK		(~(SECTION_SIZE-1))
> +#define SECTION_MASK		(~((1 << SECTION_SHIFT) - 1))

These masks are applied to a _virtual_ kernel address, not the physical
addresses,  Even with LPAE, the virtual address space is still 32-bit.

So this is definitely wrong.
