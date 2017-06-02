From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Jun 2017 17:04:37 +0100
Subject: [PATCH v2 3/3] perf: xgene: Add support for SoC PMU version 3
In-Reply-To: <1491238077-20666-4-git-send-email-hotran@apm.com>
References: <1491238077-20666-1-git-send-email-hotran@apm.com>
 <1491238077-20666-4-git-send-email-hotran@apm.com>
Message-ID: <20170602160436.GL28299@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hoan,

Apologies for the delay in getting to this.

On Mon, Apr 03, 2017 at 09:47:57AM -0700, Hoan Tran wrote:
> This patch adds support for SoC-wide (AKA uncore) Performance Monitoring
> Unit version 3.
> 
> It can support up to
>  - 2 IOB PMU instances
>  - 8 L3C PMU instances
>  - 2 MCB PMU instances
>  - 8 MCU PMU instances

Please elaborate on the differences compared with prior versions.

I see that counters are 64-bit. Are there any other important details to
be aware of?

[...]

> +static struct attribute *l3c_pmu_v3_events_attrs[] = {

> +	XGENE_PMU_EVENT_ATTR(read-hit,				0x01),
> +	XGENE_PMU_EVENT_ATTR(read-miss,				0x02),

> +	XGENE_PMU_EVENT_ATTR(reads,				0x08),
> +	XGENE_PMU_EVENT_ATTR(writes,				0x09),

> +};

Some of these are singular (e.g. "read-hit", "read-miss"), while others
are plural (e.g. "reads", "writes").

The existing driver use the singular form. Please remain consistent with
that. e.g. turn "reads" into "read".

> +	XGENE_PMU_EVENT_ATTR(PA-req-buf-alloc-all,		0x01),

Likewise, please consistently use lower case.

> +	XGENE_PMU_EVENT_ATTR(pmu-act-sent,			0x01),

Surely we don't need "pmu" in the event names?

[...]

>  static inline u64 xgene_pmu_read_counter32(struct xgene_pmu_dev *pmu_dev,
>  					   int idx)
>  {
>  	return (u64)readl(pmu_dev->inf->csr + PMU_PMEVCNTR0 + (4 * idx));
>  }

I don't think the cast is necessary. Please remove it.

>  static inline void
> +xgene_pmu_write_counter64(struct xgene_pmu_dev *pmu_dev, int idx, u64 val)
> +{
> +	u32 cnt_lo, cnt_hi;
> +
> +	cnt_lo = val & 0xFFFFFFFF;
> +	cnt_hi = val >> 32;

	cnt_hi = upper_32_bits(val);
	cnt_lo = lower_32_bits(val);

(both are in <linux/kernel.h>)

> +
> +	/* v3 has 64-bit counter registers composed by 2 32-bit registers */
> +	xgene_pmu_write_counter32(pmu_dev, 2 * idx, val);
> +	xgene_pmu_write_counter32(pmu_dev, 2 * idx + 1, val >> 32);

Please use cnt_hi and cnt_lo for the writes.

[...]

> @@ -621,7 +989,7 @@ static void xgene_perf_event_set_period(struct perf_event *event)
>  	struct xgene_pmu *xgene_pmu = pmu_dev->parent;
>  	struct hw_perf_event *hw = &event->hw;
>  	/*
> -	 * The X-Gene PMU counters have a period of 2^32. To account for the
> +	 * The X-Gene PMU counters have a period of 2^32 or more. To account for the
>  	 * possiblity of extreme interrupt latency we program for a period of
>  	 * half that. Hopefully we can handle the interrupt before another 2^31
>  	 * events occur and the counter overtakes its previous value.

This comment is now a little out-of-date, as we don't start 64-bit
counters at half their period.

I guess we don't expect a 64-bit counter to overflow, so can we state
that in the comment?

[...]

> -static int acpi_pmu_probe_active_mcb_mcu(struct xgene_pmu *xgene_pmu,
> +static int acpi_pmu_probe_active_mcb_mcu_l3c(struct xgene_pmu *xgene_pmu,
>  					 struct platform_device *pdev)
>  {
>  	void __iomem *csw_csr, *mcba_csr, *mcbb_csr;
>  	struct resource *res;
>  	unsigned int reg;
> +	u32 mcb0routing;
> +	u32 mcb1routing;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	csw_csr = devm_ioremap_resource(&pdev->dev, res);
> @@ -899,41 +1309,72 @@ static int acpi_pmu_probe_active_mcb_mcu(struct xgene_pmu *xgene_pmu,
>  		return PTR_ERR(csw_csr);
>  	}
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> -	mcba_csr = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(mcba_csr)) {
> -		dev_err(&pdev->dev, "ioremap failed for MCBA CSR resource\n");
> -		return PTR_ERR(mcba_csr);
> -	}
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> -	mcbb_csr = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(mcbb_csr)) {
> -		dev_err(&pdev->dev, "ioremap failed for MCBB CSR resource\n");
> -		return PTR_ERR(mcbb_csr);
> -	}
> -
>  	reg = readl(csw_csr + CSW_CSWCR);
> -	if (reg & CSW_CSWCR_DUALMCB_MASK) {
> -		/* Dual MCB active */
> -		xgene_pmu->mcb_active_mask = 0x3;
> -		/* Probe all active MC(s) */
> -		reg = readl(mcbb_csr + CSW_CSWCR);
> -		xgene_pmu->mc_active_mask =
> -			(reg & MCBADDRMR_DUALMCU_MODE_MASK) ? 0xF : 0x5;
> +	if (xgene_pmu->version == PCP_PMU_V3) {
> +		mcb0routing = CSW_CSWCR_MCB0_ROUTING(reg);
> +		mcb1routing = CSW_CSWCR_MCB0_ROUTING(reg);
> +		if (reg & CSW_CSWCR_DUALMCB_MASK) {
> +			/* Dual MCB active */
> +			xgene_pmu->mcb_active_mask = 0x3;
> +			/* Probe all active L3C(s), maximum is 8 */
> +			xgene_pmu->l3c_active_mask = 0xFF;
> +			/* Probe all active MC(s), maximum is 8 */
> +			if ((mcb0routing == 0x2) && (mcb1routing == 0x2))
> +				xgene_pmu->mc_active_mask = 0xFF;
> +			else if ((mcb0routing == 0x1) && (mcb1routing == 0x1))
> +				xgene_pmu->mc_active_mask =  0x33;
> +			else
> +				xgene_pmu->mc_active_mask =  0x11;
> +
> +		} else {
> +			/* Single MCB active */
> +			xgene_pmu->mcb_active_mask = 0x1;
> +			/* Probe all active L3C(s), maximum is 4 */
> +			xgene_pmu->l3c_active_mask = 0x0F;
> +			/* Probe all active MC(s), maximum is 4 */
> +			if ((mcb0routing == 0x2) && (mcb1routing == 0x0))
> +				xgene_pmu->mc_active_mask = 0x0F;
> +			else if ((mcb0routing == 0x1) && (mcb1routing == 0x0))
> +				xgene_pmu->mc_active_mask =  0x03;
> +			else
> +				xgene_pmu->mc_active_mask =  0x01;
> +		}
>  	} else {
> -		/* Single MCB active */
> -		xgene_pmu->mcb_active_mask = 0x1;
> -		/* Probe all active MC(s) */
> -		reg = readl(mcba_csr + CSW_CSWCR);
> -		xgene_pmu->mc_active_mask =
> -			(reg & MCBADDRMR_DUALMCU_MODE_MASK) ? 0x3 : 0x1;
> -	}
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +		mcba_csr = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(mcba_csr)) {
> +			dev_err(&pdev->dev, "ioremap failed for MCBA CSR resource\n");
> +			return PTR_ERR(mcba_csr);
> +		}
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> +		mcbb_csr = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(mcbb_csr)) {
> +			dev_err(&pdev->dev, "ioremap failed for MCBB CSR resource\n");
> +			return PTR_ERR(mcbb_csr);
> +		}
>  
> +		xgene_pmu->l3c_active_mask = 0x1;
> +		if (reg & CSW_CSWCR_DUALMCB_MASK) {
> +			/* Dual MCB active */
> +			xgene_pmu->mcb_active_mask = 0x3;
> +			/* Probe all active MC(s) */
> +			reg = readl(mcbb_csr + CSW_CSWCR);
> +			xgene_pmu->mc_active_mask =
> +				(reg & MCBADDRMR_DUALMCU_MODE_MASK) ? 0xF : 0x5;
> +		} else {
> +			/* Single MCB active */
> +			xgene_pmu->mcb_active_mask = 0x1;
> +			/* Probe all active MC(s) */
> +			reg = readl(mcba_csr + CSW_CSWCR);
> +			xgene_pmu->mc_active_mask =
> +				(reg & MCBADDRMR_DUALMCU_MODE_MASK) ? 0x3 : 0x1;
> +		}
> +	}
>  	return 0;
>  }

Please split these into separate functions. e.g. have
acpi_pmu_probe_active_mcb_mcu_v1_2() and
acpi_pmu_probe_active_mcb_mcu_v3().

>  static char *xgene_pmu_dev_name(struct device *dev, u32 type, int id)
> @@ -997,6 +1439,8 @@ static char *xgene_pmu_dev_name(struct device *dev, u32 type, int id)
>  		return devm_kasprintf(dev, GFP_KERNEL, "l3c%d", id);
>  	case PMU_TYPE_IOB:
>  		return devm_kasprintf(dev, GFP_KERNEL, "iob%d", id);
> +	case PMU_TYPE_IOB_SLOW:
> +		return devm_kasprintf(dev, GFP_KERNEL, "iob-slow%d", id);

What is IOB slow? How does it relate to the existing IOB?

Thanks,
Mark.
