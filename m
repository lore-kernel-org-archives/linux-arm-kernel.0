From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 13 Jul 2012 11:21:09 +0200
Subject: [PATCH 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <20120713071415.GA10602@S2100-06.ap.freescale.net>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
 <20474.55029.733084.749955@ipc1.ka-ro>
 <20120713071415.GA10602@S2100-06.ap.freescale.net>
Message-ID: <20479.59525.385001.544046@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo writes:
> Hi Lothar,
> 
> On Mon, Jul 09, 2012 at 03:04:53PM +0200, Lothar Wa?mann wrote:
> > This doesn't work at least because the pins that are used for PHY
> > strap options need to be reconfigured for their FEC functionality
> > after releasing the PHY reset. But even after adding the missing
> > reconfiguration the ethernet PHY does not work.
> > 
> Can you please test the branch below to see if ethernet PHY works?
> 
No. See bootlog below.

The following patch is required for the kernel to build:
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -82,6 +82,7 @@ config MODULE_TX28
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXS_PWM
 	select MXS_HAVE_PLATFORM_RTC_STMP3XXX
+	select MXS_OCOTP
 
 config MODULE_M28
 	bool

>   git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/dt/tx28
> 
> I hope I have addressed the issue with pin configuration there.
> But I'm not sure if "enet_out" clock needs to be enabled on tx28.
> I have enabled it in the code above.  You need to remove
> enable_clk_enet_out call from tx28_init, if it's not needed.
> 
ENET_CLK is required on the module.

## Booting kernel from Legacy Image at 40100000 ...
   Image Name:   Linux-3.5.0-rc6-next-20120712-ka
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2277008 Bytes = 2.2 MiB
   Load Address: 40008000
   Entry Point:  40008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...


Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.5.0-rc6-next-20120712-karo+ (lothar at ipc1) (gcc version 4.5.3 (GCC) ) #5 PREEMPT Fri Jul 13 11:06
:19 CEST 2012
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: Ka-Ro electronics TX28 module
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c046db28, node_mem_map c04a8000
  Normal zone: 256 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 32512 pages, LIFO batch:7
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: init=/linuxrc mtdparts=gpmi-nand:128k at 0x20000(env),1m(u-boot),4m(linux),16m(rootfs),-(userfs) root=/dev/nfs nfsroot=192.168.1.225:/tftpboot/KARO/imx28-new,nolock ip=bootp debug panic=1 console=ttyAMA0,115200 ro
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 125136k/125136k available, 5936k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc0419d40   (4168 kB)
      .init : 0xc041a000 - 0xc043be28   ( 136 kB)
      .data : 0xc043c000 - 0xc046e540   ( 202 kB)
       .bss : 0xc046e564 - 0xc04a7020   ( 227 kB)
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:304
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294967286ms
Console: colour dummy device 80x30
Calibrating delay loop... 226.09 BogoMIPS (lpj=1130496)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x402fc958 - 0x402fc9b0
------------[ cut here ]------------
WARNING: at /usr/local/src/arm/projects/imx28/linux-tx28-dt/kernel/workqueue.c:1217 worker_enter_idle+0x114/0x13
0()
Modules linked in:
[<c001381c>] (unwind_backtrace+0x0/0xe4) from [<c001adf8>] (warn_slowpath_common+0x4c/0x64)
[<c001adf8>] (warn_slowpath_common+0x4c/0x64) from [<c001ae28>] (warn_slowpath_null+0x18/0x1c)
[<c001ae28>] (warn_slowpath_null+0x18/0x1c) from [<c0030304>] (worker_enter_idle+0x114/0x130)
[<c0030304>] (worker_enter_idle+0x114/0x130) from [<c0030348>] (start_worker+0x28/0x34)
[<c0030348>] (start_worker+0x28/0x34) from [<c0420954>] (init_workqueues+0x144/0x2bc)
[<c0420954>] (init_workqueues+0x144/0x2bc) from [<c00088e4>] (do_one_initcall+0x9c/0x174)
[<c00088e4>] (do_one_initcall+0x9c/0x174) from [<c041a7b0>] (kernel_init+0x50/0x1b4)
[<c041a7b0>] (kernel_init+0x50/0x1b4) from [<c000f464>] (kernel_thread_exit+0x0/0x8)
---[ end trace 84ec6457efae102a ]---
devtmpfs: initialized
pinctrl core: initialized pinctrl subsystem
dummy: 
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
gpiochip_add: registered GPIOs 0 to 31 on device: imx28-gpio.0
gpiochip_add: registered GPIOs 32 to 63 on device: imx28-gpio.1
gpiochip_add: registered GPIOs 64 to 95 on device: imx28-gpio.2
gpiochip_add: registered GPIOs 96 to 127 on device: imx28-gpio.3
gpiochip_add: registered GPIOs 128 to 159 on device: imx28-gpio.4
Serial: AMBA PL011 UART driver
duart: ttyAMA0 at MMIO 0x80074000 (irq = 47) is a PL011 rev2
console [ttyAMA0] enabled
bio: create slab <bio-0> at 0
mxs-dma imx28-dma-apbh: initialized
mxs-dma imx28-dma-apbx: initialized
Switching to clocksource mxs_timer
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (double precision)
NFS: Registering the id_resolver key type
Key type id_resolver registered
jffs2: version 2.2. (NAND) (SUMMARY)  ?? 2001-2006 Red Hat, Inc.
msgmni has been set to 244
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
uart-pl011 duart: no DMA platform data
mxs-auart.1: ttyAPP1 at MMIO 0x8006c000 (irq = 113) is a mxs-auart.1
mxs-auart mxs-auart.1: Found APPUART 3.1.0
brd: module loaded
loop: module loaded
GPMI NAND driver registered. (IMX)
libphy: fec_enet_mii_bus: probed
mousedev: PS/2 mouse device common for all mice
rtc-ds1307 0-0068: SET TIME!
rtc-ds1307 0-0068: rtc core: registered ds1339 as rtc0
stmp3xxx-rtc stmp3xxx-rtc.0: rtc core: registered stmp3xxx-rtc as rtc1
Registered led device: GPIO-LED
TCP: cubic registered
NET: Registered protocol family 17
Key type dns_resolver registered
rtc-ds1307 0-0068: setting system clock to 2000-01-01 00:00:33 UTC (946684833)
eth0: no PHY, assuming direct connection to switch
libphy: PHY fixed-0:00 not found
eth0: could not attach to PHY
IP-Config: Failed to open eth0
IP-Config: No network devices available
script "uboot": global timeout
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
Please append a correct "root=" boot option; here are the available partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)
[<c001381c>] (unwind_backtrace+0x0/0xe4) from [<c02fa1e0>] (panic+0x90/0x1e8)
[<c02fa1e0>] (panic+0x90/0x1e8) from [<c041ac94>] (mount_block_root+0x1d4/0x230)
[<c041ac94>] (mount_block_root+0x1d4/0x230) from [<c041aee4>] (mount_root+0xd0/0xf0)
[<c041aee4>] (mount_root+0xd0/0xf0) from [<c041b054>] (prepare_namespace+0x150/0x1b0)
[<c041b054>] (prepare_namespace+0x150/0x1b0) from [<c041a8cc>] (kernel_init+0x16c/0x1b4)
[<c041a8cc>] (kernel_init+0x16c/0x1b4) from [<c000f464>] (kernel_thread_exit+0x0/0x8)
Rebooting in 1 seconds..


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
