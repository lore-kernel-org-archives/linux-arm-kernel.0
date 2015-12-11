From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 11 Dec 2015 13:10:23 +0100
Subject: [PATCHv3 5/5] arm-cci: CCI-500: Work around PMU counter writes
In-Reply-To: <566AB36D.9050209@arm.com>
References: <1447783407-18027-1-git-send-email-suzuki.poulose@arm.com>
 <1447783407-18027-6-git-send-email-suzuki.poulose@arm.com>
 <20151210154251.GG495@leverpostej> <566AB36D.9050209@arm.com>
Message-ID: <20151211121023.GJ6356@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 11:28:45AM +0000, Suzuki K. Poulose wrote:
> On 10/12/15 15:42, Mark Rutland wrote:

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
> 
> from linux/perf_event.h:
> 
>         /*
>          * Adds/Removes a counter to/from the PMU, can be done inside a
>          * transaction, see the ->*_txn() methods.
>          *
> 
> As of now it is only called within the transactions, but the comment somehow
> doesn't look like enforces it.

Right, txn stuff is intended to be optional. However a txn
implementation must track if one is in progress, so the ::add() method
can check against that.

Also note that there exist a callchain into pmu->add() that does not
start a txn. See:

	__perf_event_enable()
		if (event != leader)
			event_sched_in()
				event->pmu->add()

That said, you can also use pmu->pmu_{en,dis}able() to batch stuff (x86
does this too), add/del, start/stop are guaranteed to be called with the
PMU disabled (as per the comments in struct pmu).


on x86:

For ::add(), we delay touching the hardware until ::pmu_enable() time.

!txn ::add() will do a schedulability test to see if the pmu had place
for the new event and then record the details of it.

txn ::add() will just record the details.

::commit_txn will do the schedulability test for the txn, if that fails
we undo bits.

::pmu_enable rewrites the hardware registers, moves events about if
needed and configures the new event.
