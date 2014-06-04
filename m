From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Wed, 4 Jun 2014 10:44:47 +0100
Subject: [PATCH v2 08/11] sched: get CPU's activity statistic
In-Reply-To: <20140604092313.GB11096@twins.programming.kicks-ass.net>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
 <20140528121001.GI19967@e103034-lin>
 <CAKfTPtDxeBfZK1AxCRqEG91pi--Ti1RYFoQPDhvMVnGTCspQ-g@mail.gmail.com>
 <20140528154703.GJ19967@e103034-lin>
 <20140603155007.GZ30445@twins.programming.kicks-ass.net>
 <CAKfTPtDUvH--WxFATTW6YRAvLuohzyNHDUq6DRdfxc7gRKCX6Q@mail.gmail.com>
 <20140604080809.GK30445@twins.programming.kicks-ass.net>
 <20140604085542.GH29593@e103034-lin>
 <20140604092313.GB11096@twins.programming.kicks-ass.net>
Message-ID: <20140604094447.GI29593@e103034-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 10:23:13AM +0100, Peter Zijlstra wrote:
> > f you had five tasks on one cpu that each have a 25% requirement you can
> > get individual task runnable_avgs of up to 100% (cpu unweighted
> > runnable_load_avg can get up 500%, I think), but the task running_avgs
> > would be 20% each (total of 100%). 
> 
> Yeah, more or less so indeed. I had not considered the queueing effects
> on runnable_avg yesterday, so good that that got raised.
> 
> That does indeed invalidate my: runnable - running := extra cpu required
> thing. It ends up being the extra cpu required for 0 latency but gobs of
> idle time, which is something else entirely.

Agreed, but I think it is still a useful estimate of the required
compute capacity. If there is a significant difference between runnable
and running on a cpu, the current mix of tasks is not good for latency.
However, we need to treat it as a worst case estimate and not necessarily
try to move exactly runnable-running worth of tasks to another cpu.

So far I haven't been able to come up with something better.
