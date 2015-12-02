From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 01 Dec 2015 17:54:44 -0800
Subject: [PATCH v4 2/5] ARM: BCM: Clean up SMP support for Broadcom Kona
In-Reply-To: <1448987049-17041-3-git-send-email-kapilh@broadcom.com>
References: <1448987049-17041-1-git-send-email-kapilh@broadcom.com>
 <1448987049-17041-3-git-send-email-kapilh@broadcom.com>
Message-ID: <565E4F64.9090704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/15 08:24, Kapil Hali wrote:
> These changes cleans up SMP implementaion for Broadcom's
> Kona SoC which are required for handling SMP for iProc
> family of SoCs at a single place for BCM NSP and BCM Kona.

FWIW, I gave this patch a try on a Capri board, and this still brings-up
the two CPUs successfully:

MMC read: dev # 0, block # 114688, count 32768 ...

100% (32768/32768 blocks)

32768 blocks read: OK

## Starting application at 0x80008000 ...

Uncompressing Linux... done, booting the kernel.

[    0.000000] Booting Linux on physical CPU 0x0

[    0.000000] Linux version 4.4.0-rc1-00005-ge49c96ed573e
(fainelli at fainelli-desktop) (gcc version 4.
8.5 (Broadcom stbgcc-4.8-1.4) ) #605 SMP Tue Dec 1 17:53:02 PST 2015

[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7),
cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: BCM28155 AP board

[    0.000000] cma: Reserved 16 MiB at 0xbf000000

[    0.000000] Memory policy: Data cache writealloc

[    0.000000] PERCPU: Embedded 12 pages/cpu @ef7d3000 s18752 r8192
d22208 u49152
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 260608
[    0.000000] Kernel command line: console=ttyS0,115200n8

[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)

[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.000000] Memory: 1009696K/1048576K available (6384K kernel code,
279K rwdata, 2268K rodata, 4152
K init, 218K bss, 22496K reserved, 16384K cma-reserved, 245760K highmem)

[    0.000000] Virtual kernel memory layout:

[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)

[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)

[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)

[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)

[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)

[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)

[    0.000000]       .text : 0xc0008000 - 0xc087b694   (8654 kB)

[    0.000000]       .init : 0xc087c000 - 0xc0c8a000   (4152 kB)

[    0.000000]       .data : 0xc0c8a000 - 0xc0ccfdf8   ( 280 kB)

[    0.000000]        .bss : 0xc0cd2000 - 0xc0d08bac   ( 219 kB)

[    0.000000] Hierarchical RCU implementation.

[    0.000000]  Build-time adjustment of leaf fanout to 32.

[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.

[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32,
nr_cpu_ids=2
[    0.000000] NR_IRQS:16 nr_irqs:16 16

[    0.000000] __ccu_wait_bit: slave_ccu/0x0484 bit 18 was never set

[    0.000000] __peri_clk_init: error initializing gate for bsc3

[    0.000000] Broadcom slave_ccu initialization had errors

[    0.000000] sched_clock: 32 bits at 1kHz, resolution 1000000ns, wraps
every 2147483647500000ns
[    0.000000] Console: colour dummy device 80x30

[    0.006000] Calibrating delay loop... 2383.87 BogoMIPS (lpj=1191936)

[    0.006000] pid_max: default: 32768 minimum: 301

[    0.006000] Mount-cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.006000] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.006000] CPU: Testing write buffer coherency: ok

[    0.006000] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000

[    0.006000] Setting up static identity map for 0x800082c0 -
0x80008318
[    0.015000] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001

[    0.015000] Brought up 2 CPUs

[    0.015000] SMP: Total of 2 processors activated (7200.76 BogoMIPS).

[    0.015000] CPU: All CPU(s) started in SVC mode.

[    0.015000] devtmpfs: initialized

[    0.016000] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.016000] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462
75000 ns

[    0.016000] pinctrl core: initialized pinctrl subsystem

[    0.017000] NET: Registered protocol family 16

[    0.017000] DMA: preallocated 256 KiB pool for atomic coherent
allocations
[    0.023000] cpuidle: using governor ladder

[    0.025000] cpuidle: using governor menu

[    0.026000] Kona Secure API initialized

[    0.026000] BCM-L2C-310 cache controller enabled, 16 ways, 512 kB

[    0.026000] BCM-L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x1e050000

[    0.026000] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.026000] hw-breakpoint: maximum watchpoint size is 4 bytes.

[    0.033000] SCSI subsystem initialized

[    0.033000] usbcore: registered new interface driver usbfs

[    0.033000] usbcore: registered new interface driver hub

[    0.033000] usbcore: registered new device driver usb

[    0.033000] Linux video capture interface: v2.00

[    0.033000] pps_core: LinuxPPS API ver. 1 registered

[    0.033000] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it
>

[    0.033000] PTP clock support registered

[    0.034000] Advanced Linux Sound Architecture Driver Initialized.

[    0.037000] NET: Registered protocol family 2

[    0.037000] TCP established hash table entries: 8192 (order: 3, 32768
bytes)
[    0.038000] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)

[    0.038000] TCP: Hash tables configured (established 8192 bind 8192)

[    0.038000] UDP hash table entries: 512 (order: 2, 16384 bytes)

[    0.038000] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)

[    0.038000] NET: Registered protocol family 1

[    0.038000] RPC: Registered named UNIX socket transport module.

[    0.038000] RPC: Registered udp transport module.

[    0.038000] RPC: Registered tcp transport module.

[    0.038000] RPC: Registered tcp NFSv4.1 backchannel transport module.

[    0.114000] futex hash table entries: 512 (order: 3, 32768 bytes)

[    0.114000] squashfs: version 4.0 (2009/01/31) Phillip Lougher

[    0.114000] NFS: Registering the id_resolver key type

[    0.114000] Key type id_resolver registered

[    0.114000] Key type id_legacy registered

[    0.114000] nfs4filelayout_init: NFSv4 File Layout Driver
Registering...
[    0.114000] jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.

[    0.114000] fuse init (API version 7.23)

[    0.115000] bounce: pool size: 64 pages

[    0.115000] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 252)
[    0.115000] io scheduler noop registered

[    0.115000] io scheduler deadline registered

[    0.115000] io scheduler cfq registered (default)

[    0.115000] bcm-kona-gpio 35003000.gpio: Setting up Kona GPIO

[    0.138000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled

[    0.139000] console [ttyS0] disabled

[    0.139000] 3e000000.uart: ttyS0 at MMIO 0x3e000000 (irq = 17,
base_baud = 808290) is a 16550A
[    0.415000] console [ttyS0] enabled

[    0.421000] brd: module loaded

[    0.423000] loop: module loaded

[    0.424000] libphy: Fixed MDIO Bus: probed

[    0.425000] cnic: QLogic cnicDriver v2.5.22 (July 20, 2015)

[    0.426000] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k

[    0.427000] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.

[    0.428000] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB
Ethernet driver
[    0.429000] usbcore: registered new interface driver pegasus

[    0.430000] usbcore: registered new interface driver asix

[    0.431000] usbcore: registered new interface driver ax88179_178a

[    0.432000] usbcore: registered new interface driver cdc_ether

[    0.433000] usbcore: registered new interface driver cdc_ncm

[    0.434000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI)
Driver
[    0.435000] ehci-pci: EHCI PCI platform driver

[    0.436000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver

[    0.437000] ohci-pci: OHCI PCI platform driver

[    0.438000] usbcore: registered new interface driver usb-storage

[    0.439000] mousedev: PS/2 mouse device common for all mice

[    0.440000] i2c /dev entries driver

[    0.441000] bcm-kona-i2c 3e016000.i2c: device registered successfully

[    0.442000] bcm-kona-i2c 3e017000.i2c: device registered successfully

[    0.443000] bcm-kona-i2c 3e018000.i2c: device registered successfully

[    0.444000] bcm-kona-i2c 3500d000.i2c: device registered successfully

[    0.445000] gspca_main: v2.14.0 registered

[    0.446000] sdhci: Secure Digital Host Controller Interface driver

[    0.447000] sdhci: Copyright(c) Pierre Ossman

[    0.448000] sdhci-pltfm: SDHCI platform and OF driver helper

[    0.452000] sdhci-kona 3f190000.sdio: No vmmc regulator found

[    0.453000] sdhci-kona 3f190000.sdio: No vqmmc regulator found

[    0.483000] mmc0: SDHCI controller on 3f190000.sdio [3f190000.sdio]
using ADMA
[    0.485000] sdhci-kona 3f1b0000.sdio: Got CD GPIO

[    0.489000] sdhci-kona 3f1b0000.sdio: No vmmc regulator found

[    0.490000] sdhci-kona 3f1b0000.sdio: No vqmmc regulator found

[    0.519000] mmc1: SDHCI controller on 3f1b0000.sdio [3f1b0000.sdio]
using ADMA
[    0.520000] usbcore: registered new interface driver usbhid

[    0.521000] usbhid: USB HID core driver

[    0.522000] NET: Registered protocol family 17

[    0.523000] bridge: automatic filtering via arp/ip/ip6tables has been
deprecated. Update your scrip
ts to load br_netfilter if you need this.

[    0.524000] 8021q: 802.1Q VLAN Support v1.8

[    0.525000] Key type dns_resolver registered

[    0.526000] Registering SWP/SWPB emulation handler

[    0.527000] ALSA device list:

[    0.528000]   No soundcards found.

[    0.529000] ttyS0 - failed to request DMA

[    0.531000] Freeing unused kernel memory: 4152K (c087c000 - c0c8a000)

starting pid 1114, tty '': '/etc/init.d/rcS'

Mounting virtual filesystems

[    0.548000] mmc0: MAN_BKOPS_EN bit is not set

[    0.554000] mmc0: new high speed MMC card at address 0001

[    0.557000] mmcblk0: mmc0:0001 016G4A 14.8 GiB

[    0.560000] mmcblk0boot0: mmc0:0001 016G4A partition 1 2.00 MiB

* WARNING: THIS STB CONTAINS GPLv3 SOFTWARE[    0.564000] mmcblk0boot1:
mmc0:0001 016G4A partition 2 2
.00 MiB


* GPLv3 programs must be removed in order to enable security.

* See: http://www.gnu.org/licenses/gpl-faq.html#Tivoization

[    0.570000] mmcblk0rpmb: mmc0:0001 016G4A partition 3 256 KiB

Configuring lo interface

[    0.577000] Alternate GPT is invalid, using primary GPT.

[    0.580000]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14
p15
Starting network services

starting pid 1211, tty '': '/bin/cttyhack /bin/sh -l'

#

# ps awwux

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND

root         1 22.0  0.1   1928  1244 ?        Ss   00:00   0:00 init

root         2  0.0  0.0      0     0 ?        S    00:00   0:00
[kthreadd]
root         3  0.0  0.0      0     0 ?        S    00:00   0:00
[ksoftirqd/0]
root         4  0.0  0.0      0     0 ?        S    00:00   0:00
[kworker/0:0]
root         5  0.0  0.0      0     0 ?        S<   00:00   0:00
[kworker/0:0H]
root         6  0.0  0.0      0     0 ?        S    00:00   0:00
[kworker/u4:0]
root         7  0.0  0.0      0     0 ?        S    00:00   0:00
[rcu_sched]
root         8  0.0  0.0      0     0 ?        S    00:00   0:00
[rcu_bh]
root         9  0.0  0.0      0     0 ?        S    00:00   0:00
[migration/0]
root        10  0.0  0.0      0     0 ?        S    00:00   0:00
[watchdog/0]
root        11  0.0  0.0      0     0 ?        S    00:00   0:00
[watchdog/1]
root        12  0.0  0.0      0     0 ?        S    00:00   0:00
[migration/1]
root        13  0.0  0.0      0     0 ?        S    00:00   0:00
[ksoftirqd/1]
root        14  0.0  0.0      0     0 ?        S    00:00   0:00
[kworker/1:0]
root        15  0.0  0.0      0     0 ?        S<   00:00   0:00
[kworker/1:0H]
root        16  0.0  0.0      0     0 ?        S    00:00   0:00
[kdevtmpfs]
root        17  2.0  0.0      0     0 ?        S    00:00   0:00
[kworker/u4:1]
root        18  0.0  0.0      0     0 ?        S<   00:00   0:00 [perf]

root        24  0.0  0.0      0     0 ?        S    00:00   0:00
[kworker/u4:2]
root       248  0.0  0.0      0     0 ?        S    00:00   0:00
[khungtaskd]
root       249  0.0  0.0      0     0 ?        S<   00:00   0:00
[writeback]
root       250  0.0  0.0      0     0 ?        S<   00:00   0:00
[crypto]
root       252  0.0  0.0      0     0 ?        S<   00:00   0:00
[bioset]
root       253  0.0  0.0      0     0 ?        S    00:00   0:00
[kworker/0:1]
root       254  0.0  0.0      0     0 ?        S<   00:00   0:00
[kblockd]
root       256  0.0  0.0      0     0 ?        S<   00:00   0:00
[ata_sff]
root       376  0.0  0.0      0     0 ?        S<   00:00   0:00
[rpciod]
root       389  0.0  0.0      0     0 ?        S    00:00   0:00 [kswapd0]
root       390  0.0  0.0      0     0 ?        S    00:00   0:00
[fsnotify_mark]
root       391  0.0  0.0      0     0 ?        S<   00:00   0:00 [nfsiod]
root       943  0.0  0.0      0     0 ?        S    00:00   0:00
[kworker/1:1]
root       947  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       950  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       951  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       952  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       953  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       954  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       955  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       956  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       957  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       958  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       959  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       960  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       961  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       962  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       963  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       964  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root       998  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root      1001  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root      1004  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root      1007  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root      1010  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root      1013  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root      1016  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root      1019  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root      1051  0.0  0.0      0     0 ?        S<   00:00   0:00 [cnic_wq]
root      1074  0.0  0.0      0     0 ?        S<   00:00   0:00 [kpsmoused]
root      1092  0.0  0.0      0     0 ?        S    00:00   0:00
[irq/24-mmc0]
root      1094  0.0  0.0      0     0 ?        S    00:00   0:00
[irq/25-mmc1]
root      1096  0.0  0.0      0     0 ?        S    00:00   0:00
[irq/31-3f1b0000]
root      1111  0.0  0.0      0     0 ?        S<   00:00   0:00 [deferwq]
root      1127  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root      1130  0.0  0.0      0     0 ?        S    00:00   0:00 [mmcqd/0]
root      1131  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root      1133  0.0  0.0      0     0 ?        S    00:00   0:00
[mmcqd/0boot0]
root      1134  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root      1137  0.0  0.0      0     0 ?        S    00:00   0:00
[mmcqd/0boot1]
root      1138  0.0  0.0      0     0 ?        S<   00:00   0:00 [bioset]
root      1140  0.0  0.0      0     0 ?        S    00:00   0:00
[mmcqd/0rpmb]
bin       1174  0.0  0.1   1452  1072 ?        Ss   00:00   0:00 portmap
root      1210  0.0  0.0   1928    56 ?        Ss   00:00   0:00 telnetd
root      1211  0.0  0.1   1968  1632 ttyS0    Ss   00:00   0:00 /bin/sh -l
root      1219  0.0  0.1   1948  1124 ttyS0    R+   00:00   0:00 ps awwux
c# cat /proc/cpuinfo
processor       : 0
model name      : ARMv7 Processor rev 0 (v7l)
BogoMIPS        : 2383.87
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0xc09
CPU revision    : 0

processor       : 1
model name      : ARMv7 Processor rev 0 (v7l)
BogoMIPS        : 4816.89
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0xc09
CPU revision    : 0

Hardware        : BCM281xx Broadcom Application Processor
Revision        : 0000
Serial          : 0000000000000000
#
-- 
Florian
