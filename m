From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Jan 2011 08:45:17 +0000
Subject: [PATCH 1/4] ARM: runtime patching of __virt_to_phys() and
	__phys_to_virt()
In-Reply-To: <1294129208-15201-2-git-send-email-nico@fluxnic.net>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<1294129208-15201-2-git-send-email-nico@fluxnic.net>
Message-ID: <20110104084517.GA9791@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is basically my patch with a few blank lines removed, a couple
of \n's also removed, a #error if __virt_to_phys is defined by a platform,
a minor tweak to the assembly and it being only usable on PXA.

I much prefer my patch over this as anyone can use it.  That's one of
the reasons why I arranged the code testing for __virt_to_phys as I
did, so the config option could be offered without having a big long
dependency list attached to it.

On Tue, Jan 04, 2011 at 03:20:05AM -0500, Nicolas Pitre wrote:
> On ARM it is common to find different offsets for the location of
> physical memory.  In order to support multiple machine types with
> a single kernel binary, we need to make PHYS_OFFSET a variable.
> But turning PHYS_OFFSET into a global variable would  impact performance
> of many hot paths.
> 
> In the context of __virt_to_phys() and __phys_to_virt(), we currently have:
> 
> 	#define __virt_to_phys(x)  ((x) - PAGE_OFFSET + PHYS_OFFSET)
> 
> This normally translates into the following assembly instruction:
> 
> 	add	rx, rx, #(PHYS_OFFSET - PAGE_OFFSET)
> 
> If we can assume that the difference between PHYS_OFFSET and PAGE_OFFSET
> will always fit into 8 bits shifted to the MSBs, then we can easily patch
> this difference into the corresponding assembly instructions at run time.
> This is like saying that phys and virt offsets will always be at least
> 16 MB aligned which is a pretty safe assumption.
> 
> So the idea is to create a table of pointers to all those add instructions,
> and have the early boot code to walk and patch them up before the kernel
> gets to use them.  Result is equivalent to a variable PHYS_OFFSET with
> next to zero performance impact compared to the constant PHYS_OFFSET.
> 
> Right now, the difference between PHYS_OFFSET and PAGE_OFFSET is determined
> by the actual physical address the kernel is executing from upon start,
> assuming that the kernel is located within the first 16 MB of RAM.
> 
> Thanks to Eric Miao and Russell King for their contributions to this patch.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
>  arch/arm/Kconfig              |    5 ++++
>  arch/arm/include/asm/memory.h |   51 +++++++++++++++++++++++++++++++++--------
>  arch/arm/kernel/head.S        |   35 ++++++++++++++++++++++++++++
>  arch/arm/kernel/vmlinux.lds.S |    4 +++
>  4 files changed, 85 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d56d21c0..136ed9b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -187,6 +187,11 @@ config VECTORS_BASE
>  	help
>  	  The base address of exception vectors.
>  
> +config ARM_PATCH_PHYS_VIRT
> +	bool
> +	depends on EXPERIMENTAL
> +	depends on !XIP && !THUMB2_KERNEL
> +
>  source "init/Kconfig"
>  
>  source "kernel/Kconfig.freezer"
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 23c2e8e..2783ce2 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -133,16 +133,6 @@
>  #endif
>  
>  /*
> - * Physical vs virtual RAM address space conversion.  These are
> - * private definitions which should NOT be used outside memory.h
> - * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
> - */
> -#ifndef __virt_to_phys
> -#define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
> -#define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
> -#endif
> -
> -/*
>   * Convert a physical address to a Page Frame Number and back
>   */
>  #define	__phys_to_pfn(paddr)	((paddr) >> PAGE_SHIFT)
> @@ -157,6 +147,47 @@
>  #ifndef __ASSEMBLY__
>  
>  /*
> + * Physical vs virtual RAM address space conversion.  These are
> + * private definitions which should NOT be used outside memory.h
> + * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
> + */
> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
> +
> +#ifdef __virt_to_phys
> +#error "this machine configuration uses complex __virt_to_phys/__phys_to_virt and cannot use CONFIG_ARM_PATCH_PHYS_VIRT"
> +#endif
> +
> +#define __pv_stub(from,to,instr)			\
> +	__asm__(					\
> +	"1:	" instr "\t%0, %1, %2\n"		\
> +	"	.pushsection .pv_table,\"a\"\n"		\
> +	"	.long	1b\n"				\
> +	"	.popsection"				\
> +	: "=r" (to)					\
> +	: "r" (from), "I" (1))
> +
> +static inline unsigned long __virt_to_phys(unsigned long x)
> +{
> +	unsigned long t;
> +
> +	__pv_stub(x, t, "add");
> +	return t;
> +}
> +
> +static inline unsigned long __phys_to_virt(unsigned long x)
> +{
> +	unsigned long t;
> +
> +	__pv_stub(x, t, "sub");
> +	return t;
> +}
> +
> +#else
> +#define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
> +#define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
> +#endif
> +
> +/*
>   * The DMA mask corresponding to the maximum bus address allocatable
>   * using GFP_DMA.  The default here places no restriction on DMA
>   * allocations.  This must be the smallest DMA mask in the system,
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 6bd82d2..eaaf0ad 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -95,6 +95,9 @@ ENTRY(stext)
>  #ifdef CONFIG_SMP_ON_UP
>  	bl	__fixup_smp
>  #endif
> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
> +	bl	__fixup_pv_table
> +#endif
>  	bl	__create_page_tables
>  
>  	/*
> @@ -433,4 +436,36 @@ smp_on_up:
>  
>  #endif
>  
> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
> +
> +/* __fixup_pv_table - patch the stub instructions with the delta between
> + * PHYS_OFFSET and PAGE_OFFSET, which is assumed to be 16MiB aligned and
> + * can be expressed by an immediate shifter operand. The stub instruction
> + * has a form of '(add|sub) rd, rn, #imm'.
> + */
> +__fixup_pv_table:
> +	adr	r0, 1f
> +	ldmia	r0, {r3-r5}
> +	sub	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
> +	mov	r6, r3, lsr #24	@ constant for add/sub instructions
> +	teq	r3, r6, lsl #24 @ must be 16MiB aligned
> +	bne	__error
> +	orr	r6, r6, #0x400	@ mask in rotate right 8 bits
> +	add	r4, r4, r3
> +	add	r5, r5, r3
> +2:	cmp	r4, r5
> +	ldrlo	r7, [r4], #4
> +	ldrlo	ip, [r7, r3]
> +	mov	ip, ip, lsr #12
> +	orr	ip, r6, ip, lsl #12
> +	strlo	ip, [r7, r3]
> +	blo	2b
> +	mov	pc, lr
> +ENDPROC(__fixup_phys_virt)
> +
> +1:	.word	.
> +	.word	__pv_table_begin
> +	.word	__pv_table_end
> +#endif
> +
>  #include "head-common.S"
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index cead889..fb32c9d 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -57,6 +57,10 @@ SECTIONS
>  		__smpalt_end = .;
>  #endif
>  
> +		__pv_table_begin = .;
> +			*(.pv_table)
> +		__pv_table_end = .;
> +
>  		INIT_SETUP(16)
>  
>  		INIT_CALLS
> -- 
> 1.7.3.2.193.g78bbb
> 
