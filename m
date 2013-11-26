From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 26 Nov 2013 14:40:40 +0000
Subject: MP11 port
In-Reply-To: <CAMou_+dOdmxfsB9Xx1Kbci_uSoPpy-dBf9Ct7Ku+sJ1gE=r0mA@mail.gmail.com>
References: <CAMou_+dOdmxfsB9Xx1Kbci_uSoPpy-dBf9Ct7Ku+sJ1gE=r0mA@mail.gmail.com>
Message-ID: <20131126144035.GA2355@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 24, 2013 at 07:36:18PM +0100, Ferrari Dante L?szl? wrote:
> Dear Developers,
> 
> I am quite new to the ARM world, and hope that you will have the
> patience to help me out with my question. I would like to start a
> basic kernel on an MP11 platform with only 6MB of RAM. Short term goal
> would be to initialize a basic serial console. For booting i use the
> ATAG method, initrd and cosole is not set. I have a problem when the
> GIC is switched on, from __log_buf I can get some info about the state
> of the booting procedure.
> 
> 
> Booting Linux on physical CPU 0x0
> Linux version 3.12.0-01915-g6c86ae2-dirty (dante at dante-Latitude-D620)
> (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #9 Thu Nov 21
> 16:29:14 CET 2013
> CPU: ARMv6-compatible processor [410fb026] revision 6 (ARMv7), cr=08c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine: ARM-RealView PB11MPCore
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
> 
>  However it prints: ' BUG not creating mapping for 0x0c001000 at 0x0c001000
>  in user region. This is the location of my mach specific GIC
> distributor. What am I doing wrong?

It's not clear what you're trying to do here.

Which board are you using?  Is it definitely RealView PB11MPCore?  Or is
that just a similar platform you're using as a starting point?

What config are you using?  Did you start with realview-smp_defconfig or
realview_defconfig?

If you're using a standard board, why do you need to modify the code, and
why would you have different addresses?

Cheers
---Dave
