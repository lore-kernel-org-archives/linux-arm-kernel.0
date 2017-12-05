From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Tue, 5 Dec 2017 07:21:03 -0600
Subject: [PATCH] irqchip/gic-v3: Fix the driver probe() fail due to
 disabled GICC entry
In-Reply-To: <a854553a-f751-842d-c813-1871b18aae75@arm.com>
References: <1512343269-19327-1-git-send-email-shankerd@codeaurora.org>
 <8a926bff-f8aa-220c-85f0-9d39ec5bef4b@arm.com>
 <383ff5f3-44e9-e654-f421-2ac5bac2419a@codeaurora.org>
 <a854553a-f751-842d-c813-1871b18aae75@arm.com>
Message-ID: <250756b7-741e-9295-abcd-b4a69898c10a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 12/05/2017 02:59 AM, Marc Zyngier wrote:
> On 04/12/17 14:04, Shanker Donthineni wrote:
>> Hi Thanks,
>>
>> On 12/04/2017 04:28 AM, Marc Zyngier wrote:
>>> On 03/12/17 23:21, Shanker Donthineni wrote:
>>>> As per MADT specification, it's perfectly valid firmware can pass
>>>> MADT table to OS with disabled GICC entries. ARM64-SMP code skips
>>>> those cpu cores to bring online. However the current GICv3 driver
>>>> probe bails out in this case on systems where redistributor regions
>>>> are not in the always-on power domain.
>>>>
>>>> This patch does the two things to fix the panic.
>>>>   - Don't return an error in gic_acpi_match_gicc() for disabled GICC.
>>>>   - No need to keep GICR region information for disabled GICC.
>>>>
>>>> Kernel crash traces:
>>>>   Kernel panic - not syncing: No interrupt controller found.
>>>>   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.13.5 #26
>>>>   [<ffff000008087770>] dump_backtrace+0x0/0x218
>>>>   [<ffff0000080879dc>] show_stack+0x14/0x20
>>>>   [<ffff00000883b078>] dump_stack+0x98/0xb8
>>>>   [<ffff0000080c5c14>] panic+0x118/0x26c
>>>>   [<ffff000008b62348>] init_IRQ+0x24/0x2c
>>>>   [<ffff000008b609fc>] start_kernel+0x230/0x394
>>>>   [<ffff000008b601e4>] __primary_switched+0x64/0x6c
>>>>   ---[ end Kernel panic - not syncing: No interrupt controller found.
>>>>
>>>> Disabled GICC subtable example:
>>>>                    Subtable Type : 0B [Generic Interrupt Controller]
>>>>                           Length : 50
>>>>                         Reserved : 0000
>>>>             CPU Interface Number : 0000003D
>>>>                    Processor UID : 0000003D
>>>>            Flags (decoded below) : 00000000
>>>>                Processor Enabled : 0
>>>>  Performance Interrupt Trig Mode : 0
>>>>  Virtual GIC Interrupt Trig Mode : 0
>>>>         Parking Protocol Version : 00000000
>>>>            Performance Interrupt : 00000017
>>>>                   Parked Address : 0000000000000000
>>>>                     Base Address : 0000000000000000
>>>>         Virtual GIC Base Address : 0000000000000000
>>>>      Hypervisor GIC Base Address : 0000000000000000
>>>>            Virtual GIC Interrupt : 00000019
>>>>       Redistributor Base Address : 0000FFFF88F40000
>>>>                        ARM MPIDR : 000000000000000D
>>>>                 Efficiency Class : 00
>>>>                         Reserved : 000000
>>>>
>>>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>>>> ---
>>>>  drivers/irqchip/irq-gic-v3.c | 14 +++++++++-----
>>>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>>>> index b56c3e2..a30fbac 100644
>>>> --- a/drivers/irqchip/irq-gic-v3.c
>>>> +++ b/drivers/irqchip/irq-gic-v3.c
>>>> @@ -1331,6 +1331,10 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
>>>>  	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
>>>>  	void __iomem *redist_base;
>>>>  
>>>> +	/* GICC entry which has !ACPI_MADT_ENABLED is not unusable so skip */
>>>> +	if (!(gicc->flags & ACPI_MADT_ENABLED))
>>>> +		return 0;
>>>> +
>>>>  	redist_base = ioremap(gicc->gicr_base_address, size);
>>>>  	if (!redist_base)
>>>>  		return -ENOMEM;
>>>> @@ -1374,13 +1378,13 @@ static int __init gic_acpi_match_gicc(struct acpi_subtable_header *header,
>>>>  				(struct acpi_madt_generic_interrupt *)header;
>>>>  
>>>>  	/*
>>>> -	 * If GICC is enabled and has valid gicr base address, then it means
>>>> -	 * GICR base is presented via GICC
>>>> +	 * If GICC is enabled and has not valid gicr base address, then it means
>>>> +	 * GICR base is not presented via GICC
>>>>  	 */
>>>> -	if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address)
>>>> -		return 0;
>>>> +	if ((gicc->flags & ACPI_MADT_ENABLED) && (!gicc->gicr_base_address))
>>>> +		return -ENODEV;
>>>
>>> This doesn't feel quite right. It would mean that having the ENABLED
>>> flag cleared and potentially no address would make it valid? It looks to
>>> me that the original code is "less wrong".
>>>
>>> What am I missing?
>>>
>>
>> Original definition of the function gic_acpi_match_gicc().
>>  {
>>   if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address)
>>     return 0;
>>
>>   return -ENODEV;
>>  }
>>
>> Above code triggers the driver probe fail for the two reasons.
>>   1) GICC with ACPI_MADT_ENABLED=0, it's a bug according to ACPI spec.
>>   2) GICC with ACPI_MADT_ENABLED=1 and invalid GICR address, expected.
>>
>>
>> This patch fix the first failed case and keep the second case intact.
>>   if ((gicc->flags & ACPI_MADT_ENABLED) && (!gicc->gicr_base_address))
>>     return -ENODEV;
>>
>>   return 0;
> If (1) is a firmware bug, then why is it handled in the SMP code? You're
> even saying that this is the right thing to do?
> 

It's a bug in Linux GICv3 driver not firmware. Firmware is populating MADT
table according to ACPI specification.

> As for (2), you seem to imply that only the address matter. So why isn't
> it just:
> 
> 	if (gicc->gicr_base_address)
> 		return 0;
> 
> ?

ACPI spec says operating shouldn't attempt to use GICC configuration parameters
if the flag ACPI_MADT_ENABLED is cleared. I believe we should check GICR address
only for enabled GICC interfaces. 

 
> 
> Thanks,
> 
> 	M.
> 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
