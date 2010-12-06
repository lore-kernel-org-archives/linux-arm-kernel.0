From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 06 Dec 2010 15:09:41 +0100
Subject: [PATCH] ARM: mx3/pcm037: properly allocate memory for mx3-camera
In-Reply-To: <20101206114629.GB31777@n2100.arm.linux.org.uk>
References: <1290505382-16110-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20101123101210.GA18170@n2100.arm.linux.org.uk>
	<20101123102632.GM4693@pengutronix.de>
	<1290521329.3901.14.camel@realization>
	<20101123141713.GQ4693@pengutronix.de>
	<20101124080214.GU4693@pengutronix.de>
	<20101206083306.GI10693@pengutronix.de>
	<1291630492.3151.14.camel@realization>
	<20101206102602.GE29563@n2100.arm.linux.org.uk>
	<1291635442.3151.39.camel@realization>
	<20101206114629.GB31777@n2100.arm.linux.org.uk>
Message-ID: <1291644581.3151.89.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On lun, 2010-12-06 at 11:46 +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 06, 2010 at 12:37:22PM +0100, Alberto Panizzo wrote:
> > On lun, 2010-12-06 at 10:26 +0000, Russell King - ARM Linux wrote:
> > > On Mon, Dec 06, 2010 at 11:14:52AM +0100, Alberto Panizzo wrote:
> > > > Uwe, the following function works for me:
> > > > +static void __init mx31_3ds_reserve(void)
> > > > +{
> > > > +       long ret;
> > > > +       /* reserve MX3_CAMERA_BUF_SIZE for mx3-camera */
> > > > +       mx3_camera_base = memblock_alloc(MX3_CAMERA_BUF_SIZE,
> > > > +                       /* ??? */ MX3_CAMERA_BUF_SIZE);
> > > > +       memblock_free(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
> > > > +       memblock_remove(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
> > > > +       if (!mx3_camera_base) {
> > > > +               pr_err("%s: Wrong base allocation\n", __func__);
> > > > +               return;
> > > > +       }
> > > > +       ret = memblock_reserve(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
> > > > +       if (ret) {
> > > > +               pr_err("%s: Memory not reserved\n", __func__);
> > > > +               return;
> > > > +       }
> > > > +}
> > > > 
> > > > The basic Idea is: why a region allocated, freed and removed can
> > > > be declared safely as dma memory for the camera in a second time?
> > > > Instead, I used the reserve API on the previous region so I am
> > > > sure that region is not used by someone else before declaring it
> > > > ad dma region for camera.
> > > > 
> > > > The ugly part of this code is that memblock_reserve want a base address
> > > > that I have to decide before and I am supposing that the base address
> > > > resulting from the allocate/free/remove operations, can be safely fed 
> > > > to it.
> > > 
> > > It really is not on to have a region of memory marked as being reserved
> > > and at the same time tell memblock that it's not part of the memory map.
> > > When we pass this information to bootmem, we will reserve a region which
> > > does not exist in the memory map.
> > > 
> > > Try passing memblock=debug to get a display of the memblock information
> > > at boot time - and debugging a bit further from there.
> > 
> > Ok, I've done as you suggested and the results are the following debug:
> > 
....
> 
> And the memblock debug output?

The following is the complete debug:

Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.36-10808-ga06e72c-dirty (alberto at realization) (gcc version 4.3.2 (OSELAS.Toolchain-1.99.3) ) #180 PREEMPT Mon Dec 6 14:24:53 CET 2010
[    0.000000] CPU: ARMv6-compatible processor [4107b364] revision 4 (ARMv6TEJ), cr=00c5387f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] Machine: Freescale MX31PDK (3DS)

[    0.000000] mx31_3ds_reserve: Reserved 8388608 bytes from address 0x87800000

Removed 8 MB from the memory map. Start address 0x87800000 

[    0.000000] MEMBLOCK configuration:
[    0.000000]  rmo_size    = 0x0
[    0.000000]  memory.size = 0x7800000
[    0.000000]  memory.cnt  = 0x1
[    0.000000]  memory[0x0]	0x0000000080000000 - 0x00000000877fffff, 0x7800000 bytes
[    0.000000]  reserved.cnt  = 0x1
[    0.000000]  reserved[0x0]	0x0000000080004000 - 0x0000000080415ed7, 0x411ed8 bytes

That's true, because otherwise (without reserving memory) I get:
>>[    0.000000]  memory[0x0]	0x0000000080000000 - 0x0000000087ffffff, 0x8000000 bytes

[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c03fcb90, node_mem_map c0416000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32512 pages, LIFO batch:7
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: console=tty0 console=ttymxc0 video=mx3fb:Epson-VGA,bpp=16 rootfstype=nfs root=/dev/nfs nfsroot=192.168.0.2:/nfs/mx31_3ds_root ip=192.168.0.3:192.168.0.2:192.168.0.2:255.255.255.0:mx31pdk:eth0:off debug memblock=debug
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Memory: 125764k/125764k available, 5308k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xff600000 - 0xffe00000   (   8 MB)
[    0.000000]     vmalloc : 0xc8800000 - 0xf4000000   ( 696 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0028000   ( 128 kB)
[    0.000000]       .text : 0xc0028000 - 0xc03c0000   (3680 kB)
[    0.000000]       .data : 0xc03da000 - 0xc03fd220   ( 141 kB)
[    0.000000] Preemptable hierarchical RCU implementation.
[    0.000000] 	RCU-based detection of stalled CPUs is disabled.
[    0.000000] 	Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:180
[    0.000000] MXC IRQ initialized
[    0.000000] MXC GPIO hardware
[    0.000000] Clock input source is 26000000
[    0.000000] CPU identified as i.MX31, silicon rev 2.0
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
[    0.000000] Calibrating delay loop... 530.84 BogoMIPS (lpj=2654208)
[    0.250000] pid_max: default: 32768 minimum: 301
[    0.250000] Mount-cache hash table entries: 512
[    0.250000] CPU: Testing write buffer coherency: ok
[    0.260000] regulator: core version 0.5
[    0.260000] NET: Registered protocol family 16
[    0.280000] 3-Stack Debug board detected, rev = 0x0200
[    0.280000] L210 cache controller enabled
[    0.280000] l2x0: 8 ways, CACHE_ID 0x41000040, AUX_CTRL 0x00030024
[    0.320000] bio: create slab <bio-0> at 0
[    0.320000] usbcore: registered new interface driver usbfs
[    0.320000] usbcore: registered new interface driver hub
[    0.320000] usbcore: registered new device driver usb
[    0.350000] Switching to clocksource mxc_timer1
[    0.390000] NET: Registered protocol family 2
[    0.390000] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.390000] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.390000] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.390000] TCP: Hash tables configured (established 4096 bind 4096)
[    0.390000] TCP reno registered
[    0.390000] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.390000] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.390000] NET: Registered protocol family 1
[    0.390000] RPC: Registered udp transport module.
[    0.390000] RPC: Registered tcp transport module.
[    0.390000] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.400000] JFFS2 version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
[    0.400000] msgmni has been set to 245
[    0.400000] io scheduler noop registered
[    0.400000] io scheduler deadline registered
[    0.400000] io scheduler cfq registered (default)
[    0.400000] private_candidate: dma0chan0 filter said false
[    0.400000] private_candidate: dma0chan1 filter said false
[    0.400000] private_candidate: dma0chan2 filter said false
[    0.400000] private_candidate: dma0chan3 filter said false
[    0.400000] private_candidate: dma0chan4 filter said false
[    0.400000] private_candidate: dma0chan5 filter said false
[    0.400000] private_candidate: dma0chan6 filter said false
[    0.400000] private_candidate: dma0chan7 filter said false
[    0.400000] private_candidate: dma0chan8 filter said false
[    0.400000] private_candidate: dma0chan9 filter said false
[    0.400000] private_candidate: dma0chan10 filter said false
[    0.400000] private_candidate: dma0chan11 filter said false
[    0.400000] private_candidate: dma0chan12 filter said false
[    0.400000] private_candidate: dma0chan13 filter said false
[    0.500000] __dma_request_channel: success (dma0chan14)
[    0.530000] mx3_sdc_fb mx3_sdc_fb: registered, using mode Epson-VGA
[    0.660000] Console: switching to colour frame buffer device 60x40
[    0.670000] Serial: IMX driver
[    0.670000] imx-uart.0: ttymxc0 at MMIO 0x43f90000 (irq = 45) is a IMX
[    0.670000] Serial: Console IMX rounded baud rate from 115201 to 115200
[    2.190000] console [ttymxc0] enabled
[    2.210000] NAND device: Manufacturer ID: 0xec, Chip ID: 0xaa (Samsung NAND 256MiB 1,8V 8-bit)
[    2.240000] Scanning device for bad blocks
[    2.800000] Bad eraseblock 759 at 0x000005ee0000
[    3.420000] Bad eraseblock 1575 at 0x00000c4e0000
[    3.450000] Bad eraseblock 1611 at 0x00000c960000
[    3.790000] Bad eraseblock 2046 at 0x00000ffc0000
[    3.800000] Bad eraseblock 2047 at 0x00000ffe0000
[    3.810000] RedBoot partition parsing not available
[    3.820000] Registering mxc_nand as whole device
[    4.330000] spi_imx imx31-cspi.1: probed
[    4.710000] l4f00242t03 spi0.0: Epson l4f00242t03 lcd probed.
[    4.730000] spi_imx imx31-cspi.0: probed
[    4.740000] FEC Ethernet Driver
[    4.750000] smsc911x: Driver version 2008-10-21.
[    4.770000] smsc911x-mdio: probed
[    4.780000] eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=0:01, irq=-1)
[    4.800000] net eth0: MAC Address: 00:04:9f:00:b0:68
[    4.810000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.840000] input: imx-keypad as /class/input/input0
[    4.850000] i2c /dev entries driver
[    4.860000] Linux video capture interface: v2.00
[    4.880000] Driver for 1-wire Dallas network protocol.
[    4.890000] i.MX SDHC driver
[    4.900000] regulator regulator.4: mc13783_regulator_get_voltage id: 22
[    4.930000] TCP cubic registered
[    4.940000] NET: Registered protocol family 17
[    4.950000] regulator regulator.4: mc13783_regulator_get_voltage id: 22 val: 5
[    4.970000] Registering the dns_resolver key type
[    4.980000] VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2
[    5.620000] net eth0: SMSC911x/921x identified at 0xc8886000, IRQ: 160
[    6.650000] IP-Config: Complete:
[    6.650000]      device=eth0, addr=192.168.0.3, mask=255.255.255.0, gw=192.168.0.2,
[    6.670000]      host=mx31pdk, domain=, nis-domain=(none),
[    6.680000]      bootserver=192.168.0.2, rootserver=192.168.0.2, rootpath=
[    6.720000] Looking up port of RPC 100003/2 on 192.168.0.2
[    8.750000] Looking up port of RPC 100005/1 on 192.168.0.2
[    9.170000] VFS: Mounted root (nfs filesystem) on device 0:11.
[    9.200000] Freeing init memory: 128K

...

[   12.650000] camera 0-0: Probing 0-0
[   12.670000] regulator regulator.7: mc13783_regulator_enable id: 18
[   12.820000] mx3-camera mx3-camera.0: MX3 Camera driver attached to camera 0
[   12.910000] ov2640 0-0030: ov2640 Product ID 26:42 Manufacturer ID 7f:a2
[   12.930000] i2c i2c-0: OV2640 Probed
[   13.050000] mx3-camera mx3-camera.0: MX3 Camera driver detached from camera 0
[   13.080000] regulator regulator.7: mc13783_regulator_disable id: 18

...

root at phyCORE:~ gst-launch -v v4l2src device=/dev/video0 num-buffers=1 ! video/x-
raw-rgb,width=320,height=240,format=RGBP ! filesink location=/root/capture.raw
Setting pipeline to PAUSED ...
[   80.460000] regulator regulator.7: mc13783_regulator_enable id: 18
[   80.620000] mx3-camera mx3-camera.0: MX3 Camera driver attached to camera 0
[   80.640000] private_candidate: dma0chan0 filter said false
[   80.660000] private_candidate: dma0chan1 filter said false
[   80.680000] private_candidate: dma0chan2 filter said false
[   80.700000] private_candidate: dma0chan3 filter said false
[   80.720000] private_candidate: dma0chan4 filter said false
[   80.740000] private_candidate: dma0chan5 filter said false
[   80.760000] private_candidate: dma0chan6 filter said false
[   80.780000] __dma_request_channel: success (dma0chan7)

** (gst-launch-0.10:646): CRITIC[   80.910000] private_candidate: dma0chan0 filter said false
AL **: gst_v4l2src_fixate: assert[   80.930000] private_candidate: dma0chan1 filter said false
ion `G_VALUE_TYPE (v) == GST_TYPE[   80.960000] private_candidate: dma0chan2 filter said false
_LIST' failed
[   80.980000] private_candidate: dma0chan3 filter said false
[   81.000000] private_candidate: dma0chan4 filter said false
[   81.020000] private_candidate: dma0chan5 filter said false
[   81.050000] private_candidate: dma0chan6 filter said false
[   81.070000] __dma_request_channel: success (dma0chan7)
[   81.190000] mx3-camera mx3-camera.0: __videobuf_mmap_mapper
[   81.210000] mx3-camera mx3-camera.0: dma_alloc_coherent data is at addr c9000000 (size 155648)
[   81.230000] mx3-camera mx3-camera.0: mmap c7054d40: q=c7dddca8 40643000-40669000 (25800) pgoff 00087800 buf 0
[   81.260000] mx3-camera mx3-camera.0: vm_open c7054d40 [count=0,vma=40643000-40669000]
[   81.280000] mx3-camera mx3-camera.0: __videobuf_mmap_mapper
[   81.300000] mx3-camera mx3-camera.0: dma_alloc_coherent data is at addr c9040000 (size 155648)
[   81.330000] mx3-camera mx3-camera.0: mmap c7f72400: q=c7dddca8 406ce000-406f4000 (25800) pgoff 00087840 buf 1
[   81.360000] mx3-camera mx3-camera.0: vm_open c7f72400 [count=0,vma=406ce000-406f4000]
[   81.380000] mx3-camera mx3-camera.0: __videobuf_iolock memory method MMAP
[   81.400000] mx3-camera mx3-camera.0: __videobuf_iolock memory method MMAP

[   81.430000] rw_verify_area: inode

[   81.430000] Unable to handle kernel NULL pointer dereference at virtual address 00000098
[   81.460000] pgd = c7050000
[   81.470000] [00000098] *pgd=87f4c031, *pte=00000000, *ppte=00000000
[   81.490000] Internal error: Oops: 17 [#1] PREEMPT
[   81.490000] last sysfs file: /sys/kernel/uevent_seqnum
[   81.490000] Modules linked in: ov2640 mx3_camera soc_camera soc_mediabus videobuf_dma_contig videobuf_core
[   81.490000] CPU: 0    Not tainted  (2.6.36-10808-ga06e72c-dirty #180)
[   81.490000] PC is at rw_verify_area+0x80/0x110
[   81.490000] LR is at rw_verify_area+0x80/0x110
[   81.490000] pc : [<c00a4a1c>]    lr : [<c00a4a1c>]    psr: 60000013
[   81.490000] sp : c7faff30  ip : 00000000  fp : 00000003
[   81.490000] r10: 00000001  r9 : c7fae000  r8 : c7d8ce30
[   81.490000] r7 : 0000010f  r6 : 00000000  r5 : 00000000  r4 : 00000000
[   81.490000] r3 : 00000000  r2 : 00000000  r1 : c7fae000  r0 : 0000002a
[   81.490000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   81.490000] Control: 00c5387d  Table: 87050000  DAC: 00000015
[   81.490000] Process gst-launch-0.10 (pid: 646, stack limit = 0xc7fae268)
[   81.490000] Stack: (0xc7faff30 to 0xc7fb0000)
[   81.490000] ff20:                                     c7d8de10 00000026 00000000 c7d8de10
[   81.490000] ff40: 00000001 c7d8ce30 00000000 400b0000 c7faff80 0000010f 00000000 c00a5288
[   81.490000] ff60: c7fae000 c7d8de10 00000000 00000000 c7d8ce30 400b0000 0000010f c00a53f8
[   81.490000] ff80: 00000000 00000000 c0029048 00000000 0000010f 400b0000 4044f5e0 00000004
[   81.490000] ffa0: c0029048 c0028ea0 0000010f 400b0000 00000001 400b0000 0000010f 00000000
[   81.490000] ffc0: 0000010f 400b0000 4044f5e0 00000004 0000010f 00000000 0008b40f 00000003
[   81.490000] ffe0: 00000000 bee16f08 40393d1c 403e2f0c 60000010 00000001 bfffffef ffffff7f
[   81.490000] [<c00a4a1c>] (rw_verify_area+0x80/0x110) from [<c00a5288>] (vfs_write+0x80/0x138)
[   81.490000] [<c00a5288>] (vfs_write+0x80/0x138) from [<c00a53f8>] (sys_write+0x40/0x6c)
[   81.490000] [<c00a53f8>] (sys_write+0x40/0x6c) from [<c0028ea0>] (ret_fast_syscall+0x0/0x30)
[   81.490000] Code: 1a000002 e59f0088 e59f107c eb0916b7 (e5963098) 
[   81.990000] ---[ end trace 96af8e948c5e83d0 ]---
[   82.010000] kernel BUG at lib/prio_tree.c:149!
[   82.010000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[   82.010000] pgd = c0004000
[   82.010000] [00000000] *pgd=00000000
[   82.010000] Internal error: Oops: 817 [#2] PREEMPT
[   82.010000] last sysfs file: /sys/kernel/uevent_seqnum
[   82.010000] Modules linked in: ov2640 mx3_camera soc_camera soc_mediabus videobuf_dma_contig videobuf_core
[   82.010000] CPU: 0    Tainted: G      D      (2.6.36-10808-ga06e72c-dirty #180)
[   82.010000] PC is at __bug+0x1c/0x28
[   82.010000] LR is at __bug+0x18/0x28
[   82.010000] pc : [<c002c634>]    lr : [<c002c630>]    psr: 60000193
[   82.010000] sp : c7fafc38  ip : 000041a8  fp : 00000001
[   82.010000] r10: 00001000  r9 : c03de2c8  r8 : c700a148
[   82.010000] r7 : 00000001  r6 : c785ff84  r5 : 00004a84  r4 : c7dd4928
[   82.010000] r3 : 00000000  r2 : 00000003  r1 : 000041a8  r0 : 00000038
[   82.010000] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   82.010000] Control: 00c5387d  Table: 87050000  DAC: 00000015
[   82.010000] Process gst-launch-0.10 (pid: 646, stack limit = 0xc7fae268)
[   82.010000] Stack: (0xc7fafc38 to 0xc7fb0000)
[   82.010000] fc20:                                                       c7f48648 c01a5eb0
[   82.010000] fc40: c7f4864c c01a5ff0 c7fae000 c700a120 c700a120 40002000 00000000 c00925a0
[   82.010000] fc60: c03de2c8 c0092604 c7dd4900 c0090178 40002000 c7fae000 c7fae000 c03de2c8
[   82.010000] fc80: 00000000 c700a740 c7fc6b40 00000008 bf000000 c00920a8 c7fafca0 00000000
[   82.010000] fca0: 000000d6 c03de2c8 c7fc6b40 00000000 c7fc6b40 c7fc6b74 00000000 c003f5d8
[   82.010000] fcc0: c7fae000 c7fae000 c7c9d060 c00436cc c7fafd57 c7c9d060 c00a4a20 0000000b
[   82.010000] fce0: c7fafd57 c7c9d060 c00a4a20 c0045064 00000008 bf000000 00000000 00000001
[   82.010000] fd00: c7fafd57 c00a4a1e c00a4a20 00000000 00000008 bf000000 00000000 c002cbf0
[   82.010000] fd20: c7fae268 0000000b 5d303030 00000000 31ce5f00 30303061 20323030 66393565
[   82.010000] fd40: 38383030 39356520 37303166 62652063 36313930 28203762 36393565 38393033
[   82.010000] fd60: 00002029 00000000 00000017 00000098 c7fafee8 c7fc6b40 00000017 00000000
[   82.010000] fd80: 00000017 c7fafee8 00000003 c002f534 00010000 c7c9d060 00000098 c7fc6b40
[   82.010000] fda0: c7fc6b74 c002f72c 00000008 00000010 00000007 00000000 60000001 c030350c
[   82.010000] fdc0: c7fafec5 c7fafdf6 c7fafec5 00000006 00000001 00000000 ffffffff 00000007
[   82.010000] fde0: c01c17f8 00000000 c7fafe40 ffffffff c040cf04 c7d63248 00000024 c0060030
[   82.010000] fe00: 00000000 00000000 c7c05de0 c7c05de0 00000065 00000024 00000024 c0060054
[   82.010000] fe20: 00000000 c01dba0c c03de054 c7faff1c 00000017 c7fafee8 00000098 20000113
[   82.010000] fe40: 00000001 c00282c4 00000221 c03f1798 00003829 00000024 c03e5450 c03e5454
[   82.010000] fe60: ffffffff ffffc7b3 c03e5450 c0041998 0000384d 0000384d c7fae000 60000093
[   82.010000] fe80: 0000384d c00421d8 c0401b33 00000000 00000012 c7fafecd c0401b33 00000015
[   82.010000] fea0: 0000002a c7fafecd c7fafebe c0042888 00000033 60000013 c02ea920 205bbf58
[   82.010000] fec0: 31382020 3033342e 5d303030 c7fa0020 ffffffff c7faff1c 00000000 0000010f
[   82.010000] fee0: c7d8ce30 c0028a4c 0000002a c7fae000 00000000 00000000 00000000 00000000
[   82.010000] ff00: 00000000 0000010f c7d8ce30 c7fae000 00000001 00000003 00000000 c7faff30
[   82.010000] ff20: c00a4a1c c00a4a1c 60000013 ffffffff c7d8de10 00000026 00000000 c7d8de10
[   82.010000] ff40: 00000001 c7d8ce30 00000000 400b0000 c7faff80 0000010f 00000000 c00a5288
[   82.010000] ff60: c7fae000 c7d8de10 00000000 00000000 c7d8ce30 400b0000 0000010f c00a53f8
[   82.010000] ff80: 00000000 00000000 c0029048 00000000 0000010f 400b0000 4044f5e0 00000004
[   82.010000] ffa0: c0029048 c0028ea0 0000010f 400b0000 00000001 400b0000 0000010f 00000000
[   82.010000] ffc0: 0000010f 400b0000 4044f5e0 00000004 0000010f 00000000 0008b40f 00000003
[   82.010000] ffe0: 00000000 bee16f08 40393d1c 403e2f0c 60000010 00000001 bfffffef ffffff7f
[   82.010000] [<c002c634>] (__bug+0x1c/0x28) from [<c01a5eb0>] (prio_tree_replace+0x3c/0x90)
[   82.010000] [<c01a5eb0>] (prio_tree_replace+0x3c/0x90) from [<c01a5ff0>] (prio_tree_remove+0xec/0x104)
[   82.010000] [<c01a5ff0>] (prio_tree_remove+0xec/0x104) from [<c00925a0>] (__remove_shared_vm_struct+0x98/0xd0)
[   82.010000] [<c00925a0>] (__remove_shared_vm_struct+0x98/0xd0) from [<c0092604>] (unlink_file_vma+0x2c/0x4c)
[   82.010000] [<c0092604>] (unlink_file_vma+0x2c/0x4c) from [<c0090178>] (free_pgtables+0x64/0xa4)
[   82.010000] [<c0090178>] (free_pgtables+0x64/0xa4) from [<c00920a8>] (exit_mmap+0x10c/0x1d8)
[   82.010000] [<c00920a8>] (exit_mmap+0x10c/0x1d8) from [<c003f5d8>] (mmput+0x38/0x114)
[   82.010000] [<c003f5d8>] (mmput+0x38/0x114) from [<c00436cc>] (exit_mm+0x140/0x14c)
[   82.010000] [<c00436cc>] (exit_mm+0x140/0x14c) from [<c0045064>] (do_exit+0x180/0x638)
[   82.010000] [<c0045064>] (do_exit+0x180/0x638) from [<c002cbf0>] (die+0x2bc/0x2fc)
[   82.010000] [<c002cbf0>] (die+0x2bc/0x2fc) from [<c002f534>] (__do_kernel_fault+0x64/0x84)
[   82.010000] [<c002f534>] (__do_kernel_fault+0x64/0x84) from [<c002f72c>] (do_page_fault+0x1d8/0x1f0)
[   82.010000] [<c002f72c>] (do_page_fault+0x1d8/0x1f0) from [<c00282c4>] (do_DataAbort+0x34/0x94)
[   82.010000] [<c00282c4>] (do_DataAbort+0x34/0x94) from [<c0028a4c>] (__dabt_svc+0x4c/0x80)
[   82.010000] Exception stack(0xc7fafee8 to 0xc7faff30)
[   82.010000] fee0:                   0000002a c7fae000 00000000 00000000 00000000 00000000
[   82.010000] ff00: 00000000 0000010f c7d8ce30 c7fae000 00000001 00000003 00000000 c7faff30
[   82.010000] ff20: c00a4a1c c00a4a1c 60000013 ffffffff
[   82.010000] [<c0028a4c>] (__dabt_svc+0x4c/0x80) from [<c00a4a1c>] (rw_verify_area+0x80/0x110)
[   82.010000] [<c00a4a1c>] (rw_verify_area+0x80/0x110) from [<c00a5288>] (vfs_write+0x80/0x138)
[   82.010000] [<c00a5288>] (vfs_write+0x80/0x138) from [<c00a53f8>] (sys_write+0x40/0x6c)
[   82.010000] [<c00a53f8>] (sys_write+0x40/0x6c) from [<c0028ea0>] (ret_fast_syscall+0x0/0x30)
[   82.010000] Code: e1a01000 e59f000c eb0af7b2 e3a03000 (e5833000) 
[   83.570000] ---[ end trace 96af8e948c5e83d1 ]---
[   83.580000] Fixing recursive fault but reboot is needed!
[   83.590000] BUG: scheduling while atomic: gst-launch-0.10/646/0x00000004
[   83.620000] Modules linked in: ov2640 mx3_camera soc_camera soc_mediabus videobuf_dma_contig videobuf_core
[   83.640000] [<c002e6b0>] (unwind_backtrace+0x0/0xec) from [<c02ea610>] (schedule+0x74/0x408)
[   83.670000] [<c02ea610>] (schedule+0x74/0x408) from [<c0044f9c>] (do_exit+0xb8/0x638)
[   83.690000] [<c0044f9c>] (do_exit+0xb8/0x638) from [<c002cbf0>] (die+0x2bc/0x2fc)
[   83.710000] [<c002cbf0>] (die+0x2bc/0x2fc) from [<c002f534>] (__do_kernel_fault+0x64/0x84)
[   83.740000] [<c002f534>] (__do_kernel_fault+0x64/0x84) from [<c002f72c>] (do_page_fault+0x1d8/0x1f0)
[   83.760000] [<c002f72c>] (do_page_fault+0x1d8/0x1f0) from [<c00282c4>] (do_DataAbort+0x34/0x94)
[   83.790000] [<c00282c4>] (do_DataAbort+0x34/0x94) from [<c0028a4c>] (__dabt_svc+0x4c/0x80)
[   83.810000] Exception stack(0xc7fafbf0 to 0xc7fafc38)
[   83.820000] fbe0:                                     00000038 000041a8 00000003 00000000
[   83.850000] fc00: c7dd4928 00004a84 c785ff84 00000001 c700a148 c03de2c8 00001000 00000001
[   83.870000] fc20: 000041a8 c7fafc38 c002c630 c002c634 60000193 ffffffff
[   83.900000] [<c0028a4c>] (__dabt_svc+0x4c/0x80) from [<c002c634>] (__bug+0x1c/0x28)
[   83.920000] [<c002c634>] (__bug+0x1c/0x28) from [<c01a5eb0>] (prio_tree_replace+0x3c/0x90)
[   83.940000] [<c01a5eb0>] (prio_tree_replace+0x3c/0x90) from [<c01a5ff0>] (prio_tree_remove+0xec/0x104)
[   83.970000] [<c01a5ff0>] (prio_tree_remove+0xec/0x104) from [<c00925a0>] (__remove_shared_vm_struct+0x98/0xd0)
[   84.000000] [<c00925a0>] (__remove_shared_vm_struct+0x98/0xd0) from [<c0092604>] (unlink_file_vma+0x2c/0x4c)
[   84.020000] [<c0092604>] (unlink_file_vma+0x2c/0x4c) from [<c0090178>] (free_pgtables+0x64/0xa4)
[   84.050000] [<c0090178>] (free_pgtables+0x64/0xa4) from [<c00920a8>] (exit_mmap+0x10c/0x1d8)
[   84.070000] [<c00920a8>] (exit_mmap+0x10c/0x1d8) from [<c003f5d8>] (mmput+0x38/0x114)
[   84.100000] [<c003f5d8>] (mmput+0x38/0x114) from [<c00436cc>] (exit_mm+0x140/0x14c)
[   84.120000] [<c00436cc>] (exit_mm+0x140/0x14c) from [<c0045064>] (do_exit+0x180/0x638)
[   84.140000] [<c0045064>] (do_exit+0x180/0x638) from [<c002cbf0>] (die+0x2bc/0x2fc)
[   84.170000] [<c002cbf0>] (die+0x2bc/0x2fc) from [<c002f534>] (__do_kernel_fault+0x64/0x84)
[   84.190000] [<c002f534>] (__do_kernel_fault+0x64/0x84) from [<c002f72c>] (do_page_fault+0x1d8/0x1f0)
[   84.220000] [<c002f72c>] (do_page_fault+0x1d8/0x1f0) from [<c00282c4>] (do_DataAbort+0x34/0x94)
[   84.240000] [<c00282c4>] (do_DataAbort+0x34/0x94) from [<c0028a4c>] (__dabt_svc+0x4c/0x80)
[   84.270000] Exception stack(0xc7fafee8 to 0xc7faff30)
[   84.280000] fee0:                   0000002a c7fae000 00000000 00000000 00000000 00000000
[   84.310000] ff00: 00000000 0000010f c7d8ce30 c7fae000 00000001 00000003 00000000 c7faff30
[   84.330000] ff20: c00a4a1c c00a4a1c 60000013 ffffffff
[   84.350000] [<c0028a4c>] (__dabt_svc+0x4c/0x80) from [<c00a4a1c>] (rw_verify_area+0x80/0x110)
[   84.370000] [<c00a4a1c>] (rw_verify_area+0x80/0x110) from [<c00a5288>] (vfs_write+0x80/0x138)
[   84.390000] [<c00a5288>] (vfs_write+0x80/0x138) from [<c00a53f8>] (sys_write+0x40/0x6c)
[   84.420000] [<c00a53f8>] (sys_write+0x40/0x6c) from [<c0028ea0>] (ret_fast_syscall+0x0/0x30)
[   84.440000] Unable to handle kernel paging request at virtual address 31c129c1
[   84.440000] pgd = c0004000
[   84.440000] [31c129c1] *pgd=00000000
[   84.440000] Internal error: Oops: 805 [#3] PREEMPT
[   84.440000] last sysfs file: /sys/kernel/uevent_seqnum
[   84.440000] Modules linked in: ov2640 mx3_camera soc_camera soc_mediabus videobuf_dma_contig videobuf_core
[   84.440000] CPU: 0    Tainted: G      D      (2.6.36-10808-ga06e72c-dirty #180)
[   84.440000] PC is at free_block+0x80/0x1c8
[   84.440000] LR is at drain_array+0xb0/0xfc
[   84.440000] pc : [<c00a1138>]    lr : [<c00a1330>]    psr: 00000193
[   84.440000] sp : c7d2bf08  ip : c7d2bf50  fp : c7c4eaac
[   84.440000] r10: 00000000  r9 : 00000000  r8 : c7856068
[   84.440000] r7 : c7c4ea20  r6 : c7c2a9c0  r5 : c7c2cf80  r4 : c7856020
[   84.440000] r3 : 31a231a1  r2 : 31c129c1  r1 : c7856020  r0 : c7c4ea20
[   84.440000] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[   84.440000] Control: 00c5387d  Table: 87050000  DAC: 00000017
[   84.440000] Process kworker/0:2 (pid: 284, stack limit = 0xc7d2a268)
[   84.440000] Stack: (0xc7d2bf08 to 0xc7d2c000)
[   84.440000] bf00:                   00000007 c7c2a9d0 c7fae000 c7c2a9d0 00000007 c7c2a9c0
[   84.440000] bf20: 00000000 c7c4ea20 c0405d98 00000005 c7c05315 c00a1330 c7c2cf80 c7c4ea20
[   84.440000] bf40: 00000000 c03eb95c c03e6110 c00a14ec 00000000 c7c62060 c03eb95c c7d5b500
[   84.440000] bf60: 00000003 00000000 c7c05300 c00a1490 00000000 c0054740 c03e67ec c7d5b500
[   84.440000] bf80: c03e67ec 00000009 c7d2a000 c03e67ec c7d5b510 c7d5b510 c03e696c c0054f20
[   84.440000] bfa0: c7c27f0c c7d2bfd4 c7c27f0c c7d5b500 c0054d00 00000000 00000000 00000000
[   84.440000] bfc0: 00000000 c005a670 c0029f0c 00000000 c7d5b500 00000000 c7d2bfd8 c7d2bfd8
[   84.440000] bfe0: 00000000 c7c27f0c c005a5f4 c0029f0c 00000013 c0029f0c 00ff00ff 00ff007f
[   84.440000] [<c00a1138>] (free_block+0x80/0x1c8) from [<c00a1330>] (drain_array+0xb0/0xfc)
[   84.440000] [<c00a1330>] (drain_array+0xb0/0xfc) from [<c00a14ec>] (cache_reap+0x5c/0x12c)
[   84.440000] [<c00a14ec>] (cache_reap+0x5c/0x12c) from [<c0054740>] (process_one_work+0x258/0x3c8)
[   84.440000] [<c0054740>] (process_one_work+0x258/0x3c8) from [<c0054f20>] (worker_thread+0x220/0x438)
[   84.440000] [<c0054f20>] (worker_thread+0x220/0x438) from [<c005a670>] (kthread+0x7c/0x84)
[   84.440000] [<c005a670>] (kthread+0x7c/0x84) from [<c0029f0c>] (kernel_thread_exit+0x0/0x8)
[   84.440000] Code: e1a00007 e5942004 e5943000 e1a01004 (e5823000) 
[   85.090000] ---[ end trace 96af8e948c5e83d2 ]---
[   85.100000] note: kworker/0:2[284] exited with preempt_count 1
[   85.120000] Unable to handle kernel paging request at virtual address 19221926
[   85.150000] pgd = c0004000
[   85.160000] [19221926] *pgd=00000000
[   85.170000] Internal error: Oops: 5 [#4] PREEMPT
[   85.170000] last sysfs file: /sys/kernel/uevent_seqnum
[   85.170000] Modules linked in: ov2640 mx3_camera soc_camera soc_mediabus videobuf_dma_contig videobuf_core
[   85.170000] CPU: 0    Tainted: G      D      (2.6.36-10808-ga06e72c-dirty #180)
[   85.170000] PC is at d_hash_and_lookup+0x5c/0x9c
[   85.170000] LR is at proc_flush_task+0x68/0x260
[   85.170000] pc : [<c00b7c90>]    lr : [<c00e79e8>]    psr: 20000113
[   85.170000] sp : c7d2bc30  ip : 00121bc5  fp : c7d2bc5f
[   85.170000] r10: c7c0d808  r9 : c7c1ce30  r8 : c7c1ce30
[   85.170000] r7 : 0000000b  r6 : c78017b0  r5 : 00000000  r4 : c7d2bc6c
[   85.170000] r3 : 19221922  r2 : 00000034  r1 : 00000003  r0 : c7d2bc5f
[   85.170000] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[   85.170000] Control: 00c5387d  Table: 87050000  DAC: 00000017
[   85.170000] Process kworker/0:2 (pid: 284, stack limit = 0xc7d2a268)
[   85.170000] Stack: (0xc7d2bc30 to 0xc7d2c000)
[   85.170000] bc20:                                     c7d2bc5f c7d2a000 c7d2bcc8 c7c1ce30
[   85.170000] bc40: 00000000 c00e79e8 00000000 0000011c 0000011c c7d2bc60 c00362e0 322eab9c
[   85.170000] bc60: 00003438 00000000 fffffffe 00121bc5 00000003 c7d2bc5f 00000001 c7c62060
[   85.170000] bc80: c7d2bcc8 c7c62060 c7d2a000 c7c6215c 00000000 c7c6215c 00000150 c0043dbc
[   85.170000] bca0: c00a113c ffffffff c7d2bcc8 c7c62060 c7c13ce0 c7c6215c c7c62058 c7c6215c
[   85.170000] bcc0: 00000001 c0045464 c7d2bcc8 c7d2bcc8 00000000 00000001 c7d2bd2f c00a113a
[   85.170000] bce0: c00a113c 00000000 00000008 00000000 00000000 c002cbf0 c7d2a268 0000000b
[   85.170000] bd00: 5d303030 00000000 65f91102 30306131 20373030 34393565 34303032 39356520
[   85.170000] bd20: 30303334 31652030 30313061 28203430 32383565 30303033 00002029 00000000
[   85.170000] bd40: 00000805 31c129c1 c7d2bec0 00000000 00000805 00000000 00000805 c7d2bec0
[   85.170000] bd60: c7c4eaac c002f534 c03de034 c7c62060 31c129c1 00000000 31c129c1 c002f72c
[   85.170000] bd80: c7c0ab40 c7f2ddd8 c7f5c9f0 c7fac0c4 00000000 c02aa58c ffffb5f0 c7f2ddd8
[   85.170000] bda0: c7f5c9f0 c02ab8ec c7f5c9f0 c7f2ddd8 c7fac0c4 0000106c c7f5ca08 c02ac5ec
[   85.170000] bdc0: 00005003 00000002 c04108fc 00000000 c040f7e0 c7fc0d21 c7d2be10 c7f5ca08
[   85.170000] bde0: 0300a8c0 0200a8c0 00000050 00000011 00000000 00000011 00000000 c040fdc8
[   85.170000] be00: c03de034 c7d2bef4 00000805 c7d2bec0 31c129c1 00000193 00000000 c00282c4
[   85.170000] be20: c7f5c9f0 c0288fcc 00000020 00000010 ff600000 c01c3b3c c040f84c 0000ad55
[   85.170000] be40: 00000000 00000000 ad55ad55 00000003 00000001 c7d228c0 c7d228c0 c7f5c9f0
[   85.170000] be60: 60000113 c026d188 60000113 c7f5c9f0 00000141 c0214804 c7f6d1a4 c7d5fbd0
[   85.170000] be80: c7ce5f00 c7d2bee0 c7d0a4c0 00000010 c7ce5f38 00000001 00000001 c01c225c
[   85.170000] bea0: 00000010 00000001 ffffffff c7d2bef4 c7c2a9c0 c7c4ea20 c7856068 c0028a4c
[   85.170000] bec0: c7c4ea20 c7856020 31c129c1 31a231a1 c7856020 c7c2cf80 c7c2a9c0 c7c4ea20
[   85.170000] bee0: c7856068 00000000 00000000 c7c4eaac c7d2bf50 c7d2bf08 c00a1330 c00a1138
[   85.170000] bf00: 00000193 ffffffff 00000007 c7c2a9d0 c7fae000 c7c2a9d0 00000007 c7c2a9c0
[   85.170000] bf20: 00000000 c7c4ea20 c0405d98 00000005 c7c05315 c00a1330 c7c2cf80 c7c4ea20
[   85.170000] bf40: 00000000 c03eb95c c03e6110 c00a14ec 00000000 c7c62060 c03eb95c c7d5b500
[   85.170000] bf60: 00000003 00000000 c7c05300 c00a1490 00000000 c0054740 c03e67ec c7d5b500
[   85.170000] bf80: c03e67ec 00000009 c7d2a000 c03e67ec c7d5b510 c7d5b510 c03e696c c0054f20
[   85.170000] bfa0: c7c27f0c c7d2bfd4 c7c27f0c c7d5b500 c0054d00 00000000 00000000 00000000
[   85.170000] bfc0: 00000000 c005a670 c0029f0c 00000000 c7d5b500 00000001 c7d2bfd8 c7d2bfd8
[   85.170000] bfe0: 00000000 c7c27f0c c005a5f4 c0029f0c 00000013 c0029f0c 00ff00ff 00ff007f
[   85.170000] [<c00b7c90>] (d_hash_and_lookup+0x5c/0x9c) from [<c00e79e8>] (proc_flush_task+0x68/0x260)
[   85.170000] [<c00e79e8>] (proc_flush_task+0x68/0x260) from [<c0043dbc>] (release_task+0x4c/0x37c)
[   85.170000] [<c0043dbc>] (release_task+0x4c/0x37c) from [<c0045464>] (do_exit+0x580/0x638)
[   85.170000] [<c0045464>] (do_exit+0x580/0x638) from [<c002cbf0>] (die+0x2bc/0x2fc)
[   85.170000] [<c002cbf0>] (die+0x2bc/0x2fc) from [<c002f534>] (__do_kernel_fault+0x64/0x84)
[   85.170000] [<c002f534>] (__do_kernel_fault+0x64/0x84) from [<c002f72c>] (do_page_fault+0x1d8/0x1f0)
[   85.170000] [<c002f72c>] (do_page_fault+0x1d8/0x1f0) from [<c00282c4>] (do_DataAbort+0x34/0x94)
[   85.170000] [<c00282c4>] (do_DataAbort+0x34/0x94) from [<c0028a4c>] (__dabt_svc+0x4c/0x80)
[   85.170000] Exception stack(0xc7d2bec0 to 0xc7d2bf08)
[   85.170000] bec0: c7c4ea20 c7856020 31c129c1 31a231a1 c7856020 c7c2cf80 c7c2a9c0 c7c4ea20
[   85.170000] bee0: c7856068 00000000 00000000 c7c4eaac c7d2bf50 c7d2bf08 c00a1330 c00a1138
[   85.170000] bf00: 00000193 ffffffff
[   85.170000] [<c0028a4c>] (__dabt_svc+0x4c/0x80) from [<c00a1138>] (free_block+0x80/0x1c8)
[   85.170000] [<c00a1138>] (free_block+0x80/0x1c8) from [<c00a1330>] (drain_array+0xb0/0xfc)
[   85.170000] [<c00a1330>] (drain_array+0xb0/0xfc) from [<c00a14ec>] (cache_reap+0x5c/0x12c)
[   85.170000] [<c00a14ec>] (cache_reap+0x5c/0x12c) from [<c0054740>] (process_one_work+0x258/0x3c8)
[   85.170000] [<c0054740>] (process_one_work+0x258/0x3c8) from [<c0054f20>] (worker_thread+0x220/0x438)
[   85.170000] [<c0054f20>] (worker_thread+0x220/0x438) from [<c005a670>] (kthread+0x7c/0x84)
[   85.170000] [<c005a670>] (kthread+0x7c/0x84) from [<c0029f0c>] (kernel_thread_exit+0x0/0x8)
[   85.170000] Code: e584c000 e596304c e3530000 0a00000a (e5933004) 
[   86.620000] ---[ end trace 96af8e948c5e83d3 ]---
[   86.640000] Fixing recursive fault but reboot is needed!
[   86.650000] Unable to handle kernel paging request at virtual address fffffffc
[   86.650000] pgd = c0004000
[   86.650000] [fffffffc] *pgd=877fe021, *pte=00000000, *ppte=00000000
[   86.650000] Internal error: Oops: 17 [#5] PREEMPT
[   86.650000] last sysfs file: /sys/kernel/uevent_seqnum
[   86.650000] Modules linked in: ov2640 mx3_camera soc_camera soc_mediabus videobuf_dma_contig videobuf_core
[   86.650000] CPU: 0    Tainted: G      D      (2.6.36-10808-ga06e72c-dirty #180)
[   86.650000] PC is at kthread_data+0x4/0xc
[   86.650000] LR is at wq_worker_sleeping+0xc/0xb0
[   86.650000] pc : [<c005a11c>]    lr : [<c0056f48>]    psr: 00000193
[   86.650000] sp : c7d2b9b0  ip : c7d2b9f0  fp : c7d2b9ec
[   86.650000] r10: c03e4ee0  r9 : c7c621d4  r8 : 00000000
[   86.650000] r7 : c00b7c94  r6 : c7d2a000  r5 : c7c62060  r4 : 00000000
[   86.650000] r3 : 00000000  r2 : 00000002  r1 : 00000000  r0 : c7c62060
[   86.650000] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[   86.650000] Control: 00c5387d  Table: 87050000  DAC: 00000017
[   86.650000] Process kworker/0:2 (pid: 284, stack limit = 0xc7d2a268)
[   86.650000] Stack: (0xc7d2b9b0 to 0xc7d2c000)
[   86.650000] b9a0:                                     0000000b c02ea69c c7d2ba57 c7c621d8
[   86.650000] b9c0: c00b7c94 0000000b c7d2ba57 c7c62060 c00b7c94 00000000 00000008 00000000
[   86.650000] b9e0: 00000000 c7d2b9f0 c0044f9c c02ea5a8 00000008 00000000 00000000 00000001
[   86.650000] ba00: c7d2ba57 c00b7c92 c00b7c94 00000000 00000008 00000000 00000000 c002cbf0
[   86.650000] ba20: c7d2a268 0000000b 5d303030 00000000 65000001 63343835 20303030 36393565
[   86.650000] ba40: 63343033 35336520 30303033 61302030 30303030 28206130 33393565 34303033
[   86.650000] ba60: 00002029 00000000 00000005 19221926 c7d2bbe8 00000000 00000005 00000000
[   86.650000] ba80: 00000005 c7d2bbe8 c7d2bc5f c002f534 c03de034 c7c62060 19221926 00000000
[   86.650000] baa0: 19221926 c002f72c c003aeb0 c003abc4 c03e4ee0 c7c62090 c7c62060 c03e4ee0
[   86.650000] bac0: 07bec38f 00000000 07270e0a 00000000 ffffffff 00000000 00000c56 c006397c
[   86.650000] bae0: 07bec38f 00000000 00000000 00000000 c7d2bb28 00000055 c03e6aa0 c7d2bb28
[   86.650000] bb00: 00000055 c03e6ad0 c7d2bb28 00000055 07bec38f 00000055 c03e4888 c0066f20
[   86.650000] bb20: 07bec38f 00000055 c03de034 c7d2bc1c 00000005 c7d2bbe8 19221926 20000113
[   86.650000] bb40: c7c0d808 c00282c4 00000000 00000055 c03e6aa0 c7d2bb8e c7d2bc5f c7d2bb8e
[   86.650000] bb60: c7d2bc5f 0000ffff 00000002 00000000 c7d2bc6c c01a97a4 00000000 00000000
[   86.650000] bb80: 00000055 0000ffff c03ead64 38346a54 07be8232 c7d2a000 00000104 00000024
[   86.650000] bba0: 00000001 00000009 0000000a c0076d3c 00000000 c0046e94 c7d2bc56 c00357fc
[   86.650000] bbc0: c03e4860 0000001d 00000000 001d0000 ffffffff c7d2bc1c c78017b0 0000000b
[   86.650000] bbe0: c7c1ce30 c0028a4c c7d2bc5f 00000003 00000034 19221922 c7d2bc6c 00000000
[   86.650000] bc00: c78017b0 0000000b c7c1ce30 c7c1ce30 c7c0d808 c7d2bc5f 00121bc5 c7d2bc30
[   86.650000] bc20: c00e79e8 c00b7c90 20000113 ffffffff c7d2bc5f c7d2a000 c7d2bcc8 c7c1ce30
[   86.650000] bc40: 00000000 c00e79e8 00000000 0000011c 0000011c c7d2bc60 c00362e0 322eab9c
[   86.650000] bc60: 00003438 00000000 fffffffe 00121bc5 00000003 c7d2bc5f 00000001 c7c62060
[   86.650000] bc80: c7d2bcc8 c7c62060 c7d2a000 c7c6215c 00000000 c7c6215c 00000150 c0043dbc
[   86.650000] bca0: c00a113c ffffffff c7d2bcc8 c7c62060 c7c13c?++Searching for BBT table in the flash ...



-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
