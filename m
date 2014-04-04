From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 4 Apr 2014 12:57:48 +0200
Subject: [PATCH V2 02/19] mmc: mmci: Convert to devm functions
In-Reply-To: <533E8C2E.9040400@monstr.eu>
References: <1396279100-2920-1-git-send-email-ulf.hansson@linaro.org>
 <1396279100-2920-3-git-send-email-ulf.hansson@linaro.org>
 <533E8C2E.9040400@monstr.eu>
Message-ID: <CAPDyKFqQ8ik2vz-E7A11T9tpk-+=KjwQxAJpqWh3UmehH7EDEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2014 12:40, Michal Simek <monstr@monstr.eu> wrote:
> On 03/31/2014 05:18 PM, Ulf Hansson wrote:
>> Converting to devm functions to simplify error handling in ->probe() and
>> to cleanup ->remove().
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/host/mmci.c |   51 ++++++++++++++++++-----------------------------
>>  1 file changed, 19 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index b0b81ac..d6f20ba 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/init.h>
>>  #include <linux/ioport.h>
>>  #include <linux/device.h>
>> +#include <linux/io.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/kernel.h>
>>  #include <linux/slab.h>
>> @@ -1456,15 +1457,13 @@ static int mmci_probe(struct amba_device *dev,
>>       if (np)
>>               mmci_dt_populate_generic_pdata(np, plat);
>>
>> -     ret = amba_request_regions(dev, DRIVER_NAME);
>> -     if (ret)
>> -             goto out;
>> +     if (!devm_request_mem_region(&dev->dev, dev->res.start,
>> +                             resource_size(&dev->res), DRIVER_NAME))
>> +             return -ENOMEM;
>
> here. Look below.
>
>>
>>       mmc = mmc_alloc_host(sizeof(struct mmci_host), &dev->dev);
>> -     if (!mmc) {
>> -             ret = -ENOMEM;
>> -             goto rel_regions;
>> -     }
>> +     if (!mmc)
>> +             return -ENOMEM;
>>
>>       host = mmc_priv(mmc);
>>       host->mmc = mmc;
>> @@ -1500,8 +1499,10 @@ static int mmci_probe(struct amba_device *dev,
>>               dev_dbg(mmc_dev(mmc), "eventual mclk rate: %u Hz\n",
>>                       host->mclk);
>>       }
>> +
>>       host->phybase = dev->res.start;
>> -     host->base = ioremap(dev->res.start, resource_size(&dev->res));
>> +     host->base = devm_ioremap(&dev->dev, host->phybase,
>> +                             resource_size(&dev->res));
>

Hi Michal,

Appreciate your review - you are right! I will convert to
devm_ioremap_resource().

Kind regards
Ulf Hansson

> Isn't it better to use devm_ioremap_resource directly?
> You will get correct error return values too.
>
> Thanks,
> Michal
>
>
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
> Maintainer of Linux kernel - Xilinx Zynq ARM architecture
> Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
>
>
