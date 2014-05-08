From: john.stultz@linaro.org (John Stultz)
Date: Thu, 08 May 2014 13:39:13 -0700
Subject: [PATCH] ARM: Don't ever downscale loops_per_jiffy in SMP systems
In-Reply-To: <alpine.LFD.2.11.1405081600260.980@knanqh.ubzr>
References: <1399504982-31181-1-git-send-email-dianders@chromium.org>
 <CAOh2x=kwaoSdj8JO0Vo08Y0dX2UfKFiF3pBV-qtp-YTyN=8H8Q@mail.gmail.com>
 <CAD=FV=UEGJGHrdcXgs3EZ_wFXT8GnNeCOMt7CgdiiUzBzZ5Y0A@mail.gmail.com>
 <alpine.LFD.2.11.1405081149190.980@knanqh.ubzr>
 <CAD=FV=VtcLOh51LCmafzRMdqtDrwKXCqK6gE6V7OOOUe4gjwbA@mail.gmail.com>
 <alpine.LFD.2.11.1405081329010.980@knanqh.ubzr>
 <20140508192209.GH3693@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1405081600260.980@knanqh.ubzr>
Message-ID: <536BEB71.9070007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2014 01:12 PM, Nicolas Pitre wrote:
> On Thu, 8 May 2014, Russell King - ARM Linux wrote:
>
>> So, the only /real/ solution if you want proper delays is for udelay()
>> to use a timer or counter, and this is should always the preferred
>> method where it's available.  Quite rightly, we're not hacking udelay()
>> stuff to work around not having that, or if someone configures it out.
> What about using a default based on ktime_get(), or even sched_clock(), 
> when SMP and cpufreq are configured in?

While somewhat rare these days, there are some systems that still only
have tick(jiffies)-granular time (as well as sched_clock), which might
be far too coarse for udelay, and in addition depends on irqs being
enabled to be able for time to progress.

The loops based delay is sort of a hack that allows fine grained (but
somewhat inaccurate) time delays in just about any context.

The problem being the loop based delays are somewhat fragile,
particularly as many of the assumptions for that code have been broken
(cpufreq scaling, ASMP, SMIs or other calibration issues, etc).  On
these systems where the assumptions are broken, time-based counter
delays are needed, but not always in place.

Thus I suspect we need something that provides proper warnings when we
are using loop delays on system that breaks its assumptions.

thanks
-john
