From: nathan@nathanrossi.com (Nathan Rossi)
Date: Thu, 10 Nov 2016 19:33:38 +1000
Subject: [PATCH] ARM: zynq: Reserve correct amount of non-DMA RAM
In-Reply-To: <CAHTX3d+8kBYQwcUUcL1Z71Geij4EU3pjcv29=r8ndqSLW8iZDw@mail.gmail.com>
References: <20161031162617.10565-1-kyle.roeschley@ni.com>
 <CAHTX3d+8kBYQwcUUcL1Z71Geij4EU3pjcv29=r8ndqSLW8iZDw@mail.gmail.com>
Message-ID: <CA+aJhH11ty3xWQ5-CLCrPA5xH-dr_nVb8JCKZEvgJcm6Ha3xaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 November 2016 at 18:41, Michal Simek <monstr@monstr.eu> wrote:
> + Nathan
>
> 2016-10-31 17:26 GMT+01:00 Kyle Roeschley <kyle.roeschley@ni.com>:
>>
>> On Zynq, we haven't been reserving the correct amount of DMA-incapable
>> RAM to keep DMA away from it (per the Zynq TRM Section 4.1, it should be
>> the first 512k). In older kernels, this was masked by the
>> memblock_reserve call in arm_memblock_init(). Now, reserve the correct
>> amount excplicitly rather than relying on swapper_pg_dir, which is an
>> address and not a size anyway.
>>
>> Fixes: 46f5b96 ("ARM: zynq: Reserve not DMAable space in front of the
>> kernel")
>>
>> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>

Tested-by: Nathan Rossi <nathan@nathanrossi.com>

For reference this causes problems with DEBUG_RODATA (which changed to
default yes for CPU_V7 in v4.6) due to padding memory between
.head.text and .text, allowing memory below 0x80000 to be available
for allocation as non-reserved memory.

Regards,
Nathan

>> ---
>> Found when migrating from 4.1 to 4.6.
>>
>>  arch/arm/mach-zynq/common.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
>> index 6cefdb8..75885bc 100644
>> --- a/arch/arm/mach-zynq/common.c
>> +++ b/arch/arm/mach-zynq/common.c
>> @@ -59,7 +59,7 @@ void __iomem *zynq_scu_base;
>>  static void __init zynq_memory_init(void)
>>  {
>>         if (!__pa(PAGE_OFFSET))
>> -               memblock_reserve(__pa(PAGE_OFFSET), __pa(swapper_pg_dir));
>> +               memblock_reserve(__pa(PAGE_OFFSET), 0x80000);
>>  }
>>
>>  static struct platform_device zynq_cpuidle_device = {
>> --
>> 2.9.3
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
>
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
> Maintainer of Linux kernel - Xilinx Zynq ARM architecture
> Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
