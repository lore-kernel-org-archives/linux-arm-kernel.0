From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 18 Dec 2015 10:58:17 +0000
Subject: [PATCH v4 05/12] arm-cci: PMU: Add support for transactions
In-Reply-To: <20151218104234.GN6344@twins.programming.kicks-ass.net>
References: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
 <1450374559-23315-6-git-send-email-suzuki.poulose@arm.com>
 <20151217184255.GI6344@twins.programming.kicks-ass.net>
 <5673DFC7.6060406@arm.com>
 <20151218104234.GN6344@twins.programming.kicks-ass.net>
Message-ID: <5673E6C9.7040304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/15 10:42, Peter Zijlstra wrote:
> On Fri, Dec 18, 2015 at 10:28:23AM +0000, Suzuki K. Poulose wrote:
>> On 17/12/15 18:42, Peter Zijlstra wrote:
>> I thought about that, but was not sure if pmu->stop() is guaranteed to be
>> called on all the events scheduled on the PMU when we pmu::pmu_disable().
>> Is it ?
>
> Not by core code, but you get to implement your pmu::pmu_disable() call,
> and if that's what you need, you can make it do that.

OK.

>
> Examples:
>
> On some x86 hardware we indeed have to poke at each counter control
> register and clear the ENable bit, which is the same what
> pmu::stop(.flags=0) would do.

We have a global Enable/Disable for CCI PMU and thats what we use
currently. To be able to reprogram the counters with the event period
(we program the counter with a specific count in pmu::start() and at
overflow irq handler, not to be confused with the sampling period, which
is not supported), we need to be sure that the counter value has been updated.

May be we could check the event->hw->state to see if we need to reprogram it.

Thanks
Suzuki
