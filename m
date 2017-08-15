From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Aug 2017 12:05:18 +0100
Subject: [PATCH v4 4/6] perf: hisi: Add support for HiSilicon SoC HHA PMU
 driver
In-Reply-To: <1500984642-204676-5-git-send-email-zhangshaokun@hisilicon.com>
References: <1500984642-204676-1-git-send-email-zhangshaokun@hisilicon.com>
 <1500984642-204676-5-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <20170815110518.GE6090@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 08:10:40PM +0800, Shaokun Zhang wrote:
> +/* HHA register definition */
> +#define HHA_INT_MASK		0x0804
> +#define HHA_INT_STATUS		0x0808
> +#define HHA_INT_CLEAR		0x080C
> +#define HHA_PERF_CTRL		0x1E00
> +#define HHA_EVENT_CTRL		0x1E04
> +#define HHA_EVENT_TYPE0		0x1E80
> +#define HHA_CNT0_LOWER		0x1F00
> +
> +/* HHA has 16-counters and supports 0x50 events */

As with the L3C PMU, what exactly does this mean?

Does this mean event IDs 0-0x4f are valid?

[...]

> +static irqreturn_t hisi_hha_pmu_isr(int irq, void *dev_id)
> +{
> +	struct hisi_pmu *hha_pmu = dev_id;
> +	struct perf_event *event;
> +	unsigned long overflown;
> +	u32 status;
> +	int idx;
> +
> +	/* Read HHA_INT_STATUS register */
> +	status = readl(hha_pmu->base + HHA_INT_STATUS);
> +	if (!status)
> +		return IRQ_NONE;
> +	overflown = status;

No need for the u32 temporary here.

[....]

> +static int hisi_hha_pmu_dev_probe(struct platform_device *pdev,
> +				  struct hisi_pmu *hha_pmu)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = hisi_hha_pmu_init_data(pdev, hha_pmu);
> +	if (ret)
> +		return ret;
> +
> +	/* Pick one core to use for cpumask attributes */
> +	cpumask_set_cpu(smp_processor_id(), &hha_pmu->cpus);
> +

Why does this not have the usual event migration callbacks, across CPUs
in the same SCCL?

> +	ret = hisi_hha_pmu_init_irq(hha_pmu, pdev);
> +	if (ret)
> +		return ret;
> +
> +	hha_pmu->name = devm_kasprintf(dev, GFP_KERNEL, "hisi_hha%u_%u",
> +				       hha_pmu->hha_uid, hha_pmu->sccl_id);

As on the doc patch, this should be hierarchical.

Thanks,
Mark
