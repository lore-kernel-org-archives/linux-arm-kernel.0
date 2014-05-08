From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 8 May 2014 13:43:29 -0400 (EDT)
Subject: [PATCH] ARM: Don't ever downscale loops_per_jiffy in SMP systems
In-Reply-To: <CAD=FV=VtcLOh51LCmafzRMdqtDrwKXCqK6gE6V7OOOUe4gjwbA@mail.gmail.com>
References: <1399504982-31181-1-git-send-email-dianders@chromium.org>
 <CAOh2x=kwaoSdj8JO0Vo08Y0dX2UfKFiF3pBV-qtp-YTyN=8H8Q@mail.gmail.com>
 <CAD=FV=UEGJGHrdcXgs3EZ_wFXT8GnNeCOMt7CgdiiUzBzZ5Y0A@mail.gmail.com>
 <alpine.LFD.2.11.1405081149190.980@knanqh.ubzr>
 <CAD=FV=VtcLOh51LCmafzRMdqtDrwKXCqK6gE6V7OOOUe4gjwbA@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1405081329010.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 May 2014, Doug Anderson wrote:

> Nicolas,
> 
> On Thu, May 8, 2014 at 9:04 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Thu, 8 May 2014, Doug Anderson wrote:
> >
> >> 1. Initially CPU1 and CPU2 at 200MHz.  Pretend loops_per_jiffy is 1000.
> >>
> >> 2. CPU1 starts a delay.  It reads global lpj (1000) and sets up its
> >> local registers up for the loop.
> >>
> >> 3. At the same time, CPU2 is transitioning the system to 2000MHz.
> >> Right after CPU1 reads lpj CPU2 stores it as 10000.
> >>
> >> 4. Now CPU1 and CPU2 are running at 2000MHz but CPU1 is only looping
> >> 1000 times.  It will complete too fast.
> >>
> >> ...you could possibly try to account for this in the delay loop code
> >> (being careful to handle all of the corner cases and races).  ...or we
> >> could make the delay loop super conservative and suggest that people
> >> should be using a real timer.
> >
> > I don't see how you can possibly solve this issue without a timer based
> > delay.  Even if you scale the loop count in only one direction, it will
> > still have this problem even though the window for the race would happen
> > much less often.  Yet having a delay which is way longer than expected
> > might cause problems in some cases.
> 
> You could possibly try to do something excessively clever by checking
> the loops per jiffy after the loop was done (and perhaps register for
> cpufreq changes so you know if it changed and then changed back)?  As
> I said, I don't think it's a good use of anyone's time.

Agreed.

> Longer delays aren't very good, but IMHO having some delays of 100 =>
> 1000 is better than having delays of 100 => 75.  The former will cause
> mostly performance problems and the later will cause real correctness
> problems.
> I'm not saying that 100 => 1000 is good, it's just less bad.

There might be some cases where precise timing is needed though.
I thought I came across one such case in the past but I can't remember 
which.

> Specifically even in a timer-based system you can't guarantee that a
> udelay(100) won't end up a udelay(1000) if the kernel finds something
> better to do than to run your code.  I agree that there might be code
> that breaks when a udelay(100) becomes a udelay(1000), but probably
> that code needs to be fixed to be more tolerant anyway.

The timer based udelay implementation does poll the timer, and if exact 
timing is important then you'll certainly turn off IRQs during the 
critical sequence.

[...]
> > SMP with shared clock for DVFS simply doesn't allow pure loop counts to
> > always be accurate.  Trying to fix a broken implementation with
> > something that is still broken to some extent, and maybe more in
> > some cases, doesn't look like much progress to me.
> 
> I totally agree that this doesn't really fix the problem nicely which
> is why I didn't send it initially.
> 
> I will make the argument that this patch makes things less broken
> overall on any systems that actually end up running this code, but if
> you want NAK it then it won't cause me any heartache.  ;)

What I insist on is for this issue to be solved using a stable counter 
such a timer when available.  It _is_ available on one of the target you 
mentioned so that is the solution you should add to your tree.  
Investigating a similar solution for your other target should be 
preferred to hacking the udelay loop. This way you're guaranteed to 
solve this problem fully.


Nicolas
