From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 15 Aug 2013 16:09:39 +0100
Subject: [PATCH 2/3] ARM: fix BUG() detection
In-Reply-To: <1376498563-8146-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1376498563-8146-1-git-send-email-ben.dooks@codethink.co.uk>
 <1376498563-8146-3-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130815150939.GC4103@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 05:42:42PM +0100, Ben Dooks wrote:
> The detection of the instruction used by BUG() did not take into account
> the differences in endian-ness between instruction and data. Change the
> code to use the relevant helpers in <asm/opcodes.h> to translate the
> endian-ness of the instructions.
> 
> Fixes issue reported by Dave Martin <Dave.Martin@arm.com>

It probably makes sense to fold this with the preceding patch.

> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/include/asm/bug.h |   10 ++++++----
>  arch/arm/kernel/traps.c    |    8 +++++---
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
> index b95da52..b274bde 100644
> --- a/arch/arm/include/asm/bug.h
> +++ b/arch/arm/include/asm/bug.h
> @@ -2,6 +2,8 @@
>  #define _ASMARM_BUG_H
>  
>  #include <linux/linkage.h>
> +#include <linux/types.h>
> +#include <asm/opcodes.h>
>  
>  #ifdef CONFIG_BUG
>  
> @@ -12,10 +14,10 @@
>   */
>  #ifdef CONFIG_THUMB2_KERNEL
>  #define BUG_INSTR_VALUE 0xde02
> -#define BUG_INSTR_TYPE ".inst.w "
> +#define BUG_INSTR(__value) __inst_thumb16(__value)
>  #else
>  #define BUG_INSTR_VALUE 0xe7f001f2
> -#define BUG_INSTR_TYPE ".inst "
> +#define BUG_INSTR(__value) __inst_arm(__value)
>  #endif

Looks OK.  You could make things a bit less verbose by

	#define BUG_INSTR __inst_thumb16(BUG_INSTR_VALUE)
#else
...
	#define BUG_INSTR __inst_arm(BUG_INSTR_VALUE)

>  
>  
> @@ -33,7 +35,7 @@
>  
>  #define __BUG(__file, __line, __value)				\
>  do {								\
> -	asm volatile("1:\t" BUG_INSTR_TYPE #__value "\n"	\
> +	asm volatile("1:\t" BUG_INSTR(__value) "\n"  \
>  		".pushsection .rodata.str, \"aMS\", %progbits, 1\n" \
>  		"2:\t.asciz " #__file "\n" 			\
>  		".popsection\n" 				\
> @@ -48,7 +50,7 @@ do {								\
>  
>  #define __BUG(__file, __line, __value)				\
>  do {								\
> -	asm volatile(BUG_INSTR_TYPE #__value);			\
> +	asm volatile(BUG_INSTR(__value) "\n");			\
>  	unreachable();						\
>  } while (0)
>  #endif  /* CONFIG_DEBUG_BUGVERBOSE */
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index cb67b04..ae2d828 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -344,15 +344,17 @@ void arm_notify_die(const char *str, struct pt_regs *regs,
>  int is_valid_bugaddr(unsigned long pc)
>  {
>  #ifdef CONFIG_THUMB2_KERNEL
> -	unsigned short bkpt;
> +	u16 bkpt;
> +	u16 insn = __opcode_to_mem_thumb16(BUG_INSTR_VALUE);
>  #else
> -	unsigned long bkpt;
> +	u32 bkpt;
> +	u32 insn = __opcode_to_mem_arm(BUG_INSTR_VALUE);
>  #endif
>  
>  	if (probe_kernel_address((unsigned *)pc, bkpt))

Hmm, the (unsigned *) actually looks weird here now I look at it.

probe_kernel_address does (__force typeof(bkpt) __user *) on it anyway,
so I guess that's harmless.  void * might make more sense, though this
patch may not be the place to fix it.

Cheers
---Dave

>  		return 0;
>  
> -	return bkpt == BUG_INSTR_VALUE;
> +	return bkpt == insn;
>  }
>  
>  #endif
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
