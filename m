From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 19 Jul 2012 08:13:06 +0200
Subject: [PATCH 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <20120718133956.GB30219@S2100-06.ap.freescale.net>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
 <20474.55029.733084.749955@ipc1.ka-ro>
 <20120713071415.GA10602@S2100-06.ap.freescale.net>
 <20479.59525.385001.544046@ipc1.ka-ro>
 <20120715144935.GB2429@S2100-06.ap.freescale.net>
 <20483.48136.37651.182431@ipc1.ka-ro>
 <20120718133956.GB30219@S2100-06.ap.freescale.net>
Message-ID: <20487.42354.946399.866320@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On Mon, Jul 16, 2012 at 09:00:24AM +0200, Lothar Wa?mann wrote:
> > > below.  But does that mean ethernet PHY does not work even on non-DT
> > > kernel right now?
> > > 
> > Seems so.
> > 
> Have you got the chance to figure it out why it does not work on
> non-DT kernel?
> 
No.

> > > I'm not sure if you have your bootloader passes dtb to kernel or use
> > > append-dtb approach.  In the later case, here are the brief
> > > instructions.
> > > 
> > > - Enable CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT
> > > - Build kernel
> > > - make ARCH=arm imx28-tx28.dtb
> > > - cat arch/arm/boot/zImage arch/arm/boot/imx28-tx28.dtb > arch/arm/boot/zImage_dtb
> > > - Boot zImage_dtb like you boot zImage as usual
> > > 
> > I'm using the appended DTB approach, and have done exactly this except
> > for using uImage rather than zImage.
> > 
> So, got a chance to wrap the zImage_dtb into uImage and have the DT
> kernel actually running?
> 
Yes, that actually works:
--------
|Linux version 3.5.0-rc6-next-20120712-karo+ (lothar at ipc1) (gcc version 4.5.3 (GCC) ) #11 PREEMPT Mon Jul 16 09:08:40 CEST 2012
|CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
|CPU: VIVT data cache, VIVT instruction cache
|Machine: Freescale i.MX28 (Device Tree), model: Ka-Ro electronics TX28 module
|bootconsole [earlycon0] enabled
|Memory policy: ECC disabled, Data cache writeback
|On node 0 totalpages: 32768
|free_area_init_node: node 0, pgdat c0471ce8, node_mem_map c04ac000
|  Normal zone: 256 pages used for memmap
|  Normal zone: 0 pages reserved
|  Normal zone: 32512 pages, LIFO batch:7
|pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
|pcpu-alloc: [0] 0 
|Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
|Kernel command line: init=/linuxrc kmemleak=on tx28_base=stkv3 tx28_otg_mode=device mtdparts=gpmi-nand:128k at 0x20000(env|),1m(u-boot),4m(linux),16m(rootfs),-(userfs) root=/dev/nfs nfsroot=192.168.1.225:/tftpboot/KARO/imx28-new,nolock ip=boo|tp mxsfb.mode=ETV570 debug earlyprintk panic=1 console=ttyAMA0,115200 ro
|PID hash table entries: 512 (order: -1, 2048 bytes)
|Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
|Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
|Memory: 128MB = 128MB total
|Memory: 125080k/125080k available, 5992k reserved, 0K highmem
|Virtual kernel memory layout:
|    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
|    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
|    vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
|    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
|    modules : 0xbf000000 - 0xc0000000   (  16 MB)
|      .text : 0xc0008000 - 0xc041bd90   (4176 kB)
|      .init : 0xc041c000 - 0xc043e294   ( 137 kB)
|      .data : 0xc0440000 - 0xc0472700   ( 202 kB)
|       .bss : 0xc0472724 - 0xc04ab1e0   ( 227 kB)
|SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
|NR_IRQS:304
|sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294967286ms
|Console: colour dummy device 80x30
|Calibrating delay loop... 226.09 BogoMIPS (lpj=1130496)
|pid_max: default: 32768 minimum: 301
|Mount-cache hash table entries: 512
|CPU: Testing write buffer coherency: ok
|Setting up static identity map for 0x402fcd58 - 0x402fcdb0
|------------[ cut here ]------------
|WARNING: at /usr/local/src/arm/projects/imx28/linux-tx28-dt/kernel/workqueue.c:1217 worker_enter_idle+0x114/0x130()
|Modules linked in:
|[<c001381c>] (unwind_backtrace+0x0/0xe4) from [<c001b20c>] (warn_slowpath_common+0x4c/0x64)
|[<c001b20c>] (warn_slowpath_common+0x4c/0x64) from [<c001b23c>] (warn_slowpath_null+0x18/0x1c)
|[<c001b23c>] (warn_slowpath_null+0x18/0x1c) from [<c0030718>] (worker_enter_idle+0x114/0x130)
|[<c0030718>] (worker_enter_idle+0x114/0x130) from [<c003075c>] (start_worker+0x28/0x34)
|[<c003075c>] (start_worker+0x28/0x34) from [<c0422bc4>] (init_workqueues+0x144/0x2bc)
|[<c0422bc4>] (init_workqueues+0x144/0x2bc) from [<c00088e4>] (do_one_initcall+0x9c/0x174)
|[<c00088e4>] (do_one_initcall+0x9c/0x174) from [<c041c7b0>] (kernel_init+0x50/0x1b4)
|[<c041c7b0>] (kernel_init+0x50/0x1b4) from [<c000f464>] (kernel_thread_exit+0x0/0x8)
|---[ end trace f60ac847315b779a ]---
|devtmpfs: initialized
|pinctrl core: initialized pinctrl subsystem
|dummy: 
|NET: Registered protocol family 16
|DMA: preallocated 256 KiB pool for atomic coherent allocations
|gpiochip_add: registered GPIOs 0 to 31 on device: gpio.0
|gpiochip_add: registered GPIOs 32 to 63 on device: gpio.1
|gpiochip_add: registered GPIOs 64 to 95 on device: gpio.2
|gpiochip_add: registered GPIOs 96 to 127 on device: gpio.3
|gpiochip_add: registered GPIOs 128 to 159 on device: gpio.4
|Serial: AMBA PL011 UART driver
|80074000.serial: ttyAMA0 at MMIO 0x80074000 (irq = 47) is a PL011 rev2
|console [ttyAMA0] enabled, bootconsole disabled
|console [ttyAMA0] enabled, bootconsole disabled
|bio: create slab <bio-0> at 0
|mxs-dma 80004000.dma-apbh: initialized
|mxs-dma 80024000.dma-apbx: initialized
|Switching to clocksource mxs_timer
|NET: Registered protocol family 2
|IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
|TCP established hash table entries: 4096 (order: 3, 32768 bytes)
|TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
|TCP: Hash tables configured (established 4096 bind 4096)
|TCP: reno registered
|UDP hash table entries: 256 (order: 0, 4096 bytes)
|UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
|NET: Registered protocol family 1
|RPC: Registered named UNIX socket transport module.
|RPC: Registered udp transport module.
|RPC: Registered tcp transport module.
|RPC: Registered tcp NFSv4.1 backchannel transport module.
|NetWinder Floating Point Emulator V0.97 (double precision)
|NFS: Registering the id_resolver key type
|Key type id_resolver registered
|jffs2: version 2.2. (NAND) (SUMMARY)  ?? 2001-2006 Red Hat, Inc.
|msgmni has been set to 244
|alg: No test for stdrng (krng)
|Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
|io scheduler noop registered
|io scheduler deadline registered
|io scheduler cfq registered (default)
|uart-pl011 80074000.serial: no DMA platform data
|8006c000.serial: ttyAPP1 at MMIO 0x8006c000 (irq = 113) is a 8006c000.serial
|mxs-auart 8006c000.serial: Found APPUART 3.1.0
|brd: module loaded
|loop: module loaded
|GPMI NAND driver registered. (IMX)
|of_get_named_gpio_flags: can't parse gpios property
|gpio_request: gpio--2 (phy-reset) status -22
|libphy: fec_enet_mii_bus: probed
|mousedev: PS/2 mouse device common for all mice
|rtc-ds1307 0-0068: SET TIME!
|rtc-ds1307 0-0068: rtc core: registered ds1339 as rtc0
|stmp3xxx-rtc 80056000.rtc: rtc core: registered 80056000.rtc as rtc1
|of_get_named_gpio_flags exited with status 0
|Registered led device: Heartbeat
|TCP: cubic registered
|NET: Registered protocol family 17
|Key type dns_resolver registered
|rtc-ds1307 0-0068: setting system clock to 2000-01-01 00:01:07 UTC (946684867)
|eth0: Freescale FEC PHY driver [SMSC LAN8710/LAN8720] (mii_bus:phy_addr=800f0000.etherne:00, irq=-1)
|libphy: 800f0000.etherne:00 - Link is Up - 100/Full
|Sending BOOTP requests . OK
|IP-Config: Got BOOTP answer from 192.168.100.1, my address is 192.168.100.73
|IP-Config: Complete:
|     device=eth0, addr=192.168.100.73, mask=255.255.254.0, gw=192.168.100.1
|     host=192.168.100.73, domain=ka-ro, nis-domain=(none)
|     bootserver=192.168.100.1, rootserver=192.168.1.225, rootpath=
|VFS: Mounted root (nfs filesystem) readonly on device 0:12.
|devtmpfs: mounted
|Freeing init memory: 136K
|Executing /sbin/init 
|INIT: version 2.88 booting
|Activating swap...done.
|Initializing /var... Done.
|Setting the system clock.
|Loading kernel modules...done.
|Activating lvm and md swap...done.
|Checking file systems...fsck from util-linux-ng 2.16
|done.
|Mounting local filesystems...done.
|Activating swapfile swap...done.
|Cleaning up temporary files....
|Cleaning up temporary files....
|Setting the system clock.
|ERROR: cannot update random seed file '/var/lib/urandom/random-seed'
|INIT: Entering runlevel: 2
|Starting internet superserver: inetd done.
|Configuring network interfaces: done.
|Starting telnetd...
|Setting sysfs variables....
|
|GNU/Linux 3.5.0-rc6-next-20120712-karo+ on triton1(armv5tejl) ttyAMA0:
--------

So you can have my
Acked-by: Lothar Wa?mann <LW@KARO-electronics.de>
for the patch to convert tx28 to DT.
Thank you very much for your work!


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
