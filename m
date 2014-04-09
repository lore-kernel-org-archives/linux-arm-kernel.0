From: dave.long@linaro.org (David Long)
Date: Wed, 09 Apr 2014 14:23:00 -0400
Subject: [PATCH v2] ARM: uprobes need icache flush after xol write
In-Reply-To: <1397023132-10313-2-git-send-email-victor.kamensky@linaro.org>
References: <1397023132-10313-1-git-send-email-victor.kamensky@linaro.org>
 <1397023132-10313-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <53459004.2070807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/14 01:58, Victor Kamensky wrote:
> After instruction write into xol area, on ARM V7
> architecture code need to flush dcache and icache to sync
> them up for given set of addresses. Having just
> 'flush_dcache_page(page)' call is not enough - it is
> possible to have stale instruction sitting in icache
> for given xol area slot address.
>
> Introduce arch_uprobe_flush_xol_access weak function
> that by default calls 'flush_dcache_page(page)' and on
> ARM define new one that calls flush_uprobe_xol_access
> function.
>
> flush_uprobe_xol_access function shares/reuses implementation
> with/of flush_ptrace_access function and takes care of writing
> instruction to user land address space on given variety of
> different cache types on ARM CPUs. Because
> flush_uprobe_xol_access does not have vma around
> flush_ptrace_access was split into two parts. First that
> retrieves set of condition from vma and common that receives
> those conditions as flags.
>
> Because on ARM cache flush function need kernel address
> through which instruction write happened, changed
> xol_get_insn_slot to explicitly map page and do memcpy
> rather than use copy_to_page helper. In this case
> xol_get_insn_slot knows kernel address and passes it to
> arch_uprobe_flush_xol_access function.
>
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>   arch/arm/include/asm/cacheflush.h |  2 ++
>   arch/arm/kernel/uprobes.c         |  6 ++++++
>   arch/arm/mm/flush.c               | 41 +++++++++++++++++++++++++++++++++------
>   include/linux/uprobes.h           |  3 +++
>   kernel/events/uprobes.c           | 33 +++++++++++++++++++++++++------
>   5 files changed, 73 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index 8b8b616..e02712a 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -487,4 +487,6 @@ int set_memory_rw(unsigned long addr, int numpages);
>   int set_memory_x(unsigned long addr, int numpages);
>   int set_memory_nx(unsigned long addr, int numpages);
>
> +void flush_uprobe_xol_access(struct page *page, unsigned long uaddr,
> +			     void *kaddr, unsigned long len);
>   #endif
> diff --git a/arch/arm/kernel/uprobes.c b/arch/arm/kernel/uprobes.c
> index f9bacee..a0339a6 100644
> --- a/arch/arm/kernel/uprobes.c
> +++ b/arch/arm/kernel/uprobes.c
> @@ -113,6 +113,12 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
>   	return 0;
>   }
>
> +void arch_uprobe_flush_xol_access(struct page *page, unsigned long vaddr,
> +				  void *kaddr, unsigned long len)
> +{
> +	flush_uprobe_xol_access(page, vaddr, kaddr, len);
> +}
> +
>   int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
>   {
>   	struct uprobe_task *utask = current->utask;
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 3387e60..69a0bd08 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -104,17 +104,21 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
>   #define flush_icache_alias(pfn,vaddr,len)	do { } while (0)
>   #endif
>
> +#define FLAG_UA_IS_EXEC 1
> +#define FLAG_UA_CORE_IN_MM 2
> +#define FLAG_UA_BROADCAST 4
> +
>   static void flush_ptrace_access_other(void *args)
>   {
>   	__flush_icache_all();
>   }
>
> -static
> -void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
> -			 unsigned long uaddr, void *kaddr, unsigned long len)
> +static inline
> +void __flush_ptrace_access(struct page *page, unsigned long uaddr, void *kaddr,
> +			   unsigned long len, unsigned int flags)
>   {
>   	if (cache_is_vivt()) {
> -		if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
> +		if (flags & FLAG_UA_CORE_IN_MM) {
>   			unsigned long addr = (unsigned long)kaddr;
>   			__cpuc_coherent_kern_range(addr, addr + len);
>   		}
> @@ -128,18 +132,43 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
>   	}
>
>   	/* VIPT non-aliasing D-cache */
> -	if (vma->vm_flags & VM_EXEC) {
> +	if (flags & FLAG_UA_IS_EXEC) {
>   		unsigned long addr = (unsigned long)kaddr;
>   		if (icache_is_vipt_aliasing())
>   			flush_icache_alias(page_to_pfn(page), uaddr, len);
>   		else
>   			__cpuc_coherent_kern_range(addr, addr + len);
> -		if (cache_ops_need_broadcast())
> +		if (flags & FLAG_UA_BROADCAST)
>   			smp_call_function(flush_ptrace_access_other,
>   					  NULL, 1);
>   	}
>   }
>
> +static
> +void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
> +			 unsigned long uaddr, void *kaddr, unsigned long len)
> +{
> +	unsigned int flags = 0;
> +	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
> +		flags |= FLAG_UA_CORE_IN_MM;
> +	}
> +	if (vma->vm_flags & VM_EXEC) {
> +		flags |= FLAG_UA_IS_EXEC;
> +	}
> +	if (cache_ops_need_broadcast()) {
> +		flags |= FLAG_UA_BROADCAST;
> +	}
> +	__flush_ptrace_access(page, uaddr, kaddr, len, flags);
> +}
> +
> +void flush_uprobe_xol_access(struct page *page, unsigned long uaddr,
> +			     void *kaddr, unsigned long len)
> +{
> +	unsigned int flags = FLAG_UA_CORE_IN_MM|FLAG_UA_IS_EXEC;
> +
> +	__flush_ptrace_access(page, uaddr, kaddr, len, flags);
> +}
> +

I guess this is cleaner than duplicating some part of 
flush_ptrace_access inside your new flush function.

>   /*
>    * Copy user data from/to a page which is mapped into a different
>    * processes address space.  Really, we want to allow our "user
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index edff2b9..534e083 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -32,6 +32,7 @@ struct vm_area_struct;
>   struct mm_struct;
>   struct inode;
>   struct notifier_block;
> +struct page;
>
>   #define UPROBE_HANDLER_REMOVE		1
>   #define UPROBE_HANDLER_MASK		1
> @@ -127,6 +128,8 @@ extern int  arch_uprobe_exception_notify(struct notifier_block *self, unsigned l
>   extern void arch_uprobe_abort_xol(struct arch_uprobe *aup, struct pt_regs *regs);
>   extern unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs);
>   extern bool __weak arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
> +extern void __weak arch_uprobe_flush_xol_access(struct page *page, unsigned long vaddr,
> +						void *kaddr, unsigned long len);
>   #else /* !CONFIG_UPROBES */
>   struct uprobes_state {
>   };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 04709b6..b9142d5 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1287,6 +1287,7 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
>   {
>   	struct xol_area *area;
>   	unsigned long xol_vaddr;
> +	void *xol_page_kaddr;
>
>   	area = get_xol_area();
>   	if (!area)
> @@ -1296,14 +1297,22 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
>   	if (unlikely(!xol_vaddr))
>   		return 0;
>
> -	/* Initialize the slot */
> -	copy_to_page(area->page, xol_vaddr,
> -			&uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
>   	/*
> -	 * We probably need flush_icache_user_range() but it needs vma.
> -	 * This should work on supported architectures too.
> +	 * We don't use copy_to_page here because we need kernel page
> +	 * addr to invalidate caches correctly
>   	 */
> -	flush_dcache_page(area->page);
> +	xol_page_kaddr = kmap_atomic(area->page);
> +
> +	/* Initialize the slot */
> +	memcpy(xol_page_kaddr + (xol_vaddr & ~PAGE_MASK),
> +	       &uprobe->arch.ixol,
> +	       sizeof(uprobe->arch.ixol));
> +
> +	arch_uprobe_flush_xol_access(area->page, xol_vaddr,
> +				     xol_page_kaddr + (xol_vaddr & ~PAGE_MASK),
> +				     sizeof(uprobe->arch.ixol));
> +
> +	kunmap_atomic(xol_page_kaddr);
>
>   	return xol_vaddr;
>   }
> @@ -1346,6 +1355,18 @@ static void xol_free_insn_slot(struct task_struct *tsk)
>   	}
>   }
>
> +void __weak arch_uprobe_flush_xol_access(struct page *page, unsigned long vaddr,
> +					 void *kaddr, unsigned long len)
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
>   /**
>    * uprobe_get_swbp_addr - compute address of swbp given post-swbp regs
>    * @regs: Reflects the saved state of the task after it has hit a breakpoint
>

I can confirm this fixes the problem I was seeing on arndale.  x86 
builds but I have not tested it.

It looks to me like this is the best way to solve the problem.  You 
should run checkpatch.pl on your patch though, there are some warnings 
from unnecessary curly braces on if statements and a couple lines over 
80 characters long.  Minor issues, but easily fixed.  Assuming you fix 
those you can add:

Reviewed-by: David A. Long <dave.long@linaro.org>


-dl
