From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 20 Apr 2016 15:52:58 +0100
Subject: [PATCH v5 6/7] arm64/perf: Filter common events based on
 PMCEIDn_EL0
In-Reply-To: <1461092062-7484-7-git-send-email-ashoks@broadcom.com>
References: <1461092062-7484-1-git-send-email-ashoks@broadcom.com>
 <1461092062-7484-7-git-send-email-ashoks@broadcom.com>
Message-ID: <20160420145258.GC15229@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 11:54:21AM -0700, Ashok Kumar wrote:
> +static ssize_t
> +armv8pmu_events_sysfs_show(struct device *dev,
> +			   struct device_attribute *attr, char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +
> +	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
> +}

It might be best to make that %03llx from the outset. Event encodings
are 10 bits, and the ARM ARM lists them all as 0xNNN (i.e. with three
hex digits).

> -static void armv8pmu_read_num_pmnc_events(void *info)
> +static void armv8pmu_read_num_pmnc_events(int *nb_cnt)
>  {
> -	int *nb_cnt = info;
> -
>  	/* Read the nb of CNTx counters supported from PMNC */
>  	*nb_cnt = (armv8pmu_pmcr_read() >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
>  
> @@ -870,11 +898,30 @@ static void armv8pmu_read_num_pmnc_events(void *info)
>  	*nb_cnt += 1;
>  }
>  
> -static int armv8pmu_probe_num_events(struct arm_pmu *arm_pmu)
> +static void armv8pmu_read_common_events_bitmap(unsigned long *bmp)
> +{
> +	u32 arr[2];
> +
> +	arr[0] = read_sysreg(pmceid0_el0);
> +	arr[1] = read_sysreg(pmceid1_el0);
> +
> +	bitmap_from_u32array(bmp, ARMV8_PMUV3_MAX_COMMON_EVENTS,
> +			     arr, ARRAY_SIZE(arr));
> +}

I'd recommend s/arr/pmceid/ here.

> +static void __armv8pmu_probe_pmu(void *info)
> +{
> +	struct arm_pmu *cpu_pmu = info;
> +
> +	armv8pmu_read_num_pmnc_events(&cpu_pmu->num_events);
> +	armv8pmu_read_common_events_bitmap(cpu_pmu->pmceid_bitmap);
> +}

We may as well just fold these in to the same function; passwing
pointers to fields feels a little odd.

Otherwise this looks good to me.

Thanks,
Mark.
