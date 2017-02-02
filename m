From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Thu, 02 Feb 2017 17:38:49 -0500
Subject: [PATCH V10 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <CAJZ5v0gfW-qn0Onj95EJmU94rp-+osZCqk+JBs96cJuGz1PUTA@mail.gmail.com>
References: <1484757988-23739-1-git-send-email-agustinv@codeaurora.org>
 <1484757988-23739-3-git-send-email-agustinv@codeaurora.org>
 <CAJZ5v0gfW-qn0Onj95EJmU94rp-+osZCqk+JBs96cJuGz1PUTA@mail.gmail.com>
Message-ID: <a0cc7d21838cf922c8c7cca1bd2b4b49@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On 2017-01-31 17:10, Rafael J. Wysocki wrote:
> On Wed, Jan 18, 2017 at 5:46 PM, Agustin Vega-Frias
> <agustinv@codeaurora.org> wrote:
>> ACPI extended IRQ resources may contain a ResourceSource to specify
>> an alternate interrupt controller. Introduce acpi_irq_get and use it
>> to implement ResourceSource/IRQ domain mapping.
>> 
>> The new API is similar to of_irq_get and allows re-initialization
>> of a platform resource from the ACPI extended IRQ resource, and
>> provides proper behavior for probe deferral when the domain is not
>> yet present when called.
>> 
>> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
>> ---
> [...]
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index c4af003..61423d2 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -102,6 +102,14 @@ int platform_get_irq(struct platform_device *dev, 
>> unsigned int num)
>>         }
>> 
>>         r = platform_get_resource(dev, IORESOURCE_IRQ, num);
>> +       if (r && r->flags & IORESOURCE_DISABLED && 
>> ACPI_COMPANION(&dev->dev)) {
>> +               int ret;
>> +
>> +               ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
>> +               if (ret)
>> +                       return ret;
>> +       }
> 
> The code above is a bit convoluted.  It would be better to write it as
> something like
> 
> if (r && r->flags & IORESOURCE_DISABLED) {
>         struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> 
>         if (adev) {
>                 int ret = acpi_irq_get(adev->handle, num, r);
> 
>                 if (ret)
>                         return ret;
>         }
> }
> 

I changed this to:

     r = platform_get_resource(dev, IORESOURCE_IRQ, num);
     if (has_acpi_companion(&dev->dev)) {
         if (r && r->flags & IORESOURCE_DISABLED) {
             int ret;

             ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
             if (ret)
                 return ret;
         }
     }

To avoid errors when CONFIG_ACPI is disabled.

Thanks for the ACKs. V12 coming soon.

Agustin

>> +
>>         /*
>>          * The resources may pass trigger flags to the irqs that need
>>          * to be set up. It so happens that the trigger flags for
>> @@ -1450,4 +1458,3 @@ void __init early_platform_cleanup(void)
>>                 memset(&pd->dev.devres_head, 0, 
>> sizeof(pd->dev.devres_head));
>>         }
>>  }
>> -
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 5b36974..03a94cd 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1153,4 +1153,14 @@ static inline void acpi_table_upgrade(void) { }
>>  static inline int parse_spcr(bool earlycon) { return 0; }
>>  #endif
>> 
>> +#ifdef CONFIG_ACPI_GENERIC_GSI
>> +int acpi_irq_get(acpi_handle handle, unsigned int index, struct 
>> resource *res);
>> +#else
>> +static inline int acpi_irq_get(acpi_handle handle, unsigned int 
>> index,
>> +                              struct resource *res)
>> +{
>> +       return -EINVAL;
>> +}
>> +#endif
>> +
>>  #endif /*_LINUX_ACPI_H*/
> 
> The rest looks reasonable to me.
> 
> Thanks,
> Rafael

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
