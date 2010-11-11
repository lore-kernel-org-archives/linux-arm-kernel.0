From: svalentine@concentris-systems.com (Scott Valentine)
Date: Thu, 11 Nov 2010 11:16:58 -1000
Subject: arm smp support patch
In-Reply-To: <4CDC4C11.7090003@gmail.com>
References: <73a3b42c84eb2bfde0f861d1e53042cd.squirrel@www.concentris-systems.com>
	<20101111044125.GA5850@mvista.com> <4CDC4C11.7090003@gmail.com>
Message-ID: <7138466c84c288d93cb16e87c0038333.squirrel@www.concentris-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 11/10/2010 10:41 PM, George G. Davis wrote:
>> On Tue, Nov 09, 2010 at 01:33:20PM -1000, Scott Valentine wrote:
>>> On arm multi-core platforms that have a gic, the secondary cores fail
>>> to
>>> wake if they are booted in WFI mode, as the gic_dist_init disables all
>>> interrupts including IPI. I've included a simple patch to the
>>> gic_dist_init function that enables interrupts 0-15 on SMP enabled
>>> systems. This patch was made against linux-2.6-HEAD-151f52f.
>>>
>>>
>>> diff -uNr a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>>> --- a/arch/arm/common/gic.c     2010-11-05 15:57:04.000000000 -1000
>>> +++ b/arch/arm/common/gic.c     2010-11-09 13:08:33.000000000 -1000
>>> @@ -262,6 +262,13 @@
>>>          for (i = 0; i<  max_irq; i += 32)
>>>                  writel(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i *
>>> 4 /
>>> 32);
>>>
>>> +#ifdef CONFIG_SMP
>>> +       /*
>>> +        * Enable IPI interrupts on SMP systems so we can wake
>>> secondary
>>> cores
>>> +        */
>>> +       writel(0x0000ffff, base + GIC_DIST_ENABLE_SET);
>>
>> The ARM11 MPCore TRM [1] states "Interrupts 0-15 fields are read as one,
>> that is, always enabled, and write to these fields have no effect."  So
>> it seems odd that this is needed.  Errata?  FWIW, I've peeked and poked
>> at GIC_DIST_ENABLE_SET and GIC_DIST_ENABLE_CLEAR via a debugger and the
>> 16 LSBs of both of these registers are stuck-at-one on my ARM11 MPCore
>> r1p0.
>>
> The GIC arch spec states these bits are implementation defined. However,
> this register is also banked for SMP. So you cannot enable the interrupt
> for other cores from the primary core.
>
> Rob
>
I couldn't find any documentation that states this explicitly; my best
understanding is that the IPI interrupts (0-15) are aliased for each core.
The behavior I'm seeing in the econa indicates that the write from core 0
does in fact enable the interrupts on core 1.
