From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Feb 2016 11:33:50 +0000
Subject: [RFC PATCH 1/7] arm64/perf: Basic uncore counter support for
 Cavium ThunderX
In-Reply-To: <56BE8B2D.1000001@gmail.com>
References: <cover.1455295032.git.jglauber@cavium.com>
 <8bd93a25e069ed6428bc6c21fc53270962ccafcc.1455295032.git.jglauber@cavium.com>
 <20160212173658.GD20262@leverpostej> <56BE8B2D.1000001@gmail.com>
Message-ID: <20160215113350.GB9732@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 05:47:25PM -0800, David Daney wrote:
> On 02/12/2016 09:36 AM, Mark Rutland wrote:
> >On Fri, Feb 12, 2016 at 05:55:06PM +0100, Jan Glauber wrote:
> [...]
> >>2) Counters are summarized across the different units of the same type,
> >>    e.g. L2C TAD 0..7 is presented as a single counter (adding the
> >>    values from TAD 0 to 7). Although losing the ability to read a
> >>    single value the merged values are easier to use and yield
> >>    enough information.
> >
> >I'm not sure I follow this. What is easier? What are you doing, and what
> >are you comparing that with to say that your approach is easier?
> >
> >It sounds like it should be possible to handle multiple counters like
> >this, so I don't follow why you want to amalgamate them in-kernel.
> >
> 
> The values of the individual counters are close to meaningless.  The
> only thing that is meaningful to someone reading the counters is the
> aggregate sum of all the counts.

I obviously know nowhere near enough about your system to say with
certainty, but it may turn out that being able to track counters
individually is useful for some profiling/debugging scenario. How
meaningful the individual counts are really depends on what you're
trying to figure out.

If you believe that aggregate values are sufficient, then I'm happy to
leave that as-is.

> >>+void thunder_uncore_read(struct perf_event *event)
> >>+{
> >>+	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
> >>+	struct hw_perf_event *hwc = &event->hw;
> >>+	u64 prev, new = 0;
> >>+	s64 delta;
> >>+	int i;
> >>+
> >>+	/*
> >>+	 * since we do not enable counter overflow interrupts,
> >>+	 * we do not have to worry about prev_count changing on us
> >>+	 */
> >
> >Without overflow interrupts, how do you ensure that you account for
> >overflow in a reasonable time window (i.e. before the counter runs past
> >its initial value)?
> 
> Two reasons:
> 
>   1) There are no interrupts.
> 
>   2) The counters are 64-bit, they never overflow.

Ok. Please point this out in the comment so that reviewers aren't
misled. Stating that we don't enable an interrupt implies that said
interrupt exists.

> >>+	/* and we do not enable counter overflow interrupts */
> >
> >That statement raises far more questions than it answers.
> >
> >_why_ do we not user overflow interrupts?
> 
> As stated above, there are *no* overflow interrupts.

Ok. As stated above, please fix this comment to not mislead.

> The events we are counting cannot be attributed to any one (or even
> any) CPU, they run asynchronous to the CPU, so even if there were
> interrupts, they would be meaningless.

Yes, they are meaningless w.r.t. the state of an arbitrary CPU.

Were they to exist you could use them to drive other snapshotting of the
state of the uncore PMU, to get an idea of the frequency/stability of
events over time, etc. Userspace might then decide to snapshot other
whole system state based on events fed to it.

That's moot if they don't exist.

Mark.
