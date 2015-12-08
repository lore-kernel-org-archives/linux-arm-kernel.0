From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 9 Dec 2015 01:02:07 +0900
Subject: [PATCH v8 3/4] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <20151208114321.GD19612@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-4-git-send-email-james.morse@arm.com>
 <20151207224805.GA20777@MBP.local> <20151208114321.GD19612@arm.com>
Message-ID: <4EBA6141-5CFB-4CAC-97D2-26346AAA91F0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 8, 2015, at 8:43 PM, Will Deacon wrote:
> On Mon, Dec 07, 2015 at 10:48:07PM +0000, Catalin Marinas wrote:
>> On Fri, Dec 04, 2015 at 11:02:27AM +0000, James Morse wrote:
>>> entry.S is modified to switch to the per_cpu irq_stack during el{0,1}_irq.
>>> irq_count is used to detect recursive interrupts on the irq_stack, it is
>>> updated late by do_softirq_own_stack(), when called on the irq_stack, before
>>> __do_softirq() re-enables interrupts to process softirqs.
>>> 
>>> do_softirq_own_stack() is added by this patch, but does not yet switch
>>> stack.
>>> 
>>> This patch adds the dummy stack frame and data needed by the previous
>>> stack tracing patches.
>>> 
>>> Signed-off-by: James Morse <james.morse@arm.com>
>> 
>> In the interest of getting things moving on this series:
>> 
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> 
>> I propose that we skip patch 4 for now and, as James suggested, keep the
>> THREAD_SIZE to 16KB for one more release cycle. It would be good to get
>> some statistics on stack usage.
>> 
>> Patches 1-3 look fine to me on their own.
> 
> I'll pick them up and see if they survive testing.

Dear All

I've seen the following BUG log with CONFIG_DEBUG_SPINLOCK=y kernel.
 
 BUG: spinlock lockup suspected on CPU#1

Under that option, I cannot even complete a single kernel build successfully.
I hope I'm the only person to experience it. My Android machine is running
well for over 12 hours now with the below change.

----8<----

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index fa2a8d0..db90a69 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -27,7 +27,7 @@ DECLARE_PER_CPU(unsigned long [IRQ_STACK_SIZE/sizeof(long)], irq_stack);
  * The offset from irq_stack_ptr where entry.S will store the original
  * stack pointer. Used by unwind_frame() and dump_backtrace().
  */
-#define IRQ_STACK_TO_TASK_STACK(ptr) *((unsigned long *)(ptr - 0x10));
+#define IRQ_STACK_TO_TASK_STACK(ptr) *((unsigned long *)(ptr - 0x20));
 
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 81cc538..7d54c26 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -199,7 +199,7 @@ alternative_endif
        /* Add a dummy stack frame */
        stp     x29, \dummy_lr, [sp, #-16]!           // dummy stack frame
        mov     x29, sp
-       stp     xzr, x19, [sp, #-16]!
+       stp     x19, xzr, [sp, #-16]!
 
 9998:
        .endm

----8<----

If I read the patches correctly, the dummy stack frame looks as follows.

  top ------------ <- irq_stack_ptr
      | dummy_lr |
      ------------
      |   x29    |
      ------------ <- new frame pointer (x29)
      |   x19    |
      ------------
      |   xzr    |
      ------------

So, we should refer to x19 in order to retrieve frame->sp. But, frame->sp is
xzr under the current implementation. I suspect this causes spinlock lockup.

Please correct me if I'm wrong.

Best Regards
Jungseok Lee
