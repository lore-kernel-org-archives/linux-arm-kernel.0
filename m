From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Wed, 4 Jun 2014 14:23:50 +0100
Subject: [PATCH v2 08/11] sched: get CPU's activity statistic
In-Reply-To: <20140604130918.GO29593@e103034-lin>
References: <20140603155007.GZ30445@twins.programming.kicks-ass.net>
 <CAKfTPtDUvH--WxFATTW6YRAvLuohzyNHDUq6DRdfxc7gRKCX6Q@mail.gmail.com>
 <20140604080809.GK30445@twins.programming.kicks-ass.net>
 <CAKfTPtBCG1Jq2b+fyoGuA=7yG_yUbsmaD+j-ZXXsPNGp5giKpg@mail.gmail.com>
 <20140604101724.GD11096@twins.programming.kicks-ass.net>
 <20140604103619.GL29593@e103034-lin>
 <CAKfTPtCVyLRG-fSge1shdw5aSDB3y=_qzU1DOVgCx0VBnn6mnA@mail.gmail.com>
 <20140604112342.GN29593@e103034-lin>
 <CAKfTPtCsxkypo_4e9zTHV_XPUt7-Bybot2uNOHUZVfbd=7vXHw@mail.gmail.com>
 <20140604130918.GO29593@e103034-lin>
Message-ID: <20140604132350.GP29593@e103034-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 02:09:18PM +0100, Morten Rasmussen wrote:
> On Wed, Jun 04, 2014 at 12:52:46PM +0100, Vincent Guittot wrote:
> > On 4 June 2014 13:23, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> > > I get:
> > >
> > > A: 15/40 ms = 37.5%
> > > B: 20/40 ms = 50%
> > >
> > > Schedule:
> > >
> > >    | 5 ms | 5 ms | 5 ms | 5 ms | 5 ms | 5 ms | 5 ms | 5 ms | 5 ms |
> > > A:   run     rq     run  ----------- sleeping -------------  run
> > > B:   rq      run    rq    run   ---- sleeping -------------  rq
> > >
> > >> and CPU runnable will be 60% too
> > >
> > > rq->avg.runnable_avg_sum should be 50%. You have two tasks running for
> > > 20 ms every 40 ms.
> > >
> > > Right?
> > 
> > ok, i see the misunderstood.
> > it's depends of what we mean by runnable. You take the % of time
> > whereas i take the runnable_avg_sum/period
> 
> Right. There is a difference.
> 
> > 
> > so A is on_rq 15/40 ms = 37.5% of the time which gives a
> > runnable_avg_sum/runnable_avg_period of 47%
> > B is on_rq  20/40 ms = 50% of the time which gives a
> > runnable_avg_sum/runnable_avg_period of 60%
> > and CPU has a task on its rq 20/40ms = 50% of the time which gives a
> > runnable_avg_sum/runnable_avg_period of 60%
> 
> Yes, that seems about right.

If my calculations are right, cfs.runnable_load_avg would peak 15 ms
into the period at about 104%. After 20 ms A has decayed more than B has
gained so the sum is slightly lower.
