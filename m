From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 11 Dec 2012 16:46:00 +0800
Subject: at91: Status of NAND flash access
In-Reply-To: <91586D499ADFD74FBCFB8425266A5DE4013765D96EA5@pluto.melinkcorp.local>
References: <91586D499ADFD74FBCFB8425266A5DE4013765CC370A@pluto.melinkcorp.local>
 <50BDD661.7070803@atmel.com>
 <91586D499ADFD74FBCFB8425266A5DE4013765CC3D14@pluto.melinkcorp.local>
 <50BEF0C0.7060807@atmel.com>
 <91586D499ADFD74FBCFB8425266A5DE4013765D969EE@pluto.melinkcorp.local>
 <91586D499ADFD74FBCFB8425266A5DE4013765D96E77@pluto.melinkcorp.local>
 <50C073BD.7060604@atmel.com>
 <91586D499ADFD74FBCFB8425266A5DE4013765D96EA5@pluto.melinkcorp.local>
Message-ID: <50C6F2C8.5010705@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bryan

I tested your kernel & dtb (both 3.4 and 3.7-rc8) that you shared in 
dropbox. I can produce your situation. in my case the pmecc error offset 
is 0x86a000.
the test steps is:
    1. use a sd card boot at91bootstrap and u-boot to boot a 
at91sam9g25ek board.
    2. use u-boot command to flush a ubi rootfs in 0x800000.
    3. load your 3.4 kernel and dtb. it will boot ok.
    4. load your 3.7-rc8 kernel and dtb. it will fail to boot. "too many 
errors" happens.

But use the test step (not load 3.4 kernel & dtb):
    1. use a sd card boot at91bootstrap and u-boot to boot a 
at91sam9g25ek board.
    2. use u-boot command to flush a ubi rootfs in 0x800000.
    3. load your 3.7-rc8 kernel and dtb. it will boot ok. (use my own 
3.4 kernel & my dtb is also boot ok.)

Since I don't write DTB in nand flash at all. so it is not caused by 
write dtb in nand flash.

So I suspect your 3.4 kernel cause those problem.
Check your kernel 3.4 boot log, I suspect that PMECC is not enabled in 
your 3.4 kernel. Since in the log, I don't find the line :  atmel_nand 
40000000.nand: Initialize PMECC params, cap: 2, sector: 512

After checking your 3.4 dtb. it shows below, and the PMECC parameters is 
set correctly.

U-Boot> tftp 21000000 josh/kernel/dt/zImage-3.4-r7-at91sam9x5ek.dtb
macb0: PHY present at 0
macb0: Starting autonegotiation...
macb0: Autonegotiation complete
macb0: link up, 100Mbps full-duplex (lpa: 0x45e1)
Using macb0 device
TFTP from server 10.217.6.34; our IP address is 10.217.3.136
Filename 'josh/kernel/dt/zImage-3.4-r7-at91sam9x5ek.dtb'.
Load address: 0x21000000
Loading: *###
done
Bytes transferred = 12288 (3000 hex)
U-Boot> fdt addr 21000000
U-Boot> fdt print
.......
         nand at 40000000 {
             compatible = "atmel,at91rm9200-nand";
             #address-cells = <0x1>;
             #size-cells = <0x1>;
             reg = <0x40000000 0x10000000 0xffffe000 0x600 0xffffe600 
0x200 0x100000 0x100000>;
             atmel,pmecc-lookup-table-offset = <0x8000 0x10000>;
             atmel,nand-addr-offset = <0x15>;
             atmel,nand-cmd-offset = <0x16>;
             gpios = <0x2 0x5 0x0 0x2 0x4 0x0 0x0>;
             status = "okay";
             nand-bus-width = <0x8>;
             nand-ecc-mode = "hw";
             atmel,has-pmecc;
             atmel,pmecc-cap = <0x2>;
             atmel,pmecc-sector-size = <0x200>;
             nand-on-flash-bbt;
.......

but in the log (my comment is in below):

On 12/6/2012 9:20 PM, Bryan Evenson wrote:
>> -----Original Message-----
>> From: Josh Wu [mailto:josh.wu at atmel.com]
>> Sent: Thursday, December 06, 2012 5:30 AM
>> To: Bryan Evenson
>> Cc: linux-arm-kernel at lists.infradead.org
>> Subject: Re: at91: Status of NAND flash access
>>
>> On 12/6/2012 11:13 AM, Bryan Evenson wrote:
>>> Josh,
>>>
>>> I spoke too soon.  I was able to read and use the filesystem from
>> NAND
>>> flash with the patch you provided when I applied it to the Atmel 3.4
>>> kernel fork over at https://github.com/linux4sam/linux-at91/ (master
>> branch).
>>> When I applied the same patch to the recent mainline kernel (3.7-
>> rc8),
>>> it's still having problems accessing flash.  The boot log shows that
>>> it is setting up for PMECC correctly, but it has errors when it tries
>>> to read from the filesystem.
>> It is strange.  The 3.4 kernel from at91 github just have a few
>> changes.
>> so rationally it behavior the same at PMECC function. From your log,
>> the
>> 3.7-rc8 kernel says the PMECC found uncorrectable errors.
>>
>> Can you try to dump or read from the u-boot? to see whether u-boot can
>> recognize the same nand page that "too many errors" happened in kernel?
>> I will do some test to see whether the 3.7-rc8 can work in my side or
>> not.
> U-Boot> nand read 0x22000000 0x800000 0x1D00000
>
> NAND read: device 0 offset 0x800000, size 0x1d00000
> PMECC: Too many errors
> NAND read from offset 800000 failed -5
>   0 bytes read: ERROR
>
> So u-boot has the same issue.  However, changing the kernel to the linux-at91
> forked kernel produced different results.  That kernel noted the PMECC errors
> but was still able to load the filesystem.  My boot output from the successful
> filesystem load is below.  Is the 3.4 kernel performing corrections that the
> mainline is not, or is it just ignoring errors that it should not be ignoring?
>
> I'm hesitant to make any filesystem changes on this board because I know test
> cases like this where it works one way but not the other are kind of rare.  Let
> me know if you have similar results on your end.
>
> -Bryan
>
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0
> Linux version 3.4.0 (xxxx at xxxx) (gcc version 4.5.3 20110311 (prerelease) (
> GCC) ) #2 Wed Dec 5 15:36:29 EST 2012
> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
> CPU: VIVT data cache, VIVT instruction cache
> Machine: Atmel AT91SAM (Device Tree), model: Atmel AT91SAM9G25-EK
> Memory policy: ECC disabled, Data cache writeback
> AT91: Detected soc type: at91sam9x5
> AT91: Detected soc subtype: at91sam9g25
> AT91: sram at 0x300000 of 0x8000 mapped at 0xfef70000
> Clocks: CPU 400 MHz, master 133 MHz, main 12.000 MHz
> gpiochip_add: registered GPIOs 0 to 31 on device: pioA
> gpiochip_add: registered GPIOs 32 to 63 on device: pioB
> gpiochip_add: registered GPIOs 64 to 95 on device: pioC
> gpiochip_add: registered GPIOs 96 to 127 on device: pioD
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
> Kernel command line: mem=128M console=ttyS0,115200 mtdparts=atmel_nand:8M(bootst
> rap/uboot/kernel)ro,-(rootfs) root=/dev/mtdblock1 rw rootfstype=ubifs ubi.mtd=1
> root=ubi0:rootfs
> PID hash table entries: 512 (order: -1, 2048 bytes)
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Memory: 128MB = 128MB total
> Memory: 119856k/119856k available, 11216k reserved, 0K highmem
> Virtual kernel memory layout:
>      vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>      fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>      vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
>      lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
>      modules : 0xbf000000 - 0xc0000000   (  16 MB)
>        .text : 0xc0008000 - 0xc04650d4   (4469 kB)
>        .init : 0xc0466000 - 0xc048a000   ( 144 kB)
>        .data : 0xc048a000 - 0xc04c4420   ( 234 kB)
>         .bss : 0xc04c4444 - 0xc09c66e4   (5129 kB)
> NR_IRQS:192
> sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294967286ms
> Console: colour dummy device 80x30
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> ... MAX_LOCKDEP_SUBCLASSES:  8
> ... MAX_LOCK_DEPTH:          48
> ... MAX_LOCKDEP_KEYS:        8191
> ... CLASSHASH_SIZE:          4096
> ... MAX_LOCKDEP_ENTRIES:     16384
> ... MAX_LOCKDEP_CHAINS:      32768
> ... CHAINHASH_SIZE:          16384
>   memory used by lock dependency info: 3695 kB
>   per task-struct memory footprint: 1152 bytes
> ------------------------
> | Locking API testsuite:
> ----------------------------------------------------------------------------
>                                   | spin |wlock |rlock |mutex | wsem | rsem |
>    --------------------------------------------------------------------------
>                       A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
>                   A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
>               A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
>               A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
>           A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
>           A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
>           A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
>                      double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
>                    initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
>                   bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
>    --------------------------------------------------------------------------
>                recursive read-lock:             |  ok  |             |  ok  |
>             recursive read-lock #2:             |  ok  |             |  ok  |
>              mixed read-write-lock:             |  ok  |             |  ok  |
>              mixed write-read-lock:             |  ok  |             |  ok  |
>    --------------------------------------------------------------------------
>       hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
>       soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
>       hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
>       soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
>         sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
>         sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
>           hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
>           soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
>           hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
>           soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
>      hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
>      soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
>      hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
>      soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
>      hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
>      soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
>      hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
>      soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
>      hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
>      soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
>      hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
>      soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
>      hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
>      soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
>      hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
>      soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
>      hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
>      soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
>      hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
>      soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
>      hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
>      soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
>      hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
>      soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
>        hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
>        soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
>        hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
>        soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
>        hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
>        soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
>        hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
>        soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
>        hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
>        soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
>        hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
>        soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
>        hard-irq read-recursion/123:  ok  |
>        soft-irq read-recursion/123:  ok  |
>        hard-irq read-recursion/132:  ok  |
>        soft-irq read-recursion/132:  ok  |
>        hard-irq read-recursion/213:  ok  |
>        soft-irq read-recursion/213:  ok  |
>        hard-irq read-recursion/231:  ok  |
>        soft-irq read-recursion/231:  ok  |
>        hard-irq read-recursion/312:  ok  |
>        soft-irq read-recursion/312:  ok  |
>        hard-irq read-recursion/321:  ok  |
>        soft-irq read-recursion/321:  ok  |
> -------------------------------------------------------
> Good, all 218 testcases passed! |
> ---------------------------------
> Calibrating delay loop... 198.04 BogoMIPS (lpj=990208)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> Setting up static identity map for 0x2033ced8 - 0x2033cf30
> devtmpfs: initialized
> dummy:
> NET: Registered protocol family 16
> AT91: Power Management (with slow clock mode)
> AT91: Starting after power-restored wakeup
> bio: create slab <bio-0> at 0
> at_hdmac ffffec00.dma-controller: Atmel AHB DMA Controller ( cpy slave ), 8 chan
> nels
> at_hdmac ffffee00.dma-controller: Atmel AHB DMA Controller ( cpy slave ), 8 chan
> nels
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> cfg80211: Calling CRDA to update world regulatory domain
> Switching to clocksource tcb_clksrc
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 4096 (order: 3, 32768 bytes)
> TCP bind hash table entries: 4096 (order: 5, 147456 bytes)
> TCP: Hash tables configured (established 4096 bind 4096)
> TCP: reno registered
> UDP hash table entries: 64 (order: 0, 5120 bytes)
> UDP-Lite hash table entries: 64 (order: 0, 5120 bytes)
> NET: Registered protocol family 1
> RPC: Registered named UNIX socket transport module.
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> NFS: Registering the id_resolver key type
> jffs2: version 2.2. (NAND) (SUMMARY)  ?? 2001-2006 Red Hat, Inc.
> msgmni has been set to 234
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
> io scheduler noop registered (default)
> fffff200.serial: ttyS0 at MMIO 0xfffff200 (irq = 1) is a ATMEL_SERIAL
> console [ttyS0] enabled
> f801c000.serial: ttyS1 at MMIO 0xf801c000 (irq = 5) is a ATMEL_SERIAL
> f8020000.serial: ttyS2 at MMIO 0xf8020000 (irq = 6) is a ATMEL_SERIAL
> f8028000.serial: ttyS4 at MMIO 0xf8028000 (irq = 8) is a ATMEL_SERIAL
> brd: module loaded
> loop: module loaded
> mtdoops: mtd device (mtddev=name/number) must be supplied
> atmel_nand: Use On Flash BBT
> atmel_nand 40000000.nand: No DMA support for NAND access.
> ONFI param page 0 valid
> ONFI flash detected
> NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron MT29F2G08AAD)

Here, when PMECC is really enabled, the driver should show following 
message:
    atmel_nand 40000000.nand: Initialize PMECC params, cap: 2, sector: 512

But your 3.4's log doesn't have it. If the dtb is right then maybe the 
issue is caused in the driver?

Can you check your 3.4 kernel code, make sure the function 
atmel_pmecc_nand_init_params() is called or not?

Best Regards,
Josh Wu

> Bad block table found at page 131008, version 0x01
> Bad block table found at page 130944, version 0x01
> nand_read_bbt: bad block at 0x000009380000
> 2 cmdlinepart partitions found on MTD device atmel_nand
> Creating 2 MTD partitions on "atmel_nand":
> 0x000000000000-0x000000800000 : "bootstrap/uboot/kernel"
> 0x000000800000-0x000010000000 : "rootfs"
> UBI: attaching mtd1 to ubi0
> UBI: physical eraseblock size:   131072 bytes (128 KiB)
> UBI: logical eraseblock size:    126976 bytes
> UBI: smallest flash I/O unit:    2048
> UBI: VID header offset:          2048 (aligned 2048)
> UBI: data offset:                4096
> UBI: max. sequence number:       4249
> UBI warning: print_rsvd_warning: cannot reserve enough PEBs for bad PEB handling
> , reserved 15, need 19
> UBI: attached mtd1 to ubi0
> UBI: MTD device name:            "rootfs"
> UBI: MTD device size:            248 MiB
> UBI: number of good PEBs:        1979
> UBI: number of bad PEBs:         5
> UBI: number of corrupted PEBs:   0
> UBI: max. allowed volumes:       128
> UBI: wear-leveling threshold:    4096
> UBI: number of internal volumes: 1
> UBI: number of user volumes:     1
> UBI: available PEBs:             0
> UBI: total number of reserved PEBs: 1979
> UBI: number of PEBs reserved for bad PEB handling: 15
> UBI: max/mean erase counter: 5/2
> UBI: image sequence number:  191777507
> UBI: background thread "ubi_bgt0d" started, PID 31
> UBI error: ubi_init: cannot attach mtd1
> tun: Universal TUN/TAP device driver, 1.6
> tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> macb f802c000.ethernet: (unregistered net_device): invalid hw address, using ran
> dom
> MACB_mii_bus: probed
> macb f802c000.ethernet: eth0: Cadence MACB at 0xf802c000 irq 24 (4a:15:f4:49:94:
> a4)
> macb f802c000.ethernet: eth0: attached PHY driver [Davicom DM9161A] (mii_bus:phy
> _addr=f802c000.etherne:00, irq=-1)
> PPP generic driver version 2.4.2
> NET: Registered protocol family 24
> usbcore: registered new interface driver asix
> usbcore: registered new interface driver cdc_ether
> usbcore: registered new interface driver cdc_eem
> usbcore: registered new interface driver net1080
> usbcore: registered new interface driver cdc_subset
> usbcore: registered new interface driver zaurus
> usbcore: registered new interface driver ipheth
> usbcore: registered new interface driver cdc_ncm
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> atmel-ehci 700000.ehci: Atmel EHCI UHP HS
> atmel-ehci 700000.ehci: new USB bus registered, assigned bus number 1
> atmel-ehci 700000.ehci: irq 22, io mem 0x00700000
> atmel-ehci 700000.ehci: USB 2.0 started, EHCI 1.00
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: Atmel EHCI UHP HS
> usb usb1: Manufacturer: Linux 3.4.0 ehci_hcd
> usb usb1: SerialNumber: 700000.ehci
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> at91_ohci 600000.ohci: AT91 OHCI
> at91_ohci 600000.ohci: new USB bus registered, assigned bus number 2
> at91_ohci 600000.ohci: irq 22, io mem 0x00600000
> usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
> usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb2: Product: AT91 OHCI
> usb usb2: Manufacturer: Linux 3.4.0 ohci_hcd
> usb usb2: SerialNumber: at91
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> usbcore: registered new interface driver cdc_acm
> cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
> Initializing USB Mass Storage driver...
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new interface driver libusual
> usbcore: registered new interface driver usbserial
> usbcore: registered new interface driver usbserial_generic
> USB Serial support registered for generic
> usbserial: USB Serial Driver core
> usbcore: registered new interface driver moto-modem
> USB Serial support registered for moto-modem
> usbcore: registered new interface driver opticon
> USB Serial support registered for opticon
> usbcore: registered new interface driver pl2303
> USB Serial support registered for pl2303
> usbcore: registered new interface driver qcserial
> USB Serial support registered for Qualcomm USB modem
> usbcore: registered new interface driver symbol
> USB Serial support registered for symbol
> i2c /dev entries driver
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> nf_conntrack version 0.5.0 (1872 buckets, 7488 max)
> IPv4 over IPv4 tunneling driver
> ip_tables: (C) 2000-2006 Netfilter Core Team
> TCP: cubic registered
> NET: Registered protocol family 17
> lib80211: common routines for IEEE802.11 drivers
> Registering the dns_resolver key type
> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> UBIFS: recovery needed
> UBIFS: recovery completed
> UBIFS: mounted UBI device 0, volume 0, name "rootfs"
> UBIFS: file system size:   247476224 bytes (241676 KiB, 236 MiB, 1949 LEBs)
> UBIFS: journal size:       9023488 bytes (8812 KiB, 8 MiB, 72 LEBs)
> UBIFS: media format:       w4/r0 (latest is w4/r0)
> UBIFS: default compressor: lzo
> UBIFS: reserved for root:  0 bytes (0 KiB)
> VFS: Mounted root (ubifs filesystem) on device 0:11.
> devtmpfs: mounted
> Freeing init memory: 144K
> INIT: version 2.86 booting
> Please wait: booting...
> Starting udev
> udev[62]: starting version 165
> Root filesystem already rw, not remounting
> Caching udev devnodes
> Populating dev cache
> logger: mount: mount point /proc/bus/usb does not exist
> ALSA: Restoring mixer settings...
> /usr/sbin/alsactl: load_state:1625: No soundcards found...
> Configuring network interfaces... eth0      no wireless extensions.
>
> udhcpc (v1.18.3) started
> run-parts: /etc/udhcpc.d/00avahi-autoipd exited with code 1
> Sending discover...
> Sending discover...
> Sending discover...
> netlink: 12 bytes leftover after parsing attributes.
> netlink: 12 bytes leftover after parsing attributes.
> netlink: 12 bytes leftover after parsing attributes.
> No lease, failing
> done.
> Starting portmap daemon: portmap.
> net.ipv4.conf.default.rp_filter = 1
> net.ipv4.conf.all.rp_filter = 1
> kernel.panic = 10
> hwclock: can't open '/dev/misc/rtc': No such file or directory
> Mon Nov  5 09:47:00 EST 2012
> hwclock: can't open '/dev/misc/rtc': No such file or directory
> INIT: Entering runlevel: 5
> Starting system message bus: dbus.
> Starting Dropbear SSH server: dropbear.
> starting Busybox HTTP Daemon: httpd... done.
> Starting Vixie-cron.
> Starting ntpd: done
> Starting syslogd/klogd: done
>   * Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon
>     ...done.
>
>>> I noticed over at the linux-at91 fork that you had applied the PMECC
>>> support on the 3.4.x_pmecc_dt_9x5 branch a few months ago.  From
>>> browsing the mainline I didn't see some of your changes from that
>>> branch in the mainline.  Are there some changes from the linux-at91
>> fork that are still scheduled for mainlining?
>> yes, this patch is not push to mainline yet. Currently the only concern
>> is we are think about the PMECC error correct bits need to adjust by
>> ONFI parameters that read from nand flash.
>> But it is not decide yet. if no exception, this patch will push to
>> mainline soon.
>>
>> Best Regards,
>> Josh Wu
>>
>>> If it helps, here is the boot log when I tried to boot using a 3.7-
>> rc8
>>> kernel and DT.
>>>
>>> Thanks,
>>> Bryan
>>>
>>> Uncompressing Linux... done, booting the kernel.
>>> [    0.000000] Booting Linux on physical CPU 0
>>> [    0.000000] Linux version 3.7.0-rc8-armv5-x0.16 (xxxx at xxxx) (gcc
>> versio
>>> n 4.6.2 20121016 (release) [ARM/embedded-4_6-branch revision 192487]
>>> (GNU Tools for ARM Embedded Processors) ) #1 Wed Dec 5 16:11:30 EST
>> 2012
>>> [    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ),
>> cr=00053177
>>> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
>>> [    0.000000] Machine: Atmel AT91SAM (Device Tree), model: Atmel
>> AT91SAM9G25-EK
>>> [    0.000000] Memory policy: ECC disabled, Data cache writeback
>>> [    0.000000] AT91: Detected soc type: at91sam9x5
>>> [    0.000000] AT91: Detected soc subtype: at91sam9g25
>>> [    0.000000] AT91: sram at 0x300000 of 0x8000 mapped at 0xfef70000
>>> [    0.000000] Clocks: CPU 400 MHz, master 133 MHz, main 12.000 MHz
>>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
>> Total pag
>>> es: 32512
>>> [    0.000000] Kernel command line: mem=128M console=ttyS0,115200
>> mtdparts=atmel
>>> _nand:8M(bootstrap/uboot/kernel)ro,-(rootfs) root=/dev/mtdblock1 rw
>>> rootfstype=u bifs ubi.mtd=1 root=ubi0:rootfs
>>> [    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
>>> [    0.000000] Dentry cache hash table entries: 16384 (order: 4,
>> 65536 bytes)
>>> [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768
>> bytes)
>>> [    0.000000] Memory: 128MB = 128MB total
>>> [    0.000000] Memory: 124276k/124276k available, 6796k reserved, 0K
>> highmem
>>> [    0.000000] Virtual kernel memory layout:
>>> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>>> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>>> [    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
>>> [    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
>>> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>>> [    0.000000]       .text : 0xc0008000 - 0xc04b8630   (4802 kB)
>>> [    0.000000]       .init : 0xc04b9000 - 0xc04e45c4   ( 174 kB)
>>> [    0.000000]       .data : 0xc04e6000 - 0xc0516ce0   ( 196 kB)
>>> [    0.000000]        .bss : 0xc0516d04 - 0xc05760bc   ( 381 kB)
>>> [    0.000000] NR_IRQS:16 nr_irqs:16 16
>>> [    0.000000] sched_clock: 32 bits at 256 Hz, resolution 3906250ns,
>> wraps every
>>>    3892314108ms
>>> [    0.000000] Console: colour dummy device 80x30
>>> [    0.035156] Calibrating delay loop... 199.80 BogoMIPS (lpj=389120)
>>> [    0.035156] pid_max: default: 32768 minimum: 301
>>> [    0.035156] Mount-cache hash table entries: 512
>>> [    0.039062] CPU: Testing write buffer coherency: ok
>>> [    0.039062] Setting up static identity map for 0x20371d48 -
>> 0x20371da0
>>> [    0.039062] devtmpfs: initialized
>>> [    0.042968] NET: Registered protocol family 16
>>> [    0.042968] DMA: preallocated 256 KiB pool for atomic coherent
>> allocations
>>> [    0.070312] No ATAGs?
>>> [    0.070312] AT91: Power Management
>>> [    0.070312] AT91: Starting after power-restored wakeup
>>> [    0.121093] bio: create slab <bio-0> at 0
>>> [    0.125000] SCSI subsystem initialized
>>> [    0.128906] usbcore: registered new interface driver usbfs
>>> [    0.128906] usbcore: registered new interface driver hub
>>> [    0.128906] usbcore: registered new device driver usb
>>> [    0.132812] at91_i2c f8010000.i2c: AT91 i2c bus driver.
>>> [    0.132812] at91_i2c f8014000.i2c: AT91 i2c bus driver.
>>> [    0.136718] at91_i2c f8018000.i2c: AT91 i2c bus driver.
>>> [    0.140625] Switching to clocksource tcb_clksrc
>>> [    0.195312] NET: Registered protocol family 2
>>> [    0.199218] TCP established hash table entries: 4096 (order: 3,
>> 32768 bytes)
>>> [    0.199218] TCP bind hash table entries: 4096 (order: 2, 16384
>> bytes)
>>> [    0.199218] TCP: Hash tables configured (established 4096 bind
>> 4096)
>>> [    0.199218] TCP: reno registered
>>> [    0.199218] UDP hash table entries: 256 (order: 0, 4096 bytes)
>>> [    0.199218] UDP-Lite hash table entries: 256 (order: 0, 4096
>> bytes)
>>> [    0.199218] NET: Registered protocol family 1
>>> [    0.199218] RPC: Registered named UNIX socket transport module.
>>> [    0.199218] RPC: Registered udp transport module.
>>> [    0.199218] RPC: Registered tcp transport module.
>>> [    0.199218] RPC: Registered tcp NFSv4.1 backchannel transport
>> module.
>>> [    0.207031] NFS: Registering the id_resolver key type
>>> [    0.207031] Key type id_resolver registered
>>> [    0.207031] Key type id_legacy registered
>>> [    0.207031] jffs2: version 2.2. (NAND) ????? 2001-2006 Red Hat,
>> Inc.
>>> [    0.207031] msgmni has been set to 242
>>> [    0.210937] io scheduler noop registered (default)
>>> [    0.218750] fffff200.serial: ttyS0 at MMIO 0xfffff200 (irq = 18)
>> is a ATMEL_S
>>> ERIAL
>>> [    0.609375] console [ttyS0] enabled
>>> [    0.613281] f801c000.serial: ttyS1 at MMIO 0xf801c000 (irq = 22)
>> is a ATMEL_S
>>> ERIAL
>>> [    0.632812] brd: module loaded
>>> [    0.652343] loop: module loaded
>>> [    0.667968] atmel_nand: Use On Flash BBT
>>> [    0.671875] atmel_nand 40000000.nand: No DMA support for NAND
>> access.
>>> [    0.675781] ONFI param page 0 valid
>>> [    0.679687] ONFI flash detected
>>> [    0.683593] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda
>> (Micron MT29F2G
>>> 08AAD), page size: 2048, OOB size: 64
>>> [    0.695312] atmel_nand 40000000.nand: Initialize PMECC params,
>> cap: 2, sector
>>> : 512
>>> [    0.703125] Bad block table found at page 131008, version 0x01
>>> [    0.707031] Bad block table found at page 130944, version 0x01
>>> [    0.714843] nand_read_bbt: bad block at 0x000009380000
>>> [    0.718750] 2 cmdlinepart partitions found on MTD device
>> atmel_nand
>>> [    0.726562] Creating 2 MTD partitions on "atmel_nand":
>>> [    0.730468] 0x000000000000-0x000000800000 :
>> "bootstrap/uboot/kernel"
>>> [    0.742187] 0x000000800000-0x000010000000 : "rootfs"
>>> [    0.757812] macb f802c000.ethernet (unregistered net_device):
>> invalid hw addr
>>> ess, using random
>>> [    0.773437] libphy: MACB_mii_bus: probed
>>> [    0.777343] macb f802c000.ethernet eth0: Cadence MACB at
>> 0xf802c000 irq 23 (c
>>> a:2c:e6:c3:59:8f)
>>> [    0.785156] macb f802c000.ethernet eth0: attached PHY driver
>> [Davicom DM9161A
>>> ] (mii_bus:phy_addr=f802c000.etherne:00, irq=-1)
>>> [    0.796875] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI)
>> Driver
>>> [    0.804687] atmel-ehci 700000.ehci: Atmel EHCI UHP HS
>>> [    0.808593] atmel-ehci 700000.ehci: new USB bus registered,
>> assigned bus numb
>>> er 1
>>> [    0.816406] atmel-ehci 700000.ehci: irq 28, io mem 0x00700000
>>> [    0.835937] atmel-ehci 700000.ehci: USB 2.0 started, EHCI 1.00
>>> [    0.839843] usb usb1: New USB device found, idVendor=1d6b,
>> idProduct=0002
>>> [    0.847656] usb usb1: New USB device strings: Mfr=3, Product=2,
>> SerialNumber=
>>> 1
>>> [    0.855468] usb usb1: Product: Atmel EHCI UHP HS
>>> [    0.859375] usb usb1: Manufacturer: Linux 3.7.0-rc8-armv5-x0.16
>> ehci_hcd
>>> [    0.867187] usb usb1: SerialNumber: 700000.ehci
>>> [    0.871093] hub 1-0:1.0: USB hub found
>>> [    0.875000] hub 1-0:1.0: 3 ports detected
>>> [    0.878906] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
>>> [    0.886718] at91_ohci 600000.ohci: AT91 OHCI
>>> [    0.890625] at91_ohci 600000.ohci: new USB bus registered,
>> assigned bus numbe
>>> r 2
>>> [    0.898437] at91_ohci 600000.ohci: irq 28, io mem 0x00600000
>>> [    0.964843] usb usb2: New USB device found, idVendor=1d6b,
>> idProduct=0001
>>> [    0.968750] usb usb2: New USB device strings: Mfr=3, Product=2,
>> SerialNumber=
>>> 1
>>> [    0.976562] usb usb2: Product: AT91 OHCI
>>> [    0.980468] usb usb2: Manufacturer: Linux 3.7.0-rc8-armv5-x0.16
>> ohci_hcd
>>> [    0.988281] usb usb2: SerialNumber: at91
>>> [    0.992187] hub 2-0:1.0: USB hub found
>>> [    0.996093] hub 2-0:1.0: 2 ports detected
>>> [    1.003906] usbcore: registered new interface driver cdc_acm
>>> [    1.007812] cdc_acm: USB Abstract Control Model driver for USB
>> modems and ISD
>>> N adapters
>>> [    1.019531] usbcore: registered new interface driver uas
>>> [    1.023437] Initializing USB Mass Storage driver...
>>> [    1.027343] usbcore: registered new interface driver usb-storage
>>> [    1.035156] USB Mass Storage support registered.
>>> [    1.039062] usbcore: registered new interface driver ums-alauda
>>> [    1.046875] usbcore: registered new interface driver ums-cypress
>>> [    1.054687] usbcore: registered new interface driver ums-datafab
>>> [    1.058593] usbcore: registered new interface driver ums_eneub6250
>>> [    1.066406] usbcore: registered new interface driver ums-freecom
>>> [    1.074218] usbcore: registered new interface driver ums-isd200
>>> [    1.078125] usbcore: registered new interface driver ums-jumpshot
>>> [    1.085937] usbcore: registered new interface driver ums-karma
>>> [    1.093750] usbcore: registered new interface driver ums-onetouch
>>> [    1.097656] usbcore: registered new interface driver ums-realtek
>>> [    1.105468] usbcore: registered new interface driver ums-sddr09
>>> [    1.113281] usbcore: registered new interface driver ums-sddr55
>>> [    1.117187] usbcore: registered new interface driver ums-usbat
>>> [    1.125000] usbcore: registered new interface driver usbserial
>>> [    1.132812] usbcore: registered new interface driver
>> usbserial_generic
>>> [    1.140625] usbserial: USB Serial support registered for generic
>>> [    1.144531] usbcore: registered new interface driver ftdi_sio
>>> [    1.152343] usbserial: USB Serial support registered for FTDI USB
>> Serial Devi
>>> ce
>>> [    1.160156] usbcore: registered new interface driver pl2303
>>> [    1.167968] usbserial: USB Serial support registered for pl2303
>>> [    1.171875] mousedev: PS/2 mouse device common for all mice
>>> [    1.179687] i2c /dev entries driver
>>> [    1.191406] usbcore: registered new interface driver usbhid
>>> [    1.199218] usbhid: USB HID core driver
>>> [    1.207031] usb 1-2: new high-speed USB device number 2 using
>> atmel-ehci
>>> [    1.214843] TCP: cubic registered
>>> [    1.218750] NET: Registered protocol family 10
>>> [    1.222656] sit: IPv6 over IPv4 tunneling driver
>>> [    1.230468] NET: Registered protocol family 17
>>> [    1.234375] Key type dns_resolver registered
>>> [    1.246093] UBI: attaching mtd1 to ubi0
>>> [    1.253906] atmel_nand 40000000.nand: PMECC: Too many errors
>>> [    1.261718] UBI warning: ubi_io_read: error -5 while reading 64
>> bytes from PE
>>> B 10:0, read only 0 bytes, retry
>>> [    1.269531] atmel_nand 40000000.nand: PMECC: Too many errors
>>> [    1.277343] UBI warning: ubi_io_read: error -5 while reading 64
>> bytes from PE
>>> B 10:0, read only 0 bytes, retry
>>> [    1.285156] atmel_nand 40000000.nand: PMECC: Too many errors
>>> [    1.292968] UBI warning: ubi_io_read: error -5 while reading 64
>> bytes from PE
>>> B 10:0, read only 0 bytes, retry
>>> [    1.304687] atmel_nand 40000000.nand: PMECC: Too many errors
>>> [    1.308593] UBI error: ubi_io_read: error -5 while reading 64
>> bytes from PEB
>>> 10:0, read 0 bytes
>>> [    1.316406] [<c000d2bc>] (unwind_backtrace+0x0/0xe0) from
>> [<c0243a10>] (ubi_i
>>> o_read+0x1d4/0x2a4)
>>> [    1.328125] [<c0243a10>] (ubi_io_read+0x1d4/0x2a4) from
>> [<c0243d20>] (ubi_io_
>>> read_ec_hdr+0x68/0x214)
>>> [    1.335937] [<c0243d20>] (ubi_io_read_ec_hdr+0x68/0x214) from
>> [<c024804c>] (u
>>> bi_attach+0x104/0x13e4)
>>> [    1.343750] [<c024804c>] (ubi_attach+0x104/0x13e4) from
>> [<c023e514>] (ubi_att
>>> ach_mtd_dev+0x5a4/0xb94)
>>> [    1.355468] [<c023e514>] (ubi_attach_mtd_dev+0x5a4/0xb94) from
>> [<c04d09dc>] (
>>> ubi_init+0x1d8/0x2d8)
>>> [    1.363281] [<c04d09dc>] (ubi_init+0x1d8/0x2d8) from [<c0008860>]
>> (do_one_ini
>>> tcall+0x90/0x168)
>>> [    1.371093] [<c0008860>] (do_one_initcall+0x90/0x168) from
>> [<c03686a4>] (kern
>>> el_init+0xe8/0x2a0)
>>> [    1.378906] [<c03686a4>] (kernel_init+0xe8/0x2a0) from
>> [<c00093f0>] (ret_from
>>> _fork+0x14/0x24)
>>> [    1.386718] UBI error: ubi_attach_mtd_dev: failed to attach mtd1,
>> error -5
>>> [    1.394531] UBI error: ubi_init: cannot attach mtd1
>>> [    1.402343] drivers/rtc/hctosys.c: unable to open rtc device
>> (rtc0)
>>> [    1.410156] UBIFS error (pid 1): ubifs_mount: cannot open
>> "ubi0:rootfs", erro
>>> r -19
>>> [    1.417968] VFS: Cannot open root device "ubi0:rootfs" or unknown-
>> block(0,0):
>>>    error -19
>>> [    1.425781] Please append a correct "root=" boot option; here are
>> the availab
>>> le partitions:
>>> [    1.433593] 1f00            8192 mtdblock0  (driver?)
>>> [    1.437500] 1f01          253952 mtdblock1  (driver?)
>>> [    1.441406] Kernel panic - not syncing: VFS: Unable to mount root
>> fs on unkno
>>> wn-block(0,0)
>>>
>>>
