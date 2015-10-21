From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Thu, 22 Oct 2015 00:14:36 +0900
Subject: [PATCH v4 2/2] arm64: Expand the stack trace feature to support
 IRQ stack
In-Reply-To: <721ACBE7-53CE-4698-8470-B941F6D41AC2@gmail.com>
References: <07A53E87-C562-48D1-86DF-A373EAAA73F9@gmail.com>
 <561BE111.7@arm.com> <3CAA206D-3A3A-49A9-BDAD-4206D6F9BAA8@gmail.com>
 <561CE454.7080201@arm.com> <04D64B22-8EF5-400E-A7F0-1CD0AB48184D@gmail.com>
 <B6AB90B9-3AA9-413A-B357-137710E89C7C@gmail.com> <561FCD59.1090600@arm.com>
 <6E0DDC4D-9A97-4EAE-868C-B1271F02D3E0@gmail.com>
 <20151016160606.GE6613@e104818-lin.cambridge.arm.com>
 <3AD5938C-4109-4B95-A13B-5D45525B39FB@gmail.com>
 <20151019161816.GE11226@e104818-lin.cambridge.arm.com>
 <721ACBE7-53CE-4698-8470-B941F6D41AC2@gmail.com>
Message-ID: <6017691C-BDEE-475E-9425-18793B7AA7C9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 20, 2015, at 10:08 PM, Jungseok Lee wrote:
> On Oct 20, 2015, at 1:18 AM, Catalin Marinas wrote:
> 
> Hi Catalin,
> 
>> On Sat, Oct 17, 2015 at 10:38:16PM +0900, Jungseok Lee wrote:
>>> On Oct 17, 2015, at 1:06 AM, Catalin Marinas wrote:
>>>> BTW, a static allocation (DEFINE_PER_CPU for the whole irq stack) would
>>>> save us from another stack address reading on the IRQ entry path. I'm
>>>> not sure exactly where the 16K image increase comes from but at least it
>>>> doesn't grow with NR_CPUS, so we can probably live with this.
>>> 
>>> I've tried the approach, a static allocation using DEFINE_PER_CPU, but
>>> it dose not work on a top-bit comparison method (for IRQ re-entrance
>>> check). The top-bit idea is based on the assumption that IRQ stack is
>>> aligned with THREAD_SIZE. But, tpidr_el1 is PAGE_SIZE aligned. It leads
>>> to IRQ re-entrance failure in case of 4KB page system.
>>> 
>>> IMHO, it is hard to avoid 16KB size increase for 64KB page support.
>>> Secondary cores can rely on slab.h, but a boot core cannot. So, IRQ
>>> stack for at least a boot cpu should be allocated statically.
>> 
>> Ah, I forgot about the alignment check. The problem we have with your v5
>> patch is that kmalloc() doesn't guarantee this either (see commit
>> 2a0b5c0d1929, "arm64: Align less than PAGE_SIZE pgds naturally", where
>> we had to fix this for pgd_alloc).
> 
> The alignment would be guaranteed under the following additional diff. It is
> possible to remove one pointer read in irq_stack_entry on 64KB page, but it
> leads to code divergence. Am I missing something?
> 
> ----8<----
> 
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index 2755b2f..c480613 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -17,15 +17,17 @@
> #include <asm-generic/irq.h>
> 
> #if IRQ_STACK_SIZE >= PAGE_SIZE
> -static inline void *__alloc_irq_stack(void)
> +static inline void *__alloc_irq_stack(unsigned int cpu)
> {
>        return (void *)__get_free_pages(THREADINFO_GFP | __GFP_ZERO,
>                                        IRQ_STACK_SIZE_ORDER);
> }
> #else
> -static inline void *__alloc_irq_stack(void)
> +DECLARE_PER_CPU(char [IRQ_STACK_SIZE], irq_stack) __aligned(IRQ_STACK_SIZE);
> +
> +static inline void *__alloc_irq_stack(unsigned int cpu)
> {
> -       return kmalloc(IRQ_STACK_SIZE, THREADINFO_GFP | __GFP_ZERO);
> +       return (void *)per_cpu(irq_stack, cpu);
> }
> #endif
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index c8e0bcf..f1303c5 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -177,7 +177,7 @@ alternative_endif
>        .endm
> 
>        .macro  irq_stack_entry
> -       adr_l   x19, irq_stacks
> +       adr_l   x19, irq_stack_ptr
>        mrs     x20, tpidr_el1
>        add     x19, x19, x20
>        ldr     x24, [x19]
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index 13fe8f4..acb9a14 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -30,7 +30,10 @@
> 
> unsigned long irq_err_count;
> 
> -DEFINE_PER_CPU(void *, irq_stacks);
> +DEFINE_PER_CPU(void *, irq_stack_ptr);
> +#if IRQ_STACK_SIZE < PAGE_SIZE
> +DEFINE_PER_CPU(char [IRQ_STACK_SIZE], irq_stack) __aligned(IRQ_STACK_SIZE);
> +#endif
> 
> int arch_show_interrupts(struct seq_file *p, int prec)
> {
> @@ -49,13 +52,10 @@ void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>        handle_arch_irq = handle_irq;
> }
> 
> -static char boot_irq_stack[IRQ_STACK_SIZE] __aligned(IRQ_STACK_SIZE);
> -
> void __init init_IRQ(void)
> {
> -       unsigned int cpu = smp_processor_id();
> -
> -       per_cpu(irq_stacks, cpu) = boot_irq_stack + IRQ_STACK_START_SP;
> +       if (alloc_irq_stack(smp_processor_id()))
> +               panic("Failed to allocate IRQ stack for a boot cpu");
> 
>        irqchip_init();
>        if (!handle_arch_irq)
> @@ -66,14 +66,14 @@ int alloc_irq_stack(unsigned int cpu)
> {
>        void *stack;
> 
> -       if (per_cpu(irq_stacks, cpu))
> +       if (per_cpu(irq_stack_ptr, cpu))
>                return 0;
> 
> -       stack = __alloc_irq_stack();
> +       stack = __alloc_irq_stack(cpu);
>        if (!stack)
>                return -ENOMEM;
> 
> -       per_cpu(irq_stacks, cpu) = stack + IRQ_STACK_START_SP;
> +       per_cpu(irq_stack_ptr, cpu) = stack + IRQ_STACK_START_SP;
> 
>        return 0;
> }
> 
> ----8<----
> 
> 
>> 
>> I'm leaning more and more towards the x86 approach as I mentioned in the
>> two messages below:
>> 
>> http://article.gmane.org/gmane.linux.kernel/2041877
>> http://article.gmane.org/gmane.linux.kernel/2043002
>> 
>> With a per-cpu stack you can avoid another pointer read, replacing it
>> with a single check for the re-entrance. But note that the update only
>> happens during do_softirq_own_stack() and *not* for every IRQ taken.
> 
> I've reviewed carefully the approach you mentioned about a month ago.
> According to my observation on max stack depth, its context is as follows:
> 
> (1) process context
> (2) hard IRQ raised
> (3) soft IRQ raised in irq_exit()
> (4) another process context
> (5) another hard IRQ raised 
> 
> The below is a stack description under the scenario.
> 
> --- ------- <- High address of stack
>     |     |
>     |     |
> (a) |     | Process context (1)
>     |     |
>     |     |
> --- ------- <- Hard IRQ raised (2)
> (b) |     |
> --- ------- <- Soft IRQ raised in irq_exit() (3)
> (c) |     |
> --- ------- <- Max stack depth by (2)
>     |     |
> (d) |     | Another process context (4)
>     |     |
> --- ------- <- Another hard IRQ raised (5)
> (e) |     |
> --- ------- <- Low address of stack
> 
> The following is max stack depth calculation: The first argument of max() is
> handled by process stack, the second one is handled by IRQ stack. 
> 
> - current status  : max_stack_depth = max((a)+(b)+(c)+(d)+(e), 0)
> - current patch   : max_stack_depth = max((a), (b)+(c)+(d)+(e))
> - do_softirq_own_ : max_stack_depth = max((a)+(b)+(c), (c)+(d)+(e))
> 
> It is a principal objective to build up an infrastructure targeted at reduction
> of process stack size, THREAD_SIZE. Frankly I'm not sure about the inequality,
> (a)+(b)+(c) <= 8KB. If the condition is not satisfied, this feature, IRQ stack
> support, would be questionable. That is, it might be insufficient to manage a
> single out-of-tree patch which adjusts both IRQ_STACK_SIZE and THREAD_SIZE.
> 
> However, if the inequality is guaranteed, do_softirq_own_ approach looks better
> than the current one in operation overhead perspective. BTW, is there a way to
> simplify a top-bit comparison logic?
> 
> Great thanks for valuable feedbacks from which I've learned a lot.


1) Another pointer read

My interpretation on your comment is as follows.

    DEFINE_PER_CPU(char [IRQ_STACK_SIZE], irq_stack) __aligned(IRQ_STACK_SIZE);

    .macro irq_stack_entry
    adr_l x19, irq_stack
    mrs   x20, tpidr_el1
    mov   x21, #IRQ_STACK_START_SP
    add   x21, x20, x21            // x21 = top of irq_stack
    .endm

If static allocation is used, we could avoid *ldr* operation in irq_stack_entry.
I think this is *another pointer read* advantage under static allocation. Right?

2) Static allocation

Since ARM64 relies on generic setup_per_cpu_areas(), tpidr_el1 is PAGE_SIZE aligned.
As reviewing other architecture which have its own setup_per_cpu_areas(), it is
one of reasons to configure its own 'atom_size' parameter. If mm/percpu.c gives
a chance, overriding atom_size, to architecture, static allocation would be available
on 4KB page system. If this does not sound unreasonable, I will try to get feedbacks
via linux-mm. For reference, the implementation might look as below.

----8<----

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index caebf2a..ab9a1f2 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -9,6 +9,7 @@
 #include <linux/pfn.h>
 #include <linux/init.h>
 
+#include <asm/page.h>
 #include <asm/percpu.h>
 
 /* enough to cover all DEFINE_PER_CPUs in modules */
@@ -18,6 +19,10 @@
 #define PERCPU_MODULE_RESERVE          0
 #endif
 
+#ifndef PERCPU_ATOM_SIZE
+#define PERCPU_ATOM_SIZE               PAGE_SIZE
+#endif
+
 #ifndef PERCPU_ENOUGH_ROOM
 #define PERCPU_ENOUGH_ROOM                                             \
        (ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES) +      \
diff --git a/mm/percpu.c b/mm/percpu.c
index a63b4d8..cd1e0ec 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2201,8 +2201,8 @@ void __init setup_per_cpu_areas(void)
         * what the legacy allocator did.
         */
        rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
-                                   PERCPU_DYNAMIC_RESERVE, PAGE_SIZE, NULL,
-                                   pcpu_dfl_fc_alloc, pcpu_dfl_fc_free);
+                                   PERCPU_DYNAMIC_RESERVE, PERCPU_ATOM_SIZE,
+                                   NULL, pcpu_dfl_fc_alloc, pcpu_dfl_fc_free);
        if (rc < 0)
                panic("Failed to initialize percpu areas.");
 
@@ -2231,7 +2231,7 @@ void __init setup_per_cpu_areas(void)
 
        ai = pcpu_alloc_alloc_info(1, 1);
        fc = memblock_virt_alloc_from_nopanic(unit_size,
-                                             PAGE_SIZE,
+                                             PERCPU_ATOM_SIZE,
                                              __pa(MAX_DMA_ADDRESS));
        if (!ai || !fc)
                panic("Failed to allocate memory for percpu areas.");

----8<----

As overriding PERCPU_ATOM_SIZE in architecture side, aligned stack could be
allocated in a static way, which get rids of another pointer read.

Any feedbacks are welcome.

Best Regards
Jungseok Lee
