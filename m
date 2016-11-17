From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 17 Nov 2016 13:38:30 +0000
Subject: [PATCH v3 1/1] KVM: ARM64: Fix the issues when guest PMCCFILTR is
 configured
In-Reply-To: <20161117133039.GH22855@arm.com>
References: <1479316160-8567-1-git-send-email-wei@redhat.com>
 <20161117133039.GH22855@arm.com>
Message-ID: <e52dd592-b762-2da0-a7b4-ea7bd4de2e60@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/16 13:30, Will Deacon wrote:
> On Wed, Nov 16, 2016 at 11:09:20AM -0600, Wei Huang wrote:
>> KVM calls kvm_pmu_set_counter_event_type() when PMCCFILTR is configured.
>> But this function can't deals with PMCCFILTR correctly because the evtCount
>> bits of PMCCFILTR, which is reserved 0, conflits with the SW_INCR event
>> type of other PMXEVTYPER<n> registers. To fix it, when eventsel == 0, this
>> function shouldn't return immediately; instead it needs to check further
>> if select_idx is ARMV8_PMU_CYCLE_IDX.
>>
>> Another issue is that KVM shouldn't copy the eventsel bits of PMCCFILTER
>> blindly to attr.config. Instead it ought to convert the request to the
>> "cpu cycle" event type (i.e. 0x11).
>>
>> To support this patch and to prevent duplicated definitions, a limited
>> set of ARMv8 perf event types were relocated from perf_event.c to
>> asm/perf_event.h.
>>
>> Signed-off-by: Wei Huang <wei@redhat.com>
>> ---
>>  arch/arm64/include/asm/perf_event.h | 10 +++++++++-
>>  arch/arm64/kernel/perf_event.c      | 10 +---------
>>  virt/kvm/arm/pmu.c                  |  8 +++++---
>>  3 files changed, 15 insertions(+), 13 deletions(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> I'm assuming this will go via kvm-arm.

Yup, I'll take it. Thanks.

	M.
-- 
Jazz is not dead. It just smells funny...
