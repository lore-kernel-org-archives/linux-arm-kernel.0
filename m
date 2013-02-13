From: amit.virdi@st.com (Amit Virdi)
Date: Wed, 13 Feb 2013 17:59:29 +0530
Subject: Need advice: unable to mount filesystem
Message-ID: <511B8729.8040908@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have ported the code for my MMUless SoC from Kernel 3.3 to 3.8-rc6. 
I've compiled a flat cramfs format FS. This used to work with the SoC 
code over Kernel 3.3.

I copied this FS in the flash. I have done various checks such as the 
mtd partitions this kernel is creating are in accordance with the layout 
of the flash, command line arguments are correct, all the relevant 
configuration options are enabled during kernel configuration etc.

I have tried mounting the filesystem from DDR, that too with no success. 
One observation is that before mounting the FS, the kernel throws a warning:
--
Warning: unable to open an initial console.
--

I have even tried using initramfs (compiled kernel with busybox binary).

All of these used to run with Kernel 3.3. Same filesystem (copied in the 
flash is working with the older kernel).

I guess I'm missing something trivial here but not able to figure out.

I have enabled the following flags in the defconfig (pasting only relevant):
CONFIG_BINFMT_FLAT
CONFIG_BLK_DEV_INITRD
CONFIG_MTD_BLOCK
CONFIG_CRAMFS
CONFIG_AEABI

Can anyone suggest what I might be missing? Any help would be 
appreciated. Logfile is attached...

Thanks
Amit Virdi
-------------- next part --------------
CPU:   xxxx
DRAM:  128 MiB
Flash: 16 MiB
u-boot> bootm 0x23000000
## Booting kernel from Legacy Image at 23000000 ...
   Image Name:   Linux-3.8.0-rc6-00086-gb334582-d
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1168056 Bytes = 1.1 MiB
   Load Address: 20008000
   Entry Point:  20008000
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.8.0-rc6-00086-gb334582-dirty (amitvi at DLH10016) (gcc version 4.6.2 20110813 (STMicroelectronics/Linux Base 4.6.2-99) (GCC) ) #37 Wed Feb 13 11:39:33 IST 2013
CPU: ARMv7 Processor [411fc143] revision 3 (ARMv7), cr=08c51c7d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine: ST-xxxx-EVB
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyAMA0,115200 root=/dev/mtdblock3 rootfstype=cramfs
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 127528k/127528k available, 3544k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0x00000000 - 0x00001000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0x00000000 - 0xffffffff   (4095 MB)
    lowmem  : 0x20000000 - 0x28000000   ( 128 MB)
      .text : 0x20008000 - 0x201f70dc   (1981 kB)
      .init : 0x201f8000 - 0x2020c48c   (  82 kB)
      .data : 0x2020e000 - 0x20229be0   ( 111 kB)
       .bss : 0x20229be0 - 0x2025ad74   ( 197 kB)
SLUB: Genslabs=11, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:104
VIC @8e000000: id 0x00041192, vendor 0x41
VIC @8e001000: id 0x00041192, vendor 0x41
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294967286ms
Console: colour dummy device 80x30
Calibrating delay loop... 275.25 BogoMIPS (lpj=1376256)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
Serial: AMBA PL011 UART driver
uart: ttyAMA0 at MMIO 0x85000000 (irq = 17) is a PL011 rev3
console [ttyAMA0] enabled
bio: create slab <bio-0> at 0
SCSI subsystem initialized
Switching to clocksource tmr1
jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
msgmni has been set to 249
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
brd: module loaded
st: Version 20101219, fixed bufsize 32768, s/g segs 256
osst :I: Tape driver with OnStream support version 0.99.4
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
SCSI Media Changer driver v0.25 
sfc-nor sfc-nor: found device: w25q128, size = 1000000 (16MiB) erasesize = 0x00010000 (64KiB)
Creating 4 MTD partitions on "NOR":
0x000000000000-0x000000010000 : "X-loader"
0x000000010000-0x000000040000 : "U-Boot"
0x000000040000-0x000000240000 : "Kernel"
0x000000240000-0x000001000000 : "Root File System"
Warning: unable to open an initial console.
VFS: Cannot open root device "mtdblock3" or unknown-block(31,3): error -14
Please append a correct "root=" boot option; here are the available partitions:
1f00              64 mtdblock0  (driver?)
1f01             192 mtdblock1  (driver?)
1f02            2048 mtdblock2  (driver?)
1f03           14080 mtdblock3  (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(31,3)
[<2000cb50>] (unwind_backtrace+0x0/0xf8) from [<2018655c>] (panic+0x8c/0x1d8)
[<2018655c>] (panic+0x8c/0x1d8) from [<201f8d58>] (mount_block_root+0x1fc/0x2b8)
[<201f8d58>] (mount_block_root+0x1fc/0x2b8) from [<201f90c0>] (prepare_namespace+0x160/0x1b8)
[<201f90c0>] (prepare_namespace+0x160/0x1b8) from [<20185984>] (kernel_init+0x8/0xe4)
[<20185984>] (kernel_init+0x8/0xe4) from [<20008e98>] (ret_from_fork+0x14/0x3c)
