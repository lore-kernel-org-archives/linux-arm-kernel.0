From: andrea.adami@gmail.com (Andrea Adami)
Date: Tue, 12 Feb 2013 00:06:17 +0100
Subject: [ARM][collie][sa1100-flash] collie mtd fixes
Message-ID: <CAAQYJAsygSk8VvZJhcA0zO2T217_Br35tMoRaxHohALin2vvbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

trying to revive the old Zaurus collie I've rebuilt the last known
working kernel 2.6.31 and the 3.8-rc5.

Apart other issues, all kernels are lacking mtd devices so I've
googled a bit and found:

http://lists.infradead.org/pipermail/linux-mtd/2005-November/014273.html

Well, guided by those hints I ended up using a different erasesize

-ERASEINFO(0x40000,16),
+ERASEINFO(0x08000,128),

With the attached patches the mtd partitions are correctly detected as expected.
(Though, there is a warning...sa1100-0: Found different chip or no
chip at all (mfr 0xc, id 0x5) at 0x1000000)
As you can see in the 3.8-rc5 log attached, the cramfs partition is
detected and mounted, read only.

But when I try to ubiformat mtd2 it sorts out the flash is locked so I
tried to unlock the flash as suggested here

http://lists.infradead.org/pipermail/linux-mtd/2005-November/014300.html
http://lists.infradead.org/pipermail/linux-mtd/2005-November/014304.html

Unfortunately, no luck :/
This collie-mtd-rw.patch still applies with kernel 3.2 but as results
kernel stops booting :/

Testing with more recent kernels I get:
  sa1100-flash.c:121:13: error: 'struct mtd_info' has no member named 'unlock'

Now, what is exactly needed nowaday to unlock the flash?

Thanks all for your attention

Regards

Andrea
-------------- next part --------------
Booting Linux on physical CPU 0x0
Linux version 3.8.0-rc5 (andrea at mizar) (gcc version 4.7.2 (GCC) ) #1 Sun Jan 27 00:56:28 CET 2013
CPU: StrongARM-1110 [6901b118] revision 8 (ARMv4), cr=c000717f
CPU: VIVT data cache, VIVT instruction cache
Machine: Sharp-Collie
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 16384
  Normal zone: 128 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 16256 pages, LIFO batch:3
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=tty1 console=ttySA0,115200n8 fbcon=rotate:1 mem=64M debug
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
__ex_table already sorted, skipping sort
Memory: 64MB = 64MB total
Memory: 62208k/62208k available, 3328k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xc4800000 - 0xff000000   ( 936 MB)
    lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
      .text : 0xc0008000 - 0xc0247c4c   (2304 kB)
      .init : 0xc0248000 - 0xc0273cbc   ( 176 kB)
      .data : 0xc0274000 - 0xc028eb60   ( 107 kB)
       .bss : 0xc028eb60 - 0xc02a6cf8   (  97 kB)
NR_IRQS:16 nr_irqs:53 53
sched_clock: 32 bits at 3686kHz, resolution 271ns, wraps every 1165084ms
Console: colour dummy device 80x30
console [tty1] enabled
console [ttySA0] enabled
Calibrating delay loop... 136.60 BogoMIPS (lpj=683008)
pid_max: default: 4096 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0xc020e1b0 - 0xc020e208
devtmpfs: initialized
DMA: preallocated 256 KiB pool for atomic coherent allocations
Sharp Scoop Device found at 0x40800000 -> 0xc4846000
bio: create slab <bio-0> at 0
SCSI subsystem initialized
libata version 3.00 loaded.
Switching to clocksource oscr
LoCoMo Chip: 7649
jffs2: version 2.2. (NAND) (SUMMARY)  ? 2001-2006 Red Hat, Inc.
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered (default)
Console: switching to colour frame buffer device 30x40
Serial: SA11x0 driver
sa11x0-uart.1: ttySA1 at MMIO 0x80010000 (irq = 15) is a SA1100
sa11x0-uart.3: ttySA0 at MMIO 0x80050000 (irq = 17) is a SA1100
loop: module loaded
input: Touchscreen panel as /devices/platform/sa11x0-mcp/mcp0/ucb1x00/ucb1x00/input0
Found: LH28F640BF
sa1100-0: Found 4 x8 devices at 0x0 in 32-bit bank
sa1100-0: Found different chip or no chip at all (mfr 0xc, id 0x5) at 0x1000000
erase region 0: offset=0x0,size=0x20000,blocks=128
SA1100 flash: CFI device at 0x00000000, 16MiB, 32-bit
Creating 3 MTD partitions on "sa1100":
0x000000000000-0x0000000c0000 : "bootloader"
0x0000000c0000-0x0000001c0000 : "kernel"
0x0000001c0000-0x000000fe0000 : "rootfs"
mousedev: PS/2 mouse device common for all mice
input: LoCoMo keyboard as /devices/platform/locomo.0/locomo-keyboard/input/input1
sa1100-rtc sa1100-rtc: warning: initializing default clock divider/trim value
sa1100-rtc sa1100-rtc: rtc core: registered sa1100-rtc as rtc0
APM Battery Driver
pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 35)
sa1100-rtc sa1100-rtc: setting system clock to 1970-01-01 00:00:00 UTC (0)
Freeing init memory: 172K
kexecboot 0.5.9 starting
I'm the init-process!
Kernel cmdline: console=tty1 console=ttySA0,115200n8 fbcon=rotate:1 mem=64M debug
FB angle is 270, tty is /dev/tty1
Framebuffer structure
Descriptor: 3
Type: 0
Visual: 2
Width: 240, height: 320
Real width: 320, real height: 240
BPP: 16, depth: 16
Stride: 640
Screensize: 153600
Angle: 270
RGBmode: 1
Red offset: 11, red length: 5
Green offset: 5, green length: 6
Blue offset: 0, blue length: 5
Found device '/dev/mtdblock0' (31, 0) of size 0Mb
+ creating device node
+ can't identify FS type
Found device '/dev/mtdblock1' (31, 1) of size 1Mb
+ creating device node
+ can't identify FS type
Found device '/dev/mtdblock2' (31, 2) of size 14Mb
+ creating device node
+ FS type 'cramfs' detected
+ can't open config file: No such file or directory
+ no config file nor any kernels found
Found device '/dev/sda' (8, 0) of size 499Mb
+ creating device node
+ can't identify FS type
Found device '/dev/sda1' (8, 1) of size 498Mb
+ creating device node
+ FS type 'vfat' detected
+ can't mount device /dev/sda1: Invalid argument
No items for menu found
+ Trying evdev 'event1'
 + Sync
 + Keys or Buttons
 + Repeat
 + Power
+ Added evdev 'event1'
+ Trying evdev 'event0'
 + Sync
 + Keys or Buttons
 + Absolute Axes
+ Added evdev 'event0'
-------------- next part --------------
A non-text attachment was scrubbed...
Name: collie-jedec-probe.patch
Type: application/octet-stream
Size: 299 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130212/efe791df/attachment-0003.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: collie-eraseinfo.patch
Type: application/octet-stream
Size: 258 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130212/efe791df/attachment-0004.obj>
-------------- next part --------------

/ # mount -t proc proc /proc
/ # mount -t sysfs sysfs /sys
/ # ubinfo -a
UBI version:                    1
Count of UBI devices:           0
UBI control device major/minor: 10:63
/ # cat /proc/partitions
major minor  #blocks  name

  31        0        768 mtdblock0
  31        1       1024 mtdblock1
  31        2      14464 mtdblock2
   8        0     511056 sda
   8        1     510941 sda1
/ # cat /proc/mtd
dev:    size   erasesize  name
mtd0: 000c0000 00020000 "bootloader"
mtd1: 00100000 00020000 "kernel"
mtd2: 00e20000 00020000 "rootfs"
/ # ubiformat /dev/mtd2
ubiformat: mtd2 (nor), size 14811136 bytes (14.1 MiB), 113 eraseblocks of 131072 bytes (128.0 KiB), min. I/O size 1 bytes

libscan: scanning eraseblock 0 --  0 % complete  
libscan: scanning eraseblock 1 --  1 % complete  
libscan: scanning eraseblock 2 --  2 % complete  
libscan: scanning eraseblock 3 --  3 % complete  
libscan: scanning eraseblock 4 --  4 % complete  
libscan: scanning eraseblock 5 --  5 % complete  
libscan: scanning eraseblock 6 --  6 % complete  
libscan: scanning eraseblock 7 --  7 % complete  
libscan: scanning eraseblock 8 --  7 % complete  
libscan: scanning eraseblock 9 --  8 % complete  
libscan: scanning eraseblock 10 --  9 % complete  
libscan: scanning eraseblock 11 -- 10 % complete  
libscan: scanning eraseblock 12 -- 11 % complete  
libscan: scanning eraseblock 13 -- 12 % complete  
libscan: scanning eraseblock 14 -- 13 % complete  
libscan: scanning eraseblock 15 -- 14 % complete  
libscan: scanning eraseblock 16 -- 15 % complete  
libscan: scanning eraseblock 17 -- 15 % complete  
libscan: scanning eraseblock 18 -- 16 % complete  
libscan: scanning eraseblock 19 -- 17 % complete  
libscan: scanning eraseblock 20 -- 18 % complete  
libscan: scanning eraseblock 21 -- 19 % complete  
libscan: scanning eraseblock 22 -- 20 % complete  
libscan: scanning eraseblock 23 -- 21 % complete  
libscan: scanning eraseblock 24 -- 22 % complete  
libscan: scanning eraseblock 25 -- 23 % complete  
libscan: scanning eraseblock 26 -- 23 % complete  
libscan: scanning eraseblock 27 -- 24 % complete  
libscan: scanning eraseblock 28 -- 25 % complete  
libscan: scanning eraseblock 29 -- 26 % complete  
libscan: scanning eraseblock 30 -- 27 % complete  
libscan: scanning eraseblock 31 -- 28 % complete  
libscan: scanning eraseblock 32 -- 29 % complete  
libscan: scanning eraseblock 33 -- 30 % complete  
libscan: scanning eraseblock 34 -- 30 % complete  
libscan: scanning eraseblock 35 -- 31 % complete  
libscan: scanning eraseblock 36 -- 32 % complete  
libscan: scanning eraseblock 37 -- 33 % complete  
libscan: scanning eraseblock 38 -- 34 % complete  
libscan: scanning eraseblock 39 -- 35 % complete  
libscan: scanning eraseblock 40 -- 36 % complete  
libscan: scanning eraseblock 41 -- 37 % complete  
libscan: scanning eraseblock 42 -- 38 % complete  
libscan: scanning eraseblock 43 -- 38 % complete  
libscan: scanning eraseblock 44 -- 39 % complete  
libscan: scanning eraseblock 45 -- 40 % complete  
libscan: scanning eraseblock 46 -- 41 % complete  
libscan: scanning eraseblock 47 -- 42 % complete  
libscan: scanning eraseblock 48 -- 43 % complete  
libscan: scanning eraseblock 49 -- 44 % complete  
libscan: scanning eraseblock 50 -- 45 % complete  
libscan: scanning eraseblock 51 -- 46 % complete  
libscan: scanning eraseblock 52 -- 46 % complete  
libscan: scanning eraseblock 53 -- 47 % complete  
libscan: scanning eraseblock 54 -- 48 % complete  
libscan: scanning eraseblock 55 -- 49 % complete  
libscan: scanning eraseblock 56 -- 50 % complete  
libscan: scanning eraseblock 57 -- 51 % complete  
libscan: scanning eraseblock 58 -- 52 % complete  
libscan: scanning eraseblock 59 -- 53 % complete  
libscan: scanning eraseblock 60 -- 53 % complete  
libscan: scanning eraseblock 61 -- 54 % complete  
libscan: scanning eraseblock 62 -- 55 % complete  
libscan: scanning eraseblock 63 -- 56 % complete  
libscan: scanning eraseblock 64 -- 57 % complete  
libscan: scanning eraseblock 65 -- 58 % complete  
libscan: scanning eraseblock 66 -- 59 % complete  
libscan: scanning eraseblock 67 -- 60 % complete  
libscan: scanning eraseblock 68 -- 61 % complete  
libscan: scanning eraseblock 69 -- 61 % complete  
libscan: scanning eraseblock 70 -- 62 % complete  
libscan: scanning eraseblock 71 -- 63 % complete  
libscan: scanning eraseblock 72 -- 64 % complete  
libscan: scanning eraseblock 73 -- 65 % complete  
libscan: scanning eraseblock 74 -- 66 % complete  
libscan: scanning eraseblock 75 -- 67 % complete  
libscan: scanning eraseblock 76 -- 68 % complete  
libscan: scanning eraseblock 77 -- 69 % complete  
libscan: scanning eraseblock 78 -- 69 % complete  
libscan: scanning eraseblock 79 -- 70 % complete  
libscan: scanning eraseblock 80 -- 71 % complete  
libscan: scanning eraseblock 81 -- 72 % complete  
libscan: scanning eraseblock 82 -- 73 % complete  
libscan: scanning eraseblock 83 -- 74 % complete  
libscan: scanning eraseblock 84 -- 75 % complete  
libscan: scanning eraseblock 85 -- 76 % complete  
libscan: scanning eraseblock 86 -- 76 % complete  
libscan: scanning eraseblock 87 -- 77 % complete  
libscan: scanning eraseblock 88 -- 78 % complete  
libscan: scanning eraseblock 89 -- 79 % complete  
libscan: scanning eraseblock 90 -- 80 % complete  
libscan: scanning eraseblock 91 -- 81 % complete  
libscan: scanning eraseblock 92 -- 82 % complete  
libscan: scanning eraseblock 93 -- 83 % complete  
libscan: scanning eraseblock 94 -- 84 % complete  
libscan: scanning eraseblock 95 -- 84 % complete  
libscan: scanning eraseblock 96 -- 85 % complete  
libscan: scanning eraseblock 97 -- 86 % complete  
libscan: scanning eraseblock 98 -- 87 % complete  
libscan: scanning eraseblock 99 -- 88 % complete  
libscan: scanning eraseblock 100 -- 89 % complete  
libscan: scanning eraseblock 101 -- 90 % complete  
libscan: scanning eraseblock 102 -- 91 % complete  
libscan: scanning eraseblock 103 -- 92 % complete  
libscan: scanning eraseblock 104 -- 92 % complete  
libscan: scanning eraseblock 105 -- 93 % complete  
libscan: scanning eraseblock 106 -- 94 % complete  
libscan: scanning eraseblock 107 -- 95 % complete  
libscan: scanning eraseblock 108 -- 96 % complete  
libscan: scanning eraseblock 109 -- 97 % complete  
libscan: scanning eraseblock 110 -- 98 % complete  
libscan: scanning eraseblock 111 -- 99 % complete  
libscan: scanning eraseblock 112 -- 100 % complete  
ubiformat: warning!: 113 of 113 eraseblocks contain non-ubifs data
ubiformat: continue? (yes/no)  y
ubiformat: warning!: only 0 of 113 eraseblocks have valid erase counter
ubiformat: erase counter 0 will be used for all eraseblocks
ubiformat: note, arbitrary erase counter value may be specified using -e option
ubiformat: continue? (yes/no)  y
ubiformat: use erase counter 0 for all eraseblocks

ubiformat: formatting eraseblock 0 --  0 % complete  libmtd: error!: MEMERASE64 ioctl failed for eraseblock 0 (mtd2)
        error 30 (Read-only file system)

ubiformat: error!: failed to erase eraseblock 0
           error 30 (Read-only file system)
/ # 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: collie-mtd-rw.patch
Type: application/octet-stream
Size: 536 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130212/efe791df/attachment-0005.obj>
