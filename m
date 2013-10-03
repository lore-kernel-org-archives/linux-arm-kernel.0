From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Oct 2013 17:53:13 +0100
Subject: [PATCH RFC v3 1/5] AArch64: Add single-step and breakpoint
 handler hooks
In-Reply-To: <1380643080-8984-2-git-send-email-sandeepa.prabhu@linaro.org>
References: <1380643080-8984-1-git-send-email-sandeepa.prabhu@linaro.org>
 <1380643080-8984-2-git-send-email-sandeepa.prabhu@linaro.org>
Message-ID: <20131003165312.GF7408@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 04:57:56PM +0100, Sandeepa Prabhu wrote:
> AArch64 Single Steping and Breakpoint debug exceptions will be
> used by multiple debug framworks like kprobes & kgdb.
> 
> This patch implements the hooks for those frameworks to register
> their own handlers for handling breakpoint and single step events.
> 
> Reworked the debug exception handler in entry.S: do_dbg to route
> software breakpoint (BRK64) exception to do_debug_exception()
> 
> Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
> ---
>  arch/arm64/include/asm/debug-monitors.h | 23 +++++++++
>  arch/arm64/kernel/debug-monitors.c      | 85 +++++++++++++++++++++++++++++++--
>  arch/arm64/kernel/entry.S               |  2 +
>  3 files changed, 107 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index a2232d0..8e354b3 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -16,6 +16,8 @@
>  #ifndef __ASM_DEBUG_MONITORS_H
>  #define __ASM_DEBUG_MONITORS_H
>  
> +#include <linux/rculist.h>
> +
>  #ifdef __KERNEL__
>  
>  #define	DBG_ESR_EVT(x)		(((x) >> 27) & 0x7)
> @@ -62,6 +64,27 @@ struct task_struct;
>  
>  #define DBG_ARCH_ID_RESERVED	0	/* In case of ptrace ABI updates. */
>  
> +#define DEBUG_HOOK_HANDLED	0
> +#define DEBUG_HOOK_ERROR	1

Cosmetic: we use DBG vs DEBUG in the rest of this header.

> +struct step_hook {
> +	struct list_head node;
> +	int (*fn)(struct pt_regs *regs, unsigned int esr);
> +};
> +
> +void register_step_hook(struct step_hook *hook);
> +void unregister_step_hook(struct step_hook *hook);
> +
> +struct break_hook {
> +	struct list_head node;
> +	u32 esr_val;
> +	u32 esr_mask;
> +	int (*fn)(struct pt_regs *regs, unsigned int esr);
> +};
> +
> +void register_break_hook(struct break_hook *hook);
> +void unregister_break_hook(struct break_hook *hook);
> +
>  u8 debug_monitors_arch(void);
>  
>  void enable_debug_monitors(enum debug_el el);
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index cbfacf7..fbbf824 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -188,6 +188,43 @@ static void clear_regs_spsr_ss(struct pt_regs *regs)
>  	regs->pstate = spsr;
>  }
>  
> +/* EL1 Single Step Handler hooks */
> +static LIST_HEAD(step_hook);
> +
> +void register_step_hook(struct step_hook *hook)
> +{
> +	list_add_rcu(&hook->node, &step_hook);
> +}

This isn't safe against concurrent registrations. Why don't you use an
rwlock instead? Then you take the writer lock here...

> +/*
> + * Call registered single step handers
> + * There is no Syndrome info to check for determining the handler.
> + * So we call all the registered handlers, until the right handler is
> + * found which returns zero.
> + */
> +static int call_step_hook(struct pt_regs *regs, unsigned int esr)
> +{
> +	struct step_hook *hook;
> +	int retval = DEBUG_HOOK_ERROR;
> +
> +	rcu_read_lock();

... and the reader lock here.

> +	list_for_each_entry_rcu(hook, &step_hook, node)	{
> +		retval = hook->fn(regs, esr);
> +		if (retval == DEBUG_HOOK_HANDLED)
> +			break;
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return retval;
> +}
> +
>  static int single_step_handler(unsigned long addr, unsigned int esr,
>  			       struct pt_regs *regs)
>  {
> @@ -215,8 +252,11 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
>  		 */
>  		user_rewind_single_step(current);
>  	} else {
> -		/* TODO: route to KGDB */
> -		pr_warning("Unexpected kernel single-step exception at EL1\n");
> +		/* Call single step handlers for kgdb/kprobes */

Useless comment.

> +		if (call_step_hook(regs, esr) == DEBUG_HOOK_HANDLED)
> +			return 0;
> +
> +		pr_warn("unexpected single step exception at %lx!\n", addr);

Why have you reworded this warning?

>  		/*
>  		 * Re-enable stepping since we know that we will be
>  		 * returning to regs.
> @@ -227,11 +267,50 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
>  	return 0;
>  }
>  
> +
> +static LIST_HEAD(break_hook);
> +static DEFINE_RAW_SPINLOCK(break_hook_lock);
> +
> +void register_break_hook(struct break_hook *hook)
> +{
> +	raw_spin_lock(&break_hook_lock);
> +	list_add(&hook->node, &break_hook);
> +	raw_spin_unlock(&break_hook_lock);
> +}
> +
> +void unregister_break_hook(struct break_hook *hook)
> +{
> +	raw_spin_lock(&break_hook_lock);
> +	list_del(&hook->node);
> +	raw_spin_unlock(&break_hook_lock);
> +}
> +
> +static int call_break_hook(struct pt_regs *regs, unsigned int esr)
> +{
> +	struct break_hook *hook;
> +	int (*fn)(struct pt_regs *regs, unsigned int esr) = NULL;
> +
> +	raw_spin_lock(&break_hook_lock);
> +	list_for_each_entry(hook, &break_hook, node)
> +		if ((esr & hook->esr_mask) == hook->esr_val)
> +			fn = hook->fn;
> +	raw_spin_unlock(&break_hook_lock);
> +
> +	return fn ? fn(regs, esr) : DEBUG_HOOK_ERROR;
> +}
> +
>  static int brk_handler(unsigned long addr, unsigned int esr,
>  		       struct pt_regs *regs)
>  {
>  	siginfo_t info;
>  
> +	/* call single step handlers for kgdb/kprobes */
> +	if (call_break_hook(regs, esr) == DEBUG_HOOK_HANDLED)
> +		return 0;
> +
> +	pr_warn("unexpected brk exception at %llx, esr=0x%x\n",
> +			instruction_pointer(regs), esr);

%lx for the pc.

Will
