From: klimov.linux@gmail.com (Alexey Klimov)
Date: Fri, 4 Sep 2015 03:56:17 +0300
Subject: [PATCH v4 1/2] Add the driver of mbigen interrupt controller
In-Reply-To: <55E50344.9090104@huawei.com>
References: <CALW4P+JABDw=dOtpC1MgEjXt7hN4Pm1f4NPDna9XYoE+yc=Grg@mail.gmail.com>
 <55E50344.9090104@huawei.com>
Message-ID: <CALW4P+KQEJsKCbnXeyup2Z2vNGY9jXKZKafQ+hSvc5_U5O+vtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ma Jun,

On Tue, Sep 1, 2015 at 4:45 AM, majun (F) <majun258@huawei.com> wrote:
> Hi Alexey:
>
> ? 2015/8/29 11:13, Alexey Klimov ??:

[..]

>>> +*/
>>> +static u32 calc_irq_index(struct mbigen_device *dev, u32 nid, u32 offset)
>>> +{
>>> +       struct mbigen_node *mgn_node = NULL, *tmp;
>>> +       unsigned long flags;
>>> +       u32 index = 0;
>>> +
>>> +       raw_spin_lock_irqsave(&dev->lock, flags);
>>> +       list_for_each_entry(tmp, &dev->mbigen_node_list, entry) {
>>> +               if (tmp->node_num == nid)
>>> +                       mgn_node = tmp;
>>> +       }
>>> +       raw_spin_unlock_irqrestore(&dev->lock, flags);
>>> +
>>> +       if (mgn_node == NULL) {
>>> +               pr_err("No mbigen node found in device:%s\n",
>>> +                        dev->node->full_name);
>>> +               return -ENXIO;
>>> +       }
>>> +
>>> +       if ((offset <= (mgn_node->pin_offset + mgn_node->irq_nr))
>>> +           && (offset >= mgn_node->pin_offset))
>>> +               index = mgn_node->index_offset + (offset - mgn_node->pin_offset);
>>> +       else {
>>> +               pr_err("Err: no invalid index\n");
>>
>> Please check this message.
>> 1. I don't know all details about this driver but is it really correct
>> "no invalid index"? Maybe you mean "no vaild index" or just "invalid
>> index"?
>> Just checking if i correctly understand this.
>>
> You are right.  This should be "no valid index"
>> 2. Imagine what info user/dmesg reader gets when she or he will see
>> such message? I suggest to add some info about driver that printed
>> this message.
>> You already have nice name in mbigen_irq_chip: "MBIGEN-v2". What do
>> you think about using it as prefix in your printk-based messages?
>> Please also consider revisiting other messages in this patch.
>>
> good suggestion.
>>
>>> +               index = -EINVAL;
>>> +       }
>>> +
>>> +       return index;
>>> +}
> [...]
>>> +       INIT_LIST_HEAD(dev_to_msi_list(&mgn_dev->dev));
>>> +
>>> +       ret = platform_msi_domain_alloc_irqs(&mgn_dev->dev,
>>> +                                            nvec, mbigen_write_msg);
>>> +       if (ret)
>>> +               goto out_free_dev;
>>> +
>>> +       INIT_LIST_HEAD(&mgn_dev->entry);
>>> +       raw_spin_lock_init(&mgn_dev->lock);
>>> +       INIT_LIST_HEAD(&mgn_dev->mbigen_node_list);
>>> +
>>> +       /* Parse and get the info of mbigen nodes this
>>> +        * device connected
>>> +        */
>>> +       parse_mbigen_node(mgn_dev);
>>> +
>>> +       mgn_irq_data = kcalloc(nvec, sizeof(*mgn_irq_data), GFP_KERNEL);
>>> +       if (!mgn_irq_data)
>>> +               return -ENOMEM;
>>
>> Hm. Do you need error path here instead of simple return -ENOMEM?
>> Maybe 'goto out_free_dev' will work for you.
> Right. Memory leak happened.
>>
>>> +       mgn_dev->mgn_data = mgn_irq_data;
>>> +
>>> +       for_each_msi_entry(desc, &mgn_dev->dev) {
>>> +               mbigen_set_irq_handler_data(desc, mgn_dev,
>>> +                                           &mgn_irq_data[desc->platform.msi_index]);
>>> +               irq_set_chained_handler(desc->irq, mbigen_handle_cascade_irq);
>>> +       }
>>> +
>>> +       raw_spin_lock(&chip->lock);
>>> +       list_add(&mgn_dev->entry, &chip->mbigen_device_list);
>>> +       raw_spin_unlock(&chip->lock);
>>> +
>>> +       return 0;
>>> +
>>> +out_free_dev:
>>> +       kfree(mgn_dev);
>>> +       pr_err("failed to get MSIs for device:%s (%d)\n", node->full_name,
>>> +               ret);
>>> +       return ret;
>>> +}
>>> +
>>> +/*
>>> + * Early initialization as an interrupt controller
>>> + */
>>> +static int __init mbigen_of_init(struct device_node *node)
>>> +{
>>> +       struct mbigen_chip *mgn_chip;
>>> +       struct device_node *child;
>>> +       struct irq_domain *domain;
>>> +       void __iomem *base;
>>> +       int err;
>>> +
>>> +       base = of_iomap(node, 0);
>>> +       if (!base) {
>>> +               pr_err("%s: unable to map registers\n", node->full_name);
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>> +       mgn_chip = kzalloc(sizeof(*mgn_chip), GFP_KERNEL);
>>> +       if (!mgn_chip) {
>>> +               err = -ENOMEM;
>>> +               goto unmap_reg;
>>> +       }
>>> +
>>> +       mgn_chip->base = base;
>>> +       mgn_chip->node = node;
>>> +
>>> +       domain = irq_domain_add_tree(node, &mbigen_domain_ops, mgn_chip);
>>> +       mgn_chip->domain = domain;
>>> +
>>> +       raw_spin_lock_init(&mgn_chip->lock);
>>> +       INIT_LIST_HEAD(&mgn_chip->entry);
>>> +       INIT_LIST_HEAD(&mgn_chip->mbigen_device_list);
>>> +
>>> +       for_each_child_of_node(node, child) {
>>> +               mbigen_device_init(mgn_chip, child);
>>
>> You don't check error from mbigen_device_init()
> I don't think we need to check errors here.
> mbigen_device_init() handle all errors.

For my eyes, mbigen_device_init() is static and used only once here.
Here you don't check return value from it. If this is correct you can
convert mbigen_device_init() to return void unless you have future
plans to modify it.

Or you have option to check return value here and add error path.

Please add me to cc to next version of patch set which I guess will be v5.

-- 
Thanks and best regards, Klimov Alexey
