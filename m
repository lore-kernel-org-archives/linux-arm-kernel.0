From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 28 Apr 2011 15:59:03 +1200
Subject: [PATCH 0/14] at91: factorize soc init and switch to early platform
In-Reply-To: <20110428024144.GJ29103@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<4DB886FD.7000209@bluewatersys.com>
	<20110428024144.GJ29103@game.jcrosoft.org>
Message-ID: <4DB8E607.1090807@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2011 02:41 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 09:13 Thu 28 Apr     , Ryan Mallon wrote:
>> On 04/26/2011 06:08 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> Hi,
>>>
>>> 	The following patch series start to factorize the soc init
>>> 	and switch gpio and timers to early platform
>>>
>>> 	diff stat on arm
>>>
>>> 	80 files changed, 1690 insertions(+), 2053 deletions(-)
>>
>> I finally had a chance to test this. On our Snapper 9G20 board
>> (AT91SAM9G20) the latest linux-next gives me:
>>
>> Starting kernel ...
>>
>> Uncompressing Linux... done, booting the kernel.
>> <5>Linux version 2.6.39-rc4-next-20110427+ (ryan at okiwi) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #850 Thu Apr 28 09:07:43 NZST 2011
>> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
>> CPU: VIVT data cache, VIVT instruction cache
>> Machine: Bluewater Systems Snapper 9260/9G20 module
>> Memory policy: ECC disabled, Data cache writeback
>> <0>Kernel panic - not syncing: Impossible to detect the CPU type
>> [<c002fb1c>] (unwind_backtrace+0x0/0xe4) from [<c0230820>] (panic+0x50/0x178)
>> [<c0230820>] (panic+0x50/0x178) from [<c000d414>] (at91_initialize+0x18/0x20)
>> [<c000d414>] (at91_initialize+0x18/0x20) from [<c000e298>] (snapper9260_map_io+0xc/0x5c)
>> [<c000e298>] (snapper9260_map_io+0xc/0x5c) from [<c000d0ec>] (paging_init+0x668/0x728)
>> [<c000d0ec>] (paging_init+0x668/0x728) from [<c000b5cc>] (setup_arch+0x39c/0x620)
>> [<c000b5cc>] (setup_arch+0x39c/0x620) from [<c000873c>] (start_kernel+0x6c/0x2c8)
>>
>>
>> I'll have a better look at this later to see if I can find the problem,
>> though I suspect the remapping of the AT91_DBGU location is to blame.
>> What platforms have you tested this on?
> I already found the issue and fix it
> 
>  git://github.com/at91linux/linux-2.6-at91.git test_cleanup

Okay, that is working a bit better, not quite booting yet, but a little
further along :-).

Couple of bugs I've noticed so far: In board-stamp9g20.c and
board-sam9g20ek.c you have missed the .init_irq initialisation change
for the first MACHINE_START. It causes a build failure if either of
these boards are included.

Also at91x40 (e.g. board-eb01.c) does not get converted? I don't known
anything about this SoC. Is this intentional?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
