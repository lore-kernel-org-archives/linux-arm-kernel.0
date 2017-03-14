From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Mar 2017 19:57:49 +0000
Subject: [PATCH 2/2] perf: xgene: Add support for SoC PMU of next
 generation of X-Gene
In-Reply-To: <1489514812-19671-3-git-send-email-hotran@apm.com>
References: <1489514812-19671-1-git-send-email-hotran@apm.com>
 <1489514812-19671-3-git-send-email-hotran@apm.com>
Message-ID: <20170314195749.GB26335@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 11:06:52AM -0700, Hoan Tran wrote:
> This patch adds support for SoC-wide (AKA uncore) Performance Monitoring
> Unit in the next generation of X-Gene SoC.
> 
> Signed-off-by: Hoan Tran <hotran@apm.com>
> ---
>  drivers/perf/xgene_pmu.c | 645 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 575 insertions(+), 70 deletions(-)

That's a very large number of additions, and a very short commit
message.

Please expand the commit message, outlining the differences in this new
version of the PMU HW, and the structural changes made to the driver to
accommodate this.

Additionally, I think that this amount of change should be split into
separate patches. More on that below.

[...]

>  static inline void xgene_pmu_mask_int(struct xgene_pmu *xgene_pmu)
>  {
> -	writel(PCPPMU_INTENMASK, xgene_pmu->pcppmu_csr + PCPPMU_INTMASK_REG);
> +	if (xgene_pmu->version == PCP_PMU_V3) {
> +		writel(PCPPMU_V3_INTENMASK,
> +		       xgene_pmu->pcppmu_csr + PCPPMU_INTMASK_REG);
> +	} else {
> +		writel(PCPPMU_INTENMASK,
> +		       xgene_pmu->pcppmu_csr + PCPPMU_INTMASK_REG);
> +	}
>  }

Having all these version checks in the leaf functions is horrible,
especially given that in cases like xgene_pmu_read_counter(), the v3
behaviour is *substantially* different to the v1/v2 behaviour.

Please use function pointers in the xgene_pmu/xgene_pmu_dev structures
instead. That way you can clearly separate the v3 code and the v1/v2
code, and only need to distinguish the two at init time.

Please move the existing code over to function pointers with preparatory
patches, with the v3 code introduced afterwards.

That applies to almost all cases where you check xgene_pmu->version,
excluding those that happen during probing.

> -static inline u32 xgene_pmu_read_counter(struct xgene_pmu_dev *pmu_dev, int idx)
> +static inline u64 xgene_pmu_read_counter(struct xgene_pmu_dev *pmu_dev, int idx)
>  {
> -	return readl(pmu_dev->inf->csr + PMU_PMEVCNTR0 + (4 * idx));
> +	u32 cnt_lo, cnt_hi, cnt_hi2;
> +
> +	if (pmu_dev->parent->version == PCP_PMU_V3) {
> +		/*
> +		 * v3 has 64-bit counter registers composed by 2 32-bit registers
> +		 * This can be a problem if the counter increases and carries
> +		 * out of bit [31] between 2 reads. The extra reads would help
> +		 * to prevent this issue.
> +		 */
> +		while (1) {
> +			cnt_hi = readl(pmu_dev->inf->csr + PMU_PMEVCNTR0 + 4 + (8 * idx));
> +			cnt_lo = readl(pmu_dev->inf->csr + PMU_PMEVCNTR0 + (8 * idx));
> +			cnt_hi2 = readl(pmu_dev->inf->csr + PMU_PMEVCNTR0 + 4 + (8 * idx));
> +			if (cnt_hi == cnt_hi2)
> +				return (((u64)cnt_hi << 32) | cnt_lo);
> +		}
> +	}
> +
> +	return ((u64)readl(pmu_dev->inf->csr + PMU_PMEVCNTR0 + (4 * idx)));
>  }

It would be far simpler and easier to follow, if we did something like:

static inline u64 xgene_pmu_read_counter32(struct xgene_pmu_dev *pmu_dev, int idx)
{
	return readl(pmu_dev->inf->csr + PMU_PMEVCNTR0 + (4 * idx));
}

static inline u64 xgene_pmu_read_counter64(struct xgene_pmu_dev *pmu_dev, int idx)
{
	u32 lo, hi;

	do {
		hi = xgene_pmu_read_counter32(dev, 2 * idx);
		lo = xgene_pmu_read_counter32(dev, 2 * idx + 1);
	} while (hi = xgene_pmu_read_counter32(dev, 2 * idx));

	return ((u64)hi << 32) | lo;
}

... with the prototypes the same, we can assign the pointer to the
relevant pmu structure.

[...]

> @@ -595,7 +1008,7 @@ static void xgene_perf_event_set_period(struct perf_event *event)
>  	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
>  	struct hw_perf_event *hw = &event->hw;
>  	/*
> -	 * The X-Gene PMU counters have a period of 2^32. To account for the
> +	 * The X-Gene PMU counters have a period of 2^32 or more. To account for the
>  	 * possiblity of extreme interrupt latency we program for a period of
>  	 * half that. Hopefully we can handle the interrupt before another 2^31
>  	 * events occur and the counter overtakes its previous value.
> @@ -603,7 +1016,7 @@ static void xgene_perf_event_set_period(struct perf_event *event)
>  	u64 val = 1ULL << 31;
>  
>  	local64_set(&hw->prev_count, val);
> -	xgene_pmu_write_counter(pmu_dev, hw->idx, (u32) val);
> +	xgene_pmu_write_counter(pmu_dev, hw->idx, val);
>  }

Surely we should update the val to give us a 2^63 default period, then?

AFAICT, we still set it to 1ULL << 31 above.

> @@ -758,20 +1174,48 @@ static int xgene_init_perf(struct xgene_pmu_dev *pmu_dev, char *name)
>  
>  	switch (pmu->inf->type) {
>  	case PMU_TYPE_L3C:
> -		pmu->attr_groups = l3c_pmu_attr_groups;
> +		if (!(xgene_pmu->l3c_active_mask & pmu->inf->enable_mask))
> +			goto dev_err;
> +		if (xgene_pmu->version == PCP_PMU_V3) {
> +			pmu->attr_groups = l3c_pmu_v3_attr_groups;
> +			pmu->default_agentid = PCPPMU_V3_L3C_DEFAULT_AGENTID;

As with my comment on the documentation patch, I don't see why this
needs to differ from the v1/v2 cases.

[...]

> +	if (xgene_pmu->version == PCP_PMU_V3) {
> +		mcb0routing = CSW_CSWCR_MCB0_ROUTING(reg);
> +		mcb1routing = CSW_CSWCR_MCB0_ROUTING(reg);
> +		if (reg & CSW_CSWCR_DUALMCB_MASK) {
> +			xgene_pmu->mcb_active_mask = 0x3;
> +			xgene_pmu->l3c_active_mask = 0xFF;
> +			if ((mcb0routing == 0x2) && (mcb1routing == 0x2))
> +				xgene_pmu->mc_active_mask = 0xFF;
> +			else if ((mcb0routing == 0x1) && (mcb1routing == 0x1))
> +				xgene_pmu->mc_active_mask =  0x33;
> +			else
> +				xgene_pmu->mc_active_mask =  0x11;
> +
> +		} else {
> +			xgene_pmu->mcb_active_mask = 0x1;
> +			xgene_pmu->l3c_active_mask = 0x0F;
> +			if ((mcb0routing == 0x2) && (mcb1routing == 0x0))
> +				xgene_pmu->mc_active_mask = 0x0F;
> +			else if ((mcb0routing == 0x1) && (mcb1routing == 0x0))
> +				xgene_pmu->mc_active_mask =  0x03;
> +			else
> +				xgene_pmu->mc_active_mask =  0x01;
> +		}

I have no idea what's going on here, especially given the amount of
magic numbers.

Comments would be helpful here.

[...]

> @@ -1059,13 +1551,19 @@ static acpi_status acpi_pmu_dev_add(acpi_handle handle, u32 level,
>  	if (acpi_bus_get_status(adev) || !adev->status.present)
>  		return AE_OK;
>  
> -	if (!strcmp(acpi_device_hid(adev), "APMC0D5D"))
> +	if ((!strcmp(acpi_device_hid(adev), "APMC0D5D")) ||
> +	    (!strcmp(acpi_device_hid(adev), "APMC0D84")))
>  		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_L3C);
> -	else if (!strcmp(acpi_device_hid(adev), "APMC0D5E"))
> +	else if ((!strcmp(acpi_device_hid(adev), "APMC0D5E")) ||
> +		 (!strcmp(acpi_device_hid(adev), "APMC0D85")))
>  		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_IOB);
> -	else if (!strcmp(acpi_device_hid(adev), "APMC0D5F"))
> +	else if (!strcmp(acpi_device_hid(adev), "APMC0D86"))
> +		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_IOB_SLOW);
> +	else if ((!strcmp(acpi_device_hid(adev), "APMC0D5F")) ||
> +		 (!strcmp(acpi_device_hid(adev), "APMC0D87")))
>  		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_MCB);
> -	else if (!strcmp(acpi_device_hid(adev), "APMC0D60"))
> +	else if ((!strcmp(acpi_device_hid(adev), "APMC0D60")) ||
> +		 (!strcmp(acpi_device_hid(adev), "APMC0D88")))
>  		ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, PMU_TYPE_MC);

This is now illegible. Please make these table-driven, or use helper
functions. e.g. something like:

static const struct acpi_device_id xgene_pmu_dev_type_match[] =  {
	{ "APMC0D5D", PMU_TYPE_L3C },
	{ "APMC0D84", PMU_TYPE_L3C },
	{ "APMC0D5E", PMU_TYPE_IOB },
	{ "APMC0D85", PMU_TYPE_IOB },
	...
};

static acpi_status acpi_pmu_dev_add(...)
{
	...
	id = acpi_match_device(xgene_pmu_dev_type_match, adev->dev)
	if (!id)
		return AE_OK;
	
	ctx = acpi_get_pmu_hw_inf(xgene_pmu, adev, (int)id->driver_data);
	...
}

> @@ -1245,6 +1749,7 @@ static int xgene_pmu_probe_pmu_dev(struct xgene_pmu *xgene_pmu,
>  static const struct acpi_device_id xgene_pmu_acpi_match[] = {
>  	{"APMC0D5B", PCP_PMU_V1},
>  	{"APMC0D5C", PCP_PMU_V2},
> +	{"APMC0D83", PCP_PMU_V3},
>  	{},
>  };

No "apm,xgene-pmu-v3" DT update?

Thanks,
Mark.
