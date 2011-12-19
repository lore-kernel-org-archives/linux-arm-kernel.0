From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Mon, 19 Dec 2011 21:39:16 +0000
Subject: Status of the following patch (clocksource sched_clock) ?
In-Reply-To: <20111219210438.GJ14542@n2100.arm.linux.org.uk>
References: <3E54258959B69E4282D79E01AB1F32B7249324@DFLE34.ent.ti.com>
 <20111219172557.GH14542@n2100.arm.linux.org.uk>
 <3E54258959B69E4282D79E01AB1F32B724934E@DFLE34.ent.ti.com>
 <20111219210438.GJ14542@n2100.arm.linux.org.uk>
Message-ID: <3E54258959B69E4282D79E01AB1F32B724963A@DFLE34.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

I am relatively new to this. Here is more explanation of the issue.

We have clocksource timer implemented using a 32bit hw timer which at 166.84MHz of the clock rate wraps around at approximately 25secs. Our platform uses the arch/arm/mach-davinci/time.c at http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=blob;f=arch/arm/mach-davinci/time.c;h=e1969ce904dc5b4de9ff8f0d44442175c7c2497f;hb=1ea6b8f48918282bdca0b32a34095504ee65bab5

In this file, sched_clock() is implemented to override the weak sched_clock() as 

unsigned long long notrace sched_clock(void) { 
      const cycle_t cyc = clocksource_davinci.read(&clocksource_davinci); 
      return clocksource_cyc2ns(cyc, clocksource_davinci.mult,
                                clocksource_davinci.shift);
} 

>> Let's get one thing straight - are you talking about clocksource
>> wrap-around or sched_clock wrap-around? 

I think the problem is both. The clocksource timer wraps-around and sched_clock() which just reads the timer count and returns also wrap around. 

Based on your previous response, I did some research and found arch/arm/kernel/sched_clock.c that seems to solve clocksource wraparound. So I have enabled HAVE_SCHED_CLOCK to pick this implementation in my build. Also I have modified arch/arm/mach-davinci/time.c to call init_sched_clock(), but I got a kernel crash when Linux booted up (given below). Looks like this has to happen early in the initialization (postcoreinit() ??) so that sched_init() can use this. In the above time.c, the timer gets initialized late in the boot up stage. Is my understanding correct?

Is there an example that I can use to implement a fix for this? Thanks in advance for your valuable time and suggestions.

Here is the log in case you are interested..

[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Memory: 126552k/126552k available, 4520k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xff000000 - 0xffe00000   (  14 MB)
[    0.000000]     vmalloc : 0xc8800000 - 0xfe600000   ( 862 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc02edf7c   (2968 kB)
[    0.000000]       .init : 0xc02ee000 - 0xc030a000   ( 112 kB)
[    0.000000]       .data : 0xc030a000 - 0xc032f600   ( 150 kB)
[    0.000000]        .bss : 0xc032f624 - 0xc03470d8   (  95 kB)
[    0.000000] SLUB: Genslabs=11, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.000000] pgd = c0004000
[    0.000000] [00000000] *pgd=00000000
[    0.000000] Internal error: Oops: 5 [#1] PREEMPT
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Not tainted  (3.1.0-00032-g5dc3d4f-dirty #4)
[    0.000000] PC is at sched_clock+0x1c/0x64
[    0.000000] LR is at 0x0
[    0.000000] pc : [<c001e034>]    lr : [<00000000>]    psr: 400001d3
[    0.000000] sp : c030bf90  ip : 00000000  fp : c030bfac
[    0.000000] r10: c0313030  r9 : c0311bf0  r8 : c032fcc0
[    0.000000] r7 : 00000000  r6 : 389fd980  r5 : c030dd48  r4 : 400001d3
[    0.000000] r3 : 00000000  r2 : c032f910  r1 : 00000000  r0 : c030dd48
[    0.000000] Flags: nZcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    0.000000] Control: 10c5287b  Table: 80004019  DAC: 00000015
[    0.000000] Process swapper (pid: 0, stack limit = 0xc030a2e8)
[    0.000000] Stack: (0xc030bf90 to 0xc030c000)
[    0.000000] bf80:                                     400001d3 c030dd48 389fd980 c030385c
[    0.000000] bfa0: c030a000 00000000 c030bfd4 c02f49fc c030c160 c032f640 c030515c c0305158
[    0.000000] bfc0: c030ed84 80004059 413fc082 00000000 00000000 c02ee650 c02ee2c0 00000000
[    0.000000] bfe0: 00000000 c030515c 00000000 10c52c79 c030c040 8000803c 00000000 00000000
[    0.000000] [<c001e034>] (sched_clock+0x1c/0x64) from [<c030385c>] (init_idle+0x3c/0xa0)
[    0.000000] [<c030385c>] (init_idle+0x3c/0xa0) from [<c02f49fc>] (sched_init+0x190/0x1ec)
[    0.000000] [<c02f49fc>] (sched_init+0x190/0x1ec) from [<c02ee650>] (start_kernel+0x150/0x2fc)
[    0.000000] [<c02ee650>] (start_kernel+0x150/0x2fc) from [<8000803c>] (0x8000803c)
[    0.000000] Code: e5931068 e5933064 e592e014 e592c010 (e7932001)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] [<c0018084>] (unwind_backtrace+0x0/0xec) from [<c021afdc>] (panic+0x6c/0x1a4)
[    0.000000] [<c021afdc>] (panic+0x6c/0x1a4) from [<c002b05c>] (do_exit+0x9c/0x6a0)
[    0.000000] [<c002b05c>] (do_exit+0x9c/0x6a0) from [<c001656c>] (die+0x1b8/0x1e0)
[    0.000000] [<c001656c>] (die+0x1b8/0x1e0) from [<c001b4e4>] (__do_kernel_fault+0x64/0x84)
[    0.000000] [<c001b4e4>] (__do_kernel_fault+0x64/0x84) from [<c021edcc>] (do_page_fault+0x2f0/0x314)
[    0.000000] [<c021edcc>] (do_page_fault+0x2f0/0x314) from [<c00084cc>] (do_DataAbort+0x34/0x94)
[    0.000000] [<c00084cc>] (do_DataAbort+0x34/0x94) from [<c021d558>] (__dabt_svc+0x38/0x60)
[    0.000000] Exception stack(0xc030bf48 to 0xc030bf90)
[    0.000000] bf40:                   c030dd48 00000000 c032f910 00000000 400001d3 c030dd48
[    0.000000] bf60: 389fd980 00000000 c032fcc0 c0311bf0 c0313030 c030bfac 00000000 c030bf90
[    0.000000] bf80: 00000000 c001e034 400001d3 ffffffff
[    0.000000] [<c021d558>] (__dabt_svc+0x38/0x60) from [<c001e034>] (sched_clock+0x1c/0x64)
[    0.000000] [<c001e034>] (sched_clock+0x1c/0x64) from [<c030385c>] (init_idle+0x3c/0xa0)
[    0.000000] [<c030385c>] (init_idle+0x3c/0xa0) from [<c02f49fc>] (sched_init+0x190/0x1ec)
[    0.000000] [<c02f49fc>] (sched_init+0x190/0x1ec) from [<c02ee650>] (start_kernel+0x150/0x2fc)
[    0.000000] [<c02ee650>] (start_kernel+0x150/0x2fc) from [<8000803c>] (0x8000803c)
Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 3.1.0-00032-g5dc3d4f (murali at murali-laptop) (gcc version 4.3.3 (Sourcery G+
+ Lite 2009q1-203) ) #6 PREEMPT Mon Dec 19 14:57:22 EST 2011
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c52c7b
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache

Murali Karicheri
Software Design Engineer
email: m-karicheri2 at ti.com


>> -----Original Message-----
>> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
>> Sent: Monday, December 19, 2011 4:05 PM
>> To: Karicheri, Muralidharan
>> Cc: linux-arm-kernel at lists.infradead.org
>> Subject: Re: Status of the following patch (clocksource sched_clock) ?
>> 
>> On Mon, Dec 19, 2011 at 05:29:49PM +0000, Karicheri, Muralidharan wrote:
>> > Russell,
>> >
>> > Thanks for responding.
>> >
>> > >>
>> > >> > Could someone tell me what is the status of this patch? I want to try
>> > >> > it on my target platform which is a davinci variant.
>> > >>
>> > >> Dead.
>> > >>
>> > >> Just make sure you use the sched_clock infrastructure already provided
>> > >> on ARM and provided you give it the correct information - and set it up
>> > >> early enough (in init_early) you will not have any sched_clock() wraps.
>> > >> This is because a timer will be set to automatically update things
>> > >> before any wrap occurs.
>> >
>> > Good to know that there is already support available to avoid
>> > clocksource wraparound. Could you point me to the code in kernel
>> > tree where this infrastructure is located and some sample code
>> > that implements it?
>> 
>> Let's get one thing straight - are you talking about clocksource
>> wrap-around or sched_clock wrap-around?
>> 
>> I interpreted you as referring to sched_clock wrap-around.
