From: nishanth.p@gmail.com (Nishanth Peethambaran)
Date: Fri, 15 Feb 2013 21:42:12 +0530
Subject: [Linaro-mm-sig] [PATCH 2/2] drivers: dma-contiguous: add
 initialization from device tree
In-Reply-To: <511D586A.5060902@codeaurora.org>
References: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
 <1360845928-8107-3-git-send-email-m.szyprowski@samsung.com>
 <511D586A.5060902@codeaurora.org>
Message-ID: <CAMcxFTRq4-npcFw9UqfWa98hZaVocj43Tnzkh7aagqB6KW-uOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 3:04 AM, Laura Abbott <lauraa@codeaurora.org> wrote:
> Hi,
>
>
> On 2/14/2013 4:45 AM, Marek Szyprowski wrote:
> <snip>
>
>> +name:          an name given to the defined region.
>> +base-address:  the base address of the defined region.
>> +size:          the size of the memory region.
>> +linux,contiguous-region: property indicating that the defined memory
>> +               region is used for contiguous memory allocations,
>> +               Linux specific (optional)
>> +linux,default-contiguous-region: property indicating that the region
>> +               is the default region for all contiguous memory
>> +               allocations, Linux specific (optional)
>> +
>> +
>
>
> I don't see any code actually implementing the default-contiguous-region
> binding. Currently on ARM systems we will still setup the default region
> based on the Kconfig. Is this intentional?
>
>
>
>> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
>> index 085389c..5761f73 100644
>> --- a/drivers/base/dma-contiguous.c
>> +++ b/drivers/base/dma-contiguous.c
>> @@ -24,6 +24,9 @@
>>
>>   #include <linux/memblock.h>
>>   #include <linux/err.h>
>> +#include <linux/of.h>
>> +#include <linux/of_fdt.h>
>> +#include <linux/of_platform.h>
>>   #include <linux/mm.h>
>>   #include <linux/mutex.h>
>>   #include <linux/page-isolation.h>
>> @@ -177,6 +180,35 @@ no_mem:
>>         return ERR_PTR(ret);
>>   }
>>
>>
>> +/*****************************************************************************/
>> +
>> +#ifdef CONFIG_OF
>> +int __init cma_fdt_scan(unsigned long node, const char *uname,
>> +                               int depth, void *data)
>> +{
>> +       phys_addr_t base, size;
>> +       unsigned long len;
>> +       __be32 *prop;
>> +
>> +       if (strncmp(uname, "region@", 7) != 0 || depth != 2 ||
>> +           !of_get_flat_dt_prop(node, "contiguous-region", NULL))
>
>
> The documentation says "linux,contiguous-region"
>
>
>
>> +#ifdef CONFIG_OF
>> +static void cma_assign_device_from_dt(struct device *dev)
>> +{
>> +       struct device_node *node;
>> +       struct cma *cma;
>> +       u32 value;
>> +
>> +       node = of_parse_phandle(dev->of_node, "linux,contiguous-region",
>> 0);
>> +       if (!node)
>> +               return;
>> +       if (of_property_read_u32(node, "reg", &value) && !value)
>> +               return;
>> +       cma = cma_get_area(value);
>> +       if (!cma)
>> +               return;
>> +
>> +       dev_set_cma_area(dev, cma);
>> +       pr_info("Assigned CMA region at %lx to %s device\n", (unsigned
>> long)value, dev_name(dev));
>> +}
>> +
>
>
> This scheme of associating devices with CMA regions by base does not work if
> you want to let CMA figure out where to place the region (base = 0). Can we
> use the name to associate the device with the region? I had been working on
> something similar internally and that was the only solution I had come up
> with to associate arbitrary CMA nodes with devices.
>

The phandle for the region can also be used as a unique identifier.
cma_fdt_scan() can get the property(own phandle) and pass as an extra
parameter to dma_contiguous_reserve_area().
This could be stored as part of cma_area (extra field).
The devices get the cma area by passing the phandle to cma_get_area()
which should be matching criteria.

For non-DT cases, board file will have to assign a unique id while calling the
dma_declare_contiguous()

> Thanks,
> Laura
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
>
>
> _______________________________________________
> Linaro-mm-sig mailing list
> Linaro-mm-sig at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-mm-sig



- Nishanth Peethambaran
  +91-9448074166
