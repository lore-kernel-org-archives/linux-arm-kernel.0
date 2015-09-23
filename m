From: majun258@huawei.com (majun (F))
Date: Wed, 23 Sep 2015 15:24:50 +0800
Subject: [PATCH v4 1/2] Add the driver of mbigen interrupt controller
In-Reply-To: <20150921225324.5568f673@arm.com>
References: <1439952920-2296-1-git-send-email-majun258@huawei.com>
 <1439952920-2296-2-git-send-email-majun258@huawei.com>
 <20150921225324.5568f673@arm.com>
Message-ID: <560253C2.60609@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc:
	Thanks for reviewing this huge patch.

? 2015/9/22 5:53, Marc Zyngier ??:
> On Wed, 19 Aug 2015 03:55:19 +0100
> MaJun <majun258@huawei.com> wrote:
> 
>> From: Ma Jun <majun258@huawei.com>
>>
[...]
>> + * hwirq[32:12]: did. device id
>> + * hwirq[11:8]: nid. mbigen node number
>> + * hwirq[7:0]: pin. hardware pin offset of this interrupt
>> + */
>> +#define        COMPOSE_MBIGEN_HWIRQ(did, nid, pin)     \
>> +               (((did) << MBIGEN_DEV_SHIFT) | \
>> +               ((nid) << MBIGEN_NODE_SHIFT) | (pin))
> 
> The fact that you have to create a "virtual" hwirq number is an
> indication that you are doing something wrong. It seems to me that it
> would be much simpler if you had one domain per mode, with the pin
> being the actual hwirq (as you would expect it), you'd have a much
> simpler design overall.
> 

I will remove the mbigen node to make hardware structure simpler as below.
After changing, I can have one domain per mbigen chip.

                 mbigen chip
  --------------------------------------
  |              |           |        |
 dev1          dev2         dev3   dev4


> Do not try to have a global hwirq space unless you really need it. So
> far, I haven't seen anything here that mandate such a complex solution.
> 
>> +
>> +/* get the interrupt pin offset from mbigen hwirq */
[...]
>> +
>> +static void mbigen_eoi_irq(struct irq_data *data)
>> +{
>> +
>> +       struct mbigen_irq_data *mgn_irq_data = irq_data_get_irq_chip_data(data);
>> +       struct irq_chip *chip = irq_get_chip(mgn_irq_data->parent_irq);
>> +       struct irq_data *parent_d = irq_get_irq_data(mgn_irq_data->parent_irq);
>> +       u32 pin_offset, ofst, mask;
>> +
>> +       pin_offset = GET_IRQ_PIN_OFFSET(data->hwirq);
>> +       ofst = pin_offset / 32 * 4;
>> +       mask = 1 << (pin_offset % 32);
>> +
>> +       writel_relaxed(mask, mgn_irq_data->base + ofst
>> +                       + REG_MBIGEN_CLEAR_OFFSET);
> 
> What exactly is the effect of that write? Does it allow the resampling
> of a level interrupt so that a LPI can be injected again if level is
> still high?

Yes.
So we cleared irq status at here.

> 
>> +
>> +       if (chip && chip->irq_eoi)
>> +               chip->irq_eoi(parent_d);
>> +}
>> +
[...]
>> +
>> +static struct irq_domain_ops mbigen_domain_ops = {
>> +       .xlate = mbigen_domain_xlate,
>> +       .map = mbigen_domain_map,
>> +};
>> +
>> +static void mbigen_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
> 
> No. This is a chained interrupt handler, not a standard interrupt
> handler.
>> +{
>> +       struct mbigen_irq_data *mgn_irq_data = irq_get_handler_data(irq);
>> +       struct mbigen_device *mgn_dev = mgn_irq_data->dev;
>> +       struct irq_domain *domain = mgn_dev->chip->domain;
>> +       unsigned int cascade_irq;
>> +       u32 hwirq;
>> +
>> +       hwirq = COMPOSE_MBIGEN_HWIRQ(mgn_irq_data->dev_id,
>> +                                       mgn_irq_data->nid,
>> +                                       mgn_irq_data->pin_offset);
>> +
>> +       /* find cascade_irq within mbigen domain */
>> +       cascade_irq = irq_find_mapping(domain, hwirq);
>> +
>> +       if (unlikely(!cascade_irq))
>> +               handle_bad_irq(irq, desc);
>> +       else
>> +               generic_handle_irq(cascade_irq);
> 
> A consequence of the above is missing chained_irq_{enter,exit}.
> 
>> +}
>> +
>> +/*
>> + * get_mbigen_node_info() - Get the mbigen node information
>> + * and compose a new hwirq.
>> + *
>> + * @irq: irq number need to be handled
>> + * @device_id: id of device which generates this interrupt
>> + * @node_num: number of mbigen node this interrupt connected.
>> + * @offset: interrupt pin offset in a mbigen node.
>> + */
>> +static int get_mbigen_node_info(u32 irq, struct mbigen_device *dev,
>> +                                   struct mbigen_irq_data *mgn_irq_data)
>> +{
>> +       struct irq_data *irq_data = irq_get_irq_data(irq);
>> +       struct mbigen_node *mgn_node;
>> +       u32 irqs_range = 0, tmp;
>> +       u32 msi_index;
>> +
>> +       mgn_irq_data->dev_id = dev->did;
>> +       msi_index = irq_data->hwirq & 0xff;
>> +
>> +       raw_spin_lock(&dev->lock);
>> +
>> +       list_for_each_entry(mgn_node, &dev->mbigen_node_list, entry) {
>> +               tmp = irqs_range;
>> +               irqs_range += mgn_node->irq_nr;
>> +
>> +               if (msi_index < irqs_range) {
>> +                       mgn_irq_data->nid = mgn_node->node_num;
>> +                       mgn_irq_data->pin_offset =
>> +                           mgn_node->pin_offset + (msi_index - tmp);
>> +                       break;
>> +               }
>> +       }
>> +       raw_spin_unlock(&dev->lock);
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * parse the information of mbigen node included in
>> + * mbigen device node.
>> + * @dev: the mbigen device pointer
>> + *
>> + * Some devices in hisilicon soc has more than 128
>> + * interrupts and beyond a mbigen node can connect.
>> + * So It need to be connect to several mbigen nodes.
>> + */
>> +static int parse_mbigen_node(struct mbigen_device *dev)
>> +{
>> +       struct mbigen_chip *chip = dev->chip;
>> +       struct device_node *p = chip->node;
>> +       const __be32 *intspec, *tmp;
>> +       u32 intsize, intlen, index = 0;
>> +       u32 node_num;
>> +       int i;
>> +
>> +       intspec = of_get_property(dev->node, "mbigen_node", &intlen);
>> +       if (intspec == NULL)
>> +               return -EINVAL;
>> +
>> +       intlen /= sizeof(*intspec);
>> +
>> +       /* Get size of mbigen_node specifier */
>> +       tmp = of_get_property(p, "#mbigen-node-cells", NULL);
>> +       if (tmp == NULL)
>> +               return -EINVAL;
>> +
>> +       intsize = be32_to_cpu(*tmp);
> 
> Use of_property_read_u32 instead.
> 
>> +       node_num = intlen / intsize;
>> +
>> +       for (i = 0; i < node_num; i++) {
>> +               struct mbigen_node *mgn_node;
>> +
>> +               mgn_node = kzalloc(sizeof(*mgn_node), GFP_KERNEL);
>> +               if (!mgn_node)
>> +                       return -ENOMEM;
> 
> What happens to whatever has already been allocated when this failed?

Memory leak problem.I will fix this.

> 
>> +
>> +               mgn_node->node_num = be32_to_cpup(intspec++);
>> +               mgn_node->irq_nr = be32_to_cpup(intspec++);
>> +               mgn_node->pin_offset = be32_to_cpup(intspec++);
>> +
>> +               mgn_node->index_offset = index;
>> +               index += mgn_node->irq_nr;
>> +
>> +               INIT_LIST_HEAD(&mgn_node->entry);
>> +
>> +               raw_spin_lock(&dev->lock);
>> +               list_add_tail(&mgn_node->entry, &dev->mbigen_node_list);
>> +               raw_spin_unlock(&dev->lock);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void mbigen_set_irq_handler_data(struct msi_desc *desc,
>> +                                       struct mbigen_device *mgn_dev,
>> +                                       struct mbigen_irq_data *mgn_irq_data)
>> +{
>> +       struct mbigen_chip *chip = mgn_dev->chip;
>> +
>> +       mgn_irq_data->base = chip->base;
>> +       mgn_irq_data->index = desc->platform.msi_index;
>> +
>> +       get_mbigen_node_info(desc->irq, mgn_dev, mgn_irq_data);
>> +
>> +       mgn_irq_data->dev = mgn_dev;
>> +       mgn_irq_data->parent_irq = desc->irq;
>> +
>> +       irq_set_handler_data(desc->irq, mgn_irq_data);
>> +
>> +}
>> +/*
>> + * mbigen_device_init()- initial the devices connected to
>> + * mbigen chip.
>> + *
>> + * @chip: pointer to mbigen chip.
>> + * @node: represents the node of devices which defined
>> + *                     in device tree as a child node of mbigen chip
>> + *                     node.
>> + */
>> +static int mbigen_device_init(struct mbigen_chip *chip,
>> +                       struct device_node *node)
>> +{
>> +       struct mbigen_device *mgn_dev;
>> +       struct device_node *msi_np;
>> +       struct irq_domain *msi_domain;
>> +       struct msi_desc *desc;
>> +       struct mbigen_irq_data *mgn_irq_data;
>> +       u32 nvec, dev_id;
>> +       int ret;
>> +
>> +       of_property_read_u32(node, "nr-interrupts", &nvec);
>> +       if (!nvec)
>> +               return -EINVAL;
>> +
>> +       ret = of_property_read_u32_index(node, "msi-parent", 1, &dev_id);
>> +       if (ret)
>> +               return -EINVAL;
>> +
>> +       msi_np = of_parse_phandle(node, "msi-parent", 0);
>> +       if (!msi_np) {
>> +               pr_err("%s- no msi node found: %s\n", __func__,
>> +                       node->full_name);
>> +               return -ENXIO;
>> +       }
>> +
>> +       msi_domain = irq_find_matching_host(msi_np, DOMAIN_BUS_PLATFORM_MSI);
>> +       if (!msi_domain) {
>> +               pr_err("MBIGEN: no platform-msi domain for %s\n",
>> +                       msi_np->full_name);
>> +               return -ENXIO;
>> +       }
> 
> There shouldn't be any need for all this msi-parent handling if you
> correctly created the platform-devices for the mbigen devices. I've
> gone though quite some effort to make sure none of that was necessary,

Do you mean I should use the of_msi_configure() function at here,
or
msi-parent should be handled during initial when this function be called
in function of_platform_device_create_pdata() ?

> 
>> +
>> +       mgn_dev = kzalloc(sizeof(*mgn_dev), GFP_KERNEL);
>> +       if (!mgn_dev)
>> +               return -ENOMEM;
>> +
>> +       mgn_dev->dev.msi_domain = msi_domain;
>> +       mgn_dev->dev.of_node = node;
>> +       mgn_dev->chip = chip;
>> +       mgn_dev->nr_irqs = nvec;
>> +       mgn_dev->node = node;
>> +       mgn_dev->did = dev_id;
>> +
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
>> +
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
> 
> That's the wrong thing to do. The interrupt controller should be probed
> with IRQCHIP_DECLARE(). Yes, this creates a dependency problem between
> the MSI layer and the irqchip layer, but that should be easy (-ish) to
> solve.

Based on our discusstion about DTS,I will change the code likes below:
IRQCHIP_DECLARE(hisi_mbigen, "hisilicon,mbigen-v2", mbigen_of_init);

Mbigen device is initialized as a interrupt controller.

But I still can't call platform_msi_domain_alloc_irqs()
to apply the msi irqs.

It think this is what you said "dependency problem between
 the MSI layer and the irqchip layer" , am i right ?

Do you have any idea about this problem?

Thanks!
Ma Jun
