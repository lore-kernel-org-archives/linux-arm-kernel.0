From: majun258@huawei.com (majun (F))
Date: Tue, 1 Sep 2015 09:45:40 +0800
Subject: [PATCH v4 1/2] Add the driver of mbigen interrupt controller
In-Reply-To: <CALW4P+JABDw=dOtpC1MgEjXt7hN4Pm1f4NPDna9XYoE+yc=Grg@mail.gmail.com>
References: <CALW4P+JABDw=dOtpC1MgEjXt7hN4Pm1f4NPDna9XYoE+yc=Grg@mail.gmail.com>
Message-ID: <55E50344.9090104@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexey:

? 2015/8/29 11:13, Alexey Klimov ??:
> Hi Ma Jun,
> 
> On Wed, Aug 19, 2015 at 5:55 AM, MaJun <majun258@huawei.com> wrote:
>> From: Ma Jun <majun258@huawei.com>
>>
>> Mbigen means Message Based Interrupt Generator(MBIGEN).
>>
>> Its a kind of interrupt controller that collects
>>
>> the interrupts from external devices and generate msi interrupt.
>>


>> +
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/slab.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irqchip/chained_irq.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/msi.h>
> 
> What do you think about sorting this?
ok
> 
> 
>> +#include "irqchip.h"
>> +
[...]
>> +*/
>> +static u32 calc_irq_index(struct mbigen_device *dev, u32 nid, u32 offset)
>> +{
>> +       struct mbigen_node *mgn_node = NULL, *tmp;
>> +       unsigned long flags;
>> +       u32 index = 0;
>> +
>> +       raw_spin_lock_irqsave(&dev->lock, flags);
>> +       list_for_each_entry(tmp, &dev->mbigen_node_list, entry) {
>> +               if (tmp->node_num == nid)
>> +                       mgn_node = tmp;
>> +       }
>> +       raw_spin_unlock_irqrestore(&dev->lock, flags);
>> +
>> +       if (mgn_node == NULL) {
>> +               pr_err("No mbigen node found in device:%s\n",
>> +                        dev->node->full_name);
>> +               return -ENXIO;
>> +       }
>> +
>> +       if ((offset <= (mgn_node->pin_offset + mgn_node->irq_nr))
>> +           && (offset >= mgn_node->pin_offset))
>> +               index = mgn_node->index_offset + (offset - mgn_node->pin_offset);
>> +       else {
>> +               pr_err("Err: no invalid index\n");
> 
> Please check this message.
> 1. I don't know all details about this driver but is it really correct
> "no invalid index"? Maybe you mean "no vaild index" or just "invalid
> index"?
> Just checking if i correctly understand this.
> 
You are right.  This should be "no valid index"
> 2. Imagine what info user/dmesg reader gets when she or he will see
> such message? I suggest to add some info about driver that printed
> this message.
> You already have nice name in mbigen_irq_chip: "MBIGEN-v2". What do
> you think about using it as prefix in your printk-based messages?
> Please also consider revisiting other messages in this patch.
> 
good suggestion.
> 
>> +               index = -EINVAL;
>> +       }
>> +
>> +       return index;
>> +}
[...]
>> +       INIT_LIST_HEAD(dev_to_msi_list(&mgn_dev->dev));
>> +
>> +       ret = platform_msi_domain_alloc_irqs(&mgn_dev->dev,
>> +                                            nvec, mbigen_write_msg);
>> +       if (ret)
>> +               goto out_free_dev;
>> +
>> +       INIT_LIST_HEAD(&mgn_dev->entry);
>> +       raw_spin_lock_init(&mgn_dev->lock);
>> +       INIT_LIST_HEAD(&mgn_dev->mbigen_node_list);
>> +
>> +       /* Parse and get the info of mbigen nodes this
>> +        * device connected
>> +        */
>> +       parse_mbigen_node(mgn_dev);
>> +
>> +       mgn_irq_data = kcalloc(nvec, sizeof(*mgn_irq_data), GFP_KERNEL);
>> +       if (!mgn_irq_data)
>> +               return -ENOMEM;
> 
> Hm. Do you need error path here instead of simple return -ENOMEM?
> Maybe 'goto out_free_dev' will work for you.
Right. Memory leak happened.
> 
>> +       mgn_dev->mgn_data = mgn_irq_data;
>> +
>> +       for_each_msi_entry(desc, &mgn_dev->dev) {
>> +               mbigen_set_irq_handler_data(desc, mgn_dev,
>> +                                           &mgn_irq_data[desc->platform.msi_index]);
>> +               irq_set_chained_handler(desc->irq, mbigen_handle_cascade_irq);
>> +       }
>> +
>> +       raw_spin_lock(&chip->lock);
>> +       list_add(&mgn_dev->entry, &chip->mbigen_device_list);
>> +       raw_spin_unlock(&chip->lock);
>> +
>> +       return 0;
>> +
>> +out_free_dev:
>> +       kfree(mgn_dev);
>> +       pr_err("failed to get MSIs for device:%s (%d)\n", node->full_name,
>> +               ret);
>> +       return ret;
>> +}
>> +
>> +/*
>> + * Early initialization as an interrupt controller
>> + */
>> +static int __init mbigen_of_init(struct device_node *node)
>> +{
>> +       struct mbigen_chip *mgn_chip;
>> +       struct device_node *child;
>> +       struct irq_domain *domain;
>> +       void __iomem *base;
>> +       int err;
>> +
>> +       base = of_iomap(node, 0);
>> +       if (!base) {
>> +               pr_err("%s: unable to map registers\n", node->full_name);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       mgn_chip = kzalloc(sizeof(*mgn_chip), GFP_KERNEL);
>> +       if (!mgn_chip) {
>> +               err = -ENOMEM;
>> +               goto unmap_reg;
>> +       }
>> +
>> +       mgn_chip->base = base;
>> +       mgn_chip->node = node;
>> +
>> +       domain = irq_domain_add_tree(node, &mbigen_domain_ops, mgn_chip);
>> +       mgn_chip->domain = domain;
>> +
>> +       raw_spin_lock_init(&mgn_chip->lock);
>> +       INIT_LIST_HEAD(&mgn_chip->entry);
>> +       INIT_LIST_HEAD(&mgn_chip->mbigen_device_list);
>> +
>> +       for_each_child_of_node(node, child) {
>> +               mbigen_device_init(mgn_chip, child);
> 
> You don't check error from mbigen_device_init()
I don't think we need to check errors here.
mbigen_device_init() handle all errors.

Thanks
Ma Jun

> 
>> +       }
>> +
>> +       spin_lock(&mbigen_chip_lock);
>> +       list_add(&mgn_chip->entry, &mbigen_chip_list);
>> +       spin_unlock(&mbigen_chip_lock);
>> +
>> +       return 0;
>> +
>> +unmap_reg:
>> +       iounmap(base);
>> +       pr_err("MBIGEN: failed probing:%s (%d)\n", node->full_name, err);
>> +       return err;
>> +}
>> +
>> +static struct of_device_id mbigen_chip_id[] = {
>> +       {       .compatible = "hisilicon,mbigen-v2",},
>> +       {},
>> +};
>> +
>> +static int __init mbigen_init(void)
>> +{
>> +       struct device_node *np;
>> +
>> +       for (np = of_find_matching_node(NULL, mbigen_chip_id); np;
>> +            np = of_find_matching_node(np, mbigen_chip_id)) {
>> +               mbigen_of_init(np);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +core_initcall(mbigen_init);
>> +
>> +MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
>> +MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Hisilicon MBI Generator driver");
>> --
>> 1.7.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
