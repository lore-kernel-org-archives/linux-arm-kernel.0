From: tilman@gloetzner.net (=?UTF-8?B?VGlsbWFuIEdsw7Z0emVy?=)
Date: Thu, 18 Jun 2015 23:24:07 +0200
Subject: ELV LCU1 SBC: Kernel fails to mount JFFS2 root fs
Message-ID: <558336F7.8090500@gloetzner.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

I have an LCU1 SBC manifactured by ELV. It comes with a firmware 
consisting of a linux kernel (2.6.31.6), and other programs. As the 
tools used by buildroot are no longer compatible with current linux 
distributions, it no longer compiles. I have replaced buildroot (just 
buildroot, and not the kernel), and now init  fails (Kernel Oops 
Message: not syncing: Attempted to kill init!). I guess it is not init 
that is terminated prematurely but the issue is the JFFS2 driver that is 
not able to mount the root file system for whatever reason (even though 
it claims mounting the rootfs was successful)

Question: I read on http://www.linux-mtd.infradead.org/faq/jffs2.html 
that older kernels cannot mount newer JFFS2 file systems. I was 
wondering whether mkfs.jffs2 and the linux kernel (2.6.31) are not 
matching.  What is meant by "older kernel" ? Is there a compatibility  
matrix available that shows which kernel version requires which version 
of mkfs.jffs2 ?

To be sure that kernel driver and mkfs.jffs2 are compatible, I then 
tried to port the customized kernel code from Version 2.6.31 to 3.14.7 
(that is the kernel version that comes with the updated buildroot). The 
Jffs2 file system can still not be mounted. Below the console output.

I then tried to recompile the kernel so that it mounts the rootfs via 
NFS (to have a working kernel with which I can manually try to mount the 
JFFS2 partition) but to no avail - the kernel still tries to mount the 
mtd device. I guess the boot monitor u-boot passes the boot device as 
parameter to the kernel, and I need to fix it there.

I would appreciate suggestion on how to tackle this. Apparently, their 
is either something wrong with the kernel or with the JFFS2 root file system

Question: In the kernel boot messages,  there is an error message 
"mmc_spi: probe of spi1.3 failed with error -22". What does error code 
22 mean ? I guess it is not related to jffs2 issue, as the root fs is on 
a flash and not on a MMC.

If this news group is not appropriate for questions like this, I 
appologize. In this case I would be grateful for a hint to a newsgroup 
that discusses topics like this one.

Thanks
Tilman



================================ Kernel Boot Dump 
=================================

RomBOOT
AT91Bootstrap-2.10...AT45DB642D detected
 >From:  [0x00008400] To:        [0x23F00000] Size: [0x00040000]
........SUCCESS
 >Start: [0x23F00000]

U-Boot 2009.08-svn47665 (Jun 20 2011 - 11:08:57)

DRAM:  64 MB
NAND:  256 MiB
DataFlash:AT45DB642
Nb pages:   8192
Page Size:   1056
Size= 8650752 bytes
Logical address: 0xC0000000
Area 0: C0000000 to C00041FF (RO) Bootstrap
Area 1: C0004200 to C00083FF      Environment
Area 2: C0008400 to C0041FFF (RO) U-Boot
Area 3: C0042000 to C0251FFF      Kernel
Area 4: C0252000 to C0461FFF      Rescue-Kernel
In:    serial
Out:   serial
Err:   serial
Net:   dm9000
dm9000 i/o: 0x30000000, id: 0x90000a46
DM9000: running in 16 bit mode
MAC: 00:1a:22:01:d4:33
operating at 100M full duplex mode
Hit any key to stop autoboot:  0
## Booting kernel from Legacy Image at 22200000 ...
    Image Name:   Linux-3.17.4
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    2162176 Bytes =  2.1 MB
    Load Address: 20008000
    Entry Point:  20008000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.17.4 (root at btron) (gcc version 4.8.3 (Buildroot 2014.11) 
) #25 Thu Jun 18 22:21:25 CEST 2015
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f
CPU: VIVT data cache, VIVT instruction cache
Machine: ELV LCU1
Ignoring unrecognised tag 0x54410008
Memory policy: Data cache writeback
AT91: Detected soc type: at91sam9261
AT91: sram at 0x300000 of 0x28000 mapped at 0xfef50000
Clocks: CPU 198 MHz, master 99 MHz, main 18.432 MHz
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: mem=64M console=ttyS0,115200 root=/dev/mtdblock0 ro 
rootfstype=jffs2 
mtdparts=spi0.0-AT45DB642x:0x00042000(u-boot),0x210000(kernel),-(free)
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 60648K/65536K available (2950K kernel code, 173K rwdata, 900K 
rodata, 122K init, 99K bss, 4888K reserved)
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
     vmalloc : 0xc4800000 - 0xff000000   ( 936 MB)
     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .text : 0xc0008000 - 0xc03cadf8   (3852 kB)
       .init : 0xc03cb000 - 0xc03e9bf8   ( 123 kB)
       .data : 0xc03ea000 - 0xc0415640   ( 174 kB)
        .bss : 0xc0415640 - 0xc042e588   ( 100 kB)
NR_IRQS:16 nr_irqs:16 16
AT91: 96 gpio irqs in 3 banks
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 
21474836480000000ns
Console: colour dummy device 80x30
Calibrating delay loop... 98.71 BogoMIPS (lpj=493568)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x202cad00 - 0x202cad58
VFP support v0.3: not present
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
AT91: Power Management
AT91: Starting after user reset
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c-gpio i2c-gpio.0: using pins 7 (SDA) and 8 (SCL)
Switched to clocksource tcb_clksrc
NET: Registered protocol family 2
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
futex hash table entries: 256 (order: -1, 3072 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
msgmni has been set to 118
io scheduler noop registered (default)
atmel_lcdfb at91sam9261-lcdfb.0: 225KiB frame buffer at 23a40000 (mapped 
at c48a4000)
Console: switching to colour frame buffer device 40x30
atmel_lcdfb at91sam9261-lcdfb.0: fb0: Atmel LCDC at 0x00600000 (mapped 
at c4846000), irq 37
atmel_usart.0: ttyS0 at MMIO 0xfffff200 (irq = 17, base_baud = 6208000) 
is a ATMEL_SERIAL
console [ttyS0] enabled
atmel_usart.3: ttyS1 at MMIO 0xfffb8000 (irq = 24, base_baud = 6208000) 
is a ATMEL_SERIAL
ssc at91rm9200_ssc.1: Atmel SSC device at 0xc48e8000 (irq 31)
atmel_nand atmel_nand: No SmartMedia card inserted.
atmel_spi atmel_spi.0: version: 0x150
atmel_spi atmel_spi.0: Atmel SPI Controller at 0xfffc8000 (irq 28)
mtd_dataflash spi0.0: AT45DB642x (8448 KBytes) pagesize 1056 bytes (OTP)
3 cmdlinepart partitions found on MTD device spi0.0-AT45DB642x
Creating 3 MTD partitions on "spi0.0-AT45DB642x":
0x000000000000-0x000000042000 : "u-boot"
0x000000042000-0x000000252000 : "kernel"
0x000000252000-0x000000840000 : "free"
atmel_spi atmel_spi.1: version: 0x150
atmel_spi atmel_spi.1: Atmel SPI Controller at 0xfffcc000 (irq 29)
eth0: dm9000a at c48de000,c48e6044 IRQ 123 MAC: 00:1a:22:01:d4:33 (chip)
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-atmel: OHCI Atmel driver
at91_ohci at91_ohci: OHCI Host Controller
at91_ohci at91_ohci: new USB bus registered, assigned bus number 1
at91_ohci at91_ohci: irq 36, io mem 0x00500000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new interface driver usb-storage
udc: at91_udc version 3 May 2006
genirq: Setting trigger mode 2 for irq 66 failed (gpio_irq_type+0x0/0x20)
ads7846 spi0.2: trying pin change workaround on irq 66
ads7846 spi0.2: touchscreen, irq 66
input: ADS7843 Touchscreen as 
/devices/platform/atmel_spi.0/spi_master/spi0/spi0.2/input/input0
rtc (null): invalid alarm value: 1900-1-1 0:0:0
rtc-at91sam9 rtc-at91sam9.0: rtc core: registered rtc-at91sam9 as rtc0
i2c /dev entries driver
mc_spi spi1.3: ASSUMING 3.2-3.4 V slot power
mmc_spi: probe of spi1.3 failed with error -22
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
NET: Registered protocol family 17
Key type dns_resolver registered
rtc-at91sam9 rtc-at91sam9.0: setting system clock to 1970-01-01 23:59:41 
UTC (86381)
jffs2: write-buffering enabled buffer (1056) erasesize (8448)
jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 
0x00000000: 0x000d instead
jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 
0x00000004: 0x0005 instead
...
jffs2: Further such events for this erase block will not be printed
jffs2: Empty flash at 0x0003c724 ends at 0x0003c728
jffs2: Cowardly refusing to erase blocks on filesystem with no valid 
JFFS2 nodes
jffs2: empty_blocks 0, bad_blocks 0, c->nr_blocks 32
VFS: Cannot open root device "mtdblock0" or unknown-block(31,0): error -5
Please append a correct "root=" boot option; here are the available 
partitions:
1f00             264 mtdblock0  (driver?)
1f01            2112 mtdblock1  (driver?)
1f02            6072 mtdblock2  (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(31,0)
CPU: 0 PID: 1 Comm: swapper Not tainted 3.17.4 #25
[<c0012148>] (unwind_backtrace) from [<c00106ac>] (show_stack+0x10/0x14)
[<c00106ac>] (show_stack) from [<c02c6a8c>] (panic+0x78/0x1d0)
[<c02c6a8c>] (panic) from [<c03cc094>] (mount_block_root+0x204/0x24c)
[<c03cc094>] (mount_block_root) from [<c03cc1b8>] (mount_root+0xdc/0x104)
[<c03cc1b8>] (mount_root) from [<c03cc2f8>] (prepare_namespace+0x118/0x16c)
[<c03cc2f8>] (prepare_namespace) from [<c03cbcbc>] 
(kernel_init_freeable+0x174/0x1b8)
[<c03cbcbc>] (kernel_init_freeable) from [<c02c618c>] (kernel_init+0x8/0xe4)
[<c02c618c>] (kernel_init) from [<c000dc70>] (ret_from_fork+0x14/0x24)
---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(31,0)
