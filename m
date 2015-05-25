From: minchan@kernel.org (Minchan Kim)
Date: Mon, 25 May 2015 23:40:45 +0900
Subject: [RFC PATCH 2/2] arm64: Implement vmalloc based thread_info
 allocator
In-Reply-To: <1432483340-23157-1-git-send-email-jungseoklee85@gmail.com>
References: <1432483340-23157-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <20150525144045.GE14922@blaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jungseok,

On Mon, May 25, 2015 at 01:02:20AM +0900, Jungseok Lee wrote:
> Fork-routine sometimes fails to get a physically contiguous region for
> thread_info on 4KB page system although free memory is enough. That is,
> a physically contiguous region, which is currently 16KB, is not available
> since system memory is fragmented.

Order less than PAGE_ALLOC_COSTLY_ORDER should not fail in current
mm implementation. If you saw the order-2,3 high-order allocation fail
maybe your application received SIGKILL by someone. LMK?

> 
> This patch tries to solve the problem as allocating thread_info memory
> from vmalloc space, not 1:1 mapping one. The downside is one additional
> page allocation in case of vmalloc. However, vmalloc space is large enough,

The size you want to allocate is 16KB in here but additional 4K?
It increases 25% memory footprint, which is huge downside.

> around 240GB, under a combination of 39-bit VA and 4KB page. Thus, it is
> not a big tradeoff for fork-routine service.
> 
> Suggested-by: Sungjinn Chung <barami97@gmail.com>
> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-mm at kvack.org
> ---
>  arch/arm64/Kconfig                   | 12 ++++++++++++
>  arch/arm64/include/asm/thread_info.h |  9 +++++++++
>  arch/arm64/kernel/process.c          |  7 +++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 99930cf..93c236a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -536,6 +536,18 @@ config ARCH_SELECT_MEMORY_MODEL
>  config HAVE_ARCH_PFN_VALID
>  	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
>  
> +config ARCH_THREAD_INFO_ALLOCATOR
> +	bool "Enable vmalloc based thread_info allocator (EXPERIMENTAL)"
> +	depends on ARM64_4K_PAGES
> +	default n
> +	help
> +	  This feature enables vmalloc based thread_info allocator. It
> +	  prevents fork-routine from begin failed to obtain physically
> +	  contiguour region due to memory fragmentation on low system
> +	  memory platforms.
> +
> +	  If unsure, say N
> +
>  config HW_PERF_EVENTS
>  	bool "Enable hardware performance counter support for perf events"
>  	depends on PERF_EVENTS
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index dcd06d1..e753e59 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -61,6 +61,15 @@ struct thread_info {
>  #define init_thread_info	(init_thread_union.thread_info)
>  #define init_stack		(init_thread_union.stack)
>  
> +#ifdef CONFIG_ARCH_THREAD_INFO_ALLOCATOR
> +#define alloc_thread_info_node(tsk, node)				\
> +({									\
> +	__vmalloc_node_range(THREAD_SIZE, THREAD_SIZE, VMALLOC_START,	\
> +			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL, 0,	\
> +			NUMA_NO_NODE, __builtin_return_address(0));	\
> +})
> +#define free_thread_info(ti)	vfree(ti)
> +#endif
>  /*
>   * how to get the current stack pointer from C
>   */
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index c506bee..c4b6aae 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -238,6 +238,13 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ARCH_THREAD_INFO_ALLOCATOR
> +struct page *arch_thread_info_to_page(struct thread_info *ti)
> +{
> +	return vmalloc_to_page(ti);
> +}
> +#endif
> +
>  asmlinkage void ret_from_fork(void) asm("ret_from_fork");
>  
>  int copy_thread(unsigned long clone_flags, unsigned long stack_start,
> -- 
> 1.9.1
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>

-- 
Kind regards,
Minchan Kim
