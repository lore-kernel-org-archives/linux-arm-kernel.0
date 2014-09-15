From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 15 Sep 2014 13:42:29 +0200
Subject: [PATCH v5 11/12] sched: replace capacity_factor by utilization
In-Reply-To: <20140914194156.GC2832@worktop.localdomain>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-12-git-send-email-vincent.guittot@linaro.org>
 <20140911161517.GA3190@worktop.ger.corp.intel.com>
 <CAKfTPtDFuzxzGBKi_n6v_F8FUkQ84MW+dQBX4WNXo-o54mksGA@mail.gmail.com>
 <20140914194156.GC2832@worktop.localdomain>
Message-ID: <20140915114229.GB3037@worktop.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 14, 2014 at 09:41:56PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 11, 2014 at 07:26:48PM +0200, Vincent Guittot wrote:
> > On 11 September 2014 18:15, Peter Zijlstra <peterz@infradead.org> wrote:

> > > I'm confused about the utilization vs capacity_orig. I see how we should
> > 
> > 1st point is that I should compare utilization vs capacity and not
> > capacity_orig.
> > I should have replaced capacity_orig by capacity in the functions
> > above when i move the utilization statistic from
> > rq->avg.runnable_avg_sum to cfs.usage_load_avg.
> > rq->avg.runnable_avg_sum was measuring all activity on the cpu whereas
> > cfs.usage_load_avg integrates only cfs tasks
> > 
> > With this change, we don't need sgs->group_capacity_orig anymore but
> > only sgs->group_capacity. So sgs->group_capacity_orig can be removed
> > as it's no more used in the code as sg_capacity_factor has been
> > removed
> 
> Yes, but.. so I suppose we need to add DVFS accounting and remove
> cpufreq from the capacity thing. Otherwise I don't see it make sense.

OK, I've reconsidered _again_, I still don't get it.

So fundamentally I think its wrong to scale with the capacity; it just
doesn't make any sense. Consider big.little stuff, their CPUs are
inherently asymmetric in capacity, but that doesn't matter one whit for
utilization numbers. If a core is fully consumed its fully consumed, no
matter how much work it can or can not do.


So the only thing that needs correcting is the fact that these
statistics are based on clock_task and some of that time can end up in
other scheduling classes, at which point we'll never get 100% even
though we're 'saturated'. But correcting for that using capacity doesn't
'work'.
