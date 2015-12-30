From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 30 Dec 2015 10:28:30 -0500
Subject: [PATCH V10 7/7] dma: qcom_hidma: add support for object hierarchy
In-Reply-To: <CAHp75Vd-ku1E4+BWGwtL06mO7EZHFmwCvwFiAhLUVwrJHNKD7w@mail.gmail.com>
References: <1450371684-23415-1-git-send-email-okaya@codeaurora.org>
 <1450371684-23415-8-git-send-email-okaya@codeaurora.org>
 <CAHp75Vd-ku1E4+BWGwtL06mO7EZHFmwCvwFiAhLUVwrJHNKD7w@mail.gmail.com>
Message-ID: <5683F81E.5050406@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2015 1:37 PM, Andy Shevchenko wrote:
> On Thu, Dec 17, 2015 at 7:01 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> In order to create a relationship model between the channels and the
>> management object, we are adding support for object hierarchy to the
>> drivers. This patch simplifies the userspace application development.
>> We will not have to traverse different firmware paths based on device
>> tree or ACPI baed kernels.
>>
>> No matter what flavor of kernel is used, objects will be represented as
>> platform devices.
>>
>> The new layout is as follows:
>>
>> hidmam_10: hidma-mgmt at 0x5A000000 {
>>         compatible = "qcom,hidma-mgmt-1.0";
>>         ...
>>
>>         hidma_10: hidma at 0x5a010000 {
>>                         compatible = "qcom,hidma-1.0";
>>                         ...
>>         }
>> }
>>
>> The hidma_mgmt_init detects each instance of the hidma-mgmt-1.0 objects
>> in device tree and calls into the channel driver to create platform devices
>> for each child of the management object.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> 
>> +What:          /sys/devices/platform/hidma-*/chid
>> +               /sys/devices/platform/QCOM8061:*/chid
>> +Date:          Dec 2015
>> +KernelVersion: 4.4
>> +Contact:       "Sinan Kaya <okaya@cudeaurora.org>"
>> +Description:
>> +               Contains the ID of the channel within the HIDMA instance.
>> +               It is used to associate a given HIDMA channel with the
>> +               priority and weight calls in the management interface.
> 
>> -module_platform_driver(hidma_mgmt_driver);
>> +#ifdef CONFIG_OF
>> +static int object_counter;
>> +
>> +static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
>> +{
>> +       struct platform_device *pdev_parent = of_find_device_by_node(np);
>> +       struct platform_device_info pdevinfo;
>> +       struct of_phandle_args out_irq;
>> +       struct device_node *child;
>> +       struct resource *res;
>> +       const __be32 *cell;
> 
> Always BE ?

Yes, as Timur indicated device tree is big endian all the time.
> 
>> +       int ret = 0, size, i, num;
>> +       u64 addr, addr_size;
> 
> resource_size_t

These values are read from the device tree blob using of_read_number function. of_read_number
returns a u64.
> 
>> +
>> +       for_each_available_child_of_node(np, child) {
>> +               int iter = 0;
>> +
>> +               cell = of_get_property(child, "reg", &size);
>> +               if (!cell) {
>> +                       ret = -EINVAL;
>> +                       goto out;
>> +               }
>> +
>> +               size /= (sizeof(*cell));
> 
> Redundant parens. I think it might be good to use common sense for
> operator precedence, here is a radical example of ignoring it. And
> this is not the first case.

Removed. Note that I copied most of this function from another driver. 

> 
>> +               num = size /
>> +                       (of_n_addr_cells(child) + of_n_size_cells(child)) + 1;
>> +
>> +               /* allocate a resource array */
>> +               res = kcalloc(num, sizeof(*res), GFP_KERNEL);
>> +               if (!res) {
>> +                       ret = -ENOMEM;
>> +                       goto out;
>> +               }
>> +
>> +               /* read each reg value */
>> +               i = 0;
>> +               while (i < size) {
>> +                       addr = of_read_number(&cell[i],
>> +                                             of_n_addr_cells(child));
>> +                       i += of_n_addr_cells(child);
>> +
>> +                       addr_size = of_read_number(&cell[i],
>> +                                                  of_n_size_cells(child));
>> +                       i += of_n_size_cells(child);
>> +
>> +                       res[iter].start = addr;
>> +                       res[iter].end = res[iter].start + addr_size - 1;
>> +                       res[iter].flags = IORESOURCE_MEM;
> 
> res->start = ?
> ?
> res++;

ok

> 
>> +                       iter++;
>> +               }
>> +
>> +               ret = of_irq_parse_one(child, 0, &out_irq);
>> +               if (ret)
>> +                       goto out;
>> +
>> +               res[iter].start = irq_create_of_mapping(&out_irq);
>> +               res[iter].name = "hidma event irq";
>> +               res[iter].flags = IORESOURCE_IRQ;
> 
> Ditto.
ok

> 
>> +
>> +               pdevinfo.fwnode = &child->fwnode;
>> +               pdevinfo.parent = pdev_parent ? &pdev_parent->dev : NULL;
>> +               pdevinfo.name = child->name;
>> +               pdevinfo.id = object_counter++;
>> +               pdevinfo.res = res;
>> +               pdevinfo.num_res = num;
>> +               pdevinfo.data = NULL;
>> +               pdevinfo.size_data = 0;
>> +               pdevinfo.dma_mask = DMA_BIT_MASK(64);
>> +               platform_device_register_full(&pdevinfo);
>> +
>> +               kfree(res);
>> +               res = NULL;
>> +       }
>> +out:
> 
>> +       kfree(res);
> 
> 
>> +
>> +       return ret;
>> +}
>> +#endif
>> +
>> +static int __init hidma_mgmt_init(void)
>> +{
>> +#ifdef CONFIG_OF
>> +       struct device_node *child;
>> +
>> +       for (child = of_find_matching_node(NULL, hidma_mgmt_match); child;
>> +            child = of_find_matching_node(child, hidma_mgmt_match)) {
>> +               /* device tree based firmware here */
>> +               hidma_mgmt_of_populate_channels(child);
>> +               of_node_put(child);
>> +       }
> 
> And why this is can't be done in probe of parent node driver?

The populate function creates platform objects using platform_device_register_full function above. 
The hidma device driver later probes the object during object enumeration phase. 

I tried moving platform_device_register_full into the probe context. The objects got generated but hidma 
device driver didn't probe the object. I suppose we are required to create the objects before the probing starts.

I copied this pattern from another driver.

> 
>> +#endif
>> +       platform_driver_register(&hidma_mgmt_driver);
>> +
>> +       return 0;
>> +}
>> +module_init(hidma_mgmt_init);
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
