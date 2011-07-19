From: mkl0301@gmail.com (Lin Mac)
Date: Wed, 20 Jul 2011 02:11:47 +0800
Subject: [PATCH] ARM: cns3xxx: Add support for L2 Cache Controller
In-Reply-To: <20110707165102.GA7749@oksana.dev.rtsoft.ru>
References: <20110706140832.GA15946@oksana.dev.rtsoft.ru>
	<CAK1hUK-gFwcHzEqFz8+T8Vm7CL5GnHAXureVizfNOBm=8h2mRw@mail.gmail.com>
	<20110707165102.GA7749@oksana.dev.rtsoft.ru>
Message-ID: <CAK1hUK9Ygm+prOHAkT==C=4nX21SVdLpfB4=40VDCW3rWjE0gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/8 Anton Vorontsov <cbouatmailru@gmail.com>:
>> CNS3xxx have PL310. Would you mind to enable CONFIG_CACHE_PL310 by
>> default as well? It is default disabled by !CPU_V6 of CACHE_PL310.
> Well, while CNS3xxx reports that it has PL310, it still needs
> to wait on cache line operations, but 'CACHE_PL310' removes
> these waits. So, CNS3xxx is special.
Sorry for the late response.

CNS3xxx has PL310 (r2p0), and I not aware of any special point it has, AFAICT.

> With CACHE_PL310 enabled I'm getting random 'illegal instruction'
> and 'segmentation fault's when userland loads via NFS.

With commit 93e85d8 of your tree and the following patch to enable
PL310 by default, I'm able to setup NFS rootfs and doing some tests on
CNS3420 VB v2.1,
I tried write/read data on SD, SATA hardisk, and samba for 100MB. The
data is consistent, and no error is found.

Could you provide the procedure to reproduce the issue that you have seen?

-------------------------------
Devices: e1000e (Intel gigabit CT desktop adapter) + miniPCIe to PCIe
adapter, Segate Barracuda 1TB.

Toolchain is Code Soucery Sourcery G++ Lite arm-2009q1 glibc
gcc-4.3.3, rootfs built by buildroot.

Attached the config that I used, and the following are the patch,
bootargs setting and the console log:
-------------------------------
diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
index 29b13f2..419a0cf 100644
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -4,6 +4,7 @@ menu "CNS3XXX platform type"
 config MACH_CNS3420VB
        bool "Support for CNS3420 Validation Board"
        select MIGHT_HAVE_PCI
+       select CACHE_PL310 if CACHE_L2X0
        help
          Include support for the Cavium Networks CNS3420 MPCore Platform
          Baseboard.
-------------------------------
set bootargs root=/dev/nfs rw nfsroot=172.20.5.100:/home/nfs
ip=172.20.5.200:172.20.5.254::255.255.0.0::eth0:off init=/linuxrc
mem=512M console=ttyS0,38400 user_debug=31 console=tty0
-------------------------------
U-Boot 2008.10-mpcore-dirty (Jun 17 2011 - 03:32:49)
Cavium Networks CNS3XXX SDK v1.2-2515 CNS3420vb2x serial flash

CPU: Cavium Networks CNS3000
ID Code: 410fb024 (Part number: 0xB02, Revision number: 4)
CPU ID: 900
Chip Version: d
Boot from serial flash

DRAM:  512 MB
Paralle Flash: 128 MB
Flash Manufacturer: MX
Serial Flash: 16 MB
Serial Flash:
Bank # 1: MX 25L128  Nb pages: 65536  Page Size: 256
  Size:  16777216 bytes,  Logical address: 0x60000000
  Area 0: 60000000 to 60FFFFFF      SPI flash
In:    serial
Out:   serial
Err:   serial
CPU works at 600 MHz (600/1/1)
DDR2 Speed is 400 MHz
Hit any key to stop autoboot:  0
MAC PORT 0 : Initialize bcm53115M
MAC PORT 2 : Initialize RTL8211
TFTP from server 172.20.5.100; our IP address is 172.20.5.178
Filename 'uImage'.
Load address: 0x4000000
Loading: T #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ##
done
Bytes transferred = 2003632 (1e92b0 hex)
enter do_eth_down!!!
## Booting kernel from Legacy Image at 04000000 ...
   Image Name:   Linux-3.0.0-rc6+
   Created:      2011-07-19  16:50:40 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2003568 Bytes =  1.9 MB
   Load Address: 02000000
   Entry Point:  02000000
   Loading Kernel Image ... OK
OK
Using machid 0xad8 from environment

Starting kernel ...

Uncompressing Li done, booting tLinux version 3.0.0-rc6+
(root at test-desktop) (gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203)
) #82 Wed Jul 20 00:50:35 CST1
CPU: ARMv6-compatible processor [410fb024] revision 4 (ARMv7), cr=00c5387f
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Cavium Networks CNS3420 Validation Board
Memory policy: ECC disabled, Data cache writeback
Truncating RAM at 00000000-1fffffff to -0fffffff (vmalloc region overlap).
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=/dev/nfs rw nfsroot=172.20.5.100:/home/nfs
ip=172.20.5.200:172.20.5.254::255.255.0.0::eth0:off init=/linuxrc
mem=512M console=ttyS0
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 512MB = 512MB total
Memory: 255880k/255880k available, 6264k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xd0800000 - 0xd8000000   ( 120 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc0029000   ( 132 kB)
      .text : 0xc0029000 - 0xc03b1000   (3616 kB)
      .data : 0xc03b2000 - 0xc03ced00   ( 116 kB)
       .bss : 0xc03ced24 - 0xc03e1ed4   (  77 kB)
NR_IRQS:96
Console: colour dummy device 80x30
console [tty0] enabled
console [ttyS0] enabled
Calibrating delay loop... 242.07 BogoMIPS (lpj=1210368)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
L310 cache controller enabled
l2x0: 8 ways, CACHE_ID 0x410000c4, AUX_CTRL 0x02540000, Cache size: 262144 B
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
FS-Cache: Loaded
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCIe: Port[0] Enable PCIe LTSSM
PCIe: Port[0] Check data link layer...
Link up.
PCIe: Set Device Max_Read_Request_Size to 128 byte
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers enabled
PCIe map irq: 0000:00:00.00 slot 0, pin 1, irq: 87
PCIe map irq: 0000:00:01.00 slot 1, pin 1, irq: 61
pci 0000:00:01.0: BAR 1: assigned [mem 0xa0000000-0xa007ffff]
pci 0000:00:01.0: BAR 1: set to [mem 0xa0000000-0xa007ffff] (PCI
address [0xa0000000-0xa007ffff])
pci 0000:00:01.0: BAR 6: assigned [mem 0xa0080000-0xa00bffff pref]
pci 0000:00:01.0: BAR 0: assigned [mem 0xa00c0000-0xa00dffff]
pci 0000:00:01.0: BAR 0: set to [mem 0xa00c0000-0xa00dffff] (PCI
address [0xa00c0000-0xa00dffff])
pci 0000:00:01.0: BAR 3: assigned [mem 0xa00e0000-0xa00e3fff]
pci 0000:00:01.0: BAR 3: set to [mem 0xa00e0000-0xa00e3fff] (PCI
address [0xa00e0000-0xa00e3fff])
pci 0000:00:01.0: BAR 2: assigned [io  0xac000000-0xac00001f]
pci 0000:00:01.0: BAR 2: set to [io  0xac000000-0xac00001f] (PCI
address [0xac000000-0xac00001f])
pci 0000:00:00.0: PCI bridge to [bus 01-01]
pci 0000:00:00.0:   bridge window [io  disabled]
pci 0000:00:00.0:   bridge window [mem disabled]
pci 0000:00:00.0:   bridge window [mem pref disabled]
PCI: enabling device 0000:00:00.0 (0140 -> 0143)
PCIe: Port[1] Enable PCIe LTSSM
PCIe: Port[1] Check data link layer...
Device not found.
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers enabled
PCIe map irq: 0000:00:00.00 slot 0, pin 1, irq: 87
PCIe map irq: 0000:00:01.00 slot 1, pin 1, irq: 61
PCIe map irq: 0001:00:00.00 slot 0, pin 1, irq: 88
pci 0001:00:00.0: PCI bridge to [bus 01-01]
pci 0001:00:00.0:   bridge window [io  disabled]
pci 0001:00:00.0:   bridge window [mem disabled]
pci 0001:00:00.0:   bridge window [mem pref disabled]
PCI: enabling device 0001:00:00.0 (0140 -> 0143)
msgmni has been set to 499
io scheduler noop registered
io scheduler deadline registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x78000000 (irq = 45) is a 16550A
brd: module loaded
loop: module loaded
ahci ahci.0: forcing PORTS_IMPL to 0x3
ahci ahci.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl platform mode
ahci ahci.0: flags: ncq sntf pm led clo only pmp pio slum part ccc
scsi0 : ahci_platform
scsi1 : ahci_platform
ata1: SATA max UDMA/133 mmio [mem 0x83000000-0x83ffffff] port 0x100 irq 65
ata2: SATA max UDMA/133 mmio [mem 0x83000000-0x83ffffff] port 0x180 irq 65
physmap platform flash device: 08000000 at 10000000
physmap-flash physmap-flash.0: Could not reserve memory region
physmap-flash: probe of physmap-flash.0 failed with error -12
e1000e: Intel(R) PRO/1000 Network Driver - 1.3.10-k2
e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
e1000e 0000:00:01.0: Disabling ASPM L0s
PCI: enabling device 0000:00:01.0 (0140 -> 0142)
e1000e 0000:00:01.0: (unregistered net_device): Failed to initialize
MSI-X interrupts.  Falling back to MSI interrupts.
e1000e 0000:00:01.0: (unregistered net_device): Failed to initialize
MSI interrupts.  Falling back to legacy interrupts.
e1000e 0000:00:01.0: eth0: (PCI Express:2.5GT/s:Width x1) 00:1b:21:69:5d:9f
e1000e 0000:00:01.0: eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:00:01.0: eth0: MAC: 3, PHY: 8, PBA No: E46981-003
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
cns3xxx-ehci cns3xxx-ehci.0: CNS3XXX EHCI Host Controller
cns3xxx-ehci cns3xxx-ehci.0: new USB bus registered, assigned bus number 1
cns3xxx-ehci cns3xxx-ehci.0: irq 64, io mem 0x82000000
ata1: SATA link down (SStatus 0 SControl 300)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
cns3xxx-ehci cns3xxx-ehci.0: USB 0.0 started, EHCI 1.00
ata2.00: ATA-8: ST31000528AS, CC38, max UDMA/133
ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
cns3xxx-ohci cns3xxx-ohci.0: CNS3XXX OHCI Host controller
cns3xxx-ohci cns3xxx-ohci.0: new USB bus registered, assigned bus number 2
cns3xxx-ohci cns3xxx-ohci.0: irq 91, io mem 0x88000000
ata2.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      ST31000528AS     CC38 PQ: 0 ANSI: 5
sd 1:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
 sda: sda1
sd 1:0:0:0: [sda] Attached SCSI disk
mousedev: PS/2 mouse device common for all mice
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
mmc0: SDHCI controller on platform [sdhci-cns3xxx.0] using PIO
TCP cubic registered
Registering the dns_resolver key type
mmc0: new high speed SDHC card at address e0fa
mmcblk0: mmc0:e0fa SD08G 7.40 GiB
 mmcblk0: p1 p2
e1000e: eth0 NIC Link is Up 100 Mbps Full Duplex, Flow Control: Rx/Tx
e1000e 0000:00:01.0: eth0: 10/100 speed: disabling TSO
IP-Config: Complete:
     device=eth0, addr=172.20.5.200, mask=255.255.0.0, gw=255.255.255.255,
     host=172.20.5.200, domain=, nis-domain=(none),
     bootserver=172.20.5.254, rootserver=172.20.5.100, rootpath=
VFS: Mounted root (nfs filesystem) on device 0:12.
Freeing init memory: 132K

Welcome to Buildroot
buildroot login:
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config
Type: application/octet-stream
Size: 34875 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110720/9ebb06d3/attachment-0001.obj>
