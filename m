From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 8 May 2014 16:12:14 -0400 (EDT)
Subject: [PATCH] ARM: Don't ever downscale loops_per_jiffy in SMP systems
In-Reply-To: <20140508192209.GH3693@n2100.arm.linux.org.uk>
References: <1399504982-31181-1-git-send-email-dianders@chromium.org>
 <CAOh2x=kwaoSdj8JO0Vo08Y0dX2UfKFiF3pBV-qtp-YTyN=8H8Q@mail.gmail.com>
 <CAD=FV=UEGJGHrdcXgs3EZ_wFXT8GnNeCOMt7CgdiiUzBzZ5Y0A@mail.gmail.com>
 <alpine.LFD.2.11.1405081149190.980@knanqh.ubzr>
 <CAD=FV=VtcLOh51LCmafzRMdqtDrwKXCqK6gE6V7OOOUe4gjwbA@mail.gmail.com>
 <alpine.LFD.2.11.1405081329010.980@knanqh.ubzr>
 <20140508192209.GH3693@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1405081600260.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 May 2014, Russell King - ARM Linux wrote:

> Anything which is expecting precise timings from udelay() is broken.
> Firstly, udelay() does _not_ guarantee to give you a delay of at least
> the requested period - it tries to give an _approximate_ delay.
> 
> The first thing to realise is that loops_per_jiffy is calibrated with
> interrupts _on_, which means that the calculated loops_per_jiffy is
> the number of iterations in a jiffy _minus_ the time it takes for the
> timer interrupt to be processed.  This means loops_per_jiffy will
> always be smaller than the number of loops that would be executed
> within the same period.
> 
> This leads to udelay() always producing slightly shorter than
> requested delays - this is quite measurable.

OK, this is certainly bad.  Hopefully it won't be that far off like it 
would when the CPU is in the middle of a clock freq transition.

> It gets worse when you consider the utter mess that the L2 cache code
> is in - where on many platforms we calibrate udelay() with the cache
> off, which results in loops_per_jiffy being smaller than it would
> otherwise be (meaning shorter delays.)
> 
> So, that's two reasons there why loops_per_jiffy will be smaller than
> it should be at boot, and therefore udelay() will be inaccurate.
> 
> Another reason udelay() can be unaccurate is if interrupts are on, and
> you have USB present.  USB interrupt processing can take on the order
> of 10s of milliseconds even on 800MHz or faster ARM CPUs.  If you
> receive one of those mid-udelay(), your CPU will be occupied elsewhere.
> 
> Another reason is preempt.  If the kernel can preempt during udelay(),
> your delay will also be much longer than you requested.  No, disabling
> preemption in udelay() is not on, that would increase preemption
> latency.
> 
> So, the only /real/ solution if you want proper delays is for udelay()
> to use a timer or counter, and this is should always the preferred
> method where it's available.  Quite rightly, we're not hacking udelay()
> stuff to work around not having that, or if someone configures it out.

What about using a default based on ktime_get(), or even sched_clock(), 
when SMP and cpufreq are configured in?


Nicolas
