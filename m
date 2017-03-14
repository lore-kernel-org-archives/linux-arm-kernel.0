From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Tue, 14 Mar 2017 15:58:29 +0100
Subject: [PATCH 4/4] RFT: irqchip: replace moxa with ftintc010
In-Reply-To: <CACRpkdYExzp0zRdnYad6XG+58saeCUNNN04-n+hPR-X=1gezOQ@mail.gmail.com>
References: <20170311231505.16056-1-linus.walleij@linaro.org>
 <CACmBeS2rNKnJKsFXeqwuCO5YBgfO8Nv=Wr+cG8DS-gfpfsxENg@mail.gmail.com>
 <CACRpkdYExzp0zRdnYad6XG+58saeCUNNN04-n+hPR-X=1gezOQ@mail.gmail.com>
Message-ID: <CACmBeS0BAUPgP7N1FMYvWK583kAOU2ogZ0PqE2hQA2sE5nBpUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2017 at 20:56, Linus Walleij <linus.walleij@linaro.org> wrote:
> Can you try the following patch? If it works I will queue
> this too.

Thanks! everything appear to work right with that patch (see log [1]),
however, DTC can no longer compile the dtb so the following is a patch
for that:


>From 764619070a209f388d0b5eb43a81c62b45256a60 Mon Sep 17 00:00:00 2001
From: Jonas Jensen <jonas.jensen@gmail.com>
Date: Tue, 14 Mar 2017 15:05:04 +0100
Subject: [PATCH 1/2] DT: ARM: moxart: change the machine dts so it uses
 #include instead of /include/

dtb:s with #include don't compile on BPi Debian GNU/Linux 8 (jessie)..

DTC can't compile the dtb on nested #include from /include/

dtc -v
Version: DTC 1.4.0

make -j3 ARCH=arm bzImage dtbs
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  UPD     include/config/kernel.release
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/bounds.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
<stdin>:1325:2: warning: #warning syscall statx not implemented [-Wcpp]
  CHK     include/generated/compile.h
  CC      init/version.o
  CC      kernel/sys.o
  LD      init/built-in.o
  CHK     kernel/config_data.h
  DTC     arch/arm/boot/dts/moxart-uc7112lx.dtb
  LD      kernel/built-in.o
Error: arch/arm/boot/dts/moxart.dtsi:9.1-9 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:313: recipe for target
'arch/arm/boot/dts/moxart-uc7112lx.dtb' failed
make[1]: *** [arch/arm/boot/dts/moxart-uc7112lx.dtb] Error 1
arch/arm/Makefile:345: recipe for target 'dtbs' failed
make: *** [dtbs] Error 2
make: *** Waiting for unfinished jobs....

Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
---
 arch/arm/boot/dts/moxart-uc7112lx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/moxart-uc7112lx.dts
b/arch/arm/boot/dts/moxart-uc7112lx.dts
index 10d088df..4a962a2 100644
--- a/arch/arm/boot/dts/moxart-uc7112lx.dts
+++ b/arch/arm/boot/dts/moxart-uc7112lx.dts
@@ -6,7 +6,7 @@
  */

 /dts-v1/;
-/include/ "moxart.dtsi"
+#include "moxart.dtsi"

 / {
  model = "MOXA UC-7112-LX";
-- 
1.8.2.1


[1] https://bitbucket.org/Kasreyn/linux-next/commits/73c25d2afaa8e49dc1f9bbeeacfe46f55db81db0
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.11.0-rc1-next-20170310-00012-g73c25d2
(i at ildjarn) (gcc version 4.9.2 (Debian 4.9.2-10) ) #2 PREEMPT Tue Mar
14 15:28:38 CET 2017
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
[    0.000000] Memory: 19288K/32768K available (3338K kernel code,
153K rwdata, 716K rodata, 196K init, 8581K bss, 13480K reserved, 0K
cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc2800000 - 0xff800000   ( 976 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
[    0.000000]       .text : 0xc0008000 - 0xc034ab10   (3339 kB)
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
[    0.400000] DMA-API: debugging enabled by kernel config
[    0.420000] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.440000] futex hash table entries: 16 (order: -3, 704 bytes)
[    0.450000] kworker/u2:1 (13) used greatest stack depth: 6088 bytes left
[    0.480000] NET: Registered protocol family 16
[    0.500000] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.550000] kworker/u2:0 (19) used greatest stack depth: 5856 bytes left
[    1.180000] clocksource: Switched to clocksource moxart_timer
[    1.260000] NET: Registered protocol family 2
[    1.290000] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    1.300000] TCP bind hash table entries: 1024 (order: 3, 36864 bytes)
[    1.310000] TCP: Hash tables configured (established 1024 bind 1024)
[    1.320000] UDP hash table entries: 128 (order: 1, 10240 bytes)
[    1.320000] UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
[    1.340000] NET: Registered protocol family 1
[    1.390000] workingset: timestamp_bits=30 max_order=13 bucket_order=0
[    1.830000] jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
[    1.960000] io scheduler noop registered
[    1.970000] io scheduler cfq registered (default)
[    1.970000] io scheduler mq-deadline registered
[    2.020000] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled
[    2.090000] console [ttyS0] disabled
[    2.100000] 98200000.uart: ttyS0 at MMIO 0x98200000 (irq = 21,
base_baud = 921600) is a 16550A
[    2.110000] console [ttyS0] enabled
[    2.110000] console [ttyS0] enabled
[    2.120000] bootconsole [earlycon0] disabled
[    2.120000] bootconsole [earlycon0] disabled
[    2.200000] 80000000.flash: Found 1 x16 devices at 0x0 in 16-bit
bank. Manufacturer ID 0x000089 Chip ID 0x000018
[    2.210000] Intel/Sharp Extended Query Table at 0x0031
[    2.220000] Intel/Sharp Extended Query Table at 0x0031
[    2.220000] Using buffer write method
[    2.230000] cfi_cmdset_0001: Erase suspend on write enabled
[    2.240000] 4 ofpart partitions found on MTD device 80000000.flash
[    2.240000] Creating 4 MTD partitions on "80000000.flash":
[    2.250000] 0x000000000000-0x000000040000 : "bootloader"
[    2.310000] 0x000000040000-0x000000200000 : "linux kernel"
[    2.360000] 0x000000200000-0x000000a00000 : "root filesystem"
[    2.410000] 0x000000a00000-0x000001000000 : "user filesystem"
[    2.540000] random: fast init done
[    3.120000] libphy: MOXA ART Ethernet MII: probed
[    3.810000] libphy: MOXA ART Ethernet MII: probed
[    3.850000] libphy: Fixed MDIO Bus: probed
[    3.960000] moxart-rtc 90000000.soc:rtc: rtc core: registered
90000000.soc:rtc as rtc0
[    4.040000] sdhci: Secure Digital Host Controller Interface driver
[    4.050000] sdhci: Copyright(c) Pierre Ossman
[    4.140000] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.190000] mmc0: new SD card at address e624
[    4.220000] mmcblk0: mmc0:e624 SD02G 1.84 GiB
[    4.230000] NET: Registered protocol family 17
[    4.340000]  mmcblk0: p1
[    4.350000] console [netcon0] enabled
[    4.350000] netconsole: network logging started
[    4.370000] moxart-rtc 90000000.soc:rtc: setting system clock to
2017-03-14 14:36:44 UTC (1489502204)
[    4.450000] EXT4-fs (mmcblk0p1): mounting ext3 file system using
the ext4 subsystem
[    5.150000] EXT4-fs (mmcblk0p1): warning: mounting fs with errors,
running e2fsck is recommended
[    5.190000] EXT4-fs (mmcblk0p1): recovery complete
[    5.210000] EXT4-fs (mmcblk0p1): mounted filesystem with ordered
data mode. Opts: (null)
[    5.220000] VFS: Mounted root (ext3 filesystem) on device 179:1.
[    5.300000] devtmpfs: mounted
[    5.320000] Freeing unused kernel memory: 196K
[    5.330000] This architecture does not have kernel memory protection.
INIT: version 2.88 booting


   Jonas
