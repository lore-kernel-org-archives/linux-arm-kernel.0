From: Franke.M@sebakmt.com (Markus Franke)
Date: Mon, 26 Apr 2010 12:19:09 +0200
Subject: No initial console with linux-2.6.22 on Atmel Arm AT9261
Message-ID: <OF69644844.746826F2-ONC1257711.00389697-C1257711.0038B0EC@sebakmt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

I am facing a problem while booting my embedded linux system on an 
AT91SAM9261 based board.

I am running U-Boot on the board and the linux kernel (2.6.22) as well as 
the root filesystem are loaded from USB stick by means of fatload to some 
main memory location.

After running the "boot" command from the U-Boot prompt the process stops 
at "Freeing init memory 104k". 
Actually this is the place where the initial console is being loaded.

Just before the boot process stops the kernel also recognizes the 
compressed ramdisk image in memory. (see kernel boot log below)

I debugged the linux kernel with JTAG and found out that the sys_open() 
system call which tries to open the initial console (/dev/console) fails 
and results in a coredump. Not even the sys_open() function is being 
executed but when the function is called I receive a coredump.

However, the same linux kernel as well as the same root filesystem are 
working if I boot the kernel and mount the root filesystem directly from 
flash.

Could there be maybe something wrong with my memory layout?
Any idea how to debug this? I played around a bit with "earlyprintk" but 
unfortunately so far it has not yet been implemented in Linux 2.6.22 for 
the arm architecture.

Best regards,
Markus Franke


---snip---
Starting kernel ...

Uncompressing 
Linux.......................................................................................... 
done, booting the kernel.
Linux version 2.6.22-taskit2 (pcdevel at localhost.localdomain) (gcc version 
4.1.2) #30 Thu Apr 22 07:50:58 CEST 2010
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
Machine: taskit Panel-Card
Ignoring unrecognised tag 0x54410008
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 8192
  DMA zone: 64 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 8128 pages, LIFO batch:0
  Normal zone: 0 pages used for memmap
Clocks: CPU 199 MHz, master 99 MHz, main 18.432 MHz
AT91: No default serial console defined.
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
Built 1 zonelists.  Total pages: 8128
Kernel command line: console=ttyS0,115200 mem=32M root=/dev/ram rw debug 
earlyprintk=serial,ttyS0,115200,keep 
mtdparts=physmap-flash.0:384k(boot),1664k(linux),5120k(rootfs),13312k(app),1024k(log),-(fonts) 
initrd=0x20400000,0x800000
AT91: 96 gpio irqs in 3 banks
PID hash table entries: 128 (order: 7, 512 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 32MB = 32MB total
Memory: 21356KB available (2552K code, 232K data, 104K init)
Calibrating delay loop... 99.53 BogoMIPS (lpj=248832)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
AT91: Power Management (with slow clock mode)
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
Freeing initrd memory: 8192K
NetWinder Floating Point Emulator V0.97 (double precision)
JFFS2 version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
atmel_lcdfb atmel_lcdfb.0: 150KiB frame buffer at 20840000 (mapped at 
ffc00000)
atmel_lcdfb atmel_lcdfb.0: fb0: Atmel LCDC at 0x00600000 (mapped at 
c285c000), irq 21
atmel_usart.0: ttyS0 at MMIO 0xfefff200 (irq = 1) is a ATMEL_SERIAL
atmel_usart.2: ttyS2 at MMIO 0xfffb4000 (irq = 7) is a ATMEL_SERIAL
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: module loaded
at91_ext_reset_init called.  Module is now loaded.
PPP generic driver version 2.4.2
NET: Registered protocol family 24
dm9000 Ethernet Driver
eth%d: Invalid ethernet MAC address.  Please set using ifconfig
eth0: dm9000 at c285e000,c2866044 IRQ 107 MAC: 00:00:00:00:00:00
physmap platform flash device: 04000000 at 10000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
physmap-flash.0: Found an alias at 0x2000000 for the chip at 0x0
 Amd/Fujitsu Extended Query Table at 0x0040
physmap-flash.0: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
6 cmdlinepart partitions found on MTD device physmap-flash.0
Creating 6 MTD partitions on "physmap-flash.0":
0x00000000-0x00060000 : "boot"
0x00060000-0x00200000 : "linux"
0x00200000-0x00700000 : "rootfs"
0x00700000-0x01400000 : "app"
0x01400000-0x01500000 : "log"
0x01500000-0x02000000 : "fonts"
mice: PS/2 mouse device common for all mice
rtc: 0x00052098 0x00000000
at91_rtt at91_rtt: rtc core: registered at91_rtt as rtc0
AT91 Real Time Clock driver.
i2c /dev entries driver
at91_i2c at91_i2c: AT91 i2c bus driver.
Driver for 1-wire Dallas network protocol.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing init memory: 104K
---snap---


"Disclaimer: This message is intended only for the use of the individual or entity to
which it is addressed and may contain information which is privileged, confidential, proprietary,
or exempt from disclosure under applicable law. If you are not the intended recipient or the person
responsible for delivering the message to the intended recipient, you are strictly prohibited from
disclosing, distributing, copying, or in any way using this message. If you have received this 
communication in error, please notify the sender and destroy and delete any copies you may have
received."
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100426/cb4c275e/attachment-0001.htm>
