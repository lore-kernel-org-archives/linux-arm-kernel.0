From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 8 Apr 2014 09:24:50 +0100
Subject: [RFC PATCH] ARM: uprobes need icache flush after xol write
In-Reply-To: <1396926260-7705-2-git-send-email-victor.kamensky@linaro.org>
References: <1396926260-7705-1-git-send-email-victor.kamensky@linaro.org>
 <1396926260-7705-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140408082444.GA3598@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 08:04:20PM -0700, Victor Kamensky wrote:
> After instruction write into xol area, on ARM V7
> architecture code need to flush icache to sync up dcache
> and icache. Having just 'flush_dcache_page(page)' call is
> not enough - it is possible to have stale instruction
> sitting in icache for given xol area slot address.
> 
> Introduce arch_uprobe_xol_sync_dcache_icache weak function
> that by default calls 'flush_dcache_page(page)' and on
> ARM define one that calls __cpuc_coherent_user_range.

You're right that something is needed.

Would flush_icache_range() not be the correct thing to call here?

Sync'ing the I and D sides for a whole page seems excessive to
install a probe.

I believe __cpuc_coherent_kern_range() is not intended as an API,
and should only be used in special situations in arch-specific code.
It's the correct operation, but arm provides flush_icache_range as a
wrapper to call.

flush_icache_range() is documented, with the correct effect, in
Documentation/cachetlb.txt, so I believe that all arches should
provide it, even if it's a no-op.

Cheers
---Dave

> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm/kernel/uprobes.c |  6 ++++++
>  include/linux/uprobes.h   |  3 +++
>  kernel/events/uprobes.c   | 20 +++++++++++++++-----
>  3 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/kernel/uprobes.c b/arch/arm/kernel/uprobes.c
> index f9bacee..841750b 100644
> --- a/arch/arm/kernel/uprobes.c
> +++ b/arch/arm/kernel/uprobes.c
> @@ -113,6 +113,12 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  	return 0;
>  }
>  
> +void arch_uprobe_xol_sync_dcache_icache(struct page *page,
> +					unsigned long addr, unsigned long size)
> +{
> +	__cpuc_coherent_user_range(addr, size);
> +}
> +
>  int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
>  {
>  	struct uprobe_task *utask = current->utask;
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index edff2b9..2fe3dfd 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -32,6 +32,7 @@ struct vm_area_struct;
>  struct mm_struct;
>  struct inode;
>  struct notifier_block;
> +struct page;
>  
>  #define UPROBE_HANDLER_REMOVE		1
>  #define UPROBE_HANDLER_MASK		1
> @@ -127,6 +128,8 @@ extern int  arch_uprobe_exception_notify(struct notifier_block *self, unsigned l
>  extern void arch_uprobe_abort_xol(struct arch_uprobe *aup, struct pt_regs *regs);
>  extern unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs);
>  extern bool __weak arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
> +extern void __weak arch_uprobe_xol_sync_dcache_icache(struct page *page,
> +						      unsigned long addr, unsigned long size);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 04709b6..0027883 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1299,11 +1299,9 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
>  	/* Initialize the slot */
>  	copy_to_page(area->page, xol_vaddr,
>  			&uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
> -	/*
> -	 * We probably need flush_icache_user_range() but it needs vma.
> -	 * This should work on supported architectures too.
> -	 */
> -	flush_dcache_page(area->page);
> +
> +	arch_uprobe_xol_sync_dcache_icache(area->page,
> +					   xol_vaddr, sizeof(uprobe->arch.ixol));
>  
>  	return xol_vaddr;
>  }
> @@ -1346,6 +1344,18 @@ static void xol_free_insn_slot(struct task_struct *tsk)
>  	}
>  }
>  
> +void __weak arch_uprobe_xol_sync_dcache_icache(struct page *page,
> +					       unsigned long addr, unsigned long len)
> +{
> +	/*
> +	 * We probably need flush_icache_user_range() but it needs vma.
> +	 * This should work on most of architectures by default. If
> +	 * architecture needs to do something different it can define
> +	 * its own version of the function.
> +	 */
> +	flush_dcache_page(page);
> +}
> +
>  /**
>   * uprobe_get_swbp_addr - compute address of swbp given post-swbp regs
>   * @regs: Reflects the saved state of the task after it has hit a breakpoint
> -- 
> 1.8.1.4
> 
> 
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-kernel
