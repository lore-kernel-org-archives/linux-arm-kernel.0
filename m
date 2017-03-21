From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Mar 2017 17:26:34 +0000
Subject: [PATCH v6 09/11] drivers: perf: hisi: Miscellanous node(MN)
 event counting in perf
In-Reply-To: <1489127333-112865-1-git-send-email-anurup.m@huawei.com>
References: <1489127333-112865-1-git-send-email-anurup.m@huawei.com>
Message-ID: <20170321172634.GD29116@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 01:28:53AM -0500, Anurup M wrote:
> +static u32 hisi_mn_read_counter(struct hisi_mn_data *mn_data, int cntr_idx)
> +{
> +	struct hisi_djtag_client *client = mn_data->client;
> +	u32 module_id = GET_MODULE_ID(mn_data);
> +	u32 reg_off, value;
> +
> +	reg_off = get_counter_reg_off(cntr_idx);
> +	hisi_djtag_readreg(module_id, MN1_BANK_SELECT, reg_off,
> +			   client, &value);

You need to handle this failing.

[...]

> +	do {
> +		/* Get count from the MN */
> +		prev_raw_count = local64_read(&hwc->prev_count);
> +		new_raw_count =	hisi_mn_read_counter(mn_data, idx);
> +		delta = (new_raw_count - prev_raw_count) & HISI_MAX_PERIOD;
> +
> +		local64_add(delta, &event->count);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
> +				 new_raw_count) != prev_raw_count);

Same comment as for the l3 event update loop.

[...]

> +	/*
> +	 * Value to write to event select register
> +	 * Each byte in the 32 bit select register is used to
> +	 * configure the event code. Each byte correspond to a
> +	 * counter register to use.
> +	 */
> +	val = event_value << (8 * idx);
> +
> +	/*
> +	 * Set the event in MN_EVENT_TYPE Register
> +	 */
> +	hisi_djtag_readreg(module_id, MN1_BANK_SELECT, MN1_EVTYPE_REG_OFF,
> +			   client, &value);
> +	value &= ~(0xff << (8 * idx));
> +	value |= val;
> +	hisi_djtag_writereg(module_id, MN1_BANK_SELECT, MN1_EVTYPE_REG_OFF,
> +			    value, client);

Use a helper for this common pattern.

[...]

> +static int hisi_mn_pmu_init(struct hisi_pmu *mn_pmu,
> +				struct hisi_djtag_client *client)
> +{
> +	struct device *dev = &client->dev;
> +
> +	mn_pmu->num_events = HISI_HWEVENT_MN_EVENT_MAX;
> +	mn_pmu->num_counters = HISI_IDX_MN_COUNTER_MAX;
> +	mn_pmu->scl_id = hisi_djtag_get_sclid(client);
> +
> +	mn_pmu->name = kasprintf(GFP_KERNEL, "hisi_mn_%d", mn_pmu->scl_id);

This is leaked if we fail in hisi_pmu_mn_dev_probe()...

> +static int hisi_pmu_mn_dev_probe(struct hisi_djtag_client *client)
> +{
> +	struct hisi_pmu *mn_pmu;
> +	struct device *dev = &client->dev;
> +	int ret;
> +
> +	mn_pmu = hisi_pmu_alloc(dev);
> +	if (!mn_pmu)
> +		return -ENOMEM;
> +
> +	ret = hisi_mn_pmu_init(mn_pmu, client);
> +	if (ret)
> +		return ret;
> +
> +	ret = hisi_mn_init_data(mn_pmu, client);
> +	if (ret)
> +		return ret;

... e.g. here.

Thanks,
Mark.
