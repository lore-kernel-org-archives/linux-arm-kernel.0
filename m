From: monstr@monstr.eu (Michal Simek)
Date: Wed, 13 Feb 2013 15:39:21 +0100
Subject: [PATCH 1/2] arm: mm: Ignore memory banks which are in front of
 the kernel when HIGHMEM is ON
In-Reply-To: <20130213090317.GY17833@n2100.arm.linux.org.uk>
References: <1360745925-20952-1-git-send-email-michal.simek@xilinx.com>
 <20130213090317.GY17833@n2100.arm.linux.org.uk>
Message-ID: <CAHTX3dLy=t43+oNXMrsdz1_5AGf6==z=vG7K8V6dSG0tm6U4=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/2/13 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Feb 13, 2013 at 09:58:44AM +0100, Michal Simek wrote:
>> Arm kernel with HIGHMEM ON will fail when dts memory node is described
>> by memory banks and the starting address is not inside the first 16MB
>> of the first memory bank. If HIGHMEM is OFF and the configuration is the same
>> then the first memory bank is ignored and the kernel boots.
>>
>> Here is the example of behavior:
>> dts memory reg = <0x0 0x10000000 0x10000000 0x30000000>
>> kernel load address = 0x10000000 (respectively 0x1000800)
>>
>> Current:
>> "Machine: Xilinx Zynq Platform, model: Zynq ZC702 Development Board
>> bootconsole [earlycon0] enabled
>> Memory policy: ECC disabled, Data cache writeback
>> Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0."
>>
>> After:
>> The kernel ignore ram 0x0-0x0fffffff because is lower than the kernel starting
>> address and the kernel bootlog contains.
>> "Ignoring RAM at 00000000-0fffffff (CONFIG_HIGHMEM)."
>>
>> Also using mem=768M on the command line will overwrite dts memory
>> map and kernel will boot with HIGHMEM ON too.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>  arch/arm/mm/mmu.c |    9 +++++++++
>>  1 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>> index ce328c7..e60f370 100644
>> --- a/arch/arm/mm/mmu.c
>> +++ b/arch/arm/mm/mmu.c
>> @@ -937,6 +937,15 @@ void __init sanity_check_meminfo(void)
>>                       highmem = 1;
>>
>>  #ifdef CONFIG_HIGHMEM
>> +             if (__va(bank->start + bank->size - 1) < (void *)PAGE_OFFSET) {
>> +                     pr_notice("Ignoring RAM at %.8llx-%.8llx ",
>> +                             (unsigned long long)bank->start,
>> +                             (unsigned long long)bank->start
>> +                                                     + bank->size - 1);
>> +                     pr_cont("(CONFIG_HIGHMEM).\n");
>> +                     continue;
>> +             }
>
> NAK.  __va() is only valid for memory within the kernel's direct mapping
> (iow, lowmem).  Physical addresses outside of that range are free to
> return any other value.
>
> So, it's entirely possible that a valid highmem setup will have memory
> in highmem where __va(start + size - 1) _is_ below PAGE_OFFSET, and this
> memory should _not_ be discarded.

ok. Can you describe me this configuration? Enough to tell me dts memory
fragment and kernel load addr which match this case.
My configuration is above and it doesn't work that's why I believe you
have tested this case
and it will be easy for me to retest it.
Maybe we have any problem with zynq that's why I would like to be aware of it.

What about
"arm: mm: Add support for booting the kernel out of the first 16MB of memory"?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
