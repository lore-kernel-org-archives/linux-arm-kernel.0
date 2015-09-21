From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 21 Sep 2015 22:53:24 +0100
Subject: [PATCH v4 1/2] Add the driver of mbigen interrupt controller
In-Reply-To: <1439952920-2296-2-git-send-email-majun258@huawei.com>
References: <1439952920-2296-1-git-send-email-majun258@huawei.com>
 <1439952920-2296-2-git-send-email-majun258@huawei.com>
Message-ID: <20150921225324.5568f673@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Aug 2015 03:55:19 +0100
MaJun <majun258@huawei.com> wrote:

> From: Ma Jun <majun258@huawei.com>
> 
> Mbigen means Message Based Interrupt Generator(MBIGEN).
> 
> Its a kind of interrupt controller that collects
> 
> the interrupts from external devices and generate msi interrupt.
> 
> Mbigen is applied to reduce the number of wire connected interrupts.
> 
> As the peripherals increasing, the interrupts lines needed is
> increasing much, especially on the Arm64 server soc.
> 
> Therefore, the interrupt pin in gic is not enough to cover so
> many peripherals.
> 
> Mbigen is designed to fix this problem.
> 
> Mbigen chip locates in ITS or outside of ITS.
> 
> Mbigen chip hardware structure shows as below:
> 
>                 mbigen chip
> |---------------------|-------------------|
> mgn_node0         mgn_node1             mgn_node2
>  |               |-------|              |-------|------|
> dev1            dev1    dev2            dev1   dev3   dev4
> 
> Each mbigen chip contains several mbigen nodes.
> 
> External devices can connects to mbigen node through wire connecting way.
> 
> Because a mbigen node only can support 128 interrupt maximum, depends
> on the interrupt lines number of devices, a device can connects to one
> more mbigen nodes.
> 
> Also, several different devices can connect to a same mbigen node.
> 
> When devices triggered interrupt,mbigen chip detects and collects
> the interrupts and generates the MBI interrupts by writing the ITS
> Translator register.

First remark: this patch is *huge*, which makes it very hard to review.
Can you please split future revisions into smaller bits that can be
more easily reviewed independently? MSI handling in one patch,
interrupt controller in another would be a sensible split.

> Signed-off-by: Ma Jun <majun258@huawei.com>
> ---
>  drivers/irqchip/Kconfig      |    8 +
>  drivers/irqchip/Makefile     |    1 +
>  drivers/irqchip/irq-mbigen.c |  732 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 741 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/irqchip/irq-mbigen.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 120d815..356507f 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -27,6 +27,14 @@ config ARM_GIC_V3_ITS
>         bool
>         select PCI_MSI_IRQ_DOMAIN
> 
> +config HISILICON_IRQ_MBIGEN
> +       bool "Support mbigen interrupt controller"
> +       default n
> +       depends on ARM_GIC_V3 && ARM_GIC_V3_ITS
> +       help
> +        Enable the mbigen interrupt controller used on
> +        Hisilicon platform.
> +
>  config ARM_NVIC
>         bool
>         select IRQ_DOMAIN
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 11d08c9..c6f3d66 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_ARM_GIC)                 += irq-gic.o irq-gic-common.o
>  obj-$(CONFIG_ARM_GIC_V2M)              += irq-gic-v2m.o
>  obj-$(CONFIG_ARM_GIC_V3)               += irq-gic-v3.o irq-gic-common.o
>  obj-$(CONFIG_ARM_GIC_V3_ITS)           += irq-gic-v3-its.o irq-gic-v3-its-pci-msi.o irq-gic-v3-its-platform-msi.o
> +obj-$(CONFIG_HISILICON_IRQ_MBIGEN)     += irq-mbigen.o
>  obj-$(CONFIG_ARM_NVIC)                 += irq-nvic.o
>  obj-$(CONFIG_ARM_VIC)                  += irq-vic.o
>  obj-$(CONFIG_ATMEL_AIC_IRQ)            += irq-atmel-aic-common.o irq-atmel-aic.o
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> new file mode 100644
> index 0000000..4bbbd76
> --- /dev/null
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -0,0 +1,732 @@
> +/*
> + * Copyright (C) 2014 Hisilicon Limited, All Rights Reserved.
> + * Author: Jun Ma <majun258@huawei.com>
> + * Author: Yun Wu <wuyun.wu@huawei.com>
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
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include "irqchip.h"
> +
> +#define        MBIGEN_NODE_SHIFT       (8)
> +#define MBIGEN_DEV_SHIFT       (12)
> +
> +/*
> + * To avoid the duplicate hwirq number problem
> + * we use device id, mbigen node number and interrupt
> + * pin offset to generate a new hwirq number in mbigen
> + * domain.
> + *
> + * hwirq[32:12]: did. device id
> + * hwirq[11:8]: nid. mbigen node number
> + * hwirq[7:0]: pin. hardware pin offset of this interrupt
> + */
> +#define        COMPOSE_MBIGEN_HWIRQ(did, nid, pin)     \
> +               (((did) << MBIGEN_DEV_SHIFT) | \
> +               ((nid) << MBIGEN_NODE_SHIFT) | (pin))

The fact that you have to create a "virtual" hwirq number is an
indication that you are doing something wrong. It seems to me that it
would be much simpler if you had one domain per mode, with the pin
being the actual hwirq (as you would expect it), you'd have a much
simpler design overall.

Do not try to have a global hwirq space unless you really need it. So
far, I haven't seen anything here that mandate such a complex solution.

> +
> +/* get the interrupt pin offset from mbigen hwirq */
> +#define        GET_IRQ_PIN_OFFSET(hwirq)       ((hwirq) & 0xff)
> +/* get the mbigen node number from mbigen hwirq */
> +#define GET_MBIGEN_NODE_NUM(hwirq)     (((hwirq) >> MBIGEN_NODE_SHIFT) & 0xf)
> +/* get the mbigen device id from mbigen hwirq */
> +#define GET_MBIGEN_DEVICE_ID(hwirq)    \
> +               (((hwirq) >> MBIGEN_DEV_SHIFT) & 0xfffff)
> +
> +/*
> + * In mbigen vector register
> + * bit[21:12]: event id value
> + * bit[11:0]: device id
> + */
> +#define IRQ_EVENT_ID_SHIFT     (12)
> +#define IRQ_EVENT_ID_MASK      (0x3ff)
> +
> +/* register range of mbigen node  */
> +#define MBIGEN_NODE_OFFSET     0x1000
> +
> +/* offset of vector register in mbigen node */
> +#define REG_MBIGEN_VEC_OFFSET  0x200
> +
> +/* offset of clear register in mbigen node.
> + * This register is used to clear the status
> + * of interrupt.
> + */
> +#define REG_MBIGEN_CLEAR_OFFSET        0xa00
> +
> +/* offset of interrupt type register */
> +#define REG_MBIGEN_TYPE_OFFSET 0x0
> +
> +/*
> + * get the base address of mbigen node
> + * nid: mbigen node number
> + */
> +#define MBIGEN_NODE_ADDR_BASE(nid)     ((nid) * MBIGEN_NODE_OFFSET)
> +
> +/*
> + * struct mbigen_chip - holds the information of mbigen
> + * chip.
> + * @lock: spin lock protecting mbigen device list
> + * @domain: irq domain of this mbigen chip.
> + * @node: represents the mbigen chip node defined in device tree
> + * @mbigen_device_list: list of devices connected to this mbigen chip.
> + * @base: mapped address of this mbigen chip.
> + */
> +struct mbigen_chip {
> +       raw_spinlock_t          lock;
> +       struct list_head        entry;
> +       struct irq_domain       *domain;
> +       struct device_node      *node;
> +       struct list_head        mbigen_device_list;
> +       void __iomem            *base;
> +};
> +
> +/*
> + * struct mbigen_device--Holds the  information of devices connected
> + * to mbigen chip
> + * @lock: spin lock protecting mbigen node list
> + * @entry: node in mbigen chip's mbigen_device_list
> + * @chip: pointer to mbigen chip
> + * @mbigen_node_list: list of mbigen nodes.The interrupt lines
> +               of some devices maybe connected with several different
> +               mbigen nodes.
> + * @dev: device structure of this mbigen device.
> + * @node: represents the mbigen device node defined in device tree.
> + * @mgn_data: pointer to mbigen_irq_data
> + * @nr_irqs: the total interrupt lines of this device
> + * @did: device id
> +*/
> +struct mbigen_device {
> +       raw_spinlock_t          lock;
> +       struct list_head        entry;
> +       struct mbigen_chip      *chip;
> +       struct list_head        mbigen_node_list;
> +       struct device           dev;
> +       struct device_node      *node;
> +       struct mbigen_irq_data  *mgn_data;
> +       unsigned int            nr_irqs;
> +       unsigned int            did;

DevID should always be a u32.

> +};
> +
> +/*
> + * struct mbigen_node--structure of mbigen node.
> + * usually, a mbigen chip contains 8 ~ 11 mbigen nodes.
> + * Each mbigen nodes has its own register region.
> + * Devices connects to mbigen nodes directly.
> + *
> + * @entry: node in mbigen device's mbigen_node_list
> + * @node_num: mbigen node number.
> + * @pin_offset: the pin offset of first interrupt line
> + *             connected with this mbigen node.
> + * @irq_nr: the irq numbers of a device connected with mbigen node
> + * @msi_idx_offset: start of msi index of irq connected
> + *             to this mbigen node
> + */
> +struct mbigen_node {
> +       struct list_head        entry;
> +       unsigned int            node_num;
> +       unsigned int            pin_offset;
> +       unsigned int            irq_nr;
> +       unsigned int            index_offset;
> +};
> +
> +/*
> + * struct mbigen_irq_data -- private data of each irq
> + *
> + * @parent_irq: irq number of this
> + * @devid: id of devices this irq belong to
> + * @nid: id of mbigen node this irq connected.
> + * @pin_offset: pin offset of this irq.
> + * @index: msi index of this irq
> + * @base: address of mbigen chip this irq connected.
> + * @dev: mbigen device this irq belong to.
> + */
> +struct mbigen_irq_data {
> +       struct mbigen_device    *dev;
> +       void __iomem            *base;
> +       unsigned int            parent_irq;
> +       unsigned int            dev_id;
> +       unsigned int            nid;

Rather than dev_id and nid here, why don't you have a direct pointer to
the relevant structures? That would save some list parsing code...

> +       unsigned int            pin_offset;
> +       unsigned int            index;
> +};
> +
> +static LIST_HEAD(mbigen_chip_list);
> +static DEFINE_SPINLOCK(mbigen_chip_lock);
> +
> +static inline int get_mbigen_vec_reg_addr(u32 nid, u32 offset)
> +{
> +       return MBIGEN_NODE_ADDR_BASE(nid) + REG_MBIGEN_VEC_OFFSET
> +           + (offset * 4);
> +}
> +
> +static inline int get_mbigen_type_reg_addr(u32 nid, u32 offset)
> +{
> +       return MBIGEN_NODE_ADDR_BASE(nid) + REG_MBIGEN_TYPE_OFFSET + offset;
> +}
> +
> +static struct mbigen_device *mbigen_find_device(struct mbigen_chip *chip,
> +                                               u32 did)
> +{
> +       struct mbigen_device *dev = NULL, *tmp;
> +
> +       raw_spin_lock(&chip->lock);
> +       list_for_each_entry(tmp, &chip->mbigen_device_list, entry) {
> +               if (tmp->did == did) {
> +                       dev = tmp;
> +                       break;
> +               }
> +       }
> +       raw_spin_unlock(&chip->lock);
> +
> +       return dev;
> +}
> +
> +/* calc_irq_index() - calculate the msi index of this interrupt
> + *
> + * @dev: pointer to mbigen device.
> + * @nid: number of mbigen node this interrupt connected.
> + * @offset: interrupt pin offset.
> +*/
> +static u32 calc_irq_index(struct mbigen_device *dev, u32 nid, u32 offset)
> +{
> +       struct mbigen_node *mgn_node = NULL, *tmp;
> +       unsigned long flags;
> +       u32 index = 0;
> +
> +       raw_spin_lock_irqsave(&dev->lock, flags);
> +       list_for_each_entry(tmp, &dev->mbigen_node_list, entry) {
> +               if (tmp->node_num == nid)
> +                       mgn_node = tmp;
> +       }
> +       raw_spin_unlock_irqrestore(&dev->lock, flags);
> +
> +       if (mgn_node == NULL) {
> +               pr_err("No mbigen node found in device:%s\n",
> +                        dev->node->full_name);
> +               return -ENXIO;
> +       }
> +
> +       if ((offset <= (mgn_node->pin_offset + mgn_node->irq_nr))
> +           && (offset >= mgn_node->pin_offset))
> +               index = mgn_node->index_offset + (offset - mgn_node->pin_offset);
> +       else {
> +               pr_err("Err: no invalid index\n");
> +               index = -EINVAL;
> +       }
> +
> +       return index;
> +}
> +
> +static struct mbigen_irq_data *get_mbigen_irq_data(struct mbigen_chip *chip,
> +                                                  struct irq_data *d)
> +{
> +       struct mbigen_device *mgn_dev;
> +       struct mbigen_irq_data *mgn_irq_data;
> +       u32 nid, did, offset;
> +       u32 index;
> +
> +       did = GET_MBIGEN_DEVICE_ID(d->hwirq);
> +       offset = GET_IRQ_PIN_OFFSET(d->hwirq);
> +       nid = GET_MBIGEN_NODE_NUM(d->hwirq);
> +
> +       mgn_dev = mbigen_find_device(chip, did);
> +       if (!mgn_dev) {
> +               pr_err("no mbigen device found with did: 0x%x\n", did);
> +               return NULL;
> +       }
> +
> +       mgn_irq_data = mgn_dev->mgn_data;
> +
> +       index = calc_irq_index(mgn_dev, nid, offset);
> +       if (index < 0)
> +               return NULL;
> +
> +       if (offset != mgn_irq_data[index].pin_offset) {
> +               pr_err("No invalid mgn irq data found:offset:%d,nid:%d\n",
> +                       offset, mgn_irq_data[index].pin_offset);
> +               return NULL;
> +       }
> +
> +       return &mgn_irq_data[index];

Given the complication of this function, I'm thinking that my idea of
having one irqchip per node is the right one. You shouldn't have to
play that kind of game with the hwirq,

> +}
> +
> +static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +       struct mbigen_irq_data *mgn_irq_data = irq_get_handler_data(desc->irq);
> +       u32 val;
> +       int addr;
> +
> +       addr = get_mbigen_vec_reg_addr(mgn_irq_data->nid,
> +                                   mgn_irq_data->pin_offset);
> +
> +       val = readl_relaxed(addr + mgn_irq_data->base);
> +
> +       val &= ~(IRQ_EVENT_ID_MASK << IRQ_EVENT_ID_SHIFT);
> +       val |= (msg->data << IRQ_EVENT_ID_SHIFT);
> +       writel_relaxed(val, addr + mgn_irq_data->base);
> +}
> +
> +/*
> + * Interrupt controller operations
> + */
> +static int mbigen_set_type(struct irq_data *d, unsigned int type)
> +{
> +       struct mbigen_chip *chip = d->domain->host_data;
> +       u32 ofst, mask;
> +       u32 val, nid, pin_offset;
> +       int addr;
> +
> +       if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
> +               return -EINVAL;
> +
> +       nid = GET_MBIGEN_NODE_NUM(d->hwirq);
> +       pin_offset = GET_IRQ_PIN_OFFSET(d->hwirq);
> +
> +       ofst = pin_offset / 32 * 4;
> +       mask = 1 << (pin_offset % 32);
> +
> +       addr = get_mbigen_type_reg_addr(nid, ofst);
> +       val = readl_relaxed(addr + chip->base);
> +
> +       if (type == IRQ_TYPE_LEVEL_HIGH)
> +               val |= mask;
> +       else if (type == IRQ_TYPE_EDGE_RISING)
> +               val &= ~mask;
> +
> +       writel_relaxed(val, addr + chip->base);
> +
> +       return 0;
> +}
> +
> +static int mbigen_set_affinity(struct irq_data *data,
> +                               const struct cpumask *mask_val,
> +                               bool force)
> +{
> +       struct mbigen_irq_data *mgn_irq_data = irq_data_get_irq_chip_data(data);
> +       struct irq_chip *chip = irq_get_chip(mgn_irq_data->parent_irq);
> +       struct irq_data *parent_d = irq_get_irq_data(mgn_irq_data->parent_irq);
> +
> +       if (chip && chip->irq_set_affinity)
> +               return chip->irq_set_affinity(parent_d, mask_val, force);
> +       else
> +               return -EINVAL;


I feel a bit uneasy about this. It looks like a stacked domain, but it
really isn't. I don't have a better way of doing that so far though.

> +}
> +
> +static void mbigen_mask_irq(struct irq_data *data)
> +{
> +       struct mbigen_irq_data *mgn_irq_data = irq_data_get_irq_chip_data(data);
> +       struct irq_chip *chip = irq_get_chip(mgn_irq_data->parent_irq);
> +       struct irq_data *parent_d = irq_get_irq_data(mgn_irq_data->parent_irq);
> +
> +       if (chip && chip->irq_mask)
> +               return chip->irq_mask(parent_d);
> +}
> +
> +static void mbigen_unmask_irq(struct irq_data *data)
> +{
> +       struct mbigen_irq_data *mgn_irq_data = irq_data_get_irq_chip_data(data);
> +       struct irq_chip *chip = irq_get_chip(mgn_irq_data->parent_irq);
> +       struct irq_data *parent_d = irq_get_irq_data(mgn_irq_data->parent_irq);
> +
> +       if (chip && chip->irq_unmask)
> +               chip->irq_unmask(parent_d);
> +}
> +
> +static void mbigen_eoi_irq(struct irq_data *data)
> +{
> +
> +       struct mbigen_irq_data *mgn_irq_data = irq_data_get_irq_chip_data(data);
> +       struct irq_chip *chip = irq_get_chip(mgn_irq_data->parent_irq);
> +       struct irq_data *parent_d = irq_get_irq_data(mgn_irq_data->parent_irq);
> +       u32 pin_offset, ofst, mask;
> +
> +       pin_offset = GET_IRQ_PIN_OFFSET(data->hwirq);
> +       ofst = pin_offset / 32 * 4;
> +       mask = 1 << (pin_offset % 32);
> +
> +       writel_relaxed(mask, mgn_irq_data->base + ofst
> +                       + REG_MBIGEN_CLEAR_OFFSET);

What exactly is the effect of that write? Does it allow the resampling
of a level interrupt so that a LPI can be injected again if level is
still high?

> +
> +       if (chip && chip->irq_eoi)
> +               chip->irq_eoi(parent_d);
> +}
> +
> +static struct irq_chip mbigen_irq_chip = {
> +       .name = "MBIGEN-v2",
> +       .irq_mask = mbigen_mask_irq,
> +       .irq_unmask = mbigen_unmask_irq,
> +       .irq_eoi = mbigen_eoi_irq,
> +       .irq_set_affinity = mbigen_set_affinity,
> +       .irq_set_type = mbigen_set_type,
> +};
> +
> +static int mbigen_domain_xlate(struct irq_domain *d,
> +                              struct device_node *controller,
> +                              const u32 *intspec, unsigned int intsize,
> +                              unsigned long *out_hwirq,
> +                              unsigned int *out_type)
> +{
> +
> +       if (d->of_node != controller)
> +               return -EINVAL;
> +
> +       if (intsize < 4)
> +               return -EINVAL;
> +
> +       /* Compose the hwirq local to mbigen domain
> +        * intspec[0]: device id
> +        * intspec[1]: mbigen node number(nid) defined in dts file.
> +        * intspec[2]: interrut pin offset
> +        */
> +       *out_hwirq = COMPOSE_MBIGEN_HWIRQ(intspec[0], intspec[1], intspec[2]);
> +
> +       *out_type = intspec[3] & IRQ_TYPE_SENSE_MASK;
> +
> +       return 0;
> +}
> +
> +static int mbigen_domain_map(struct irq_domain *d, unsigned int irq,
> +                               irq_hw_number_t hw)
> +{
> +       struct mbigen_chip *mgn_chip = d->host_data;
> +       struct mbigen_irq_data *mgn_irq_data = NULL;
> +       struct irq_data *data = irq_get_irq_data(irq);
> +
> +       irq_set_chip_and_handler(irq, &mbigen_irq_chip, handle_fasteoi_irq);
> +
> +       mgn_irq_data = get_mbigen_irq_data(mgn_chip, data);
> +       if (!mgn_irq_data)
> +               return -EINVAL;
> +
> +       irq_set_chip_data(irq, mgn_irq_data);
> +
> +       set_irq_flags(irq, IRQF_VALID);
> +
> +       return 0;
> +}
> +
> +static struct irq_domain_ops mbigen_domain_ops = {
> +       .xlate = mbigen_domain_xlate,
> +       .map = mbigen_domain_map,
> +};
> +
> +static void mbigen_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)

No. This is a chained interrupt handler, not a standard interrupt
handler.

> +{
> +       struct mbigen_irq_data *mgn_irq_data = irq_get_handler_data(irq);
> +       struct mbigen_device *mgn_dev = mgn_irq_data->dev;
> +       struct irq_domain *domain = mgn_dev->chip->domain;
> +       unsigned int cascade_irq;
> +       u32 hwirq;
> +
> +       hwirq = COMPOSE_MBIGEN_HWIRQ(mgn_irq_data->dev_id,
> +                                       mgn_irq_data->nid,
> +                                       mgn_irq_data->pin_offset);
> +
> +       /* find cascade_irq within mbigen domain */
> +       cascade_irq = irq_find_mapping(domain, hwirq);
> +
> +       if (unlikely(!cascade_irq))
> +               handle_bad_irq(irq, desc);
> +       else
> +               generic_handle_irq(cascade_irq);

A consequence of the above is missing chained_irq_{enter,exit}.

> +}
> +
> +/*
> + * get_mbigen_node_info() - Get the mbigen node information
> + * and compose a new hwirq.
> + *
> + * @irq: irq number need to be handled
> + * @device_id: id of device which generates this interrupt
> + * @node_num: number of mbigen node this interrupt connected.
> + * @offset: interrupt pin offset in a mbigen node.
> + */
> +static int get_mbigen_node_info(u32 irq, struct mbigen_device *dev,
> +                                   struct mbigen_irq_data *mgn_irq_data)
> +{
> +       struct irq_data *irq_data = irq_get_irq_data(irq);
> +       struct mbigen_node *mgn_node;
> +       u32 irqs_range = 0, tmp;
> +       u32 msi_index;
> +
> +       mgn_irq_data->dev_id = dev->did;
> +       msi_index = irq_data->hwirq & 0xff;
> +
> +       raw_spin_lock(&dev->lock);
> +
> +       list_for_each_entry(mgn_node, &dev->mbigen_node_list, entry) {
> +               tmp = irqs_range;
> +               irqs_range += mgn_node->irq_nr;
> +
> +               if (msi_index < irqs_range) {
> +                       mgn_irq_data->nid = mgn_node->node_num;
> +                       mgn_irq_data->pin_offset =
> +                           mgn_node->pin_offset + (msi_index - tmp);
> +                       break;
> +               }
> +       }
> +       raw_spin_unlock(&dev->lock);
> +
> +       return 0;
> +}
> +
> +/*
> + * parse the information of mbigen node included in
> + * mbigen device node.
> + * @dev: the mbigen device pointer
> + *
> + * Some devices in hisilicon soc has more than 128
> + * interrupts and beyond a mbigen node can connect.
> + * So It need to be connect to several mbigen nodes.
> + */
> +static int parse_mbigen_node(struct mbigen_device *dev)
> +{
> +       struct mbigen_chip *chip = dev->chip;
> +       struct device_node *p = chip->node;
> +       const __be32 *intspec, *tmp;
> +       u32 intsize, intlen, index = 0;
> +       u32 node_num;
> +       int i;
> +
> +       intspec = of_get_property(dev->node, "mbigen_node", &intlen);
> +       if (intspec == NULL)
> +               return -EINVAL;
> +
> +       intlen /= sizeof(*intspec);
> +
> +       /* Get size of mbigen_node specifier */
> +       tmp = of_get_property(p, "#mbigen-node-cells", NULL);
> +       if (tmp == NULL)
> +               return -EINVAL;
> +
> +       intsize = be32_to_cpu(*tmp);

Use of_property_read_u32 instead.

> +       node_num = intlen / intsize;
> +
> +       for (i = 0; i < node_num; i++) {
> +               struct mbigen_node *mgn_node;
> +
> +               mgn_node = kzalloc(sizeof(*mgn_node), GFP_KERNEL);
> +               if (!mgn_node)
> +                       return -ENOMEM;

What happens to whatever has already been allocated when this failed?

> +
> +               mgn_node->node_num = be32_to_cpup(intspec++);
> +               mgn_node->irq_nr = be32_to_cpup(intspec++);
> +               mgn_node->pin_offset = be32_to_cpup(intspec++);
> +
> +               mgn_node->index_offset = index;
> +               index += mgn_node->irq_nr;
> +
> +               INIT_LIST_HEAD(&mgn_node->entry);
> +
> +               raw_spin_lock(&dev->lock);
> +               list_add_tail(&mgn_node->entry, &dev->mbigen_node_list);
> +               raw_spin_unlock(&dev->lock);
> +       }
> +
> +       return 0;
> +}
> +
> +static void mbigen_set_irq_handler_data(struct msi_desc *desc,
> +                                       struct mbigen_device *mgn_dev,
> +                                       struct mbigen_irq_data *mgn_irq_data)
> +{
> +       struct mbigen_chip *chip = mgn_dev->chip;
> +
> +       mgn_irq_data->base = chip->base;
> +       mgn_irq_data->index = desc->platform.msi_index;
> +
> +       get_mbigen_node_info(desc->irq, mgn_dev, mgn_irq_data);
> +
> +       mgn_irq_data->dev = mgn_dev;
> +       mgn_irq_data->parent_irq = desc->irq;
> +
> +       irq_set_handler_data(desc->irq, mgn_irq_data);
> +
> +}
> +/*
> + * mbigen_device_init()- initial the devices connected to
> + * mbigen chip.
> + *
> + * @chip: pointer to mbigen chip.
> + * @node: represents the node of devices which defined
> + *                     in device tree as a child node of mbigen chip
> + *                     node.
> + */
> +static int mbigen_device_init(struct mbigen_chip *chip,
> +                       struct device_node *node)
> +{
> +       struct mbigen_device *mgn_dev;
> +       struct device_node *msi_np;
> +       struct irq_domain *msi_domain;
> +       struct msi_desc *desc;
> +       struct mbigen_irq_data *mgn_irq_data;
> +       u32 nvec, dev_id;
> +       int ret;
> +
> +       of_property_read_u32(node, "nr-interrupts", &nvec);
> +       if (!nvec)
> +               return -EINVAL;
> +
> +       ret = of_property_read_u32_index(node, "msi-parent", 1, &dev_id);
> +       if (ret)
> +               return -EINVAL;
> +
> +       msi_np = of_parse_phandle(node, "msi-parent", 0);
> +       if (!msi_np) {
> +               pr_err("%s- no msi node found: %s\n", __func__,
> +                       node->full_name);
> +               return -ENXIO;
> +       }
> +
> +       msi_domain = irq_find_matching_host(msi_np, DOMAIN_BUS_PLATFORM_MSI);
> +       if (!msi_domain) {
> +               pr_err("MBIGEN: no platform-msi domain for %s\n",
> +                       msi_np->full_name);
> +               return -ENXIO;
> +       }

There shouldn't be any need for all this msi-parent handling if you
correctly created the platform-devices for the mbigen devices. I've
gone though quite some effort to make sure none of that was necessary,

> +
> +       mgn_dev = kzalloc(sizeof(*mgn_dev), GFP_KERNEL);
> +       if (!mgn_dev)
> +               return -ENOMEM;
> +
> +       mgn_dev->dev.msi_domain = msi_domain;
> +       mgn_dev->dev.of_node = node;
> +       mgn_dev->chip = chip;
> +       mgn_dev->nr_irqs = nvec;
> +       mgn_dev->node = node;
> +       mgn_dev->did = dev_id;
> +
> +       INIT_LIST_HEAD(dev_to_msi_list(&mgn_dev->dev));
> +
> +       ret = platform_msi_domain_alloc_irqs(&mgn_dev->dev,
> +                                            nvec, mbigen_write_msg);
> +       if (ret)
> +               goto out_free_dev;
> +
> +       INIT_LIST_HEAD(&mgn_dev->entry);
> +       raw_spin_lock_init(&mgn_dev->lock);
> +       INIT_LIST_HEAD(&mgn_dev->mbigen_node_list);
> +
> +       /* Parse and get the info of mbigen nodes this
> +        * device connected
> +        */
> +       parse_mbigen_node(mgn_dev);
> +
> +       mgn_irq_data = kcalloc(nvec, sizeof(*mgn_irq_data), GFP_KERNEL);
> +       if (!mgn_irq_data)
> +               return -ENOMEM;
> +
> +       mgn_dev->mgn_data = mgn_irq_data;
> +
> +       for_each_msi_entry(desc, &mgn_dev->dev) {
> +               mbigen_set_irq_handler_data(desc, mgn_dev,
> +                                           &mgn_irq_data[desc->platform.msi_index]);
> +               irq_set_chained_handler(desc->irq, mbigen_handle_cascade_irq);
> +       }
> +
> +       raw_spin_lock(&chip->lock);
> +       list_add(&mgn_dev->entry, &chip->mbigen_device_list);
> +       raw_spin_unlock(&chip->lock);
> +
> +       return 0;
> +
> +out_free_dev:
> +       kfree(mgn_dev);
> +       pr_err("failed to get MSIs for device:%s (%d)\n", node->full_name,
> +               ret);
> +       return ret;
> +}
> +
> +/*
> + * Early initialization as an interrupt controller
> + */
> +static int __init mbigen_of_init(struct device_node *node)
> +{
> +       struct mbigen_chip *mgn_chip;
> +       struct device_node *child;
> +       struct irq_domain *domain;
> +       void __iomem *base;
> +       int err;
> +
> +       base = of_iomap(node, 0);
> +       if (!base) {
> +               pr_err("%s: unable to map registers\n", node->full_name);
> +               return -ENOMEM;
> +       }
> +
> +       mgn_chip = kzalloc(sizeof(*mgn_chip), GFP_KERNEL);
> +       if (!mgn_chip) {
> +               err = -ENOMEM;
> +               goto unmap_reg;
> +       }
> +
> +       mgn_chip->base = base;
> +       mgn_chip->node = node;
> +
> +       domain = irq_domain_add_tree(node, &mbigen_domain_ops, mgn_chip);
> +       mgn_chip->domain = domain;
> +
> +       raw_spin_lock_init(&mgn_chip->lock);
> +       INIT_LIST_HEAD(&mgn_chip->entry);
> +       INIT_LIST_HEAD(&mgn_chip->mbigen_device_list);
> +
> +       for_each_child_of_node(node, child) {
> +               mbigen_device_init(mgn_chip, child);
> +       }
> +
> +       spin_lock(&mbigen_chip_lock);
> +       list_add(&mgn_chip->entry, &mbigen_chip_list);
> +       spin_unlock(&mbigen_chip_lock);
> +
> +       return 0;
> +
> +unmap_reg:
> +       iounmap(base);
> +       pr_err("MBIGEN: failed probing:%s (%d)\n", node->full_name, err);
> +       return err;
> +}
> +
> +static struct of_device_id mbigen_chip_id[] = {
> +       {       .compatible = "hisilicon,mbigen-v2",},
> +       {},
> +};
> +
> +static int __init mbigen_init(void)
> +{
> +       struct device_node *np;
> +
> +       for (np = of_find_matching_node(NULL, mbigen_chip_id); np;
> +            np = of_find_matching_node(np, mbigen_chip_id)) {
> +               mbigen_of_init(np);
> +       }
> +
> +       return 0;
> +}
> +
> +core_initcall(mbigen_init);

That's the wrong thing to do. The interrupt controller should be probed
with IRQCHIP_DECLARE(). Yes, this creates a dependency problem between
the MSI layer and the irqchip layer, but that should be easy (-ish) to
solve.

> +
> +MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
> +MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Hisilicon MBI Generator driver");
> --
> 1.7.1

I only have skimmed through the code to try and understand how it work,
and there is a number of structural issues. Still, it is amazingly
better than the previous three versions, but I expect some more changes.

Please restructure it as indicated, split the patch in reviewable
chunks, and we should be able to make it move forward.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
