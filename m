From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Thu, 11 Nov 2010 13:44:09 -0800
Subject: arm smp support patch
In-Reply-To: <52622063180ba1627bf98811e4f56a05.squirrel@www.concentris-systems.com>
References: <73a3b42c84eb2bfde0f861d1e53042cd.squirrel@www.concentris-systems.com>	<20101111044125.GA5850@mvista.com>
	<52622063180ba1627bf98811e4f56a05.squirrel@www.concentris-systems.com>
Message-ID: <4CDC63A9.9090606@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Scott Valentine wrote:
>> On Tue, Nov 09, 2010 at 01:33:20PM -1000, Scott Valentine wrote:
>>> On arm multi-core platforms that have a gic, the secondary cores fail to
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
>>>         for (i = 0; i < max_irq; i += 32)
>>>                 writel(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4
>>> /
>>> 32);
>>>
>>> +#ifdef CONFIG_SMP
>>> +       /*
>>> +        * Enable IPI interrupts on SMP systems so we can wake secondary
>>> cores
>>> +        */
>>> +       writel(0x0000ffff, base + GIC_DIST_ENABLE_SET);

Scott, you might want to try doing this first thing in gic_cpu_init. 
That seems to be the right place since the ENABLE_SET is banked per
cpu.

Abhijeet
