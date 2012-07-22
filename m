From: will.deacon@arm.com (Will Deacon)
Date: Sun, 22 Jul 2012 16:08:11 +0100
Subject: [PATCH v2 05/15] ARM: integrator: use fixed PCI i/o mapping
In-Reply-To: <CAL_JsqJmN3+1Gb5dF+9eL5c742_-mzg61VcvYhEQpabh5VE=kg@mail.gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <5005A8A4.6040608@gmail.com>
 <20120721143122.GA26790@mudshark.cambridge.arm.com>
 <201207212156.43941.arnd@arndb.de>
 <CAL_JsqJmN3+1Gb5dF+9eL5c742_-mzg61VcvYhEQpabh5VE=kg@mail.gmail.com>
Message-ID: <20120722150811.GA29535@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2012 at 02:09:23PM +0100, Rob Herring wrote:
> On Jul 21, 2012 5:56 PM, "Arnd Bergmann" <arnd at arndb.de<mailto:arnd@arndb.de>> wrote:
> > On Saturday 21 July 2012, Will Deacon wrote:
> > > I dusted off the integrator, but I'm failing to boot at all if I build from
> > > that branch:
> > >
> > >       Uncompressing Linux... done, booting the kernel.
> > >       <silence>
> > >
> > > Using the same .config, I can boot v3.5-rc7 just fine (I even rebased your
> > > branch onto that in case something had been fixed in mainline, but it made
> > > no difference).
> >
> > I've looked at integrator_defconfig, and could not find any code that
> > actually uses the PIO accessors. Is your configuration different to that?
> > Do you actually have PCI enabled and present on the machine? Do things
> > change if you turn PCI off?

I have PCI up and running, yes, but all I use it for is an Intel e100
ethernet card which isn't required for booting. Disabling PCI makes no
difference, but see below.

> Could be overlapping static mappings. I manually checked that, but may have missed something.
> 
> Can you turn on earlyprintk?

I had that turned on already... after banging my head against a wall, I
realised that increasing the baudrate in u-boot (I have to use ymodem to
transfer the kernel image...) kills the serial console completely when
booting Linux if I forget to change it back.

With that observation, I see booting get stuck:


Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.5.0-rc6-00017-g52f1412 (will at tiny-lites) (gcc version 4.5.3 (Gent2
[    0.000000] CPU: ARM926EJ-S [41069263] revision 3 (ARMv5TEJ), cr=00053177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: ARM-Integrator
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c04ad1f0, node_mem_map c04c9000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32512 pages, LIFO batch:7
[    0.000000] CPU: found DTCM0 32k @ 00000000, not enabled
[    0.000000] CPU: moved DTCM0 32k to fffe8000, enabled
[    0.000000] CPU: found ITCM0 32k @ 00000000, not enabled
[    0.000000] CPU: moved ITCM0 32k to fffe0000, enabled
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: console=ttyAM0 mem=128M earlyprintk debug user_debug=31 logl9
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Memory: 124968k/124968k available, 6104k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     DTCM    : 0xfffe8000 - 0xffff0000   (  32 kB)
[    0.000000]     ITCM    : 0xfffe0000 - 0xfffe8000   (  32 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc036e9b0   (3483 kB)
[    0.000000]       .init : 0xc036f000 - 0xc048e7a4   (1150 kB)
[    0.000000]       .data : 0xc0490000 - 0xc04ad920   ( 119 kB)
[    0.000000]        .bss : 0xc04ae024 - 0xc04c86b4   ( 106 kB)
[    0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:16 nr_irqs:34 34
[    0.000000] FPGA IRQ chip 0 "SC" @ f1400000, 22 irqs
[    0.000000] sched_clock: 16 bits at 1500kHz, resolution 666ns, wraps every 43ms


Now, the next line is usually when the VGA text console is poked. Sure
enough, disabling that (CONFIG_VGA_CONSOLE) is enough to boot with your
patches and PCI appears to work correctly (I can do basic networking).

I guess there's some mapping race with the VGA code since vga_base =
PCI_MEMORY_VADDR, but you left the static mapping alone for that region,
so I'm not sure. Any ideas?

Will
