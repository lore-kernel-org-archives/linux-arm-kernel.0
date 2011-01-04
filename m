From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Jan 2011 16:41:34 -0500 (EST)
Subject: [RFC 5/5] ARM: P2V: extend to 16-bit translation offsets
In-Reply-To: <E1PaDPu-00023p-QG@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDPu-00023p-QG@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101041628060.22191@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jan 2011, Russell King - ARM Linux wrote:

> MSM's memory is aligned to 2MB, which is more than we can do with our
> existing method as we're limited to the upper 8 bits.  Extend this by
> using two instructions to 16 bits, automatically selected when MSM is
> enabled.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/Kconfig              |    5 ++++-
>  arch/arm/include/asm/memory.h |   14 ++++++++++----
>  arch/arm/kernel/head.S        |   18 ++++++++++++++++--
>  3 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 801192b..8a753cb 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -200,7 +200,6 @@ config ARM_PATCH_PHYS_VIRT
>  	bool "Patch physical to virtual translations at runtime (EXPERIMENTAL)"
>  	depends on EXPERIMENTAL
>  	depends on !XIP_KERNEL && !THUMB2_KERNEL && MMU
> -	depends on !ARCH_MSM
>  	depends on !ARCH_REALVIEW || !SPARSEMEM
>  	help
>  	  Patch phys-to-virt translation functions at runtime according to
> @@ -209,6 +208,10 @@ config ARM_PATCH_PHYS_VIRT
>  	  This can only be used with non-XIP, non-Thumb2, MMU kernels where
>  	  the base of physical memory is at a 16MB boundary.
>  
> +config ARM_PATCH_PHYS_VIRT_16BIT
> +	def_bool y
> +	depends on ARM_PATCH_PHYS_VIRT && ARCH_MSM
> +
>  source "init/Kconfig"
>  
>  source "kernel/Kconfig.freezer"
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 288b690..e2b54fd 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -157,26 +157,32 @@
>  extern unsigned long __pv_phys_offset;
>  #define PHYS_OFFSET __pv_phys_offset
>  
> -#define __pv_stub(from,to,instr)			\
> +#define __pv_stub(from,to,instr,type)			\
>  	__asm__("@ __pv_stub\n"				\
>  	"1:	" instr "	%0, %1, %2\n"		\
>  	"	.pushsection .pv_table,\"a\"\n"		\
>  	"	.long	1b\n"				\
>  	"	.popsection\n"				\
>  	: "=r" (to)					\
> -	: "r" (from), "I" (1))
> +	: "r" (from), "I" (type))
>  
>  static inline unsigned long __virt_to_phys(unsigned long x)
>  {
>  	unsigned long t;
> -	__pv_stub(x, t, "add");
> +	__pv_stub(x, t, "add", 1);
> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
> +	__pv_stub(t, t, "add", 0);
> +#endif
[...]

I'd suggest making the type argument into a mask instead, something 
like:

	__pv_stub(x, t, "add", 0xff000000);
#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
	__pv_stub(t, t, "add", 0x00ff0000);
#endif

Reasons for this are multiple:

 - This would simplifies the patching code as the rotation bitfield in 
   the instruction would already be set appropriately for the desired 
   value by the assembler.  Would only suffice to test one bit in that 
   field to determine the required constant to patch in.

 - For the Thumb2 build, we want the assembler to select the appropriate 
   encoding flavor for the add instruction from all the possibilities.  
   Giving it a constant with all bits set nicely solves this issue.

If further distinctions are needed in the future then we can use the 6 
middle bits to encode alternatives.


Nicolas
