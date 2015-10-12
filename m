From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 13 Oct 2015 07:13:10 +0900
Subject: [PATCH v4 2/2] arm64: Expand the stack trace feature to support
 IRQ stack
In-Reply-To: <561BE111.7@arm.com>
References: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
 <1444231692-32722-3-git-send-email-jungseoklee85@gmail.com>
 <5617CE26.10604@arm.com> <07A53E87-C562-48D1-86DF-A373EAAA73F9@gmail.com>
 <561BE111.7@arm.com>
Message-ID: <3CAA206D-3A3A-49A9-BDAD-4206D6F9BAA8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 13, 2015, at 1:34 AM, James Morse wrote:
> Hi Jungseok,

Hi James,

> On 12/10/15 15:53, Jungseok Lee wrote:
>> On Oct 9, 2015, at 11:24 PM, James Morse wrote:
>>> I think unwind_frame() needs to walk the irq stack too. [2] is an example
>>> of perf tracing back to userspace, (and there are patches on the list to
>>> do/fix this), so we need to walk back to the start of the first stack for
>>> the perf accounting to be correct.
>> 
>> Frankly, I missed the case where perf does backtrace to userspace.
>> 
>> IMO, this statement supports why the stack trace feature commit should be
>> written independently. The [1/2] patch would be pretty stable if 64KB page
>> is supported.
> 
> If this hasn't been started yet, here is a build-test-only first-pass at
> the 64K page support - based on the code in kernel/fork.c:
> 
> ==================%<==================
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index a6bdf4d3a57c..deb057a735ad 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -27,8 +27,22 @@
> #include <linux/init.h>
> #include <linux/irqchip.h>
> #include <linux/seq_file.h>
> +#include <linux/slab.h>
> +#include <linux/topology.h>
> #include <linux/ratelimit.h>
> 
> +#if THREAD_SIZE >= PAGE_SIZE
> +#define __alloc_irq_stack(x) (void *)__get_free_pages(THREADINFO_GFP,  \
> +                                                     THREAD_SIZE_ORDER)
> +
> +extern struct kmem_cache *irq_stack_cache;     /* dummy declaration */
> +#else
> +#define __alloc_irq_stack(cpu) (void
> *)kmem_cache_alloc_node(irq_stack_cache, \
> +                                       THREADINFO_GFP, cpu_to_node(cpu))
> +
> +static struct kmem_cache *irq_stack_cache;
> +#endif /* THREAD_SIZE >= PAGE_SIZE */
> 
> unsigned long irq_err_count;
> 
> DEFINE_PER_CPU(struct irq_stack, irq_stacks);
> @@ -128,7 +142,17 @@ int alloc_irq_stack(unsigned int cpu)
>        if (per_cpu(irq_stacks, cpu).stack)
>                return 0;
> 
> -       stack = (void *)__get_free_pages(THREADINFO_GFP, THREAD_SIZE_ORDER);
> +       if (THREAD_SIZE < PAGE_SIZE) {
> +               if (!irq_stack_cache) {
> +                       irq_stack_cache = kmem_cache_create("irq_stack",
> +                                                           THREAD_SIZE,
> +                                                           THREAD_SIZE, 0,
> +                                                           NULL);
> +                       BUG_ON(!irq_stack_cache);
> +               }
> +       }
> +
> +       stack = __alloc_irq_stack(cpu);
>        if (!stack)
>                return -ENOMEM;
> 
> ==================%<==================
> (my mail client will almost certainly mangle that)
> 
> Having two kmem_caches for 16K stacks on a 64K page system may be wasteful
> (especially for systems with few cpus)?

This would be a single concern. To address this issue, I drop the 'static'
keyword in thread_info_cache. Please refer to the below hunk.

> The alternative is to defining CONFIG_ARCH_THREAD_INFO_ALLOCATOR and
> allocate all stack memory from arch code. (Largely copied code, prevents
> irq stacks being a different size, and nothing uses that define today!)
> 
> 
> Thoughts?

Almost same story I've been testing.

I'm aligned with yours Regarding CONFIG_ARCH_THREAD_INFO_ALLOCATOR.

Another approach I've tried is the following data structure, but it's not
a good fit for this case due to __per_cpu_offset which is page-size aligned,
not thread-size.

struct irq_stack {
	char stack[THREAD_SIZE];
	char *highest;
} __aligned(THREAD_SIZE);

DEFINE_PER_CPU(struct irq_stack, irq_stacks);

----8<-----
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index 6ea82e8..d3619b3 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -1,7 +1,9 @@
 #ifndef __ASM_IRQ_H
 #define __ASM_IRQ_H
 
+#include <linux/gfp.h>
 #include <linux/irqchip/arm-gic-acpi.h>
+#include <linux/slab.h>
 
 #include <asm-generic/irq.h>
 
@@ -9,6 +11,21 @@ struct irq_stack {
        void *stack;
 };
 
+#if THREAD_SIZE >= PAGE_SIZE
+static inline void *__alloc_irq_stack(void)
+{
+       return (void *)__get_free_pages(THREADINFO_GFP | __GFP_ZERO,
+                                       THREAD_SIZE_ORDER);
+}
+#else
+extern struct kmem_cache *thread_info_cache;
+
+static inline void *__alloc_irq_stack(void)
+{
+       return kmem_cache_alloc(thread_info_cache, THREADINFO_GFP | __GFP_ZERO);
+}
+#endif
+
 struct pt_regs;
 
 extern void migrate_irqs(void);
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index a6bdf4d..4e13bdd 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -50,10 +50,13 @@ void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
        handle_arch_irq = handle_irq;
 }
 
+static char boot_irq_stack[THREAD_SIZE] __aligned(THREAD_SIZE);
+
 void __init init_IRQ(void)
 {
-       if (alloc_irq_stack(smp_processor_id()))
-               panic("Failed to allocate IRQ stack for a boot cpu");
+       unsigned int cpu = smp_processor_id();
+
+       per_cpu(irq_stacks, cpu).stack = boot_irq_stack + THREAD_START_SP;
 
        irqchip_init();
        if (!handle_arch_irq)
@@ -128,7 +131,7 @@ int alloc_irq_stack(unsigned int cpu)
        if (per_cpu(irq_stacks, cpu).stack)
                return 0;
 
-       stack = (void *)__get_free_pages(THREADINFO_GFP, THREAD_SIZE_ORDER);
+       stack = __alloc_irq_stack();
        if (!stack)
                return -ENOMEM;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 2845623..9c55f86 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -172,7 +172,7 @@ static inline void free_thread_info(struct thread_info *ti)
        free_kmem_pages((unsigned long)ti, THREAD_SIZE_ORDER);
 }
 # else
-static struct kmem_cache *thread_info_cache;
+struct kmem_cache *thread_info_cache;
 
 static struct thread_info *alloc_thread_info_node(struct task_struct *tsk,
                                                  int node)
----8<-----

Best Regards
Jungseok Lee
