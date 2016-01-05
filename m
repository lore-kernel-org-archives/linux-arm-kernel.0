From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 5 Jan 2016 14:37:03 +0100
Subject: [PATCH v4 05/12] arm-cci: PMU: Add support for transactions
In-Reply-To: <20151221105528.GA19617@e106634-lin.cambridge.arm.com>
References: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
 <1450374559-23315-6-git-send-email-suzuki.poulose@arm.com>
 <20151217184255.GI6344@twins.programming.kicks-ass.net>
 <5673DFC7.6060406@arm.com>
 <20151218104234.GN6344@twins.programming.kicks-ass.net>
 <5673E6C9.7040304@arm.com>
 <20151218114751.GP6344@twins.programming.kicks-ass.net>
 <20151221105528.GA19617@e106634-lin.cambridge.arm.com>
Message-ID: <20160105133703.GN6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 10:55:29AM +0000, Suzuki K. Poulose wrote:
> Thanks for that hint. Here is what I cam up with. We don't reschedule
> the events, all we need to do is group the writes to the counters. Hence
> we could as well add a flag for those events which need programming
> and perform the write in pmu::pmu_enable().

I'm still somewhat confused..

> Grouping the writes to counters can ammortise the cost of the operation
> on PMUs where it is expensive (e.g, CCI-500).

This rationale makes me think you want to reduce the number of counter
writes, not batch them per-se.

So why are you unconditionally writing all counters, instead of only
those that changed?
