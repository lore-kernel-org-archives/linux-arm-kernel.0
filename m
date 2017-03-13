From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Mon, 13 Mar 2017 17:05:23 +0100
Subject: [PATCH 4/4] RFT: irqchip: replace moxa with ftintc010
In-Reply-To: <20170311231505.16056-1-linus.walleij@linaro.org>
References: <20170311231505.16056-1-linus.walleij@linaro.org>
Message-ID: <CACmBeS2rNKnJKsFXeqwuCO5YBgfO8Nv=Wr+cG8DS-gfpfsxENg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Jonas: it would be great if you could test this so we can unify the
> drivers.

Support for high/low and rising/falling edges was something I looked
at briefly but never upstreamed. Unifying the drivers now would indeed
be a good thing.

I've done the usual test on UC-7112-LX with the following patches
applied to next-20170310:

[2/4] irqchip: refactor Gemini driver to reflect Faraday origin
[3/4] irqchip: faraday: fix the trigger types
[4/4] RFT: irqchip: replace moxa with ftintc010

Log [1] is with MMC unavailable (another issue that needs a fix in DT)
and [2] when MMC is there.

I suspect some of the IRQ flags in arch/arm/boot/dts/moxart.dtsi may
not be set right / they don't match up against the "interrupt-mask"
property we probably want to get rid of. Any tips on what those flags
really should be?

[1] https://bitbucket.org/Kasreyn/linux-next/commits/e1c8e59aef885a157021091674aa617be7f42335
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.11.0-rc1-next-20170310-00003-ge1c8e59
(i at ildjarn) (gcc version 4.9.1 (crosstool-NG 1.20.0) ) #4433 PREEMPT
Mon Mar 13 16:23:10 CET 2017
[    0.000000] CPU: FA526 [66015261] revision 1 (ARMv4), cr=0000397f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] OF: fdt: Machine model: MOXA UC-7112-LX
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 8128
[    0.000000] Kernel command line: console=ttyS0,115200n8 earlyprintk
root=/dev/mmcblk0p1 rw rootwait
[    0.000000] PID hash table entries: 128 (order: -3, 512 bytes)
[    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Memory: 19288K/32768K available (3337K kernel code,
153K rwdata, 716K rodata, 196K init, 8581K bss, 13480K reserved, 0K
cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc2800000 - 0xff800000   ( 976 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
[    0.000000]       .text : 0xc0008000 - 0xc034a630   (3338 kB)
[    0.000000]       .init : 0xc0419000 - 0xc044a000   ( 196 kB)
[    0.000000]       .data : 0xc044a000 - 0xc0470620   ( 154 kB)
[    0.000000]        .bss : 0xc0470620 - 0xc0cd1d68   (8582 kB)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] RCU lockdep checking is enabled.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] clocksource: moxart_timer: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 39817925974 ns
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns,
wraps every 21474836475000000ns
[    0.020000] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.030000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.030000] ... MAX_LOCK_DEPTH:          48
[    0.040000] ... MAX_LOCKDEP_KEYS:        8191
[    0.040000] ... CLASSHASH_SIZE:          4096
[    0.040000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.050000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.050000] ... CHAINHASH_SIZE:          32768
[    0.060000]  memory used by lock dependency info: 5167 kB
[    0.070000]  per task-struct memory footprint: 1536 bytes
[    0.080000] kmemleak: Kernel memory leak detector disabled
[    0.100000] kmemleak: Early log buffer exceeded (1229), please
increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[    0.110000] Calibrating delay loop... 144.79 BogoMIPS (lpj=723968)
[    0.180000] pid_max: default: 4096 minimum: 301
[    0.190000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.200000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.220000] CPU: Testing write buffer coherency: ok
[    0.250000] Setting up static identity map for 0x8200 - 0x8248
[    0.320000] devtmpfs: initialized
[    0.390000] DMA-API: preallocated 4096 debug entries
[    0.390000] DMA-API: debugging enabled by kernel config
[    0.420000] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.440000] kworker/u2:0 (12) used greatest stack depth: 6224 bytes left
[    0.450000] futex hash table entries: 16 (order: -3, 704 bytes)
[    0.470000] NET: Registered protocol family 16
[    0.490000] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.530000] kworker/u2:1 (18) used greatest stack depth: 5856 bytes left
[    1.140000] clocksource: Switched to clocksource moxart_timer
[    1.220000] NET: Registered protocol family 2
[    1.240000] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    1.250000] TCP bind hash table entries: 1024 (order: 3, 36864 bytes)
[    1.260000] TCP: Hash tables configured (established 1024 bind 1024)
[    1.280000] UDP hash table entries: 128 (order: 1, 10240 bytes)
[    1.280000] UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
[    1.300000] NET: Registered protocol family 1
[    1.350000] workingset: timestamp_bits=30 max_order=13 bucket_order=0
[    1.780000] jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
[    1.890000] io scheduler noop registered
[    1.900000] io scheduler cfq registered (default)
[    1.910000] io scheduler mq-deadline registered
[    1.950000] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled
[    2.020000] console [ttyS0] disabled
[    2.030000] 98200000.uart: ttyS0 at MMIO 0x98200000 (irq = 21,
base_baud = 921600) is a 16550A
[    2.040000] console [ttyS0] enabled
[    2.040000] console [ttyS0] enabled
[    2.050000] bootconsole [earlycon0] disabled
[    2.050000] bootconsole [earlycon0] disabled
[    2.120000] 80000000.flash: Found 1 x16 devices at 0x0 in 16-bit
bank. Manufacturer ID 0x000089 Chip ID 0x000018
[    2.140000] Intel/Sharp Extended Query Table at 0x0031
[    2.140000] Intel/Sharp Extended Query Table at 0x0031
[    2.150000] Using buffer write method
[    2.150000] cfi_cmdset_0001: Erase suspend on write enabled
[    2.160000] 4 ofpart partitions found on MTD device 80000000.flash
[    2.170000] Creating 4 MTD partitions on "80000000.flash":
[    2.170000] 0x000000000000-0x000000040000 : "bootloader"
[    2.230000] 0x000000040000-0x000000200000 : "linux kernel"
[    2.280000] 0x000000200000-0x000000a00000 : "root filesystem"
[    2.320000] 0x000000a00000-0x000001000000 : "user filesystem"
[    2.540000] random: fast init done
[    3.040000] libphy: MOXA ART Ethernet MII: probed
[    3.720000] libphy: MOXA ART Ethernet MII: probed
[    3.760000] libphy: Fixed MDIO Bus: probed
[    3.880000] moxart-rtc 90000000.soc:rtc: rtc core: registered
90000000.soc:rtc as rtc0
[    3.940000] sdhci: Secure Digital Host Controller Interface driver
[    3.950000] sdhci: Copyright(c) Pierre Ossman
[    3.960000] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.000000] NET: Registered protocol family 17
[    4.070000] console [netcon0] enabled
[    4.080000] netconsole: network logging started
[    4.090000] moxart-rtc 90000000.soc:rtc: setting system clock to
2017-03-13 15:24:20 UTC (1489418660)
[    4.470000] random: crng init done
[    6.880000] irq 21: nobody cared (try booting with the "irqpoll" option)
[    6.880000] CPU: 0 PID: 1 Comm: swapper Not tainted
4.11.0-rc1-next-20170310-00003-ge1c8e59 #4433
[    6.880000] Hardware name: Generic DT based system
[    6.880000] [<c000f2e4>] (unwind_backtrace) from [<c000d7d8>]
(show_stack+0x10/0x14)
[    6.880000] [<c000d7d8>] (show_stack) from [<c0053900>]
(__report_bad_irq+0x24/0xc0)
[    6.880000] [<c0053900>] (__report_bad_irq) from [<c0053c48>]
(note_interrupt+0x240/0x2a4)
[    6.880000] [<c0053c48>] (note_interrupt) from [<c005186c>]
(handle_irq_event_percpu+0x44/0x54)
[    6.880000] [<c005186c>] (handle_irq_event_percpu) from
[<c00518b4>] (handle_irq_event+0x38/0x5c)
[    6.880000] [<c00518b4>] (handle_irq_event) from [<c0054794>]
(handle_level_irq+0x9c/0x14c)
[    6.880000] [<c0054794>] (handle_level_irq) from [<c0050ffc>]
(generic_handle_irq+0x20/0x34)
[    6.880000] [<c0050ffc>] (generic_handle_irq) from [<c0051058>]
(__handle_domain_irq+0x48/0xa8)
[    6.880000] [<c0051058>] (__handle_domain_irq) from [<c00093f4>]
(ft010_irqchip_handle_irq+0x74/0x90)
[    6.880000] [<c00093f4>] (ft010_irqchip_handle_irq) from
[<c000e200>] (__irq_svc+0x60/0x98)
[    6.880000] Exception stack(0xc1825b68 to 0xc1825bb0)
[    6.880000] 5b60:                   00000001 c18283f8 00000000
60000053 00000000 00000002
[    6.880000] 5b80: 00000000 00000001 c180a000 c1824000 60000053
00000000 c05a8698 c1825bb8
[    6.880000] 5ba0: c0046c04 c001a694 60000053 ffffffff
[    6.880000] [<c000e200>] (__irq_svc) from [<c001a694>]
(__do_softirq+0xb0/0x2d8)
[    6.880000] [<c001a694>] (__do_softirq) from [<c001ac4c>]
(irq_exit+0xe4/0x134)
[    6.880000] [<c001ac4c>] (irq_exit) from [<c0051060>]
(__handle_domain_irq+0x50/0xa8)
[    6.880000] [<c0051060>] (__handle_domain_irq) from [<c00093f4>]
(ft010_irqchip_handle_irq+0x74/0x90)
[    6.880000] [<c00093f4>] (ft010_irqchip_handle_irq) from
[<c000e200>] (__irq_svc+0x60/0x98)
[    6.880000] Exception stack(0xc1825c28 to 0xc1825c70)
[    6.880000] 5c20:                   00000001 c18283f8 00000000
c1828000 60000053 c18eb15c
[    6.880000] 5c40: 00000015 00000000 c18eb15c c18eb134 60000053
00000000 c05a8698 c1825c78
[    6.880000] 5c60: c0046c04 c0349d50 20000053 ffffffff
[    6.880000] [<c000e200>] (__irq_svc) from [<c0349d50>]
(_raw_spin_unlock_irqrestore+0x70/0x74)
[    6.880000] [<c0349d50>] (_raw_spin_unlock_irqrestore) from
[<c0052b68>] (__setup_irq+0x350/0x5e4)
[    6.880000] [<c0052b68>] (__setup_irq) from [<c0053118>]
(request_threaded_irq+0xd8/0x188)
[    6.880000] [<c0053118>] (request_threaded_irq) from [<c0225ebc>]
(univ8250_setup_irq+0x1e8/0x23c)
[    6.880000] [<c0225ebc>] (univ8250_setup_irq) from [<c0229230>]
(serial8250_do_startup+0x18c/0x6fc)
[    6.880000] [<c0229230>] (serial8250_do_startup) from [<c0223244>]
(uart_startup.part.0+0x7c/0x174)
[    6.880000] [<c0223244>] (uart_startup.part.0) from [<c021e970>]
(tty_port_open+0x94/0xe4)
[    6.880000] [<c021e970>] (tty_port_open) from [<c0222ee4>]
(uart_open+0x30/0x38)
[    6.880000] [<c0222ee4>] (uart_open) from [<c02173d4>] (tty_open+0xc0/0x4d8)
[    6.880000] [<c02173d4>] (tty_open) from [<c00c4734>]
(chrdev_open+0x7c/0x140)
[    6.880000] [<c00c4734>] (chrdev_open) from [<c00bcd58>]
(do_dentry_open+0x198/0x2e4)
[    6.880000] [<c00bcd58>] (do_dentry_open) from [<c00ce66c>]
(path_openat+0x2ec/0xf98)
[    6.880000] [<c00ce66c>] (path_openat) from [<c00cf378>]
(do_filp_open+0x60/0xc4)
[    6.880000] [<c00cf378>] (do_filp_open) from [<c00be2c8>]
(do_sys_open+0x100/0x1c0)
[    6.880000] [<c00be2c8>] (do_sys_open) from [<c0419f48>]
(kernel_init_freeable+0x134/0x1e0)
[    6.880000] [<c0419f48>] (kernel_init_freeable) from [<c0343f48>]
(kernel_init+0x8/0xf8)
[    6.880000] [<c0343f48>] (kernel_init) from [<c000a1cc>]
(ret_from_fork+0x14/0x28)
[    6.880000] handlers:
[    6.880000] [<c0225a78>] serial8250_interrupt
[    6.880000] Disabling IRQ #21
[    7.250000] Waiting for root device /dev/mmcblk0p1...

[2] https://bitbucket.org/Kasreyn/linux-next/commits/43afba549dbf17588a8ee2272cc7112548982cb2
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.11.0-rc1-next-20170310-00004-g43afba5
(i at ildjarn) (gcc version 4.9.1 (crosstool-NG 1.20.0) ) #4434 PREEMPT
Mon Mar 13 16:28:45 CET 2017
[    0.000000] CPU: FA526 [66015261] revision 1 (ARMv4), cr=0000397f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] OF: fdt: Machine model: MOXA UC-7112-LX
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 8128
[    0.000000] Kernel command line: console=ttyS0,115200n8 earlyprintk
root=/dev/mmcblk0p1 rw rootwait
[    0.000000] PID hash table entries: 128 (order: -3, 512 bytes)
[    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Memory: 19288K/32768K available (3337K kernel code,
153K rwdata, 716K rodata, 196K init, 8581K bss, 13480K reserved, 0K
cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc2800000 - 0xff800000   ( 976 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
[    0.000000]       .text : 0xc0008000 - 0xc034a630   (3338 kB)
[    0.000000]       .init : 0xc0419000 - 0xc044a000   ( 196 kB)
[    0.000000]       .data : 0xc044a000 - 0xc0470620   ( 154 kB)
[    0.000000]        .bss : 0xc0470620 - 0xc0cd1d68   (8582 kB)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] RCU lockdep checking is enabled.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] clocksource: moxart_timer: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 39817925974 ns
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns,
wraps every 21474836475000000ns
[    0.020000] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.030000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.030000] ... MAX_LOCK_DEPTH:          48
[    0.030000] ... MAX_LOCKDEP_KEYS:        8191
[    0.040000] ... CLASSHASH_SIZE:          4096
[    0.040000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.050000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.050000] ... CHAINHASH_SIZE:          32768
[    0.060000]  memory used by lock dependency info: 5167 kB
[    0.060000]  per task-struct memory footprint: 1536 bytes
[    0.080000] kmemleak: Kernel memory leak detector disabled
[    0.100000] kmemleak: Early log buffer exceeded (1229), please
increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[    0.110000] Calibrating delay loop... 144.79 BogoMIPS (lpj=723968)
[    0.180000] pid_max: default: 4096 minimum: 301
[    0.190000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.200000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.220000] CPU: Testing write buffer coherency: ok
[    0.250000] Setting up static identity map for 0x8200 - 0x8248
[    0.320000] devtmpfs: initialized
[    0.390000] DMA-API: preallocated 4096 debug entries
[    0.390000] DMA-API: debugging enabled by kernel config
[    0.420000] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.440000] kworker/u2:0 (12) used greatest stack depth: 6224 bytes left
[    0.450000] futex hash table entries: 16 (order: -3, 704 bytes)
[    0.470000] NET: Registered protocol family 16
[    0.490000] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.540000] kworker/u2:1 (19) used greatest stack depth: 5856 bytes left
[    1.150000] clocksource: Switched to clocksource moxart_timer
[    1.220000] NET: Registered protocol family 2
[    1.250000] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    1.260000] TCP bind hash table entries: 1024 (order: 3, 36864 bytes)
[    1.270000] TCP: Hash tables configured (established 1024 bind 1024)
[    1.280000] UDP hash table entries: 128 (order: 1, 10240 bytes)
[    1.290000] UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
[    1.310000] NET: Registered protocol family 1
[    1.350000] workingset: timestamp_bits=30 max_order=13 bucket_order=0
[    1.790000] jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
[    1.910000] io scheduler noop registered
[    1.910000] io scheduler cfq registered (default)
[    1.920000] io scheduler mq-deadline registered
[    1.960000] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled
[    2.030000] console [ttyS0] disabled
[    2.040000] 98200000.uart: ttyS0 at MMIO 0x98200000 (irq = 21,
base_baud = 921600) is a 16550A
[    2.060000] console [ttyS0] enabled
[    2.060000] console [ttyS0] enabled
[    2.060000] bootconsole [earlycon0] disabled
[    2.060000] bootconsole [earlycon0] disabled
[    2.140000] 80000000.flash: Found 1 x16 devices at 0x0 in 16-bit
bank. Manufacturer ID 0x000089 Chip ID 0x000018
[    2.150000] Intel/Sharp Extended Query Table at 0x0031
[    2.150000] Intel/Sharp Extended Query Table at 0x0031
[    2.160000] Using buffer write method
[    2.170000] cfi_cmdset_0001: Erase suspend on write enabled
[    2.170000] 4 ofpart partitions found on MTD device 80000000.flash
[    2.180000] Creating 4 MTD partitions on "80000000.flash":
[    2.190000] 0x000000000000-0x000000040000 : "bootloader"
[    2.250000] 0x000000040000-0x000000200000 : "linux kernel"
[    2.290000] 0x000000200000-0x000000a00000 : "root filesystem"
[    2.340000] 0x000000a00000-0x000001000000 : "user filesystem"
[    2.540000] random: fast init done
[    3.050000] libphy: MOXA ART Ethernet MII: probed
[    3.740000] libphy: MOXA ART Ethernet MII: probed
[    3.780000] libphy: Fixed MDIO Bus: probed
[    3.890000] moxart-rtc 90000000.soc:rtc: rtc core: registered
90000000.soc:rtc as rtc0
[    3.960000] sdhci: Secure Digital Host Controller Interface driver
[    3.960000] sdhci: Copyright(c) Pierre Ossman
[    4.060000] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.100000] NET: Registered protocol family 17
[    4.150000] irq 18, desc: c1808b00, depth: 0, count: 0, unhandled: 0
[    4.150000] ->handle_irq():  c0051440,
[    4.150000] handle_bad_irq+0x0/0x244
[    4.150000] ->irq_data.chip(): c0465990,
[    4.150000] ft010_irq_chip+0x0/0x88
[    4.150000] ->action(): c1a71080
[    4.150000] ->action->handler(): c0273e50,
[    4.150000] moxart_irq+0x0/0x308
[    4.150000] unexpected IRQ trap at vector 12
[    4.150000] irq 18, desc: c1808b00, depth: 0, count: 0, unhandled: 0
[    4.150000] ->handle_irq():  c0051440,
[    4.150000] handle_bad_irq+0x0/0x244
[    4.150000] ->irq_data.chip(): c0465990,
[    4.150000] ft010_irq_chip+0x0/0x88
[    4.150000] ->action(): c1a71080
[    4.150000] ->action->handler(): c0273e50,
[    4.150000] moxart_irq+0x0/0x308
[    4.150000] unexpected IRQ trap at vector 12
[    4.150000] irq 18, desc: c1808b00, depth: 0, count: 0, unhandled: 0
[    4.150000] ->handle_irq():  c0051440,
[    4.150000] handle_bad_irq+0x0/0x244
[    4.150000] ->irq_data.chip(): c0465990,
[    4.150000] ft010_irq_chip+0x0/0x88
[    4.150000] ->action(): c1a71080
[    4.150000] ->action->handler(): c0273e50,
[    4.150000] moxart_irq+0x0/0x308
[    4.150000] unexpected IRQ trap at vector 12
[    4.150000] irq 18, desc: c1808b00, depth: 0, count: 0, unhandled: 0
[    4.150000] ->handle_irq():  c0051440,
[    4.150000] handle_bad_irq+0x0/0x244
[    4.150000] ->irq_data.chip(): c0465990,
[    4.150000] ft010_irq_chip+0x0/0x88
[    4.150000] ->action(): c1a71080
[    4.150000] ->action->handler(): c0273e50,
[    4.150000] moxart_irq+0x0/0x308
[    4.150000] unexpected IRQ trap at vector 12
[    4.150000] irq 18, desc: c1808b00, depth: 0, count: 0, unhandled: 0
[    4.150000] ->handle_irq():  c0051440,
[    4.150000] handle_bad_irq+0x0/0x244
[    4.150000] ->irq_data.chip(): c0465990,
[    4.150000] ft010_irq_chip+0x0/0x88
[    4.150000] ->action(): c1a71080
[    4.150000] ->action->handler(): c0273e50,
[    4.150000] moxart_irq+0x0/0x308
[    4.150000] unexpected IRQ trap at vector 12
[    4.150000] irq 18, desc: c1808b00, depth: 0, count: 0, unhandled: 0
[    4.150000] ->handle_irq():  c0051440,
[    4.150000] handle_bad_irq+0x0/0x244
[    4.150000] ->irq_data.chip(): c0465990,
[    4.150000] ft010_irq_chip+0x0/0x88
[    4.150000] ->action(): c1a71080
[    4.150000] ->action->handler(): c0273e50,
[    4.150000] moxart_irq+0x0/0x308
