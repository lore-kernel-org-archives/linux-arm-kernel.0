From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 11 Jun 2015 21:22:37 +0800
Subject: [PATCH 05/11] irqchip / gic: Add stacked irqdomain support for
 ACPI based GICv2 init
In-Reply-To: <55786556.1020404@arm.com>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
 <1431953961-22706-6-git-send-email-hanjun.guo@linaro.org>
 <55786556.1020404@arm.com>
Message-ID: <55798B9D.5050409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2015 12:27 AM, Marc Zyngier wrote:
> On 18/05/15 13:59, Hanjun Guo wrote:
>> Introduce acpi_irq_domain for GICv2 core domain instead of referring
>> to the irq_default_domain, based on that, pass gsi as the argument and
>> get the gsi in gic_irq_domain_alloc() to add stacked irqdomain support
>> for ACPI based GICv2 init.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/acpi/gsi.c                   | 28 +++++++++++++---------------
>>   drivers/irqchip/irq-gic.c            | 32 +++++++++++++++++---------------
>>   include/linux/irqchip/arm-gic-acpi.h |  2 ++
>>   3 files changed, 32 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
>> index 38208f2..55b5f31 100644
>> --- a/drivers/acpi/gsi.c
>> +++ b/drivers/acpi/gsi.c
>> @@ -3,6 +3,7 @@
>>    *
>>    * Copyright (C) 2015 ARM Ltd.
>>    * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> + *         Hanjun Guo <hanjun.guo@linaro.org> for stacked irqdomains support
>>    *
>>    * This program is free software; you can redistribute it and/or modify
>>    * it under the terms of the GNU General Public License version 2 as
>> @@ -13,6 +14,8 @@
>>   #include <linux/irqdomain.h>
>>
>>   enum acpi_irq_model_id acpi_irq_model;
>> +/* ACPI core domian pointing to GICv2/3 core domain */
>> +struct irq_domain *acpi_irq_domain __read_mostly;
>
> How is a single domain pointer going to work when you will have several
> domains (GICv2m, ITS)?

This acpi_irq_domain is the core domain which is the parent domain
of GICv2m or ITS.

acpi_irq_domain points to GICv2 or GICv3 domain when the GIC
is initialized.

> Crucially, how are you going to perform the
> matching of a device with its irq domain?

since every ITS will have a domain, and there is a mapping
from device id to ITS ID in IORT table, then we can match the
device with the ITS irq domain, does it make sense?

Thanks
Hanjun
