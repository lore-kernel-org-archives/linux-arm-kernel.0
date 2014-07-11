From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 11 Jul 2014 22:12:38 +0200
Subject: [PATCH v3 09/12] Revert "sched: Put rq's sched_avg under
 CONFIG_FAIR_GROUP_SCHED"
In-Reply-To: <CAKfTPtCL6mta75k9eoK724wCm7S3w7E+psa1XDrxhN1YVDONPw@mail.gmail.com>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-10-git-send-email-vincent.guittot@linaro.org>
 <20140710131646.GB3935@laptop>
 <CAKfTPtDzxyrzVmX016VB8j_y19wcCBVB1Rj46FYngMA+Ajft6g@mail.gmail.com>
 <20140711151304.GD3935@laptop>
 <CAKfTPtCL6mta75k9eoK724wCm7S3w7E+psa1XDrxhN1YVDONPw@mail.gmail.com>
Message-ID: <20140711201238.GY20603@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 07:39:29PM +0200, Vincent Guittot wrote:
> In my mind, arch_scale_cpu_freq was intend to scale the capacity of
> the CPU according to the current dvfs operating point.
> As it's no more use anywhere now that we have arch_scale_cpu, we could
> probably remove it .. and see when it will become used.

I probably should have written comments when I wrote that code, but it
was meant to be used only where, as described above, we limit things.
Ondemand and such, which will temporarily decrease freq, will ramp it up
again at demand, and therefore lowering the capacity will skew things.

You'll put less load on because its run slower, and then you'll run it
slower because there's less load on -> cyclic FAIL.

> > In that same discussion ISTR a suggestion about adding avg_running time,
> > as opposed to the current avg_runnable. The sum of avg_running should be
> > much more accurate, and still react correctly to migrations.
> 
> I haven't look in details but I agree that avg_running would be much
> more accurate than avg_runnable and should probably fit the
> requirement. Does it means that we could re-add the avg_running (or
> something similar) that has disappeared during the review of load avg
> tracking patchset ?

Sure, I think we killed it there because there wasn't an actual use for
it and I'm always in favour of stripping everything to their bare bones,
esp big and complex things.

And then later, add things back once we have need for it.
