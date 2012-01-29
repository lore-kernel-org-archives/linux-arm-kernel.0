From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 29 Jan 2012 15:33:35 +0100
Subject: [PATCH] ARM: ioremap: fix boundary check when reusing static
 mapping
In-Reply-To: <20120129141418.GD15455@n2100.arm.linux.org.uk>
References: <1327515419-14097-1-git-send-email-pawel.moll@arm.com>
 <alpine.LFD.2.02.1201251333230.2759@xanadu.home>
 <1327574142.2355.30.camel@hornet.cambridge.arm.com>
 <CAGhQ9Vzx9K3qvkEFv-YVsUAdMF4SC0t2dvuYaqfj2QtibBem7g@mail.gmail.com>
 <20120129001136.GB15455@n2100.arm.linux.org.uk>
 <CAGhQ9VxzFZ32P08RPx8us4fE8xO3prXpM-fdWcsWWjWub4eC=w@mail.gmail.com>
 <20120129131411.GC15455@n2100.arm.linux.org.uk>
 <CAGhQ9VwKoVz36EQJ1c2yTTY7NZjsJ9O-nQk-mTWW5nY4pZdMTA@mail.gmail.com>
 <20120129141418.GD15455@n2100.arm.linux.org.uk>
Message-ID: <CAGhQ9Vwh6TTeQ1qy_Mvou+XKJ4kkZE4dUZk+3CzS2g7TM7kTrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2012 at 3:14 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jan 29, 2012 at 02:22:17PM +0100, Joachim Eastwood wrote:
>> On Sun, Jan 29, 2012 at 2:14 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Sun, Jan 29, 2012 at 02:10:34PM +0100, Joachim Eastwood wrote:
>> >> On Sun, Jan 29, 2012 at 1:11 AM, Russell King - ARM Linux
>> >> <linux@arm.linux.org.uk> wrote:
>> >> > On Sat, Jan 28, 2012 at 11:55:19PM +0100, Joachim Eastwood wrote:
>> >> >> "ARM: 7304/1: ioremap: fix boundary check when reusing static mapping"
>> >> >> Commit: 3c424f359898aff48c3d5bed608ac706f8a528c3 in Linus master
>> >> >>
>> >> >> Breaks booting on my custom AT91RM9200 board.
>> >> >> There isn't any error messages or anything that indicates what goes
>> >> >> wrong it just stops after; Uncompressing Linux... done, booting the
>> >> >> kernel.
>> >> >
>> >> > Your best way of finding out what's going on is to enable:
>> >> >
>> >> > DEBUG_KERNEL
>> >> > DEBUG_LL
>> >> > EARLY_PRINTK
>> >> >
>> >> > and select the appropriate kernel low-level debugging port. ?That should
>> >> > show you what's going on.
>> >>
>> >> Sadly, it doesn't make a difference. Still no output.
>> >
>> > Sorry, I missed that you also need 'earlyprintk' or something like that
>> > on the command line. ?Alternatively, use the following patch, which IMHO
>> > is a lot less error prone:
>>
>> <snip patch>
>>
>> The patch did the job. Thanks.
>
> Thanks - digging through the AT91 code I can't see how this has happened.
> So, one more patch to add please:

Sure.

<snip patch>

Output w/patch:
<6>Booting Linux on physical CPU 0
<5>Linux version 3.3.0-rc1-mpa+ (subcon at archspace) (gcc version 4.3.3
(GCC) ) #180 PREEMPT Sun Jan 29 15:29:41 CET 2012
CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=c0007177
CPU: VIVT data cache, VIVT instruction cache
Machine: Phontech MPA 1600
Memory policy: ECC disabled, Data cache writeback
<6>AT91: Detected soc type: at91rm9200
<6>AT91: Detected soc subtype: Unknown
<6>AT91: sram at 0x200000 of 0x4000 mapped at 0xfef74000
<7>On node 0 totalpages: 16384
<7>free_area_init_node: node 0, pgdat c02c515c, node_mem_map c02d6000
<7>  Normal zone: 128 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 16256 pages, LIFO batch:3
<6>AT91: filled in soc subtype: at91rm9200 PQFP
Clocks: CPU 179 MHz, master 59 MHz, main 18.432 MHz
<1>ioremap: pfn=fffff phys=fffff000 offset=400 size=1000
<1>ioremap: area c3ffdfc0: phys_addr=200000 pfn=200 size=4000
<1>ioremap: found: addr fef74000 => fed73000 => fed73400
<6>gpiochip_add: registered GPIOs 0 to 31 on device: pioA
<1>ioremap: pfn=fffff phys=fffff000 offset=600 size=1000
<1>ioremap: area c3ffdfc0: phys_addr=200000 pfn=200 size=4000
<1>ioremap: found: addr fef74000 => fed73000 => fed73600
<6>gpiochip_add: registered GPIOs 32 to 63 on device: pioB
<1>ioremap: pfn=fffff phys=fffff000 offset=800 size=1000
<1>ioremap: area c3ffdfc0: phys_addr=200000 pfn=200 size=4000
<1>ioremap: found: addr fef74000 => fed73000 => fed73800
<6>gpiochip_add: registered GPIOs 64 to 95 on device: pioC
<1>Unable to handle kernel paging request at virtual address fed73444
<1>pgd = c0004000
<1>[fed73444] *pgd=00000000
<0>Internal error: Oops: 805 [#1] PREEMPT
<d>Modules linked in:
CPU: 0    Not tainted  (3.3.0-rc1-mpa+ #180)
PC is at at91_set_A_periph+0x50/0x78
LR is at at91_register_uart+0x54/0x1e8
pc : [<c0010c50>]    lr : [<c0293528>]    psr: 600000d3
sp : c02abf50  ip : fed73400  fp : c02abf5c
r10: 80000200  r9 : c0258fe4  r8 : c02bc8b4
r7 : c02a3570  r6 : c02ae848  r5 : 00000000  r4 : 00000000
r3 : 00000060  r2 : 40000000  r1 : 00000000  r0 : 0000001e
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: c000717f  Table: 20004000  DAC: 00000017
<0>Process swapper (pid: 0, stack limit = 0xc02aa270)
<0>Stack: (0xc02abf50 to 0xc02ac000)
<0>bf40:                                     c02abf74 c02abf60 c0293528 c0010c10
<0>bf60: c0356220 c02cc8c0 c02abf84 c02abf78 c0293bf0 c02934e4 c02abfc4 c02abf88
<0>bf80: c02901a4 c0293bd4 c0121c9c c0007177 41129200 c02a43f4 c02abfb4 00000001
<0>bfa0: c02ac010 c02a4bf8 c02ae7dc 20004000 41129200 202a353c c02abff4 c02abfc8
<0>bfc0: c028d624 c028fb4c 00000000 00000000 00000000 c02a47f4 c0007175 c02ac010
<0>bfe0: c02a4bf8 c02ae7dc 00000000 c02abff8 20008040 c028d5c0 00000000 00000000
Backtrace:
[<c0010c00>] (at91_set_A_periph+0x0/0x78) from [<c0293528>]
(at91_register_uart+0x54/0x1e8)
[<c02934d4>] (at91_register_uart+0x0/0x1e8) from [<c0293bf0>]
(mpa1600_init_early+0x2c/0x4c)
 r5:c02cc8c0 r4:c0356220
[<c0293bc4>] (mpa1600_init_early+0x0/0x4c) from [<c02901a4>]
(setup_arch+0x668/0x76c)
[<c028fb3c>] (setup_arch+0x0/0x76c) from [<c028d624>] (start_kernel+0x74/0x318)
[<c028d5b0>] (start_kernel+0x0/0x318) from [<20008040>] (0x20008040)
 r7:c02ae7dc r6:c02a4bf8 r5:c02ac010 r4:c0007175
<0>Code: e1a02312 e3510000 13a03064 03a03060 (e58c2044)
<4>---[ end trace 1b75b31a2719ed1c ]---
<0>Kernel panic - not syncing: Attempted to kill the idle task!


regards
Joachim Eastwood
