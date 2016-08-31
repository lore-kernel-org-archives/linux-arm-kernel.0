From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 31 Aug 2016 17:20:49 +0100
Subject: [PATCH v3] Added perf functionality to mmdc driver
In-Reply-To: <20160817194253.16300-1-zhengyu.shen@nxp.com>
References: <20160817194253.16300-1-zhengyu.shen@nxp.com>
Message-ID: <e8a82cd8-0920-9da8-77f7-5245a4d36f89@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/08/16 20:42, Zhengyu Shen wrote:
> MMDC is a multi-mode DDR controller that supports DDR3/DDR3L x16/x32/x64
> and LPDDR2 two channel x16/x32 memory types. MMDC is configurable, high
> performance, and optimized. MMDC is present on i.MX6 Quad and i.MX6
> QuadPlus devices, but this driver only supports i.MX6 Quad at the moment.
> MMDC provides registers for performance counters which read via this
> driver to help debug memory throughput and similar issues.
>
> $ perf stat -a -e mmdc/busy-cycles/,mmdc/read-accesses/,mmdc/read-bytes/,mmdc/total-cycles/,mmdc/write-accesses/,mmdc/write-bytes/ dd if=/dev/zero of=/dev/null bs=1M count=5000
> Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=1M count=5000':
>
>          898021787      mmdc/busy-cycles/
>           14819600      mmdc/read-accesses/
>             471.30 MB   mmdc/read-bytes/
>         2815419216      mmdc/total-cycles/
>           13367354      mmdc/write-accesses/
>             427.76 MB   mmdc/write-bytes/
>
>        5.334757334 seconds time elapsed
>
> Signed-off-by: Zhengyu Shen <zhengyu.shen@nxp.com>
> Signed-off-by: Frank Li <frank.li@nxp.com>


> +
> +static int mmdc_pmu_init(struct mmdc_pmu *pmu_mmdc,
> +		void __iomem *mmdc_base, struct device *dev)
> +{
> +	int mmdc_num;
> +
> +	*pmu_mmdc = (struct mmdc_pmu) {
> +		.pmu = (struct pmu) {
> +			.task_ctx_nr    = perf_invalid_context,
> +			.attr_groups    = attr_groups,
> +			.event_init     = mmdc_event_init,
> +			.add            = mmdc_event_add,
> +			.del            = mmdc_event_del,
> +			.start          = mmdc_event_start,
> +			.stop           = mmdc_event_stop,
> +			.read           = mmdc_event_update,
> +		},
> +		.mmdc_base = mmdc_base,
> +	};
> +
> +	mmdc_num = ida_simple_get(&mmdc_ida, 0, 0, GFP_KERNEL);
> +
> +	cpumask_set_cpu(smp_processor_id(), &pmu_mmdc->cpu);
> +
> +	pmu_mmdc->dev = dev;
> +	pmu_mmdc->active_events = 0;
> +	spin_lock_init(&pmu_mmdc->mmdc_active_events_lock);
> +
> +	cpuhp_mmdc_pmu = pmu_mmdc;
> +	cpuhp_setup_state(CPUHP_ONLINE,
> +			"PERF_MMDC_ONLINE", NULL,
> +			mmdc_pmu_offline_cpu);

You may want cpuhp_setup_state_nocalls instead here ?


Cheers
Suzuki
