From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Dec 2015 12:14:27 +0000
Subject: [PATCHv3 5/5] arm-cci: CCI-500: Work around PMU counter writes
In-Reply-To: <566AB36D.9050209@arm.com>
References: <1447783407-18027-1-git-send-email-suzuki.poulose@arm.com>
 <1447783407-18027-6-git-send-email-suzuki.poulose@arm.com>
 <20151210154251.GG495@leverpostej> <566AB36D.9050209@arm.com>
Message-ID: <20151211121427.GA20666@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 11:28:45AM +0000, Suzuki K. Poulose wrote:
> On 10/12/15 15:42, Mark Rutland wrote:
> >On Tue, Nov 17, 2015 at 06:03:27PM +0000, Suzuki K. Poulose wrote:
> >>The CCI PMU driver sets the event counter to the half of the maximum
> >>value(2^31) it can count before we start the counters via
> >>pmu_event_set_period(). This is done to give us the best chance to
> >>handle the overflow interrupt, taking care of extreme interrupt latencies.
> 
> 
> >
> >This should work, but it seems very heavyweight given we do it for each
> >write.
> >
> >Can we not amortize this by using the {start,commit,cancel}_txn hooks?
> >
> >Either we can handle 1-4 and 6-8 in those, or we can copy everything
> >into a shadow state and apply it all in one go at commit_txn time.
> 
> I took a look at it. The only worrying part is, if pmu->add() will be
> called outside *_txn().

It looks like that happns.

If we __perf_event_enable an events which is not a leader, we may call
event_sched_in (which will call pmu->add) outside of a transaction. The
__perf_event_disable path is similar w.r.t. pmu->del.

So it does look like we can't rely on being in a transaction there.

Assuming that's deliberate, we could follow the example of other PMU
drivers and keep track of whether or not we're in a transaction. If not,
we do all the heavyweight work inline.

Thanks,
Mark.
