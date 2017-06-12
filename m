From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Mon, 12 Jun 2017 14:41:50 +0200
Subject: [PATCH 2/2] drivers/clocksource/fttmr010: Implement delay timer
In-Reply-To: <20170611212617.6906-2-linus.walleij@linaro.org>
References: <20170611212617.6906-1-linus.walleij@linaro.org>
 <20170611212617.6906-2-linus.walleij@linaro.org>
Message-ID: <CACmBeS16+S1sCvvWtd835MD7atYeatEXRu-z-Hz27yD4DrJL+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 June 2017 at 23:26, Linus Walleij <linus.walleij@linaro.org> wrote:
> Switching to timer-based delay loop, resolution 40n
> Calibrating delay loop (skipped), value calculated using
>   timer frequency.. 50.00 BogoMIPS (lpj=250000)

Thanks for this, these work OK on UC-7112-LX.

I stumbled upon boot time savings (going from next-20170518 to
next-20170609) which seem to shave off more than a second ([1]
compared to [2]) so I also booted without patches ([3]).
There seems to be improvement when these patches are applied.

[1] https://bitbucket.org/Kasreyn/linux-next/commits/ceb7a070629807ed62c1101603655bebdbec5204
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.12.0-rc4-next-20170609-00005-gceb7a07
(i at ildjarn) (gcc version 4.9.1 (crosstool-NG 1.20.0) ) #4549 PREEMPT
Mon Jun 12 13:04:19 CEST 2017
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
[    0.000000] Memory: 25816K/32768K available (4096K kernel code,
112K rwdata, 668K rodata, 1024K init, 288K bss, 6952K reserved, 0K
cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc2800000 - 0xff800000   ( 976 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0500000   (5088 kB)
[    0.000000]       .init : 0xc0600000 - 0xc0700000   (1024 kB)
[    0.000000]       .data : 0xc0700000 - 0xc071c2a0   ( 113 kB)
[    0.000000]        .bss : 0xc0720674 - 0xc0768780   ( 289 kB)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Tasks RCU enabled.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] clocksource: FTTMR010-TIMER2: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 39817925974 ns
[    0.000062] sched_clock: 32 bits at 48MHz, resolution 20ns, wraps
every 44739242997ns
[    0.008405] Switching to timer-based delay loop, resolution 20ns
[    0.021091] kmemleak: Kernel memory leak detector disabled
[    0.031970] kmemleak: Early log buffer exceeded (1229), please
increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[    0.041868] Calibrating delay loop (skipped), value calculated
using timer frequency.. 96.00 BogoMIPS (lpj=480000)
[    0.052806] pid_max: default: 4096 minimum: 301
[    0.058925] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.066022] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.077057] CPU: Testing write buffer coherency: ok
[    0.090239] Setting up static identity map for 0x100000 - 0x100048
[    0.097927] Hierarchical SRCU implementation.
[    0.141643] devtmpfs: initialized
[    0.172834] DMA-API: preallocated 4096 debug entries
[    0.178088] DMA-API: debugging enabled by kernel config
[    0.185933] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.198365] kworker/u2:0 (13) used greatest stack depth: 6732 bytes left
[    0.206072] futex hash table entries: 16 (order: -5, 192 bytes)
[    0.215797] random: bucket_table_alloc+0x94/0x248 get_random_u32
called with crng_init=0
[    0.226839] NET: Registered protocol family 16
[    0.242597] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.286674] kworker/u2:1 (25) used greatest stack depth: 6476 bytes left
[    0.554111] clocksource: Switched to clocksource FTTMR010-TIMER2
[    0.592605] NET: Registered protocol family 2
[    0.600601] random: neigh_hash_alloc+0x9c/0xe4 get_random_u32
called with crng_init=0
[    0.613871] random: rt_genid_init+0x18/0x28 get_random_u32 called
with crng_init=0
[    0.623192] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.631215] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.638463] TCP: Hash tables configured (established 1024 bind 1024)
[    0.646917] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.653246] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.661388] NET: Registered protocol family 1
[    0.684891] workingset: timestamp_bits=30 max_order=13 bucket_order=0
[    0.847527] kworker/u2:1 (202) used greatest stack depth: 6452 bytes left
[    0.889185] jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
[    0.947029] io scheduler noop registered
[    0.955454] io scheduler cfq registered (default)
[    0.960470] io scheduler mq-deadline registered
[    0.966328] io scheduler kyber registered
[    0.986690] ftgpio010-gpio 98700000.gpio: FTGPIO010 @c289e000 registered
[    1.006881] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled
[    1.028261] console [ttyS0] disabled
[    1.033357] 98200000.uart: ttyS0 at MMIO 0x98200000 (irq = 21,
base_baud = 921600) is a 16550A
[    1.043679] console [ttyS0] enabled
[    1.043679] console [ttyS0] enabled
[    1.051850] bootconsole [earlycon0] disabled
[    1.051850] bootconsole [earlycon0] disabled
[    1.101640] 80000000.flash: Found 1 x16 devices at 0x0 in 16-bit
bank. Manufacturer ID 0x000089 Chip ID 0x000018
[    1.112766] Intel/Sharp Extended Query Table at 0x0031
[    1.118581] Intel/Sharp Extended Query Table at 0x0031
[    1.123882] Using buffer write method
[    1.128057] cfi_cmdset_0001: Erase suspend on write enabled
[    1.134012] 4 ofpart partitions found on MTD device 80000000.flash
[    1.140561] Creating 4 MTD partitions on "80000000.flash":
[    1.146468] 0x000000000000-0x000000040000 : "bootloader"
[    1.168490] 0x000000040000-0x000000200000 : "linux kernel"
[    1.192265] 0x000000200000-0x000000a00000 : "root filesystem"
[    1.217379] 0x000000a00000-0x000001000000 : "user filesystem"
[    1.890595] libphy: MOXA ART Ethernet MII: probed
[    2.554143] random: fast init done
[    2.565768] libphy: MOXA ART Ethernet MII: probed
[    2.599346] libphy: Fixed MDIO Bus: probed
[    2.649311] moxart-rtc 90000000.soc:rtc: rtc core: registered
90000000.soc:rtc as rtc0
[    2.680285] sdhci: Secure Digital Host Controller Interface driver
[    2.689336] sdhci: Copyright(c) Pierre Ossman
[    2.764421] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.786042] NET: Registered protocol family 17
[    2.814928] mmc0: new SDHC card at address e624
[    2.822331] console [netcon0] enabled
[    2.828128] netconsole: network logging started
[    2.839709] mmcblk0: mmc0:e624 SS04G 3.69 GiB
[    2.848309] moxart-rtc 90000000.soc:rtc: setting system clock to
2017-06-12 11:15:23 UTC (1497266123)
[    2.865883]  mmcblk0: p1
[    2.885535] EXT4-fs (mmcblk0p1): mounting ext3 file system using
the ext4 subsystem
[    4.168117] EXT4-fs (mmcblk0p1): recovery complete
[    4.178633] EXT4-fs (mmcblk0p1): mounted filesystem with ordered
data mode. Opts: (null)
[    4.187497] VFS: Mounted root (ext3 filesystem) on device 179:1.
[    4.226905] devtmpfs: mounted
[    4.298371] Freeing unused kernel memory: 1024K
INIT: version 2.88 booting

[2] https://bitbucket.org/Kasreyn/linux-next/commits/78456248df9eeb48c963b574f50c7268713ef0b1
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.12.0-rc1-next-20170518-00010-g7845624
(i at ildjarn) (gcc version 4.9.1 (crosstool-NG 1.20.0) ) #4486 PREEMPT
Fri May 19 14:04:54 CEST 2017
..
[    2.543134] 4 ofpart partitions found on MTD device 80000000.flash
[    2.550035] Creating 4 MTD partitions on "80000000.flash":
[    2.555941] 0x000000000000-0x000000040000 : "bootloader"
[    2.563134] random: fast init done
[    2.634452] 0x000000040000-0x000000200000 : "linux kernel"
[    2.686438] 0x000000200000-0x000000a00000 : "root filesystem"
[    2.744918] 0x000000a00000-0x000001000000 : "user filesystem"

[3] https://bitbucket.org/Kasreyn/linux-next/commits/75a5fce74de4172fb6ce32aa1f4e208657013006
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.12.0-rc4-next-20170609-00003-g75a5fce
(i at ildjarn) (gcc version 4.9.1 (crosstool-NG 1.20.0) ) #4550 PREEMPT
Mon Jun 12 13:58:32 CEST 2017
..
[    1.185855] 4 ofpart partitions found on MTD device 80000000.flash
[    1.192166] Creating 4 MTD partitions on "80000000.flash":
[    1.198093] 0x000000000000-0x000000040000 : "bootloader"
[    1.220088] 0x000000040000-0x000000200000 : "linux kernel"
[    1.244496] 0x000000200000-0x000000a00000 : "root filesystem"
[    1.269177] 0x000000a00000-0x000001000000 : "user filesystem"


Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
