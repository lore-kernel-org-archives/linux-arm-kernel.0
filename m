From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue, 20 Mar 2018 17:39:07 +0800
Subject: Failed to boot ARM64 boards for recent linux-next
In-Reply-To: <9cff515e-fcb9-a1c0-329b-a18c3bed0071@rock-chips.com>
References: <dae4b3b8-3da4-4a86-ac4a-0631802fa546@rock-chips.com>
 <077cecdd-7982-dd33-454f-e38cc571366c@arm.com>
 <9cff515e-fcb9-a1c0-329b-a18c3bed0071@rock-chips.com>
Message-ID: <fe56e7e3-50dd-88de-ce61-f3cbcc1f572b@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc

On 2018/3/20 17:32, Shawn Lin wrote:
> Hi Marc,
> 
> On 2018/3/20 17:01, Marc Zyngier wrote:
>> Hi Shawn,
>>
>> On 20/03/18 08:48, Shawn Lin wrote:
>>> Hi Marc,
>>>
>>> ????? I was able to boot my RK3399 board with in linux-next-20180314,
>>> but not today. My bisect robot shows me it was introduced by
>>>
>>> commit d6062a6d62c643a06c393745d032da3e6441d4bd
>>> Author: Marc Zyngier <marc.zyngier@arm.com>
>>> Date:?? Fri Mar 9 14:53:19 2018 +0000
>>>
>>> ????? irqchip/gic-v3: Reset APgRn registers at boot time
>>>
>>> ????? Booting a crash kernel while in an interrupt handler is likely
>>> ????? to leave the Active Priority Registers with some state that
>>> ????? is not relevant to the new kernel, and is likely to lead
>>> ????? to erratic behaviours such as interrupts not firing as their
>>> ????? priority is already active.
>>>
>>> ????? As a sanity measure, wipe the APRs clean on startup. We make
>>> ????? sure to wipe both group 0 and 1 registers in order to avoid
>>> ????? any surprise.
>>>
>>>
>>> The panic log is here:
>>> https://paste.ubuntu.com/p/7WrJJDG6JQ/
>>>
>>> Is it a known issue or is there a coming patch for that?
>>
>> ? Interesting. No, that wasn't the intention, but I may have missed a key
>> detail (group 0 access traps to EL3 if SCR_EL3.FIQ==1). Can you have a
>> go at the following hack, just to narrow it down:
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 5bb7bb22f1c1..f8ff43b1d4f8 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -570,16 +570,12 @@ static void gic_cpu_sys_reg_init(void)
>> ????? switch(val + 1) {
>> ????? case 8:
>> ????? case 7:
>> -??????? write_gicreg(0, ICC_AP0R3_EL1);
>> ????????? write_gicreg(0, ICC_AP1R3_EL1);
>> -??????? write_gicreg(0, ICC_AP0R2_EL1);
>> ????????? write_gicreg(0, ICC_AP1R2_EL1);
>> ????? case 6:
>> -??????? write_gicreg(0, ICC_AP0R1_EL1);
>> ????????? write_gicreg(0, ICC_AP1R1_EL1);
>> ????? case 5:
>> ????? case 4:
>> -??????? write_gicreg(0, ICC_AP0R0_EL1);
>> ????????? write_gicreg(0, ICC_AP1R0_EL1);
>> ????? }
>>
>> Let me know if that helps.
>>
> 
> It works for me. Thanks!


Also another patch warns a lot when booting the kernel. Is there
anything else I could do to let it go? Seems I am using broken
dts for requesting IRQ_TYPE_NONE there?

[    0.000000] WARNING: CPU: 0 PID: 0 at 
drivers/irqchip/irq-gic-v3.c:909 gic_irq_domain_translate+0x84/0xe8
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
4.16.0-rc6-next-20180320-00006-g841c1d1-dirty #257
[    0.000000] Hardware name: Excavator-RK3399 Board (DT)
[    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
[    0.000000] pc : gic_irq_domain_translate+0x84/0xe8
[    0.000000] lr : irq_create_fwspec_mapping+0x64/0x328
[    0.000000] sp : ffff000009033cb0
[    0.000000] x29: ffff000009033cb0 x28: 0000000000000002
[    0.000000] x27: ffff8000f280fc90 x26: 0000000000000003
[    0.000000] x25: 0000000000000000 x24: ffff8000f280fc80
[    0.000000] x23: ffff00000903c8f8 x22: ffff00000903c000
[    0.000000] x21: ffff000009033d88 x20: ffff000009039000
[    0.000000] x19: ffff8000f2825000 x18: ffffffffffffffff
[    0.000000] x17: 000000000000000a x16: 00000000000007ff
[    0.000000] x15: ffff0000090396c8 x14: 31407570632f7375
[    0.000000] x13: 70632f207b205d31 x12: 5b312d6e6f697469
[    0.000000] x11: 747261702d747075 x10: 727265746e69206e
[    0.000000] x9 : 6f69746974726170 x8 : 407570632f737570
[    0.000000] x7 : 0000000000000000 x6 : 0000000000000002
[    0.000000] x5 : 0000000000000001 x4 : ffff000008c153f8
[    0.000000] x3 : ffff000009033cec x2 : ffff000009033cf0
[    0.000000] x1 : ffff000009033d88 x0 : 0000000000000000
[    0.000000] Call trace:
[    0.000000]  gic_irq_domain_translate+0x84/0xe8
[    0.000000]  gic_populate_ppi_partitions+0x1fc/0x280
[    0.000000]  gic_of_init+0x174/0x214
[    0.000000]  of_irq_init+0x180/0x2e8
[    0.000000]  irqchip_init+0x14/0x38
[    0.000000]  init_IRQ+0xfc/0x130
[    0.000000]  start_kernel+0x284/0x414
[    0.000000] ---[ end trace 5a16819db6b2d5d2 ]---

commit 6ef6386ef7c15bea21afce06f951c87de7e2a562
Author: Marc Zyngier <marc.zyngier@arm.com>
Date:   Fri Mar 16 14:35:17 2018 +0000

     irqchip/gic-v3: Loudly complain about the use of IRQ_TYPE_NONE

     There is a huge number of broken device trees out there. Just
     grepping through the tree for the use of IRQ_TYPE_NONE in conjunction
     with the GIC is scary.

     People just don't realise that IRQ_TYPE_NONE just doesn't exist, and
     you just get whatever junk was there before. So let's make them aware
     of the issue.

     Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>


> 
>> Thanks,
>>
>> ????M.
>>
> 
> 
> 
