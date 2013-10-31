From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 31 Oct 2013 15:05:01 -0200
Subject: [PATCH] clk: fix boot panic with non-dev-associated clocks
In-Reply-To: <1383238174-14650-1-git-send-email-olof@lixom.net>
References: <1383238174-14650-1-git-send-email-olof@lixom.net>
Message-ID: <CAOMZO5C4+K+RfHOpex7EwLObPV4Uy8YmjdVx2HPv36ZGAKeSZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Thu, Oct 31, 2013 at 2:49 PM, Olof Johansson <olof@lixom.net> wrote:
> Fixes a panic at boot on many platforms. For example, on imx (wandboard),
> I get:

With this patch applied console messages appears on 20131031, but it
seems we still have other issues:

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 3.12.0-rc7-next-20131031+ (fabio at fabio-Latitude-E6410)
(gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-1ubuntu1) ) #382 SMP Thu
Oct 31 14:53:20 BRST 2013
CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: Wandboard i.MX6 Dual Lite Board
Memory policy: ECC disabled, Data cache writeback
CPU: All CPU(s) started in SVC mode.
PERCPU: Embedded 8 pages/cpu @8141d000 s8960 r8192 d15616 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: console=tty0 console=ttymxc0,115200 root=/dev/nfs
ip=dhcp nfsroot=10.29.244.144:/tftpboot/rfs,v3,tcp earlyprintk
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 505276K/524288K available (6115K kernel code, 346K rwdata,
2032K rodata, 304K init, 5494K bss, 19012K reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xa0800000 - 0xff000000   (1512 MB)
    lowmem  : 0x80000000 - 0xa0000000   ( 512 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x807fcedc   (8148 kB)
      .init : 0x807fd000 - 0x80849300   ( 305 kB)
      .data : 0x8084a000 - 0x808a0a00   ( 347 kB)
       .bss : 0x808a0a08 - 0x80dfe3ec   (5495 kB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Hierarchical RCU implementation.
        RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
NR_IRQS:16 nr_irqs:16 16
L310 cache controller enabled
l2x0: 16 ways, CACHE_ID 0x410000c8, AUX_CTRL 0x32050000, Cache size: 512 kB
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at include/linux/kref.h:47 __clk_get+0x78/0x8c()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.12.0-rc7-next-20131031+ #382
Backtrace:
[<8001233c>] (dump_backtrace+0x0/0x10c) from [<800124d8>] (show_stack+0x18/0x1c)
 r6:8046f378 r5:00000009 r4:00000000 r3:00000000
[<800124c0>] (show_stack+0x0/0x1c) from [<805f80a4>] (dump_stack+0x80/0x9c)
[<805f8024>] (dump_stack+0x0/0x9c) from [<80026d9c>]
(warn_slowpath_common+0x70/0x94)
 r4:00000000 r3:80855d70
[<80026d2c>] (warn_slowpath_common+0x0/0x94) from [<80026de4>]
(warn_slowpath_null+0x24/0x2c)
 r8:00000000 r7:80747c88 r6:80891084 r5:80744ad4 r4:808a0970
[<80026dc0>] (warn_slowpath_null+0x0/0x2c) from [<8046f378>]
(__clk_get+0x78/0x8c)
[<8046f300>] (__clk_get+0x0/0x8c) from [<8046c310>] (clk_get_sys+0xf4/0x124)
 r4:9f828e40 r3:00000003
[<8046c21c>] (clk_get_sys+0x0/0x124) from [<80804e08>]
(mxc_timer_init+0x24/0x178)
[<80804de4>] (mxc_timer_init+0x0/0x178) from [<8081148c>]
(imx6q_clocks_init+0x2c30/0x2d60)
 r8:00000004 r7:808a1518 r6:80843af0 r5:814108c8 r4:a0820000
[<8080e85c>] (imx6q_clocks_init+0x0/0x2d60) from [<8082d588>]
(of_clk_init+0x44/0x6c)
[<8082d544>] (of_clk_init+0x0/0x6c) from [<808012c4>] (time_init+0x2c/0x38)
 r6:ffffffff r5:808a0a40 r4:00000001
[<80801298>] (time_init+0x0/0x38) from [<807fd9f4>] (start_kernel+0x1c0/0x340)
[<807fd834>] (start_kernel+0x0/0x340) from [<10008074>] (0x10008074)
---[ end trace 3406ff24bd97382e ]---
sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 65075262448ns
Console: colour dummy device 80x30
console [tty0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 3695 kB
 per task-struct memory footprint: 1152 bytes
Calibrating delay loop... 1581.05 BogoMIPS (lpj=7905280)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x105ff160 - 0x105ff1d0
CPU1: failed to boot: -38
Brought up 1 CPUs
SMP: Total of 1 processors activated.
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
CPU identified as i.MX6DL, silicon rev 1.1
syscon 20c8000.anatop: regmap [mem 0x020c8000-0x020c8fff] registered
vdd1p1: 800 <--> 1375 mV at 1100 mV
vdd3p0: 2800 <--> 3150 mV at 3000 mV
vdd2p5: 2000 <--> 2750 mV at 2400 mV
cpu: 725 <--> 1450 mV at 1150 mV
vddpu: 725 <--> 1450 mV at 1150 mV
vddsoc: 725 <--> 1450 mV at 1200 mV
syscon 20e0000.iomuxc-gpr: regmap [mem 0x020e0000-0x020e0037] registered
syscon 21bc000.ocotp: regmap [mem 0x021bc000-0x021bffff] registered
hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 4 bytes.
imx6dl-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
bio: create slab <bio-0> at 0
mxs-dma 110000.dma-apbh: initialized
2P5V: 2500 mV
3P3V: 3300 mV
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c i2c-1: IMX I2C adapter registered
Linux video capture interface: v2.00
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
<giometti@linux.it>
PTP clock support registered
Advanced Linux Sound Architecture Driver Initialized.
cfg80211: Calling CRDA to update world regulatory domain
Switched to clocksource mxc_timer1
NET: Registered protocol family 2
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 5, 147456 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP: reno registered
UDP hash table entries: 256 (order: 2, 20480 bytes)
UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7 counters available
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
fuse init (API version 7.22)
msgmni has been set to 986
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
imx-weim 21b8000.weim: Driver registered.
imx-sdma 20ec000.sdma: Direct firmware load failed with error -2
imx-sdma 20ec000.sdma: Falling back to user helper
imx-sdma 20ec000.sdma: initialized
Serial: IMX driver
2020000.serial: ttymxc0 at MMIO 0x2020000 (irq = 58, base_baud =
5000000) is a IMX
console [ttymxc0] enabled
21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq = 60, base_baud =
5000000) is a IMX
serial: Freescale lpuart driver
[drm] Initialized drm 1.1.0 20060810
brd: module loaded
loop: module loaded
fec 2188000.ethernet: dummy supplies not allowed
libphy: fec_enet_mii_bus: probed
fec 2188000.ethernet eth0: registered PHC device 0
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-mxc: Freescale On-Chip EHCI Host driver
usbcore: registered new interface driver usb-storage
imx_usb 2184000.usb: usbmisc init failed, ret=-517
platform 2184000.usb: Driver imx_usb requests probe deferral
imx_usb 2184200.usb: usbmisc init failed, ret=-517
platform 2184200.usb: Driver imx_usb requests probe deferral
mousedev: PS/2 mouse device common for all mice
Unable to handle kernel paging request at virtual address 65776f70
pgd = 80004000
[65776f70] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
3.12.0-rc7-next-20131031+ #382
task: 9f870000 ti: 9f85a000 task.ti: 9f85a000
PC is at __kmalloc_track_caller+0x68/0x160
LR is at __kmalloc_track_caller+0x20/0x160
pc : [<800d4838>]    lr : [<800d47f0>]    psr: 20000113
sp : 9f85bdc0  ip : 00bd6000  fp : 9f85bdf4
r10: 000000d0  r9 : 9f85a000  r8 : 8082b134
r7 : 80852c80  r6 : 0000000b  r5 : 65776f70  r4 : 9f801f00
r3 : 9f85a000  r2 : 00000000  r1 : 80852c80  r0 : 8084b320
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 10004059  DAC: 00000017
Process swapper/0 (pid: 1, stack limit = 0x9f85a240)
Stack: (0x9f85bdc0 to 0x9f85c000)
bdc0: ff0a0004 00001e3b 9facd2a4 9f85be68 807520ac 0000000b 000000d0 8082b134
bde0: 9f85a000 80839df0 9f85be1c 9f85bdf8 80291500 800d47dc 00000002 9f85be68
be00: 9facd280 9facd280 00000000 00000000 9f85be3c 9f85be20 80287ec0 802914c0
be20: 9facd280 807520ac 00000000 807fd55c 9f85be60 9f85be40 80287f78 80287ea0
be40: 805f0ab0 9f85be68 8088cd04 9facd280 808799d8 9f85be8c 9f85be68 8031a138
be60: 80287f4c 807520ac 80745094 9f85be78 8088cd04 00000006 808a0a40 807fd55c
be80: 9f85bea4 9f85be90 8031b310 8031a0c8 80845e1c 00000006 9f85beb4 9f85bea8
bea0: 8031bfd0 8031b29c 9f85bec4 9f85beb8 8082b14c 8031bf8c 9f85bf54 9f85bec8
bec0: 80008974 8082b140 805fec5c 8007cad0 00000000 00000000 9f85bf1c 9f85bee8
bee0: 9f85bf0c 9f85bef0 9f85bf00 9f85bef8 807fd55c 8141a665 80618964 000000bf
bf00: 9f85bf54 9f85bf10 800426e0 807fd568 9f85bf34 00000006 8141a670 00000006
bf20: 807facb8 807a1260 9f85bf54 80845e1c 00000006 808a0a40 807fd55c 000000bf
bf40: 80839de4 80839df0 9f85bf94 9f85bf58 807fdc78 80008884 00000006 00000006
bf60: 807fd55c 00000000 9f85a000 00000000 805f32b4 00000000 00000000 00000000
bf80: 00000000 00000000 9f85bfac 9f85bf98 805f32c4 807fdb80 ffffffff 00000000
bfa0: 00000000 9f85bfb0 8000eae8 805f32c0 00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
Backtrace:
[<800d47d0>] (__kmalloc_track_caller+0x0/0x160) from [<80291500>]
(kvasprintf+0x4c/0x70)
[<802914b4>] (kvasprintf+0x0/0x70) from [<80287ec0>]
(kobject_set_name_vargs+0x2c/0x78)
 r7:00000000 r6:00000000 r5:9facd280 r4:9facd280
[<80287e94>] (kobject_set_name_vargs+0x0/0x78) from [<80287f78>]
(kobject_init_and_add+0x3c/0x70)
 r7:807fd55c r6:00000000 r5:807520ac r4:9facd280
[<80287f40>] (kobject_init_and_add+0x4/0x70) from [<8031a138>]
(bus_add_driver+0x7c/0x1dc)
 r6:808799d8 r5:9facd280 r4:8088cd04
[<8031a0bc>] (bus_add_driver+0x0/0x1dc) from [<8031b310>]
(driver_register+0x80/0xfc)
 r7:807fd55c r6:808a0a40 r5:00000006 r4:8088cd04
[<8031b290>] (driver_register+0x0/0xfc) from [<8031bfd0>]
(__platform_driver_register+0x50/0x64)
 r5:00000006 r4:80845e1c
[<8031bf80>] (__platform_driver_register+0x0/0x64) from [<8082b14c>]
(imx_keypad_driver_init+0x18/0x20)
[<8082b134>] (imx_keypad_driver_init+0x0/0x20) from [<80008974>]
(do_one_initcall+0xfc/0x160)
[<80008878>] (do_one_initcall+0x0/0x160) from [<807fdc78>]
(kernel_init_freeable+0x104/0x1d4)
[<807fdb74>] (kernel_init_freeable+0x0/0x1d4) from [<805f32c4>]
(kernel_init+0x10/0x120)
[<805f32b4>] (kernel_init+0x0/0x120) from [<8000eae8>] (ret_from_fork+0x14/0x2c)
 r4:00000000 r3:ffffffff
Code: e790500c e3550000 0a000025 e5942014 (e7959002)
---[ end trace 3406ff24bd97382f ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
