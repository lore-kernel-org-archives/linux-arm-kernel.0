From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 28 Mar 2011 11:17:43 +1300
Subject: Regression: NFS rootfs: BUG: spinlock recursion on boot
Message-ID: <4D8FB787.4060904@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

My ARM EP93xx board panics on boot on 2.6.38-rc8 (see boot log below). I
am using an NFS based root filesystem. My .config is attached.

I have managed to bisect the problem to the following commit:

250df6ed274d767da844a5d9f05720b804240197 is the first bad commit
commit 250df6ed274d767da844a5d9f05720b804240197
Author: Dave Chinner <dchinner@redhat.com>
Date:   Tue Mar 22 22:23:36 2011 +1100

    fs: protect inode->i_state with inode->i_lock
    
    Protect inode state transitions and validity checks with the
    inode->i_lock. This enables us to make inode state transitions
    independently of the inode_lock and is the first step to peeling
    away the inode_lock from the code.
    
    This requires that __iget() is done atomically with i_state checks
    during list traversals so that we don't race with another thread
    marking the inode I_FREEING between the state check and grabbing the
    reference.
    
    Also remove the unlock_new_inode() memory barrier optimisation
    required to avoid taking the inode_lock when clearing I_NEW.
    Simplify the code by simply taking the inode->i_lock around the
    state change and wakeup. Because the wakeup is no longer tricky,
    remove the wake_up_inode() function and open code the wakeup where
    necessary.
    
    Signed-off-by: Dave Chinner <dchinner@redhat.com>
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Thanks,
~Ryan

Bootlog:
---

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.38-08569-g16c29da (ryan at okiwi) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #763 Mon Mar 28 09:18:51 NZDT 2011
CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=c0007177
CPU: VIVT data cache, VIVT instruction cache
Machine: Bluewater Systems Snapper CL15
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 15952
Kernel command line: console=ttyAM0,115200 root=/dev/nfs ip=bootp
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB = 64MB total
Memory: 60936k/60936k available, 4600k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xce000000 - 0xfe800000   ( 776 MB)
    lowmem  : 0xc0000000 - 0xcd800000   ( 216 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc0022000   ( 104 kB)
      .text : 0xc0022000 - 0xc03aebbc   (3635 kB)
      .data : 0xc03b0000 - 0xc03d2e40   ( 140 kB)
NR_IRQS:120
VIC @fefb0000: id 0x00041190, vendor 0x41
VIC @fefc0000: id 0x00041190, vendor 0x41
Calibrating delay loop... 104.34 BogoMIPS (lpj=521728)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
ep93xx clock: PLL1 running at 199 MHz, PLL2 at 192 MHz
ep93xx clock: FCLK 199 MHz, HCLK 99 MHz, PCLK 49 MHz
ep93xx dma_m2p: M2P DMA subsystem initialized
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c-gpio i2c-gpio.0: using pins 49 (SDA) and 48 (SCL)
Advanced Linux Sound Architecture Driver Version 1.0.24.
Bluetooth: Core ver 2.16
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
IPv4 FIB: Using LC-trie version 0.409
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 3, 40960 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
UDP hash table entries: 128 (order: 0, 6144 bytes)
UDP-Lite hash table entries: 128 (order: 0, 6144 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (extended precision)
JFFS2 version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
msgmni has been set to 119
io scheduler noop registered
io scheduler deadline registered (default)
Serial: AMBA driver
apb:uart1: ttyAM0 at MMIO 0x808c0000 (irq = 52) is a AMBA
console [ttyAM0] enabled
apb:uart2: ttyAM1 at MMIO 0x808d0000 (irq = 54) is a AMBA
apb:uart3: ttyAM2 at MMIO 0x808e0000 (irq = 55) is a AMBA
nbd: registered device at major 43
ep93xx-eth version 0.1 loading
eth0: ep93xx on-chip ethernet, IRQ 39, 00:00:00:00:00:01
rtl8150: v0.6.2 (2004/08/27):rtl8150 based usb-ethernet driver
usbcore: registered new interface driver rtl8150
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ep93xx-ohci ep93xx-ohci: EP93xx OHCI
ep93xx-ohci ep93xx-ohci: new USB bus registered, assigned bus number 1
ep93xx-ohci ep93xx-ohci: irq 56, io mem 0x80020000
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EP93xx OHCI
usb usb1: Manufacturer: Linux 2.6.38-08569-g16c29da ohci_hcd
usb usb1: SerialNumber: ep93xx
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbserial
usbserial: USB Serial Driver core
USB Serial support registered for pl2303
usbcore: registered new interface driver pl2303
pl2303: Prolific PL2303 USB to serial adaptor driver
ep93xx-rtc ep93xx-rtc: rtc core: registered ep93xx-rtc as rtc0
i2c /dev entries driver
ep93xx_wdt: EP93XX watchdog, driver version 0.3
AIC23 Audio Codec 0.1
asoc: tlv320aic23-hifi <-> ep93xx-i2s mapping ok
ALSA device list:
  #0: Snapper CL15
TCP cubic registered
NET: Registered protocol family 10
NET: Registered protocol family 17
NET: Registered protocol family 15
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11
ep93xx-rtc ep93xx-rtc: setting system clock to 1970-01-01 00:00:03 UTC (3)
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 192.168.2.2, my address is 192.168.2.187
IP-Config: Complete:
     device=eth0, addr=192.168.2.187, mask=255.255.255.0, gw=192.168.2.254,
     host=192.168.2.187, domain=bluewaternz.com, nis-domain=bluewater,
     bootserver=192.168.2.2, rootserver=192.168.2.2, rootpath=
VFS: Mounted root (nfs filesystem) on device 0:12.
Freeing init memory: 104K
init started: BusyBox v1.10.1 (2009-02-03 09:12:12 NZDT)
starting pid 250, tty '': '/etc/init.d/rcS'
Mounting system filesystems...
mount: mounting none on /sys/kernel/debug failed: No such file or directory
Starting local networking...
Setting up console ttyAM0...
starting pid 262, tty '': '/sbin/getty -L -n tty_console 115200 xterm'
BUG: spinlock recursion on CPU#0, getty/262
 lock: cc421cb4, .magic: dead4ead, .owner: getty/262, .owner_cpu: 0
[<c0031b0c>] (unwind_backtrace+0x0/0xe4) from [<c015f16c>] (do_raw_spin_lock+0x40/0x13c)
[<c015f16c>] (do_raw_spin_lock+0x40/0x13c) from [<c00a938c>] (igrab+0x14/0x48)
[<c00a938c>] (igrab+0x14/0x48) from [<c01186bc>] (nfs_updatepage+0x2e0/0x524)
[<c01186bc>] (nfs_updatepage+0x2e0/0x524) from [<c010b19c>] (nfs_write_end+0x23c/0x270)
[<c010b19c>] (nfs_write_end+0x23c/0x270) from [<c006b484>] (generic_file_buffered_write+0x180/0x248)
[<c006b484>] (generic_file_buffered_write+0x180/0x248) from [<c006d060>] (__generic_file_aio_write+0x3b8/0x3f4)
[<c006d060>] (__generic_file_aio_write+0x3b8/0x3f4) from [<c006d108>] (generic_file_aio_write+0x6c/0xdc)
[<c006d108>] (generic_file_aio_write+0x6c/0xdc) from [<c010bce0>] (nfs_file_write+0xec/0x178)
[<c010bce0>] (nfs_file_write+0xec/0x178) from [<c00956ac>] (do_sync_write+0xa4/0xe4)
[<c00956ac>] (do_sync_write+0xa4/0xe4) from [<c00960c8>] (vfs_write+0xb4/0x12c)
[<c00960c8>] (vfs_write+0xb4/0x12c) from [<c00961f0>] (sys_write+0x3c/0x68)
[<c00961f0>] (sys_write+0x3c/0x68) from [<c002c8e0>] (ret_fast_syscall+0x0/0x2c)


-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751 
Fax:   +64 3 3779135			  USA 1800 261 2934

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: .config
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110328/cf1b35af/attachment-0001.ksh>
