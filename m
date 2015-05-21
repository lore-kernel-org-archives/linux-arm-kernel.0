From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 21 May 2015 22:19:54 +0800
Subject: [PATCH 03/11] irqchip / GIC: Add GIC version support in ACPI MADT
In-Reply-To: <alpine.DEB.2.11.1505202157190.4225@nanos>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
 <1431953961-22706-4-git-send-email-hanjun.guo@linaro.org>
 <alpine.DEB.2.11.1505202157190.4225@nanos>
Message-ID: <555DE98A.2000909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?05?21? 04:02, Thomas Gleixner wrote:
> On Mon, 18 May 2015, Hanjun Guo wrote:
>> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
>> index 65d6b93..855ead9 100644
>> --- a/drivers/acpi/irq.c
>> +++ b/drivers/acpi/irq.c
>> @@ -32,6 +32,9 @@ void __init acpi_irqchip_init(void)
>>   	if (acpi_disabled)
>>   		return;
>>
>> +	if (acpi_gic_version_init())
>> +		return;
>
> This looks just wrong. acpi_irqchip_init() is a generic ACPI function
> and now you stick a GIC specific callback into it?

For now, acpi_irqchip_init() just introduced for GIC init, not for
APIC init for x86, and I don't see the usage in the near future.

>
> What calls acpi_irqchip_init?

I renamed it as acpi_irq_init() in the later patch, which
is called in irqchip_init() in drivers/irqchip/irqchip.c
to init irqchip when DT is not available.

This is not a nice way, but the kernel should stay functional
for each patch goes in, so I separate the patch to smaller one
for easy review under that rule, does it make sense?

Thanks
Hanjun
