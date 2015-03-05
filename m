From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 5 Mar 2015 17:06:34 +0800
Subject: [PATCH v9 16/21] irqchip: Add GICv2 specific ACPI boot support
In-Reply-To: <5921774.hkUTDjxi3A@vostro.rjw.lan>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-17-git-send-email-hanjun.guo@linaro.org>
 <5921774.hkUTDjxi3A@vostro.rjw.lan>
Message-ID: <54F81C9A.6040502@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/5 6:50, Rafael J. Wysocki wrote:
> On Wednesday, February 25, 2015 04:39:56 PM Hanjun Guo wrote:
>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>
>> ACPI kernel uses MADT table for proper GIC initialization. It needs to
>> parse GIC related subtables, collect CPU interface and distributor
>> addresses and call driver initialization function (which is hardware
>> abstraction agnostic). In a similar way, FDT initialize GICv1/2.
>>
>> NOTE: This commit allow to initialize GICv1/2 basic functionality.
>> While now simple GICv2 init call is used, any further GIC features
>> require generic infrastructure for proper ACPI irqchip initialization.
>> That mechanism and stacked irqdomains to support GICv2 MSI/virtualization
>> extension, GICv3/4 and its ITS are considered as next steps.
[...]
>> diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
>> index 0fe2f71..5855240 100644
>> --- a/drivers/irqchip/irqchip.c
>> +++ b/drivers/irqchip/irqchip.c
>> @@ -8,6 +8,7 @@
>>   * warranty of any kind, whether express or implied.
>>   */
>>  
>> +#include <linux/acpi.h>
>>  #include <linux/init.h>
>>  #include <linux/of_irq.h>
>>  #include <linux/irqchip.h>
>> @@ -26,4 +27,6 @@ extern struct of_device_id __irqchip_of_table[];
>>  void __init irqchip_init(void)
>>  {
>>  	of_irq_init(__irqchip_of_table);
>> +
>> +	acpi_irq_init();
>>  }
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index c03d8d1..e27117a 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -557,6 +557,20 @@ static inline int acpi_device_modalias(struct device *dev,
>>  
>>  #endif	/* !CONFIG_ACPI */
>>  
>> +#if defined(CONFIG_ACPI) && defined(CONFIG_ARM64)
>> +static inline void acpi_irq_init(void)
>> +{
>> +	/*
>> +	 * Hardcode ACPI IRQ chip initialization to GICv2 for now.
>> +	 * Proper irqchip infrastructure will be implemented along with
>> +	 * incoming  GICv2m|GICv3|ITS bits.
>> +	 */
>> +	acpi_gic_init();
>> +}
>> +#else
>> +static inline void acpi_irq_init(void) { }
>> +#endif
> I don't want this in a common header.

This is because of irqchip_init(void) in drivers/irqchip/irqchip.c
will be called by PowerPC too, so we need to put it in a common
head file, I will discuss with Tomasz to see if we have any further
solution.

Thanks
Hanjun
