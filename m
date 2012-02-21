From: joancarles@fqingenieria.es (joancarles)
Date: Tue, 21 Feb 2012 09:36:54 +0100
Subject: [2.6.39.3] [MX25] oops in driver_register for ADC touchscreen
 support (imx_adc_ts)
In-Reply-To: <20120220150940.GE9921@sapphire.tkos.co.il>
References: <50e2a71500444a5e1b951e5856d474bf@mail.fqingenieria.es>
 <20120220094013.GA9921@sapphire.tkos.co.il>
 <70cdf2c4b729fb7dfa1d641c4609c6f5@mail.fqingenieria.es>
 <20120220101157.GB9921@sapphire.tkos.co.il>
 <9741ebebcbc88e7e82a70d619e6c1d51@mail.fqingenieria.es>
 <20120220135155.GC9921@sapphire.tkos.co.il>
 <5e2eb160cb46960b705b71145f4d03c4@mail.fqingenieria.es>
 <20120220150940.GE9921@sapphire.tkos.co.il>
Message-ID: <9ea1f5a537954a91da1e76583fdbf3f9@mail.fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

>> >What kind of flash do you have on your board? NOR? NAND?
>>
>> That's most probably the culprit, thanks. We have a NOR flash, so I
>> need to find a way to enable it. Funny enough, our working 2.6.39.3
>
> Please send the console output of the working kernel.
>
> Just a shot in the dark: have you looked into pin muxing?

That was it I reckon, plus a few changes on how to initialize the mx25 
in the new kernel. Also, a hint with regard to setting the MACH-ID for 
our device helped with the first working boot of the newest kernel drop:

Booting Linux on physical CPU 0
Linux version 3.3.0-rc4-00000-rc4-dirty (develop at pc-develop) (gcc 
version 4.5.2 20101105 (prerelease) (GCC) ) #8 PREEMPT Tue Feb 21 
09:26:52 CET 2012
CPU: ARM926EJ-S [41069264] revision 4 (ARMv5TEJ), cr=00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: FQ Ingenieria SID1 (NOAH)
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 16384
free_area_init_node: node 0, pgdat c046fadc, node_mem_map c0485000
   Normal zone: 128 pages used for memmap
   Normal zone: 0 pages reserved
   Normal zone: 16256 pages, LIFO batch:3
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 
16256
Kernel command line: console=ttymxc0,115200 root=/dev/mtdblock2 
rootfstype=jffs2 
mtdparts=physmap-flash.0:0x100000(u-boot),0x300000(kernel),0x3C00000(jffs2) 
imxfb.enabled=1
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 60304k/60304k available, 5232k reserved, 0K highmem
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     vmalloc : 0xc4800000 - 0xff000000   ( 936 MB)
     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .text : 0xc0008000 - 0xc042c708   (4242 kB)
       .init : 0xc042d000 - 0xc044c000   ( 124 kB)
       .data : 0xc044c000 - 0xc0470160   ( 145 kB)
        .bss : 0xc0470184 - 0xc048481c   (  82 kB)
NR_IRQS:340
MXC IRQ initialized
CPU identified as i.MX25, unknown revision
sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 64585ms
Console: colour dummy device 80x30
Calibrating delay loop... 199.06 BogoMIPS (lpj=995328)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x80335340 - 0x80335398
devtmpfs: initialized
print_constraints: dummy:
NET: Registered protocol family 16
gpiochip_add: registered GPIOs 0 to 31 on device: imx31-gpio.0
gpiochip_add: registered GPIOs 32 to 63 on device: imx31-gpio.1
gpiochip_add: registered GPIOs 64 to 95 on device: imx31-gpio.2
gpiochip_add: registered GPIOs 96 to 127 on device: imx31-gpio.3
bio: create slab <bio-0> at 0
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Advanced Linux Sound Architecture Driver Version 1.0.24.
Switching to clocksource mxc_timer1
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (extended precision)
NTFS driver 2.1.30 [Flags: R/W].
JFFS2 version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
fuse init (API version 7.18)
msgmni has been set to 117
io scheduler noop registered (default)
imx-fb imx-fb.0: i.MX Framebuffer driver
Console: switching to colour frame buffer device 80x60
imx-sdma imx35-sdma: initialized
Serial: IMX driver
imx21-uart.0: ttymxc0 at MMIO 0x43f90000 (irq = 45) is a IMX
console [ttymxc0] enabled
loop: module loaded
at24 0-0050: 65024 byte at24 EEPROM, writable, 128 bytes/write
physmap platform flash device: 04000000 at a0000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank. 
Manufacturer ID 0x000001 Chip ID 0x002301
Amd/Fujitsu Extended Query Table at 0x0040
   Amd/Fujitsu Extended Query version 1.3.
number of CFI chips: 1
3 cmdlinepart partitions found on MTD device physmap-flash.0
Creating 3 MTD partitions on "physmap-flash.0":
0x000000000000-0x000000100000 : "u-boot"
0x000000100000-0x000000400000 : "kernel"
0x000000400000-0x000004000000 : "jffs2"
FEC Ethernet Driver
fec_enet_mii_bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
usbcore: registered new interface driver fq_cpr40
FQ cpr40 driver: driver started: v1.0.6 (2010/10/15)
imxdi_rtc imxdi_rtc.0: rtc core: registered imxdi_rtc as rtc0
i2c /dev entries driver
Driver for 1-wire Dallas network protocol.
imx2-wdt imx2-wdt.0: IMX2+ Watchdog Timer enabled. timeout=60s 
(nowayout=0)
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
ALSA device list:
   No soundcards found.
TCP cubic registered
NET: Registered protocol family 17
imxdi_rtc imxdi_rtc.0: setting system clock to 1970-01-01 00:00:00 UTC 
(0)
VFS: Mounted root (jffs2 filesystem) on device 31:2.
devtmpfs: mounted
Freeing init memory: 124K
eth0: Freescale FEC PHY driver [Generic PHY] 
(mii_bus:phy_addr=imx25-fec-1:00, irq=-1)
PHY: imx25-fec-1:00 - Link is Up - 100/Full
imx-sdma imx35-sdma: firmware not found

A long way to go still, but it's a start ...

I'll now try to get the touchscreen and the remaining interfaces (i2c, 
uarts, sdma, others) to work.

Thanks for the pointers and cheers
-- 
Joan C. Abelaira
