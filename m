From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Dec 2015 10:19:57 +0100
Subject: MP11 port
In-Reply-To: <CAMou_+dOdmxfsB9Xx1Kbci_uSoPpy-dBf9Ct7Ku+sJ1gE=r0mA@mail.gmail.com>
References: <CAMou_+dOdmxfsB9Xx1Kbci_uSoPpy-dBf9Ct7Ku+sJ1gE=r0mA@mail.gmail.com>
Message-ID: <CACRpkdYfQg1tFemWCK-CbWh2LyZpQG9Keh2xvLRwOQvX8SONcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ferrari,

sorry for not noticing your mail earlier. I am working on the ARM
RealView PB11MPCore reference platform. Currently I am migrating
it to make a clean device tree boot and document and standardize
all odd stuff.

You can always find my current patch stack and work setup here:
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-integrator.git/

Branch: realview-pb11mp

Clone it like this:
git clone git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
git checkout -b realview-pb11mp origin/realview-pb11mp

This .mak file shows how I build this kernel:
http://dflund.se/~triad/krad/makefiles/realview.mak

See if it makes sense to you. It may be reasonable for you to work
on a device tree based boot from day one, using a recent development
kernel (it's what I would do). A bunch of the patches are going
upstream for v4.5 around the turn of the year. (I am busy funneling
patches to the tree through ARM SoC).

On Sun, Nov 24, 2013 at 7:36 PM, Ferrari Dante L?szl?
<dante.ferrari@gmail.com> wrote:

> I am quite new to the ARM world, and hope that you will have the
> patience to help me out with my question. I would like to start a
> basic kernel on an MP11 platform with only 6MB of RAM.

Jesus Christ. Well you may be able to start the kernel, but I'm
suspcious about how much userspace you will have with that.
But I guess you can get a busybox prompt with a rootfs on
flash or SD card or so.

> Short term goal
> would be to initialize a basic serial console. For booting i use the
> ATAG method, initrd and cosole is not set.

Yeah that's how you should start. It's pretty cool that you
already have console and everything.

>I have a problem when the
> GIC is switched on, from __log_buf I can get some info about the state
> of the booting procedure.
>
> Booting Linux on physical CPU 0x0
> Linux version 3.12.0-01915-g6c86ae2-dirty (dante at dante-Latitude-D620)

The kernel developers use Torvald's HEAD for all development.
In this case I'd recommend you to check if maybe you want
to use my patch stack as base and boot from DT for the moment.

> (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #9 Thu Nov 21
> 16:29:14 CET 2013
> CPU: ARMv6-compatible processor [410fb026] revision 6 (ARMv7), cr=08c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine: ARM-RealView PB11MPCore

Oh now you aren't :)

If you create a special stripped-down device tree file based on mine
I think you will have an easier time getting things up.

> Memory policy: ECC disabled, Data cache writeback
> On node 0 totalpages: 1280
> free_area_init_node: node 0, pgdat c033025c, node_mem_map c034c000
>   Normal zone: 10 pages used for memmap
>   Normal zone: 0 pages reserved
>   Normal zone: 1280 pages, LIFO batch:0
> sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
> pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> pcpu-alloc: [0] 0
> Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 1270
> Kernel command line:
> PID hash table entries: 32 (order: -5, 128 bytes)
> Dentry cache hash table entries: 1024 (order: 0, 4096 bytes)
> Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Memory: 1612K/5120K available (2327K kernel code, 146K rwdata, 652K
> rodata, 105K init, 108K bss, 3508K reserved)
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
>     lowmem  : 0xc0000000 - 0xc0500000   (   5 MB)
>     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>       .text : 0xc0008000 - 0xc02f0f34   (2980 kB)
>       .init : 0xc02f1000 - 0xc030b460   ( 106 kB)
>       .data : 0xc030c000 - 0xc0330980   ( 147 kB)
>        .bss : 0xc0330980 - 0xc034b9bc   ( 109 kB)
> NR_IRQS:160
> GIC CPU mask not found - kernel will fail to boot.
> GIC CPU mask not found - kernel will fail to boot.
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic.c:809
> gic_init_bases+0x120/0x348()
> Cannot allocate irq_descs @ IRQ64, assuming pre-allocated
>
>
>
> Then I realized I need to modify
>
> gic_init_irq
>
>   at arch/arm/mach-realview/realview_pb11mp.c
>
> so that the GIC distributor and CPU interface address maps statically
> from virtual address using the
>
> realview_pb11mp_map_io
>
>  function but with my boards CPUs address.

It's not about the CPU, it is really the GIC.

That's not the only thing you need to change. If you're using my
DT-based boot you can copy and go over the .dts file and modify
all special things.

The GIC in the ARM PB11MPCore is really a special case,
which is why I had to send patches like these:
http://marc.info/?l=devicetree&m=144563857119888&w=2
http://marc.info/?l=linux-kernel&m=144563858919892&w=2
http://marc.info/?l=linux-kernel&m=144563860119896&w=2

I doubt that your system has this weirdo "new mode vs
dcc mode" but if it does, yeah then it needs the same fix.
But in that case, the setting for the NEW/DCC mode is
likely in a totally different register. So you really need to
check on documentation and figure out what's going on here.

Do you really have a cascaded GIC on your system for example?
The PB11MPCore has two GICs, but I doubt that any
special purpose silicon would have that.

>  However it prints: ' BUG not creating mapping for 0x0c001000 at 0x0c001000
>  in user region. This is the location of my mach specific GIC
> distributor. What am I doing wrong?

I recommend if you use my base and just edit the device tree
instead, else you need to send the diffs/patches you're working
on. Appending RFC: in front so noone think it's proposed for
kernel inclusion.

Yours,
Linus Wallij
