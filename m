From: anurupvasu@gmail.com (Anurup M)
Date: Fri, 24 Mar 2017 12:13:18 +0530
Subject: [PATCH v6 08/11] drivers: perf: hisi: use poll method to avoid
 L3C counter overflow
In-Reply-To: <20170321171605.GB29116@leverpostej>
References: <1489127325-112821-1-git-send-email-anurup.m@huawei.com>
 <20170321171605.GB29116@leverpostej>
Message-ID: <58D4C006.2010907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 21 March 2017 10:46 PM, Mark Rutland wrote:
> On Fri, Mar 10, 2017 at 01:28:45AM -0500, Anurup M wrote:
>> Add hrtimer support which use poll method to avoid counter overflow
>> when overflow IRQ is not supported in hardware.
>> The L3 cache PMU use N-N SPI interrupt which has no support in kernel
>> mainline. So use hrtimer to poll and update event counter to avoid
>> overflow condition for L3 cache PMU.
>> An interval of 10 seconds is used for the hrtimer.
> This should be folded with the previous patch, given that it is
> necessary for counters to work correctly.

I had separated for ease of review. I shall fold it to main L3C patch.

> [...]
>
>> +/*
>> + * Default timer frequency to poll and avoid counter overflow.
>> + * CPU speed = 2.4Ghz, Therefore Access time = 0.4ns
>> + * L1 cache - 2 way set associative
>> + * L2  - 16 way set associative
>> + * L3  - 16 way set associative. L3 cache has 4 banks.
>> + *
>> + * Overflow time = 2^31 * (access time L1 + access time L2 + access time L3)
>> + * = 2^31 * ((2 * 0.4ns) + (16 * 0.4ns) + (4 * 16 * 0.4ns)) = 70 seconds
>> + *
>> + * L3 cache is also used by devices like PCIe, SAS etc. at
>> + * the same time. So the overflow time could be even smaller.
>> + * So on a safe side we use a timer interval of 10sec
>> + */
>> +#define L3C_HRTIMER_INTERVAL (10LL * MSEC_PER_SEC)
> This sounds fine.
>
> [...]
>
>> +/*
>> + * sysfs hrtimer_interval attributes
>> + */
>> +ssize_t hisi_hrtimer_interval_sysfs_show(struct device *dev,
>> +					 struct device_attribute *attr,
>> +					 char *buf)
>> +{
>> +	struct pmu *pmu = dev_get_drvdata(dev);
>> +	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
>> +
>> +	if (hisi_pmu->hrt_duration)
>> +		return sprintf(buf, "%llu\n", hisi_pmu->hrt_duration);
>> +	return 0;
>> +}
> I don't think that we need a sysfs property for this.

Agreed. Shall remove it.

> [...]
>
>> +/* The counter overflow IRQ is not supported for some PMUs
>> + * use hrtimer to periodically poll and avoid overflow
>> + */
>> +static enum hrtimer_restart hisi_hrtimer_callback(struct hrtimer *hrtimer)
>> +{
>> +	struct hisi_pmu *hisi_pmu = container_of(hrtimer,
>> +						 struct hisi_pmu, hrtimer);
>> +	struct perf_event *event;
>> +	struct hw_perf_event *hwc;
>> +	unsigned long flags;
>> +
>> +	/* Return if no active events */
>> +	if (!hisi_pmu->num_active)
>> +		return HRTIMER_NORESTART;
>> +
>> +	local_irq_save(flags);
>> +
>> +	/* Update event count for each active event */
>> +	list_for_each_entry(event, &hisi_pmu->active_list, active_entry) {
>> +		hwc = &event->hw;
>> +		/* Read hardware counter and update the Perf event counter */
>> +		hisi_pmu->ops->event_update(event, hwc, GET_CNTR_IDX(hwc));
>> +	}
> How do we ensure that we don't take the interrupt in the middle of a
> sequence of accesses to the HW?

The L3 cache and MN PMU does not use the overflow IRQ and it does not 
occur here
as the interrupt Mask register is by default masked in hardware.
But yes I would modify it as

hisi_pmu->ops->overflow_handler (which can mask IRQ (if required) and 
call event_update)

Thanks,
Anurup

> Thanks,
> Mark.
