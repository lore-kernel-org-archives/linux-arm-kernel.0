From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 18 Dec 2015 11:42:34 +0100
Subject: [PATCH v4 05/12] arm-cci: PMU: Add support for transactions
In-Reply-To: <5673DFC7.6060406@arm.com>
References: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
 <1450374559-23315-6-git-send-email-suzuki.poulose@arm.com>
 <20151217184255.GI6344@twins.programming.kicks-ass.net>
 <5673DFC7.6060406@arm.com>
Message-ID: <20151218104234.GN6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 10:28:23AM +0000, Suzuki K. Poulose wrote:
> On 17/12/15 18:42, Peter Zijlstra wrote:

> >The above doesn't look like it has a failure case, in which case you can
> >achieve the same simpler, using pmu::pmu_{dis,en}able().
> >
> 
> I thought about that, but was not sure if pmu->stop() is guaranteed to be
> called on all the events scheduled on the PMU when we pmu::pmu_disable().
> Is it ?

Not by core code, but you get to implement your pmu::pmu_disable() call,
and if that's what you need, you can make it do that.

Examples:

On some x86 hardware we indeed have to poke at each counter control
register and clear the ENable bit, which is the same what
pmu::stop(.flags=0) would do.

But other x86 hardware has a global disable switch, which is much
cheaper than poking at the individual counter control registers one by
one. In this case we only update the counter control register if it
needs updates (typically in the pmu_enable path).

Yet other x86 hardware can auto disable this global state on interrupt,
which saves us yet another machine register poke.
