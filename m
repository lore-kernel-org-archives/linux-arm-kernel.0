From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 3 Jun 2014 19:37:41 +0200
Subject: [PATCH v2 08/11] sched: get CPU's activity statistic
In-Reply-To: <20140603171628.GE29593@e103034-lin>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-9-git-send-email-vincent.guittot@linaro.org>
 <20140528121001.GI19967@e103034-lin>
 <20140603154058.GY30445@twins.programming.kicks-ass.net>
 <20140603171628.GE29593@e103034-lin>
Message-ID: <20140603173741.GE13930@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 06:16:28PM +0100, Morten Rasmussen wrote:
> > I'm not too worried about the tipping point, per task runnable figures
> > of an overloaded cpu are higher, so migration between an overloaded cpu
> > and an underloaded cpu are going to be tricky no matter what we do.
> 
> Yes, agreed. I just got the impression that you were concerned about
> smp_nice last time we discussed this.

Well, yes, we need to keep that working, but the exact detail around the
tipping point are near impossible to get right, so I'm not too bothered
there.

> > > rq runnable_avg_sum is useful for decisions where we need a longer term
> > > view of the cpu utilization, but I don't see how we can use as cpu
> > > utilization metric for load-balancing decisions at wakeup or
> > > periodically.
> > 
> > So keeping one with a faster decay would add extra per-task storage. But
> > would be possible..
> 
> I have had that thought when we discussed potential replacements for
> cpu_load[]. It will require some messing around with the nicely
> optimized load tracking maths if we want to have load tracking with a
> different y-coefficient.

My initial thought was a y=0.5, which is really >>=1. But yes, if we
want something else that'll get messy real fast methinks.
