From: tim.niemeyer@corscience.de (Tim Niemeyer)
Date: Tue, 18 Feb 2014 10:58:49 +0100
Subject: Locking issues SAMA5
Message-ID: <1392717529.15380.48.camel@herbert.er.corscience.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi 

i have some locking problems on the SAMA5D31EK running the linux4sam
3.10 kernel (rebased on 3.10.30).

I am playing a short audio file every 1 second. After some seconds the
playback is defekt, the system hangs and finally the palyback stops.
Sometimes the system recovers and the playback is coming back to normal
but this lasts only for some further seconds.
While the systems is unresponsive, the LOCKDEP discovers this:
---- 8< ----
BUG: spinlock lockup suspected on CPU#0, abc_cuse_sim/627
 lock: 0xdf8a24ac, .magic: dead4ead, .owner: abc_cuse_sim/627, .owner_cpu: 0
CPU: 0 PID: 627 Comm: abc_cuse_sim Not tainted 3.10.30+ #11
[<c001292c>] (unwind_backtrace+0x0/0xf4) from [<c0010dfc>] (show_stack+0x10/0x14)
[<c0010dfc>] (show_stack+0x10/0x14) from [<c01d62d8>] (do_raw_spin_lock+0x108/0x13c)
[<c01d62d8>] (do_raw_spin_lock+0x108/0x13c) from [<c045f570>] (_raw_spin_lock_irqsave+0x4c/0x58)
[<c045f570>] (_raw_spin_lock_irqsave+0x4c/0x58) from [<c01f7c98>] (atc_control+0x138/0x2bc)
[<c01f7c98>] (atc_control+0x138/0x2bc) from [<c0332cc0>] (snd_dmaengine_pcm_trigger+0xb8/0x180)
[<c0332cc0>] (snd_dmaengine_pcm_trigger+0xb8/0x180) from [<c032e75c>] (soc_pcm_trigger+0x64/0xa8)
[<c032e75c>] (soc_pcm_trigger+0x64/0xa8) from [<c030f4a8>] (snd_pcm_do_stop+0x54/0x58)
[<c030f4a8>] (snd_pcm_do_stop+0x54/0x58) from [<c030f0d0>] (snd_pcm_action_single+0x38/0x78)
[<c030f0d0>] (snd_pcm_action_single+0x38/0x78) from [<c0313e44>] (xrun+0x28/0xb0)
[<c0313e44>] (xrun+0x28/0xb0) from [<c03149c0>] (snd_pcm_update_state+0xf8/0x100)
[<c03149c0>] (snd_pcm_update_state+0xf8/0x100) from [<c0314bf0>] (snd_pcm_update_hw_ptr0+0x228/0x834)
[<c0314bf0>] (snd_pcm_update_hw_ptr0+0x228/0x834) from [<c03152b8>] (snd_pcm_period_elapsed+0xbc/0xf4)
[<c03152b8>] (snd_pcm_period_elapsed+0xbc/0xf4) from [<c01f95bc>] (atc_tasklet+0x60/0x1b4)
[<c01f95bc>] (atc_tasklet+0x60/0x1b4) from [<c0021f6c>] (tasklet_action+0x6c/0xc0)
[<c0021f6c>] (tasklet_action+0x6c/0xc0) from [<c002223c>] (__do_softirq+0x114/0x1f8)
[<c002223c>] (__do_softirq+0x114/0x1f8) from [<c00223b4>] (do_softirq+0x50/0x58)
[<c00223b4>] (do_softirq+0x50/0x58) from [<c0022604>] (irq_exit+0x5c/0x94)
[<c0022604>] (irq_exit+0x5c/0x94) from [<c000e868>] (handle_IRQ+0x3c/0x84)
[<c000e868>] (handle_IRQ+0x3c/0x84) from [<c000ddfc>] (__irq_usr+0x3c/0x60)
WARN - Sound buffer underrun (writei) at device default
---- >8 ----

I peeked a bit at the code and for me it looks like the cyclic dma
transfer starts the atc_tasklet() and locks the atchan->lock. Within the
atc_handle_cyclic() the pcm playback is stopped via do_stop() wich calls
dmaengine_terminate_all(). This calls
atc_control(..,DMA_TERMINATE_ALL,..) wich also takes the &atchan->lock.

I'm a bit confused as the do_stop() seems to be a normal command, while
the TERMINALE_ALL seems to be only for error cases?

There are also LOCKDEP messages with the atmel_mci driver while booting:
---- 8< ----
RomBOOT

U-Boot SPL 2014.01 (Feb 04 2014 - 18:23:19)
mci: setting clock 257812 Hz, block size 512
mci: setting clock 257812 Hz, block size 512
mci: setting clock 257812 Hz, block size 512
mci: setting clock 257812 Hz, block size 512
mci: setting clock 22000000 Hz, block size 512
reading u-boot.img
reading u-boot.img


U-Boot 2014.01 (Feb 04 2014 - 18:23:19)

CPU: SAMA5D31
Crystal frequency:       12 MHz
CPU clock        :      528 MHz
Master clock     :      132 MHz
DRAM:  512 MiB
NAND:  256 MiB
MMC:   mci: 0
mci: setting clock 257812 Hz, block size 512
mci: setting clock 257812 Hz, block size 512
mci: setting clock 257812 Hz, block size 512
mci: setting clock 257812 Hz, block size 512
mci: setting clock 22000000 Hz, block size 512
In:    serial
Out:   serial
Err:   serial
Net:   macb0, usb_ether
Hit any key to stop autoboot:  0 
macb0: PHY present at 0
macb0: Starting autonegotiation...
macb0: Autonegotiation complete
macb0: link up, 100Mbps full-duplex (lpa: 0xcde1)
Using macb0 device
File transfer via NFS from server 192.168.50.50; our IP address is 192.168.50.60
Filename '/nfsroot/boot/uImage'.
Load address: 0x22000000
Loading: #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 ####
done
Bytes transferred = 3346064 (330e90 hex)
macb0: PHY present at 0
macb0:0 is connected to macb0.  Reconnecting to macb0
macb0: Starting autonegotiation...
macb0: Autonegotiation complete
macb0: link up, 100Mbps full-duplex (lpa: 0xcde1)
Using macb0 device
File transfer via NFS from server 192.168.50.50; our IP address is 192.168.50.60
Filename '/nfsroot/boot/sama5d31ek.dtb'.
Load address: 0x21000000
Loading: #####
done
Bytes transferred = 21487 (53ef hex)
## Booting kernel from Legacy Image at 22000000 ...
   Image Name:   Linux-3.10.30+
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3346000 Bytes = 3.2 MiB
   Load Address: 20008000
   Entry Point:  20008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 21000000
   Booting using the fdt blob at 0x21000000
   Loading Kernel Image ... OK
   Loading Device Tree to 3fd93000, end 3fd9b3ee ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.10.30+ (tniemeyer at herbert) (gcc version 4.8.1 (crosstool-NG 1.19.0) ) #11 PREEMPT Tue Feb 18 09:24:08 CET 2014
CPU: ARMv7 Processor [410fc051] revision 1 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Atmel SAMA5 (Device Tree), model: Atmel SAMA5D31-EK
Memory policy: ECC disabled, Data cache writeback
AT91: Detected soc type: sama5d3
AT91: Detected soc subtype: sama5d31
AT91: sram at 0x300000 of 0x20000 mapped at 0xfef58000
CPU: All CPU(s) started in SVC mode.
Clocks: CPU 528 MHz, master 132 MHz, main 12.000 MHz
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: console=ttyS0,115200 mtdparts=atmel_nand:8M(bootstrap/uboot/kernel)ro,-(rootfs) rootwait root=/dev/nfs ip=192.168.50.60:192.168.50.50:192.168.50.50:255.255.255.0:zitronenbaum:eth0:off nfsrootdebug nfsroot=192.168.50.50:/nfsroot rw
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 512MB = 512MB total
Memory: 509068k/509068k available, 15220k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc05ddfa8   (5976 kB)
      .init : 0xc05de000 - 0xc0608e7c   ( 172 kB)
      .data : 0xc060a000 - 0xc064e960   ( 275 kB)
       .bss : 0xc064e960 - 0xc0a592f8   (4139 kB)
Preemptible hierarchical RCU implementation.
NR_IRQS:16 nr_irqs:16 16
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294967286ms
Console: colour dummy device 80x30
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 3679 kB
 per task-struct memory footprint: 1152 bytes
Calibrating delay loop... 262.96 BogoMIPS (lpj=1314816)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0xc04600b0 - 0xc0460108
devtmpfs: initialized
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
No ATAGs?
AT91: Power Management
gpio-at91 fffff200.gpio: at address fefff200
gpio-at91 fffff400.gpio: at address fefff400
gpio-at91 fffff600.gpio: at address fefff600
gpio-at91 fffff800.gpio: at address fefff800
gpio-at91 fffffa00.gpio:@address fefffa00
pinctrl-at91 pinctrl.3: initialized AT91 pinctrl driver
bio: create slab <bio-0> at 0
at_hdmac ffffe600.dma-controller: Atmel AHB DMA Controller ( cpy slave ), 8 channels
at_hdmac ffffe800.dma-controller: Atmel AHB DMA Controller ( cpy slave ), 8 channels
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
of_dma_request_slave_channel: dma-names property missing or empty
at91_i2c f0014000.i2c: can't get a DMA channel for tx
at91_i2c f0014000.i2c: can't use DMA
at91_i2c f0014000.i2c: AT91 i2c bus driver.
at91_i2c f0018000.i2c: using dma0chan0 (tx) and dma0chan1 (rx) for DMA transfers
at91_i2c f0018000.i2c: AT91 i2c bus driver.
Linux video capture interface: v2.00
Advanced Linux Sound Architecture Driver Initialized.
cfg80211: Calling CRDA to update world regulatory domain
Switching to clocksource tcb_clksrc
NET: Registered protocol family 2
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 5, 147456 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP: reno registered
UDP hash table entries: 256 (order: 2, 20480 bytes)
UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
fuse init (API version 7.22)
msgmni has been set to 994
io scheduler noop registered (default)
atmel_hlcdfb atmel_hlcdfb_base: 1500KiB frame buffer at 3f000000 (mapped at e0859000)
Console: switching to colour frame buffer device 100x30
atmel_hlcdfb atmel_hlcdfb_base: fb0: Atmel LCDC at 0xf0030000 (mapped at e09d4000), irq 24
atmel_hlcdfb atmel_hlcdfb_ovl1: 1500KiB frame buffer at 3f200000 (mapped at e09d8000)
atmel_hlcdfb atmel_hlcdfb_ovl1: fb1: Atmel LCDC at 0xf0030140 (mapped at e0b52140), irq -6
atmel_hlcdfb atmel_hlcdfb_ovl2: 1500KiB frame buffer at 3ec00000 (mapped at e0b56000)
atmel_hlcdfb atmel_hlcdfb_ovl2: fb2: Atmel LCDC at 0xf0030240 (mapped at e0cd0240), irq -6
f0020000.serial: ttyS2 at MMIO 0xf0020000 (irq = 23) is a ATMEL_SERIAL
ffffee00.serial: ttyS0 at MMIO 0xffffee00 (irq = 35) is a ATMEL_SERIAL
console [ttyS0] enabled
brd: module loaded
loop: module loaded
ssc f0008000.ssc: Atmel SSC device at 0xe0cd8000 (irq 19)
atmel_nand_nfc 70000000.nfc: NFC is probed.
atmel_nand: Use On Flash BBT
atmel_nand 60000000.nand: Using dma0chan2 for DMA transfers.
ONFI param page 0 valid
ONFI flash detected
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron MT29F2G08ABAEAWP), 256MiB, page size: 2048, OOB size: 64
atmel_nand 60000000.nand: ONFI params, minimum required ECC: 4 bits in 512 bytes
atmel_nand 60000000.nand: Initialize PMECC params, cap: 4, sector: 512
atmel_nand 60000000.nand: Using NFC Sram read and write
Bad block table found at page 131008, version 0x01
Bad block table found at page 130944, version 0x01
2 cmdlinepart partitions found on MTD device atmel_nand
Creating 2 MTD partitions on "atmel_nand":
0x000000000000-0x000000800000 : "bootstrap/uboot/kernel"
0x000000800000-0x000010000000 : "rootfs"
atmel_spi f0004000.spi: version: 0x213
atmel_spi f0004000.spi: Using dma0chan3 (tx) and dma0chan4 (rx) for DMA transfers
atmel_spi f0004000.spi: Atmel SPI Controller at 0xf0004000 (irq 18)
atmel_spi f0004000.spi: master is unqueued, this is deprecated
m25p80 spi32766.0: found mr25h256, expected at25df321a
m25p80 spi32766.0: mr25h256 (32 Kbytes)
CAN device driver interface
at91_can f8010000.can: device registered (reg_base=e0d0a000, irq=26)
libphy: MACB_mii_bus: probed
macb f802c000.ethernet eth0: Cadence MACB at 0xf802c000 irq 29 (12:40:0c:42:dd:fe)
macb f802c000.ethernet eth0: attached PHY driver [Micrel KSZ8031] (mii_bus:phy_addr=f802c000.etherne:00, irq=-1)
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-atmel: EHCI Atmel driver
atmel-ehci 700000.ehci: EHCI Host Controller
atmel-ehci 700000.ehci: new USB bus registered, assigned bus number 1
atmel-ehci 700000.ehci: irq 43, io mem 0x00700000
atmel-ehci 700000.ehci: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 3.10.30+ ehci_hcd
usb usb1: SerialNumber: 700000.ehci
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
at91_ohci 600000.ohci: AT91 OHCI
at91_ohci 600000.ohci: new USB bus registered, assigned bus number 2
at91_ohci 600000.ohci: irq 43, io mem 0x00600000
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: AT91 OHCI
usb usb2: Manufacturer: Linux 3.10.30+ ohci_hcd
usb usb2: SerialNumber: at91
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
usbcore: registered new interface driver cdc_acm
cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
usbcore: registered new interface driver usb-storage
usbcore: registered new interface driver usbserial
usbcore: registered new interface driver usbserial_generic
usbserial: USB Serial support registered for generic
usbcore: registered new interface driver ftdi_sio
usbserial: USB Serial support registered for FTDI USB Serial Device
usbcore: registered new interface driver pl2303
usbserial: USB Serial support registered for pl2303
atmel_usba_udc 500000.gadget: MMIO registers at 0xf8030000 mapped at e0d18000
atmel_usba_udc 500000.gadget: FIFO at 0x00500000 mapped at e2800000
qt1070 1-001b: AT42QT1070 firmware version 15
input: AT42QT1070 QTouch Sensor as /devices/ahb.0/apb.1/f0018000.i2c/i2c-1/1-001b/input/input0
at91_rtc fffffeb0.rtc: rtc core: registered fffffeb0.rtc as rtc0
at91_rtc fffffeb0.rtc: AT91 Real Time Clock driver.
i2c /dev entries driver
leds-gpio leds.4: pins are not configured from the driver
atmel_aes f8038000.aes: version: 0x135
atmel_aes f8038000.aes: Atmel AES - Using dma1chan0, dma1chan1 for DMA transfers
atmel_tdes f803c000.tdes: version: 0x701
atmel_tdes f803c000.tdes: using dma1chan2, dma1chan3 for DMA transfers
atmel_tdes f803c000.tdes: Atmel DES/TDES
atmel_sha f8034000.sha: version: 0x410
atmel_sha f8034000.sha: using dma1chan4 for DMA transfers
atmel_sha f8034000.sha: Atmel SHA1/SHA256/SHA224/SHA384/SHA512
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
iio iio:device0: Resolution used: 12 bits
input: at91_adc as /devices/ahb.0/apb.1/f8018000.adc/input/input1
wm8904 0-001a: revision A
atmel-wm8904-audio sound.5: setting pck0 to 32768Hz
wm8904 0-001a: ASoC: mux DACR Mux has no paths
wm8904 0-001a: ASoC: mux DACL Mux has no paths
wm8904 0-001a: ASoC: mux AIFOUTR Mux has no paths
wm8904 0-001a: ASoC: mux AIFOUTL Mux has no paths
atmel-wm8904-audio sound.5:  wm8904-hifi <-> f0008000.ssc mapping ok
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
can: controller area network core (rev 20120528 abi 9)
NET: Registered protocol family 29
can: raw protocol (rev 20120528)
can: broadcast manager protocol (rev 20120528 t)
can: netlink gateway (rev 20130117) max_hops=1
VFP support v0.3: implementor 41 architecture 2 part 30 variant 5 rev 1
at91_rtc fffffeb0.rtc: setting system clock to 2007-01-08 17:14:31 UTC (1168276471)
atmel_mci f0000000.mmc: version: 0x505
atmel_mci f0000000.mmc: using dma0chan7 for DMA transfers
BUG: spinlock recursion on CPU#0, swapper/1
 lock: 0xdf9ec710, .magic: dead4ead, .owner: swapper/1, .owner_cpu: 0
CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.30+ #11
[<c001292c>] (unwind_backtrace+0x0/0xf4) from [<c0010dfc>] (show_stack+0x10/0x14)
[<c0010dfc>] (show_stack+0x10/0x14) from [<c01d6308>] (do_raw_spin_lock+0x138/0x13c)
[<c01d6308>] (do_raw_spin_lock+0x138/0x13c) from [<c045f570>] (_raw_spin_lock_irqsave+0x4c/0x58)
[<c045f570>] (_raw_spin_lock_irqsave+0x4c/0x58) from [<c005c84c>] (__irq_get_desc_lock+0x58/0x98)
[<c005c84c>] (__irq_get_desc_lock+0x58/0x98) from [<c005f258>] (__irq_set_handler+0x24/0x130)
[<c005f258>] (__irq_set_handler+0x24/0x130) from [<c01e2be4>] (alt_gpio_irq_type+0xd4/0x124)
[<c01e2be4>] (alt_gpio_irq_type+0xd4/0x124) from [<c005da34>] (__irq_set_trigger+0x54/0x110)
[<c005da34>] (__irq_set_trigger+0x54/0x110) from [<c005de50>] (__setup_irq+0x360/0x434)
[<c005de50>] (__setup_irq+0x360/0x434) from [<c005e054>] (request_threaded_irq+0xa8/0x128)
[<c005e054>] (request_threaded_irq+0xa8/0x128) from [<c05f74ec>] (atmci_init_slot+0x250/0x360)
[<c05f74ec>] (atmci_init_slot+0x250/0x360) from [<c05f7b94>] (atmci_probe+0x598/0x714)
[<c05f7b94>] (atmci_probe+0x598/0x714) from [<c021f1c4>] (platform_drv_probe+0x18/0x1c)
[<c021f1c4>] (platform_drv_probe+0x18/0x1c) from [<c021df2c>] (driver_probe_device+0x10c/0x22c)
[<c021df2c>] (driver_probe_device+0x10c/0x22c) from [<c021e124>] (__driver_attach+0x94/0x98)
[<c021e124>] (__driver_attach+0x94/0x98) from [<c021c41c>] (bus_for_each_dev+0x60/0x94)
[<c021c41c>] (bus_for_each_dev+0x60/0x94) from [<c021d6dc>] (bus_add_driver+0x1cc/0x258)
[<c021d6dc>] (bus_add_driver+0x1cc/0x258) from [<c021e714>] (driver_register+0x78/0x140)
[<c021e714>] (driver_register+0x78/0x140) from [<c021f7c0>] (platform_driver_probe+0x18/0xa0)
[<c021f7c0>] (platform_driver_probe+0x18/0xa0) from [<c000872c>] (do_one_initcall+0x108/0x158)
[<c000872c>] (do_one_initcall+0x108/0x158) from [<c05deb38>] (kernel_init_freeable+0x124/0x1c4)
[<c05deb38>] (kernel_init_freeable+0x124/0x1c4) from [<c0456a18>] (kernel_init+0x8/0x158)
[<c0456a18>] (kernel_init+0x8/0x158) from [<c000e058>] (ret_from_fork+0x14/0x3c)
BUG: spinlock lockup suspected on CPU#0, swapper/1
 lock: 0xdf9ec710, .magic: dead4ead, .owner: swapper/1, .owner_cpu: 0
CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.30+ #11
[<c001292c>] (unwind_backtrace+0x0/0xf4) from [<c0010dfc>] (show_stack+0x10/0x14)
[<c0010dfc>] (show_stack+0x10/0x14) from [<c01d62d8>] (do_raw_spin_lock+0x108/0x13c)
[<c01d62d8>] (do_raw_spin_lock+0x108/0x13c) from [<c045f570>] (_raw_spin_lock_irqsave+0x4c/0x58)
[<c045f570>] (_raw_spin_lock_irqsave+0x4c/0x58) from [<c005c84c>] (__irq_get_desc_lock+0x58/0x98)
[<c005c84c>] (__irq_get_desc_lock+0x58/0x98) from [<c005f258>] (__irq_set_handler+0x24/0x130)
[<c005f258>] (__irq_set_handler+0x24/0x130) from [<c01e2be4>] (alt_gpio_irq_type+0xd4/0x124)
[<c01e2be4>] (alt_gpio_irq_type+0xd4/0x124) from [<c005da34>] (__irq_set_trigger+0x54/0x110)
[<c005da34>] (__irq_set_trigger+0x54/0x110) from [<c005de50>] (__setup_irq+0x360/0x434)
[<c005de50>] (__setup_irq+0x360/0x434) from [<c005e054>] (request_threaded_irq+0xa8/0x128)
[<c005e054>] (request_threaded_irq+0xa8/0x128) from [<c05f74ec>] (atmci_init_slot+0x250/0x360)
[<c05f74ec>] (atmci_init_slot+0x250/0x360) from [<c05f7b94>] (atmci_probe+0x598/0x714)
[<c05f7b94>] (atmci_probe+0x598/0x714) from [<c021f1c4>] (platform_drv_probe+0x18/0x1c)
[<c021f1c4>] (platform_drv_probe+0x18/0x1c) from [<c021df2c>] (driver_probe_device+0x10c/0x22c)
[<c021df2c>] (driver_probe_device+0x10c/0x22c) from [<c021e124>] (__driver_attach+0x94/0x98)
[<c021e124>] (__driver_attach+0x94/0x98) from [<c021c41c>] (bus_for_each_dev+0x60/0x94)
[<c021c41c>] (bus_for_each_dev+0x60/0x94) from [<c021d6dc>] (bus_add_driver+0x1cc/0x258)
[<c021d6dc>] (bus_add_driver+0x1cc/0x258) from [<c021e714>] (driver_register+0x78/0x140)
[<c021e714>] (driver_register+0x78/0x140) from [<c021f7c0>] (platform_driver_probe+0x18/0xa0)
[<c021f7c0>] (platform_driver_probe+0x18/0xa0) from [<c000872c>] (do_one_initcall+0x108/0x158)
[<c000872c>] (do_one_initcall+0x108/0x158) from [<c05deb38>] (kernel_init_freeable+0x124/0x1c4)
[<c05deb38>] (kernel_init_freeable+0x124/0x1c4) from [<c0456a18>] (kernel_init+0x8/0x158)
[<c0456a18>] (kernel_init+0x8/0x158) from [<c000e058>] (ret_from_fork+0x14/0x3c)
atmel_mci f0000000.mmc: Atmel MCI controller at 0xf0000000 irq 17, 1 slots
atmel_mci f8000000.mmc: version: 0x505
dmaengine: private_candidate: dma0chan0 busy
dmaengine: private_candidate: dma0chan1 busy
dmaengine: private_candidate: dma0chan2 busy
dmaengine: private_candidate: dma0chan3 busy
dmaengine: private_candidate: dma0chan4 busy
dmaengine: private_candidate: dma0chan5 busy
dmaengine: private_candidate: dma0chan6 busy
dmaengine: private_candidate: dma0chan7 busy
dmaengine: private_candidate: dma1chan0 busy
dmaengine: private_candidate: dma1chan1 busy
dmaengine: private_candidate: dma1chan2 busy
dmaengine: private_candidate: dma1chan3 busy
dmaengine: private_candidate: dma1chan4 busy
dma dma1chan5: alloc_chan_resources: allocated 64 descriptors
dmaengine: __dma_request_channel: success (dma1chan5)
atmel_mci f8000000.mmc: using dma1chan5 for DMA transfers
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new SDHC card at address b368
mmcblk0: mmc0:b368 

$$ 3.84 GiB 
 mmcblk0: p1
BUG: spinlock lockup suspected on CPU#0, swapper/1
 lock: 0xdf9ec650, .magic: dead4ead, .owner: swapper/1, .owner_cpu: 0
CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.30+ #11
[<c001292c>] (unwind_backtrace+0x0/0xf4) from [<c0010dfc>] (show_stack+0x10/0x14)
[<c0010dfc>] (show_stack+0x10/0x14) from [<c01d62d8>] (do_raw_spin_lock+0x108/0x13c)
[<c01d62d8>] (do_raw_spin_lock+0x108/0x13c) from [<c045f570>] (_raw_spin_lock_irqsave+0x4c/0x58)
[<c045f570>] (_raw_spin_lock_irqsave+0x4c/0x58) from [<c005c84c>] (__irq_get_desc_lock+0x58/0x98)
[<c005c84c>] (__irq_get_desc_lock+0x58/0x98) from [<c005f258>] (__irq_set_handler+0x24/0x130)
[<c005f258>] (__irq_set_handler+0x24/0x130) from [<c01e2be4>] (alt_gpio_irq_type+0xd4/0x124)
[<c01e2be4>] (alt_gpio_irq_type+0xd4/0x124) from [<c005da34>] (__irq_set_trigger+0x54/0x110)
[<c005da34>] (__irq_set_trigger+0x54/0x110) from [<c005de50>] (__setup_irq+0x360/0x434)
[<c005de50>] (__setup_irq+0x360/0x434) from [<c005e054>] (request_threaded_irq+0xa8/0x128)
[<c005e054>] (request_threaded_irq+0xa8/0x128) from [<c05f74ec>] (atmci_init_slot+0x250/0x360)
[<c05f74ec>] (atmci_init_slot+0x250/0x360) from [<c05f7b94>] (atmci_probe+0x598/0x714)
[<c05f7b94>] (atmci_probe+0x598/0x714) from [<c021f1c4>] (platform_drv_probe+0x18/0x1c)
[<c021f1c4>] (platform_drv_probe+0x18/0x1c) from [<c021df2c>] (driver_probe_device+0x10c/0x22c)
[<c021df2c>] (driver_probe_device+0x10c/0x22c) from [<c021e124>] (__driver_attach+0x94/0x98)
[<c021e124>] (__driver_attach+0x94/0x98) from [<c021c41c>] (bus_for_each_dev+0x60/0x94)
[<c021c41c>] (bus_for_each_dev+0x60/0x94) from [<c021d6dc>] (bus_add_driver+0x1cc/0x258)
[<c021d6dc>] (bus_add_driver+0x1cc/0x258) from [<c021e714>] (driver_register+0x78/0x140)
[<c021e714>] (driver_register+0x78/0x140) from [<c021f7c0>] (platform_driver_probe+0x18/0xa0)
[<c021f7c0>] (platform_driver_probe+0x18/0xa0) from [<c000872c>] (do_one_initcall+0x108/0x158)
[<c000872c>] (do_one_initcall+0x108/0x158) from [<c05deb38>] (kernel_init_freeable+0x124/0x1c4)
[<c05deb38>] (kernel_init_freeable+0x124/0x1c4) from [<c0456a18>] (kernel_init+0x8/0x158)
[<c0456a18>] (kernel_init+0x8/0x158) from [<c000e058>] (ret_from_fork+0x14/0x3c)
atmel_mci f8000000.mmc: Atmel MCI controller at 0xf8000000 irq 25, 1 slots
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
macb f802c000.ethernet eth0: link up (100/Full)
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
IP-Config: Complete:
     device=eth0, hwaddr=12:40:0c:42:dd:fe, ipaddr=192.168.50.60, mask=255.255.255.0, gw=192.168.50.50
     host=zitronenbaum, domain=, nis-domain=(none)
     bootserver=192.168.50.50, rootserver=192.168.50.50, rootpath=
ALSA device list:
  #0: wm8904 @ SAMA5D3EK
VFS: Mounted root (nfs filesystem) on device 0:11.
devtmpfs: mounted
Freeing unused kernel memory: 168K (c05de000 - c0608000)
mounting filesystems...done.
running rc.d services...
syslogd starting
klogd starting
crond starting
starting dropbear...done
Starting telnetd...
restoring mixer state...no /etc/asound.state, aborting
starting network interfaces...
lo        Link encap:Local Loopback  
eth0      Link encap:Ethernet  HWaddr 12:40:0C:42:DD:FE  
Starting udhcpd...
[..]
starting inetd...done
logrotate: rotating in /var/log
logrotate: rotation for messages ... 
loading modules
---- >8 ----

Regards
--
Tim
