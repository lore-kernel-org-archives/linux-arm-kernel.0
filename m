From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 9 Apr 2014 21:34:44 +0200
Subject: current->sched_class->yield_task is NULL, any hint?
In-Reply-To: <CAF1ivSbVf0+PTzFdO+tNo33C6h6=HiBeKVF2jRvMQe=+RnPVxA@mail.gmail.com>
References: <CAF1ivSbZKbDc+rzd+CUqCzNmSgZmZTE-QeSU-2WmSiuEs-Kw_w@mail.gmail.com>
 <20140409182553.GE10526@twins.programming.kicks-ass.net>
 <CAF1ivSYeQcGf2d9kB-0R0TmCy=zaFg4WeJ2mgG_=K41hsoizyA@mail.gmail.com>
 <CAF1ivSbVf0+PTzFdO+tNo33C6h6=HiBeKVF2jRvMQe=+RnPVxA@mail.gmail.com>
Message-ID: <20140409193444.GA26782@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 11:49:17AM -0700, Lin Ming wrote:
> On Wed, Apr 9, 2014 at 11:32 AM, Lin Ming <minggr@gmail.com> wrote:
> > On Wed, Apr 9, 2014 at 11:25 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >> On Wed, Apr 09, 2014 at 10:43:32AM -0700, Lin Ming wrote:
> >>> Hi Peter,
> >>>
> >>> I hit a panic in sys_sched_yield() because(for some unknown reason)
> >>> current->sched_class->yield_task is NULL.
> >>> It's an ARM embedded board with 3.4-rt kernel.
> >>>
> >>> Could you share any hint for the possible causes?
> >>
> >> What class does current->sched_class point to?
> >
> > [12890.088232] Process swapper/0 (pid: 0, stack limit = 0xc07042f0)
> >
> > It's idle task. I think it should be idle_sched_class.
> > But let me double check it.
> 
> idle_sched_class has no "yield_task" defined.
> Does it mean that idle task should not call yield() at all?

Indeed. The idle task should never call yield. In fact, it should only
ever run the idle loop code, and that had better bloody not include a
yield call.
