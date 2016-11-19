From: slash.tmp@free.fr (Mason)
Date: Sat, 19 Nov 2016 19:29:22 +0100
Subject: [PATCH] arm: spin one more cycle in timer-based delays
In-Reply-To: <20161119110301.GQ1041@n2100.armlinux.org.uk>
References: <582B0F61.6030903@free.fr> <20161118120630.GJ13470@arm.com>
 <20161118125409.GK1041@n2100.armlinux.org.uk> <582F0DD2.3030805@free.fr>
 <20161119071702.GA25647@afzalpc>
 <20161119110301.GQ1041@n2100.armlinux.org.uk>
Message-ID: <58309A02.4030804@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/2016 12:03, Russell King - ARM Linux wrote:

> Linus, please see the comment and patch at the bottom of this mail.
> Thanks.
> 
> On Sat, Nov 19, 2016 at 12:47:02PM +0530, Afzal Mohammed wrote:
>> Hi Mason,
>>
>> On Fri, Nov 18, 2016 at 03:18:58PM +0100, Mason wrote:
>>> On 18/11/2016 13:54, Russell King - ARM Linux wrote:
>>
>>>> So, NAK on this change.  udelay is not super-accurate.
>>>
>>> usleep_range() fixed this issue recently.
>>> 6c5e9059692567740a4ee51530dffe51a4b9584d
>>> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=timers/core&id=6c5e9059692567740a4ee51530dffe51a4b9584d
>>
>> But the above "timers: Fix usleep_range() in the context of
>> wake_up_process()" is to avoid wakeup causing premature return than
>> about being precise, no ?
> 
> usleep*() is different from udelay().  usleep*() is not based on looping
> a certain number of times, and doesn't involve calibration of such a
> loop.

You keep saying that udelay is loop-based. That's merely the fall-back,
when nothing better is available. As you know, there are several better
arch-specific options available (peterz described some on x86).

On my platform, udelay polls a platform tick counter. (In fact, you
were the one to recommend that solution to me years ago). This tick
counter is tied to a high-precision crystal, the error of which is
measured in parts per million. The memory bus to this device offers
some guarantees for the access latency.

IIUC, arm and arm64 even have an architected counter that is
guaranteed to tick at constant frequency, and is accessible
without leaving the CPU core.


> usleep*() is based on the scheduler, which has tighter
> requirements laid down in POSIX amongst other standards, such as "not
> timing out before this specified time" (due to things like select(),
> poll(), etc.)  udelay() is purely a kernel thing, unspecified by any
> standard.

The "problem" with udelay is that the same API exists on every single
kernel ever written, and users have implicit expectations about the
implementation. (Principle of least astonishment)


>> With conflicting opinion on delay/sleep fn's from the players, the one
>> in gallery would get confused.
>>
>> But Linus has mentioned udelay as not meant to be precise, okay ?
> 
> Exactly - and the reason for that (as I've explained several times in
> the past) the "standard" software delay loop calibrated against the
> timer interrupt is _always_ going to be short.

OK, so loop-based delays are known to be short. Would you or Linus
accept a patch that adds a X% cushion *in the implementation* ?

You are saying "people shouldn't expect udelay(10) to delay at least
10 ?s, thus they should write udelay(10+N)".

Why not hide that implementation detail inside the implementation,
so as not to force the pessimization on every other implementation
behind the udelay/ndelay wrapper?

void loop_based_udelay(long us) {
  spin_for_some_us(us + us/8);
}


> I explain why this is in the message to which Linus replied:
> 
>   http://lists.openwall.net/linux-kernel/2011/01/09/56
> 
> A consequence of the formula that I give in (2) in that mail is that
> the higher the HZ value, the more error in the resulting value of
> loops_per_jiffy, and the shorter udelay(1) than 1us will be, since
> "timer_interrupt_usec" is a constant but "usec_per_jiffy" reduces.
> 
> So folk need to put the idea that "udelay(1) will always be at least
> 1us" out of their minds - that's simply not guaranteed by the kernel.
> Linus' reply also indicates that we don't care if it's out by 5%,
> and probably more than that too.
> 
> If someone can show that our timer-based udelay() produces an error
> more than 5%, then I'll apply the patch.

I gave an example where ndelay had a 60% error (37 instead of 100 ns).

If one is using a 1 MHz clock for timer-based delays, udelay(1)
will randomly return immediately (100% error).


> What I don't want to do is
> to apply the patch because someone thinks that udelay() should not
> return early.  Applying it in that case has the effect of re-inforcing
> what is an incorrect assumption, leading to people writing buggy drivers
> that have delays which are too finely "tuned" - which may work with a
> timer-based udelay() but cause failures with a loop-based udelay().

Again, I think it would be much smarter to hide this quirk within
the loop-based delay implementation.

Why is it unacceptable to "fix" the API, instead of fixing the
expectations of driver writers?


> This is all about ensuring that driver authors do the right thing.

What is the rationale behind the devm managed resources?
Driver writers were getting things wrong, and the kernel
provided a framework to help them with the hard part.

Likewise, instead of setting them up to fail with a quirky
delay routine, why not help them by writing an implementation
to match their expectation?


> Linus, how about we add something like this to linux/delay.h to document
> this fact?
> 
>  include/linux/delay.h | 12 +++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/delay.h b/include/linux/delay.h
> index a6ecb34cf547..2ecb3c46b20a 100644
> --- a/include/linux/delay.h
> +++ b/include/linux/delay.h
> @@ -5,6 +5,18 @@
>   * Copyright (C) 1993 Linus Torvalds
>   *
>   * Delay routines, using a pre-computed "loops_per_jiffy" value.
> + *
> + * Please note that ndelay(), udelay() and mdelay() may return early for
> + * several reasons:
> + *  1. computed loops_per_jiffy too low (due to the time taken to
> + *     execute the timer interrupt.)
> + *  2. cache behaviour affecting the time it takes to execute the
> + *     loop function.
> + *  3. CPU clock rate changes.
> + * As a result, delays should always be over-stated.
> + *
> + * Please see this thread:
> + *   http://lists.openwall.net/linux-kernel/2011/01/09/56

(None of the reasons you stated affect a tick-counter-based delay.)

If one wants a 100 ns delay, what should one write?
If one wants a 1 ?s delay, what should one write?
If one wants a 100 ?s delay, what should one write?
Is the relative error constant?
Is there a constant component in the error, independent of requested delay?

It seems to me you're saying "on platform A, udelay has 50%
error, so driver writers should write udelay(N+N/2);"

The code is now unnecessarily pessimized on hundreds of platform
that don't have that behavior.

Why not fix the implementation of that platform's udelay to
add the padding itself? That way, other platforms are not
hampered by that platform's ineptitude.

Regards.
