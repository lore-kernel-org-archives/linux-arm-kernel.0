From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Tue, 7 Jun 2016 09:34:50 +0900
Subject: [PATCH v13 06/10] arm64: Treat all entry code as non-kprobe-able
In-Reply-To: <1464924384-15269-7-git-send-email-dave.long@linaro.org>
References: <1464924384-15269-1-git-send-email-dave.long@linaro.org>
 <1464924384-15269-7-git-send-email-dave.long@linaro.org>
Message-ID: <20160607093450.05bd4105957b0beaa4190167@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  2 Jun 2016 23:26:20 -0400
David Long <dave.long@linaro.org> wrote:

> From: Pratyush Anand <panand@redhat.com>
> 
> Entry symbols are not kprobe safe. So blacklist them for kprobing.
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> Signed-off-by: David A. Long <dave.long@linaro.org>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> ---
>  arch/arm64/kernel/entry.S       |  3 +++
>  arch/arm64/kernel/kprobes.c     | 26 ++++++++++++++++++++++++++
>  arch/arm64/kernel/vmlinux.lds.S |  1 +
>  3 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 12e8d2b..7d99bed 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -243,6 +243,7 @@ tsk	.req	x28		// current thread_info
>   * Exception vectors.
>   */
>  
> +	.pushsection ".entry.text", "ax"
>  	.align	11
>  ENTRY(vectors)
>  	ventry	el1_sync_invalid		// Synchronous EL1t
> @@ -781,3 +782,5 @@ ENTRY(sys_rt_sigreturn_wrapper)
>  	mov	x0, sp
>  	b	sys_rt_sigreturn
>  ENDPROC(sys_rt_sigreturn_wrapper)
> +
> +	.popsection
> diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
> index 49b06cf..ba43623 100644
> --- a/arch/arm64/kernel/kprobes.c
> +++ b/arch/arm64/kernel/kprobes.c
> @@ -30,6 +30,7 @@
>  #include <asm/insn.h>
>  #include <asm/uaccess.h>
>  #include <asm/irq.h>
> +#include <asm-generic/sections.h>
>  
>  #include "kprobes-arm64.h"
>  
> @@ -520,6 +521,31 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>  	return 1;
>  }
>  
> +bool arch_within_kprobe_blacklist(unsigned long addr)
> +{
> +	extern char __idmap_text_start[], __idmap_text_end[];
> +	extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
> +
> +	if ((addr >= (unsigned long)__kprobes_text_start &&
> +	    addr < (unsigned long)__kprobes_text_end) ||
> +	    (addr >= (unsigned long)__entry_text_start &&
> +	    addr < (unsigned long)__entry_text_end) ||
> +	    (addr >= (unsigned long)__idmap_text_start &&
> +	    addr < (unsigned long)__idmap_text_end) ||
> +	    !!search_exception_tables(addr))
> +		return true;
> +
> +	if (!is_kernel_in_hyp_mode()) {
> +		if ((addr >= (unsigned long)__hyp_text_start &&
> +		    addr < (unsigned long)__hyp_text_end) ||
> +		    (addr >= (unsigned long)__hyp_idmap_text_start &&
> +		    addr < (unsigned long)__hyp_idmap_text_end))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  int __init arch_init_kprobes(void)
>  {
>  	return 0;
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 075ce32..9f59394 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -118,6 +118,7 @@ SECTIONS
>  			__exception_text_end = .;
>  			IRQENTRY_TEXT
>  			SOFTIRQENTRY_TEXT
> +			ENTRY_TEXT
>  			TEXT_TEXT
>  			SCHED_TEXT
>  			LOCK_TEXT
> -- 
> 2.5.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
