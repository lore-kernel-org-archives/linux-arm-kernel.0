From: alexis.rodet@bvs-tech.com (Alexis RODET)
Date: Mon, 26 Jul 2010 18:24:46 +0200
Subject: unable to use NAND02GR3B2DZA6E on i.MX27 with linux
Message-ID: <4C4DB6CE.6080709@bvs-tech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have a custom board with 1 i.MX27 microcontroller and 1 Numonyx NAND
256MiB 1,8V 8-bit connected on the nfc port.
I manage to read and write in that nand flash from redboot but not from
Linux which crashes.
I tested with Linux stable 2.6.34.1 + board support modification.
I have tested with and without hw_ecc = 1 and get the same crash at
send_cmd+0x20/0x34.
Could you give me any advise to debug this ?

Best regards,
Alexis RODET

Here is the full console printout from redboot start to seg fault:

++flash_hwr_init(): 0 out of NUM_DEVICES=5, dev id=0xaa20 known id=0x35ec
flash_hwr_init(): 1 out of NUM_DEVICES=5, dev id=0xaa20 known id=0x79ec
flash_hwr_init(): 2 out of NUM_DEVICES=5, dev id=0xaa20 known id=0xf1ec
flash_hwr_init(): 3 out of NUM_DEVICES=5, dev id=0xaa20 known id=0xa120
flash_hwr_init(): 4 out of NUM_DEVICES=5, dev id=0xaa20 known id=0xaa20
flash_hwr_init(): 4 out of NUM_DEVICES=5, id=0xaa20

Found 0 bad blocks

flash_hwr_init(): block_size=0x20000, blocks=0x800, start=0xe0000000,
end=0xf0000000
... Read from 0x03ee0000-0x03f00000 at 0xeffe0000:
nfc_read_region(la=0xeffe0000, mem_addr=0x3ee0000, len=0x20000)
.
... Read from 0x03ed3000-0x03ed4000 at 0xeffff000:
nfc_read_region(la=0xeffff000, mem_addr=0x3ed3000, len=0x1000)
.

Board Type: IP Camera
Clock input: 25 MHz
entering mxc_fec_bd_init
entering mxc_fec_chip_init
ipg_clk = 66500000, MSCR = 1a
entering mxc_fec_phy_init
Special mode = ff
Phy reset OK, CTRL = 3000
mxc_fec_phy_init: right phy id=7c000
Phy auto-neg OK, STATUS = 7809, after 0
Phy CTRL2 = 40
FEC: [ FULL_DUPLEX ] [ connected ] [ 100M bps ]:
... waiting for BOOTP information
Ethernet mxc_fec: MAC address 00:00:45:67:89:ab
IP: 192.168.1.110/255.255.255.0, Gateway: 0.0.0.0
Default server: 192.168.1.10

RedBoot(tm) bootstrap and debug environment [ROMRAM]
Non-certified release, version IPCAM 20080409 - built 14:26:16, Jul 23 2010

Platform: BVS BIPnet (Freescale i.MX27 based) PASS x.x [x32 SDR]
Copyright (C) 2000, 2001, 2002, 2003, 2004 Red Hat, Inc.

RAM: 0x00000000-0x03f00000, [0x00025080-0x03ed1000] available
FLASH: 0xe0000000 - 0xf0000000, 2048 blocks of 0x00020000 bytes each.
=== Executing boot script in 3.000 seconds... ===
=== TYPE ^C (Ctrl-c) NOW to abort! ===
^C
RedBoot> load -r -b 0x100000 zImage
Using default protocol (TFTP)
Raw file loaded 0x00100000-0x0029b01b, assumed entry at 0x00100000
RedBoot> exec -b 0x100000 -l 0x200000 -c "console=ttymxc0,115200 ip=dhcp
root=nfs nfsroot=192.168.1.10:/srv/nfs/rootfs
mtdparts=mxc_nand:256k(boot),2M(kernel),16M(root),-(spare)ro"
entry=0xa0008000, target=0xa0008000
[    0.000000] Linux version 2.6.34.1-bipnet-00005-g88b3664
(alro at curvature) (gcc version 4.3.2 (OSELAS.Toolchain-1.99.3) ) #5
PREEMPT Mon Jul 26 17:52:24 CEST 2010
[    0.000000] CPU: ARM926EJ-S [41069264] revision 4 (ARMv5TEJ), cr=00053177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: BVS BIPnet MX27
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 16256
[    0.000000] Kernel command line: console=ttymxc0,115200 ip=dhcp
root=nfs nfsroot=192.168.1.10:/srv/nfs/rootfs
mtdparts=mxc_nand:256k(boot),2M(kernel),16M(root),-(spare)ro
[    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Memory: 64MB = 64MB total
[    0.000000] Memory: 61480k/61480k available, 4056k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xc4800000 - 0xf4000000   ( 760 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0022000   ( 104 kB)
[    0.000000]       .text : 0xc0022000 - 0xc031d000   (3052 kB)
[    0.000000]       .data : 0xc0334000 - 0xc0355120   ( 133 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:272
[    0.000000] MXC GPIO hardware
[    0.000000] MXC IRQ initialized
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Calibrating delay loop... 132.71 BogoMIPS (lpj=663552)
[    0.230000] Mount-cache hash table entries: 512
[    0.230000] CPU: Testing write buffer coherency: ok
[    0.230000] devtmpfs: initialized
[    0.250000] NET: Registered protocol family 16
[    0.300000] bio: create slab <bio-0> at 0
[    0.310000] SCSI subsystem initialized
[    0.310000] usbcore: registered new interface driver usbfs
[    0.310000] usbcore: registered new interface driver hub
[    0.310000] usbcore: registered new device driver usb
[    0.320000] Switching to clocksource mxc_timer1
[    0.330000] NET: Registered protocol family 2
[    0.330000] IP route cache hash table entries: 1024 (order: 0, 4096
bytes)
[    0.330000] TCP established hash table entries: 2048 (order: 2, 16384
bytes)
[    0.330000] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.330000] TCP: Hash tables configured (established 2048 bind 2048)
[    0.330000] TCP reno registered
[    0.330000] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.330000] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.330000] NET: Registered protocol family 1
[    0.330000] RPC: Registered udp transport module.
[    0.330000] RPC: Registered tcp transport module.
[    0.330000] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.330000] NetWinder Floating Point Emulator V0.97 (extended precision)
[    0.530000] JFFS2 version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
[    0.530000] msgmni has been set to 120
[    0.530000] io scheduler noop registered (default)
[    0.600000] Serial: IMX driver
[    0.600000] imx-uart.0: ttymxc0 at MMIO 0x1000a000 (irq = 20) is a IMX
[    0.910000] console [ttymxc0] enabled
[    0.910000] imx-uart.2: ttymxc2 at MMIO 0x1000c000 (irq = 18) is a IMX
[    0.920000] at24 1-0050: 256 byte 24c02 EEPROM (writable)
[    0.930000] NAND device: Manufacturer ID: 0x20, Chip ID: 0xaa (ST
Micro NAND 256MiB 1,8V 8-bit)
[    0.940000] Scanning device for bad blocks
[    2.020000] Searching for RedBoot partition table in mxc_nand at
offset 0xffc0000
[    2.060000] No RedBoot partition table detected in mxc_nand
[    2.070000] 4 cmdlinepart partitions found on MTD device mxc_nand
[    2.070000] Creating 4 MTD partitions on "mxc_nand":
[    2.080000] 0x000000000000-0x000000040000 : "boot"
[    2.090000] 0x000000040000-0x000000240000 : "kernel"
[    2.090000] 0x000000240000-0x000001240000 : "root"
[    2.100000] 0x000001240000-0x000010000000 : "spare"
[    2.120000] m25p80 spi0.0: non-JEDEC variant of m25p10
[    2.120000] m25p80 spi0.0: m25p10 (128 Kbytes)
[    2.130000] spi_imx spi_imx.0: probed
[    2.140000] FEC Ethernet Driver
[    2.140000] fec: PHY @ 0x1f, ID 0x0007c0c4 -- LAN8700
[    2.150000] Initializing USB Mass Storage driver...
[    2.160000] usbcore: registered new interface driver usb-storage
[    2.160000] USB Mass Storage support registered.
[    2.170000] Freescale High-Speed USB SOC Device Controller driver
(Apr 20, 2007)
[    2.180000] g_mass_storage gadget: Mass Storage Function, version:
2009/09/11
[    2.180000] g_mass_storage gadget: Number of LUNs=1
[    2.190000]  lun0: LUN: removable file: (no medium)
[    2.190000] g_mass_storage gadget: Mass Storage Gadget, version:
2009/09/11
[    2.200000] g_mass_storage gadget: g_mass_storage ready
[    2.210000] fsl-usb2-udc: bind to driver g_mass_storage
[    2.210000] i2c /dev entries driver
[    2.220000] i.MX SDHC driver
[    2.220000] oprofile: using timer interrupt.
[    2.230000] TCP cubic registered
[    2.230000] NET: Registered protocol family 17
[    2.240000] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    2.760000] eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX,
10HDX.
[    3.770000] Sending DHCP requests .., OK
[    6.310000] IP-Config: Got DHCP answer from 192.168.1.10, my address
is 192.168.1.110
[    6.310000] IP-Config: Complete:
[    6.320000]      device=eth0, addr=192.168.1.110, mask=255.255.255.0,
gw=255.255.255.255,
[    6.330000]      host=192.168.1.110, domain=, nis-domain=(none),
[    6.330000]      bootserver=192.168.1.10, rootserver=192.168.1.10,
rootpath=
[    6.340000] Looking up port of RPC 100003/2 on 192.168.1.10
[    6.360000] Looking up port of RPC 100005/1 on 192.168.1.10
[   11.390000] VFS: Mounted root (nfs filesystem) on device 0:13.
[   11.400000] devtmpfs: mounted
[   11.400000] Freeing init memory: 104K
Setting the hostname to orion
Mounting /proc and /sys
Starting the hotplug events dispatcher udevd
Synthesizing initial hotplug events
mount: Can't find /dev/pts in /etc/fstab
Mounting filesystems
mount: Mounting usbfs on /proc/bus/usb failed: No such file or directory
Starting syslogd and klogd
Running depmod
WARNING: Couldn't open directory
/lib/modules/2.6.34.1-bipnet-00005-g88b3664: No such file or directory
FATAL: Could not open
/lib/modules/2.6.34.1-bipnet-00005-g88b3664/modules.dep.temp for
writing: No such file or directory
Setting up networking on loopback device:
Setting up networking on rausb0:
SIOCSIFADDR: No such device
SIOCSIFNETMASK: No such device
Adding static route for default gateway to 192.168.1.1:
route: SIOC[ADD|DEL]RT: No such device
Setting nameserver to 192.168.1.1 in /etc/resolv.conf:
Setting up networking on eth0:
Adding static route for default gateway to 192.168.1.1:
Setting nameserver to 192.168.1.1 in /etc/resolv.conf:
Starting inetd:
Starting the Apache webserver:
chmod: /dev/v4l: No such file or directory
httpd: Could not determine the server's fully qualified domain name,
using 127.0.0.1 for ServerName
mx27# ls
bin           etc           mnt           rootfs.jffs2  usr
boot          home          mtdblock2     sbin          var
dev           lib           opt           sys
dir           linuxrc       proc          test
done          log           root          tmp
mx27# ls /dev/mtd*
/dev/mtd0       /dev/mtd2       /dev/mtd4       /dev/mtdblock2
/dev/mtd0ro     /dev/mtd2ro     /dev/mtd4ro     /dev/mtdblock3
/dev/mtd1       /dev/mtd3       /dev/mtdblock0  /dev/mtdblock4
/dev/mtd1ro     /dev/mtd3ro     /dev/mtdblock1
mx27# cat rootfs.jffs2 > /dev/mtd2
[  157.550000] Unhandled fault: external abort on non-linefetch (0x808)
at 0xc4868e1c
[  157.550000] Internal error: : 808 [#1] PREEMPT
[  157.550000] last sysfs file:
/sys/devices/platform/imx-i2c.1/i2c-1/1-0050/modalias
[  157.550000] Modules linked in:
[  157.550000] CPU: 0    Not tainted  (2.6.34.1-bipnet-00005-g88b3664 #5)
[  157.550000] PC is at send_cmd+0x20/0x34
[  157.550000] LR is at mxc_nand_command+0x30c/0x320
[  157.550000] pc : [<c01b15c4>]    lr : [<c01b19f0>]    psr: 60000013
[  157.550000] sp : c3e0fe28  ip : 00000001  fp : 00000000
[  157.550000] r10: ffffffff  r9 : 00000004  r8 : ffffffff
[  157.550000] r7 : c3d00000  r6 : 00000004  r5 : c3d00000  r4 : c3d00000
[  157.550000] r3 : 00000e1c  r2 : 00000001  r1 : c4868000  r0 : c3d00000
[  157.550000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[  157.550000] Control: 0005317f  Table: a3e30000  DAC: 00000015
[  157.550000] Process cat (pid: 510, stack limit = 0xc3e0e270)
[  157.550000] Stack: (0xc3e0fe28 to 0xc3e10000)
[  157.550000] fe20:                   c3d00000 c01b19f0 c3d00190
c3d00000 c3eb2800 00000801
[  157.550000] fe40: c3d00190 c3d00000 00001800 c01ac4f8 c3d00000
c3d00000 c3d00190 00000800
[  157.550000] fe60: 00000001 c3eb2800 00000801 c01ad588 00000001
00000000 0001ffff 00000000
[  157.550000] fe80: 00000801 0000003f 00000000 c3eb2800 00000000
00002000 c3d00190 c3d00000
[  157.550000] fea0: c3d2d000 00400000 00000000 c3e0e000 beabbc98
c01ad770 c3d0027c c00a3b14
[  157.550000] fec0: 001c0000 00000000 00002000 c3e0ff80 00000000
c01a660c 00002000 c3e0ff34
[  157.550000] fee0: c3eb2000 c3eb2000 00002000 c3eb2000 00002000
c01a8458 00002000 c3e0ff34
[  157.550000] ff00: c3eb2000 00000000 beabdeb4 c3d1ffe0 00002000
c0278194 00002000 00000001
[  157.550000] ff20: 00184000 00000000 00000001 c383d7c0 00000002
c383d7c0 beabbc98 c3eb4320
[  157.550000] ff40: beabbc98 00002000 c3e0ff80 beabbc98 c3e0e000
00900004 beabdeb4 c00a4428
[  157.550000] ff60: 00000000 00000000 00000000 001c0000 00000000
c3eb4320 00002000 c00a455c
[  157.550000] ff80: 001c0000 00000000 f4040000 00000000 00002000
00002000 beabbc98 00000004
[  157.550000] ffa0: c0023224 c0022a00 00002000 00002000 00000001
beabbc98 00002000 00000001
[  157.550000] ffc0: 00002000 00002000 beabbc98 00000001 00000001
00000001 00000003 beabdeb4
[  157.550000] ffe0: 00000000 beabbc70 0006cb04 40103e74 60000010
00000001 00000000 00000000
[  157.550000] [<c01b15c4>] (send_cmd+0x20/0x34) from [<c01b19f0>]
(mxc_nand_command+0x30c/0x320)
[  157.550000] [<c01b19f0>] (mxc_nand_command+0x30c/0x320) from
[<c01ac4f8>] (nand_write_page+0x78/0xc8)
[  157.550000] [<c01ac4f8>] (nand_write_page+0x78/0xc8) from
[<c01ad588>] (nand_do_write_ops+0x294/0x31c)
[  157.550000] [<c01ad588>] (nand_do_write_ops+0x294/0x31c) from
[<c01ad770>] (nand_write+0x8c/0xb0)
[  157.550000] [<c01ad770>] (nand_write+0x8c/0xb0) from [<c01a660c>]
(part_write+0x9c/0xa4)
[  157.550000] [<c01a660c>] (part_write+0x9c/0xa4) from [<c01a8458>]
(mtd_write+0x1bc/0x224)
[  157.550000] [<c01a8458>] (mtd_write+0x1bc/0x224) from [<c00a4428>]
(vfs_write+0xac/0x128)
[  157.550000] [<c00a4428>] (vfs_write+0xac/0x128) from [<c00a455c>]
(sys_write+0x40/0x6c)
[  157.550000] [<c00a455c>] (sys_write+0x40/0x6c) from [<c0022a00>]
(ret_fast_syscall+0x0/0x2c)
[  157.550000] Code: e18c10b3 e59012c8 e2833014 e3a0c001 (e181c0b3)
[  157.850000] ---[ end trace b6ea005a06537845 ]---
Segmentation fault

-------------- next part --------------
A non-text attachment was scrubbed...
Name: alexis_rodet.vcf
Type: text/x-vcard
Size: 315 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100726/b133b8c4/attachment.vcf>
