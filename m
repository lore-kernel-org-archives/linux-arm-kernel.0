From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Jun 2016 11:58:44 +0100
Subject: [PATCH 5/8] arm64:perf: L3 cache(LLC) event counting in perf
In-Reply-To: <1467107429-55477-6-git-send-email-anurup.m@huawei.com>
References: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
 <1467107429-55477-6-git-send-email-anurup.m@huawei.com>
Message-ID: <20160628105844.GF31744@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 05:50:26AM -0400, Anurup M wrote:
> 	1. Add support to count L3 cache(LLC) hardware events.
> 	2. Add events as RAW events.
> 	  The events to count can be selected as RAW event
> 	  referring to the hardware user manual.
> 	  e.g.: To input as RAW events the RAW event code is
> 		-e r124f301
> 	  The RAW event encoding followed is
> 	  <socket ID(2 bit)><SCCL ID(4 bit)><ModuleID(4 bit)>
> 	  <Bank(4 bit)><event code(12 bit)>
> 	  So 0x1 is SocketID, 0x2 is SCCL ID, 0x4 is the LLC
> 	  hardware module ID, 0xf is for sum of all LLC banks,
> 	  0x301 is the event code for LLC_READ_ALLOCATE.

If you have a special way of encoding events, please add documentation
for this, as we do for CCN, and as is being done for the X-Gene SoC PMU
driver [1].

The commit message is not an appropriate location to document a
user-facing ABI which the user needs to know about.

For example, I have no idea what a "SCCL ID" is, how the LLC HW module
ID corresponds topologically, what a djtag unit is, nor how a djtag unit
relates to other units in the system.

Given that, and the lack of information regarding the djtag unit(s),
I've skimmed over the rest of this patch, ignoring the portions I canot
review due to a lack of appropriate information.

> +u64 hisi_llc_event_update(struct perf_event *event,
> +				struct hw_perf_event *hwc, int idx)
> +{
> +	struct device_node *djtag_node;
> +	struct hisi_pmu *pllc_pmu = to_hisi_pmu(event->pmu);
> +	struct hisi_hwmod_unit *punit;
> +	struct hisi_llc_data *llc_hwmod_data;
> +	u64 delta, prev_raw_count, new_raw_count = 0;
> +	int cfg_en;
> +	u32 raw_event_code = hwc->config_base;
> +	u32 scclID = (raw_event_code & HISI_SCCL_MASK) >> 20;
> +	u32 llc_idx = scclID - 1;
> +	int i;
> +
> +	if (!scclID || (scclID >= HISI_SCCL_MASK)) {
> +		pr_err("Invalid SCCL=%d in event code!\n", scclID);
> +		return 0;
> +	}
> +
> +	if (!hisi_llc_counter_valid(idx)) {
> +		pr_err("Unsupported event index:%d!\n", idx);
> +		return 0;
> +	}
> +
> +	punit = &pllc_pmu->hwmod_pmu_unit[llc_idx];
> +	llc_hwmod_data = punit->hwmod_data;
> +
> +	/* Check if the LLC data is initialized for this SCCL */
> +	if (!llc_hwmod_data->djtag_node) {
> +		pr_err("SCCL=%d not initialized!\n", scclID);
> +		return 0;
> +	}
> +
> +	/* Find the djtag device node of the SCCL */
> +	djtag_node = llc_hwmod_data->djtag_node;

As above, I cannot follow this due to a lack of understanding of the HW.
You will need to add documentation such that this can be understood.

[...]

> +	/* Increment the active_events for the first event counting */
> +	if (!atomic_inc_not_zero(active_events)) {
> +		mutex_lock(&punit->reserve_mutex);
> +		if (atomic_read(active_events) == 0)
> +			atomic_inc(active_events);
> +		mutex_unlock(&punit->reserve_mutex);
> +	}

If you have no special work to do to activate the PMU HW, this reference
counting is pointless. Please get rid of it entirely.

[...]

> +int hisi_llc_get_event_idx(struct hisi_hwmod_unit *punit)
> +{
> +	struct hisi_llc_data *llc_hwmod_data = punit->hwmod_data;
> +	int event_idx;
> +
> +	event_idx =
> +		find_first_zero_bit(
> +			llc_hwmod_data->hisi_llc_event_used_mask,
> +					HISI_MAX_CFG_LLC_CNTR);
> +
> +	if (event_idx == HISI_MAX_CFG_LLC_CNTR)
> +		return -EAGAIN;
> +
> +	__set_bit(event_idx,
> +		llc_hwmod_data->hisi_llc_event_used_mask);

For reference, what mutual exclusion mechanism protects the used_mask?

[...]

> +void hisi_llc_pmu_init(struct platform_device *pdev,
> +					struct hisi_pmu *pllc_pmu)
> +{
> +	pllc_pmu->pmu_type = SCCL_SPECIFIC;
> +	pllc_pmu->name = "HISI_L3C";

Use lowercase. I suspect "hip05_l3c" is likely a better name, as
Hisilcon may produce a new, different L3C controller, and you already
use "hisilicon,hip05-llc" as the compatible string.

[...]

> +		pllc_pmu->pmu = (struct pmu) {
> +				.name		= "HISI-L3C-PMU",
> +		/*		.task_ctx_nr	= perf_invalid_context, */

Why is this commented out? You *must* use perf_invalid_context.

> +				.pmu_enable = hisi_uncore_pmu_enable,
> +				.pmu_disable = hisi_uncore_pmu_disable,
> +				.event_init = hisi_uncore_pmu_event_init,
> +				.add = hisi_uncore_pmu_add,
> +				.del = hisi_uncore_pmu_del,
> +				.start = hisi_uncore_pmu_start,
> +				.stop = hisi_uncore_pmu_stop,
> +				.read = hisi_uncore_pmu_read,
> +		};

[...]

> +MODULE_DESCRIPTION("HiSilicon ARMv8 LLC PMU driver");

s/ARMv8/HIP05/, the SoC matters far more than the architecture it
happens to use.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438607.html
