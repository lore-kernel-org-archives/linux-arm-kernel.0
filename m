From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Jan 2016 11:24:43 +0000
Subject: [PATCH v5 05/11] arm-cci PMU: Delay counter writes to pmu_enable
In-Reply-To: <56938D2B.7050700@arm.com>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
 <1451908490-2615-6-git-send-email-suzuki.poulose@arm.com>
 <20160104192401.GD17127@leverpostej> <568B93F1.8050202@arm.com>
 <20160111104609.GE6499@leverpostej> <56938D2B.7050700@arm.com>
Message-ID: <20160111112443.GI6499@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 11:08:27AM +0000, Suzuki K. Poulose wrote:
> On 11/01/16 10:46, Mark Rutland wrote:
> >On Tue, Jan 05, 2016 at 09:59:13AM +0000, Suzuki K. Poulose wrote:
> >>On 04/01/16 19:24, Mark Rutland wrote:
> >>>On Mon, Jan 04, 2016 at 11:54:44AM +0000, Suzuki K. Poulose wrote:
> >>The pmu is not disabled while we are in overflow irq handler. Hence there may
> >>not be a pmu_enable() which would set the period for the counter which
> >>overflowed, if defer the write in that case. Is that assumption wrong ?
> >
> >As the driver stands today, yes.
> >
> >However, wouldn't it make more sense to disable the PMU for the overflow
> >handler, such that we can reuse the batching logic?
> 
> None of the PMU drivers do that AFAIK.

I see.

The Intel PMU driver disables the PMU for the interrupt handler; see
intel_pmu_handle_irq in arch/x86/kernel/cpu/perf_event_intel.c. It looks
like that's a special-case for sampling.

I guess we may have the only case where it makes sense to batch counter
writes as opposed to batching configuration writes.

> Hence, didn't want to change it for CCI. We could use the batching
> logic, if decide to do so. I can go ahead with that if there are no
> other side effects with that.

We'll lose events regardless as our RMW sequence will race against the
counters. Batching will make that window slightly larger, but other than
that I don't see a problem.

Thanks,
Mark.
