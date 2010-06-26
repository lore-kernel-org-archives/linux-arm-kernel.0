From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 Jun 2010 10:54:20 +0100
Subject: [PATCH] [ARM] Introduce patching of phys_to_virt and vice versa
In-Reply-To: <1277542025-19881-1-git-send-email-eric.miao@canonical.com>
References: <1277542025-19881-1-git-send-email-eric.miao@canonical.com>
Message-ID: <20100626095420.GA10340@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mostly like this patch, but there's a couple of issues with it which
can be worked around by documentation...

On Sat, Jun 26, 2010 at 04:47:05PM +0800, eric.miao at canonical.com wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1f254bd..0c171c2 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -189,6 +189,9 @@ config VECTORS_BASE
>  	help
>  	  The base address of exception vectors.
>  
> +config PATCH_PHYS_VIRT

ARM_PATCH_PHYS_TO_VIRT might be a better name?

> +	def_bool n
> +
>  source "init/Kconfig"
>  
>  source "kernel/Kconfig.freezer"
> @@ -579,6 +582,7 @@ config ARCH_PXA
>  	select GENERIC_CLOCKEVENTS
>  	select TICK_ONESHOT
>  	select PLAT_PXA
> +	select PATCH_PHYS_VIRT if !XIP_KERNEL

It needs to be documented that PATCH_PHYS_VIRT is only for non-XIP and
non-Thumb2 kernels.  I suggest it goes in the help text for the config
option, or a comment before the option.

>  	help
>  	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
>  
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 4312ee5..a5f84bc 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -173,6 +173,37 @@
>   */
>  #define PHYS_PFN_OFFSET	(PHYS_OFFSET >> PAGE_SHIFT)
>  
> +#ifdef CONFIG_PATCH_PHYS_VIRT
> +
> +#define PATCH_TYPE_PHYS_TO_VIRT		(0)
> +#define PATCH_TYPE_VIRT_TO_PHYS		(1)
> +
> +#define __patch_stub(from,to,type)			\
> +	__asm__ __volatile__(				\
> +	"1:	add	%0, %1, %2\n"			\
> +	"\n"						\
> +	"	.pushsection __patch_table,\"a\"\n"	\
> +	"	.long	1b\n"				\
> +	"	.popsection\n"				\
> +	: "=r" (to)					\
> +	: "r" (from), "i" (type))

This should be "I" not "i":

    `I'
          Integer that is valid as an immediate operand in a data
          processing instruction.  That is, an integer in the range 0
          to 255 rotated by a multiple of 2

which is what 'add' takes.  "i" means any integer of any size.

> +/* patch_phys_virt - patch the stub instructions with the delta between
> + * PHYS_OFFSET and PAGE_OFFSET, which is assumed to be 16MiB aligned and
> + * can be expressed by an immediate shifter operand. The stub instruction
> + * has a form of 'add rn, rd, #imm', where the lowest 8-bit of #imm is

'add rd, rn, #imm'

> + * used to identify the type of patching.
> + */
> +static void __init patch_phys_virt(void)
> +{
> +	extern unsigned int *__patch_table_begin, *__patch_table_end;
> +	unsigned int **p;
> +	unsigned int imm, instr[2];
> +
> +	if (PHYS_OFFSET & 0x00ffffff)
> +		panic("Physical memory start is not 16MiB aligned\n");
> +
> +	if (likely(PHYS_OFFSET < PAGE_OFFSET)) {
> +		imm = 0x400 | ((PAGE_OFFSET >> 24) - (PHYS_OFFSET >> 24));
> +		instr[0] = PATCH_INSTR_ADD | imm;
> +		instr[1] = PATCH_INSTR_SUB | imm;
> +	} else {
> +		imm = 0x400 | ((PHYS_OFFSET >> 24) - (PAGE_OFFSET >> 24));
> +		instr[0] = PATCH_INSTR_SUB | imm;
> +		instr[1] = PATCH_INSTR_ADD | imm;
> +	}
> +
> +	for (p = &__patch_table_begin; p < &__patch_table_end; p++) {
> +		unsigned int *inptr = *p;
> +
> +		if ((*inptr & PATCH_STUB_MASK) == PATCH_STUB_PHYS_TO_VIRT)
> +			*inptr = (*inptr & ~0x00e00fff) | instr[0];
> +		if ((*inptr & PATCH_STUB_MASK) == PATCH_STUB_VIRT_TO_PHYS)
> +			*inptr = (*inptr & ~0x00e00fff) | instr[1];
> +	}
> +	flush_cache_all();

That's not a good idea before the page tables are setup - there is CPU
support which needs to read data in order to writeback dirty entries in
the cache.  (eg, StrongARM CPUs - which corresponds with ebsa110,
footbridge, rpc, sa1100, and shark.)

This mapping does not exist before paging_init() has completed - which
presents a catch-22 situation here.  This also needs to be documented
against the config option.
