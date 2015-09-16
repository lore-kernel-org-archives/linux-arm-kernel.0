From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Sep 2015 12:25:21 +0100
Subject: [PATCH v2] arm64: Introduce IRQ stack
In-Reply-To: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
References: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <20150916112520.GH28771@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 13, 2015 at 03:42:17PM +0100, Jungseok Lee wrote:
> Currently, kernel context and interrupts are handled using a single
> kernel stack navigated by sp_el1. This forces many systems to use
> 16KB stack, not 8KB one. Low memory platforms naturally suffer from
> memory pressure accompanied by performance degradation.
> 
> This patch addresses the issue as introducing a separate percpu IRQ
> stack to handle both hard and soft interrupts with two ground rules:
> 
>   - Utilize sp_el0 in EL1 context, which is not used currently
>   - Do not complicate current_thread_info calculation
> 
> It is a core concept to trace struct thread_info using sp_el0 instead
> of sp_el1. This approach helps arm64 align with other architectures
> regarding object_is_on_stack() without additional complexity.
> 
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
> ---
> Changes since v1:
> - Rebased on top of v4.3-rc1
> - Removed Kconfig about IRQ stack, per James
> - Used PERCPU for IRQ stack, per James
> - Tried to allocate IRQ stack when CPU is about to start up, per James
> - Moved sp_el0 update into kernel_entry macro, per James
> - Dropped S_SP removal patch, per Mark and James
> 
>  arch/arm64/include/asm/irq.h         |  8 +++
>  arch/arm64/include/asm/thread_info.h |  7 +-
>  arch/arm64/kernel/asm-offsets.c      |  5 ++
>  arch/arm64/kernel/entry.S            | 54 ++++++++++++++--
>  arch/arm64/kernel/head.S             |  3 +
>  arch/arm64/kernel/irq.c              | 21 ++++++
>  arch/arm64/kernel/smp.c              |  6 ++
>  7 files changed, 95 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index bbb251b..67975a2 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -5,11 +5,19 @@
>  
>  #include <asm-generic/irq.h>
>  
> +struct irq_stack {
> +	void *stack;
> +	unsigned long thread_sp;
> +	unsigned int count;
> +};
> +
>  struct pt_regs;
>  
>  extern void migrate_irqs(void);
>  extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
>  
> +extern int alloc_irq_stack(unsigned int cpu);
> +
>  static inline void acpi_irq_init(void)
>  {
>  	/*
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index dcd06d1..44839c0 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -73,8 +73,11 @@ static inline struct thread_info *current_thread_info(void) __attribute_const__;
>  
>  static inline struct thread_info *current_thread_info(void)
>  {
> -	return (struct thread_info *)
> -		(current_stack_pointer & ~(THREAD_SIZE - 1));
> +	unsigned long sp_el0;
> +
> +	asm volatile("mrs %0, sp_el0" : "=r" (sp_el0));
> +
> +	return (struct thread_info *)(sp_el0 & ~(THREAD_SIZE - 1));

This looks like it will generate worse code than our current implementation,
thanks to the asm volatile. Maybe just add something like a global
current_stack_pointer_el0?

Will
