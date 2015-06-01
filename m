From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 01 Jun 2015 10:13:10 +0100
Subject: [PATCH 3/4]: Change arm-gic-its to support the Mbigen interrupt
In-Reply-To: <55692C32.2050209@huawei.com>
References: <55692C32.2050209@huawei.com>
Message-ID: <556C2226.70502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/15 04:19, majun (F) wrote:
> This patch is applied to support the mbigen interrupt.
> 
> Change log:
> --For irq_mbigen.c using,move some struct and function definition
>   to a new head file arm-gic-its.h
> --Add a irq_write_mbi_msg member for mbi interrupt using
> --For mbi interrupt, the event id depends on the Hardware pin number on mbigen,
>   so, the its_get_event_id is changed to calclulate the event id of mbi interrupt
> --For mbigen, the device id information need to be carried with msg. So,
>   its_irq_compose_msi_msg is changed.
> --its_mask_msi_irq and its_unmaks_msi_irq are modifid for mbi interrupt using.
> --before the irq_ack callback, check the irq_ack first(chip.c)
> 
> 
> Signed-off-by: Ma Jun <majun258@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c    |   71 +++++++++++-----------------------
>  include/linux/irq.h                 |    1 +
>  include/linux/irqchip/arm-gic-its.h |   68 +++++++++++++++++++++++++++++++++
>  kernel/irq/chip.c                   |   12 ++++--
>  4 files changed, 100 insertions(+), 52 deletions(-)
>  mode change 100644 => 100755 drivers/irqchip/irq-gic-v3-its.c
>  create mode 100755 include/linux/irqchip/arm-gic-its.h
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> old mode 100644
> new mode 100755
> index 9687f8a..21c36bf
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -22,6 +22,7 @@
>  #include <linux/log2.h>
>  #include <linux/mm.h>
>  #include <linux/msi.h>
> +#include <linux/mbi.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> @@ -30,7 +31,7 @@
>  #include <linux/percpu.h>
>  #include <linux/slab.h>
> 
> -#include <linux/irqchip/arm-gic-v3.h>
> +#include <linux/irqchip/arm-gic-its.h>
> 
>  #include <asm/cacheflush.h>
>  #include <asm/cputype.h>
> @@ -42,36 +43,6 @@
> 
>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
> 
> -/*
> - * Collection structure - just an ID, and a redistributor address to
> - * ping. We use one per CPU as a bag of interrupts assigned to this
> - * CPU.
> - */
> -struct its_collection {
> -	u64			target_address;
> -	u16			col_id;
> -};
> -
> -/*
> - * The ITS structure - contains most of the infrastructure, with the
> - * msi_controller, the command queue, the collections, and the list of
> - * devices writing to it.
> - */
> -struct its_node {
> -	raw_spinlock_t		lock;
> -	struct list_head	entry;
> -	struct msi_controller	msi_chip;
> -	struct irq_domain	*domain;
> -	void __iomem		*base;
> -	unsigned long		phys_base;
> -	struct its_cmd_block	*cmd_base;
> -	struct its_cmd_block	*cmd_write;
> -	void			*tables[GITS_BASER_NR_REGS];
> -	struct its_collection	*collections;
> -	struct list_head	its_device_list;
> -	u64			flags;
> -	u32			ite_size;
> -};
> 
>  #define ITS_ITT_ALIGN		SZ_256
> 
> @@ -79,17 +50,6 @@ struct its_node {
>   * The ITS view of a device - belongs to an ITS, a collection, owns an
>   * interrupt translation table, and a list of interrupts.
>   */
> -struct its_device {
> -	struct list_head	entry;
> -	struct its_node		*its;
> -	struct its_collection	*collection;
> -	void			*itt;
> -	unsigned long		*lpi_map;
> -	irq_hw_number_t		lpi_base;
> -	int			nr_lpis;
> -	u32			nr_ites;
> -	u32			device_id;
> -};

As I said before, there is no way an external driver is going to touch
these. These structure are private to the ITS, and are definitely going
to stay that way.

> 
>  static LIST_HEAD(its_nodes);
>  static DEFINE_SPINLOCK(its_lock);
> @@ -528,7 +488,11 @@ static void its_send_invall(struct its_node *its, struct its_collection *col)
>  static inline u32 its_get_event_id(struct irq_data *d)
>  {
>  	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
> -	return d->hwirq - its_dev->lpi_base;
> +
> +	if (!is_mbigen_domain(d))
> +		return d->hwirq - its_dev->lpi_base;
> +	else
> +		return get_mbi_offset(d->irq);
>  }

So on top of exposing the guts of the ITS code to the outside world, you
are creating a compile-time dependency between the ITS and your MBI
thing. No way.

> 
>  static void lpi_set_config(struct irq_data *d, bool enable)
> @@ -599,7 +563,13 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
> 
>  	msg->address_lo		= addr & ((1UL << 32) - 1);
>  	msg->address_hi		= addr >> 32;
> -	msg->data		= its_get_event_id(d);
> +
> +	/*for devices connect to mbigen, device id
> +	 *information is needed*/
> +	if (!is_mbigen_domain(d))
> +		msg->data = its_get_event_id(d);
> +	else
> +		msg->data = (its_dev->device_id << 16) | its_get_event_id(d);
>  }
> 
>  static struct irq_chip its_irq_chip = {
> @@ -613,13 +583,15 @@ static struct irq_chip its_irq_chip = {
> 
>  static void its_mask_msi_irq(struct irq_data *d)
>  {
> -	pci_msi_mask_irq(d);
> +	if (!is_mbigen_domain(d))
> +		pci_msi_mask_irq(d);
>  	irq_chip_mask_parent(d);
>  }
> 
>  static void its_unmask_msi_irq(struct irq_data *d)
>  {
> -	pci_msi_unmask_irq(d);
> +	if (!is_mbigen_domain(d))
> +		pci_msi_unmask_irq(d);
>  	irq_chip_unmask_parent(d);
>  }
> 
> @@ -629,6 +601,8 @@ static struct irq_chip its_msi_irq_chip = {
>  	.irq_mask		= its_mask_msi_irq,
>  	.irq_eoi		= irq_chip_eoi_parent,
>  	.irq_write_msi_msg	= pci_msi_domain_write_msg,
> +	.irq_write_mbi_msg 	= mbigen_write_msg,
> +	.irq_ack		= irq_chip_ack_parent,
>  };
> 

Do you realize that you're hacking into code that is PCI specific, and
that most of your changes could be solved elegantly by just having an
MBI specific irqchip/domain?

>  /*
> @@ -721,6 +695,7 @@ static void its_lpi_free(unsigned long *bitmap, int base, int nr_ids)
> 
>  	for (lpi = base; lpi < (base + nr_ids); lpi += IRQS_PER_CHUNK) {
>  		int chunk = its_lpi_to_chunk(lpi);
> +
>  		BUG_ON(chunk > lpi_chunks);
>  		if (test_bit(chunk, lpi_bitmap)) {
>  			clear_bit(chunk, lpi_bitmap);
> @@ -1067,7 +1042,7 @@ static void its_cpu_init_collection(void)
>  	spin_unlock(&its_lock);
>  }
> 
> -static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
> +struct its_device *its_find_device(struct its_node *its, u32 dev_id)
>  {
>  	struct its_device *its_dev = NULL, *tmp;
>  	unsigned long flags;
> @@ -1086,7 +1061,7 @@ static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
>  	return its_dev;
>  }
> 
> -static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
> +struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>  					    int nvecs)
>  {
>  	struct its_device *dev;
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 62c6901..9a745a8 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -365,6 +365,7 @@ struct irq_chip {
> 
>  	void		(*irq_compose_msi_msg)(struct irq_data *data, struct msi_msg *msg);
>  	void		(*irq_write_msi_msg)(struct irq_data *data, struct msi_msg *msg);
> +	void		(*irq_write_mbi_msg)(struct irq_data *irq_data, struct msi_msg *msg);
> 
>  	int		(*irq_get_irqchip_state)(struct irq_data *data, enum irqchip_irq_state which, bool *state);
>  	int		(*irq_set_irqchip_state)(struct irq_data *data, enum irqchip_irq_state which, bool state);
> diff --git a/include/linux/irqchip/arm-gic-its.h b/include/linux/irqchip/arm-gic-its.h
> new file mode 100755
> index 0000000..5677114
> --- /dev/null
> +++ b/include/linux/irqchip/arm-gic-its.h
> @@ -0,0 +1,68 @@
> +/*
> + * Copyright (C) 2013, 2014 ARM Limited, All Rights Reserved.
> + * Author: Marc Zyngier <marc.zyngier@arm.com>
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef __LINUX_IRQCHIP_ARM_GIC_ITS_H
> +#define __LINUX_IRQCHIP_ARM_GIC_ITS_H
> +
> +#include <linux/irqchip/arm-gic-v3.h>
> +
> +struct its_device {
> +	struct list_head	entry;
> +	struct its_node		*its;
> +	struct its_collection	*collection;
> +	void			*itt;
> +	unsigned long		*lpi_map;
> +	irq_hw_number_t		lpi_base;
> +	int			nr_lpis;
> +	u32			nr_ites;
> +	u32			device_id;
> +};
> +/*
> + * Collection structure - just an ID, and a redistributor address to
> + * ping. We use one per CPU as a bag of interrupts assigned to this
> + * CPU.
> + */
> +struct its_collection {
> +	u64			target_address;
> +	u16			col_id;
> +};
> +
> +/*
> + * The ITS structure - contains most of the infrastructure, with the
> + * msi_controller, the command queue, the collections, and the list of
> + * devices writing to it.
> + */
> +struct its_node {
> +	raw_spinlock_t		lock;
> +	struct list_head	entry;
> +	struct msi_controller	msi_chip;
> +	struct irq_domain	*domain;
> +	void __iomem		*base;
> +	unsigned long		phys_base;
> +	struct its_cmd_block	*cmd_base;
> +	struct its_cmd_block	*cmd_write;
> +	void			*tables[GITS_BASER_NR_REGS];
> +	struct its_collection	*collections;
> +	struct list_head	its_device_list;
> +	u64			flags;
> +	u32			ite_size;
> +};
> +
> +struct its_device *its_find_device(struct its_node *its, u32 dev_id);
> +struct its_device *its_create_device(struct its_node *its, u32 dev_id,
> +					    int nvecs);
> +#endif
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index eb9a4ea..3020efc 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -882,7 +882,8 @@ void irq_cpu_offline(void)
>  void irq_chip_ack_parent(struct irq_data *data)
>  {
>  	data = data->parent_data;
> -	data->chip->irq_ack(data);
> +	if (data->chip->irq_ack)
> +		data->chip->irq_ack(data);
>  }
> 
>  /**
> @@ -892,7 +893,8 @@ void irq_chip_ack_parent(struct irq_data *data)
>  void irq_chip_mask_parent(struct irq_data *data)
>  {
>  	data = data->parent_data;
> -	data->chip->irq_mask(data);
> +	if (data->chip->irq_mask)
> +		data->chip->irq_mask(data);
>  }
> 
>  /**
> @@ -902,7 +904,8 @@ void irq_chip_mask_parent(struct irq_data *data)
>  void irq_chip_unmask_parent(struct irq_data *data)
>  {
>  	data = data->parent_data;
> -	data->chip->irq_unmask(data);
> +	if (data->chip->irq_unmask)
> +		data->chip->irq_unmask(data);
>  }
> 
>  /**
> @@ -912,7 +915,8 @@ void irq_chip_unmask_parent(struct irq_data *data)
>  void irq_chip_eoi_parent(struct irq_data *data)
>  {
>  	data = data->parent_data;
> -	data->chip->irq_eoi(data);
> +	if (data->chip->irq_eoi)
> +		data->chip->irq_eoi(data);
>  }
> 
>  /**
> 

Like I said in patch #1, you need to come up with a different approach.
Use the LPI layer of the ITS as the parent for your MBI, stop messing
with the PCI stuff, stop poking the ITS internals.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
