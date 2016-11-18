From: nleeder@codeaurora.org (Leeder, Neil)
Date: Thu, 17 Nov 2016 22:16:46 -0500
Subject: System/uncore PMUs and unit aggregation
In-Reply-To: <20161117181708.GT22855@arm.com>
References: <20161117181708.GT22855@arm.com>
Message-ID: <2cb0eb12-979c-7eff-7c51-ce9e06b3740c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for opening up the discussion on this Will.

For the Qualcomm L2 driver, one objection I had to exposing each unit is 
that there are so many of them - the minimum starting point is a dozen, 
so trying to start 9 counters on each means a perf command line 
specifying 100+ events. Future chips are only likely to increase that.

There is a single CPU node so from an end-user perspective it would 
seems to make sense to also have a single L2 node. perf already has the 
ability to create events on multiple units using cpumask, aggregate the 
results, and split them out per unit with perf stat -a -A, so the user 
can get that granularity. Exposing separate units would make userspace 
duplicate a lot of that functionality. This may rely on each uncore unit 
being associated with a CPU, which is the case with L2.

I agree with your comments regarding groups and I can see that a 
standard way of representing topology could be useful - in this case, 
which CPUs are within the same L2 cluster. Perhaps a list of cpumasks, 
one per L2 unit.

On 11/17/2016 1:17 PM, Will Deacon wrote:
[...]
>   3. Summing the counters across units is only permitted if the units
>      can all be started and stopped atomically. Otherwise, the counters
>      should be exposed individually. It's up to the driver author to
>      decide what makes sense to sum.

If I understand your your point 3 correctly, I'm not sure about the need 
to start and stop them all atomically. That seems to be a tighter 
requirement than we require for CPU PMUs. For them, perf stat -a creates 
events/groups on each CPU, then starts and stops them sequentially and 
sums the results. If that model is acceptable for the CPU to collect and 
aggregate counts, that should be the same bar that uncore PMUs need to 
reach. In the L2 case, the driver isn't summing the results, it's still 
perf doing it, so I may be misinterpreting your comment about where the 
summation is permitted.

Thanks,

Neil
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
