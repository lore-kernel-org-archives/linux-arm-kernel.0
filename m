From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 10 Dec 2013 12:17:30 -0700
Subject: Build breakage from 'ARM: mm: use phys_addr_t appropriately in
 p2v and v2p conversions'
In-Reply-To: <20131125233654.GV16735@n2100.arm.linux.org.uk>
References: <20131125223636.GA20822@obsidianresearch.com>
 <20131125232003.GU16735@n2100.arm.linux.org.uk>
 <20131125233654.GV16735@n2100.arm.linux.org.uk>
Message-ID: <20131210191730.GT5429@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 11:36:54PM +0000, Russell King - ARM Linux wrote:
 
> Actually, I think Nicolas' commit:
> 
> 1b9f95f8ade9efc2bd49f0e7b9dc61a038ac3eef
> 
> was wrong to remove PLAT_PHYS_OFFSET.  So, partially undoing Nicolas'
> patch, and reordering things a little, we end up with this, which if
> it weren't for the comment would be 5 lines shorter!

Not sure where this thread ended up, but:

Tested-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

On ARM kirkwood with 3.13-rc3

Regards,
Jason
 
>  arch/arm/include/asm/memory.h |   23 ++++++++++++-----------
>  arch/arm/kernel/head-nommu.S  |    4 ++--
>  arch/arm/kernel/head.S        |    2 +-
>  3 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 9ecccc865046..c7e0d708e911 100644
> +++ b/arch/arm/include/asm/memory.h
> @@ -157,6 +157,16 @@
>  #endif
>  #define ARCH_PGD_MASK		((1 << ARCH_PGD_SHIFT) - 1)
>  
> +/*
> + * PLAT_PHYS_OFFSET is the offset (from zero) of the start of physical
> + * memory.  This is used for XIP and NoMMU kernels, or by kernels which
> + * have their own mach/memory.h.  Assembly code must always use
> + * PLAT_PHYS_OFFSET and not PHYS_OFFSET.
> + */
> +#ifndef PLAT_PHYS_OFFSET
> +#define PLAT_PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
> +#endif
> +
>  #ifndef __ASSEMBLY__
>  
>  /*
> @@ -239,6 +249,8 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
>  
>  #else
>  
> +#define PHYS_OFFSET	PLAT_PHYS_OFFSET
> +
>  static inline phys_addr_t __virt_to_phys(unsigned long x)
>  {
>  	return (phys_addr_t)x - PAGE_OFFSET + PHYS_OFFSET;
> @@ -251,17 +263,6 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
>  
>  #endif
>  #endif
> -#endif /* __ASSEMBLY__ */
> -
> -#ifndef PHYS_OFFSET
> -#ifdef PLAT_PHYS_OFFSET
> -#define PHYS_OFFSET	PLAT_PHYS_OFFSET
> -#else
> -#define PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
> -#endif
> -#endif
> -
> -#ifndef __ASSEMBLY__
>  
>  /*
>   * PFNs are used to describe any physical page; this means
> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index 14235ba64a90..716249cc2ee1 100644
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -68,7 +68,7 @@ ENTRY(stext)
>  
>  #ifdef CONFIG_ARM_MPU
>  	/* Calculate the size of a region covering just the kernel */
> -	ldr	r5, =PHYS_OFFSET		@ Region start: PHYS_OFFSET
> +	ldr	r5, =PLAT_PHYS_OFFSET		@ Region start: PHYS_OFFSET
>  	ldr     r6, =(_end)			@ Cover whole kernel
>  	sub	r6, r6, r5			@ Minimum size of region to map
>  	clz	r6, r6				@ Region size must be 2^N...
> @@ -213,7 +213,7 @@ ENTRY(__setup_mpu)
>  	set_region_nr r0, #MPU_RAM_REGION
>  	isb
>  	/* Full access from PL0, PL1, shared for CONFIG_SMP, cacheable */
> -	ldr	r0, =PHYS_OFFSET		@ RAM starts at PHYS_OFFSET
> +	ldr	r0, =PLAT_PHYS_OFFSET		@ RAM starts at PHYS_OFFSET
>  	ldr	r5,=(MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL)
>  
>  	setup_region r0, r5, r6, MPU_DATA_SIDE	@ PHYS_OFFSET, shared, enabled
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 11d59b32fb8d..32f317e5828a 100644
> +++ b/arch/arm/kernel/head.S
> @@ -110,7 +110,7 @@ ENTRY(stext)
>  	sub	r4, r3, r4			@ (PHYS_OFFSET - PAGE_OFFSET)
>  	add	r8, r8, r4			@ PHYS_OFFSET
>  #else
> -	ldr	r8, =PHYS_OFFSET		@ always constant in this case
> +	ldr	r8, =PLAT_PHYS_OFFSET		@ always constant in this case
>  #endif
>  
>  	/*
>
