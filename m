From: ccross@android.com (Colin Cross)
Date: Tue, 16 Oct 2012 14:30:20 -0700
Subject: [PATCH 2/2] ARM: unwind: enable dumping stacks for SMP &&
 ARM_UNWIND
In-Reply-To: <20121016105504.GD21164@n2100.arm.linux.org.uk>
References: <1346021216-21979-1-git-send-email-ccross@android.com>
 <1346021216-21979-3-git-send-email-ccross@android.com>
 <20121012090807.GB21164@n2100.arm.linux.org.uk>
 <20121012100242.GA2126@linaro.org>
 <CAMbhsRRpYrOBhaFn5PV5f5J=36Hsj2eZixyD1hXRfRLoyWm1Xg@mail.gmail.com>
 <20121016101201.GA26075@linaro.org>
 <20121016105504.GD21164@n2100.arm.linux.org.uk>
Message-ID: <CAMbhsRTL=EgBcuSwsinNz5AiDV=39Z+6zaf6_s-7vZeHJ6N=8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 3:55 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Oct 16, 2012 at 11:12:01AM +0100, Dave Martin wrote:
>> On Mon, Oct 15, 2012 at 07:15:31PM -0700, Colin Cross wrote:
>> > About half the callers to unwind_frame end up limiting the number of
>> > frames they will follow before giving up, so I wasn't sure if I should
>> > put an arbitrary limit in unwind_frame or just make sure all callers
>> > are bounded.  Your idea of limiting same sp frames instead of total
>> > frames sounds better.  I can send a new patch that adds a new field to
>> > struct stackframe (which will need to be initialized everywhere, the
>> > struct is usually on the stack) and limits the recursion.  Any
>> > suggestion on the recursion limit?  I would never expect to see a real
>> > situation with more than a few, but on the other hand parsing the
>> > frames should be pretty fast so a high number (100?) shouldn't cause
>> > any user visible effect.
>>
>> Talking to some tools guys about this, it sounds like there really
>> shouldn't be any stackless frame except for the leaf frame.  If there are
>> stackless functions they will probably not be visible in the frame chain
>> at all.  So it might make sense to have a pretty small limit.  Maybe it
>> could even be 1.  Cartainly a small number.
>>
>> We should also add a check for whether the current and frame and previous
>> frame appear identical and abort if that's the case, if we don't do that
>> already.
>
> The case that actually worries me is not the "end up looping for ever"
> case, but the effects of having the stack change while the unwinder is
> reading from it - for example:
>
>                 /* pop R4-R15 according to mask */
>                 load_sp = mask & (1 << (13 - 4));
>                 while (mask) {
>                         if (mask & 1)
>                                 ctrl->vrs[reg] = *vsp++;
>                         mask >>= 1;
>                         reg++;
>                 }
>
> Remember that for a running thread, the stack will be changing all the
> time while another CPU tries to read it to do the unwind, and also
> remember that the bottom of stack isn't really known.  All you have is
> the snapshot of the registers when the thread was last stopped by the
> scheduler, and that state probably isn't valid.

If the snapshot of the registers when the thread was last stopped
includes an sp that points somewhere in two contiguous pages of low
memory, I don't see a problem.  From the sp we can get the bounds of
the stack (see the valid_stack_addr function I added), and we can make
sure the unwinder never dereferences anything outside of that stack,
so it will never fault.  We can also make sure that the sp stays
within that stack between frames, and moves in the right direction, so
it will never loop (except for the leaf-node sp issue, which Dave
Martin's idea will address).

> So what you're asking is for the unwinder to produce a backtrace from
> a kernel stack which is possibly changing beneath it from an unknown
> current state.

I don't think the stack changing is relevant.  With my modifications,
the unwinder can handle an invalid value at any place in the stack
without looping or crashing, and it doesn't matter if it is invalid
due to changing or permanent stack corruption.  The worst it will do
is produce a partial stack trace that ends with an invalid value.  For
example:

shell@:/ # dd if=/dev/urandom of=/dev/null bs=1000000 count=1000000 &
[1] 2709
130|shell@:/ # while true; do cat /proc/2709/stack; echo ---; done
[<c00084d4>] gic_handle_irq+0x24/0x58
[<c000e580>] __irq_svc+0x40/0x70
[<ffffffff>] 0xffffffff
---
[<00000099>] 0x99
[<ffffffff>] 0xffffffff
---
[<c0039728>] irq_exit+0x7c/0x98
[<c000f888>] handle_IRQ+0x50/0xac
[<c00084d4>] gic_handle_irq+0x24/0x58
[<00000014>] 0x14
[<ffffffff>] 0xffffffff
---
[<c087ac40>] rcu_preempt_state+0x0/0x140
[<ffffffff>] 0xffffffff
---
[<c00084d4>] gic_handle_irq+0x24/0x58
[<c000e580>] __irq_svc+0x40/0x70
[<ffffffff>] 0xffffffff
---
[<60000013>] 0x60000013
[<ffffffff>] 0xffffffff
---
[<d79ce000>] 0xd79ce000
[<ffffffff>] 0xffffffff

> This doesn't sound like a particularly bright thing to be doing...

As discussed previously, this already happens, has anyone ever
reported it as a problem?  Sysrq-t dumps all stacks by calling
dump_backtrace(), which bypasses the check for tsk == current.  And
any caller to unwind_backtrace with preemption on can see a changing
stack, even on UP.
