From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 21 Nov 2018 17:01:47 +0000
Subject: [PATCH v2 3/4] arm64: arm_pmu: Add support for
 exclude_host/exclude_guest attributes
In-Reply-To: <20181121132337.GC42987@e119886-lin.cambridge.arm.com>
References: <1542723322-42536-1-git-send-email-andrew.murray@arm.com>
 <1542723322-42536-4-git-send-email-andrew.murray@arm.com>
 <2fb3eef1-c361-8ce0-a5ad-10de66517858@arm.com>
 <20181121105601.GB42987@e119886-lin.cambridge.arm.com>
 <20181121132337.GC42987@e119886-lin.cambridge.arm.com>
Message-ID: <d956129d-cced-2d61-c247-4521f039dfba@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/11/2018 13:23, Andrew Murray wrote:
> On Wed, Nov 21, 2018 at 10:56:02AM +0000, Andrew Murray wrote:
>> On Tue, Nov 20, 2018 at 02:49:05PM +0000, Suzuki K Poulose wrote:
>>> On 11/20/2018 02:15 PM, Andrew Murray wrote:
>>>> Add support for the :G and :H attributes in perf by handling the
>>>> exclude_host/exclude_guest event attributes.
>>>>
>>>> We notify KVM of counters that we wish to be enabled or disabled on
>>>> guest entry/exit and thus defer from starting or stopping :G events
>>>> as per the events exclude_host attribute.
>>>>
>>>> When using VHE, EL2 is unused by the guest - therefore we can filter
>>>> out these events with the PMU as per the 'exclude_host' attribute.
>>>>
>>>> With both VHE and non-VHE we switch the counters between host/guest
>>>> at EL2. With non-VHE when using 'exclude_host' we filter out EL2.
>>>>
>>>> These changes eliminate counters counting host events on the
>>>> boundaries of guest entry/exit when using :G. However when using :H
>>>> unless exclude_hv is set on non-VHE then there is a small blackout
>>>> window at the guest entry/exit where host events are not captured.
>>>>
>>>> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>>>> ---
>>>>    arch/arm64/kernel/perf_event.c | 41 +++++++++++++++++++++++++++++++++++------
>>
> 
> 
>>> 	
>>>> +	}
>>>>    }
>>>>    static inline int armv8pmu_disable_counter(int idx)
>>>> @@ -664,11 +677,23 @@ static inline int armv8pmu_disable_counter(int idx)
>>>>    static inline void armv8pmu_disable_event_counter(struct perf_event *event)
>>>>    {
>>>>    	struct hw_perf_event *hwc = &event->hw;
>>>> +	struct perf_event_attr *attr = &event->attr;
>>>>    	int idx = hwc->idx;
>>>> +	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
>>>>    	if (armv8pmu_event_is_chained(event))
>>>> -		armv8pmu_disable_counter(idx - 1);
>>>> -	armv8pmu_disable_counter(idx);
>>>> +		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
>>>> +
>>>> +	if (attr->exclude_host)
>>>> +		kvm_set_clr_guest_pmu_events(counter_bits, 0);
>>>> +	if (attr->exclude_guest)
>>>> +		kvm_set_clr_host_pmu_events(counter_bits, 0);
>>>> +
>>>> +	if (!attr->exclude_host) {
>>>> +		if (armv8pmu_event_is_chained(event))
>>>> +			armv8pmu_disable_counter(idx - 1);
>>>> +		armv8pmu_disable_counter(idx);
>>>> +	}
>>>>    }
>>>>    static inline int armv8pmu_enable_intens(int idx)
>>>> @@ -945,12 +970,12 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>>>>    	 * with other architectures (x86 and Power).
>>>>    	 */
>>>>    	if (is_kernel_in_hyp_mode()) {
>>>> -		if (!attr->exclude_kernel)
>>>> +		if (!attr->exclude_kernel && !attr->exclude_host)
>>>>    			config_base |= ARMV8_PMU_INCLUDE_EL2;
>>>
>>> Shouldn't we handle "exclude_kernel" for a "Guest" event ?
>>> i.e, what if we have exclude_kernel + exclude_host set ? Doesn't
>>> the "exclude_kernel" apply to the event filtering after we enter
>>> guest and thus, we need to set the EXCLUDE_EL1 ?
>>
>> Yes you're right. This is a problem not just for a VHE host's guest but
>> for the host as well - for example perf -e instructions:h and
>> -e instructions:G will currently give the same count.
>>
>>>
>>> Also I am wondering what is the situation with Nested virtualisation
>>> coming in. i.e, if the host hyp wanted to profile the guest hyp, should
>>> we set EL2 events ? I understand this is something which should be
>>> solved with the nested virt changes. But it would be good to see
>>> if we could filter "exclude_host" and "exclude_guest" at the hypervisor
>>> level (i.e, in software, without PMU filtering) to allow the normal
>>> controls to make use of the hardware filtering ?
>>
>> It took me a while to think this through and I think you're right in
>> that we can do more to future proof this for nested virt. In fact we
>> don't depend on the hunks in this function (i.e. addition of extra
>> '!attr->exclude_host' conditions) - we don't need them due to the
>> enable/disable of counters at guest entry/exit.
>>
>> With the assumption of the hypervisor switch enabling/disabling
>> host/guest counters I think we can now do the following:
>>
>>          /*
>>           * If we're running in hyp mode, then we *are* the hypervisor.
>>           * Therefore we ignore exclude_hv in this configuration, since
>>           * there's no hypervisor to sample anyway. This is consistent
>>           * with other architectures (x86 and Power).
>>           */
>>          if (is_kernel_in_hyp_mode())
>>                  if (!attr->exclude_kernel)
>>                          config_base |= ARMV8_PMU_INCLUDE_EL2;
>>          else
>>                  if (!attr->exclude_hv)
>>                          config_base |= ARMV8_PMU_INCLUDE_EL2;
>>
>>          if (attr->exclude_kernel)
>>                  config_base |= ARMV8_PMU_EXCLUDE_EL1;
>>
>>          if (attr->exclude_user)
>>                  config_base |= ARMV8_PMU_EXCLUDE_EL0;
>>
>> Also for nested virt we'd need to update
>> kvm_pmu_set_counter_event_type to ensure exclude_kernel is set when
>> the guest attempts to include EL2 to count a VHE guest kernel.
>>
>> Does this look right?
> 
> Actually I think this is more correct:
> 


>          /*
>           * If we're running in hyp mode, then we *are* the hypervisor.
>           * Therefore we ignore exclude_hv in this configuration, since
>           * there's no hypervisor to sample anyway. This is consistent
>           * with other architectures (x86 and Power).
>           *
>           * To eliminate counting host events on the boundaries of
>           * guest entry/exit we ensure EL2 is not included in hyp mode
>           * with !exclude_host.
>           */
>          if (is_kernel_in_hyp_mode())
>                  if (!attr->exclude_kernel && !attr->exclude_host)
>                          config_base |= ARMV8_PMU_INCLUDE_EL2;

You beat me to it. I was thinking about it and was planning to respond
with the same suggestion.

>          else
>                  if (!attr->exclude_hv)
>                          config_base |= ARMV8_PMU_INCLUDE_EL2;
> 
>          /*
>           * Filter out !VHE kernels and guest kernels
>           */
>          if (attr->exclude_kernel)
>                  config_base |= ARMV8_PMU_EXCLUDE_EL1;
> 
>          if (attr->exclude_user)
>                  config_base |= ARMV8_PMU_EXCLUDE_EL0;
> 
> 
> The reason for re-adding the !attr->exclude_host is to prevent
> leakage of host events getting counted when using guest_only and thus
> prevents information exposing to the guest. On VHE we flip the counters
> from host to guest shortly before entering the guest - if we don't
> exclude EL2 then we start counting host time between the counter flip
> and actually entering the guest. As the guests will always be EL1/EL0
> we really should exclude EL2. I don't think this breaks any nested
> virt use case as EL2 is only ever emulated right?

I am not sure about the Nested virt case. But I think this looks
fine with me.

Cheers
Suzuki
