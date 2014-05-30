From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 May 2014 18:20:54 +0100
Subject: [PATCH v2 2/7] ARM: Introduce arm_get_current_stack_frame()
In-Reply-To: <1401469191-29232-3-git-send-email-nikolay.borisov@arm.com>
References: <1401469191-29232-1-git-send-email-nikolay.borisov@arm.com>
 <1401469191-29232-3-git-send-email-nikolay.borisov@arm.com>
Message-ID: <20140530172054.GE22895@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 05:59:46PM +0100, Nikolay Borisov wrote:
> From: Nikolay Borisov <Nikolay.Borisov@arm.com>
> 
> Currently there are numerous places where "struct pt_regs" are used to
> populate "struct stackframe", however all of those location do not
> consider the situation where the kernel might be compiled in THUMB2
> mode, in which case the framepointer member of pt_regs become ARM_r7
> instead of ARM_fp (r11). Document this idiosyncracy in the
> definition of "struct stackframe"
> 
> The easiest solution is to introduce a new function (in the spirit of
> https://groups.google.com/forum/#!topic/linux.kernel/dA2YuUcSpZ4)
> which would hide the complexity of initializing the stackframe struct
> from pt_regs.
> 
> Also implement a macro frame_pointer(regs) that would return the correct
> register so that we can use it in cases where we just require the frame
> pointer and not a whole struct stackframe
> 
> Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
> ---
>  arch/arm/include/asm/ptrace.h     |  6 ++++++
>  arch/arm/include/asm/stacktrace.h | 12 ++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
> index c877654..601264d 100644
> --- a/arch/arm/include/asm/ptrace.h
> +++ b/arch/arm/include/asm/ptrace.h
> @@ -84,6 +84,12 @@ static inline long regs_return_value(struct pt_regs *regs)
>  
>  #define instruction_pointer(regs)	(regs)->ARM_pc
>  
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define frame_pointer(regs) (regs)->ARM_r7
> +#else
> +#define frame_pointer(regs) (regs)->ARM_fp
> +#endif
> +
>  static inline void instruction_pointer_set(struct pt_regs *regs,
>  					   unsigned long val)
>  {
> diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
> index 4d0a164..6a5b13e 100644
> --- a/arch/arm/include/asm/stacktrace.h
> +++ b/arch/arm/include/asm/stacktrace.h
> @@ -2,12 +2,24 @@
>  #define __ASM_STACKTRACE_H
>  
>  struct stackframe {
> +	/* FP member should hold R7 when CONFIG_THUMB2_KERNEL is enabled.
> +	 * and R11 otherwise
> +	 */

Very minor nit: please reformat the comment like:

	/*
	 * FP member should hold R7 when CONFIG_THUMB2_KERNEL is enabled
	 * and R11 otherwise.
	 */

for consistency with the rest of the kernel (I also moved the full-stop to
the end of the sentence).

With that:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
