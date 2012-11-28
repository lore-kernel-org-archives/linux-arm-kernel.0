From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Nov 2012 12:34:58 +0000
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <20121127010203.GC21160@jl-vm1.vm.bytemark.co.uk>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121122113401.GC3113@mudshark.cambridge.arm.com>
 <50B2679F.3070107@gmail.com>
 <20121126111337.GA13312@mudshark.cambridge.arm.com>
 <20121126151534.GA13620@mudshark.cambridge.arm.com>
 <20121127010203.GC21160@jl-vm1.vm.bytemark.co.uk>
Message-ID: <20121128123458.GC21671@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

On Tue, Nov 27, 2012 at 01:02:03AM +0000, Jamie Lokier wrote:
> Will Deacon wrote:
> > That was a fun bit of debugging -- my hunch was right,
> 
> Yes it was.
> 
> I'll sum up what I found looking at the x86 version.
> Brief summary:
> 
>    1. Due to preemption, it's not safe to cache per-CPU values within
>       a function in general.
>    2. Except, if they are per-thread values (like current and
>       current_thread_info) that don't depend on the CPU and just use
>       per-CPU for efficient reading.
>    3. So, implement separate this_cpu_read_stable() and
>       this_cpu_read() if you want GCC to cache certain values that are
>       safe to cache.
>    4. Use asm volatile, not just an "m" constraint.  I think x86 has a
>       bug by using just "m" for this_cpu_read().
> 
> Long version:
> 
>    - It's not really about the code in schedule().  It's about when
>      context switch can happen.  Which is every instruction in a
>      preemptible context.

I disagree. You don't get magically pre-empted: control must pass through
context_switch to put you on a runqueue and choose a different task. With
PREEMPT, this can happen in response to an interrupt but the state of the
interrupted context is still correctly saved/restored via switch_to and
friends.

If a function accesses per-cpu data when preemptible(), then it must be
prepared to handle the pointer being incorrect (and this does seem to be
used: see slab_alloc_node, called during kmalloc, for example). So actually,
the only case of note *is* __schedule. Why? Because preemption is disabled,
but half of the function may appear to execute on one CPU and the other half
(i.e. once the task has been rescheduled from a different runqueue) may
execute on a different CPU.

The solution is to make the per-cpu offset reader hazard with
context-switch/barrier(). I tried Nico's suggestion of adding a memory
clobber and it seems to work pretty well, without any noticeable degradation
in quality of the generated code that I could spot:


diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index 9c8d051..2e58a1d 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -24,13 +24,15 @@
 
 static inline void set_my_cpu_offset(unsigned long off)
 {
-       asm volatile("mcr p15, 0, %0, c13, c0, 4        @ set TPIDRPRW" : : "r" (off) );
+       /* Set TPIDRPRW */
+       asm volatile("mcr p15, 0, %0, c13, c0, 4" : : "r" (off) : "memory");
 }
 
 static inline unsigned long __my_cpu_offset(void)
 {
        unsigned long off;
-       asm("mrc p15, 0, %0, c13, c0, 4 @ get TPIDRPRW" : "=r" (off) : );
+       /* Read TPIDRPRW */
+       asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : : "memory");
        return off;
 }
 #define __my_cpu_offset __my_cpu_offset()


>    - That seems like a nice trick, allowing some reads to be reused
>      between instructions.  It can be replicated even on other archs,
>      using an "m" constraint on a dummy extern variable (no need to
>      actually read anything!).  But I'm not convinced this isn't a bug
>      on x86.  Consider this code:

The "m" constraint probably isn't what we want. Firstly, it will cause GCC
to emit instructions to calculate the address of whatever the dummy extern
variable is (probably a PC-relative load to get its address) and secondly,
GCC may generate a post-increment/decrement addressing mode with the
assumption that it will be evaluated exactly once in the asm block. You
could use "o", but you still have to load the address.

> #include <linux/percpu.h>
> #include <linux/preempt.h>
> #include <linux/preempt.h>
> 
> DEFINE_PER_CPU(int, myvar1) = 0;
> DEFINE_PER_CPU(int, myvar2) = 0;
> 
> static spinlock_t mylock = SPIN_LOCK_UNLOCKED;

Guessing this should be raw?

> int mytest(void)
> {
>         long flags;
>         int x, y, z;
> 
>         x = this_cpu_read(myvar1);

If it's important that the CPU doesn't change, this read into x should happen
inside the critical section.

>         spin_lock_irqsave(&mylock, flags);
> 
>         /*
>          * These two values should be consistent due to irqsave: No
>          * preemption, no interrupts.  But on x86, GCC can reuse the x
>          * above for the value of y.  If preemption happened before the
>          * irqsave, y and z are not consistent.
>          */
>         y = this_cpu_read(myvar1);
>         z = this_cpu_read(myvar2);
>         spin_unlock_irqrestore(&mylock, flags);
> 
>         return y + z;
> }

Will
