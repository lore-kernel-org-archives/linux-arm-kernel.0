From: anurupvasu@gmail.com (Anurup M)
Date: Tue, 21 Feb 2017 17:19:58 +0530
Subject: [PATCH v4 10/11] drivers: perf: hisi: Handle counter overflow IRQ
 in MN PMU
In-Reply-To: <20170220112918.GG9003@leverpostej>
References: <1487530282-42731-1-git-send-email-anurup.m@huawei.com>
 <20170220112918.GG9003@leverpostej>
Message-ID: <58AC2966.3060200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 20 February 2017 04:59 PM, Mark Rutland wrote:
> Hi,
>
> On Sun, Feb 19, 2017 at 01:51:22PM -0500, Anurup M wrote:
>> +static irqreturn_t hisi_pmu_mn_isr(int irq, void *dev_id)
>> +{
>> +	struct hisi_pmu *mn_pmu = dev_id;
>> +	struct hisi_mn_data *mn_data = mn_pmu->hwmod_data;
>> +	struct hisi_djtag_client *client = mn_data->client;
>> +	struct perf_event *event;
>> +	u32 module_id = GET_MODULE_ID(mn_data);
>> +	unsigned long flags;
>> +	u32 value = 0;
>> +	int bit_pos;
>> +
>> +	raw_spin_lock_irqsave(&mn_pmu->lock, flags);
>> +
>> +	/* Read the INTS register */
>> +	hisi_djtag_readreg(module_id, MN1_BANK_SELECT, MN1_INTS_REG_OFF,
>> +							client, &value);
> Weird alignment here. Please only align up to the '('.

Thanks. Shall correct it.

>> +	if (!value) {
>> +		raw_spin_unlock_irqrestore(&mn_pmu->lock, flags);
>> +		return IRQ_NONE;
>> +	}
>> +
>> +	/* Find the counter index which overflowed and handle them */
>> +	for (bit_pos = 0; bit_pos < HISI_MAX_CFG_MN_CNTR; bit_pos++) {
>> +		if (test_bit(bit_pos, (void *)&value)) {
> This casting is incorrect. Please listen to the compiler in future, and
> don't bodge around it like this.
>
> Make value an unsigned long, and use another temporary variable for the
> hisi_djtag_readreg() call (i.e. don't cast to a u32 there either).
>
> e.g.
> 	unsigned long overflown;
> 	u32 ints;
> 	int idx;
>
> 	hisi_djtag_readreg(module_id, MN1_BANK_SELECT, MN1_INTS_REG_OFF,
> 	                   client, &ints);
> 	
> 	...
>
> 	overflown = ints;
>
> 	for_each_set_bit(idx, &overflown, HISI_MAX_CFG_MN_CNTR) {
>
> 		...
>
> 	}
>

I'm sorry for this. Shall modify as suggested. Shall take care of this 
in entire patch series.

>> +			/* Clear the IRQ status flag */
>> +			hisi_djtag_writereg(module_id, MN1_BANK_SELECT,
>> +				MN1_INTC_REG_OFF, (1 << bit_pos), client);
>> +
>> +			/* Get the corresponding event struct */
>> +			event = mn_pmu->hw_perf_events[bit_pos];
>> +			if (!event)
>> +				continue;
> Do we expect to take interrupts for an event which does not exist?

Here I ignore if the event does not exist. I have seen it is handled in 
arm_pmu and other reference
implementations to ignore if there is no event.
The event is cleared in .del. So if .del is called before the IRQ 
handler, this check is required right?
Please comment.

> Elsewhere we do not, and we WARN_ON_ONCE() for this case.
>
> [...]
>
>> +static int hisi_mn_init_irq(int irq, struct hisi_pmu *mn_pmu,
>> +				     struct hisi_djtag_client *client)
>> +{
>> +	struct hisi_mn_data *mn_data = mn_pmu->hwmod_data;
>> +	u32 module_id = GET_MODULE_ID(mn_data);
>> +	struct device *dev = &client->dev;
>> +	int rc;
>> +
>> +	rc = devm_request_irq(dev, irq, hisi_pmu_mn_isr,
>> +			       IRQF_NOBALANCING | IRQF_NO_THREAD,
>> +					       dev_name(dev), mn_pmu);
>> +	if (rc) {
>> +		dev_err(dev, "Could not request IRQ:%d\n", irq);
>> +		return rc;
>> +	}
>> +
>> +	/* Overflow interrupt also should use the same CPU */
>> +	rc = irq_set_affinity(irq, &mn_pmu->cpu);
>> +	if (rc) {
>> +		dev_err(dev, "could not set IRQ affinity!\n");
>> +		return rc;
>> +	}
>> +
>> +	/*
>> +	 * Unmask all interrupts in Mask register
>> +	 * Enable all IRQ's
>> +	 */
>> +	hisi_mn_enable_interrupts(module_id, client);
> Nit: s/IRQ's/IRQs/

Thanks. shall correct it.

>
> We've only requested one interrupt. Why are we manipulating others?
>
> [...]

There are 4 counters in MN1. so here I enable the overflow IRQ of all 
counters.
I shall modify the comment to describe it more clearly with bits in the 
register .

>> +static int hisi_mn_init_irqs_fdt(struct device *dev,
>> +				struct hisi_pmu *mn_pmu)
>> +{
>> +	struct hisi_mn_data *mn_data = mn_pmu->hwmod_data;
>> +	struct hisi_djtag_client *client = mn_data->client;
>> +	int irq = -1, num_irqs, i;
>> +
>> +	num_irqs = of_irq_count(dev->of_node);
> Surely we expect a specific number of interrupts?
>
>> +	for (i = 0; i < num_irqs; i++) {
>> +		irq = of_irq_get(dev->of_node, i);
>> +		if (irq < 0)
>> +			dev_info(dev, "No IRQ resource!\n");
>> +	}
> Why are we throwing these away?
>
>> +
>> +	if (irq < 0)
>> +		return 0;
>> +
>> +	/* The last entry in the IRQ list to be chosen
>> +	 * This is as per mbigen-v2 IRQ mapping
>> +	 */
>> +	return hisi_mn_init_irq(irq, mn_pmu, client);
> I don't understand this comment.
>
> Why do we only use the list IRQ?
>
> What does this have to do with the mbigen?
>
> No ordering requirement was described in the DT binding.

There is a defect in the mbigen hardware to handle the IRQ mapping for 
MN. Due to this the IRQ property
of MN is made as a list and we read all IRQs and use only the last one.
I shall mention it in the comment and also add note in the DT bindings.
Is it OK? Please share your comment.

Thanks,
Anurup

> Thanks,
> Mark.
