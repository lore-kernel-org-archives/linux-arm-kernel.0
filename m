From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Wed, 5 Dec 2012 22:13:29 -0500
Subject: at91: Status of NAND flash access
In-Reply-To: <91586D499ADFD74FBCFB8425266A5DE4013765D969EE@pluto.melinkcorp.local>
References: <91586D499ADFD74FBCFB8425266A5DE4013765CC370A@pluto.melinkcorp.local>
 <50BDD661.7070803@atmel.com>
 <91586D499ADFD74FBCFB8425266A5DE4013765CC3D14@pluto.melinkcorp.local>
 <50BEF0C0.7060807@atmel.com>
 <91586D499ADFD74FBCFB8425266A5DE4013765D969EE@pluto.melinkcorp.local>
Message-ID: <91586D499ADFD74FBCFB8425266A5DE4013765D96E77@pluto.melinkcorp.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Josh,

I spoke too soon.  I was able to read and use the filesystem from NAND
flash with the patch you provided when I applied it to the Atmel 3.4
kernel fork over at https://github.com/linux4sam/linux-at91/ (master branch).
When I applied the same patch to the recent mainline kernel (3.7-rc8),
it's still having problems accessing flash.  The boot log shows that it is
setting up for PMECC correctly, but it has errors when it tries to read from
the filesystem.

I noticed over at the linux-at91 fork that you had applied the PMECC support
on the 3.4.x_pmecc_dt_9x5 branch a few months ago.  From browsing the mainline
I didn't see some of your changes from that branch in the mainline.  Are there
some changes from the linux-at91 fork that are still scheduled for mainlining?

If it helps, here is the boot log when I tried to boot using a 3.7-rc8 kernel
and DT.

Thanks,
Bryan

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.7.0-rc8-armv5-x0.16 (xxxx at xxxx) (gcc versio
n 4.6.2 20121016 (release) [ARM/embedded-4_6-branch revision 192487] (GNU Tools
for ARM Embedded Processors) ) #1 Wed Dec 5 16:11:30 EST 2012
[    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Atmel AT91SAM (Device Tree), model: Atmel AT91SAM9G25-EK
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AT91: Detected soc type: at91sam9x5
[    0.000000] AT91: Detected soc subtype: at91sam9g25
[    0.000000] AT91: sram at 0x300000 of 0x8000 mapped at 0xfef70000
[    0.000000] Clocks: CPU 400 MHz, master 133 MHz, main 12.000 MHz
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pag
es: 32512
[    0.000000] Kernel command line: mem=128M console=ttyS0,115200 mtdparts=atmel
_nand:8M(bootstrap/uboot/kernel)ro,-(rootfs) root=/dev/mtdblock1 rw rootfstype=u
bifs ubi.mtd=1 root=ubi0:rootfs
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Memory: 124276k/124276k available, 6796k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc04b8630   (4802 kB)
[    0.000000]       .init : 0xc04b9000 - 0xc04e45c4   ( 174 kB)
[    0.000000]       .data : 0xc04e6000 - 0xc0516ce0   ( 196 kB)
[    0.000000]        .bss : 0xc0516d04 - 0xc05760bc   ( 381 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] sched_clock: 32 bits at 256 Hz, resolution 3906250ns, wraps every
 3892314108ms
[    0.000000] Console: colour dummy device 80x30
[    0.035156] Calibrating delay loop... 199.80 BogoMIPS (lpj=389120)
[    0.035156] pid_max: default: 32768 minimum: 301
[    0.035156] Mount-cache hash table entries: 512
[    0.039062] CPU: Testing write buffer coherency: ok
[    0.039062] Setting up static identity map for 0x20371d48 - 0x20371da0
[    0.039062] devtmpfs: initialized
[    0.042968] NET: Registered protocol family 16
[    0.042968] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.070312] No ATAGs?
[    0.070312] AT91: Power Management
[    0.070312] AT91: Starting after power-restored wakeup
[    0.121093] bio: create slab <bio-0> at 0
[    0.125000] SCSI subsystem initialized
[    0.128906] usbcore: registered new interface driver usbfs
[    0.128906] usbcore: registered new interface driver hub
[    0.128906] usbcore: registered new device driver usb
[    0.132812] at91_i2c f8010000.i2c: AT91 i2c bus driver.
[    0.132812] at91_i2c f8014000.i2c: AT91 i2c bus driver.
[    0.136718] at91_i2c f8018000.i2c: AT91 i2c bus driver.
[    0.140625] Switching to clocksource tcb_clksrc
[    0.195312] NET: Registered protocol family 2
[    0.199218] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.199218] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.199218] TCP: Hash tables configured (established 4096 bind 4096)
[    0.199218] TCP: reno registered
[    0.199218] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.199218] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.199218] NET: Registered protocol family 1
[    0.199218] RPC: Registered named UNIX socket transport module.
[    0.199218] RPC: Registered udp transport module.
[    0.199218] RPC: Registered tcp transport module.
[    0.199218] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.207031] NFS: Registering the id_resolver key type
[    0.207031] Key type id_resolver registered
[    0.207031] Key type id_legacy registered
[    0.207031] jffs2: version 2.2. (NAND) ????? 2001-2006 Red Hat, Inc.
[    0.207031] msgmni has been set to 242
[    0.210937] io scheduler noop registered (default)
[    0.218750] fffff200.serial: ttyS0 at MMIO 0xfffff200 (irq = 18) is a ATMEL_S
ERIAL
[    0.609375] console [ttyS0] enabled
[    0.613281] f801c000.serial: ttyS1 at MMIO 0xf801c000 (irq = 22) is a ATMEL_S
ERIAL
[    0.632812] brd: module loaded
[    0.652343] loop: module loaded
[    0.667968] atmel_nand: Use On Flash BBT
[    0.671875] atmel_nand 40000000.nand: No DMA support for NAND access.
[    0.675781] ONFI param page 0 valid
[    0.679687] ONFI flash detected
[    0.683593] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron MT29F2G
08AAD), page size: 2048, OOB size: 64
[    0.695312] atmel_nand 40000000.nand: Initialize PMECC params, cap: 2, sector
: 512
[    0.703125] Bad block table found at page 131008, version 0x01
[    0.707031] Bad block table found at page 130944, version 0x01
[    0.714843] nand_read_bbt: bad block at 0x000009380000
[    0.718750] 2 cmdlinepart partitions found on MTD device atmel_nand
[    0.726562] Creating 2 MTD partitions on "atmel_nand":
[    0.730468] 0x000000000000-0x000000800000 : "bootstrap/uboot/kernel"
[    0.742187] 0x000000800000-0x000010000000 : "rootfs"
[    0.757812] macb f802c000.ethernet (unregistered net_device): invalid hw addr
ess, using random
[    0.773437] libphy: MACB_mii_bus: probed
[    0.777343] macb f802c000.ethernet eth0: Cadence MACB at 0xf802c000 irq 23 (c
a:2c:e6:c3:59:8f)
[    0.785156] macb f802c000.ethernet eth0: attached PHY driver [Davicom DM9161A
] (mii_bus:phy_addr=f802c000.etherne:00, irq=-1)
[    0.796875] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.804687] atmel-ehci 700000.ehci: Atmel EHCI UHP HS
[    0.808593] atmel-ehci 700000.ehci: new USB bus registered, assigned bus numb
er 1
[    0.816406] atmel-ehci 700000.ehci: irq 28, io mem 0x00700000
[    0.835937] atmel-ehci 700000.ehci: USB 2.0 started, EHCI 1.00
[    0.839843] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.847656] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=
1
[    0.855468] usb usb1: Product: Atmel EHCI UHP HS
[    0.859375] usb usb1: Manufacturer: Linux 3.7.0-rc8-armv5-x0.16 ehci_hcd
[    0.867187] usb usb1: SerialNumber: 700000.ehci
[    0.871093] hub 1-0:1.0: USB hub found
[    0.875000] hub 1-0:1.0: 3 ports detected
[    0.878906] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.886718] at91_ohci 600000.ohci: AT91 OHCI
[    0.890625] at91_ohci 600000.ohci: new USB bus registered, assigned bus numbe
r 2
[    0.898437] at91_ohci 600000.ohci: irq 28, io mem 0x00600000
[    0.964843] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    0.968750] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=
1
[    0.976562] usb usb2: Product: AT91 OHCI
[    0.980468] usb usb2: Manufacturer: Linux 3.7.0-rc8-armv5-x0.16 ohci_hcd
[    0.988281] usb usb2: SerialNumber: at91
[    0.992187] hub 2-0:1.0: USB hub found
[    0.996093] hub 2-0:1.0: 2 ports detected
[    1.003906] usbcore: registered new interface driver cdc_acm
[    1.007812] cdc_acm: USB Abstract Control Model driver for USB modems and ISD
N adapters
[    1.019531] usbcore: registered new interface driver uas
[    1.023437] Initializing USB Mass Storage driver...
[    1.027343] usbcore: registered new interface driver usb-storage
[    1.035156] USB Mass Storage support registered.
[    1.039062] usbcore: registered new interface driver ums-alauda
[    1.046875] usbcore: registered new interface driver ums-cypress
[    1.054687] usbcore: registered new interface driver ums-datafab
[    1.058593] usbcore: registered new interface driver ums_eneub6250
[    1.066406] usbcore: registered new interface driver ums-freecom
[    1.074218] usbcore: registered new interface driver ums-isd200
[    1.078125] usbcore: registered new interface driver ums-jumpshot
[    1.085937] usbcore: registered new interface driver ums-karma
[    1.093750] usbcore: registered new interface driver ums-onetouch
[    1.097656] usbcore: registered new interface driver ums-realtek
[    1.105468] usbcore: registered new interface driver ums-sddr09
[    1.113281] usbcore: registered new interface driver ums-sddr55
[    1.117187] usbcore: registered new interface driver ums-usbat
[    1.125000] usbcore: registered new interface driver usbserial
[    1.132812] usbcore: registered new interface driver usbserial_generic
[    1.140625] usbserial: USB Serial support registered for generic
[    1.144531] usbcore: registered new interface driver ftdi_sio
[    1.152343] usbserial: USB Serial support registered for FTDI USB Serial Devi
ce
[    1.160156] usbcore: registered new interface driver pl2303
[    1.167968] usbserial: USB Serial support registered for pl2303
[    1.171875] mousedev: PS/2 mouse device common for all mice
[    1.179687] i2c /dev entries driver
[    1.191406] usbcore: registered new interface driver usbhid
[    1.199218] usbhid: USB HID core driver
[    1.207031] usb 1-2: new high-speed USB device number 2 using atmel-ehci
[    1.214843] TCP: cubic registered
[    1.218750] NET: Registered protocol family 10
[    1.222656] sit: IPv6 over IPv4 tunneling driver
[    1.230468] NET: Registered protocol family 17
[    1.234375] Key type dns_resolver registered
[    1.246093] UBI: attaching mtd1 to ubi0
[    1.253906] atmel_nand 40000000.nand: PMECC: Too many errors
[    1.261718] UBI warning: ubi_io_read: error -5 while reading 64 bytes from PE
B 10:0, read only 0 bytes, retry
[    1.269531] atmel_nand 40000000.nand: PMECC: Too many errors
[    1.277343] UBI warning: ubi_io_read: error -5 while reading 64 bytes from PE
B 10:0, read only 0 bytes, retry
[    1.285156] atmel_nand 40000000.nand: PMECC: Too many errors
[    1.292968] UBI warning: ubi_io_read: error -5 while reading 64 bytes from PE
B 10:0, read only 0 bytes, retry
[    1.304687] atmel_nand 40000000.nand: PMECC: Too many errors
[    1.308593] UBI error: ubi_io_read: error -5 while reading 64 bytes from PEB
10:0, read 0 bytes
[    1.316406] [<c000d2bc>] (unwind_backtrace+0x0/0xe0) from [<c0243a10>] (ubi_i
o_read+0x1d4/0x2a4)
[    1.328125] [<c0243a10>] (ubi_io_read+0x1d4/0x2a4) from [<c0243d20>] (ubi_io_
read_ec_hdr+0x68/0x214)
[    1.335937] [<c0243d20>] (ubi_io_read_ec_hdr+0x68/0x214) from [<c024804c>] (u
bi_attach+0x104/0x13e4)
[    1.343750] [<c024804c>] (ubi_attach+0x104/0x13e4) from [<c023e514>] (ubi_att
ach_mtd_dev+0x5a4/0xb94)
[    1.355468] [<c023e514>] (ubi_attach_mtd_dev+0x5a4/0xb94) from [<c04d09dc>] (
ubi_init+0x1d8/0x2d8)
[    1.363281] [<c04d09dc>] (ubi_init+0x1d8/0x2d8) from [<c0008860>] (do_one_ini
tcall+0x90/0x168)
[    1.371093] [<c0008860>] (do_one_initcall+0x90/0x168) from [<c03686a4>] (kern
el_init+0xe8/0x2a0)
[    1.378906] [<c03686a4>] (kernel_init+0xe8/0x2a0) from [<c00093f0>] (ret_from
_fork+0x14/0x24)
[    1.386718] UBI error: ubi_attach_mtd_dev: failed to attach mtd1, error -5
[    1.394531] UBI error: ubi_init: cannot attach mtd1
[    1.402343] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    1.410156] UBIFS error (pid 1): ubifs_mount: cannot open "ubi0:rootfs", erro
r -19
[    1.417968] VFS: Cannot open root device "ubi0:rootfs" or unknown-block(0,0):
 error -19
[    1.425781] Please append a correct "root=" boot option; here are the availab
le partitions:
[    1.433593] 1f00            8192 mtdblock0  (driver?)
[    1.437500] 1f01          253952 mtdblock1  (driver?)
[    1.441406] Kernel panic - not syncing: VFS: Unable to mount root fs on unkno
wn-block(0,0)
