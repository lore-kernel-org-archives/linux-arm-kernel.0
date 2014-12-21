From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 21 Dec 2014 11:29:25 +0100
Subject: kernel.org - master not booting on keystone (ARM v7 Cortex A15
 SoC) EVMs
In-Reply-To: <5494B932.6060602@ti.com>
References: <549490D6.3090804@ti.com> <20141219211816.GH10857@pengutronix.de>
 <CANMBJr5T6SJFiw4HwvK0cfJsyrM8WTPU6_aK0uzznEV4Mqcg3w@mail.gmail.com>
 <5494B932.6060602@ti.com>
Message-ID: <20141221102925.GJ10857@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I cannot say anything here, but maybe the people being involved in
1e6b48116a950 can. I added them to Cc and didn't trim the mail for them.

Best regards
Uwe

On Fri, Dec 19, 2014 at 06:48:02PM -0500, Murali Karicheri wrote:
> On 12/19/2014 04:25 PM, Tyler Baker wrote:
> >Hello,
> >
> >On 19 December 2014 at 13:18, Uwe Kleine-K?nig
> ><u.kleine-koenig@pengutronix.de>  wrote:
> >>Hello,
> >>
> >>On Fri, Dec 19, 2014 at 03:55:50PM -0500, Murali Karicheri wrote:
> >>>I have pulled the latest master from
> >>>git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git and
> >>>tried booting on keystone k2hk and k2e EVM. The boot hangs with
> >>>following log. Has anyone seen this? Keystone is an ARM v7 cortex
> >>>A15 SMP platform. I am assuming master branch is broken for ARM v7
> >>>and someone is working to address this. v3.18 booted up fine on my
> >>>EVM.
> >>>
> >>>Any idea?
> >>You forgot to attach the log?! So no, I don't have any idea. Did you
> >>bisect?
> 
> This was my first git bisect work. git bisect showed me below commit
> as bad commit. But it is pretty old commit. I tried reverting the
> commit and my board booted up fine. The boot log attached below. I
> did following until I got the bad commit. v3.18 also worked fine.
> 
> git bisect start
> git bisect good <working commit>
> git bisect bad <non working commit>
> 
> I build and test. If boots fine, I did git bisect good and if not,
> git bisect bad until I got the bad commit. Can someone comment if my
> bisect steps look sane? If so, what is wrong with the below commit?
> Ours is a LPAE SoC.
> 
> commit 1e6b48116a95046ec51f3d40f83aff8b006674d7
> Author: Kees Cook <keescook@chromium.org>
> Date:   Thu Apr 3 17:28:11 2014 -0700
> 
>     ARM: mm: allow non-text sections to be non-executable
> 
>     Adds CONFIG_ARM_KERNMEM_PERMS to separate the kernel memory regions
>     into section-sized areas that can have different permisions. Performs
>     the NX permission changes during free_initmem, so that init
> memory can be
>     reclaimed.
> 
>     This uses section size instead of PMD size to reduce memory lost to
>     padding on non-LPAE systems.
> 
>     Based on work by Brad Spengler, Larry Bassel, and Laura Abbott.
> 
>     Signed-off-by: Kees Cook <keescook@chromium.org>
>     Tested-by: Laura Abbott <lauraa@codeaurora.org>
>     Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> Bytes transferred = 3934208 (3c0800 hex)
> ## installed monitor, freq [208333333], status 0
> ## Booting kernel from Legacy Image at 88000000 ...
>    Image Name:   Linux-3.18.0-11757-gd790be3-dirt
>    Created:      2014-12-19  23:14:58 UTC
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    3934144 Bytes = 3.8 MiB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
> ## Flattened Device Tree blob at 87000000
>    Booting using the fdt blob at 0x87000000
>    Loading Kernel Image ... OK
>    Using Device Tree in place at 87000000, end 8700781d
> 
> Starting kernel ...
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.18.0-11757-gd790be3-dirty
> (a0868495 at ares-ubuntu) (gcc version 4.7.3 20130226 (prerelease)
> (crosstool-NG linaro-1.13.1-4.7-2013.03-20130313 - Linaro GCC
> 2013.03) ) #16 SMP PREEMPT Fri Dec 19 18:14:46 EST 2014
> [    0.000000] CPU: ARMv7 Processor [412fc0f4] revision 4 (ARMv7),
> cr=30c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT
> instruction cache
> [    0.000000] Machine model: Texas Instruments Keystone 2 Edison EVM
> [    0.000000] Switching to high address space at 0x800000000
> [    0.000000] WARNING: unsafe modification of in-place page tables
> - tainting kernel
> [    0.000000] cma: Reserved 16 MiB at 0x000000085f000000
> [    0.000000] Forcing write-allocate cache policy for SMP
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] On node 0 totalpages: 917504
> [    0.000000] free_area_init_node: node 0, pgdat c078c240,
> node_mem_map ed7f9000
> [    0.000000]   DMA zone: 1520 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 194560 pages, LIFO batch:31
> [    0.000000]   HighMem zone: 722944 pages, LIFO batch:31
> [    0.000000] PERCPU: Embedded 10 pages/cpu @ed7b2000 s12096 r8192
> d20672 u40960
> [    0.000000] pcpu-alloc: s12096 r8192 d20672 u40960 alloc=10*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping
> on. Total pages: 915984
> [    0.000000] Kernel command line: console=ttyS0,115200n8
> rootwait=1 clk_ignore_unused debug earlyprintk rdinit=/sbin/init rw
> root=/dev/ram0 initrd=0x802000000,9M
> [    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
> [    0.000000] log_buf_len total cpu_extra contributions: 12288 bytes
> [    0.000000] log_buf_len min size: 16384 bytes
> [    0.000000] log_buf_len: 32768 bytes
> [    0.000000] early log buf free: 14536(88%)
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7,
> 524288 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6,
> 262144 bytes)
> [    0.000000] Memory: 3606688K/3670016K available (5220K kernel
> code, 288K rwdata, 1888K rodata, 315K init, 174K bss, 46944K
> reserved, 16384K cma-reserved, 2875392K highmem)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc06f95bc   (7110 kB)
> [    0.000000]       .init : 0xc06fa000 - 0xc0748f40   ( 316 kB)
> [    0.000000]       .data : 0xc074a000 - 0xc079217c   ( 289 kB)
> [    0.000000]        .bss : 0xc079217c - 0xc07bdaa0   ( 175 kB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] Architected cp15 timer(s) running at 208.33MHz (virt).
> [    0.000003] sched_clock: 56 bits at 208MHz, resolution 4ns, wraps
> every 2638828011520ns
> [    0.000011] Switching to timer-based delay loop, resolution 4ns
> [    0.000122] keystone timer clock @208333333 Hz
> [    0.000219] Console: colour dummy device 80x30
> [    0.000234] Calibrating delay loop (skipped), value calculated
> using timer frequency.. 416.66 BogoMIPS (lpj=2083333)
> [    0.000244] pid_max: default: 4096 minimum: 301
> [    0.000306] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.000314] Mountpoint-cache hash table entries: 2048 (order: 1,
> 8192 bytes)
> [    0.000680] CPU: Testing write buffer coherency: ok
> [    0.000824] /cpus/cpu at 0 missing clock-frequency property
> [    0.000838] /cpus/cpu at 1 missing clock-frequency property
> [    0.000851] /cpus/cpu at 2 missing clock-frequency property
> [    0.000865] /cpus/cpu at 3 missing clock-frequency property
> [    0.000874] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.000914] Setting up static identity map for 0x804f3760 - 0x804f3794
> [    0.139325] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.229428] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
> [    0.319532] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
> [    0.319599] Brought up 4 CPUs
> [    0.319613] CPU: All CPU(s) started in SVC mode.
> [    0.320333] VFP support v0.3: implementor 41 architecture 4 part
> 30 variant f rev 0
> [    0.324330] NET: Registered protocol family 16
> [    0.325137] DMA: preallocated 256 KiB pool for atomic coherent
> allocations
> [    0.330901] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4
> watchpoint registers.
> [    0.330908] hw-breakpoint: maximum watchpoint size is 8 bytes.
> [    0.339937] vgaarb: loaded
> [    0.340214] SCSI subsystem initialized
> [    0.340617] usbcore: registered new interface driver usbfs
> [    0.340696] usbcore: registered new interface driver hub
> [    0.340790] usbcore: registered new device driver usb
> [    0.342609] Switched to clocksource arch_sys_counter
> [    0.364910] NET: Registered protocol family 2
> [    0.365338] TCP established hash table entries: 8192 (order: 3,
> 32768 bytes)
> [    0.365389] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.365494] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.365531] TCP: reno registered
> [    0.365540] UDP hash table entries: 512 (order: 2, 16384 bytes)
> [    0.365565] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
> [    0.365699] NET: Registered protocol family 1
> [    0.365857] RPC: Registered named UNIX socket transport module.
> [    0.365864] RPC: Registered udp transport module.
> [    0.365869] RPC: Registered tcp transport module.
> [    0.365874] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.365889] PCI: CLS 0 bytes, default 64
> [    0.366023] Unpacking initramfs...
> [    0.797798] Freeing initrd memory: 9216K (c2000000 - c2900000)
> [    0.797991] hw perfevents: enabled with armv7_cortex_a15 PMU
> driver, 7 counters available
> [    0.798630] platform alarmtimer: set dma_pfn_offset00780000
> [    0.799270] futex hash table entries: 16 (order: -2, 1024 bytes)
> [    0.810620] Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
> [    0.810718] ntfs: driver 2.1.31 [Flags: R/O].
> [    0.811058] jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
> [    0.812696] NET: Registered protocol family 38
> [    0.812765] bounce: pool size: 64 pages
> [    0.812992] Block layer SCSI generic (bsg) driver version 0.4
> loaded (major 253)
> [    0.813006] io scheduler noop registered
> [    0.813018] io scheduler deadline registered
> [    0.813197] io scheduler cfq registered (default)
> [    0.813333] keystone_irq soc:keystone_irq at 26202a0: irqchip
> registered, nr_irqs 28
> [    0.813480] gpio-syscon soc:keystone_dsp_gpio at 02620240: can't
> read the dir register offset!
> [    0.814272] keystone-pcie 21801000.pcie: missing *config* reg space
> [    1.014637] keystone-pcie 21801000.pcie: phy link never came up
> [    1.014853] keystone-pcie 21801000.pcie: PCI host bridge to bus 0000:00
> [    1.014865] pci_bus 0000:00: root bus resource [io  0x1000-0x3fff]
> [    1.014874] pci_bus 0000:00: root bus resource [mem
> 0x50000000-0x5fffffff]
> [    1.014883] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    1.014913] pci 0000:00:00.0: [104c:b009] type 01 class 0x060400
> [    1.015180] PCI: bus0: Fast back to back transfers disabled
> [    1.015324] PCI: bus1: Fast back to back transfers enabled
> [    1.015334] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> [    1.015389] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    1.015599] pcieport 0000:00:00.0: Signaling PME through PCIe PME
> interrupt
> [    1.015610] pcie_pme 0000:00:00.0:pcie01: service driver pcie_pme loaded
> [    1.015736] aer 0000:00:00.0:pcie02: service driver aer loaded
> [    1.016058] keystone-pcie 21021000.pcie: missing *config* reg space
> [    1.016075] Requested IO range too big, new size set to 64K
> [    1.215646] keystone-pcie 21021000.pcie: phy link never came up
> [    1.215857] keystone-pcie 21021000.pcie: PCI host bridge to bus 0001:00
> [    1.215867] pci_bus 0001:00: root bus resource [io
> 0x10000-0xfffff] (bus address [0x0000-0xeffff])
> [    1.215876] pci_bus 0001:00: root bus resource [mem
> 0x60000000-0x6fffffff]
> [    1.215884] pci_bus 0001:00: root bus resource [bus 00-ff]
> [    1.215910] pci 0001:00:00.0: [104c:b009] type 01 class 0x060400
> [    1.216162] PCI: bus0: Fast back to back transfers disabled
> [    1.216313] PCI: bus1: Fast back to back transfers enabled
> [    1.216322] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
> [    1.216378] pci 0001:00:00.0: PCI bridge to [bus 01]
> [    1.216578] pcieport 0001:00:00.0: Signaling PME through PCIe PME
> interrupt
> [    1.216588] pcie_pme 0001:00:00.0:pcie01: service driver pcie_pme loaded
> [    1.216712] aer 0001:00:00.0:pcie02: service driver aer loaded
> [    1.256740] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    1.256825] platform serial8250: set dma_pfn_offset00780000
> [    1.257936] console [ttyS0] disabled
> [    1.257993] of_serial 2530c00.serial: ttyS0 at MMIO 0x2530c00
> (irq = 26, base_baud = 13020833) is a 16550A
> [    2.082903] console [ttyS0] enabled
> [    2.086928] of_serial 2531000.serial: ttyS1 at MMIO 0x2531000
> (irq = 27, base_baud = 13020833) is a 16550A
> [    2.099328] loop: module loaded
> [    2.102592] at24 0-0050: 131072 byte 24c1024 EEPROM, writable, 1
> bytes/write
> [    2.114188] m25p80 spi32766.0: n25q128a11 (16384 Kbytes)
> [    2.119507] 2 ofpart partitions found on MTD device spi32766.0
> [    2.125340] Creating 2 MTD partitions on "spi32766.0":
> [    2.130472] 0x000000000000-0x000000080000 : "u-boot-spl"
> [    2.136411] 0x000000080000-0x000001000000 : "misc"
> [    2.141765] spi_davinci 21000400.spi: Controller at 0xf014a400
> [    2.147931] spi_davinci 21000600.spi: Controller at 0xf014c600
> [    2.154096] spi_davinci 21000800.spi: Controller at 0xf014e800
> [    2.360911] dwc3 2690000.dwc3: No power optimization available
> [    2.366743] dwc3 2690000.dwc3: found 16 IN and 16 OUT endpoints
> [    2.572689] dwc3 2690000.dwc3: Event buf ec9c1000 dma ac9c1000 length 256
> [    2.579469] dwc3 2690000.dwc3: Event buf ec9c2000 dma ac9c2000 length 256
> [    2.586254] dwc3 2690000.dwc3: Event buf ec9c3000 dma ac9c3000 length 256
> [    2.593039] dwc3 2690000.dwc3: Event buf ed164000 dma ad164000 length 256
> [    2.599819] dwc3 2690000.dwc3: Event buf ed166000 dma ad166000 length 256
> [    2.606603] dwc3 2690000.dwc3: Event buf ed167000 dma ad167000 length 256
> [    2.613387] dwc3 2690000.dwc3: Event buf ec82c000 dma ac82c000 length 256
> [    2.620166] dwc3 2690000.dwc3: Event buf ec82d000 dma ac82d000 length 256
> [    2.626951] dwc3 2690000.dwc3: Event buf ec82e000 dma ac82e000 length 256
> [    2.633735] dwc3 2690000.dwc3: Event buf ec82f000 dma ac82f000 length 256
> [    2.640514] dwc3 2690000.dwc3: Event buf ecb80000 dma acb80000 length 256
> [    2.647298] dwc3 2690000.dwc3: Event buf ecb81000 dma acb81000 length 256
> [    2.654083] dwc3 2690000.dwc3: Event buf ecb82000 dma acb82000 length 256
> [    2.660862] dwc3 2690000.dwc3: Event buf ecb83000 dma acb83000 length 256
> [    2.667647] dwc3 2690000.dwc3: Event buf ed34c000 dma ad34c000 length 256
> [    2.674430] dwc3 2690000.dwc3: Event buf ed34d000 dma ad34d000 length 256
> [    2.681274] platform xhci-hcd.0.auto: set dma_pfn_offset00780000
> [    2.887719] dwc3 25010000.dwc3: No power optimization available
> [    2.893637] dwc3 25010000.dwc3: found 16 IN and 16 OUT endpoints
> [    3.099664] dwc3 25010000.dwc3: Event buf ecbd0000 dma acbd0000
> length 256
> [    3.106537] dwc3 25010000.dwc3: Event buf ecbd1000 dma acbd1000
> length 256
> [    3.113410] dwc3 25010000.dwc3: Event buf ecbd2000 dma acbd2000
> length 256
> [    3.120276] dwc3 25010000.dwc3: Event buf ecbd3000 dma acbd3000
> length 256
> [    3.127148] dwc3 25010000.dwc3: Event buf ec866000 dma ac866000
> length 256
> [    3.134019] dwc3 25010000.dwc3: Event buf ec867000 dma ac867000
> length 256
> [    3.140885] dwc3 25010000.dwc3: Event buf ecb74000 dma acb74000
> length 256
> [    3.147756] dwc3 25010000.dwc3: Event buf ecb75000 dma acb75000
> length 256
> [    3.154628] dwc3 25010000.dwc3: Event buf ed3d2000 dma ad3d2000
> length 256
> [    3.161495] dwc3 25010000.dwc3: Event buf ed3d3000 dma ad3d3000
> length 256
> [    3.168367] dwc3 25010000.dwc3: Event buf ec828000 dma ac828000
> length 256
> [    3.175239] dwc3 25010000.dwc3: Event buf ec829000 dma ac829000
> length 256
> [    3.182105] dwc3 25010000.dwc3: Event buf ed1da000 dma ad1da000
> length 256
> [    3.188975] dwc3 25010000.dwc3: Event buf ed1db000 dma ad1db000
> length 256
> [    3.195846] dwc3 25010000.dwc3: Event buf ed160000 dma ad160000
> length 256
> [    3.202716] dwc3 25010000.dwc3: Event buf ed161000 dma ad161000
> length 256
> [    3.209649] platform xhci-hcd.1.auto: set dma_pfn_offset00780000
> [    3.215984] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> [    3.221567] xhci-hcd xhci-hcd.0.auto: new USB bus registered,
> assigned bus number 1
> [    3.229502] xhci-hcd xhci-hcd.0.auto: irq 34, io mem 0x02690000
> [    3.235545] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [    3.242326] usb usb1: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    3.249552] usb usb1: Product: xHCI Host Controller
> [    3.254430] usb usb1: Manufacturer: Linux
> 3.18.0-11757-gd790be3-dirty xhci-hcd
> [    3.261643] usb usb1: SerialNumber: xhci-hcd.0.auto
> [    3.266901] hub 1-0:1.0: USB hub found
> [    3.270666] hub 1-0:1.0: 1 port detected
> [    3.274845] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> [    3.280445] xhci-hcd xhci-hcd.0.auto: new USB bus registered,
> assigned bus number 2
> [    3.288235] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
> [    3.295027] usb usb2: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    3.302240] usb usb2: Product: xHCI Host Controller
> [    3.307118] usb usb2: Manufacturer: Linux
> 3.18.0-11757-gd790be3-dirty xhci-hcd
> [    3.314340] usb usb2: SerialNumber: xhci-hcd.0.auto
> [    3.319582] hub 2-0:1.0: USB hub found
> [    3.323353] hub 2-0:1.0: 1 port detected
> [    3.327559] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
> [    3.333182] xhci-hcd xhci-hcd.1.auto: new USB bus registered,
> assigned bus number 3
> [    3.341014] xhci-hcd xhci-hcd.1.auto: irq 68, io mem 0x25010000
> [    3.347041] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
> [    3.353832] usb usb3: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    3.361045] usb usb3: Product: xHCI Host Controller
> [    3.365923] usb usb3: Manufacturer: Linux
> 3.18.0-11757-gd790be3-dirty xhci-hcd
> [    3.373836] usb usb3: SerialNumber: xhci-hcd.1.auto
> [    3.379079] hub 3-0:1.0: USB hub found
> [    3.382850] hub 3-0:1.0: 1 port detected
> [    3.387013] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
> [    3.392622] xhci-hcd xhci-hcd.1.auto: new USB bus registered,
> assigned bus number 4
> [    3.400399] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
> [    3.407189] usb usb4: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    3.414412] usb usb4: Product: xHCI Host Controller
> [    3.419282] usb usb4: Manufacturer: Linux
> 3.18.0-11757-gd790be3-dirty xhci-hcd
> [    3.427836] usb usb4: SerialNumber: xhci-hcd.1.auto
> [    3.433091] hub 4-0:1.0: USB hub found
> [    3.436850] hub 4-0:1.0: 1 port detected
> [    3.441197] usbcore: registered new interface driver usb-storage
> [    3.447572] mousedev: PS/2 mouse device common for all mice
> [    3.453353] i2c /dev entries driver
> [    3.457258] davinci-wdt 22f0080.wdt: heartbeat 60 sec
> [    3.462762] usbcore: registered new interface driver usbhid
> [    3.468325] usbhid: USB HID core driver
> [    3.472893] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xac
> [    3.479237] nand: Micron MT29F4G08ABBDAHC
> [    3.483945] nand: 512 MiB, SLC, erase size: 128 KiB, page size:
> 2048, OOB size: 64
> [    3.491793] Bad block table found at page 262080, version 0x01
> [    3.498135] Bad block table found at page 262016, version 0x01
> [    3.504281] 3 ofpart partitions found on MTD device 30000000.nand
> [    3.510365] Creating 3 MTD partitions on "30000000.nand":
> [    3.515765] 0x000000000000-0x000000100000 : "u-boot"
> [    3.521319] 0x000000100000-0x000000180000 : "params"
> [    3.526843] 0x000000180000-0x000020000000 : "ubifs"
> [    3.532529] davinci_nand 30000000.nand: controller rev. 2.5
> [    3.539597] platform oprofile-perf.0: set dma_pfn_offset00780000
> [    3.545733] oprofile: using timer interrupt.
> [    3.550019] Netfilter messages via NETLINK v0.30.
> [    3.554737] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
> [    3.561219] ctnetlink v0.93: registering with nfnetlink.
> [    3.566790] ipip: IPv4 over IPv4 tunneling driver
> [    3.571876] gre: GRE over IPv4 demultiplexor driver
> [    3.576762] ip_gre: GRE over IPv4 tunneling driver
> [    3.582421] ip_tables: (C) 2000-2006 Netfilter Core Team
> [    3.587816] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
> [    3.594195] arp_tables: (C) 2002 David S. Miller
> [    3.598847] TCP: cubic registered
> [    3.602157] Initializing XFRM netlink socket
> [    3.606965] NET: Registered protocol family 10
> [    3.612005] NET: Registered protocol family 17
> [    3.616472] NET: Registered protocol family 15
> [    3.620912] 8021q: 802.1Q VLAN Support v1.8
> [    3.626750] sctp: Hash tables configured (established 65536 bind 65536)
> [    3.633786] Registering SWP/SWPB emulation handler
> [    3.641684] clk: Not disabling unused clocks
> [    3.646516] Freeing unused kernel memory: 312K (c06fa000 - c0748000)
> INIT: version 2.88 booting
> Starting udev
> Starting Bootlog daemon: bootlogd.
> Configuring network interfaces... ifconfig: SIOCGIFFLAGS: No such device
> ifconfig: SIOCGIFFLAGS: No such device
> done.
> Mon Jul  8 13:27:00 UTC 2013
> Configuring update-modules.
> ERROR: could not open directory
> /lib/modules/3.18.0-11757-gd790be3-dirty: No such file or directory
> WARNING: -e needs -E or -F
> ERROR: could not open directory
> /lib/modules/3.18.0-11757-gd790be3-dirty: No such file or directory
> INIT: Entering runlevel: 5dules: No such file or direct
> Starting telnet daemon.
> Starting syslogd/klogd: done
> Starting thttpd.
> Stopping Bootlog daemon: bootlogd.
> 
>  _____                    _____           _         _
> |  _  |___ ___ ___ ___   |  _  |___ ___  |_|___ ___| |_
> |     |  _| .'| . | . |  |   __|  _| . | | | -_|  _|  _|
> |__|__|_| |__,|_  |___|  |__|  |_| |___|_| |___|___|_|
>               |___|                    |___|
> 
> Arago Project http://arago-project.org keystone-evm ttyS0
> 
> Arago 2013.04 keystone-evm ttyS0
> 
> keystone-evm login: root
> root at keystone-evm:~# uname -a
> Linux keystone-evm 3.18.0-11757-gd790be3-dirty #16 SMP PREEMPT Fri
> Dec 19 18:14:46 EST 2014 armv7l GNU/Linux
> root at keystone-evm:~#
> 
> 
> 
> 
> -- 
> Murali Karicheri
> Linux Kernel, Texas Instruments
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
