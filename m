From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 01 Sep 2016 09:19:13 +0200
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <20160831102721.GR1041@n2100.armlinux.org.uk> (Russell King's
 message of "Wed, 31 Aug 2016 11:27:21 +0100")
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <87eg57e54l.fsf@belgarion.home>
 <20160830091805.GL1041@n2100.armlinux.org.uk>
 <87k2eycip0.fsf@belgarion.home>
 <20160830184612.GO1041@n2100.armlinux.org.uk>
 <87fupmc59b.fsf@belgarion.home>
 <20160831084938.GQ1041@n2100.armlinux.org.uk>
 <20160831102721.GR1041@n2100.armlinux.org.uk>
Message-ID: <87twe0krym.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Wed, Aug 31, 2016 at 09:49:38AM +0100, Russell King - ARM Linux wrote:
>> On Tue, Aug 30, 2016 at 11:32:16PM +0200, Robert Jarzmik wrote:
>> > Russell King - ARM Linux <linux@armlinux.org.uk> writes:
>> > 
>> > > If you can wait a day or two, I'll push a branch out for everything in
>> > > all these multiple series.
>> > Sure, just ping me when you have something.
>> 
>> git://git.armlinux.org.uk/~rmk/linux-arm.git sa1100
>> 
>> should get you something suitable to test.  It's based on 4.7-rc3 plus
>> my fixes branch.
>> 
>> It would be great to have this tested on Lubbock, and get the PCMCIA
>> issues fixed.
Ok Russell, I run a first mini-test.

I used :
 - one trivial typo fix of your patches in [1]
 - one "make it better fix" in [2] to pass the pcmcia probe, without much
   thinking about it, just to have the probe finished

The result today is that my PCMCIA card inserted in Lubbock's slot is not
detected, but that's not really a surprise. As a matter of fact, I didn't look
much into it, the only data points I have are :
 - PCMCIA is probed now
   - this is based on dmesg in [3]
   - this is also based on ls /sys/bus/sa1111-rab/devices/1800
	lrwxrwxrwx    1 root     root             0 Jan  1 00:15 driver -> ../../../../bus/sa1111-rab/drivers/sa1111-pcmcia
	drwxr-xr-x    2 root     root             0 Jan  1 00:15 power
	lrwxrwxrwx    1 root     root             0 Jan  1 00:15 subsystem -> ../../../../bus/sa1111-rab
	-rw-r--r--    1 root     root          4096 Jan  1 00:15 uevent

 - PCMCIA sockets are not there
   - this is based on ls /sys/class/pcmcia_socket/ where there is nothing

 - MAX16xx gpio are not claimed, which is surprising
   - this is based on cat /sys/kernel/debug/gpio
	gpiochip0: GPIOs 0-84, gpio-pxa:
	gpiochip2: GPIOs 478-495, parent: platform/sa1111, sa1111:
	gpiochip1: GPIOs 496-511, lubbock:

I'm not familiar with drivers/pcmcia part of the kernel tree so I won't be fast
to go down to the problem, but I'll try in the next days. Maybe if I activate
debug logs in pcmcia related parts I'll find out more quickly what is happening.

> Maybe we can look at converting mainstone as well?
Yep.

> This follows the Cirrus code (also used by Lubbock.)  So, if we represent the
> MST_PCMCIA[01] registers as GPIOs, we can switch pxa2xx_mainstone.c to use the
> max1600.c code for power control.
Yes.

> There is a slight issue, which is that the interrupts can't be translated to
> an interrupt by gpio-reg, which will currently cause soc_common problems - but
> that's an easy fix, though leaves us with more code than I'd desire in
> pxa2xx_mainstone.c.  Maybe a solution there would be to have gpio-reg also
> take an array of interrupt numbers... not sure yet.
Normally these interrupts are already dealt with by
arch/arm/mach-pxa/pxa_cplds_irq.c, which adds an irqdomain for them. The missing
part is the "gpio to interrupt" translation part, right ? This is where your
array comes into play if I get your right, to be the input of the to_irq()
function of the gpiochip.

As your gpios are contiguous (0 .. 31), why an array instead of a simple offset
so that your translation is only a linear irq = gpio + offset ?

> For IrDA, it looks like it has the same transceiver as the assabet, so I've
> (already) patches to split out the gpio-based transceiver control from
> sa1100_ir - maybe we can re-use that in pxaficp_ir too.
Once PCMCIA is over, sure.

Cheers.

--
Robert

[1] Typo fix
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index f034928b99a1..81a1de6fb46f 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -13,7 +13,7 @@
  */
 #include <linux/clkdev.h>
 #include <linux/gpio.h>
-#include <linux/gpip/gpio-reg.h>
+#include <linux/gpio/gpio-reg.h>
 #include <linux/gpio/machine.h>
 #include <linux/module.h>
 #include <linux/kernel.h>

[2] Kind-of fix for lubbock pcmcia probe
>From 977c16201a752aac8a8fb2da1f4271795f0b2122 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Thu, 1 Sep 2016 08:31:08 +0200
Subject: [PATCH] pcmcia: lubbock: fix sockets configuration

On lubbock board, the probe of the driver crashes by dereferencing very
early a platform_data structure which is not set, in
pxa2xx_configure_sockets().

This patch blindly fixes it without any analysis as to know if it's the
right fix or even if the fix doesn't break in suspend/resume.

The stack fixed is :
[    0.244353] SA1111 Microprocessor Companion Chip: silicon revision 1, metal revision 1
[    0.256321] sa1111 sa1111: Providing IRQ336-390
[    0.340899] clocksource: Switched to clocksource oscr0
[    0.472263] Unable to handle kernel NULL pointer dereference at virtual address 00000004
[    0.480469] pgd = c0004000
[    0.483432] [00000004] *pgd=00000000
[    0.487105] Internal error: Oops: f5 [#1] ARM
[    0.491497] Modules linked in:
[    0.494650] CPU: 0 PID: 1 Comm: swapper Not tainted 4.8.0-rc3-00080-g1aaa68426f0c-dirty #2068
[    0.503229] Hardware name: Intel DBPXA250 Development Platform (aka Lubbock)
[    0.510344] task: c3e42000 task.stack: c3e44000
[    0.514984] PC is at pxa2xx_configure_sockets+0x4/0x24 (drivers/pcmcia/pxa2xx_base.c:227)
[    0.520193] LR is at pcmcia_lubbock_init+0x1c/0x38
[    0.525079] pc : [<c0247c30>]    lr : [<c02479b0>]    psr: a0000053
[    0.525079] sp : c3e45e70  ip : 100019ff  fp : 00000000
[    0.536651] r10: c0828900  r9 : c0434838  r8 : 00000000
[    0.541953] r7 : c0820700  r6 : c0857b30  r5 : c3ec1400  r4 : c0820758
[    0.548549] r3 : 00000000  r2 : 0000000c  r1 : c3c09c40  r0 : c3ec1400
[    0.555154] Flags: NzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
[    0.562450] Control: 0000397f  Table: a0004000  DAC: 00000053
[    0.568257] Process swapper (pid: 1, stack limit = 0xc3e44190)
[    0.574154] Stack: (0xc3e45e70 to 0xc3e46000)
[    0.578610] 5e60:                                     c4849800 00000000 c3ec1400 c024769c
[    0.586928] 5e80: 00000000 c3ec140c c3c0ee0c c3ec1400 c3ec1434 c020c410 c3ec1400 c3ec1434
[    0.595244] 5ea0: c0820700 c080b408 c0828900 c020c5f8 00000000 c0820700 c020c578 c020ac5c
[    0.603560] 5ec0: c3e687cc c3e71e10 c0820700 00000000 c3c02de0 c020bae4 c03c62f7 c03c62f7
[    0.611872] 5ee0: c3e68780 c0820700 c042e034 00000000 c043c440 c020cdec c080b408 00000005
[    0.620188] 5f00: c042e034 c00096c0 c0034440 c01c730c 20000053 ffffffff 00000000 00000000
[    0.628502] 5f20: 00000000 c3ffcb87 c3ffcb90 c00346ac c3e66ba0 c03f7914 00000092 00000005
[    0.636811] 5f40: 00000005 c03f847c 00000091 c03f847c 00000000 00000005 c0434828 00000005
[    0.645125] 5f60: c043482c 00000092 c043c440 c0828900 c0434838 c0418d2c 00000005 00000005
[    0.653430] 5f80: 00000000 c041858c 00000000 c032e9f0 00000000 00000000 00000000 00000000
[    0.661729] 5fa0: 00000000 c032e9f8 00000000 c000f0f0 00000000 00000000 00000000 00000000
[    0.670020] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.678311] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    0.686673] (pxa2xx_configure_sockets) from pcmcia_lubbock_init (/drivers/pcmcia/sa1111_lubbock.c:161)
[    0.696026] (pcmcia_lubbock_init) from pcmcia_probe (/drivers/pcmcia/sa1111_generic.c:213)
[    0.704358] (pcmcia_probe) from driver_probe_device (/drivers/base/dd.c:378 /drivers/base/dd.c:499)
[    0.712848] (driver_probe_device) from __driver_attach (/./include/linux/device.h:983 /drivers/base/dd.c:733)
[    0.721414] (__driver_attach) from bus_for_each_dev (/drivers/base/bus.c:313)
[    0.729723] (bus_for_each_dev) from bus_add_driver (/drivers/base/bus.c:708)
[    0.738036] (bus_add_driver) from driver_register (/drivers/base/driver.c:169)
[    0.746185] (driver_register) from do_one_initcall (/init/main.c:778)
[    0.754561] (do_one_initcall) from kernel_init_freeable (/init/main.c:843 /init/main.c:851 /init/main.c:869 /init/main.c:1016)
[    0.763409] (kernel_init_freeable) from kernel_init (/init/main.c:944)
[    0.771660] (kernel_init) from ret_from_fork (/arch/arm/kernel/entry-common.S:119)
[ 0.779347] Code: c03c6305 c03c631e c03c632e e5903048 (e993000c)
All code
========
   0:	c03c6305 	eorsgt	r6, ip, r5, lsl #6
   4:	c03c631e 	eorsgt	r6, ip, lr, lsl r3
   8:	c03c632e 	eorsgt	r6, ip, lr, lsr #6
   c:	e5903048 	ldr	r3, [r0, #72]	; 0x48
  10:*	e993000c 	ldmib	r3, {r2, r3}		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	e993000c 	ldmib	r3, {r2, r3}
[    0.786319] ---[ end trace 5264be19ef367bea ]---
[    0.791201] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.791201]
[    0.800441] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/pcmcia/pxa2xx_base.c    | 9 +++++----
 drivers/pcmcia/pxa2xx_base.h    | 2 +-
 drivers/pcmcia/sa1111_lubbock.c | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 483f919e0d2e..91b5f5724cba 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -214,9 +214,8 @@ pxa2xx_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
 }
 #endif
 
-void pxa2xx_configure_sockets(struct device *dev)
+void pxa2xx_configure_sockets(struct device *dev, struct pcmcia_low_level *ops)
 {
-	struct pcmcia_low_level *ops = dev->platform_data;
 	/*
 	 * We have at least one socket, so set MECR:CIT
 	 * (Card Is There)
@@ -322,7 +321,7 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 			goto err1;
 	}
 
-	pxa2xx_configure_sockets(&dev->dev);
+	pxa2xx_configure_sockets(&dev->dev, ops);
 	dev_set_drvdata(&dev->dev, sinfo);
 
 	return 0;
@@ -348,7 +347,9 @@ static int pxa2xx_drv_pcmcia_remove(struct platform_device *dev)
 
 static int pxa2xx_drv_pcmcia_resume(struct device *dev)
 {
-	pxa2xx_configure_sockets(dev);
+	struct pcmcia_low_level *ops = (struct pcmcia_low_level *)dev->platform_data;
+
+	pxa2xx_configure_sockets(dev, ops);
 	return 0;
 }
 
diff --git a/drivers/pcmcia/pxa2xx_base.h b/drivers/pcmcia/pxa2xx_base.h
index b609b45469ed..e58c7a415418 100644
--- a/drivers/pcmcia/pxa2xx_base.h
+++ b/drivers/pcmcia/pxa2xx_base.h
@@ -1,4 +1,4 @@
 int pxa2xx_drv_pcmcia_add_one(struct soc_pcmcia_socket *skt);
 void pxa2xx_drv_pcmcia_ops(struct pcmcia_low_level *ops);
-void pxa2xx_configure_sockets(struct device *dev);
+void pxa2xx_configure_sockets(struct device *dev, struct pcmcia_low_level *ops);
 
diff --git a/drivers/pcmcia/sa1111_lubbock.c b/drivers/pcmcia/sa1111_lubbock.c
index 9d5ffc71ae51..7c1f0f6cd578 100644
--- a/drivers/pcmcia/sa1111_lubbock.c
+++ b/drivers/pcmcia/sa1111_lubbock.c
@@ -157,7 +157,7 @@ int pcmcia_lubbock_init(struct sa1111_dev *sadev)
 
 	if (machine_is_lubbock()) {
 		pxa2xx_drv_pcmcia_ops(&lubbock_pcmcia_ops);
-		pxa2xx_configure_sockets(&sadev->dev);
+		pxa2xx_configure_sockets(&sadev->dev, &lubbock_pcmcia_ops);
 		ret = sa1111_pcmcia_add(sadev, &lubbock_pcmcia_ops,
 				pxa2xx_drv_pcmcia_add_one);
 	}
-- 
2.1.4


[3] Lubbock boot dmesg
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.8.0-rc3-00080-g1aaa68426f0c-dirty (rj at belgarion) (gcc version 4.9.2 ( 4.9.2-10) ) #2070 Wed Aug 31 23:51:13 CEST 2016
[    0.000000] CPU: XScale-PXA255 [69052d06] revision 6 (ARMv5TE), cr=0000397f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Intel DBPXA250 Development Platform (aka Lubbock)
[    0.000000] Ignoring tag cmdline (using the default kernel command line)
[    0.000000] earlycon: pxa0 at I/O port 0xf6200000 (options '115200n8')
[    0.000000] bootconsole [pxa0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] Run Mode clock: 0.00MHz
[    0.000000] Turbo Mode clock: 0.00MHz
[    0.000000] Memory clock: 0.00MHz
[    0.000000] On node 0 totalpages: 16384
[    0.000000] free_area_init_node: node 0, pgdat c082816c, node_mem_map c3f79000
[    0.000000]   Normal zone: 128 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 16384 pages, LIFO batch:3
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
[    0.000000] Kernel command line: root=/dev/ram0 ip=192.168.1.230:192.168.1.5:192.168.1.1:255.255.255.0:lubbock nfsroot=/srv/nfs console=ttyS0,115200 mem=64M init=/init earlycon=pxa,io,0xf6200000,115200n8
[    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Memory: 56360K/65536K available (3239K kernel code, 138K rwdata, 796K rodata, 4024K init, 213K bss, 9176K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc4800000 - 0xff800000   ( 944 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0331e10   (3240 kB)
[    0.000000]       .init : 0xc0418000 - 0xc0806000   (4024 kB)
[    0.000000]       .data : 0xc0806000 - 0xc0828900   ( 139 kB)
[    0.000000]        .bss : 0xc0828900 - 0xc085e000   ( 214 kB)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:16 nr_irqs:304 304
[    0.000114] sched_clock: 32 bits at 3686kHz, resolution 271ns, wraps every 582542222200ns
[    0.008566] clocksource: oscr0: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 518462577799 ns
[    0.018973] Console: colour dummy device 80x30
[    0.023584] Calibrating delay loop... 99.22 BogoMIPS (lpj=496128)
[    0.111082] pid_max: default: 32768 minimum: 301
[    0.116494] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.123275] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.135194] CPU: Testing write buffer coherency: ok
[    0.142953] Setting up static identity map for 0xa0008200 - 0xa000826c
[    0.158820] devtmpfs: initialized
[    0.174104] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.187473] NET: Registered protocol family 16
[    0.197820] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.230917] Lubbock configured to boot from Flash (bank 1)
[    0.244372] SA1111 Microprocessor Companion Chip: silicon revision 1, metal revision 1
[    0.256347] sa1111 sa1111: Providing IRQ336-390
[    0.341129] clocksource: Switched to clocksource oscr0
[    0.480900] NET: Registered protocol family 2
[    0.491029] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.498548] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.505134] TCP: Hash tables configured (established 1024 bind 1024)
[    0.512320] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.518318] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.526083] NET: Registered protocol family 1
[    0.533923] RPC: Registered named UNIX socket transport module.
[    0.539970] RPC: Registered udp transport module.
[    0.545013] RPC: Registered tcp transport module.
[    0.549769] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.611252] random: fast init done
[    4.602524] NetWinder Floating Point Emulator V0.97 (double precision)
[    4.618163] futex hash table entries: 256 (order: -1, 3072 bytes)
[    4.626714] workingset: timestamp_bits=30 max_order=14 bucket_order=0
[    4.744565] NFS: Registering the id_resolver key type
[    4.749885] Key type id_resolver registered
[    4.754304] Key type id_legacy registered
[    4.758459] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    4.765569] jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
[    4.787241] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    4.795072] io scheduler noop registered
[    4.799064] io scheduler deadline registered
[    4.805440] io scheduler cfq registered (default)
[    5.598819] pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq = 38, base_baud = 921600) is a UART1
[    5.607998] console [ttyS0] enabled
[    5.615110] bootconsole [pxa0] disabled
[    5.626365] pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 37, base_baud = 921600) is a UART2
[    5.638730] pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 36, base_baud = 921600) is a UART3
[    5.794222] brd: module loaded
[    5.807555] Probing application-flash at physical address 0x00000000 (32-bit bankwidth)
[    5.816198] application-flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000089 Chip ID 0x000018
[    5.826804] application-flash: Found an alias at 0x2000000 for the chip at 0x0
[    5.826893] Intel/Sharp Extended Query Table at 0x0031
[    5.832199] Intel/Sharp Extended Query Table at 0x0031
[    5.837431] Using buffer write method
[    5.841210] cfi_cmdset_0001: Erase suspend on write enabled
[    5.846884] erase region 0: offset=0x0,size=0x40000,blocks=128
[    5.847827] Searching for RedBoot partition table in application-flash at offset 0x1fc0000
[    5.866264] No RedBoot partition table detected in application-flash
[    5.873505] Creating 3 MTD partitions on "application-flash":
[    5.879560] 0x000000000000-0x000000040000 : "Bootloader"
[    5.897858] 0x000000040000-0x000000140000 : "Kernel"
[    5.915722] 0x000000140000-0x000002000000 : "Filesystem"
[    5.942646] Probing boot-rom at physical address 0x04000000 (32-bit bankwidth)
[    5.950187] boot-rom: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000089 Chip ID 0x000018
[    5.960237] boot-rom: Found an alias at 0x2000000 for the chip at 0x0
[    5.960326] Intel/Sharp Extended Query Table at 0x0031
[    5.965630] Intel/Sharp Extended Query Table at 0x0031
[    5.970861] Using buffer write method
[    5.974639] cfi_cmdset_0001: Erase suspend on write enabled
[    5.980310] erase region 0: offset=0x0,size=0x40000,blocks=128
[    5.981318] Searching for RedBoot partition table in boot-rom at offset 0x1fc0000
[    5.998817] No RedBoot partition table detected in boot-rom
[    6.051635] smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@fluxnic.net>
[    6.065113] smc91x smc91x eth0: SMC91C94 (rev 9) at c4846c00 IRQ 307
[    6.071860]  [nowait]
[    6.074248] smc91x smc91x eth0: Ethernet addr: 00:02:b3:92:a8:21
[    6.081391] udc-core: couldn't find an available UDC - added [zero] to list of pending drivers
[    6.098363] mousedev: PS/2 mouse device common for all mice
[    6.116546] Key type dns_resolver registered
[    6.122655] XScale DSP coprocessor detected.
[    6.158065] smc91x smc91x eth0: link up
[    6.192158] IP-Config: Complete:
[    6.195595]      device=eth0, hwaddr=00:02:b3:92:a8:21, ipaddr=192.168.1.230, mask=255.255.255.0, gw=192.168.1.1
[    6.206072]      host=lubbock, domain=, nis-domain=(none)
[    6.211615]      bootserver=192.168.1.5, rootserver=192.168.1.5, rootpath=
[    6.280332] Freeing unused kernel memory: 4024K (c0418000 - c0806000)
[    6.287068] This architecture does not have kernel memory protection.
[    7.171675] atkbd serio0: keyboard reset failed on 0a00
[    7.177087] ------------[ cut here ]------------
[    7.181895] WARNING: CPU: 0 PID: 17 at kernel/irq/manage.c:527 enable_irq+0x58/0x70
[    7.189606] Unbalanced enable for IRQ 357
[    7.193662] Modules linked in:
[    7.196854] CPU: 0 PID: 17 Comm: kworker/0:1 Not tainted 4.8.0-rc3-00080-g1aaa68426f0c-dirty #2070
[    7.205878] Hardware name: Intel DBPXA250 Development Platform (aka Lubbock)
[    7.213055] Workqueue: events_long serio_handle_event
[    7.218386] [<c0015260>] (unwind_backtrace) from [<c00122f0>] (show_stack+0x10/0x14)
[    7.226312] [<c00122f0>] (show_stack) from [<c001ea40>] (__warn+0xcc/0xf8)
[    7.233334] [<c001ea40>] (__warn) from [<c001eaa0>] (warn_slowpath_fmt+0x34/0x44)
[    7.240964] [<c001eaa0>] (warn_slowpath_fmt) from [<c0047d44>] (enable_irq+0x58/0x70)
[    7.248935] [<c0047d44>] (enable_irq) from [<c0250df4>] (ps2_write+0x4c/0x78)
[    7.256211] [<c0250df4>] (ps2_write) from [<c025107c>] (ps2_sendbyte+0x50/0x144)
[    7.263746] [<c025107c>] (ps2_sendbyte) from [<c02513b0>] (__ps2_command+0xc0/0x3c4)
[    7.271630] [<c02513b0>] (__ps2_command) from [<c02516d8>] (ps2_command+0x24/0x38)
[    7.279389] [<c02516d8>] (ps2_command) from [<c0259968>] (atkbd_probe+0x60/0x140)
[    7.287026] [<c0259968>] (atkbd_probe) from [<c025a950>] (atkbd_connect+0x130/0x238)
[    7.294901] [<c025a950>] (atkbd_connect) from [<c0250ae4>] (serio_driver_probe+0x28/0x3c)
[    7.303251] [<c0250ae4>] (serio_driver_probe) from [<c020c410>] (driver_probe_device+0x124/0x28c)
[    7.312276] [<c020c410>] (driver_probe_device) from [<c020c5f8>] (__driver_attach+0x80/0xa4)
[    7.320852] [<c020c5f8>] (__driver_attach) from [<c020ac5c>] (bus_for_each_dev+0x6c/0x90)
[    7.329167] [<c020ac5c>] (bus_for_each_dev) from [<c0250984>] (serio_handle_event+0x154/0x1a0)
[    7.337933] [<c0250984>] (serio_handle_event) from [<c0030638>] (process_one_work+0x1bc/0x300)
[    7.346688] [<c0030638>] (process_one_work) from [<c0030d1c>] (worker_thread+0x2bc/0x3f8)
[    7.355043] [<c0030d1c>] (worker_thread) from [<c0034da0>] (kthread+0xc4/0xd8)
[    7.362418] [<c0034da0>] (kthread) from [<c000f0f0>] (ret_from_fork+0x14/0x24)
[    7.369720] ---[ end trace 52001af966019111 ]---
[    9.091294] atkbd serio1: keyboard reset failed on 0c00
[    9.096726] ------------[ cut here ]------------
[    9.101541] WARNING: CPU: 0 PID: 17 at kernel/irq/manage.c:527 enable_irq+0x58/0x70
[    9.109261] Unbalanced enable for IRQ 354
[    9.113316] Modules linked in:
[    9.116506] CPU: 0 PID: 17 Comm: kworker/0:1 Tainted: G        W       4.8.0-rc3-00080-g1aaa68426f0c-dirty #2070
[    9.126747] Hardware name: Intel DBPXA250 Development Platform (aka Lubbock)
[    9.133922] Workqueue: events_long serio_handle_event
[    9.139247] [<c0015260>] (unwind_backtrace) from [<c00122f0>] (show_stack+0x10/0x14)
[    9.147172] [<c00122f0>] (show_stack) from [<c001ea40>] (__warn+0xcc/0xf8)
[    9.154195] [<c001ea40>] (__warn) from [<c001eaa0>] (warn_slowpath_fmt+0x34/0x44)
[    9.161824] [<c001eaa0>] (warn_slowpath_fmt) from [<c0047d44>] (enable_irq+0x58/0x70)
[    9.169796] [<c0047d44>] (enable_irq) from [<c0250df4>] (ps2_write+0x4c/0x78)
[    9.177072] [<c0250df4>] (ps2_write) from [<c025107c>] (ps2_sendbyte+0x50/0x144)
[    9.184608] [<c025107c>] (ps2_sendbyte) from [<c02513b0>] (__ps2_command+0xc0/0x3c4)
[    9.192491] [<c02513b0>] (__ps2_command) from [<c02516d8>] (ps2_command+0x24/0x38)
[    9.200250] [<c02516d8>] (ps2_command) from [<c0259968>] (atkbd_probe+0x60/0x140)
[    9.207886] [<c0259968>] (atkbd_probe) from [<c025a950>] (atkbd_connect+0x130/0x238)
[    9.215770] [<c025a950>] (atkbd_connect) from [<c0250ae4>] (serio_driver_probe+0x28/0x3c)
[    9.224120] [<c0250ae4>] (serio_driver_probe) from [<c020c410>] (driver_probe_device+0x124/0x28c)
[    9.233143] [<c020c410>] (driver_probe_device) from [<c020c5f8>] (__driver_attach+0x80/0xa4)
[    9.241720] [<c020c5f8>] (__driver_attach) from [<c020ac5c>] (bus_for_each_dev+0x6c/0x90)
[    9.250037] [<c020ac5c>] (bus_for_each_dev) from [<c0250984>] (serio_handle_event+0x154/0x1a0)
[    9.258802] [<c0250984>] (serio_handle_event) from [<c0030638>] (process_one_work+0x1bc/0x300)
[    9.267556] [<c0030638>] (process_one_work) from [<c0030d1c>] (worker_thread+0x2bc/0x3f8)
[    9.275912] [<c0030d1c>] (worker_thread) from [<c0034da0>] (kthread+0xc4/0xd8)
[    9.283287] [<c0034da0>] (kthread) from [<c000f0f0>] (ret_from_fork+0x14/0x24)
[    9.290587] ---[ end trace 52001af966019112 ]---
[  118.294784] random: crng init done
