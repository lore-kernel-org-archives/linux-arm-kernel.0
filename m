From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 03 Nov 2016 15:41:02 +0000
Subject: [PATCH 1/1] KVM: ARM64: Fix the issues when PMCCFILTR is
 configured
In-Reply-To: <c083c21c-1395-6674-8c66-3fe7d0aa4917@redhat.com> (Wei Huang's
 message of "Thu, 3 Nov 2016 09:29:26 -0500")
References: <1478120132-9928-1-git-send-email-wei@redhat.com>
 <db2cdc7caf7dc40b0895e1b6f91c7758@codeaurora.org>
 <c083c21c-1395-6674-8c66-3fe7d0aa4917@redhat.com>
Message-ID: <86wpgkh8q9.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03 2016 at 02:29:26 PM, Wei Huang <wei@redhat.com> wrote:
> On 11/02/2016 11:11 PM, cov at codeaurora.org wrote:
>> Hi Wei,
>> 
>> On 2016-11-02 14:55, Wei Huang wrote:
>>> KVM calls kvm_pmu_set_counter_event_type() when PMCCFILTR is configured.
>>> But this function can't deals with PMCCFILTR correctly because the
>>> evtCount
>>> bit of PMCCFILTR, which is reserved 0, conflits with the SW_INCR event
>>> type of other PMXEVTYPER<n> registers. To fix it, when eventsel == 0, KVM
>>> shouldn't return immediately, but instead it needs to check further if
>>> select_idx is ARMV8_PMU_CYCLE_IDX.
>>>
>>> Another issue is that KVM shouldn't copy the eventsel bits of PMCCFILTER
>>> directly to attr.config. Istead it shoudl convert the request to
>>> perf_event of type 0x11 (i.e. the "cpu cycle" event type).
>>>
>>> Signed-off-by: Wei Huang <wei@redhat.com>
>>> ---
>>>  virt/kvm/arm/pmu.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>>> index 6e9c40e..13cc812 100644
>>> --- a/virt/kvm/arm/pmu.c
>>> +++ b/virt/kvm/arm/pmu.c
>>> @@ -379,7 +379,8 @@ void kvm_pmu_set_counter_event_type(struct
>>> kvm_vcpu *vcpu, u64 data,
>>>      eventsel = data & ARMV8_PMU_EVTYPE_EVENT;
>>>
>>>      /* Software increment event does't need to be backed by a perf
>>> event */
>>> -    if (eventsel == ARMV8_PMU_EVTYPE_EVENT_SW_INCR)
>>> +    if (eventsel == ARMV8_PMU_EVTYPE_EVENT_SW_INCR &&
>>> +        select_idx != ARMV8_PMU_CYCLE_IDX)
>>>          return;
>>>
>>>      memset(&attr, 0, sizeof(struct perf_event_attr));
>>> @@ -391,7 +392,7 @@ void kvm_pmu_set_counter_event_type(struct
>>> kvm_vcpu *vcpu, u64 data,
>>>      attr.exclude_kernel = data & ARMV8_PMU_EXCLUDE_EL1 ? 1 : 0;
>>>      attr.exclude_hv = 1; /* Don't count EL2 events */
>>>      attr.exclude_host = 1; /* Don't count host events */
>>> -    attr.config = eventsel;
>>> +    attr.config = (select_idx == ARMV8_PMU_CYCLE_IDX) ? 0x011 :
>>> eventsel;
>> 
>> Nit: Is there some way you could use ARMV8_PMUV3_PERFCTR_CPU_CYCLES
>> currently
>> defined in arch/arm64/kernel/perf_event.c?
>
> The event definitions in perf_event.c are local to this file. To use
> them, I have to re-factor them out to a header file, which is bigger
> than this patch intended. How about adding the following line to
> arch/arm64/include/asm/perf_event.h (i.e. the same file of
> ARMV8_PMU_EVTYPE_EVENT_SW_INCR)?
>
> #define ARMV8_PMU_EVTYPE_EVENT_CPU_CYCLES  0x11

Patch size is not relevant, and I'd rather avoid both magic numbers and
duplicate definitions. It would make sense to me to move all the
required events to this header file, and fix the SW_INCR duplication.

Please CC the ARM perf maintainers when you repost this patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
