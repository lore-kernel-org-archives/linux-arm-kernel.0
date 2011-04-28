From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 28 Apr 2011 17:07:50 +1200
Subject: [PATCH 09/14] at91: switch pit timer to early platform devices
In-Reply-To: <1303756284-26529-9-git-send-email-plagnioj@jcrosoft.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-9-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4DB8F626.1070001@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2011 06:31 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> this will allow to specify the resources per soc
>
> as the 5series use a different start address for the pit
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>

This patch breaks my Snapper 9G20 board (bisected). With this patch in
place the kernel hangs with the following boot log:

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.39-rc4+ (ryan at okiwi) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #868 Thu Apr 28 16:37:56 NZST 2011
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: Bluewater Systems Snapper 9260/9G20 module
Memory policy: ECC disabled, Data cache writeback
AT91: detected soc: at91sam9260
Clocks: CPU 396 MHz, master 132 MHz, main 18.432 MHz
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=ttyS0,115200 nfsroot=/home/ryan/work/internal/package_builder/rootfs ip=any root=/dev/nfs atmel_nand.use_dma=0
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 61456k/61456k available, 4080k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xc4800000 - 0xfee00000   ( 934 MB)
    lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc0024000   ( 112 kB)
      .text : 0xc0024000 - 0xc03274ac   (3086 kB)
      .data : 0xc0328000 - 0xc034a280   ( 137 kB)
NR_IRQS:192
AT91: 96 gpio irqs in 3 banks
 at91_pit.0: used as clock source
 at91_pit.0: used for clock events
Console: colour dummy device 80x30
console [ttyS0] enabled
Calibrating delay loop... 197.01 BogoMIPS (lpj=985088)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
AT91: Power Management
AT91: Starting after general reset
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Advanced Linux Sound Architecture Driver Version 1.0.24.
Switching to clocksource pit
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
IPv4 FIB: Using LC-trie version 0.409
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (double precision)
JFFS2 version 2.2. (NAND) (SUMMARY)  ? 2001-2006 Red Hat, Inc.
msgmni has been set to 120
io scheduler noop registered (default)
atmel_usart.0: ttyS0 at MMIO 0xfefff200 (irq = 1) is a ATMEL_SERIAL
atmel_usart.1: ttyS1 at MMIO 0xfffb0000 (irq = 6) is a ATMEL_SERIAL
atmel_usart.2: ttyS2 at MMIO 0xfffb4000 (irq = 7) is a ATMEL_SERIAL
atmel_usart.3: ttyS3 at MMIO 0xfffb8000 (irq = 8) is a ATMEL_SERIAL
brd: module loaded
loop: module loaded
atmel_nand atmel_nand: No DMA support for NAND access.
nand_get_flash_type: second ID read did not match 52,2c against 09,2c
No NAND device found.
MACB_mii_bus: probed
eth0: Atmel MACB at 0xfffc4000 irq 21 (00:00:00:00:00:01)
eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=ffffffff:1f, irq=-1)
usbmon: debugfs is not available
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
at91_ohci at91_ohci: AT91 OHCI
at91_ohci at91_ohci: new USB bus registered, assigned bus number 1
at91_ohci at91_ohci: irq 20, io mem 0x00500000


It just stops dead here. Unfortunately I can't get my ICE unit to
connect to it for some reason so I can't give you any more information
at the moment.

I've had a quick look through the patch and I can't see anything
obviously wrong, but I don't have much experience with the clockevents
subsystem either. Any ideas? I can send through my .config if that helps.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751 
Fax:   +64 3 3779135			  USA 1800 261 2934
