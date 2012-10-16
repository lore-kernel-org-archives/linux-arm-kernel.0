From: ccross@android.com (Colin Cross)
Date: Tue, 16 Oct 2012 14:53:06 -0700
Subject: [PATCH 2/2] ARM: unwind: enable dumping stacks for SMP &&
 ARM_UNWIND
In-Reply-To: <20121016122658.GB26075@linaro.org>
References: <1346021216-21979-1-git-send-email-ccross@android.com>
 <1346021216-21979-3-git-send-email-ccross@android.com>
 <20121012090807.GB21164@n2100.arm.linux.org.uk>
 <20121012100242.GA2126@linaro.org>
 <CAMbhsRRpYrOBhaFn5PV5f5J=36Hsj2eZixyD1hXRfRLoyWm1Xg@mail.gmail.com>
 <20121016101201.GA26075@linaro.org>
 <20121016105504.GD21164@n2100.arm.linux.org.uk>
 <20121016122658.GB26075@linaro.org>
Message-ID: <CAMbhsRR2rZXs_aYgB1E0sn8_m-5dfcJmtQhtnydkTBtuiT9C8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 5:26 AM, Dave Martin <dave.martin@linaro.org> wrote:
> On Tue, Oct 16, 2012 at 11:55:04AM +0100, Russell King - ARM Linux wrote:
>> On Tue, Oct 16, 2012 at 11:12:01AM +0100, Dave Martin wrote:
>> > On Mon, Oct 15, 2012 at 07:15:31PM -0700, Colin Cross wrote:
>> > > About half the callers to unwind_frame end up limiting the number of
>> > > frames they will follow before giving up, so I wasn't sure if I should
>> > > put an arbitrary limit in unwind_frame or just make sure all callers
>> > > are bounded.  Your idea of limiting same sp frames instead of total
>> > > frames sounds better.  I can send a new patch that adds a new field to
>> > > struct stackframe (which will need to be initialized everywhere, the
>> > > struct is usually on the stack) and limits the recursion.  Any
>> > > suggestion on the recursion limit?  I would never expect to see a real
>> > > situation with more than a few, but on the other hand parsing the
>> > > frames should be pretty fast so a high number (100?) shouldn't cause
>> > > any user visible effect.
>> >
>> > Talking to some tools guys about this, it sounds like there really
>> > shouldn't be any stackless frame except for the leaf frame.  If there are
>> > stackless functions they will probably not be visible in the frame chain
>> > at all.  So it might make sense to have a pretty small limit.  Maybe it
>> > could even be 1.  Cartainly a small number.
>> >
>> > We should also add a check for whether the current and frame and previous
>> > frame appear identical and abort if that's the case, if we don't do that
>> > already.
>>
>> The case that actually worries me is not the "end up looping for ever"
>> case, but the effects of having the stack change while the unwinder is
>> reading from it - for example:
>>
>>                 /* pop R4-R15 according to mask */
>>                 load_sp = mask & (1 << (13 - 4));
>>                 while (mask) {
>>                         if (mask & 1)
>>                                 ctrl->vrs[reg] = *vsp++;
>>                         mask >>= 1;
>>                         reg++;
>>                 }
>>
>> Remember that for a running thread, the stack will be changing all the
>> time while another CPU tries to read it to do the unwind, and also
>> remember that the bottom of stack isn't really known.  All you have is
>> the snapshot of the registers when the thread was last stopped by the
>> scheduler, and that state probably isn't valid.
>
> So long as the unwinder enforces continuous progress towards a fixed
> limit, sooner or later the supposed bottom of the stack will be reached,
> or the unwinder will encounter something which is recognised as garbage
> and stop.
>
> This the best we can hope for if trying to print a backtrace for a
> thread without stopping it...  which admittedly seems quite a dodgy
> thing to attempt.
>
> Colin, what are the scenarios when we want to backtrace a thread while
> it is actually running?

There is no case where I want a backtrace from a running thread other
than current, but there is no way to guarantee that the thread won't
start running unless we stick it in the freezer, which has other
problems.  The main use case is dumping /proc/pid/stack for all
threads in the process when the thread is deadlocked.  Most likely
none of them will be running, and if they are running I don't care
about the stack.

If the unwinder is made safe against running tasks,
save_stack_trace_tsk could print an error if the task is running
(because it has no idea when it will stop running), then capture the
stack and test that the thread is still not running and the number of
context switches on the task hasn't increased, otherwise retry.  That
way we'll get an error from a running task, but still be able to dump
blocked tasks that are not current.  It still relies on being able to
call unwind_frame on a possibly invalid stack.

>> So what you're asking is for the unwinder to produce a backtrace from
>> a kernel stack which is possibly changing beneath it from an unknown
>> current state.
>>
>> This doesn't sound like a particularly bright thing to be doing...
>
> Nonetheless, the changes are relevant to normal stack dumping too, since
> when we take a fault the sp or stack may be corrupted, even if the
> thread in question is stopped.  Being more robust against infinte loops
> etc., still seems like a good idea ?

I can split out the unwind_frame hardening from the
save_stack_trace_tsk part if you only want that part, and I'll put the
save_stack_trace_tsk chunk in the Android tree.
