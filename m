From: majun258@huawei.com (majun (F))
Date: Sun, 4 Oct 2015 15:22:37 +0800
Subject: [PATCH v5 1/3] initialize each mbigen device node as a interrupt
 controller.
In-Reply-To: <alpine.DEB.2.11.1509302242220.4500@nanos>
References: <1443605949-15396-1-git-send-email-majun258@huawei.com>
 <1443605949-15396-2-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1509302242220.4500@nanos>
Message-ID: <5610D3BD.1040408@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas:

? 2015/10/1 5:37, Thomas Gleixner ??:
> On Wed, 30 Sep 2015, MaJun wrote:
> 
> First of all.
> 
> [PATCH v5 1/3] initialize each mbigen device node as a interrupt controller
> 
> is not a proper subject line, but that's the least of your problems.
> 
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/irqchip/chained_irq.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/msi.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include "irqchip.h"
> 
> Do you really need all these includes?

Ok, I will remove usless includes.
> 
>> +
>> +/* Interrupt numbers per mbigen node supported */
>> +#define IRQS_PER_MBIGEN_NODE	(128)
> 
[...]
>> +
>> +	info = &mgn_dev->mgn_data[index].info;
>> +	info->index = index;
>> +	info->global_pin_offset = GET_IRQ_PIN_OFFSET(d->hwirq);
>> +	info->nid = info->global_pin_offset / IRQS_PER_MBIGEN_NODE;
>> +
>> +	info->local_pin_offset = (info->global_pin_offset % IRQS_PER_MBIGEN_NODE)
>> +						- RESERVED_IRQ_PER_MBIGEN_CHIP;
>> +
>> +	info->reg_offset = get_mbigen_vec_reg_addr(info->nid, info->local_pin_offset);
> 
> So you fill in a structure with 5 fields and the only information
> which is ever used is local_pin_offset.
> 
> What's the point of this exercise? 

Besides local_pin_offset , nid, and reg_offset are also useful information which will be used
in next patch.

For each mbigen chip, the register space of mbigen node between each other is discontinuous.
So, I need to find the mbigen node number(nid) and pin offset within this mbigen node
(local_pin_offset). Based on them, I can get the corresponding register address.

> 
>> +
>> +	return &mgn_dev->mgn_data[index];
>> +}
>> +
>> +static int mbigen_set_affinity(struct irq_data *data,
>> +				const struct cpumask *mask_val,
>> +				bool force)
>> +{
>> +	struct mbigen_irq_data *mgn_irq_data = irq_data_get_irq_chip_data(data);
>> +	struct irq_chip *chip = irq_get_chip(mgn_irq_data->msi_irq);
> 
> And that msi_irq information comes from where? Nothing in that code
> initializes it.

msi_irq is is initialized in next patch.

>> +	struct irq_data *parent_d = irq_get_irq_data(mgn_irq_data->msi_irq);
> 
> Also WHY are you going through a full lookup of the chip and the irq
> data, if that is your parent irq? That's what the domain hierarchy is
> for. If you now tell me, that msi_irq is not the same as data->irq,
> i.e. the virq number, then you have a lot more things to explain.

Yes, they have different virq number. My explanation about this
problem is list at last.


> irq_chip_set_affinity_parent() is the callback you want for your chip,
> not some completely nonsensical hackery.

I think this is used for hierarchy structure. My interrupt controller is not
hierarchy structrue.

> 
>> +
>> +	if (chip && chip->irq_set_affinity)
> 
> Why would chip ever be NULL? If your parent interrupt does not have a
> chip assigned then your whole setup is hosed.
> 
>> +static void mbigen_eoi_irq(struct irq_data *data)
>> +{
>> +
>> +	struct mbigen_irq_data *mgn_irq_data = irq_data_get_irq_chip_data(data);
>> +	struct mbigen_device *mgn_dev = mgn_irq_data->dev;
> 
> So the only reason for accessing yet another data structure is to get
> the base address of that mbi device. You seem to have a strong
> interest in making the cache foot print of your code as big as
> possible. 
> 
>> +	struct irq_chip *chip = irq_get_chip(mgn_irq_data->msi_irq);
>> +	struct irq_data *parent_d = irq_get_irq_data(mgn_irq_data->msi_irq);
>> +	u32 pin_offset, ofst, mask;
>> +
>> +	pin_offset = mgn_irq_data->info.local_pin_offset;
>> +
>> +	ofst = pin_offset / 32 * 4;
>> +	mask = 1 << (pin_offset % 32);
>> +
>> +	writel_relaxed(mask, mgn_dev->base + ofst
>> +			+ REG_MBIGEN_CLEAR_OFFSET);
>> +
>> +	if (chip && chip->irq_eoi)
>> +		chip->irq_eoi(parent_d);
> 
> So again. Why would chip be NULL and why would chip NOT have an EOI
> callback?
> 
>> +static int mbigen_domain_xlate(struct irq_domain *d,
>> +			       struct device_node *controller,
>> +			       const u32 *intspec, unsigned int intsize,
>> +			       unsigned long *out_hwirq,
>> +			       unsigned int *out_type)
>> +{
>> +
>> +	if (d->of_node != controller)
>> +		return -EINVAL;
>> +
>> +	if (intsize < 2)
>> +		return -EINVAL;
>> +
>> +	/* Compose the hwirq local to mbigen domain
>> +	 * intspec[0]: interrut pin offset
>> +	 * intspec[1]: index(start from 0)
>> +	 */
>> +	*out_hwirq = COMPOSE_MBIGEN_HWIRQ(intspec[1], intspec[0]);
> 
> So here you use that convoluted MACRO. Why can't you open code it so
> we don't have to go up to the top of the file to see what you are
> composing?
> 
> We use macros and inlines for things which are used over and over, but
> not for code obfuscation.
> 
>> +static int mbigen_domain_map(struct irq_domain *d, unsigned int irq,
>> +				irq_hw_number_t hw)
>> +{
>> +	struct mbigen_device *mgn_dev = d->host_data;
>> +	struct mbigen_irq_data *mgn_irq_data;
>> +	struct irq_data *data = irq_get_irq_data(irq);
>> +
>> +	mgn_irq_data = get_mbigen_irq_data(mgn_dev, data);
>> +	if (!mgn_irq_data)
>> +		return -EINVAL;
> 
> Ah. Here is that useless function actually called and of course the
> return value which can never happen checked once more.
> 
>> +	mgn_irq_data->dev_irq = irq;
> 
> Oh, yet another place where you store the irq number. Darn, it's
> already in irq_data. Your data representation is a complete mess.
> 
> All you ever need from this is local_pin_offset and the base address
> for that calculation in the eoi callback.

dev_irq is stored for easily using in next patch when interrupt happened.

> 
>> +	pin_offset = mgn_irq_data->info.local_pin_offset;
>> +
>> +	ofst = pin_offset / 32 * 4;
>> +	mask = 1 << (pin_offset % 32);
>> +
>> +	writel_relaxed(mask, mgn_dev->base + ofst
>> +			+ REG_MBIGEN_CLEAR_OFFSET);
> 
> Now if you think about it, then you might figure out, that you can
> store that information in a way which does not require that math at
> all and you can avoid having all these pointless data structures for
> it. Hint: Each hierarchy level has it's own irq_data representation
> and that is sufficient to store everything.
> 
>> +	irq_set_chip_data(irq, mgn_irq_data);
>> +	irq_set_chip_and_handler(irq, &mbigen_irq_chip, handle_fasteoi_irq);
>> +
>> +	set_irq_flags(irq, IRQF_VALID);
> 
> And how does that compile against Linus kernel? Not at all.
> 
>> +
>> +	/* add this mbigen device into a global list*/
>> +	spin_lock(&mbigen_device_lock);
>> +	list_add(&mgn_dev->global_entry, &mbigen_device_list);
>> +	spin_unlock(&mbigen_device_lock);
> 
> And that global list is used whatfor? I can't see anything which makes
> use of it.

This global list is used to find out mbigen device when initializing the mbigen
device as a platform device in next patch.

Because there are several mbigen chips in this system, and each mbigen chip also
contains several mbgien devices.

I need a list contains all of the mbigen devices which connect to these mbigen
chips.
Then, during mbigen chip initializing, we can use this list to find out mbigen devices
and pass mbigen_device data structure.

> 
> That's a complete disaster and I'm not even thinking about looking at
> the next patch in this series.
> 
> Can you please explain in a simple ASCII picture how your irq chip
> hierarchy looks like and what kind of data you need for each hierarchy
> level?

Mbigen chip hardware structure shows as below:

		mbigen chip
|---------------------|-------------------|
mgn_node0	  mgn_node1		mgn_node2
 |		 |-------|		|-------|------|
dev1		dev1    dev2		dev1   dev3   dev4



Irq chip hierarchy stucture:
		
	ITS
	 |
	ITS-pMSI
	 | (virq1)
|--------| -----------------|
mbigen-device1		mbigen-device2
 | (virq2)		 | (virq2)
devices(uart)		device(gmac)


I named virq1 as msi_irq , virq2 as dev-irq and ,virq1 != virq2.

Each virq2 has a corresponding virq1.

Mbigen-device is a special hardware.
On the one hand, it's a platform device for ITS. We need to
allocate the msi-irqs for it.(handled in patch 2/3)

On the other hand, it's a interrupt controller for the devices connected to it.(handled in current patch).

To bind these two different irqs, I made a data sutruce named mbigen_irq_data
which contains some information  of this irq, including private index, pin_offset, nid,
and local_pin_offset.

All these information can help us to find the corresponding reg addr and msi_irq quickly.


Thanks!
Ma Jun
