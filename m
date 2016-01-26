From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 26 Jan 2016 08:49:11 -0500
Subject: [PATCH] acpi: implement Generic Event Device
In-Reply-To: <CAHp75Ve98Z3xOxSQMG5ncpGggj+jmBmnWvw0ROXwK=s6X9N_QQ@mail.gmail.com>
References: <1453757387-28154-1-git-send-email-okaya@codeaurora.org>
 <CAHp75Ve98Z3xOxSQMG5ncpGggj+jmBmnWvw0ROXwK=s6X9N_QQ@mail.gmail.com>
Message-ID: <56A77957.3050500@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/26/2016 7:38 AM, Andy Shevchenko wrote:
> On Mon, Jan 25, 2016 at 11:29 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> 
> Few comments below.
> 
>> Generic Event Device described in ACPI 6.1 allows platforms to handle
>> platform interrupts in ACPI ASL statements. It borrows constructs like
>> _EVT from GPIO events.
> 
> Can it share code with gpiolib-acpi.c ? I see some duplication.

The interrupt registration mechanism could be made common but they have their own
data structure types. 

Can Rafael think of any higher level API like acpi_dev_resource_interrupt below?

> 
>> All interrupts are listed in _CRS and the handler
>> is written in _EVT method. Here is an example.
> 
> 
>>
>> Device (GED0)
>> {
>>
>>         Name (_HID, "ACPI0013")
>>         Name (_UID, 0)
>>         Name(_CRS, ResourceTemplate ()
>>         {
>>                 Interrupt(ResourceConsumer, Edge, ActiveHigh, Shared, , , )
>>                  {123}
>>         })
>>
>>         Method (_EVT, 1) {
>>                 if (Lequal(123, Arg0))
>>                 {
>>                 }
>>         }
>> }
>>
>> Wake capability has not been implemented yet.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/acpi/Makefile |   1 +
>>  drivers/acpi/evged.c  | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 163 insertions(+)
>>  create mode 100644 drivers/acpi/evged.c
>>
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index b5e7cd8..4dbb732 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -46,6 +46,7 @@ acpi-y                                += acpi_pnp.o
>>  acpi-y                         += int340x_thermal.o
>>  acpi-y                         += power.o
>>  acpi-y                         += event.o
>> +acpi-$(CONFIG_ACPI_REDUCED_HARDWARE_ONLY) += evged.o
>>  acpi-y                         += sysfs.o
>>  acpi-y                         += property.o
>>  acpi-$(CONFIG_X86)             += acpi_cmos_rtc.o
>> diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
>> new file mode 100644
>> index 0000000..a904676
>> --- /dev/null
>> +++ b/drivers/acpi/evged.c
>> @@ -0,0 +1,162 @@
>> +/*
>> + * Generic Event Device for ACPI.
>> + *
>> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * Generic Event Device allows platforms to handle
>> + * interrupts in ACPI ASL statements. It follows very similar
>> + * _EVT method approach from GPIO events.
>> + * All interrupts are listed in _CRS and the handler
>> + * is written in _EVT method. Here is an example.
> 
> Can it be wider on screen?
> 
sure

> 
>> +
>> +       event = devm_kzalloc(dev, sizeof(*event), GFP_KERNEL);
>> +       if (!event)
>> +               return AE_ERROR;
>> +
>> +       event->gsi = gsi;
>> +       event->dev = dev;
>> +       event->irq = irq;
>> +       event->handle = evt_handle;
>> +
>> +       if (r.flags & IORESOURCE_IRQ_SHAREABLE)
>> +               irqflags |= IRQF_SHARED;
>> +
>> +       if (devm_request_threaded_irq(dev, irq, NULL, acpi_ged_irq_handler,
>> +                                     irqflags, "ACPI:Ged", event)) {
>> +               dev_err(dev, "failed to setup event handler for irq %u\n", irq);
>> +               return AE_ERROR;
>> +       }
> 
> The above part is clearly belongs to ged_probe().
> 

It depends. The implementation needs to find all the interrupt entries in _CRS. That's why, 
the interrupt registration is done inside the ACPI callback.

I originally tried using the platform_get_irq() method rather than walking the ACPI resources. 
Any resource listed in _CRS is accessible via standard platform API. However, I couldn't obtain 
the shareability and other edge/level attributes through the standard APIs. Most drivers I have 
seen hardcode this information when calling devm_request_threaded_irq function.

Here, the type of interrupt is declared in the ACPI and the registration is done based on passed
attributes.

>> +
>> +       return AE_OK;
>> +}
>> +
>> +static int ged_probe(struct platform_device *pdev)
>> +{
>> +       acpi_status acpi_ret;
>> +
>> +       acpi_ret = acpi_walk_resources(ACPI_HANDLE(&pdev->dev), "_CRS",
>> +                                      acpi_ged_request_interrupt, &pdev->dev);
>> +       if (ACPI_FAILURE(acpi_ret)) {
>> +               dev_err(&pdev->dev, "unable to parse the _CRS record\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct acpi_device_id ged_acpi_ids[] = {
>> +       {"ACPI0013"},
>> +       {},
>> +};
>> +
>> +static struct platform_driver ged_driver = {
>> +       .probe = ged_probe,
>> +       .driver = {
>> +               .name = MODULE_NAME,
> 
>> +               .owner = THIS_MODULE,
> 
> Do you need this one?

I'll get rid of it.

> 
> 
>> +               .acpi_match_table = ACPI_PTR(ged_acpi_ids),
>> +       },
>> +};
>> +
>> +static int __init ged_init(void)
>> +{
>> +       return platform_driver_register(&ged_driver);
>> +}
>> +
> 
>> +subsys_initcall(ged_init);
> 
> Any specific reason to have on that level?
> 

changed to module_platform_driver(ged_driver); 

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
