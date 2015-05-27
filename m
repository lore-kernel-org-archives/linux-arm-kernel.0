From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 27 May 2015 10:51:13 +0200
Subject: [PATCH 1/7] perf: allow for PMU-specific event filtering
In-Reply-To: <20150522140844.GA1619@arm.com>
References: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
 <1431533549-27715-2-git-send-email-mark.rutland@arm.com>
 <20150522140844.GA1619@arm.com>
Message-ID: <20150527085113.GV3644@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 03:08:44PM +0100, Will Deacon wrote:
> Hi Mark,
> 
> On Wed, May 13, 2015 at 05:12:23PM +0100, Mark Rutland wrote:
> > In certain circumstances it may not be possible to schedule particular
> > events due to constraints other than a lack of hardware counters (e.g.
> > on big.LITTLE systems where CPUs support different events). The core
> > perf event code does not distinguish these cases and pessimistically
> > assumes that any failure to schedule an event means that it is not worth
> > attempting to schedule later events, even if some hardware counters are
> > still unused.
> > 
> > When an event a pmu cannot schedule exists in a flexible group list it
> > can unnecessarily prevent event groups following it in the list from
> > being scheduled (until it is rotated to the end of the list). This means
> > some events are scheduled for only a portion of the time they could be,
> > and for short running programs no events may be scheduled if the list is
> > initially sorted in an unfortunate order.
> > 
> > This patch adds a new (optional) filter_match function pointer to struct
> > pmu which a pmu driver can use to tell perf core when an event matches
> > pmu-specific scheduling requirements. This plugs into the existing
> > event_filter_match logic, and makes it possible to avoid the scheduling
> > problem described above. When no filter is provided by the PMU, the
> > existing behaviour is retained.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > ---
> >  include/linux/perf_event.h | 5 +++++
> >  kernel/events/core.c       | 8 +++++++-
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> Whilst I'm really keen to merge the architecture-specific parts of this
> series, I'm going to need an Ack from one of the perf core maintainers
> on this patch.
> 
> Peter, can you take a look please? (and I assume this is self-contained
> enough not to conflict heavily with the current perf queue?).

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Merge it however you like, but test merge against tip/perf/core or
something of that nature, if a conflict pops up, maybe keep this one
patch in a separate branch such that it can also be pulled into
tip/perf/core -- but as you say, I don't really suspect a conflict.
