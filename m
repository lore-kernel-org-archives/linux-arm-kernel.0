From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 20 Nov 2018 14:49:05 +0000
Subject: [PATCH v2 3/4] arm64: arm_pmu: Add support for
 exclude_host/exclude_guest attributes
In-Reply-To: <1542723322-42536-4-git-send-email-andrew.murray@arm.com>
References: <1542723322-42536-1-git-send-email-andrew.murray@arm.com>
 <1542723322-42536-4-git-send-email-andrew.murray@arm.com>
Message-ID: <2fb3eef1-c361-8ce0-a5ad-10de66517858@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2018 02:15 PM, Andrew Murray wrote:
> Add support for the :G and :H attributes in perf by handling the
> exclude_host/exclude_guest event attributes.
> 
> We notify KVM of counters that we wish to be enabled or disabled on
> guest entry/exit and thus defer from starting or stopping :G events
> as per the events exclude_host attribute.
> 
> When using VHE, EL2 is unused by the guest - therefore we can filter
> out these events with the PMU as per the 'exclude_host' attribute.
> 
> With both VHE and non-VHE we switch the counters between host/guest
> at EL2. With non-VHE when using 'exclude_host' we filter out EL2.
> 
> These changes eliminate counters counting host events on the
> boundaries of guest entry/exit when using :G. However when using :H
> unless exclude_hv is set on non-VHE then there is a small blackout
> window at the guest entry/exit where host events are not captured.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>   arch/arm64/kernel/perf_event.c | 41 +++++++++++++++++++++++++++++++++++------
>   1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index de564ae..412bd80 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -26,6 +26,7 @@
>   
>   #include <linux/acpi.h>
>   #include <linux/clocksource.h>
> +#include <linux/kvm_host.h>
>   #include <linux/of.h>
>   #include <linux/perf/arm_pmu.h>
>   #include <linux/platform_device.h>
> @@ -647,11 +648,23 @@ static inline int armv8pmu_enable_counter(int idx)
>   
>   static inline void armv8pmu_enable_event_counter(struct perf_event *event)
>   {
> +	struct perf_event_attr *attr = &event->attr;
>   	int idx = event->hw.idx;
> +	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
>   
> -	armv8pmu_enable_counter(idx);
>   	if (armv8pmu_event_is_chained(event))
> -		armv8pmu_enable_counter(idx - 1);
> +		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));

minor nit: If you rearrange the code below a bit

> +
> +	if (attr->exclude_host)
> +		kvm_set_clr_guest_pmu_events(0, counter_bits);
> +	if (attr->exclude_guest)
> +		kvm_set_clr_host_pmu_events(0, counter_bits);
> +
> +	if (!attr->exclude_host) {
> +		armv8pmu_enable_counter(idx);
> +		if (armv8pmu_event_is_chained(event))
> +			armv8pmu_enable_counter(idx - 1);

we could have :

	if (attr->exclude_guest)
		kvm_set_clr_host_pmu_events(0, counter_bits);

	if (attr->exclude_host) {
		kvm_set_clr_guest_pmu_events(0, counter_bits);
		return;
	}

	armv8pmu_enable_counter(idx);
	if (armv8pmu_event_is_chained(event))
		armv8pmu_enable_counter(idx - 1);

Similarly for disable_event_counter.
	
> +	}
>   }
>   
>   static inline int armv8pmu_disable_counter(int idx)
> @@ -664,11 +677,23 @@ static inline int armv8pmu_disable_counter(int idx)
>   static inline void armv8pmu_disable_event_counter(struct perf_event *event)
>   {
>   	struct hw_perf_event *hwc = &event->hw;
> +	struct perf_event_attr *attr = &event->attr;
>   	int idx = hwc->idx;
> +	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
>   
>   	if (armv8pmu_event_is_chained(event))
> -		armv8pmu_disable_counter(idx - 1);
> -	armv8pmu_disable_counter(idx);
> +		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
> +
> +	if (attr->exclude_host)
> +		kvm_set_clr_guest_pmu_events(counter_bits, 0);
> +	if (attr->exclude_guest)
> +		kvm_set_clr_host_pmu_events(counter_bits, 0);
> +
> +	if (!attr->exclude_host) {
> +		if (armv8pmu_event_is_chained(event))
> +			armv8pmu_disable_counter(idx - 1);
> +		armv8pmu_disable_counter(idx);
> +	}
>   }
>   
>   static inline int armv8pmu_enable_intens(int idx)
> @@ -945,12 +970,12 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>   	 * with other architectures (x86 and Power).
>   	 */
>   	if (is_kernel_in_hyp_mode()) {
> -		if (!attr->exclude_kernel)
> +		if (!attr->exclude_kernel && !attr->exclude_host)
>   			config_base |= ARMV8_PMU_INCLUDE_EL2;

Shouldn't we handle "exclude_kernel" for a "Guest" event ?
i.e, what if we have exclude_kernel + exclude_host set ? Doesn't
the "exclude_kernel" apply to the event filtering after we enter
guest and thus, we need to set the EXCLUDE_EL1 ?

Also I am wondering what is the situation with Nested virtualisation
coming in. i.e, if the host hyp wanted to profile the guest hyp, should
we set EL2 events ? I understand this is something which should be
solved with the nested virt changes. But it would be good to see
if we could filter "exclude_host" and "exclude_guest" at the hypervisor
level (i.e, in software, without PMU filtering) to allow the normal
controls to make use of the hardware filtering ?

>   	} else {
>   		if (attr->exclude_kernel)
>   			config_base |= ARMV8_PMU_EXCLUDE_EL1;
> -		if (!attr->exclude_hv)
> +		if (!attr->exclude_hv && !attr->exclude_host)
>   			config_base |= ARMV8_PMU_INCLUDE_EL2;
>   	}


>   	if (attr->exclude_user)
> @@ -976,6 +1001,10 @@ static void armv8pmu_reset(void *info)
>   		armv8pmu_disable_intens(idx);
>   	}
>   
> +	/* Clear the counters we flip at guest entry/exit */
> +	kvm_set_clr_host_pmu_events(U32_MAX, 0);
> +	kvm_set_clr_guest_pmu_events(U32_MAX, 0);
> +
>   	/*
>   	 * Initialize & Reset PMNC. Request overflow interrupt for
>   	 * 64 bit cycle counter but cheat in armv8pmu_write_counter().
> 

Suzuki
