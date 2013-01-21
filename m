From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Mon, 21 Jan 2013 13:57:42 -0300
Subject: [PATCH v2 3/3] arm: omap2: gpmc: add DT bindings for OneNAND
In-Reply-To: <20130121123020.GI15707@e106331-lin.cambridge.arm.com>
References: <1358634477-25868-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1358634477-25868-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130121123020.GI15707@e106331-lin.cambridge.arm.com>
Message-ID: <CALF0-+VOxtsfQLZCGujvjMrsGacbfVTMytRUX=CfKa3+FgnU1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Jan 21, 2013 at 9:30 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> [...]
>
>> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
>> index 01ce462..f7de9eb 100644
>> --- a/arch/arm/mach-omap2/gpmc.c
>> +++ b/arch/arm/mach-omap2/gpmc.c
>> @@ -39,6 +39,7 @@
>>  #include "omap_device.h"
>>  #include "gpmc.h"
>>  #include "gpmc-nand.h"
>> +#include "gpmc-onenand.h"
>>
>>  #define      DEVICE_NAME             "omap-gpmc"
>>
>> @@ -1259,6 +1260,43 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
>>  }
>>  #endif
>>
>> +#ifdef CONFIG_MTD_ONENAND
>> +static int gpmc_probe_onenand_child(struct platform_device *pdev,
>> +                              struct device_node *child)
>> +{
>> +     u32 val;
>> +     struct omap_onenand_platform_data *gpmc_onenand_data;
>> +
>> +     if (of_property_read_u32(child, "reg", &val) < 0) {
>> +             dev_err(&pdev->dev, "%s has no 'reg' property\n",
>> +                     child->full_name);
>> +             return -ENODEV;
>> +     }
>> +
>> +     gpmc_onenand_data = devm_kzalloc(&pdev->dev, sizeof(*gpmc_onenand_data),
>> +                                      GFP_KERNEL);
>> +     if (!gpmc_onenand_data)
>> +             return -ENOMEM;
>> +
>> +     gpmc_onenand_data->cs = val;
>> +     gpmc_onenand_data->of_node = child;
>> +     gpmc_onenand_data->dma_channel = -1;
>> +
>> +     if (!of_property_read_u32(child, "dma-channel", &val))
>> +             gpmc_onenand_data->dma_channel = val;
>> +
>> +     gpmc_onenand_init(gpmc_onenand_data);
>> +
>> +     return 0;
>> +}
>> +#else
>> +static int gpmc_probe_onenand_child(struct platform_device *pdev,
>> +                                 struct device_node *child)
>> +{
>> +     return 0;
>> +}
>> +#endif
>> +
>>  static int gpmc_probe_dt(struct platform_device *pdev)
>>  {
>>       int ret;
>> @@ -1276,6 +1314,12 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>>                       return ret;
>>       }
>>
>
> This doesn't look right to me:
>
>> +     for_each_node_by_name(child, "onenand") {
>> +             ret = gpmc_probe_onenand_child(pdev, child);
>> +             of_node_put(child);
>> +             if (ret < 0)
>> +                     return ret;
>> +     }
>
> for_each_node_by_name automatically calls of_node_put on each node once passed,
> and as far as I can tell, gpmc_probe_onenand_child doesn't do anything that'd
> increment a node's refcount.
>
> As far as I can see, you only need the of_node_put in the error case:
>
> for_each_node_by_name(child, "onenand") {
>         ret = gpmc_probe_onenand_child(pdev, child);
>         if (ret < 0) {
>                 of_node_put(child);
>                 return ret;
>         }
> }
>
> Have I missed something here?
>

Mmm... perhaps I've overlooked that code.

After some digging through source and reading for_each_node_by_name()
it seems to me you're right.

@Daniel: It seems this would also apply to the NAND binding.
What do you think?

-- 
    Ezequiel
