From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 22 May 2017 17:22:12 +0100
Subject: [PATCH v3 4/5] drivers/perf: Add support for ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <20170522104521.942a45a207d541edcf738b4c@arm.com>
References: <1495128273-13941-1-git-send-email-will.deacon@arm.com>
 <1495128273-13941-5-git-send-email-will.deacon@arm.com>
 <20170522073249.d95a6d7050d24e99261ceae6@arm.com>
 <20170522124446.GE1478@leverpostej>
 <20170522104521.942a45a207d541edcf738b4c@arm.com>
Message-ID: <20170522162211.GA29333@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 22, 2017 at 10:45:21AM -0500, Kim Phillips wrote:
> On Mon, 22 May 2017 13:44:46 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, May 22, 2017 at 07:32:49AM -0500, Kim Phillips wrote:
> > > On Thu, 18 May 2017 18:24:32 +0100
> > > Will Deacon <will.deacon@arm.com> wrote:
> > > > +/* Perf callbacks */
> > > > +static int arm_spe_pmu_event_init(struct perf_event *event)
> > > > +{
> > > > +	u64 reg;
> > > > +	struct perf_event_attr *attr = &event->attr;
> > > > +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> > > > +
> > > > +	/* This is, of course, deeply driver-specific */
> > > > +	if (attr->type != event->pmu->type)
> > > > +		return -ENOENT;
> > > > +
> > 
> > [trimming other return sites]
> 
> Thanks but other conditions, such as the user specified sample period
> check would be more appropriate to be left in for this discussion.

Sure, I was just trimming to a single example for brevity.  I appreciate
there are cases where it may not be as simple to determine the cause
from userspace today.

> > > I've consistently brought up lack of proper user error messaging in all
> > > previous submissions of this driver:
> > > 
> > ... and we've consistently explained why logging such things to dmesg by
> > default will not fly. As before, while we call these return codes error
> > values, they are *not* errors in the same sense as pr_err().
> 
> I've expressed my disagreement to that matter here:
>  
> https://lkml.org/lkml/2017/4/7/223
>  
> yet it got no response.

That's not strictly true.

I replied to the mail you cited, attempting to clarify as best I could.

You replied again, and it's true I didn't respond there, but there was
no new substantiative argument. To summarize that thread, to the best of
my understanding:

* We disagree on the semantic of "an error" in this context. Clearly we
  aren't going to agree.

* We agree that error reporting and handling is painful in this area.

* We disagree w.r.t. using printk() and friends. My position has not
  been swayed. 

[...]

> > > AFAICT, my comments hold, yet the driver still gets resubmitted without
> > > them being addressed.  How do we get out of this loop?
> > 
> > We've repeatedly explained why the approach you suggest is not feasible.
> > Perhaps you could try to explain why our approach doesn't seem feasible
> > to you.
> 
> I don't want SPE users to have to manually instrument the driver
> in order to find out what it didn't like about the parameters they
> specified.  This problem has already been reported by other early
> adopters.  perf itself says "dmesg may provide additional information",
> so let's please use it.

Sorry, but regardless of any argument there is to be had on how best to
handle errors, I'm not going to be swayed to the position that the
solution is printk() or its ilk, for the reasons that I have outlined
several times previously.

As one of the maintainers of PMU code, I must NAK such code in any PMU
driver.

FWIW, I'm more than happy to:

* Add pr_debug() statements so that developers directly using the perf
  interfaces can debug their userspace code and without having to first
  develop a full knowledge of what is and isn't permitted.

* Add documentation such that userspace developers can figure out what
  is and is not supported.

* Add interfaces as appropriate such that userspace can more reliably
  determine the reason(s) an error code has been returned. For example,
  we might expose sample period information under sysfs.

* Help with any userspace error handling code. I am more than happy to
  review such code and to provide improvements myself.

... so if you want to make any progress on this front, please either
look at one of those, or make a *new* suggestion that does not involve
printk.

Thanks,
Mark.
