From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jan 2017 18:54:59 +0000
Subject: System/uncore PMUs and unit aggregation
In-Reply-To: <2cb0eb12-979c-7eff-7c51-ce9e06b3740c@codeaurora.org>
References: <20161117181708.GT22855@arm.com>
 <2cb0eb12-979c-7eff-7c51-ce9e06b3740c@codeaurora.org>
Message-ID: <20170110185459.GB12728@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil, Anurup, Jan,

On Thu, Nov 17, 2016 at 10:16:46PM -0500, Leeder, Neil wrote:
> Thanks for opening up the discussion on this Will.
> 
> For the Qualcomm L2 driver, one objection I had to exposing each unit is
> that there are so many of them - the minimum starting point is a dozen, so
> trying to start 9 counters on each means a perf command line specifying 100+
> events. Future chips are only likely to increase that.
> 
> There is a single CPU node so from an end-user perspective it would seems to
> make sense to also have a single L2 node. perf already has the ability to
> create events on multiple units using cpumask, aggregate the results, and
> split them out per unit with perf stat -a -A, so the user can get that
> granularity. Exposing separate units would make userspace duplicate a lot of
> that functionality. This may rely on each uncore unit being associated with
> a CPU, which is the case with L2.
> 
> I agree with your comments regarding groups and I can see that a standard
> way of representing topology could be useful - in this case, which CPUs are
> within the same L2 cluster. Perhaps a list of cpumasks, one per L2 unit.

Mark and I had a chat about this earlier today and I think we largely agree
with you. That is, for composite PMUs with a notion of CPU affinity for
their component units, it makes sense to use the event affinity as a means
to address these units, rather than e.g. create separate PMU instances.

However, for PMUs that don't have this notion of affinity, the units should
either be exposed individually or, in the case that there is something like
shared control logic, they should be addressed through the config fields
(e.g. the hisilicon cache with the bank=NN option).

I think this fits with your driver, so please post an updated version
addressing Mark's unrelated review comments.

> On 11/17/2016 1:17 PM, Will Deacon wrote:
> [...]
> >  3. Summing the counters across units is only permitted if the units
> >     can all be started and stopped atomically. Otherwise, the counters
> >     should be exposed individually. It's up to the driver author to
> >     decide what makes sense to sum.
> 
> If I understand your your point 3 correctly, I'm not sure about the need to
> start and stop them all atomically. That seems to be a tighter requirement
> than we require for CPU PMUs. For them, perf stat -a creates events/groups
> on each CPU, then starts and stops them sequentially and sums the results.
> If that model is acceptable for the CPU to collect and aggregate counts,
> that should be the same bar that uncore PMUs need to reach. In the L2 case,
> the driver isn't summing the results, it's still perf doing it, so I may be
> misinterpreting your comment about where the summation is permitted.

My concern with summation is more that I don't want to expose high-level
"meta" events from the driver which in fact end up being a bunch of
different events in a bunch of different counters that can't be read
atomically. Userspace is free to do that, but the driver shouldn't claim
that it can support the event, if you see what I mean?

Will
