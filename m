From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 30 Jan 2012 16:54:22 +0000
Subject: [PATCHv2 2/6] ARM: ftrace: use canonical Thumb-2 wide
 instruction format
In-Reply-To: <1327757725-10114-3-git-send-email-rabin@rab.in>
References: <1327757725-10114-1-git-send-email-rabin@rab.in>
 <1327757725-10114-3-git-send-email-rabin@rab.in>
Message-ID: <20120130165421.GC2248@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2012 at 07:05:21PM +0530, Rabin Vincent wrote:
> As commit 592201a9f15 (ARM: Thumb-2: Support Thumb-2 in undefined
> instruction handler) says:
> 
>     32-bit Thumb instructions are specified in the form:
>         ((first_half << 16 ) | second_half)
>     which matches the layout used by the ARM ARM.
> 
> Convert the ftrace code to use the same format to avoid the usage of
> different formats in kernel code.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Acked-by: Dave Martin <dave.martin@linaro.org>

I haven't tried it out, but the use of the opcode helpers looks correct.

Cheers
---Dave

> ---
>  arch/arm/kernel/ftrace.c |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index e9488ad..72a381a 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -16,10 +16,11 @@
>  #include <linux/uaccess.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/opcodes.h>
>  #include <asm/ftrace.h>
>  
>  #ifdef CONFIG_THUMB2_KERNEL
> -#define	NOP		0xeb04f85d	/* pop.w {lr} */
> +#define	NOP		0xf85deb04	/* pop.w {lr} */
>  #else
>  #define	NOP		0xe8bd4000	/* pop {lr} */
>  #endif
> @@ -88,7 +89,7 @@ static unsigned long ftrace_gen_branch(unsigned long pc, unsigned long addr,
>  	if (link)
>  		second |= 1 << 14;
>  
> -	return (second << 16) | first;
> +	return __opcode_thumb32_compose(first, second);
>  }
>  #else
>  static unsigned long ftrace_gen_branch(unsigned long pc, unsigned long addr,
> @@ -125,6 +126,14 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
>  {
>  	unsigned long replaced;
>  
> +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> +		old = __opcode_to_mem_thumb32(old);
> +		new = __opcode_to_mem_thumb32(new);
> +	} else {
> +		old = __opcode_to_mem_arm(old);
> +		new = __opcode_to_mem_arm(new);
> +	}
> +
>  	if (old) {
>  		if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
>  			return -EFAULT;
> -- 
> 1.7.8.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
