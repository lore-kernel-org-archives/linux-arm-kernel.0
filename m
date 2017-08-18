From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Aug 2017 18:47:39 +0100
Subject: [RFC 3/3] irqchip: Add Realtek RTD1295 mux driver
In-Reply-To: <d7b03533-0442-4df9-7829-5e81f3ed6f34@suse.de>
References: <20170817101140.32000-1-afaerber@suse.de>
 <20170817101140.32000-4-afaerber@suse.de>
 <da3b236f-08ec-837a-de18-4c22b30ce5ca@arm.com>
 <d7b03533-0442-4df9-7829-5e81f3ed6f34@suse.de>
Message-ID: <84641d7e-1312-18c4-67e3-7610c3a3f5f8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/08/17 18:21, Andreas F?rber wrote:
> Hi Marc,
> 
> Am 18.08.2017 um 12:53 schrieb Marc Zyngier:
>> On 17/08/17 11:11, Andreas F?rber wrote:
>>> This irq mux driver is derived from the RTD1295 vendor DT and assumes a linear
>>> mapping between intr_en and intr_status registers. Code for RTD119x indicates
>>> this may not always be the case (i2c_3).
>>>
>>> The register initialization was copied from QNAP's mach-rtk119x/rtk_irq_mux.c
>>> as a boot fix, without full insights into what exactly this is changing (TODO).
>>>
>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>> ---
>>>  drivers/irqchip/Makefile          |   1 +
>>>  drivers/irqchip/irq-rtd119x-mux.c | 201 ++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 202 insertions(+)
>>>  create mode 100644 drivers/irqchip/irq-rtd119x-mux.c
>>>
>>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>>> index e88d856cc09c..46202a0b7d96 100644
>>> --- a/drivers/irqchip/Makefile
>>> +++ b/drivers/irqchip/Makefile
>>> @@ -78,3 +78,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
>>>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
>>>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>>>  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
>>> +obj-$(CONFIG_ARCH_REALTEK)		+= irq-rtd119x-mux.o
> 
> Should this get its own config option? It would get shared by ARM64 and
> future potential ARM, so no strict need for composite expressions, and
> there's examples of both ways above.

If another platform type comes up with this particular gem, we can
always create a specific symbol. In the meantime, you can keep simple.

> BTW I was surprised that the Makefile does not seem to have a consistent
> order, leading to potential conflicts when adding things in the bottom.
> Have you guys thought about enforcing alphabetical order by either
> config option or file name?

Not really. I cannot bring myself to care about that kind of thing...

> 
>>> diff --git a/drivers/irqchip/irq-rtd119x-mux.c b/drivers/irqchip/irq-rtd119x-mux.c
>>> new file mode 100644
>>> index 000000000000..c6c1ba126bf3
>>> --- /dev/null
>>> +++ b/drivers/irqchip/irq-rtd119x-mux.c
>>> @@ -0,0 +1,201 @@
>>> +/*
>>> + * Realtek RTD129x IRQ mux
>>> + *
>>> + * Copyright (c) 2017 Andreas F?rber
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0+
>>> + */
>>> +
>>> +#include <linux/io.h>
>>> +#include <linux/irqchip.h>
>>> +#include <linux/irqchip/chained_irq.h>
>>> +#include <linux/irqdomain.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_irq.h>
>>> +#include <linux/slab.h>
>>> +
>>> +struct rtd119x_irq_mux_info {
>>> +	unsigned intr_status;
>>> +	unsigned intr_en;
>>
>> nit: these would be better named with a "_offset" suffix, in order to
>> better distinguish them from the structure below.
> 
> True, renamed. See also discussion in the bottom.
> 
>>> +};
>>> +
>>> +struct rtd119x_irq_mux_data {
>>> +	void __iomem *intr_status;
>>> +	void __iomem *intr_en;
>>> +	int irq;
>>> +	struct irq_domain *domain;
>>> +	spinlock_t lock;
>>> +};
>>> +
>>> +static void rtd119x_mux_irq_handle(struct irq_desc *desc)
>>> +{
>>> +	struct rtd119x_irq_mux_data *data = irq_desc_get_handler_data(desc);
>>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>>> +	u32 intr_en, intr_status, status;
>>> +	int ret;
>>> +
>>> +	chained_irq_enter(chip, desc);
>>> +
>>> +	spin_lock(&data->lock);
>>> +	intr_en     = readl(data->intr_en);
>>> +	intr_status = readl(data->intr_status);
>>
>> All the readl/writel should be turned into their _relaxed versions.
> 
> Hmm, so I use readl/writel by default. The old downstream code was using
> __raw_readl/__raw_writel, but my initial code appeared to work, so I
> left it that way.
> 
> Can you explain why _relaxed, so that I can properly choose next time?
> I see the difference is __iormb(), but when do I need that? Thanks.

You can use the _relaxed version when there is no dependency with a
memory access before (for a write) that needs to be propagated to the
device before the MMIO access takes place. In your case, the device (the
irqchip) never reads anything from memory, so there is strictly no need
to issue a dsb on each MMIO write.

> 
>>> +	spin_unlock(&data->lock);
>>> +
>>> +	status = intr_status & intr_en;
>>> +	if (status != 0) {
>>> +		unsigned irq = __ffs(status);
>>> +		ret = generic_handle_irq(irq_find_mapping(data->domain, irq));
>>> +		if (ret == 0) {
>>> +			spin_lock(&data->lock);
>>> +			intr_status = readl(data->intr_status);
>>> +			intr_status |= BIT(irq - 1);
>>> +			writel(intr_status, data->intr_status);
>>> +			spin_unlock(&data->lock);
>>> +		}
>>> +	}
>>
>> And what if status is 0? We keep the lock held forever?
> 
> Which lock? Locking is only done for consistently reading en and status,
> and for the read-modify-write of status. Both look balanced to me, and
> no hangs have been observed in testing.

Forget it. I read the above "unlock" as a "lock", and everything went
downhill. Too much crap code today, I see it everywhere.

> 
> __ffs: "Undefined if no bit exists, so code should check against 0 first."
> 
> If status is 0 then there's no pending enabled interrupt and thus
> nothing to do.
> 
> The downstream code modified all drivers (e.g., 8250 serial) to
> acknowledge their interrupts inside the drivers, and instead it had code
> that complained and cleared them here.

Well, good luck to them.

> I wanted to keep the irqchip abstraction, so I am always acknowledging
> the interrupt if generic_handle_irq does not run into an error - I
> understood that this is not the same as actually having been
> successfully handled, but I did not see a better way for how to do this
> in generic code.
> (I am facing a similar mux situation with FM4, so input appreciated on
> whether these are right hooks to use - for FM4 I got stuck trying to
> adopt the hierarchical API and resorted to the simpler approach here.)
> 
> Would you rather have realtek,intr_en and realtek,intr_status properties
> in the relevant device nodes and drivers and acknowledge the interrupts
> from their respective interrupt handlers and then ignore it here?

Certainly not. Dealing with the interrupt controller is the job of the
irqchip driver, hence no need to pollute the drivers. What you're doing
is fine, though masking the interrupt on error is a bit heavy handed...

>>> +
>>> +	chained_irq_exit(chip, desc);
>>> +}
>>> +
>>> +static void rtd119x_mux_mask_irq(struct irq_data *data)
>>> +{
>>> +	struct rtd119x_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
>>> +	u32 intr_status;
>>> +
>>> +	intr_status = readl(mux_data->intr_status);
>>> +	intr_status |= BIT(data->hwirq);
>>> +	writel(intr_status, mux_data->intr_status);
>>
>> So you need a lock in the chained handler, but you don't need one here?
>> It doesn't feel right.
> 
> Good point. I had started without locks; should add them here and below.
> 
>>> +}
>>> +
>>> +static void rtd119x_mux_unmask_irq(struct irq_data *data)
>>> +{
>>> +	struct rtd119x_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
>>> +	u32 intr_en;
>>> +
>>> +	intr_en = readl(mux_data->intr_en);
>>> +	intr_en |= BIT(data->hwirq);
>>> +	writel(intr_en, mux_data->intr_en);
>>
>> Same thing here.
>>
>>> +}
>>> +
>>> +static int rtd119x_mux_set_affinity(struct irq_data *d,
>>> +			const struct cpumask *mask_val, bool force)
>>> +{
>>> +	struct rtd119x_irq_mux_data *mux_data = irq_data_get_irq_chip_data(d);
>>> +	struct irq_chip *chip = irq_get_chip(mux_data->irq);
>>> +	struct irq_data *data = irq_get_irq_data(mux_data->irq);
>>> +
>>> +	if (chip && chip->irq_set_affinity)
>>> +		return chip->irq_set_affinity(data, mask_val, force);
>>
>> I'm always worried when I see this. It means that all of the interrupts
>> on the secondary chip move in one go, without the core code noticing.
> 
> You mean it affects all 32 mux'ed IRQs as a side effect here? True.
> 
>> One of these days, we'll have to address it.
> 
> Note that currently I have only a single core up on RTD1295, so affinity
> is not really tested. (They use a custom "rtk-spin-table" implementation
> that I have no source code or documentation for, and I haven't made
> guesses yet, nor do I think that would be acceptable in mainline arm64.)

Indeed.

> This hook appears to be optional, so we could just drop it for now, or
> always return -EINVAL if preferred over forwarding to the GIC?

I'd feel more comfortable with that. Just return -EINVAL.

>>> +
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static struct irq_chip rtd119x_mux_irq_chip = {
>>> +	.name			= "rtd119x-mux",
>>> +	.irq_mask		= rtd119x_mux_mask_irq,
>>> +	.irq_unmask		= rtd119x_mux_unmask_irq,
>>> +	.irq_set_affinity	= rtd119x_mux_set_affinity,
>>> +};
>>> +
>>> +static int rtd119x_mux_irq_domain_xlate(struct irq_domain *d,
>>> +		struct device_node *controller,
>>> +		const u32 *intspec, unsigned int intsize,
>>> +		unsigned long *out_hwirq,
>>> +		unsigned int *out_type)
>>> +{
>>> +	if (irq_domain_get_of_node(d) != controller)
>>> +		return -EINVAL;
>>> +
>>> +	if (intsize < 1)
>>> +		return -EINVAL;
>>> +
>>> +	*out_hwirq = intspec[0];
>>> +	*out_type = 0;
>>> +
>>> +	return 0;
>>> +}
>>
>> Please use irq_domain_xlate_onecell() instead.
> 
> Thanks for the pointer, done.
> 
>>> +
>>> +static int rtd119x_mux_irq_domain_map(struct irq_domain *d,
>>> +		unsigned int irq, irq_hw_number_t hw)
>>> +{
>>> +	struct rtd119x_irq_mux_data *data = d->host_data;
>>> +
>>> +	irq_set_chip_and_handler(irq, &rtd119x_mux_irq_chip, handle_level_irq);
>>> +	irq_set_chip_data(irq, data);
>>> +	irq_set_probe(irq);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct irq_domain_ops rtd119x_mux_irq_domain_ops = {
>>> +	.xlate	= rtd119x_mux_irq_domain_xlate,
>>> +	.map	= rtd119x_mux_irq_domain_map,
>>> +};
> [...]
>>> +static const struct rtd119x_irq_mux_info rtd1295_iso_irq_mux_info = {
>>> +	.intr_status	= 0x0,
>>> +	.intr_en	= 0x40,
>>> +};
>>> +
>>> +static int __init rtd1295_iso_irq_mux_init(struct device_node *node,
>>> +					   struct device_node *parent)
>>> +{
>>> +	return rtd119x_irq_mux_init(node, parent, &rtd1295_iso_irq_mux_info);
>>> +}
>>> +IRQCHIP_DECLARE(rtd1295_iso_mux, "realtek,rtd1295-iso-irq-mux", rtd1295_iso_irq_mux_init);
>>> +
>>> +static const struct rtd119x_irq_mux_info rtd1295_irq_mux_info = {
>>> +	.intr_status	= 0xc,
>>> +	.intr_en	= 0x80,
>>> +};
>>> +
>>> +static int __init rtd1295_irq_mux_init(struct device_node *node,
>>> +				       struct device_node *parent)
>>> +{
>>> +	return rtd119x_irq_mux_init(node, parent, &rtd1295_irq_mux_info);
>>> +}
>>> +IRQCHIP_DECLARE(rtd1295_mux, "realtek,rtd1295-irq-mux", rtd1295_irq_mux_init);
> 
> This was a quick hack to cover both instances. I am not yet sure how to
> best model the case of e.g. en bit 28 corresponding to status bit 23 in
> the struct. An index array of all 32 bits with special value for absent,
> to iteratively or the bits instead of masking them?
> 
> We might use of_match_node() to get the info pointer in one generic init
> function instead of having per-compatible init functions down here, but
> then we'd have the compatibles duplicated (compared to platform_driver
> reusing the same of_device_id array).
> 
> For the bit twiddling we could use of_device_is_compatible() and avoid
> this info struct altogether. That would allow to implement more complex
> logic - doesn't rule out using this struct for the offsets of course.
> 
> Preferences?

None. This looks like fishy/undocumented HW, so whatever floats your
boat will work for me. The struct seem slightly overkill given the
information it provides, but that's your choice.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
