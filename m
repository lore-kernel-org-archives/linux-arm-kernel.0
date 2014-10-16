From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 16 Oct 2014 10:23:52 +0100
Subject: [PATCH 3.17-rc4 v7 0/6] arm: Implement
 arch_trigger_all_cpu_backtrace
In-Reply-To: <CAD8Lp44gPOBh_q1zDy3y1GkrRVAvix5YaNr-+E92+g8Q7fLKJA@mail.gmail.com>
References: <1410970218-28847-1-git-send-email-daniel.thompson@linaro.org>
 <CAD8Lp44gPOBh_q1zDy3y1GkrRVAvix5YaNr-+E92+g8Q7fLKJA@mail.gmail.com>
Message-ID: <543F8EA8.6080905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/14 23:37, Daniel Drake wrote:
> Hi,
> 
> Thanks a lot for working on this!
> 
> On Wed, Sep 17, 2014 at 10:10 AM, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
>> Changes *before* v1:
>>
>> * This patchset is a hugely cut-down successor to "[PATCH v11 00/19]
>>   arm: KGDB NMI/FIQ support". Thanks to Thomas Gleixner for suggesting
>>   the new structure. For historic details see:
>>         https://lkml.org/lkml/2014/9/2/227
> 
> What's the right way to extend your work in order to get a NMI-like
> watchdog hard lockup detector similar to the one on x86?

There are a few things to get into place for this.

1. Figure out what number to put into the PMU to get an interrupt every
   10s and provide the stub functions for the lock up detector.

2. Modify the current ARM PMU support to make is possible for this code
   to run from a FIQ handler. This should be feasible by replicating
   the design pattern used on x86. Nevertheless this is a fairly big
   chunk of code review and testing.

3. Modify the Linux IRQ support to allow some kind of flag to
   hint/demand that an interrupt be treated as NMI-ish in order to
   switch (unshared) interrupts into FIQ mode and hook this up in
   the GIC.

   [Side note, this approach was suggested by Thomas Gleixner in
   response to some rather hacky patches from me. My patches are
   robust enough but are poorly designed and hard to maintain.
   Thus if you want to do any quick prototyping you might skip this
   step and dig out my old patches:

https://git.linaro.org/people/daniel.thompson/linux.git/shortlog/refs/heads/dev/kdb-fiq

Note also that, as a side effect of the above, tools like oprofile would
also get a very significant boost for kernel profiling because they
would no longer attribute time spent in interrupt handlers to interrupt
unmask functions.

At present I've done a little work towards all three of the above but
none are complete (most of the code has never been executed).


> I'm testing your patches on Exynos4412 and I guess in their current
> state they don't go quite this deep, as the only callers of
> trigger_all_cpu_backtrace() are sysrq, hung_task and spinlock debug
> code - none of which seem as fail-safe as a trigger like a
> pre-programmed watchdog NMI interrupt would be.
> 
> Do I need to find a way to get CONFIG_FIQ available on this platform
> first? and/or CONFIG_HARDLOCKUP_DETECTOR?

You need CONFIG_FIQ working first. Be aware that this may be impossible
on Exynos unless you control the TrustZone. For this reason most of my
development is on Freescale i.MX6 (because i.MX6 boots in secure mode).


Daniel.
