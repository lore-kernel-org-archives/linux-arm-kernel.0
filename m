From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 28 Aug 2013 17:48:46 +0100
Subject: [PATCH 17/19] ARM: Correct BUG() assembly to ensure it is
 endian-agnostic
In-Reply-To: <1377639509-22778-18-git-send-email-ben.dooks@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377639509-22778-18-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130828164846.GG3842@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 10:38:27PM +0100, Ben Dooks wrote:
> Currently BUG() uses .word or .hword to create the necessary illegal
> instructions. However if we are building BE8 then these get swapped
> by the linker into different illegal instructions in the text. This
> means that the BUG() macro does not get trapped properly.
> 
> Change to using <asm/opcodes.h> to provide the necessary ARM instruction
> building as we cannot rely on gcc/gas having the `.inst` instructions
> which where added to try and resolve this issue (reported by Dave Martin
> <Dave.Martin@arm.com>).

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/include/asm/bug.h |   10 ++++++----
>  arch/arm/kernel/traps.c    |    8 +++++---
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
> index 7af5c6c..b274bde 100644
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
> -#define BUG_INSTR_TYPE ".hword "
> +#define BUG_INSTR(__value) __inst_thumb16(__value)
>  #else
>  #define BUG_INSTR_VALUE 0xe7f001f2
> -#define BUG_INSTR_TYPE ".word "
> +#define BUG_INSTR(__value) __inst_arm(__value)
>  #endif
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
> index 99bcd0e3..da070db 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -342,15 +342,17 @@ void arm_notify_die(const char *str, struct pt_regs *regs,
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
