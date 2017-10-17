From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 17 Oct 2017 13:50:55 +0200
Subject: [PATCH v2 2/3] irqchip: Add Realtek RTD1295 mux driver
In-Reply-To: <daf9b232-69dc-7701-6a0d-b28479d1f7d4@arm.com>
References: <20170828105344.8338-1-afaerber@suse.de>
 <20170828105344.8338-3-afaerber@suse.de>
 <daf9b232-69dc-7701-6a0d-b28479d1f7d4@arm.com>
Message-ID: <7f4a052b-2543-aed6-a4d8-e842aa994058@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.10.2017 um 19:35 schrieb Marc Zyngier:
> On 28/08/17 11:53, Andreas F?rber wrote:
>> This irq mux driver is derived from the RTD1295 vendor DT and assumes a
>> linear mapping between intr_en and intr_status registers.
>> Code for RTD119x indicates this may not always be the case (i2c_3).
>>
>> Based in part on QNAP's arch/arm/mach-rtk119x/rtk_irq_mux.c code.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  v1 -> v2:
>>  * Renamed struct fields to avoid ambiguity (Marc)
>>  * Refactored offset lookup to avoid per-compatible init functions
>>  * Inserted white lines to clarify balanced locking (Marc)
>>  * Dropped forwarding of set_affinity to GIC (Marc)
>>  * Added spinlocks for consistency (Marc)
>>  * Limited initialization quirk to iso mux
>>  * Fixed spinlock initialization (Andrew)
>>  
>>  drivers/irqchip/Makefile          |   1 +
>>  drivers/irqchip/irq-rtd119x-mux.c | 204 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 205 insertions(+)
>>  create mode 100644 drivers/irqchip/irq-rtd119x-mux.c
>>
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index e88d856cc09c..46202a0b7d96 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -78,3 +78,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
>>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
>>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>>  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
>> +obj-$(CONFIG_ARCH_REALTEK)		+= irq-rtd119x-mux.o
>> diff --git a/drivers/irqchip/irq-rtd119x-mux.c b/drivers/irqchip/irq-rtd119x-mux.c
>> new file mode 100644
>> index 000000000000..65d22e163bef
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-rtd119x-mux.c
>> @@ -0,0 +1,204 @@
>> +/*
>> + * Realtek RTD129x IRQ mux
>> + *
>> + * Copyright (c) 2017 Andreas F?rber
>> + *
>> + * SPDX-License-Identifier: GPL-2.0+
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqchip/chained_irq.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/slab.h>
>> +
>> +struct rtd119x_irq_mux_info {
>> +	unsigned intr_status_offset;
>> +	unsigned intr_en_offset;
>> +};
>> +
>> +struct rtd119x_irq_mux_data {
>> +	void __iomem *intr_status;
>> +	void __iomem *intr_en;
>> +	int irq;
>> +	struct irq_domain *domain;
>> +	spinlock_t lock;
>> +};
>> +
>> +static void rtd119x_mux_irq_handle(struct irq_desc *desc)
>> +{
>> +	struct rtd119x_irq_mux_data *data = irq_desc_get_handler_data(desc);
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	u32 intr_en, intr_status, status;
>> +	int ret;
>> +
>> +	chained_irq_enter(chip, desc);
>> +
>> +	spin_lock(&data->lock);
>> +	intr_en     = readl(data->intr_en);
> 
> I think that all the MMIO accessors in this file can advantageously
> turned into their _relaxed version (none of them require any barrier).

Done, works okay.

>> +	intr_status = readl(data->intr_status);
>> +	spin_unlock(&data->lock);
>> +
>> +	status = intr_status & intr_en;
>> +	if (status != 0) {
>> +		unsigned irq = __ffs(status);
>> +		ret = generic_handle_irq(irq_find_mapping(data->domain, irq));
>> +		if (ret == 0) {
>> +			spin_lock(&data->lock);
>> +
>> +			intr_status = readl(data->intr_status);
>> +			intr_status |= BIT(irq - 1);
>> +			writel(intr_status, data->intr_status);
> 
> This sequence feels a bit wrong: It seems to imply that writing to the
> status register is a way to EOI the interrupt. But what happens to the
> other bits that you've read? I fear that you are inadvertently
> signalling an EOI for interrupts that you may not have handled yet.
> 
> I'd rather see something like this:
> 
> 	while (status) {
> 		irq = __ffs(status) - 1;
> 		writel_relaxed(BIT(irq), data->intr_status);
> 		generic_handle_irq(irq_find_mapping(data->domain, irq));
> 		status &= ~irq;
> 	}
> 
> assuming I've understood how the HW works. No need for additional locking.

I've adopted a similar loop from the RTD1296 code, which differs from
the old RTD1195 code, which was like the above.

Similarly, the UART does a simple write for ack but the RTD1195's
fallback code here did the read-modify-write cycle. RTD129x removed that
fallback apparently.

I've reworked the code to use register names found in RTD1195 headers,
which will hopefully clarify things as far as there is code. I did not
find any code actually using the *_UMSK_ISR register, only *_ISR and
*_SCPU_INT_EN.

>> +
>> +			spin_unlock(&data->lock);
>> +		}
>> +	}
>> +
>> +	chained_irq_exit(chip, desc);
>> +}
>> +
>> +static void rtd119x_mux_mask_irq(struct irq_data *data)
>> +{
>> +	struct rtd119x_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
>> +	u32 intr_status;
>> +
>> +	spin_lock(&mux_data->lock);
> 
> Bang, you're dead. If you get the chained interrupt firing here on the
> same CPU, it will take the lock in the above function, and everything
> will grind to a halt. Use the irqsave version.

Done.

> 
>> +
>> +	intr_status = readl(mux_data->intr_status);
>> +	intr_status |= BIT(data->hwirq);
>> +	writel(intr_status, mux_data->intr_status);
> 
> Or maybe I haven't understood how this works at all. Can you please
> explain? I'd expect masking to be the opposite of unmasking, but that's
> not the case...

Again, I have no documentation, just like you, so I cannot definitively
explain their hardware. Only downstream code and experiments. I've been
testing it with serial console and I?C access to PMIC.

>> +
>> +	spin_unlock(&mux_data->lock);
>> +}
>> +
>> +static void rtd119x_mux_unmask_irq(struct irq_data *data)
>> +{
>> +	struct rtd119x_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
>> +	u32 intr_en;
>> +
>> +	spin_lock(&mux_data->lock);
>> +
> 
> Same here.
> 
>> +	intr_en = readl(mux_data->intr_en);
>> +	intr_en |= BIT(data->hwirq);
>> +	writel(intr_en, mux_data->intr_en);
>> +
>> +	spin_unlock(&mux_data->lock);
>> +}
>> +
>> +static int rtd119x_mux_set_affinity(struct irq_data *d,
>> +			const struct cpumask *mask_val, bool force)
>> +{
>> +	/* Forwarding the affinity to the parent would affect all 32 interrupts. */
>> +	return -EINVAL;
>> +}
>> +
>> +static struct irq_chip rtd119x_mux_irq_chip = {
>> +	.name			= "rtd119x-mux",
>> +	.irq_mask		= rtd119x_mux_mask_irq,
>> +	.irq_unmask		= rtd119x_mux_unmask_irq,
>> +	.irq_set_affinity	= rtd119x_mux_set_affinity,
>> +};
>> +
>> +static int rtd119x_mux_irq_domain_map(struct irq_domain *d,
>> +		unsigned int irq, irq_hw_number_t hw)
>> +{
>> +	struct rtd119x_irq_mux_data *data = d->host_data;
>> +
>> +	irq_set_chip_and_handler(irq, &rtd119x_mux_irq_chip, handle_level_irq);
>> +	irq_set_chip_data(irq, data);
>> +	irq_set_probe(irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct irq_domain_ops rtd119x_mux_irq_domain_ops = {
>> +	.xlate	= irq_domain_xlate_onecell,
>> +	.map	= rtd119x_mux_irq_domain_map,
>> +};
>> +
>> +static const struct rtd119x_irq_mux_info rtd1295_iso_irq_mux_info = {
>> +	.intr_status_offset	= 0x0,
>> +	.intr_en_offset		= 0x40,
>> +};
>> +
>> +static const struct rtd119x_irq_mux_info rtd1295_irq_mux_info = {
>> +	.intr_status_offset	= 0xc,
>> +	.intr_en_offset		= 0x80,
>> +};
>> +
>> +static const struct of_device_id rtd1295_irq_mux_dt_matches[] = {
>> +	{
>> +		.compatible = "realtek,rtd1295-iso-irq-mux",
>> +		.data = &rtd1295_iso_irq_mux_info,
>> +	}, {
>> +		.compatible = "realtek,rtd1295-irq-mux",
>> +		.data = &rtd1295_irq_mux_info,
>> +	}, {
>> +	}
>> +};
>> +
>> +static int __init rtd119x_irq_mux_init(struct device_node *node,
>> +				       struct device_node *parent)
>> +{
>> +	struct rtd119x_irq_mux_data *data;
>> +	const struct of_device_id *match;
>> +	const struct rtd119x_irq_mux_info *info;
>> +	void __iomem *base;
>> +	u32 val;
>> +
>> +	match = of_match_node(rtd1295_irq_mux_dt_matches, node);
>> +	if (!match)
>> +		return -EINVAL;
>> +
>> +	info = match->data;
>> +	if (!info)
>> +		return -EINVAL;
>> +
>> +	base = of_iomap(node, 0);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->intr_status = base + info->intr_status_offset;
>> +	data->intr_en     = base + info->intr_en_offset;
>> +
>> +	data->irq = irq_of_parse_and_map(node, 0);
>> +	if (data->irq <= 0) {
>> +		kfree(data);
>> +		return -EINVAL;
>> +	}
>> +
>> +	spin_lock_init(&data->lock);
>> +
>> +	data->domain = irq_domain_add_linear(node, 32,
>> +				&rtd119x_mux_irq_domain_ops, data);
>> +	if (!data->domain) {
>> +		kfree(data);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	if (of_device_is_compatible(node, "realtek,rtd1295-iso-irq-mux")) {
>> +		const int uart0_irq = 2;
>> +
>> +		spin_lock(&data->lock);
>> +
>> +		val = readl(data->intr_en);
>> +		val &= ~BIT(uart0_irq);
>> +		writel(val, data->intr_en);
>> +
>> +		writel(BIT(uart0_irq), data->intr_status);
> 
> Same here. Can you please explain what you're trying to do? The locking
> seems a bit pointless (nobody can request the interrupt yet), and this
> uart0 needs at least a comment, and maybe a description in the device-tree.

Please see v1... downstream has it unconditionally for both iso and
misc. I'm adding a comment that this resolves a hang.
I can drop the lock, was locking all register accesses for consistency.

>> +
>> +		spin_unlock(&data->lock);
>> +	}
>> +
>> +	irq_set_chained_handler_and_data(data->irq, rtd119x_mux_irq_handle, data);
>> +
>> +	return 0;
>> +}
>> +IRQCHIP_DECLARE(rtd1295_iso_mux, "realtek,rtd1295-iso-irq-mux", rtd119x_irq_mux_init);
>> +IRQCHIP_DECLARE(rtd1295_mux, "realtek,rtd1295-irq-mux", rtd119x_irq_mux_init);

Thanks for getting back to this. Note that this driver is needed both
for UART and I?C, and no lock-ups have been observed so far. So let's
please try to tidy this up sufficiently for merging into 4.15, so that
we can flush some more of the 100+ patches on top.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
