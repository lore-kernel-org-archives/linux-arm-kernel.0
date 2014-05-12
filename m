From: dianders@chromium.org (Doug Anderson)
Date: Mon, 12 May 2014 16:51:32 -0700
Subject: [PATCH] ARM: Don't ever downscale loops_per_jiffy in SMP systems#
In-Reply-To: <alpine.LFD.2.11.1405091640090.980@knanqh.ubzr>
References: <CAD=FV=UEGJGHrdcXgs3EZ_wFXT8GnNeCOMt7CgdiiUzBzZ5Y0A@mail.gmail.com>
 <alpine.LFD.2.11.1405081149190.980@knanqh.ubzr>
 <CAD=FV=VtcLOh51LCmafzRMdqtDrwKXCqK6gE6V7OOOUe4gjwbA@mail.gmail.com>
 <alpine.LFD.2.11.1405081329010.980@knanqh.ubzr>
 <20140508192209.GH3693@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1405081600260.980@knanqh.ubzr>
 <20140508205223.GI3693@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1405082058130.980@knanqh.ubzr>
 <20140509091824.GL3693@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1405091245070.980@knanqh.ubzr>
 <20140509182245.GM3693@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1405091640090.980@knanqh.ubzr>
Message-ID: <CAD=FV=UJK1nSPjH-au-KtbnOZk2nC7usLD8L9neMedj6WHUp8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 9, 2014 at 2:05 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Fri, 9 May 2014, Russell King - ARM Linux wrote:
>
>> I'd much prefer just printing a warning at kernel boot time to report
>> that the kernel is running with features which would make udelay() less
>> than accurate.
>
> What if there is simply no timer to rely upon, as in those cases where
> interrupts are needed for time keeping to make progress?  We should do
> better than simply saying "sorry your kernel should irradicate every
> udelay() usage to be reliable".
>
> And I mean "reliable" which is not exactly the same as "accurate".
> Reliable means "never *significantly* shorter".
>
>> Remember, it should be usable for _short_ delays on slow machines as
>> well as other stuff, and if we're going to start throwing stuff like
>> the above at it, it's going to become very inefficient.
>
> You said that udelay can be much longer than expected due to various
> reasons.
>
> You also said that the IRQ handler overhead during udelay calibration
> makes actual delays slightli shorter than expected.
>
> I'm suggesting the addition of a slight overhead that is much smaller
> than the IRQ handler here.  That shouldn't impact things masurably.
> I'd certainly like Doug to run his udelay timing test with the following
> patch to see if it solves the problem.

...so I spent a whole chunk of time debugging this problem today.  I'm
out of time today (more tomorrow), but it looks like the theory I
proposed about why udelay() is giving bad results _might_ have more to
do with bugs in the exynos cpufreq driver and less to do with the
theoretical race we've been talking about.  It looks possible that the
driver is not setting the "old" frequency properly, which would
certainly cause problems.

I'll post more when I figure this out for sure.

-Doug
