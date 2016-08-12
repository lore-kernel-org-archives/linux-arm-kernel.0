From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 12 Aug 2016 21:10:36 +0530
Subject: [PATCH 7/8] iommu: of: Handle IOMMU lookup failure with deferred
 probing or error
In-Reply-To: <CAAFQd5C8BuOCc5ySw_3tVELDG4S+r_5VyDvOPnBBuVr-6CBfxg@mail.gmail.com>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
 <1470696550-3416-8-git-send-email-sricharan@codeaurora.org>
 <CAAFQd5C8BuOCc5ySw_3tVELDG4S+r_5VyDvOPnBBuVr-6CBfxg@mail.gmail.com>
Message-ID: <000901d1f4af$e26b6c00$a7424400$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomaz,

>> +               if (ops->add_device)
>> +                       ops = ops->add_device(dev) ? ops : NULL;
>
>Patch description fails to mention anything about this change. Also it
>looks slightly incorrect to lose the error condition here. I think we
>should at least print some error message here and tell the user that
>we are falling back to non-IOMMU setup.
    Ok, will have to improve the patch description to add this and will
    fix the error value as well. Will also add the remove_device during
     deconfigure as well.

>
>>
>>                 of_node_put(np);
>>                 idx++;
>> @@ -200,7 +213,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>
>>  err_put_node:
>>         of_node_put(np);
>> -       return NULL;
>> +       return ops;
>>  }
>>
>>  void __init of_iommu_init(void)
>> @@ -211,7 +224,7 @@ void __init of_iommu_init(void)
>>         for_each_matching_node_and_match(np, matches, &match) {
>>                 const of_iommu_init_fn init_fn = match->data;
>>
>> -               if (init_fn(np))
>> +               if (init_fn && init_fn(np))
>
>When is it possible to have NULL init_fn?
   ya wrong, should not be needed.
 
>
>>                         pr_err("Failed to initialise IOMMU %s\n",
>>                                 of_node_full_name(np));
>>         }
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index e1fad50..92e02dc 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -149,6 +149,8 @@ int of_dma_configure_ops(struct device *dev, struct device_node *np)
>>                 coherent ? " " : " not ");
>>
>>         iommu = of_iommu_configure(dev, np);
>> +       if (IS_ERR(iommu))
>> +               return PTR_ERR(iommu);
>
>nit: Would be good to add a blank line here for improved readability.
   ok, will add.

Regards,
 Sricharan
