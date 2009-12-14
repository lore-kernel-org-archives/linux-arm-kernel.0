From: valentin.longchamp@epfl.ch (valentin.longchamp at epfl.ch)
Date: Mon, 14 Dec 2009 22:41:09 +0100
Subject: "ARM: MX3: fix CPU revision number detection" breaks QONG support
In-Reply-To: <20091214150420.GE28375@buzzloop.caiaq.de>
References: <20091211143318.1D8B43F6CC@gemini.denx.de>
	<20091211234714.GT28375@buzzloop.caiaq.de>
	<20091214135722.CBCBF4C026@gemini.denx.de>
	<20091214150420.GE28375@buzzloop.caiaq.de>
Message-ID: <20091214224109.20623gout4jbbdo5@webmail.epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@caiaq.de> a ?crit?:

> On Mon, Dec 14, 2009 at 02:57:22PM +0100, Wolfgang Denk wrote:
>> I don't think this is a boot loader issue.
>>
>> In Linux, the kernel hangs here:
>>
>> 	/* read SREV register from IIM module */
>> 	srev = __raw_readl(IO_ADDRESS(IIM_BASE_ADDR) + MXC_IIMSREV);
>>
>> In U-Boot, I can read this register just fine:
>>
>> 	=> md 5001c024 1
>> 	5001c024: 00000028    (...
>>
>> In Linux, the IO_ADDRESS() makes this a read from 0xFC11C024, which
>> hangs.
>>
>> So if this is a clock thing, then it must be a clock being disabled by
>> Linux.

I have looked more carefully at the bootloader code, and it does not  
seem to configure anything for SPBA0. Furthermore, Redboot actually  
reads this register at boot time to determine the CPU revision just as  
Daniel with its patch.

As for Wolfgang, when I ask Redboot to dump this memory region, I can  
read the revision as well (0x28 here too). I would then also rule the  
bootloader out of the culprits. It would be interesting to see what  
CPU revisions have the people who experience the problem and the ones  
who don't (but I don't think it does play a role).

For the IO_ADDRESS stuff, it may be the problem. This macro is  
supposed to do the physical address -> virtual address translation. If  
I have understood correctly (correct if wrong, I don't really know  
when whe have to use it or not), it is used when the memory region was  
not allocated and then mapped with request_mem_region and ioremap  
calls. The 0xFC11C024 is the virtual address defined by the IO_ADDRESS  
macro succession for the SPBA0 memory region. Now how was this defined  
and may this fail on certain systems/configuration because other  
memory definitions ?

>
> Well, clocks are explicitly enabled for that module, so I really don't
> know. And I can't debug as I'm not at my office where the hardware is I
> developed this on. Can anyone help check what's the matter? As I said,
> on my MX31LiteKit, that works as expected and the register definition
> reads as something that must have been there for a longer time (taking
> into account that possible values for that register cover ancient
> variants of that hardware).

The iim clock is explicitely enabled in clock.c, just before the call  
to mx31_read_cpu_rev(), and from what I had checked, the clock  
effectively seemed enabled for me. I have no clue about the register  
definition since I have found no real documentation about it, but from  
my point of view, this would more look like 8 bit registers as Andy  
pointed out in an earlier mail.

>
> As I said already, we could also consider reverting this patch - I'll
> have another look and ask for more testers when I'm back. I would,
> however, greatly prefer a fixup patch.
>

Let's wait a few more days so that we maybe can find a solution, but  
in case no solution is found when -rc1 is approaching, we maybe should  
revert it.

Val
