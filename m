From: monstr@monstr.eu (Michal Simek)
Date: Mon, 25 Mar 2013 15:51:28 +0100
Subject: [PATCH 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <515059D4.5070903@gmail.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
 <1364219596-4954-4-git-send-email-michal.simek@xilinx.com>
 <515059D4.5070903@gmail.com>
Message-ID: <CAHTX3dJfvFNNuyJC54fS=NCpRxovVsxHTss8wJd_QOB2PaxL7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

2013/3/25 Rob Herring <robherring2@gmail.com>:
> On 03/25/2013 08:53 AM, Michal Simek wrote:
>> Use Cortex a9 cp15 to read scu baseaddress.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>  arch/arm/boot/dts/zynq-7000.dtsi |    5 +++++
>>  arch/arm/mach-zynq/common.c      |   33 +++++++++++++++++++++------------
>>  arch/arm/mach-zynq/common.h      |    2 ++
>>  3 files changed, 28 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>> index 2a72339..4943568 100644
>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>> @@ -22,6 +22,11 @@
>>               interrupt-parent = <&intc>;
>>               ranges;
>>
>> +             scu: scu at f8f000000 {
>> +                     compatible = "arm,cortex-a9-scu";
>> +                     reg = <0xf8f00000 0x58>;
>> +             };
>> +
>
> It's fine to add this, but you don't really need it for this patch.

yes truth.

>
>>               intc: interrupt-controller at f8f01000 {
>>                       compatible = "arm,cortex-a9-gic";
>>                       #interrupt-cells = <3>;
>> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
>> index 68e0907..13f9d8b 100644
>> --- a/arch/arm/mach-zynq/common.c
>> +++ b/arch/arm/mach-zynq/common.c
>> @@ -33,10 +33,13 @@
>>  #include <asm/mach-types.h>
>>  #include <asm/page.h>
>>  #include <asm/pgtable.h>
>> +#include <asm/smp_scu.h>
>>  #include <asm/hardware/cache-l2x0.h>
>>
>>  #include "common.h"
>>
>> +void __iomem *scu_base;
>> +
>>  static struct of_device_id zynq_of_bus_ids[] __initdata = {
>>       { .compatible = "simple-bus", },
>>       {}
>> @@ -56,17 +59,6 @@ static void __init xilinx_init_machine(void)
>>       of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
>>  }
>>
>> -#define SCU_PERIPH_PHYS              0xF8F00000
>> -#define SCU_PERIPH_SIZE              SZ_8K
>> -#define SCU_PERIPH_VIRT              (VMALLOC_END - SCU_PERIPH_SIZE)
>> -
>> -static struct map_desc scu_desc __initdata = {
>> -     .virtual        = SCU_PERIPH_VIRT,
>> -     .pfn            = __phys_to_pfn(SCU_PERIPH_PHYS),
>> -     .length         = SCU_PERIPH_SIZE,
>> -     .type           = MT_DEVICE,
>> -};
>> -
>>  static void __init xilinx_zynq_timer_init(void)
>>  {
>>       struct device_node *np;
>> @@ -81,13 +73,30 @@ static void __init xilinx_zynq_timer_init(void)
>>       clocksource_of_init();
>>  }
>>
>> +static struct map_desc zynq_cortex_a9_scu_map __initdata = {
>> +     .length = SZ_256,
>> +     .type   = MT_DEVICE,
>> +};
>> +
>> +static void __init scu_init(void)
>> +{
>> +     unsigned long base;
>> +
>> +     base = scu_a9_get_base();
>> +     zynq_cortex_a9_scu_map.pfn = __phys_to_pfn(base);
>> +     zynq_cortex_a9_scu_map.virtual = base;
>
> You are setting the virtual address to the physical base?
>
>> +     iotable_init(&zynq_cortex_a9_scu_map, 1);
>
> Then creating a static mapping...
>
>> +     scu_base = ioremap(base, zynq_cortex_a9_scu_map.length);
>
> And also a dynamic mapping?

Yes - exactly.
I was talking to Olof about this code at ELC and he mentioned that someone
else might know better way how to do it.

It is quite a long time I played with this code.
I found this solution in vexpress platform (mach-vexpress/platsmp.c)

IRC: Static mapping is necessary to be able to access device so early.
On the other hand you can't use this static mapping when kernel runs
for that you need to use dynamic allocation.
Calling ioremap so early caused that the return address is the same
and you can just use it later. and it is also in the correct vmalloc area.

We are using scu_base for power management code.
Let me check if dynamic mapping is also required.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
