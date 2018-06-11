From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Jun 2018 15:24:32 +0100
Subject: [PATCH v2 5/5] arm64: perf: Add support for chaining event
 counters
In-Reply-To: <847dfe5c-665c-6398-f87f-3ca56e73f5aa@arm.com>
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
 <1527591356-10934-6-git-send-email-suzuki.poulose@arm.com>
 <20180606180119.4ofhges6codarbmk@lakrids.cambridge.arm.com>
 <4a5b5e7f-fc0b-84e3-fc65-b9f860029207@arm.com>
 <847dfe5c-665c-6398-f87f-3ca56e73f5aa@arm.com>
Message-ID: <20180611142431.4svc26y27scgzfcg@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2018 at 02:54:16PM +0100, Suzuki K Poulose wrote:
> On 08/06/18 15:46, Suzuki K Poulose wrote:
> > On 06/06/2018 07:01 PM, Mark Rutland wrote:
> > > On Tue, May 29, 2018 at 11:55:56AM +0100, Suzuki K Poulose wrote:
> 
> > > > -??????? value |= 0xffffffff00000000ULL;
> > > > +??????? if (!armv8pmu_event_is_64bit(event))
> > > > +??????????? value |= 0xffffffff00000000ULL;
> > > > ????????? write_sysreg(value, pmccntr_el0);
> > > > -??? } else if (armv8pmu_select_counter(idx) == idx)
> > > > -??????? write_sysreg(value, pmxevcntr_el0);
> > > > +??? } else
> > > > +??????? armv8pmu_write_hw_counter(event, value);
> > > > ? }
> > > 
> > > > +static inline void armv8pmu_write_event_type(struct perf_event *event)
> > > > +{
> > > > +??? struct hw_perf_event *hwc = &event->hw;
> > > > +??? int idx = hwc->idx;
> > > > +
> > > > +??? /*
> > > > +???? * For chained events, write the the low counter event type
> > > > +???? * followed by the high counter. The high counter is programmed
> > > > +???? * with CHAIN event code with filters set to count at all ELs.
> > > > +???? */
> > > > +??? if (armv8pmu_event_is_chained(event)) {
> > > > +??????? u32 chain_evt = ARMV8_PMUV3_PERFCTR_CHAIN |
> > > > +??????????????? ARMV8_PMU_INCLUDE_EL2;
> > > > +
> > > > +??????? armv8pmu_write_evtype(idx - 1, hwc->config_base);
> > > > +??????? isb();
> > > > +??????? armv8pmu_write_evtype(idx, chain_evt);
> > > 
> > > The ISB isn't necessary here, AFAICT. We only do this while the PMU is
> > > disabled; no?
> > 
> > You're right. I was just following the ARM ARM.
> 
> Taking another look, it is not clear about the semantics of "pmu->enable()"
> and pmu->disable() callbacks. 

I was talking about pmu::{pmu_disable,pmu_enable}(), so I'm not sure I
follow how arm_pmu::{enable,disable}() are relevant here.

The arm_pmu::{enable,disable}() callbacks enable or disable individual
counters. For example, leaving unused counters disabled may save power,
even if the PMU as a whole is enabled.

> I don't see any reference to them in the perf core
> driver anymore. The perf core uses add() / del () instead, with the PMU
> turned off. Do you have any idea about the enable()/disable() callbacks ?

I'm not sure I understand what you're asking here.

Thanks,
Mark.
