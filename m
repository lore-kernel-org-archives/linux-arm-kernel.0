From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 27 Nov 2012 01:02:03 +0000
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <20121126151534.GA13620@mudshark.cambridge.arm.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121122113401.GC3113@mudshark.cambridge.arm.com>
 <50B2679F.3070107@gmail.com>
 <20121126111337.GA13312@mudshark.cambridge.arm.com>
 <20121126151534.GA13620@mudshark.cambridge.arm.com>
Message-ID: <20121127010203.GC21160@jl-vm1.vm.bytemark.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> On Mon, Nov 26, 2012 at 11:13:37AM +0000, Will Deacon wrote:
> > On Sun, Nov 25, 2012 at 06:46:55PM +0000, Rob Herring wrote:
> > > On 11/22/2012 05:34 AM, Will Deacon wrote:
> > > > As an aside, you also need to make the asm block volatile in
> > > > __my_cpu_offset -- I can see it being re-ordered before the set for
> > > > secondary CPUs otherwise.
> > > 
> > > I don't really see where there would be a re-ordering issue. There's no
> > > percpu var access before or near the setting that I can see.
> > 
> > The issue is on bringing up the secondary core, so I assumed that a lot
> > of inlining goes on inside secondary_start_kernel and then the result is
> > shuffled around, placing a cpu-offset read before we've done the set.
> > 
> > Unfortunately, looking at the disassembly I can't see this happening at
> > all, so I'll keep digging. The good news is that I've just reproduced the
> > problem on the model, so I've got more visibility now (although both cores
> > are just stuck in spinlocks...).
> 
> That was a fun bit of debugging -- my hunch was right,

Yes it was.

I'll sum up what I found looking at the x86 version.
Brief summary:

   1. Due to preemption, it's not safe to cache per-CPU values within
      a function in general.
   2. Except, if they are per-thread values (like current and
      current_thread_info) that don't depend on the CPU and just use
      per-CPU for efficient reading.
   3. So, implement separate this_cpu_read_stable() and
      this_cpu_read() if you want GCC to cache certain values that are
      safe to cache.
   4. Use asm volatile, not just an "m" constraint.  I think x86 has a
      bug by using just "m" for this_cpu_read().

Long version:

   - It's not really about the code in schedule().  It's about when
     context switch can happen.  Which is every instruction in a
     preemptible context.

   - this_cpu (and __my_cpu_offset) need to reload the per-CPU offset
     each time.  This is because per-CPU offset can change on every
     instruction in a preemptible context.

   - For task-dependent values like current and current_thread_info(),
     x86 uses a variant called this_cpu_read_stable().  That is
     allowed to be cached by GCC across barrier() and in general.

   - Probably this_cpu_read_stable() ought to be available more
     generically across archs

   - That means interaction with barrier(), and with switch_to(),
     aren't relevant.  There are two flavours: Safe to cache always,
     and safe to cache never.  (If you count !CONFIG_PREEMPT maybe
     it's different, but that's tweaking.)

   - x86 __my_cpu_offset does a memory read, using an "m" asm
     constraint on a per-CPU variable (this_cpu_off).  This makes it
     sensitive to barrier(), and otherwise cache the value.  It's a
     nice trick, if it's safe.

   - That seems like a nice trick, allowing some reads to be reused
     between instructions.  It can be replicated even on other archs,
     using an "m" constraint on a dummy extern variable (no need to
     actually read anything!).  But I'm not convinced this isn't a bug
     on x86.  Consider this code:

#include <linux/percpu.h>
#include <linux/preempt.h>
#include <linux/preempt.h>

DEFINE_PER_CPU(int, myvar1) = 0;
DEFINE_PER_CPU(int, myvar2) = 0;

static spinlock_t mylock = SPIN_LOCK_UNLOCKED;

int mytest(void)
{
        long flags;
        int x, y, z;

        x = this_cpu_read(myvar1);

        spin_lock_irqsave(&mylock, flags);

        /*
         * These two values should be consistent due to irqsave: No
         * preemption, no interrupts.  But on x86, GCC can reuse the x
         * above for the value of y.  If preemption happened before the
         * irqsave, y and z are not consistent.
         */
        y = this_cpu_read(myvar1);
        z = this_cpu_read(myvar2);
        spin_unlock_irqrestore(&mylock, flags);

        return y + z;
}

I think the optimisation behaviour of this_cpu_read() is unsafe on x86
for the reason in the comment above.  I have tested with GCC 4.5.2 on
x86-32 and it really does what the comment says.

Curiously all uses of __this_cpu_ptr() are fine: that asm uses
volatile.  I think this_cpu_read() also needs the volatile; but not
this_cpu_read_stable().

It's rather subtle and I wouldn't be surprised if I'm mistaken.

Best,
-- Jamie
