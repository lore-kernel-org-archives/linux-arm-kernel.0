From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 21 May 2015 22:27:54 +0800
Subject: [PATCH 10/11] irqchip / GICv2 / ACPI: Consolidate GICv2 ACPI
 related init code
In-Reply-To: <555CF23B.1000002@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
 <1431953961-22706-11-git-send-email-hanjun.guo@linaro.org>
 <555CF23B.1000002@linaro.org>
Message-ID: <555DEB6A.8090404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?05?21? 04:44, Tomasz Nowicki wrote:
> Hi Hanjun,
>
> On 05/18/2015 02:59 PM, Hanjun Guo wrote:
>> Move GICv2 ACPI related init code in irq-gic.c to irq-gic-acpi.c,
>> this can make the ACPI related GIC init code slef-contained.
>>
>> Introduce set_acpi_core_irqdomain() to set acpi_irqdomain then
>> it will be no need to make gic_data[] as a global value, and
>> it will save the confilcts with GICv3's gic_data in the later
>> patch.
>>
>> acpi_gic_parse_distributor() have the same function as
>> gic_acpi_parse_madt_distributor() to get the GIC distributor
>> physical base address, so just remove the duplicate one, and
>> only get the GIC version when it is unknown.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/irqchip/irq-gic-acpi.c       |  95
>> +++++++++++++++++++++++++++++++-
>>   drivers/irqchip/irq-gic.c            | 103
>> +----------------------------------
>>   include/linux/irqchip/arm-gic-acpi.h |   5 ++
>>   3 files changed, 101 insertions(+), 102 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-acpi.c
>> b/drivers/irqchip/irq-gic-acpi.c
>> index 1388d9e..8463e48 100644
>> --- a/drivers/irqchip/irq-gic-acpi.c
>> +++ b/drivers/irqchip/irq-gic-acpi.c
>> @@ -13,12 +13,16 @@
>>
>>   #include <linux/acpi.h>
>>   #include <linux/init.h>
>> +#include <linux/irqchip/arm-gic.h>
>>   #include <linux/irqchip/arm-gic-acpi.h>
>>   #include <linux/irqchip/arm-gic-v3.h>
>
> arm-gic.h and arm-gic-v3.h describe register map for respective drivers
> and should be used separately within parent driver only.

Seems that there is no duplicate macros in that two head
file, but yes, it will confuse people.

Consolidating all ACPI GIC code is an improvement to make
ACPI related code self-contained, but also have some drawbacks,

Marc, what do you think?

Thanks
Hanjun
