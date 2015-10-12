From: james.morse@arm.com (James Morse)
Date: Mon, 12 Oct 2015 17:34:25 +0100
Subject: [PATCH v4 2/2] arm64: Expand the stack trace feature to support
 IRQ stack
In-Reply-To: <07A53E87-C562-48D1-86DF-A373EAAA73F9@gmail.com>
References: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
 <1444231692-32722-3-git-send-email-jungseoklee85@gmail.com>
 <5617CE26.10604@arm.com> <07A53E87-C562-48D1-86DF-A373EAAA73F9@gmail.com>
Message-ID: <561BE111.7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jungseok,

On 12/10/15 15:53, Jungseok Lee wrote:
> On Oct 9, 2015, at 11:24 PM, James Morse wrote:
>> I think unwind_frame() needs to walk the irq stack too. [2] is an example
>> of perf tracing back to userspace, (and there are patches on the list to
>> do/fix this), so we need to walk back to the start of the first stack for
>> the perf accounting to be correct.
> 
> Frankly, I missed the case where perf does backtrace to userspace.
> 
> IMO, this statement supports why the stack trace feature commit should be
> written independently. The [1/2] patch would be pretty stable if 64KB page
> is supported.

If this hasn't been started yet, here is a build-test-only first-pass at
the 64K page support - based on the code in kernel/fork.c:

==================%<==================
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index a6bdf4d3a57c..deb057a735ad 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -27,8 +27,22 @@
 #include <linux/init.h>
 #include <linux/irqchip.h>
 #include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/topology.h>
 #include <linux/ratelimit.h>

+#if THREAD_SIZE >= PAGE_SIZE
+#define __alloc_irq_stack(x) (void *)__get_free_pages(THREADINFO_GFP,  \
+                                                     THREAD_SIZE_ORDER)
+
+extern struct kmem_cache *irq_stack_cache;     /* dummy declaration */
+#else
+#define __alloc_irq_stack(cpu) (void
*)kmem_cache_alloc_node(irq_stack_cache, \
+                                       THREADINFO_GFP, cpu_to_node(cpu))
+
+static struct kmem_cache *irq_stack_cache;
+#endif /* THREAD_SIZE >= PAGE_SIZE */

 unsigned long irq_err_count;

 DEFINE_PER_CPU(struct irq_stack, irq_stacks);
@@ -128,7 +142,17 @@ int alloc_irq_stack(unsigned int cpu)
        if (per_cpu(irq_stacks, cpu).stack)
                return 0;

-       stack = (void *)__get_free_pages(THREADINFO_GFP, THREAD_SIZE_ORDER);
+       if (THREAD_SIZE < PAGE_SIZE) {
+               if (!irq_stack_cache) {
+                       irq_stack_cache = kmem_cache_create("irq_stack",
+                                                           THREAD_SIZE,
+                                                           THREAD_SIZE, 0,
+                                                           NULL);
+                       BUG_ON(!irq_stack_cache);
+               }
+       }
+
+       stack = __alloc_irq_stack(cpu);
        if (!stack)
                return -ENOMEM;

==================%<==================
(my mail client will almost certainly mangle that)

Having two kmem_caches for 16K stacks on a 64K page system may be wasteful
(especially for systems with few cpus)...

The alternative is to defining CONFIG_ARCH_THREAD_INFO_ALLOCATOR and
allocate all stack memory from arch code. (Largely copied code, prevents
irq stacks being a different size, and nothing uses that define today!)


Thoughts?


> 
>>> +	 */
>>> +	if (fp < low || fp > high - 0x10 || fp & 0xf)
>>> 		return -EINVAL;
>>>
>>> 	frame->sp = fp + 0x10;
>>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>>> index f93aae5..44b2f828 100644
>>> --- a/arch/arm64/kernel/traps.c
>>> +++ b/arch/arm64/kernel/traps.c
>>> @@ -146,6 +146,8 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
>>> static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>>> {
>>> 	struct stackframe frame;
>>> +	unsigned int cpu = smp_processor_id();
>>
>> I wonder if there is any case where dump_backtrace() is called on another cpu?
>>
>> Setting the cpu value from task_thread_info(tsk)->cpu would protect against
>> this.
> 
> IMO, no, but your suggestion makes sense. I will update it.
> 
>>> +	bool in_irq = in_irq_stack(cpu);
>>>
>>> 	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
>>>
>>> @@ -170,6 +172,10 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>>> 	}
>>>
>>> 	pr_emerg("Call trace:\n");
>>> +repeat:
>>> +	if (in_irq)
>>> +		pr_emerg("<IRQ>\n");
>>
>> Do we need these? 'el1_irq()' in the trace is a giveaway?
> 
> I borrow this idea from x86 implementation in order to show a separate stack
> explicitly. There is no issue to remove these tags, <IRQ> and <EOI>.

Ah okay - if its done elsewhere, its better to be consistent.


Thanks,


James
