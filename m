From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Wed, 22 Aug 2012 12:28:42 +0200
Subject: Kernel oops since v3.5.x on Atmel chips
Message-ID: <5034B45A.5060107@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Doing some tests with the help of Lava (a Linaro tool), I get some 
kernel oops with 3.5.x on several chips at91sam9260, at91sam9261 and 
at91sam9m10g45.

Most of the time the oops comes from the cascade BUG() call in 
kernel/timer.c but sometimes it comes from a bad PC value.

With Lava, I got the crash each time. It happens after mounting a mtd 
partition, copying a file from it, removing this file from the flash 
memory and then unmounting the mtd partition.

I couldn't reproduce manually this issue so maybe there is something 
related to time...

Here I paste the usual oops and the one with the bad PC value:

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.5.0 (ldesroches at ibiza) (gcc version 4.6.1 (Ubuntu/Linaro 
4.6.1-9ubuntu3) ) #10 Wed Aug 22 09:17:23 CEST 2012
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: Atmel AT91SAM9260-EK
Memory policy: ECC disabled, Data cache writeback
AT91: Detected soc type: at91sam9260
AT91: Detected soc subtype: Unknown
AT91: sram at 0x2ff000 of 0x2000 mapped at 0xfef76000
Clocks: CPU 198 MHz, master 99 MHz, main 18.432 MHz
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: mem=64M console=ttyS0,115200 
mtdparts=atmel_nand:4M(bootstrap/uboot/kernel)ro,70M(rootfs),-(data) 
root=/dev/mtdblock1 rw rootfstype=jffs2 ip=192.168.1.16:::255.255.255.0:::
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 60848k/60848k available, 4688k reserved, 0K highmem
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     vmalloc : 0xc4800000 - 0xff000000   ( 936 MB)
     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .text : 0xc0008000 - 0xc039fee8   (3680 kB)
       .init : 0xc03a0000 - 0xc03bd7c4   ( 118 kB)
       .data : 0xc03be000 - 0xc03e8f00   ( 172 kB)
        .bss : 0xc03e8f24 - 0xc03fb138   (  73 kB)
NR_IRQS:192
AT91: 96 gpio irqs in 3 banks
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 
4294967286ms
Console: colour dummy device 80x30
Calibrating delay loop... 98.71 BogoMIPS (lpj=493568)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x202af150 - 0x202af1a8
devtmpfs: initialized
NET: Registered protocol family 16
AT91: Power Management (with slow clock mode)
AT91: Starting after software reset
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Advanced Linux Sound Architecture Driver Version 1.0.25.
Switching to clocksource pit
cfg80211: Calling CRDA to update world regulatory domain
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
jffs2: version 2.2. (NAND) (SUMMARY)  ? 2001-2006 Red Hat, Inc.
msgmni has been set to 118
io scheduler noop registered (default)
atmel_usart.0: ttyS0 at MMIO 0xfffff200 (irq = 1) is a ATMEL_SERIAL
console [ttyS0] enabled
atmel_usart.1: ttyS1 at MMIO 0xfffb0000 (irq = 6) is a ATMEL_SERIAL
atmel_usart.2: ttyS2 at MMIO 0xfffb4000 (irq = 7) is a ATMEL_SERIAL
brd: module loaded
loop: module loaded
atmel_nand: Use On Flash BBT
atmel_nand atmel_nand: No DMA support for NAND access.
NAND device: Manufacturer ID: 0xec, Chip ID: 0xda (Samsung NAND 256MiB 
3,3V 8-bit), page size: 2048, OOB size: 64
Bad block table found at page 131008, version 0x01
Bad block table found at page 130944, version 0x01
nand_read_bbt: bad block at 0x000009840000
nand_read_bbt: bad block at 0x00000fb80000
3 cmdlinepart partitions found on MTD device atmel_nand
Creating 3 MTD partitions on "atmel_nand":
0x000000000000-0x000000400000 : "bootstrap/uboot/kernel"
0x000000400000-0x000004a00000 : "rootfs"
0x000004a00000-0x000010000000 : "data"
MACB_mii_bus: probed
macb macb: eth0: Cadence MACB at 0xfffc4000 irq 21 (3a:1f:34:08:54:54)
macb macb: eth0: attached PHY driver [Davicom DM9161A] 
(mii_bus:phy_addr=macb-ffffffff:00, irq=-1)
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
at91_ohci at91_ohci: can't request overcurrent gpio 0
at91_ohci at91_ohci: AT91 OHCI
at91_ohci at91_ohci: new USB bus registered, assigned bus number 1
at91_ohci at91_ohci: irq 20, io mem 0x00500000
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: AT91 OHCI
usb usb1: Manufacturer: Linux 3.5.0 ohci_hcd
usb usb1: SerialNumber: at91
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new interface driver cdc_acm
cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
mousedev: PS/2 mouse device common for all mice
TCP: cubic registered
NET: Registered protocol family 17
lib80211: common routines for IEEE802.11 drivers
VFP support v0.3: not present
input: gpio-keys as /devices/platform/gpio-keys/input/input0
/home/ldesroches/workspace/linux/drivers/rtc/hctosys.c: unable to open 
rtc device (rtc0)
IP-Config: Complete:
      device=eth0, addr=192.168.1.16, mask=255.255.255.0, gw=255.255.255.255
      host=192.168.1.16, domain=, nis-domain=(none)
      bootserver=255.255.255.255, rootserver=255.255.255.255, rootpath=
ALSA device list:
   No soundcards found.
macb macb: eth0: link up (100/Full)
jffs2: Empty flash at 0x01fb1c68 ends at 0x01fb2000
VFS: Mounted root (jffs2 filesystem) on device 31:1.
devtmpfs: mounted
Freeing init memory: 116K
Starting logging: OK
Populating  using udev: udevd[468]: starting version 182
done
Starting portmap: done
Initializing random number generator... done.
Starting network...
ip: RTNETLINK answers: File exists
Starting sshd: OK

Welcome to Buildroot
at91 login: root
[root at at91 ~]#
[root at at91 ~]#
[root at at91 ~]# export PS1="$PS1 [rc=$(echo \$?)]: "
[root at at91 ~]#  [rc=0]: mount -t jffs2 /dev/mtdblock2 /mnt/
jffs2: Empty flash at 0x01fb1c68 ends at 0x01fb2000
o_at91_lava/tmp [rc=0]: rm -rf /tmp/lava_results.tgz 
/tmp//srv/lava/instances/rf
[root at at91 ~]#  [rc=0]: mkdir -p /tmp//srv/lava/instances/rfo_at91_lava/tmp
tmp//srv/lava/instances/rfo_at91_lava/tmp/instances/rfo_at91_lava/tmp/*.bundle 
/
eroot at at91 ~]#  [rc=0]: rm -f 
/mnt//srv/lava/instances/rfo_at91_lava/tmp/*.bundl
[root at at91 ~]#  [rc=0]: umount /mnt/
[root at at91 ~]#  [rc=0]: ------------[ cut here ]------------
kernel BUG at /home/ldesroches/workspace/linux/kernel/timer.c:1091!
Internal error: Oops - BUG: 0 [#1] ARM
Modules linked in:
CPU: 0    Not tainted  (3.5.0 #10)
PC is at cascade+0x54/0x78
LR is at cascade+0x60/0x78
pc : [<c0023c80>]    lr : [<c0023c8c>]    psr: a0000093
sp : c03bfec8  ip : ffffae00  fp : 00000000
r10: c03ee540  r9 : 0000000a  r8 : 00000100
r7 : c03bfec8  r6 : c03bfec8  r5 : 0000002e  r4 : c03ee6a0
r3 : 00000000  r2 : 00000068  r1 : c3a60738  r0 : c03ee9ec
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: 23a58000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc03be270)
Stack: (0xc03bfec8 to 0xc03c0000)
fec0:                   c03faf70 c3a60738 0000002e c03ee6a0 c03be000 
00000000
fee0: c03ee560 c0023d98 c0145bc4 c3952ba0 00000000 00000000 c03cddf4 
00000001
ff00: 00000004 c03be000 c03ee560 00000100 c03ee540 c001f4b0 000027da 
c03cddf4
ff20: 00000000 00000001 c03bff9c 00000001 00000000 fefff000 c03bff9c 
20004000
ff40: 41069265 203b834c 00000000 c001f890 fefff000 c000dfc8 c000e0cc 
c000e0e0
ff60: a0000013 c000d398 00000000 0005317f 0005217f a0000013 c03be000 
c03c8f54
ff80: c03e8fe8 c047c300 20004000 41069265 203b834c 00000000 a00000d3 
c03bffb0
ffa0: c000e0cc c000e0e0 a0000013 ffffffff c000e0b4 c000e27c c03c60b0 
ffffffff
ffc0: c03b9784 c03a070c ffffffff ffffffff c03a0274 00000000 00000000 
c03b9784
ffe0: 00000000 00053175 c03c603c c03b9780 c03c8f4c 20008040 00000000 
00000000
[<c0023c80>] (cascade+0x54/0x78) from [<c0023d98>] 
(run_timer_softirq+0x68/0x1f4)
[<c0023d98>] (run_timer_softirq+0x68/0x1f4) from [<c001f4b0>] 
(__do_softirq+0x7c/0x110)
[<c001f4b0>] (__do_softirq+0x7c/0x110) from [<c001f890>] 
(irq_exit+0x40/0x4c)
[<c001f890>] (irq_exit+0x40/0x4c) from [<c000dfc8>] (handle_IRQ+0x74/0x98)
[<c000dfc8>] (handle_IRQ+0x74/0x98) from [<c000d398>] (__irq_svc+0x38/0x60)
[<c000d398>] (__irq_svc+0x38/0x60) from [<c000e0e0>] 
(default_idle+0x2c/0x34)
[<c000e0e0>] (default_idle+0x2c/0x34) from [<c000e27c>] (cpu_idle+0x78/0xd8)
[<c000e27c>] (cpu_idle+0x78/0xd8) from [<c03a070c>] 
(start_kernel+0x280/0x2d0)
Code: e591300c e3c33001 e1540003 0a000000 (e7f001f2)
---[ end trace 6105dc3872c7de5d ]---
Kernel panic - not syncing: Fatal exception in interrupt





Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.5.0 (ldesroches at ibiza) (gcc version 4.6.1 (Ubuntu/Linaro 
4.6.1-9ubuntu3) ) #10 Wed Aug 22 09:17:23 CEST 2012
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: Atmel AT91SAM9260-EK
Memory policy: ECC disabled, Data cache writeback
AT91: Detected soc type: at91sam9260
AT91: Detected soc subtype: Unknown
AT91: sram at 0x2ff000 of 0x2000 mapped at 0xfef76000
Clocks: CPU 198 MHz, master 99 MHz, main 18.432 MHz
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: mem=64M console=ttyS0,115200 
mtdparts=atmel_nand:4M(bootstrap/uboot/kernel)ro,70M(rootfs),-(data) 
root=/dev/mtdblock1 rw rootfstype=jffs2 ip=192.168.1.16:::255.255.255.0:::
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 60848k/60848k available, 4688k reserved, 0K highmem
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     vmalloc : 0xc4800000 - 0xff000000   ( 936 MB)
     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .text : 0xc0008000 - 0xc039fee8   (3680 kB)
       .init : 0xc03a0000 - 0xc03bd7c4   ( 118 kB)
       .data : 0xc03be000 - 0xc03e8f00   ( 172 kB)
        .bss : 0xc03e8f24 - 0xc03fb138   (  73 kB)
NR_IRQS:192
AT91: 96 gpio irqs in 3 banks
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 
4294967286ms
Console: colour dummy device 80x30
Calibrating delay loop... 98.71 BogoMIPS (lpj=493568)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x202af150 - 0x202af1a8
devtmpfs: initialized
NET: Registered protocol family 16
AT91: Power Management (with slow clock mode)
AT91: Starting after software reset
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Advanced Linux Sound Architecture Driver Version 1.0.25.
Switching to clocksource pit
cfg80211: Calling CRDA to update world regulatory domain
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
jffs2: version 2.2. (NAND) (SUMMARY)  ? 2001-2006 Red Hat, Inc.
msgmni has been set to 118
io scheduler noop registered (default)
atmel_usart.0: ttyS0 at MMIO 0xfffff200 (irq = 1) is a ATMEL_SERIAL
console [ttyS0] enabled
atmel_usart.1: ttyS1 at MMIO 0xfffb0000 (irq = 6) is a ATMEL_SERIAL
atmel_usart.2: ttyS2 at MMIO 0xfffb4000 (irq = 7) is a ATMEL_SERIAL
brd: module loaded
loop: module loaded
atmel_nand: Use On Flash BBT
atmel_nand atmel_nand: No DMA support for NAND access.
NAND device: Manufacturer ID: 0xec, Chip ID: 0xda (Samsung NAND 256MiB 
3,3V 8-bit), page size: 2048, OOB size: 64
Bad block table found at page 131008, version 0x01
Bad block table found at page 130944, version 0x01
nand_read_bbt: bad block at 0x000009840000
nand_read_bbt: bad block at 0x00000fb80000
3 cmdlinepart partitions found on MTD device atmel_nand
Creating 3 MTD partitions on "atmel_nand":
0x000000000000-0x000000400000 : "bootstrap/uboot/kernel"
0x000000400000-0x000004a00000 : "rootfs"
0x000004a00000-0x000010000000 : "data"
MACB_mii_bus: probed
macb macb: eth0: Cadence MACB at 0xfffc4000 irq 21 (3a:1f:34:08:54:54)
macb macb: eth0: attached PHY driver [Davicom DM9161A] 
(mii_bus:phy_addr=macb-ffffffff:00, irq=-1)
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
at91_ohci at91_ohci: can't request overcurrent gpio 0
at91_ohci at91_ohci: AT91 OHCI
at91_ohci at91_ohci: new USB bus registered, assigned bus number 1
at91_ohci at91_ohci: irq 20, io mem 0x00500000
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: AT91 OHCI
usb usb1: Manufacturer: Linux 3.5.0 ohci_hcd
usb usb1: SerialNumber: at91
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new interface driver cdc_acm
cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
mousedev: PS/2 mouse device common for all mice
TCP: cubic registered
NET: Registered protocol family 17
lib80211: common routines for IEEE802.11 drivers
VFP support v0.3: not present
input: gpio-keys as /devices/platform/gpio-keys/input/input0
/home/ldesroches/workspace/linux/drivers/rtc/hctosys.c: unable to open 
rtc device (rtc0)
IP-Config: Complete:
      device=eth0, addr=192.168.1.16, mask=255.255.255.0, gw=255.255.255.255
      host=192.168.1.16, domain=, nis-domain=(none)
      bootserver=255.255.255.255, rootserver=255.255.255.255, rootpath=
ALSA device list:
   No soundcards found.
macb macb: eth0: link up (100/Full)
jffs2: Empty flash at 0x01fb1c68 ends at 0x01fb2000
VFS: Mounted root (jffs2 filesystem) on device 31:1.
devtmpfs: mounted
Freeing init memory: 116K
Starting logging: OK
Populating  using udev: done
udevd[468]: starting version 182
Starting portmap: done
Initializing random number generator... done.
Starting network...
ip: RTNETLINK answers: File exists
Starting sshd: OK

Welcome to Buildroot
at91 login: root
[root at at91 ~]#
[root at at91 ~]#
[root at at91 ~]# export PS1="$PS1 [rc=$(echo \$?)]: "
[root at at91 ~]#  [rc=0]: mount -t jffs2 /dev/mtdblock2 /mnt/
jffs2: Empty flash at 0x01fb1c68 ends at 0x01fb2000
o_at91_lava/tmp [rc=0]: rm -rf /tmp/lava_results.tgz 
/tmp//srv/lava/instances/rf
[root at at91 ~]#  [rc=0]: mkdir -p /tmp//srv/lava/instances/rfo_at91_lava/tmp
tmp//srv/lava/instances/rfo_at91_lava/tmp/instances/rfo_at91_lava/tmp/*.bundle 
/
eroot at at91 ~]#  [rc=0]: rm -f 
/mnt//srv/lava/instances/rfo_at91_lava/tmp/*.bundl
[root at at91 ~]#  [rc=0]: umount /mnt/
[root at at91 ~]#  [rc=0]: Unable to handle kernel paging request at 
virtual address 0d0c951c
pgd = c0004000
[0d0c951c] *pgd=00000000
Internal error: Oops: 80000005 [#1] ARM
Modules linked in:
CPU: 0    Not tainted  (3.5.0 #10)
PC is at 0xd0c951c
LR is at run_timer_softirq+0x144/0x1f4
pc : [<0d0c951c>]    lr : [<c0023e74>]    psr: 20000013
sp : c03bfee8  ip : 00200200  fp : 00000000
r10: 0d0c951c  r9 : 0000000a  r8 : c03bfef0
r7 : c03ee560  r6 : 00000100  r5 : c03be000  r4 : c03ee6a0
r3 : 20000013  r2 : 00000000  r1 : c03bfef0  r0 : b5a01535
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: 23a58000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc03be270)
Stack: (0xc03bfee8 to 0xc03c0000)
fee0:                   c0145bc4 c396dba0 c03bfef0 c03bfef0 c03cddf4 
00000001
ff00: 00000004 c03be000 c03ee560 00000100 c03ee540 c001f4b0 00002870 
c03cddf4
ff20: 00000000 00000001 c03bff9c 00000001 00000000 fefff000 c03bff9c 
20004000
ff40: 41069265 203b834c 00000000 c001f890 fefff000 c000dfc8 c000e0cc 
c000e0e0
ff60: a0000013 c000d398 00000000 0005317f 0005217f a0000013 c03be000 
c03c8f54
ff80: c03e8fe8 c047c300 20004000 41069265 203b834c 00000000 a00000d3 
c03bffb0
ffa0: c000e0cc c000e0e0 a0000013 ffffffff c000e0b4 c000e27c c03c60b0 
ffffffff
ffc0: c03b9784 c03a070c ffffffff ffffffff c03a0274 00000000 00000000 
c03b9784
ffe0: 00000000 00053175 c03c603c c03b9780 c03c8f4c 20008040 00000000 
00000000
[<c0023e74>] (run_timer_softirq+0x144/0x1f4) from [<c001f4b0>] 
(__do_softirq+0x7c/0x110)
[<c001f4b0>] (__do_softirq+0x7c/0x110) from [<c001f890>] 
(irq_exit+0x40/0x4c)
[<c001f890>] (irq_exit+0x40/0x4c) from [<c000dfc8>] (handle_IRQ+0x74/0x98)
[<c000dfc8>] (handle_IRQ+0x74/0x98) from [<c000d398>] (__irq_svc+0x38/0x60)
[<c000d398>] (__irq_svc+0x38/0x60) from [<c000e0e0>] 
(default_idle+0x2c/0x34)
[<c000e0e0>] (default_idle+0x2c/0x34) from [<c000e27c>] (cpu_idle+0x78/0xd8)
[<c000e27c>] (cpu_idle+0x78/0xd8) from [<c03a070c>] 
(start_kernel+0x280/0x2d0)
Code: bad PC value
---[ end trace f65db9c681fbd6e3 ]---
Kernel panic - not syncing: Fatal exception in interrupt



Regards

Ludovic
