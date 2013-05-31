From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 31 May 2013 12:12:07 -0700
Subject: [BUG] zynq | CCF | SRCU
Message-ID: <42b8bfd5-3012-4c49-b9ef-7a9beb5956f1@VA3EHSMHS041.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

we recently encountered some kernel panics when we compiled one of our
drivers as module and tested inserting/removing the module.
Trying to debug this issue, I could reproduce it on the mainline kernel
with a dummy module.

What happens is, that when on driver remove clk_notifier_unregister() is
called and no other notifier for that clock is registered, the kernel
panics.
I'm not sure what is going wrong here. If there is a bug (and if where)
or I'm just using the infrastructure the wrong way,... So, any hint is
appreciated.

I attach the output from the crashing system. The stacktrace indicates a
crash in 'srcu_readers_seq_idx()'.
I also attach the module I used to trigger the issue and a patch on top
of mainline commit a93cb29acaa8f75618c3f202d1cf43c231984644 which has
the DT modifications I need to make the module find its clock and boot
with my initramfs.


	Thanks,
	S??ren

-------------- next part --------------


U-Boot 2013.01-00001-g7926df4 (Apr 09 2013 - 09:45:48)

I2C:   ready
DRAM:  1 GiB
WARNING: Caches not enabled
MMC:   zynq_sdhci: 0
SF: Detected N25Q128A with page size 64 KiB, total 16 MiB
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Net:   Gem.e000b000
Hit any key to stop autoboot:  3  2  1  0 
TFTPing Linux to RAM...
Gem.e000b000 Waiting for PHY auto negotiation to complete..... done
Using Gem.e000b000 device
TFTP from server 10.10.70.101; our IP address is 10.10.70.102
Filename 'uImage'.
Load address: 0x3000000
Loading: *T #################################################################
	 #################################################################
	 ##################################
	 410.2 KiB/s
done
Bytes transferred = 2397912 (2496d8 hex)
Gem.e000b000:7 is connected to Gem.e000b000.  Reconnecting to Gem.e000b000
Gem.e000b000 Waiting for PHY auto negotiation to complete..... done
Using Gem.e000b000 device
TFTP from server 10.10.70.101; our IP address is 10.10.70.102
Filename 'devicetree.dtb'.
Load address: 0x2a00000
Loading: *#
	 200.2 KiB/s
done
Bytes transferred = 3078 (c06 hex)
Gem.e000b000:7 is connected to Gem.e000b000.  Reconnecting to Gem.e000b000
Gem.e000b000 Waiting for PHY auto negotiation to complete..... done
Using Gem.e000b000 device
TFTP from server 10.10.70.101; our IP address is 10.10.70.102
Filename 'uramdisk.image.gz'.
Load address: 0x2000000
Loading: *#################################################################
	 #################################################################
	 #################################################################
	 ################################################################
	 3.4 MiB/s
done
Bytes transferred = 3792138 (39dd0a hex)
## Booting kernel from Legacy Image at 03000000 ...
   Image Name:   Linux-3.10.0-rc3-00119-ga93cb29-
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2397848 Bytes = 2.3 MiB
   Load Address: 00008000
   Entry Point:  00008000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 02000000 ...
   Image Name:   
   Image Type:   ARM Linux RAMDisk Image (gzip compressed)
   Data Size:    3792074 Bytes = 3.6 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 02a00000
   Booting using the fdt blob at 0x02a00000
   Loading Kernel Image ... OK
OK
   Loading Ramdisk to 1fc62000, end 1ffffcca ... OK
   Loading Device Tree to 1fc5e000, end 1fc61c05 ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0

[    0.000000] Linux version 3.10.0-rc3-00119-ga93cb29-dirty (sorenb at xsjandreislx) (gcc version 4.7.2 (Sourcery CodeBench Lite 2012.09-104) ) #85 SMP PREEMPT Fri May 31 11:43:25 PDT 2013

[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5387d

[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache

[    0.000000] Machine: Xilinx Zynq Platform, model: Zynq ZC702 Development Board

[    0.000000] bootconsole [earlycon0] enabled

[    0.000000] cma: CMA: reserved 16 MiB at 2e800000

[    0.000000] Memory policy: ECC disabled, Data cache writealloc

[    0.000000] PERCPU: Embedded 9 pages/cpu @c1475000 s14144 r8192 d14528 u36864

[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624

[    0.000000] Kernel command line: console=ttyPS0,115200 earlyprintk

[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)

[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)

[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)

[    0.000000] Memory: 1024MB = 1024MB total

[    0.000000] Memory: 1006620k/1006620k available, 41956k reserved, 270336K highmem

[    0.000000] Virtual kernel memory layout:

[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)

[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)

[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)

[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)

[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)

[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)

[    0.000000]       .text : 0xc0008000 - 0xc06338a4   (6319 kB)

[    0.000000]       .init : 0xc0634000 - 0xc0685740   ( 326 kB)

[    0.000000]       .data : 0xc0686000 - 0xc06d0ee0   ( 300 kB)

[    0.000000]        .bss : 0xc06d0ee0 - 0xc0c615d0   (5698 kB)

[    0.000000] Preemptible hierarchical RCU implementation.

[    0.000000] 	RCU lockdep checking is enabled.

[    0.000000] 	Additional per-CPU info printed with stalls.

[    0.000000] 	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.

[    0.000000] NR_IRQS:16 nr_irqs:16 16

[    0.000000] slcr mapped to f0002000

[    0.000000] ttc0 #0 at f0004000, irq=43

[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294967286ms

[    0.000000] Console: colour dummy device 80x30

[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar

[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8

[    0.000000] ... MAX_LOCK_DEPTH:          48

[    0.000000] ... MAX_LOCKDEP_KEYS:        8191

[    0.000000] ... CLASSHASH_SIZE:          4096

[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384

[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768

[    0.000000] ... CHAINHASH_SIZE:          16384

[    0.000000]  memory used by lock dependency info: 3695 kB

[    0.000000]  per task-struct memory footprint: 1152 bytes

[    0.060000] Calibrating delay loop... 1332.01 BogoMIPS (lpj=6660096)

[    0.150000] pid_max: default: 32768 minimum: 301

[    0.150000] Mount-cache hash table entries: 512

[    0.160000] CPU: Testing write buffer coherency: ok

[    0.160000] ftrace: allocating 15863 entries in 47 pages

[    0.200000] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000

[    0.200000] Setting up static identity map for 0xc04552d8 - 0xc0455330

[    0.210000] CPU1: Booted secondary processor

[    0.300000] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001

[    0.300000] Brought up 2 CPUs

[    0.300000] SMP: Total of 2 processors activated (2664.03 BogoMIPS).

[    0.310000] CPU: All CPU(s) started in SVC mode.

[    0.320000] devtmpfs: initialized

[    0.340000] NET: Registered protocol family 16

[    0.340000] DMA: preallocated 256 KiB pool for atomic coherent allocations

[    0.360000] L310 cache controller enabled

[    0.360000] l2x0: 8 ways, CACHE_ID 0x410000c8, AUX_CTRL 0x72360000, Cache size: 524288 B

[    0.370000] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.

[    0.370000] hw-breakpoint: maximum watchpoint size is 4 bytes.

[    0.450000] bio: create slab <bio-0> at 0

[    0.460000] SCSI subsystem initialized

[    0.460000] usbcore: registered new interface driver usbfs

[    0.460000] usbcore: registered new interface driver hub

[    0.470000] usbcore: registered new device driver usb

[    0.480000] Switching to clocksource ttc_clocksource

[    0.650000] NET: Registered protocol family 2

[    0.650000] TCP established hash table entries: 8192 (order: 4, 65536 bytes)

[    0.650000] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)

[    0.670000] TCP: Hash tables configured (established 8192 bind 8192)

[    0.670000] TCP: reno registered

[    0.670000] UDP hash table entries: 512 (order: 3, 40960 bytes)

[    0.680000] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)

[    0.690000] NET: Registered protocol family 1

[    0.690000] RPC: Registered named UNIX socket transport module.

[    0.690000] RPC: Registered udp transport module.

[    0.700000] RPC: Registered tcp transport module.

[    0.700000] RPC: Registered tcp NFSv4.1 backchannel transport module.

[    0.710000] Trying to unpack rootfs image as initramfs...

[    1.250000] Freeing initrd memory: 3700K (dfc62000 - dffff000)

[    1.260000] bounce pool size: 64 pages

[    1.260000] jffs2: version 2.2. (NAND) (SUMMARY)  ?? 2001-2006 Red Hat, Inc.

[    1.260000] msgmni has been set to 1477

[    1.290000] io scheduler noop registered

[    1.290000] io scheduler deadline registered

[    1.290000] io scheduler cfq registered (default)

[    1.310000] e000?[    1.310000] console [ttyPS0] enabled, bootconsole disabled
[    1.310000] console [ttyPS0] enabled, bootconsole disabled

[    1.360000] brd: module loaded
[    1.380000] loop: module loaded
[    1.400000] usbcore: registered new interface driver usb-storage
[    1.410000] mousedev: PS/2 mouse device common for all mice
[    1.420000] i2c /dev entries driver
[    1.430000] mpcore_wdt: MPcore Watchdog Timer: 0.1. mpcore_noboot=0 mpcore_margin=60 sec (nowayout= 0)
[    1.440000] cpuidle: using governor ladder
[    1.440000] cpuidle: using governor menu
[    1.440000] sdhci: Secure Digital Host Controller Interface driver
[    1.450000] sdhci: Copyright(c) Pierre Ossman
[    1.460000] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.460000] usbcore: registered new interface driver usbhid
[    1.470000] usbhid: USB HID core driver
[    1.470000] TCP: cubic registered
[    1.480000] NET: Registered protocol family 17
[    1.480000] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    1.490000] Registering SWP/SWPB emulation handler
[    1.500000] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    1.510000] Freeing unused kernel memory: 324K (c0634000 - c0685000)
Starting logging: OK
Starting mdev...
mdev: bad line 25
mdev: bad line 26
mdev: bad line 27
mdev: bad line 28
mdev: bad line 29
mdev: bad line 32
mdev: bad line 33
mdev: bad line 34
mdev: bad line 35
Initializing random number generator... done.
Starting network...
Starting dropbear sshd: generating rsa key... generating dsa key... OK


Zynq Busybox System

zynq login: root
Password: 
# lsmod
# modprobe clk_notif_dbg
[  508.310000] clk_notif_dbg clk_notif_dbg.1: clk_get()
[  508.320000] clk_notif_dbg clk_notif_dbg.1: clk_prepare()
[  508.320000] clk_notif_dbg clk_notif_dbg.1: clk_enable()
[  508.330000] clk_notif_dbg clk_notif_dbg.1: clk_notifier_register()
[  508.330000] clk_notif_dbg clk_notif_dbg.1: probe done
# 
# modprobe clk_notif_dbg[J -r
[  512.230000] clk_notif_dbg clk_notif_dbg.1: clk_notifier_unregister()
[  512.240000] clk_notif_dbg clk_notif_dbg.1: clk_disable()
[  512.240000] clk_notif_dbg clk_notif_dbg.1: clk_unprepare()
[  512.250000] clk_notif_dbg clk_notif_dbg.1: clk_put()
[  512.250000] clk_notif_dbg clk_notif_dbg.1: remove done
# 
# modprobe clk_notif_dbg -r[J
# modprobe clk_notif_dbg[J
[  515.290000] clk_notif_dbg clk_notif_dbg.1: clk_get()
[  515.290000] clk_notif_dbg clk_notif_dbg.1: clk_prepare()
[  515.300000] clk_notif_dbg clk_notif_dbg.1: clk_enable()
[  515.300000] clk_notif_dbg clk_notif_dbg.1: clk_notifier_register()
[  515.310000] clk_notif_dbg clk_notif_dbg.1: probe done
# 
# modprobe clk_notif_dbg[J
# modprobe clk_notif_dbg -r[J
[  517.040000] clk_notif_dbg clk_notif_dbg.1: clk_notifier_unregister()
[  517.040000] Unable to handle kernel paging request at virtual address 00df3008
[  517.050000] pgd = ed858000
[  517.050000] [00df3008] *pgd=00000000
[  517.060000] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[  517.060000] Modules linked in: clk_notif_dbg(O-) [last unloaded: clk_notif_dbg]
[  517.060000] CPU: 1 PID: 499 Comm: modprobe Tainted: G           O 3.10.0-rc3-00119-ga93cb29-dirty #85
[  517.060000] task: ee1e0180 ti: ee3e6000 task.ti: ee3e6000
[  517.060000] PC is at srcu_readers_seq_idx+0x48/0x84
[  517.060000] LR is at srcu_readers_seq_idx+0x60/0x84
[  517.060000] pc : [<c0052720>]    lr : [<c0052738>]    psr: 80070013
[  517.060000] sp : ee3e7d48  ip : 00000000  fp : ee3e7d6c
[  517.060000] r10: 00000000  r9 : ee3e6000  r8 : 00000000
[  517.060000] r7 : ed84fe4c  r6 : c068ec90  r5 : c068e430  r4 : 00000000
[  517.060000] r3 : 00df3000  r2 : 00000000  r1 : 00000002  r0 : 00000000
[  517.060000] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  517.060000] Control: 18c5387d  Table: 2d85804a  DAC: 00000015
[  517.060000] Process modprobe (pid: 499, stack limit = 0xee3e6238)
[  517.060000] Stack: (0xee3e7d48 to 0xee3e8000)
[  517.060000] 7d40:                   ee3e7dd4 ed84fe4c 00000000 00000002 c045719c 00000002
[  517.060000] 7d60: ee3e7da4 ee3e7d70 c0052790 c00526e4 ee3e6000 00000002 ee3e7da4 ed84fe4c
[  517.060000] 7d80: ed84fe80 00000001 00000000 00000002 ee3e6000 00000000 ee3e7dcc ee3e7da8
[  517.060000] 7da0: c00528b0 c0052768 ed84fe4c ee3e7dd4 00000001 00000000 ed84fe54 00000002
[  517.060000] 7dc0: ee3e7e2c ee3e7dd0 c0052c30 c0052864 ee3e7dfc 00000000 c0052d38 00000000
[  517.060000] 7de0: 00000000 dead4ead ffffffff ffffffff c06d8880 00000000 00000000 c0557b5a
[  517.060000] 7e00: ee3e7e00 ee3e7e00 ed84fe04 00000000 bf008704 00000081 c000f044 00000000
[  517.060000] 7e20: ee3e7e3c ee3e7e30 c0052d14 c0052b28 ee3e7e5c ee3e7e40 c0053a08 c0052cf4
[  517.060000] 7e40: ee002dc0 ed84fe00 ee002dc0 bf008704 ee3e7e7c ee3e7e60 c0375a78 c00539ac
[  517.060000] 7e60: 60070013 ee150410 bf008700 ee150444 ee3e7e94 ee3e7e80 bf008034 c0375a08
[  517.060000] 7e80: ee150410 bf008548 ee3e7ea4 ee3e7e98 c02bb974 bf00800c ee3e7ebc ee3e7ea8
[  517.060000] 7ea0: c02b9bf8 c02bb95c ee150410 bf008548 ee3e7edc ee3e7ec0 c02ba680 c02b9b78
[  517.060000] 7ec0: 00000000 bf008548 00000000 c06af670 ee3e7efc ee3e7ee0 c02b99c4 c02ba5f0
[  517.060000] 7ee0: ee3f9840 bf008548 00000000 bee66e83 ee3e7f14 ee3e7f00 c02bace4 c02b9904
[  517.060000] 7f00: bf008588 00000000 ee3e7f24 ee3e7f18 c02bbb44 c02bac9c ee3e7f34 ee3e7f28
[  517.060000] 7f20: bf0081f8 c02bbb34 ee3e7fa4 ee3e7f38 c00835e4 bf0081f0 c005815c 00000000
[  517.060000] 7f40: bf008588 00000880 ee3e7f3c 5f6b6c63 69746f6e 62645f66 ee3e0067 ee3e7f68
[  517.060000] 7f60: c0079424 c00791a8 00000000 00000000 bee66e83 00108250 ee3e7f94 ee3e7f88
[  517.060000] 7f80: c00794c4 000792dc 00000000 00000000 bee66e83 00108250 00000000 ee3e7fa8
[  517.060000] 7fa0: c000edc0 c00833f0 00000000 bee66e83 bee66e83 00000880 00108250 00000000
[  517.060000] 7fc0: 00000000 bee66e83 00108250 00000081 00000001 bee66d74 000ffcc0 00000000
[  517.060000] 7fe0: b6e7afd0 bee669e4 000370bc b6e7afdc 60070010 bee66e83 f8ce7acf b7b173d5
[  517.060000] [<c0052720>] (srcu_readers_seq_idx+0x48/0x84) from [<c0052790>] (try_check_zero+0x34/0xfc)
[  517.060000] [<c0052790>] (try_check_zero+0x34/0xfc) from [<c00528b0>] (srcu_advance_batches+0x58/0x114)
[  517.060000] [<c00528b0>] (srcu_advance_batches+0x58/0x114) from [<c0052c30>] (__synchronize_srcu+0x114/0x1ac)
[  517.060000] [<c0052c30>] (__synchronize_srcu+0x114/0x1ac) from [<c0052d14>] (synchronize_srcu+0x2c/0x34)
[  517.060000] [<c0052d14>] (synchronize_srcu+0x2c/0x34) from [<c0053a08>] (srcu_notifier_chain_unregister+0x68/0x74)
[  517.060000] [<c0053a08>] (srcu_notifier_chain_unregister+0x68/0x74) from [<c0375a78>] (clk_notifier_unregister+0x7c/0xc0)
[  517.060000] [<c0375a78>] (clk_notifier_unregister+0x7c/0xc0) from [<bf008034>] (clk_notif_dbg_remove+0x34/0x9c [clk_notif_dbg])
[  517.060000] [<bf008034>] (clk_notif_dbg_remove+0x34/0x9c [clk_notif_dbg]) from [<c02bb974>] (platform_drv_remove+0x24/0x28)
[  517.060000] [<c02bb974>] (platform_drv_remove+0x24/0x28) from [<c02b9bf8>] (__device_release_driver+0x8c/0xd4)
[  517.060000] [<c02b9bf8>] (__device_release_driver+0x8c/0xd4) from [<c02ba680>] (driver_detach+0x9c/0xc4)
[  517.060000] [<c02ba680>] (driver_detach+0x9c/0xc4) from [<c02b99c4>] (bus_remove_driver+0xcc/0xfc)
[  517.060000] [<c02b99c4>] (bus_remove_driver+0xcc/0xfc) from [<c02bace4>] (driver_unregister+0x54/0x78)
[  517.060000] [<c02bace4>] (driver_unregister+0x54/0x78) from [<c02bbb44>] (platform_driver_unregister+0x1c/0x20)
[  517.060000] [<c02bbb44>] (platform_driver_unregister+0x1c/0x20) from [<bf0081f8>] (clk_notif_dbg_driver_exit+0x14/0x1c [clk_notif_dbg])
[  517.060000] [<bf0081f8>] (clk_notif_dbg_driver_exit+0x14/0x1c [clk_notif_dbg]) from [<c00835e4>] (SyS_delete_module+0x200/0x28c)
[  517.060000] [<c00835e4>] (SyS_delete_module+0x200/0x28c) from [<c000edc0>] (ret_fast_syscall+0x0/0x48)
[  517.060000] Code: e5973004 e7911102 e0833001 e2881002 (e7933101) 
[  517.490000] ---[ end trace 389463afcdb5d46a ]---
Segmentation fault
# 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: clk_notif_dbg.c
Type: text/x-csrc
Size: 2017 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130531/aba1a917/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-zynq-Clock-notify-debug-on-zc702.patch
Type: text/x-diff
Size: 1468 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130531/aba1a917/attachment-0003.bin>
