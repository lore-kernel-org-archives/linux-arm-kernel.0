From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 18 Dec 2015 12:47:51 +0100
Subject: [PATCH v4 05/12] arm-cci: PMU: Add support for transactions
In-Reply-To: <5673E6C9.7040304@arm.com>
References: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
 <1450374559-23315-6-git-send-email-suzuki.poulose@arm.com>
 <20151217184255.GI6344@twins.programming.kicks-ass.net>
 <5673DFC7.6060406@arm.com>
 <20151218104234.GN6344@twins.programming.kicks-ass.net>
 <5673E6C9.7040304@arm.com>
Message-ID: <20151218114751.GP6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 10:58:17AM +0000, Suzuki K. Poulose wrote:

> We have a global Enable/Disable for CCI PMU and thats what we use
> currently. To be able to reprogram the counters with the event period
> (we program the counter with a specific count in pmu::start() and at
> overflow irq handler, not to be confused with the sampling period, which
> is not supported), we need to be sure that the counter value has been updated.
> 
> May be we could check the event->hw->state to see if we need to reprogram it.

Right, have a look at arch/x86/kernel/cpu/perf_event.c:x86_pmu_enable()

If there's new events, it does two loops over the events.

The first loop does stop(PERF_EF_UPDATE) any counter that got moved.
The second loop does start(PERF_EF_RELOAD) on moved and new events.

The PERF_HES_ARCH bit is used to preserve the stopped state of counters
that were programmed but temporarily stopped.
