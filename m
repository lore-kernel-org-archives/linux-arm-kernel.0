From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Wed, 5 Dec 2012 09:15:43 -0500
Subject: at91: Status of NAND flash access
In-Reply-To: <50BEF0C0.7060807@atmel.com>
References: <91586D499ADFD74FBCFB8425266A5DE4013765CC370A@pluto.melinkcorp.local>
 <50BDD661.7070803@atmel.com>
 <91586D499ADFD74FBCFB8425266A5DE4013765CC3D14@pluto.melinkcorp.local>
 <50BEF0C0.7060807@atmel.com>
Message-ID: <91586D499ADFD74FBCFB8425266A5DE4013765D969EE@pluto.melinkcorp.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Josh,

Yes, that worked!  I have to still need change a few device tree settings to use the peripherals I want to use (certain USARTs, RTC, WDT, ADC) but my system now completely boots.  Thanks for the help.

I have a thread on the Atmel forum related to this issue.  I will be updating that in the next day or so with some more detailed information.

Thanks again,
Bryan

> -----Original Message-----
> From: Josh Wu [mailto:josh.wu at atmel.com]
> Sent: Wednesday, December 05, 2012 1:59 AM
> To: Bryan Evenson
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: at91: Status of NAND flash access
>
> On 12/5/2012 12:24 AM, Bryan Evenson wrote:
> >> -----Original Message-----
> >> From: Josh Wu [mailto:josh.wu at atmel.com]
> >> Sent: Tuesday, December 04, 2012 5:54 AM
> >> To: Bryan Evenson
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> Subject: Re: at91: Status of NAND flash access
> >>
> >> Hi, Bryan
> >>
> >> On 12/3/2012 10:39 PM, Bryan Evenson wrote:
> >>> I have a kernel build of 3.7-rc5 that is built for the AT91SAM9G25.
> >> The kernel has issues when it tries to read the filesystem from NAND
> >> flash.  If I change to an NFS setup then the filesystem loads.
> >> According to your question, it is not very clear to me, so could you
> >> give more detail then I can help.
> >>
> >> What type (ubi, jffs2, or others) of your filesystem is used? How do
> >> you flush the file system into the nand flash, by SAM-BA, or U-Boot?
> >> With or without pmecc?
> >> And what ecc type (pmecc, soft, none) do you enabled in the kernel?
> >>
> > I have a UBI filesystem, built using OE (2011.03-maintenance branch).
> > I've been burning the filesystem to flash using SAM-BA, following the
> > instructions on the Atmel Linux4SAM site (on this page here:
> http://www.at91.com/linux4sam/bin/view/Linux4SAM/FlashRootFs_9x5).
>
> I checked the website, so your filesystem enable the PMECC with 2bits
> error bits.
>
> >
> > Here are all my MTD and filesystem related flags I have enabled in my
> > kernel configuration.  If you see any missing that I should have set
> > for UBI access of NAND flash, please let me know.
> In your defconfig, the UBI filesystem is included.
> >
> > Also note that I am using the instructions found here to build this
> > kernel: http://www.eewiki.net/display/linuxonarm/AT91SAM9x5, which
> > means I am using the kernel extracted from the listed fork with the
> > listed patches applied.
> >
> > #
> > # Bus devices
> > #
> > CONFIG_MTD=y
> > CONFIG_MTD_CMDLINE_PARTS=y
> > CONFIG_MTD_OF_PARTS=y
> >
> > #
> > # User Modules And Translation Layers
> > #
> > CONFIG_MTD_CHAR=y
> > CONFIG_MTD_BLKDEVS=y
> > CONFIG_MTD_BLOCK=y
> >
> > #
> > # RAM/ROM/Flash chip drivers
> > #
> > CONFIG_MTD_MAP_BANK_WIDTH_1=y
> > CONFIG_MTD_MAP_BANK_WIDTH_2=y
> > CONFIG_MTD_MAP_BANK_WIDTH_4=y
> > CONFIG_MTD_CFI_I1=y
> > CONFIG_MTD_CFI_I2=y
> >
> > #
> > # Disk-On-Chip Device Drivers
> > #
> > CONFIG_MTD_NAND_ECC=y
> > CONFIG_MTD_NAND=y
> > CONFIG_MTD_NAND_IDS=y
> > CONFIG_MTD_NAND_ATMEL=y
> >
> > #
> > # LPDDR flash memory drivers
> > #
> > CONFIG_MTD_UBI=y
> > CONFIG_MTD_UBI_WL_THRESHOLD=4096
> > CONFIG_MTD_UBI_BEB_LIMIT=20
> > CONFIG_MTD_UBI_GLUEBI=y
> > CONFIG_DTC=y
> > CONFIG_OF=y
> >
> > #
> > # Device Tree and Open Firmware support # CONFIG_PROC_DEVICETREE=y
> > CONFIG_OF_FLATTREE=y CONFIG_OF_EARLY_FLATTREE=y CONFIG_OF_ADDRESS=y
> > CONFIG_OF_IRQ=y CONFIG_OF_DEVICE=y CONFIG_OF_I2C=y CONFIG_OF_NET=y
> > CONFIG_OF_MDIO=y CONFIG_OF_MTD=y CONFIG_BLK_DEV=y
> > CONFIG_BLK_DEV_LOOP=y
> > CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
> >
> > #
> > # File systems
> > #
> > CONFIG_EXT2_FS=y
> > CONFIG_EXT2_FS_XATTR=y
> > CONFIG_EXT2_FS_POSIX_ACL=y
> > CONFIG_EXT2_FS_SECURITY=y
> > CONFIG_EXT3_FS=y
> > CONFIG_EXT3_DEFAULTS_TO_ORDERED=y
> > CONFIG_EXT3_FS_XATTR=y
> > CONFIG_EXT3_FS_POSIX_ACL=y
> > CONFIG_EXT3_FS_SECURITY=y
> > CONFIG_EXT4_FS=y
> > CONFIG_EXT4_FS_XATTR=y
> > CONFIG_EXT4_FS_POSIX_ACL=y
> > CONFIG_EXT4_FS_SECURITY=y
> > CONFIG_JBD=y
> > CONFIG_JBD2=y
> > CONFIG_FS_MBCACHE=y
> > CONFIG_FS_POSIX_ACL=y
> > CONFIG_FILE_LOCKING=y
> > CONFIG_FSNOTIFY=y
> > CONFIG_DNOTIFY=y
> > CONFIG_INOTIFY_USER=y
> > CONFIG_FANOTIFY=y
> > CONFIG_GENERIC_ACL=y
> >
> > #
> > # Pseudo filesystems
> > #
> > CONFIG_PROC_FS=y
> > CONFIG_PROC_SYSCTL=y
> > CONFIG_PROC_PAGE_MONITOR=y
> > CONFIG_SYSFS=y
> > CONFIG_TMPFS=y
> > CONFIG_TMPFS_POSIX_ACL=y
> > CONFIG_TMPFS_XATTR=y
> > CONFIG_MISC_FILESYSTEMS=y
> > CONFIG_JFFS2_FS=y
> > CONFIG_JFFS2_FS_DEBUG=0
> > CONFIG_JFFS2_FS_WRITEBUFFER=y
> > CONFIG_JFFS2_ZLIB=y
> > CONFIG_JFFS2_RTIME=y
> > CONFIG_UBIFS_FS=y
> > CONFIG_UBIFS_FS_ADVANCED_COMPR=y
> > CONFIG_UBIFS_FS_LZO=y
> > CONFIG_UBIFS_FS_ZLIB=y
> > CONFIG_NETWORK_FILESYSTEMS=y
> > CONFIG_NFS_FS=y
> > CONFIG_NFS_V2=y
> > CONFIG_NFS_V3=y
> > CONFIG_NFS_V3_ACL=y
> > CONFIG_NFS_V4=y
> > CONFIG_ROOT_NFS=y
> > CONFIG_NFS_USE_KERNEL_DNS=y
> > CONFIG_LOCKD=y
> > CONFIG_LOCKD_V4=y
> > CONFIG_NFS_ACL_SUPPORT=y
> > CONFIG_NFS_COMMON=y
> > CONFIG_SUNRPC=y
> > CONFIG_SUNRPC_GSS=y
> > CONFIG_NLS=y
> > CONFIG_NLS_DEFAULT="iso8859-1"
> > CONFIG_NLS_CODEPAGE_437=y
> > CONFIG_NLS_CODEPAGE_850=y
> > CONFIG_NLS_ISO8859_1=y
> >
> >>> I've seen some patches on this list lately related to AT91 NAND
> >>> flash
> >> (specifically this thread:
> >> http://lists.infradead.org/pipermail/linux-
> >> arm-kernel/2012-November/133748.html) and I believe my problems may
> >> be related to this issue.  But, I'm having trouble following the
> >> thread to find the current status.
> >>> Can anyone tell me what the status is on NAND flash access for the
> >> AT91 series with the 3.7-rc5 kernel?  If this version has a known
> >> bug, is there a different suggested version I use that fixes the
> issue?
> >> In 3.7-rc5, I think the atmel nand driver should work well with
> >> AT91SAM9G25EK board even without the patch you mentioned in above
> URL.
> >>
> >> Just for PMECC, you need add following code in
> >> arch/arm/boot/dts/at91sam9x5cm.dtsi:
> >> -                        nand-ecc-mode = "soft";
> >> +                       nand-ecc-mode = "hw";
> >> +                        atmel,has-pmecc;        /* Enable PMECC */
> >> +                        atmel,pmecc-cap = <2>;    /* PMECC error
> >> bits*/
> >> +                        atmel,pmecc-sector-size = <512>;  /* sector
> >> size for PMECC, it is not page size */
> >>
> >> Also you can check the readme file in:
> >> Documentation/devicetree/bindings/mtd/atmel-nand.txt
> >>
> > I did not have the NAND flash setup correctly in the dtsi.  I applied
> > the patch that you provided, rebuilt and reloaded my kernel.
> > Unfortunately, the filesystem is still not being read from flash
> > correctly.  It looks like the kernel correctly identifies the NAND
> > flash and sets up the partitions, but has problems when it attempts
> to read out the filesystem.  Here is the kernel boot output.
> > Do you see anything that tells you what may be going wrong?
>
>
> [    1.226562] UBI: attaching mtd1 to ubi0
> [    1.230468] uncorrectable error :
>
> ^^^^^^^^^^^^
> After checking the log, it shows the nand driver use the soft ecc. So
> the pmecc is not enable yet.
>
> Checking the 3.7-rc7, I found the patch I gave to you is not complete
> for pmecc enable, here is the whole patch to enable PMECC in dtsi.
> Please apply it and give me the feedback. Sorry for the missing of the
> part of at91sam9x5.dtsi.
>
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi
> b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 0cc062b..32ca418 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -281,7 +281,11 @@
>               #address-cells = <1>;
>               #size-cells = <1>;
>               reg = <0x40000000 0x10000000
> +                0xffffe000 0x600    /* PMECC Registers */
> +                0xffffe600 0x200    /* PMECC Error Location Registers
> */
> +                0x00100000 0x100000    /* ROM code */
>                     >;
> +            atmel,pmecc-lookup-table-offset = <0x8000 0x10000>;
>               atmel,nand-addr-offset = <21>;
>               atmel,nand-cmd-offset = <22>;
>               gpios = <&pioD 5 0
> diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi
> b/arch/arm/boot/dts/at91sam9x5cm.dtsi
> index 31e7be2..4027ac7 100644
> --- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
> @@ -26,7 +26,10 @@
>       ahb {
>           nand0: nand at 40000000 {
>               nand-bus-width = <8>;
> -            nand-ecc-mode = "soft";
> +            nand-ecc-mode = "hw";
> +            atmel,has-pmecc;    /* Enable PMECC */
> +            atmel,pmecc-cap = <2>;
> +            atmel,pmecc-sector-size = <512>;
>               nand-on-flash-bbt;
>               status = "okay";
>
> --
> 1.7.9.5
>
> Best Regards,
> Josh Wu
> >
> > [    0.000000] Booting Linux on physical CPU 0
> > [    0.000000] Linux version 3.7.0-rc7-armv5-x0.11 (xxxx at xxxx) (gcc
> versio
> > n 4.6.2 20121016 (release) [ARM/embedded-4_6-branch revision 192487]
> > (GNU Tools for ARM Embedded Processors) ) #1 Tue Dec 4 10:29:17 EST
> 2012
> > [    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ),
> cr=00053177
> > [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> > [    0.000000] Machine: Atmel AT91SAM (Device Tree), model: Atmel
> AT91SAM9G25-EK
> > [    0.000000] Memory policy: ECC disabled, Data cache writeback
> > [    0.000000] AT91: Detected soc type: at91sam9x5
> > [    0.000000] AT91: Detected soc subtype: at91sam9g25
> > [    0.000000] AT91: sram at 0x300000 of 0x8000 mapped at 0xfef70000
> > [    0.000000] Clocks: CPU 400 MHz, master 133 MHz, main 12.000 MHz
> > [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pag
> > es: 32512
> > [    0.000000] Kernel command line: mem=128M console=ttyS0,115200
> mtdparts=atmel
> > _nand:8M(bootstrap/uboot/kernel)ro,-(rootfs) root=/dev/mtdblock1 rw
> > rootfstype=u bifs ubi.mtd=1 root=ubi0:rootfs
> > [    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
> > [    0.000000] Dentry cache hash table entries: 16384 (order: 4,
> 65536 bytes)
> > [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768
> bytes)
> > [    0.000000] Memory: 128MB = 128MB total
> > [    0.000000] Memory: 124312k/124312k available, 6760k reserved, 0K
> highmem
> > [    0.000000] Virtual kernel memory layout:
> > [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> > [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
> > [    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
> > [    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
> > [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
> > [    0.000000]       .text : 0xc0008000 - 0xc04b01d8   (4769 kB)
> > [    0.000000]       .init : 0xc04b1000 - 0xc04dc304   ( 173 kB)
> > [    0.000000]       .data : 0xc04de000 - 0xc050e9a0   ( 195 kB)
> > [    0.000000]        .bss : 0xc050e9c4 - 0xc056dd1c   ( 381 kB)
> > [    0.000000] NR_IRQS:16 nr_irqs:16 16
> > [    0.000000] sched_clock: 32 bits at 256 Hz, resolution 3906250ns,
> wraps every
> >   3892314108ms
> > [    0.000000] Console: colour dummy device 80x30
> > [    0.035156] Calibrating delay loop... 199.80 BogoMIPS (lpj=389120)
> > [    0.035156] pid_max: default: 32768 minimum: 301
> > [    0.035156] Mount-cache hash table entries: 512
> > [    0.039062] CPU: Testing write buffer coherency: ok
> > [    0.039062] Setting up static identity map for 0x2036cb00 -
> 0x2036cb58
> > [    0.039062] devtmpfs: initialized
> > [    0.042968] NET: Registered protocol family 16
> > [    0.042968] DMA: preallocated 256 KiB pool for atomic coherent
> allocations
> > [    0.070312] No ATAGs?
> > [    0.070312] AT91: Power Management
> > [    0.070312] AT91: Starting after power-restored wakeup
> > [    0.125000] bio: create slab <bio-0> at 0
> > [    0.128906] SCSI subsystem initialized
> > [    0.132812] usbcore: registered new interface driver usbfs
> > [    0.132812] usbcore: registered new interface driver hub
> > [    0.132812] usbcore: registered new device driver usb
> > [    0.136718] at91_i2c f8010000.i2c: AT91 i2c bus driver.
> > [    0.136718] at91_i2c f8014000.i2c: AT91 i2c bus driver.
> > [    0.140625] at91_i2c f8018000.i2c: AT91 i2c bus driver.
> > [    0.144531] Switching to clocksource tcb_clksrc
> > [    0.199218] NET: Registered protocol family 2
> > [    0.203125] TCP established hash table entries: 4096 (order: 3,
> 32768 bytes)
> > [    0.203125] TCP bind hash table entries: 4096 (order: 2, 16384
> bytes)
> > [    0.203125] TCP: Hash tables configured (established 4096 bind
> 4096)
> > [    0.203125] TCP: reno registered
> > [    0.203125] UDP hash table entries: 256 (order: 0, 4096 bytes)
> > [    0.203125] UDP-Lite hash table entries: 256 (order: 0, 4096
> bytes)
> > [    0.203125] NET: Registered protocol family 1
> > [    0.203125] RPC: Registered named UNIX socket transport module.
> > [    0.203125] RPC: Registered udp transport module.
> > [    0.203125] RPC: Registered tcp transport module.
> > [    0.203125] RPC: Registered tcp NFSv4.1 backchannel transport
> module.
> > [    0.210937] NFS: Registering the id_resolver key type
> > [    0.210937] Key type id_resolver registered
> > [    0.210937] Key type id_legacy registered
> > [    0.210937] jffs2: version 2.2. (NAND)  ? 2001-2006 Red Hat, Inc.
> > [    0.210937] msgmni has been set to 242
> > [    0.210937] io scheduler noop registered (default)
> > [    0.222656] fffff200.serial: ttyS0 at MMIO 0xfffff200 (irq = 18)
> is a ATMEL_S
> > ERIAL
> > [    0.613281] console [ttyS0] enabled
> > [    0.617187] f801c000.serial: ttyS1 at MMIO 0xf801c000 (irq = 22)
> is a ATMEL_S
> > ERIAL
> > [    0.632812] brd: module loaded
> > [    0.652343] loop: module loaded
> > [    0.667968] atmel_nand: Use On Flash BBT
> > [    0.671875] atmel_nand 40000000.nand: No DMA support for NAND
> access.
> > [    0.679687] ONFI param page 0 valid
> > [    0.683593] ONFI flash detected
> > [    0.687500] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda
> (Micron MT29F2G
> > 08AAD), page size: 2048, OOB size: 64
> > [    0.699218] Bad block table found at page 131008, version 0x01
> > [    0.703125] Bad block table found at page 130944, version 0x01
> > [    0.710937] nand_read_bbt: bad block at 0x000009380000
> > [    0.714843] 2 cmdlinepart partitions found on MTD device
> atmel_nand
> > [    0.722656] Creating 2 MTD partitions on "atmel_nand":
> > [    0.726562] 0x000000000000-0x000000800000 :
> "bootstrap/uboot/kernel"
> > [    0.734375] 0x000000800000-0x000010000000 : "rootfs"
> > [    0.753906] macb f802c000.ethernet (unregistered net_device):
> invalid hw addr
> > ess, using random
> > [    0.765625] libphy: MACB_mii_bus: probed
> > [    0.769531] macb f802c000.ethernet eth0: Cadence MACB at
> 0xf802c000 irq 23 (4
> > a:b7:82:09:12:d7)
> > [    0.781250] macb f802c000.ethernet eth0: attached PHY driver
> [Davicom DM9161A
> > ] (mii_bus:phy_addr=f802c000.etherne:00, irq=-1)
> > [    0.792968] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI)
> Driver
> > [    0.800781] atmel-ehci 700000.ehci: Atmel EHCI UHP HS
> > [    0.804687] atmel-ehci 700000.ehci: new USB bus registered,
> assigned bus numb
> > er 1
> > [    0.812500] atmel-ehci 700000.ehci: irq 30, io mem 0x00700000
> > [    0.828125] atmel-ehci 700000.ehci: USB 2.0 started, EHCI 1.00
> > [    0.832031] usb usb1: New USB device found, idVendor=1d6b,
> idProduct=0002
> > [    0.839843] usb usb1: New USB device strings: Mfr=3, Product=2,
> SerialNumber=
> > 1
> > [    0.847656] usb usb1: Product: Atmel EHCI UHP HS
> > [    0.851562] usb usb1: Manufacturer: Linux 3.7.0-rc7-armv5-x0.11
> ehci_hcd
> > [    0.859375] usb usb1: SerialNumber: 700000.ehci
> > [    0.863281] hub 1-0:1.0: USB hub found
> > [    0.867187] hub 1-0:1.0: 3 ports detected
> > [    0.875000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> > [    0.878906] at91_ohci 600000.ohci: AT91 OHCI
> > [    0.882812] at91_ohci 600000.ohci: new USB bus registered,
> assigned bus numbe
> > r 2
> > [    0.890625] at91_ohci 600000.ohci: irq 30, io mem 0x00600000
> > [    0.957031] usb usb2: New USB device found, idVendor=1d6b,
> idProduct=0001
> > [    0.960937] usb usb2: New USB device strings: Mfr=3, Product=2,
> SerialNumber=
> > 1
> > [    0.968750] usb usb2: Product: AT91 OHCI
> > [    0.972656] usb usb2: Manufacturer: Linux 3.7.0-rc7-armv5-x0.11
> ohci_hcd
> > [    0.980468] usb usb2: SerialNumber: at91
> > [    0.984375] hub 2-0:1.0: USB hub found
> > [    0.988281] hub 2-0:1.0: 2 ports detected
> > [    0.996093] usbcore: registered new interface driver cdc_acm
> > [    1.000000] cdc_acm: USB Abstract Control Model driver for USB
> modems and ISD
> > N adapters
> > [    1.011718] usbcore: registered new interface driver uas
> > [    1.015625] Initializing USB Mass Storage driver...
> > [    1.019531] usbcore: registered new interface driver usb-storage
> > [    1.027343] USB Mass Storage support registered.
> > [    1.031250] usbcore: registered new interface driver ums-alauda
> > [    1.039062] usbcore: registered new interface driver ums-cypress
> > [    1.046875] usbcore: registered new interface driver ums-datafab
> > [    1.050781] usbcore: registered new interface driver ums_eneub6250
> > [    1.058593] usbcore: registered new interface driver ums-freecom
> > [    1.066406] usbcore: registered new interface driver ums-isd200
> > [    1.070312] usbcore: registered new interface driver ums-jumpshot
> > [    1.078125] usbcore: registered new interface driver ums-karma
> > [    1.085937] usbcore: registered new interface driver ums-onetouch
> > [    1.089843] usbcore: registered new interface driver ums-realtek
> > [    1.097656] usbcore: registered new interface driver ums-sddr09
> > [    1.105468] usbcore: registered new interface driver ums-sddr55
> > [    1.109375] usbcore: registered new interface driver ums-usbat
> > [    1.117187] usbcore: registered new interface driver usbserial
> > [    1.125000] usbcore: registered new interface driver
> usbserial_generic
> > [    1.132812] usbserial: USB Serial support registered for generic
> > [    1.136718] usbcore: registered new interface driver ftdi_sio
> > [    1.144531] usbserial: USB Serial support registered for FTDI USB
> Serial Devi
> > ce
> > [    1.152343] usbcore: registered new interface driver pl2303
> > [    1.156250] usbserial: USB Serial support registered for pl2303
> > [    1.164062] mousedev: PS/2 mouse device common for all mice
> > [    1.171875] i2c /dev entries driver
> > [    1.183593] usbcore: registered new interface driver usbhid
> > [    1.191406] usbhid: USB HID core driver
> > [    1.195312] TCP: cubic registered
> > [    1.195312] NET: Registered protocol family 10
> > [    1.203125] sit: IPv6 over IPv4 tunneling driver
> > [    1.210937] NET: Registered protocol family 17
> > [    1.214843] Key type dns_resolver registered
> > [    1.226562] UBI: attaching mtd1 to ubi0
> > [    1.230468] uncorrectable error :
> > [    1.234375] UBI warning: ubi_io_read: error -74 (ECC error) while
> reading 64
> > bytes from PEB 0:0, read only 64 bytes, retry
> > [    1.242187] uncorrectable error :
> > [    1.246093] UBI warning: ubi_io_read: error -74 (ECC error) while
> reading 64
> > bytes from PEB 0:0, read only 64 bytes, retry
> > [    1.257812] uncorrectable error :
> > [    1.261718] UBI warning: ubi_io_read: error -74 (ECC error) while
> reading 64
> > bytes from PEB 0:0, read only 64 bytes, retry
> > [    1.273437] uncorrectable error :
> > [    1.277343] UBI error: ubi_io_read: error -74 (ECC error) while
> reading 64 by
> > tes from PEB 0:0, read 64 bytes
> > [    1.285156] [<c000d2bc>] (unwind_backtrace+0x0/0xe0) from
> [<c0243764>] (ubi_i
> > o_read+0x1d4/0x2a4)
> > [    1.292968] [<c0243764>] (ubi_io_read+0x1d4/0x2a4) from
> [<c0243a74>] (ubi_io_
> > read_ec_hdr+0x68/0x214)
> > [    1.304687] [<c0243a74>] (ubi_io_read_ec_hdr+0x68/0x214) from
> [<c0247da0>] (u
> > bi_attach+0x104/0x13e4)
> > [    1.312500] [<c0247da0>] (ubi_attach+0x104/0x13e4) from
> [<c023e268>] (ubi_att
> > ach_mtd_dev+0x5a4/0xb94)
> > [    1.320312] [<c023e268>] (ubi_attach_mtd_dev+0x5a4/0xb94) from
> [<c04c88d4>] (
> > ubi_init+0x1d8/0x2d8)
> > [    1.332031] [<c04c88d4>] (ubi_init+0x1d8/0x2d8) from [<c0008860>]
> (do_one_ini
> > tcall+0x90/0x168)
> > [    1.339843] [<c0008860>] (do_one_initcall+0x90/0x168) from
> [<c0363f10>] (kern
> > el_init+0xe4/0x298)
> > [    1.347656] [<c0363f10>] (kernel_init+0xe4/0x298) from
> [<c00093f0>] (ret_from
> > _fork+0x14/0x24)
> > [    1.355468] UBI error: validate_ec_hdr: bad VID header offset
> 2048, expected
> > 512
> > [    1.363281] UBI error: validate_ec_hdr: bad EC header
> > [    1.367187] Erase counter header dump:
> > [    1.371093]  magic          0x55424923
> > [    1.375000]  version        1
> > [    1.378906]  ec             4
> > [    1.382812]  vid_hdr_offset 2048
> > [    1.386718]  data_offset    4096
> > [    1.390625]  image_seq      191777507
> > [    1.390625]  hdr_crc        0xecd7a545
> > [    1.394531] erase counter header hexdump:
> > [    1.398437] [<c000d2bc>] (unwind_backtrace+0x0/0xe0) from
> [<c024303c>] (valid
> > ate_ec_hdr+0x148/0x168)
> > [    1.410156] [<c024303c>] (validate_ec_hdr+0x148/0x168) from
> [<c0243bc4>] (ubi
> > _io_read_ec_hdr+0x1b8/0x214)
> > [    1.417968] [<c0243bc4>] (ubi_io_read_ec_hdr+0x1b8/0x214) from
> [<c0247da0>] (
> > ubi_attach+0x104/0x13e4)
> > [    1.429687] [<c0247da0>] (ubi_attach+0x104/0x13e4) from
> [<c023e268>] (ubi_att
> > ach_mtd_dev+0x5a4/0xb94)
> > [    1.437500] [<c023e268>] (ubi_attach_mtd_dev+0x5a4/0xb94) from
> [<c04c88d4>] (
> > ubi_init+0x1d8/0x2d8)
> > [    1.445312] [<c04c88d4>] (ubi_init+0x1d8/0x2d8) from [<c0008860>]
> (do_one_ini
> > tcall+0x90/0x168)
> > [    1.453125] [<c0008860>] (do_one_initcall+0x90/0x168) from
> [<c0363f10>] (kern
> > el_init+0xe4/0x298)
> > [    1.464843] [<c0363f10>] (kernel_init+0xe4/0x298) from
> [<c00093f0>] (ret_from
> > _fork+0x14/0x24)
> > [    1.472656] UBI error: ubi_io_read_ec_hdr: validation failed for
> PEB 0
> > [    1.476562] UBI error: ubi_attach_mtd_dev: failed to attach mtd1,
> error -22
> > [    1.484375] UBI error: ubi_init: cannot attach mtd1
> > [    1.492187] drivers/rtc/hctosys.c: unable to open rtc device
> (rtc0)
> > [    1.496093] atmel_mci f0008000.mmc: version: 0x504
> > [    1.503906] atmel_mci f0008000.mmc: using PIO
> > [    1.539062] atmel_mci f0008000.mmc: Atmel MCI controller at
> 0xf0008000 irq 28
> > , 1 slots
> > [    1.546875] atmel_mci f000c000.mmc: version: 0x504
> > [    1.550781] atmel_mci f000c000.mmc: using PIO
> > [    1.585937] atmel_mci f000c000.mmc: Atmel MCI controller at
> 0xf000c000 irq 29
> > , 1 slots
> > [    1.593750] UBIFS error (pid 1): ubifs_mount: cannot open
> "ubi0:rootfs", erro
> > r -19
> > [    1.601562] VFS: Cannot open root device "ubi0:rootfs" or unknown-
> block(0,0):
> >   error -19
> > [    1.609375] Please append a correct "root=" boot option; here are
> the availab
> > le partitions:
> > [    1.617187] 1f00            8192 mtdblock0  (driver?)
> > [    1.621093] 1f01          253952 mtdblock1  (driver?)
> > [    1.628906] Kernel panic - not syncing: VFS: Unable to mount root
> fs on unkno
> > wn-block(0,0)
> >
> > Thanks,
> > Bryan
> >
> >> Best Regards,
> >> Josh Wu
> >>
> >>> Thanks,
> >>> Bryan
> >>>
> >>>
> >>>
> >>> _______________________________________________
> >>> linux-arm-kernel mailing list
> >>> linux-arm-kernel at lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
