From: jglauber@cavium.com (Jan Glauber)
Date: Fri, 11 Mar 2016 11:54:24 +0100
Subject: [RFC PATCH 1/7] arm64/perf: Basic uncore counter support for
 Cavium ThunderX
In-Reply-To: <20160212173658.GD20262@leverpostej>
References: <cover.1455295032.git.jglauber@cavium.com>
 <8bd93a25e069ed6428bc6c21fc53270962ccafcc.1455295032.git.jglauber@cavium.com>
 <20160212173658.GD20262@leverpostej>
Message-ID: <20160311105423.GA4442@wintermute>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 05:36:59PM +0000, Mark Rutland wrote:
> On Fri, Feb 12, 2016 at 05:55:06PM +0100, Jan Glauber wrote:

[...]

> > +int thunder_uncore_event_init(struct perf_event *event)
> > +{
> > +	struct hw_perf_event *hwc = &event->hw;
> > +	struct thunder_uncore *uncore;
> > +
> > +	if (event->attr.type != event->pmu->type)
> > +		return -ENOENT;
> > +
> > +	/* we do not support sampling */
> > +	if (is_sampling_event(event))
> > +		return -EINVAL;
> > +
> > +	/* counters do not have these bits */
> > +	if (event->attr.exclude_user	||
> > +	    event->attr.exclude_kernel	||
> > +	    event->attr.exclude_host	||
> > +	    event->attr.exclude_guest	||
> > +	    event->attr.exclude_hv	||
> > +	    event->attr.exclude_idle)
> > +		return -EINVAL;
> 
> We should _really_ make these features opt-in at the core level. It's
> crazy that each and every PMU drivers has to explicitly test and reject
> things it doesn't support.
> 

Looking at the exclude_* feature handling in pmu->event_init under
arch/ shows lots of differences. Just as an example, exclude_idle
returns sometimes -EINVAL, sometimes -EPERM while other archs
ignore it and one silently deletes the flag.

So it looks hard to me to move the exclude handling into
perf core while keeping the per-arch differences. And if we
don't and return an error on the perf_event_open syscall in a newer
kernel for an exclude bit that was previously ignored it will be a
user-space regression, right?

Looking only at the uncore drivers (plus drivers/bus/arm-cc*)
it looks like they all don't support any exclude bits but the
handling here differs also. The table shows the current behaviour,
X means the requested exclude flag is refused.

                          user  kernel  host    guest    hv     idle
---------------------------------------------------------------------
x86 uncore intel        |  X      X                      X       X
x86 uncore intel snb    |  X      X      X       X       X       X
x86 uncore intel cqm    |  X      X      X       X       X       X
x86 uncore intel cstate |  X      X      X       X       X       X
x86 uncore intel rapl   |  X      X      X       X       X       X
x86 uncore amd          |  X      X      X       X
x86 uncore amd iommu    |  X      X      X       X
x86 uncore amd ibs      |  X      X      X       X       X       X
arm bus cci             |  X      X      X       X       X       X
arm bus ccn             |  X      X                      X       X
----------------------------------------------------------------------

How about simply adding a helper function to include/linux/perf_event.h
that checks if _any_ of the exclude bits is set? We could then
simplify the check-for-any exclude flag to:

if (any_exclude_set(event))
	return -EINVAL;

What's your opinion?

Jan

---

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5c5a3f..0eacdba0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -849,6 +849,18 @@ static inline bool is_sampling_event(struct perf_event *event)
 	return event->attr.sample_period != 0;
 }
 
+static inline int any_exclude_set(struct perf_event *event)
+{
+	if (event->attr.exclude_user	||
+	    event->attr.exclude_kernel	||
+	    event->attr.exclude_host	||
+	    event->attr.exclude_guest	||
+	    event->attr.exclude_hv	||
+	    event->attr.exclude_idle)
+		return 1;
+	return 0;
+}
+
 /*
  * Return 1 for a software event, 0 for a hardware event
  */
