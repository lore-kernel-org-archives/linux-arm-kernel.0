From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 9 Sep 2015 18:21:11 +0100
Subject: [PATCH] arm64: Add support for hardware updates of the access
 and dirty pte bits
In-Reply-To: <1436545468-1549-1-git-send-email-catalin.marinas@arm.com>
References: <1436545468-1549-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <55F06A87.3000204@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

I've tried to boot the latest linus/master (a794b4f) which include this
patch as DOM0 on xgene. This is failing late in the boot with
a BUG (see trace below).

The bisector pointed me to this patch. When I disable
CONFIG_ARM64_HW_AFDBM, I'm able to boot the kernel and use it
without any issue.

Although, I'm not sure to understand how this patch could
possibly break the filesystem subsystem.

Do you have any insight for debugging this problem?

Regards,



(XEN) DOM0: Booting Linux on physical CPU 0x0

(XEN) DOM0: Linux version 4.2.0-10637-ga794b4f (julien at chilopoda) (gcc version 4.9.2 20140904 (prerelease) (crosstool-NG linaro-1.13.1-4.9

(XEN) DOM0: -2014.09 - Linaro GCC 4.9-2014.09) ) #125 SMP Wed Sep 9 17:57:41 BST 2015

(XEN) DOM0: CPU: AArch64 Processor [500f0000] revision 0

(XEN) DOM0: Detected PIPT I-cache on CPU0

(XEN) DOM0: earlycon: Early serial console at MMIO32 0x1c020000 (options '')

(XEN) DOM0: bootconsole [uart0] enabled

(XEN) DOM0: debug: ignoring loglevel setting.

(XEN) DOM0: efi: Getting EFI parameters from FDT:

(XEN) DOM0: efi: UEFI not found.

(XEN) DOM0: On node 0 totalpages: 1048576

(XEN) DOM0:   DMA zone: 16384 pages used for memmap

(XEN) DOM0:   DMA zone: 0 pages reserved

(XEN) DOM0:   DMA zone: 1048576 pages, LIFO batch:31

(XEN) DOM0: Moving initrd from [804100000000-8040ffffffff] to [41fffe6000-41fffe5fff]

(XEN) DOM0: psci: probing for conduit method from DT.

(XEN) DOM0: psci: PSCIv0.2 detected in firmware.

(XEN) DOM0: psci: Using standard PSCI v0.2 function IDs

(XEN) DOM0: psci: Trusted OS migration not required

(XEN) DOM0: Xen 4.6 support found

(XEN) DOM0: PERCPU: Embedded 16 pages/cpu @ffff8000fff53000 s28032 r8192 d29312 u65536

(XEN) DOM0: pcpu-alloc: s28032 r8192 d29312 u65536 alloc=16*4096

(XEN) DOM0: pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 

(XEN) DOM0: Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1032192

(XEN) DOM0: Kernel command line: console=hvc0 root=/dev/sda3 rw earlycon=uart8250,mmio32,0x1c020000 ignore_loglevel

(XEN) DOM0: PID hash table entries: 4096 (order: 3, 32768 bytes)

(XEN) DOM0: Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)

(XEN) DOM0: Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)

(XEN) DOM0: software IO TLB [mem 0x41f7600000-0x41fb600000] (64MB) mapped at [ffff8000f7600000-ffff8000fb5fffff]

(XEN) DOM0: Memory: 4045140K/4194304K available (6888K kernel code, 654K rwdata, 2340K rodata, 360K init, 481K bss, 149164K reserved, 0K c

(XEN) DOM0: ma-reserved)

(XEN) DOM0: Virtual kernel memory layout:

(XEN) DOM0:     vmalloc : 0xffff000000000000 - 0xffff7bffbfff0000   (126974 GB)

(XEN) DOM0:     vmemmap : 0xffff7bffc0000000 - 0xffff7fffc0000000   (  4096 GB maximum)

(XEN) DOM0:               0xffff7c00c4000000 - 0xffff7c00c8000000   (    64 MB actual)

(XEN) DOM0:     fixed   : 0xffff7ffffa7fd000 - 0xffff7ffffac00000   (  4108 KB)

(XEN) DOM0:     PCI I/O : 0xffff7ffffae00000 - 0xffff7ffffbe00000   (    16 MB)

(XEN) DOM0:     modules : 0xffff7ffffc000000 - 0xffff800000000000   (    64 MB)

(XEN) DOM0:     memory  : 0xffff800000000000 - 0xffff800100000000   (  4096 MB)

(XEN) DOM0:       .init : 0xffff800000986000 - 0xffff8000009e0000   (   360 KB)

(XEN) DOM0:       .text : 0xffff800000080000 - 0xffff8000009852f4   (  9237 KB)

(XEN) DOM0:       .data : 0xffff8000009e7000 - 0xffff800000a8aa00   (   655 KB)

(XEN) DOM0: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1

(XEN) DOM0: Hierarchical RCU implementation.

(XEN) DOM0: 	Build-time adjustment of leaf fanout to 64.

(XEN) DOM0: NR_IRQS:64 nr_irqs:64 0

(XEN) DOM0: Architected cp15 timer(s) running at 50.00MHz (virt).

(XEN) DOM0: clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns

(XEN) DOM0: sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns

console [hvc0] enabled


(XEN) DOM0: console [hvc0] enabled

bootconsole [uart0] disabled


(XEN) DOM0: bootconsole [uart0] disabled

Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=500000)


pid_max: default: 32768 minimum: 301


Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)


Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)


Initializing cgroup subsys net_cls


Initializing cgroup subsys perf_event


hw perfevents: enabled with arm/armv8-pmuv3 PMU driver, 1 counters available


EFI services will not be available.


xen:grant_table: Grant tables using version 1 layout


Grant table initialized


xen:events: Using FIFO-based ABI

Xen: initializing cpu0


CPU1: Booted secondary processor


Detected PIPT I-cache on CPU1


Xen: initializing cpu1


CPU2: Booted secondary processor


Detected PIPT I-cache on CPU2


Xen: initializing cpu2


CPU3: Booted secondary processor


Detected PIPT I-cache on CPU3


Xen: initializing cpu3


CPU4: Booted secondary processor


Detected PIPT I-cache on CPU4


Xen: initializing cpu4


CPU5: Booted secondary processor


Detected PIPT I-cache on CPU5


Xen: initializing cpu5


CPU6: Booted secondary processor


Detected PIPT I-cache on CPU6


Xen: initializing cpu6


CPU7: Booted secondary processor


Detected PIPT I-cache on CPU7


Xen: initializing cpu7


Brought up 8 CPUs


SMP: Total of 8 processors activated.


CPU: All CPU(s) started at EL1


devtmpfs: initialized


DMI not present or invalid.


clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns


xor: measuring software checksum speed


   8regs     :  8666.000 MB/sec


   8regs_prefetch:  7758.400 MB/sec


   32regs    :  8619.600 MB/sec


   32regs_prefetch:  7726.800 MB/sec


xor: using function: 8regs (8666.000 MB/sec)


NET: Registered protocol family 16


vdso: 2 pages (1 code @ ffff8000009ed000, 1 data @ ffff8000009ec000)


hw-breakpoint: found 4 breakpoint and 4 watchpoint registers.


DMA: preallocated 256 KiB pool for atomic allocations


xen:swiotlb_xen: Warning: only able to allocate 4 MB for software IO TLB


software IO TLB [mem 0x41f6800000-0x41f6c00000] (4MB) mapped at [ffff8000f6800000-ffff8000f6bfffff]


Serial: AMBA PL011 UART driver


raid6: int64x1  gen()  1443 MB/s


raid6: int64x1  xor()  1133 MB/s


raid6: int64x2  gen()  1956 MB/s


raid6: int64x2  xor()  1405 MB/s


raid6: int64x4  gen()  2825 MB/s


raid6: int64x4  xor()  1658 MB/s


raid6: int64x8  gen()  2800 MB/s


raid6: int64x8  xor()  1660 MB/s


raid6: neonx1   gen()  3075 MB/s


raid6: neonx1   xor()  1810 MB/s


raid6: neonx2   gen()  3131 MB/s


raid6: neonx2   xor()  1837 MB/s


raid6: neonx4   gen()  3115 MB/s


raid6: neonx4   xor()  1835 MB/s


raid6: neonx8   gen()  2655 MB/s


raid6: neonx8   xor()  1766 MB/s


raid6: using algorithm neonx2 gen() 3131 MB/s


raid6: .... xor() 1837 MB/s, rmw enabled


raid6: using intx1 recovery algorithm


ACPI: Interpreter disabled.


xen:balloon: Initialising balloon driver


xen_balloon: Initialising balloon driver


vgaarb: loaded


SCSI subsystem initialized


libata version 3.00 loaded.


pps_core: LinuxPPS API ver. 1 registered


pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>


PTP clock support registered


dmi: Firmware registration failed.


clocksource: Switched to clocksource arch_sys_counter


pnp: PnP ACPI: disabled


NET: Registered protocol family 2


TCP established hash table entries: 32768 (order: 6, 262144 bytes)


TCP bind hash table entries: 32768 (order: 7, 524288 bytes)


TCP: Hash tables configured (established 32768 bind 32768)


UDP hash table entries: 2048 (order: 4, 65536 bytes)


UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)


NET: Registered protocol family 1


RPC: Registered named UNIX socket transport module.


RPC: Registered udp transport module.


RPC: Registered tcp transport module.


RPC: Registered tcp NFSv4.1 backchannel transport module.


PCI: CLS 0 bytes, default 64


Unpacking initramfs...


futex hash table entries: 2048 (order: 5, 131072 bytes)


HugeTLB registered 2 MB page size, pre-allocated 0 pages


Installing knfsd (copyright (C) 1996 okir at monad.swb.de).


JFS: nTxBlock = 8192, nTxLock = 65536


SGI XFS with security attributes, no debug enabled


9p: Installing v9fs 9p2000 file system support


Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)


io scheduler noop registered


io scheduler deadline registered


io scheduler cfq registered (default)


PCI host bridge /soc/pcie at 1f2b0000 ranges:


  No bus range found for /soc/pcie at 1f2b0000, using [bus 00-ff]


   IO 0xe010000000..0xe01000ffff -> 0x00000000


  MEM 0xe180000000..0xe1ffffffff -> 0x80000000


xgene-pcie 1f2b0000.pcie: (rc) x4 gen-1 link up


xgene-pcie 1f2b0000.pcie: PCI host bridge to bus 0000:00


pci_bus 0000:00: root bus resource [bus 00-ff]


pci_bus 0000:00: root bus resource [io  0x0000-0xffff]


pci_bus 0000:00: root bus resource [mem 0xe180000000-0xe1ffffffff] (bus address [0x80000000-0xffffffff])


pci 0000:00:00.0: [10e8:e004] type 01 class 0x060400


pci 0000:00:00.0: supports D1 D2


(XEN) do_physdev_op 16 cmd=25: not implemented yet

(XEN) do_physdev_op 16 cmd=15: not implemented yet

pci 0000:00:00.0: Failed to add - passthrough or MSI/MSI-X might fail!


pci 0000:00:00.0: PCI bridge to [bus 01]


pci 0000:00:00.0:   bridge window [io  0x10000000-0x10000fff]


pci 0000:00:00.0:   bridge window [mem 0x00100000-0x001fffff]


pci 0000:01:00.0: [8086:105e] type 00 class 0x020000


pci 0000:01:00.0: reg 0x10: [mem 0x00100000-0x0011ffff]


pci 0000:01:00.0: reg 0x14: [mem 0x00120000-0x0013ffff]


pci 0000:01:00.0: reg 0x18: [io  0x10000000-0x1000001f]


pci 0000:01:00.0: reg 0x30: [mem 0x00140000-0x0015ffff pref]


pci 0000:01:00.0: PME# supported from D0 D3hot


(XEN) do_physdev_op 16 cmd=15: not implemented yet

pci 0000:01:00.0: Failed to add - passthrough or MSI/MSI-X might fail!


pci 0000:01:00.1: [8086:105e] type 00 class 0x020000


pci 0000:01:00.1: reg 0x10: [mem 0x00160000-0x0017ffff]


pci 0000:01:00.1: reg 0x14: [mem 0x00180000-0x0019ffff]


pci 0000:01:00.1: reg 0x18: [io  0x10000020-0x1000003f]


pci 0000:01:00.1: reg 0x30: [mem 0x001a0000-0x001bffff pref]


pci 0000:01:00.1: PME# supported from D0 D3hot


(XEN) do_physdev_op 16 cmd=15: not implemented yet

pci 0000:01:00.1: Failed to add - passthrough or MSI/MSI-X might fail!


pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'


pci 0000:00:00.0: BAR 8: assigned [mem 0xe180000000-0xe1800fffff]


pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]


pci 0000:01:00.0: BAR 0: assigned [mem 0xe180000000-0xe18001ffff]


pci 0000:01:00.0: BAR 1: assigned [mem 0xe180020000-0xe18003ffff]


pci 0000:01:00.0: BAR 6: assigned [mem 0xe180040000-0xe18005ffff pref]


pci 0000:01:00.1: BAR 0: assigned [mem 0xe180060000-0xe18007ffff]


pci 0000:01:00.1: BAR 1: assigned [mem 0xe180080000-0xe18009ffff]


pci 0000:01:00.1: BAR 6: assigned [mem 0xe1800a0000-0xe1800bffff pref]


pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]


pci 0000:01:00.1: BAR 2: assigned [io  0x1020-0x103f]


pci 0000:00:00.0: PCI bridge to [bus 01]


pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]


pci 0000:00:00.0:   bridge window [mem 0xe180000000-0xe1800fffff]


pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt


pci 0000:01:00.0: Signaling PME through PCIe PME interrupt


pci 0000:01:00.1: Signaling PME through PCIe PME interrupt


pcie_pme 0000:00:00.0:pcie01: service driver pcie_pme loaded


xen:xen_evtchn: Event-channel device installed


Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled


Unable to detect cache hierarchy from DT for CPU 0


loop: module loaded


xgene-ahci 1a400000.sata: skip clock and PHY initialization


xgene-ahci 1a400000.sata: controller can't do NCQ, turning off CAP_NCQ


xgene-ahci 1a400000.sata: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3 impl platform mode


xgene-ahci 1a400000.sata: flags: 64bit sntf pm only pmp fbs pio slum part ccc apst boh 


scsi host0: xgene-ahci


scsi host1: xgene-ahci


ata1: SATA max UDMA/133 mmio [mem 0x1a400000-0x1a400fff] port 0x100 irq 5


ata2: SATA max UDMA/133 mmio [mem 0x1a400000-0x1a400fff] port 0x180 irq 5


xgene-ahci 1a800000.sata: skip clock and PHY initialization


xgene-ahci 1a800000.sata: controller can't do NCQ, turning off CAP_NCQ


xgene-ahci 1a800000.sata: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3 impl platform mode


xgene-ahci 1a800000.sata: flags: 64bit sntf pm only pmp fbs pio slum part ccc apst boh 


scsi host2: xgene-ahci


scsi host3: xgene-ahci


ata3: SATA max UDMA/133 mmio [mem 0x1a800000-0x1a800fff] port 0x100 irq 6


ata4: SATA max UDMA/133 mmio [mem 0x1a800000-0x1a800fff] port 0x180 irq 6


tun: Universal TUN/TAP device driver, 1.6


tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>


libphy: APM X-Gene MDIO bus: probed


xen_netfront: Initialising Xen virtual ethernet driver


xgene-rtc 10510000.rtc: rtc core: registered 10510000.rtc as rtc0


device-mapper: ioctl: 4.33.0-ioctl (2015-8-18) initialised: dm-devel at redhat.com


device-mapper: multipath: version 1.9.0 loaded


device-mapper: multipath round-robin: version 1.0.0 loaded


ip_tables: (C) 2000-2006 Netfilter Core Team


arp_tables: (C) 2002 David S. Miller


NET: Registered protocol family 10


sit: IPv6 over IPv4 tunneling driver


NET: Registered protocol family 17


bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.


Bridge firewalling registered


9pnet: Installing 9P2000 support


NET: Registered protocol family 37


Btrfs loaded


xgene-rtc 10510000.rtc: setting system clock to 2015-09-09 17:00:01 UTC (1441818001)


ata3: SATA link down (SStatus 0 SControl 4300)


ata2: SATA link down (SStatus 0 SControl 4300)


ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 4300)


ata4: SATA link down (SStatus 0 SControl 4300)


ata1.00: ATA-8: ST500DM002-1BD142, KC45, max UDMA/133


ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)


ata1.00: configured for UDMA/133


scsi 0:0:0:0: Direct-Access     ATA      ST500DM002-1BD14 KC45 PQ: 0 ANSI: 5


sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)


sd 0:0:0:0: [sda] 4096-byte physical blocks


sd 0:0:0:0: Attached scsi generic sg0 type 0


sd 0:0:0:0: [sda] Write Protect is off


sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00


sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA


 sda: sda1 sda2 sda3 sda4


sd 0:0:0:0: [sda] Attached SCSI disk


EXT4-fs (sda3): couldn't mount as ext3 due to feature incompatibilities


EXT4-fs (sda3): couldn't mount as ext2 due to feature incompatibilities


EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)


VFS: Mounted root (ext4 filesystem) on device 8:3.


devtmpfs: mounted


Freeing unused kernel memory: 360K (ffff800000986000 - ffff8000009e0000)


Freeing alternatives memory: 16K (ffff8000009e0000 - ffff8000009e4000)


Mount failed for selinuxfs on /sys/fs/selinux:  No such file or directory



INIT: version 2.88 booting



[[36minfo[39;49m] Using makefile-style concurrent boot in runlevel S.


findfs: unable to resolve 'UUID=c21caf83-198f-4c13-ae91-e16296f8f278'


[....] Starting the hotplug events dispatcher: udevdsystemd-udevd[210]: starting version 215


[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0c.


[....] Synthesizing the initial hotplug events...[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0cdone.


random: udevd urandom read with 25 bits of entropy available


[....] Waiting for /dev to be fully populated...[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0cdone.


[....] Setting preliminary keymap...[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0cdone.


EXT4-fs (sda3): re-mounted. Opts: (null)


[....] Checking root file system...fsck from util-linux 2.25.2


/dev/sda3: clean, 51202/2097152 files, 658553/8388608 blocks


[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0cdone.


EXT4-fs (sda3): re-mounted. Opts: errors=remount-ro


[....] Cleaning up temporary files... /tmp[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0c.


[....] Setting up LVM Volume Groups...[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0cdone.


[....] Activating lvm and md swap...Adding 16777212k swap on /dev/mapper/pony-swap.  Priority:-1 extents:1 across:16777212k 


[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0cdone.


[....] Checking file systems...fsck from util-linux 2.25.2


/dev/mapper/pony-home: clean, 6925/262144 files, 148573/1048576 blocks


/dev/mapper/pony-rootfs: clean, 15/6553600 files, 7012928/26214400 blocks


[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0cdone.


EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: (null)


EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: (null)


[....] Mounting local filesystems...[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0cdone.


[....] Activating swapfile swap...[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0cdone.


[....] Cleaning up temporary files...[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0c.


[....] Setting kernel variables ...[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0cdone.


device eth0 entered promiscuous mode


xenbr0: port 1(eth0) entered forwarding state


xenbr0: port 1(eth0) entered forwarding state


xenbr0: port 1(eth0) entered disabled state


xgene-enet 17020000.ethernet eth0: Link is Down


[....] Configuring network interfaces...


Waiting for xenbr0 to get ready (MAXWAIT is 32 seconds).


Internet Systems Consortium DHCP Client 4.3.1


Copyright 2004-2014 Internet Systems Consortium.


All rights reserved.


For info, please visit https://www.isc.org/software/dhcp/





Listening on LPF/xenbr0/d2:ee:a8:7d:e5:5b


Sending on   LPF/xenbr0/d2:ee:a8:7d:e5:5b


Sending on   Socket/fallback


DHCPDISCOVER on xenbr0 to 255.255.255.255 port 67 interval 3


random: nonblocking pool is initialized


xgene-enet 17020000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx


xenbr0: port 1(eth0) entered forwarding state


xenbr0: port 1(eth0) entered forwarding state


DHCPDISCOVER on xenbr0 to 255.255.255.255 port 67 interval 5


DHCPDISCOVER on xenbr0 to 255.255.255.255 port 67 interval 7


DHCPREQUEST on xenbr0 to 255.255.255.255 port 67


DHCPOFFER from 10.80.224.1


DHCPACK from 10.80.224.1


bound to 10.80.239.166 -- renewal in 744 seconds.


ifup: interface eth0 already configured


[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0cdone.


[....] Starting rpcbind daemon...[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0c.


[....] Starting NFS common utilities: statd idmapd[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0c.


[....] Cleaning up temporary files...[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0c.


[[36minfo[39;49m] Setting console screen modes.


setterm: cannot (un)set powersave mode: Inappropriate ioctl for device


[9;30][14;30][....] Setting up console font and keymap...%GCouldn't get a file descriptor referring to the console


Couldn't get a file descriptor referring to the console


[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0cdone.



INIT: Entering runlevel: 2



[[36minfo[39;49m] Using makefile-style concurrent boot in runlevel 2.


[....] Starting enhanced syslogd: rsyslogd[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0c.


[....] Starting deferred execution scheduler: atd[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0c.


[....] Starting periodic command scheduler: cron[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0c.


------------[ cut here ]------------


kernel BUG at /home/julien/works/linux/fs/ext4/inode.c:2351!


Internal error: Oops - BUG: 0 [#1] SMP


Modules linked in:


CPU: 6 PID: 96 Comm: kworker/u16:4 Not tainted 4.2.0-10637-ga794b4f #125


Hardware name: APM X-Gene Mustang board (DT)


Workqueue: writeback wb_workfn (flush-8:0)


task: ffff8000f5ff6900 ti: ffff8000f5a98000 task.ti: ffff8000f5a98000


PC is at mpage_prepare_extent_to_map+0x23c/0x27c


LR is at mpage_prepare_extent_to_map+0x104/0x27c


pc : [<ffff800000216884>] lr : [<ffff80000021674c>] pstate: 60000145


sp : ffff8000f5a9b890


x29: ffff8000f5a9b890 x28: 000000000000000d 


x27: 0000000000000000 x26: ffff8000f65853e0 


x25: 0000000000000000 x24: ffffffffffffffff 


x23: 0000000000003400 x22: ffff8000f5a9b918 


x21: ffff8000f5a9b918 x20: ffff8000f5a9ba50 


x19: ffff7c00c4209080 x18: 0000ffffe4edc7a0 


x17: 0000ffff8e2fc8d0 x16: 0000ffff8e315000 


x15: 0000ffff8e315000 x14: 0ffffffffffffffe 


x13: 0000000000000000 x12: 0000000000000000 


x11: ffff8000f657fd98 x10: 0000000000000040 


x9 : 0000000000000220 x8 : 0000000000000100 


x7 : 0000000000000040 x6 : 0000000000000002 


x5 : 0000000000000000 x4 : 0000000000000001 


x3 : 000000000000000a x2 : 000000000032023d 


x1 : ffff7c00c4209080 x0 : 000000000032023d 





Process kworker/u16:4 (pid: 96, stack limit = 0xffff8000f5a98020)


Stack: (0xffff8000f5a9b890 to 0xffff8000f5a9c000)


b880:                                   ffff8000f5a9b980 ffff800000219dc4


b8a0: ffff8000f6585290 ffff8000f5a9bb98 0000000000000000 ffff8000f65853e0


b8c0: ffff8000f5a9bb98 ffff8000009ee000 ffff8000f6664000 ffff8000f56c7000


b8e0: 0000000000003400 0000000000000000 0000000000000008 000000000000000b


b900: 0000000000000001 0000000000000000 ffff7c00c4209080 ffff8000f56c7000


b920: 0000000000003400 ffff800000241f0c ffff8000f5a9b980 ffff800000219d94


b940: ffff8000f6585290 ffff8000f5a9bb98 0000000000000000 ffff8000f65853e0


b960: ffff800000a82000 ffff8000009ee000 ffff8000f65853e0 0000000100219afc


b980: ffff8000f5a9bab0 ffff80000013eaa8 ffff8000f6585290 ffff8000f5af81d8


b9a0: ffff8000f5a9bb98 0000000000003400 ffff800000a82000 ffff8000009ee000


b9c0: ffff8000f65853e0 0000000000000807 ffff8000f5a9bd40 ffff8000f5af8200


b9e0: ffff800000754d40 ffff8000008ca290 0000000100000008 ffffffffffffffff


ba00: 0000000000000000 0000000000000001 ffff800000755088 0000000000000000


ba20: ffff8000f5a9bd40 ffff8000f5af8200 ffff8000f5a9ba70 ffff8000008fe2c0


ba40: ffff8000f5a9ba60 ffff8000004110a8 ffff8000f6585290 ffff8000f5a9bb98


ba60: 000000000000000a 000000000000000b ffffffffffffffff ffff8000001b0bcc


ba80: 00000000f65b3888 0000000000000007 ffff8000f5a9bb98 0000000000000000


baa0: ffff8000f650c000 ffff800000414cc4 ffff8000f5a9bac0 ffff8000001b0a50


bac0: ffff8000f5a9bb10 ffff8000001b15f8 ffff8000f6585378 ffff8000f5af81d8


bae0: ffff8000f56c6800 ffff8000f6585290 0000000000000006 ffff8000009ee000


bb00: ffff8000f5af8230 0000000000000807 ffff8000f5a9bbf0 ffff8000001b18b4


bb20: ffff8000f56c6800 ffff8000f5af81d8 ffff8000f5af8200 0000000000000011


bb40: ffff8000f5a9bd40 00000000ffff930e ffff8000009ee000 ffff8000f65d43b0


bb60: ffff8000f5af8350 ffff800000a08be0 0000000000003400 ffff8000f6585310


bb80: ffff800000a82e10 00000000ffff9304 ffff8000f5a9bc10 0000000000003400


bba0: 0000000000000000 0000000000000000 7fffffffffffffff 0000001200000000


bbc0: ffff8000f5a9bbc0 ffff8000f5a9bbc0 ffff8000f5a9bbd0 ffff8000f5a9bbd0


bbe0: ffff8000f5a9bbe0 ffff8000f5a9bbe0 ffff8000f5a9bc40 ffff8000001b1b2c


bc00: ffff8000f5a9bd40 ffff8000f5af81d8 ffff8000f5af8188 ffff800000a82e10


bc20: ffff8000f5af81d8 000000000000000a ffff8000f5af8350 00000000ffff9304


bc40: ffff8000f5a9bcc0 ffff8000001b1fbc 0000000000000000 0000000000000000


bc60: ffff8000f70d8c18 ffff8000f70d8c00 ffff8000f5af81d8 ffff8000f5af834c


bc80: 0000000000000000 ffff8000f5af8360 ffff8000f5af8350 ffff800000a82000


bca0: 7fffffffffffffff ffff8000f5af8230 0000000000000000 00000000ffff9304


bcc0: ffff8000f5a9bd80 ffff8000000aca54 ffff8000f5af8360 ffff8000f735b300


bce0: ffff8000f70d8c18 ffff8000f70d8c00 ffff8000f7245a00 0000000000000000


bd00: 0000000000000000 ffff800000a81c68 ffff8000009ee000 ffff8000f70d8ee0


bd20: ffff8000f5af81e0 ffff800000a81874 ffff8000f5af81e0 ffff800000a82e10


bd40: 7fffffffffffffef 0000000000000000 ffff8000f5a9bcb8 0000000c00000000


bd60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bd80: ffff8000f5a9bdd0 ffff8000000acdb8 ffff8000f735b300 ffff8000f735b330


bda0: ffff8000f70d8c18 ffff8000f70d8c00 ffff8000f5a98000 ffff800000a8178a


bdc0: ffff8000f70d8c18 ffff8000f70d8c90 ffff8000f5a9be30 ffff8000000b2680


bde0: ffff8000f7359840 ffff800000a90f38 ffff8000008b0b88 ffff8000f735b300


be00: ffff8000000acc80 0000000000000000 0000000000000000 0000000000000000


be20: 0000000000000000 0000000000000000 0000000000000000 ffff800000085940


be40: ffff8000000b25a0 ffff8000f7359840 0000000000000000 0000000000000000


be60: 0000000000000000 ffff8000000bc9e0 ffff8000000b25a0 0000000000000000


be80: 0000000000000000 ffff8000f735b300 0000000000000000 0000000000000000


bea0: ffff8000f5a9bea0 ffff8000f5a9bea0 0000000000000000 ffff800000000000


bec0: ffff8000f5a9bec0 ffff8000f5a9bec0 0000000000000000 0000000000000000


bee0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bf00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bf20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bf40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bf60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bf80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bfa0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bfc0: 0000000000000000 0000000000000000 0000000000000000 0000000000000005


bfe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


Call trace:


[<ffff800000216884>] mpage_prepare_extent_to_map+0x23c/0x27c


[<ffff800000219dc0>] ext4_writepages+0x35c/0xa1c


[<ffff80000013eaa4>] do_writepages+0x20/0x44


[<ffff8000001b0a4c>] __writeback_single_inode+0x50/0x2fc


[<ffff8000001b15f4>] writeback_sb_inodes+0x180/0x3a4


[<ffff8000001b18b0>] __writeback_inodes_wb+0x98/0xe0


[<ffff8000001b1b28>] wb_writeback+0x230/0x29c


[<ffff8000001b1fb8>] wb_workfn+0x20c/0x45c


[<ffff8000000aca50>] process_one_work+0x160/0x390


[<ffff8000000acdb4>] worker_thread+0x134/0x450


[<ffff8000000b267c>] kthread+0xdc/0xf4


Code: d4210000 aa1303e0 97fc74c0 17ffffb4 (d4210000) 


---[ end trace bf745ad43e0ca82a ]---


Unable to handle kernel paging request at virtual address ffffffffffffffd8


pgd = ffff8000f533e000


[ffffffffffffffd8] *pgd=00000041f527f003, *pud=00000041f3d08003, *pmd=0000000000000000


Internal error: Oops: 96000004 [#2] SMP


Modules linked in:


CPU: 6 PID: 96 Comm: kworker/u16:4 Tainted: G      D         4.2.0-10637-ga794b4f #125


Hardware name: APM X-Gene Mustang board (DT)


task: ffff8000f5ff6900 ti: ffff8000f5a98000 task.ti: ffff8000f5a98000


PC is at kthread_data+0x4/0xc


LR is at wq_worker_sleeping+0x10/0xc4


pc : [<ffff8000000b2cd8>] lr : [<ffff8000000ad8ec>] pstate: a00003c5


sp : ffff8000f5a9b510


x29: ffff8000f5a9b510 x28: 000000000000000d 


x27: ffff8000f70e8000 x26: ffff8000f65853e0 


x25: 0000000000000006 x24: ffff8000009ef000 


x23: ffff8000007338a0 x22: ffff8000f5ff6d08 


x21: ffff8000fffb8d40 x20: ffff8000f5ff6900 


x19: ffff8000009de000 x18: 0000000000000007 


x17: 000000000000000e x16: 0000000000000001 


x15: 0000000000000007 x14: 000000000000000e 


x13: 0000000000000013 x12: 000000000000001a 


x11: ffff8000f5a9b510 x10: 0000000000000001 


x9 : 0000000000000001 x8 : 0000000000000000 


x7 : 00000000fa83b2da x6 : 0000000000000001 


x5 : 0000000000000001 x4 : 0000000000000013 


x3 : ffffffffff5773cc x2 : 00000000c26d732e 


x1 : 0000000000000006 x0 : 0000000000000000 





Process kworker/u16:4 (pid: 96, stack limit = 0xffff8000f5a98020)


Stack: (0xffff8000f5a9b510 to 0xffff8000f5a9c000)


b500:                                   ffff8000f5a9b530 ffff80000073360c


b520: ffff8000f5a9b530 00000006007334b0 ffff8000f5a9b580 ffff8000007338a0


b540: ffff8000f5a98000 ffff8000f5a9b2e0 ffff8000f5a9b610 ffff8000f5ff6bf8


b560: ffff8000009ee000 0000000000000001 0000000000000000 ffff8000f5ff6bf8


b580: ffff8000f5a9b5a0 ffff800000099b74 ffff8000f5ff6900 0000000000000001


b5a0: ffff8000f5a9b620 ffff80000008948c ffff800000a8f000 0000000000000001


b5c0: ffff8000008ace90 ffff8000f5a9b770 ffff8000f5a98000 ffff8000f5ff6900


b5e0: 0000000000000000 ffff8000f65853e0 0000000000000000 000000000000000d


b600: ffff800000a8f000 ffff800000a01350 ffff8000f5a9b610 ffff8000f5a9b610


b620: ffff8000f5a9b660 ffff8000000894e4 ffff8000f5a9b770 ffff800000a781f8


b640: 0000ffff8dfbb008 ffff8000f5a9b770 0000000060000145 000000000000003d


b660: ffff8000f5a9b680 ffff80000008953c ffff800000a8f000 ffff80000040a3cc


b680: ffff8000f5a9b690 ffff8000000839cc ffff8000f5a9b6c0 ffff800000082398


b6a0: 00000000f2000800 0000000000000001 ffff8000f5a9b770 f2000800f64e00f0


b6c0: ffff8000f5a9b890 ffff8000000853f4 ffff7c00c4209080 ffff8000f5a9ba50


b6e0: ffff8000f5a9b890 ffff800000216884 0000000000000001 ffff800000a43f68


b700: ffff8000f5a9b740 ffff800000414aac ffff8000f5af8000 0000000000000000


b720: ffff8000f5a9bbc0 0000000000000003 ffff7c00c7cae000 ffff800000414a4c


b740: ffff8000f5a9b790 ffff800000411b60 ffff8000f2c91f00 ffff8000f5a98000


b760: 0000000000000021 00000000f0000000 000000000032023d ffff7c00c4209080


b780: 000000000032023d 000000000000000a 0000000000000001 0000000000000000


b7a0: 0000000000000002 0000000000000040 0000000000000100 0000000000000220


b7c0: 0000000000000040 ffff8000f657fd98 0000000000000000 0000000000000000


b7e0: 0ffffffffffffffe 0000ffff8e315000 0000ffff8e315000 0000ffff8e2fc8d0


b800: 0000ffffe4edc7a0 ffff7c00c4209080 ffff8000f5a9ba50 ffff8000f5a9b918


b820: ffff8000f5a9b918 0000000000003400 ffffffffffffffff 0000000000000000


b840: ffff8000f65853e0 0000000000000000 000000000000000d ffff8000f5a9b890


b860: ffff80000021674c ffff8000f5a9b890 ffff800000216884 0000000060000145


b880: ffff8000f6585290 0000000000000000 ffff8000f5a9b980 ffff800000219dc4


b8a0: ffff8000f6585290 ffff8000f5a9bb98 0000000000000000 ffff8000f65853e0


b8c0: ffff8000f5a9bb98 ffff8000009ee000 ffff8000f6664000 ffff8000f56c7000


b8e0: 0000000000003400 0000000000000000 0000000000000008 000000000000000b


b900: 0000000000000001 0000000000000000 ffff7c00c4209080 ffff8000f56c7000


b920: 0000000000003400 ffff800000241f0c ffff8000f5a9b980 ffff800000219d94


b940: ffff8000f6585290 ffff8000f5a9bb98 0000000000000000 ffff8000f65853e0


b960: ffff800000a82000 ffff8000009ee000 ffff8000f65853e0 0000000100219afc


b980: ffff8000f5a9bab0 ffff80000013eaa8 ffff8000f6585290 ffff8000f5af81d8


b9a0: ffff8000f5a9bb98 0000000000003400 ffff800000a82000 ffff8000009ee000


b9c0: ffff8000f65853e0 0000000000000807 ffff8000f5a9bd40 ffff8000f5af8200


b9e0: ffff800000754d40 ffff8000008ca290 0000000100000008 ffffffffffffffff


ba00: 0000000000000000 0000000000000001 ffff800000755088 0000000000000000


ba20: ffff8000f5a9bd40 ffff8000f5af8200 ffff8000f5a9ba70 ffff8000008fe2c0


ba40: ffff8000f5a9ba60 ffff8000004110a8 ffff8000f6585290 ffff8000f5a9bb98


ba60: 000000000000000a 000000000000000b ffffffffffffffff ffff8000001b0bcc


ba80: 00000000f65b3888 0000000000000007 ffff8000f5a9bb98 0000000000000000


baa0: ffff8000f650c000 ffff800000414cc4 ffff8000f5a9bac0 ffff8000001b0a50


bac0: ffff8000f5a9bb10 ffff8000001b15f8 ffff8000f6585378 ffff8000f5af81d8


bae0: ffff8000f56c6800 ffff8000f6585290 0000000000000006 ffff8000009ee000


bb00: ffff8000f5af8230 0000000000000807 ffff8000f5a9bbf0 ffff8000001b18b4


bb20: ffff8000f56c6800 ffff8000f5af81d8 ffff8000f5af8200 0000000000000011


bb40: ffff8000f5a9bd40 00000000ffff930e ffff8000009ee000 ffff8000f65d43b0


bb60: ffff8000f5af8350 ffff800000a08be0 0000000000003400 ffff8000f6585310


bb80: ffff800000a82e10 00000000ffff9304 ffff8000f5a9bc10 0000000000003400


bba0: 0000000000000000 0000000000000000 7fffffffffffffff 0000001200000000


bbc0: ffff8000f5a9bbc0 ffff8000f5a9bbc0 ffff8000f5a9bbd0 ffff8000f5a9bbd0


bbe0: ffff8000f5a9bbe0 ffff8000f5a9bbe0 ffff8000f5a9bc40 ffff8000001b1b2c


bc00: ffff8000f5a9bd40 ffff8000f5af81d8 ffff8000f5af8188 ffff800000a82e10


bc20: ffff8000f5af81d8 000000000000000a ffff8000f5af8350 00000000ffff9304


bc40: ffff8000f5a9bcc0 ffff8000001b1fbc 0000000000000000 0000000000000000


bc60: ffff8000f70d8c18 ffff8000f70d8c00 ffff8000f5af81d8 ffff8000f5af834c


bc80: 0000000000000000 ffff8000f5af8360 ffff8000f5af8350 ffff800000a82000


bca0: 7fffffffffffffff ffff8000f5af8230 0000000000000000 00000000ffff9304


bcc0: ffff8000f5a9bd80 ffff8000000aca54 ffff8000f5af8360 ffff8000f735b300


bce0: ffff8000f70d8c18 ffff8000f70d8c00 ffff8000f7245a00 0000000000000000


bd00: 0000000000000000 ffff800000a81c68 ffff8000009ee000 ffff8000f70d8ee0


bd20: ffff8000f5af81e0 ffff800000a81874 ffff8000f5af81e0 ffff800000a82e10


bd40: 7fffffffffffffef 0000000000000000 ffff8000f5a9bcb8 0000000c00000000


bd60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bd80: ffff8000f5a9bdd0 ffff8000000acdb8 ffff8000f735b300 ffff8000f735b330


bda0: ffff8000f70d8c18 ffff8000f70d8c00 ffff8000f5a98000 ffff800000a8178a


bdc0: ffff8000f70d8c18 ffff8000f70d8c90 ffff8000f5a9be30 ffff8000000b2680


bde0: ffff8000f7359840 ffff800000a90f38 ffff8000008b0b88 ffff8000f735b300


be00: ffff8000000acc80 0000000000000000 0000000000000000 0000000000000000


be20: 0000000000000000 0000000000000000 0000000000000000 ffff800000085940


be40: ffff8000000b25a0 ffff8000f7359840 0000000000000000 0000000000000000


be60: 0000000000000000 ffff8000000bc9e0 ffff8000000b25a0 0000000000000000


be80: 0000000000000000 ffff8000f735b300 0000000000000000 0000000000000000


bea0: ffff8000f5a9bea0 ffff8000f5a9bea0 0000000000000001 ffff800000010001


bec0: ffff8000f5a9bec0 ffff8000f5a9bec0 0000000000000000 0000000000000000


bee0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bf00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bf20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bf40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bf60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bf80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bfa0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


bfc0: 0000000000000000 0000000000000000 0000000000000000 0000000000000005


bfe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000


Call trace:


[<ffff8000000b2cd8>] kthread_data+0x4/0xc


[<ffff800000733608>] __schedule+0x3b4/0x618


[<ffff80000073389c>] schedule+0x30/0x8c


[<ffff800000099b70>] do_exit+0x5b8/0x8c0


[<ffff800000089488>] die+0x1ac/0x1c8


[<ffff8000000894e0>] bug_handler.part.4+0x3c/0x7c


[<ffff800000089538>] bug_handler+0x18/0x2c


[<ffff8000000839c8>] brk_handler+0x9c/0xe0


[<ffff800000082394>] do_debug_exception+0x38/0xa8


Exception stack(0xffff8000f5a9b6d0 to 0xffff8000f5a9b7f0)


b6c0:                                   ffff7c00c4209080 ffff8000f5a9ba50


b6e0: ffff8000f5a9b890 ffff800000216884 0000000000000001 ffff800000a43f68


b700: ffff8000f5a9b740 ffff800000414aac ffff8000f5af8000 0000000000000000


b720: ffff8000f5a9bbc0 0000000000000003 ffff7c00c7cae000 ffff800000414a4c


b740: ffff8000f5a9b790 ffff800000411b60 ffff8000f2c91f00 ffff8000f5a98000


b760: 0000000000000021 00000000f0000000 000000000032023d ffff7c00c4209080


b780: 000000000032023d 000000000000000a 0000000000000001 0000000000000000


b7a0: 0000000000000002 0000000000000040 0000000000000100 0000000000000220


b7c0: 0000000000000040 ffff8000f657fd98 0000000000000000 0000000000000000


b7e0: 0ffffffffffffffe 0000ffff8e315000


[<ffff8000000853f0>] el1_dbg+0x14/0x6c


[<ffff800000219dc0>] ext4_writepages+0x35c/0xa1c


[<ffff80000013eaa4>] do_writepages+0x20/0x44


[<ffff8000001b0a4c>] __writeback_single_inode+0x50/0x2fc


[<ffff8000001b15f4>] writeback_sb_inodes+0x180/0x3a4


[<ffff8000001b18b0>] __writeback_inodes_wb+0x98/0xe0


[<ffff8000001b1b28>] wb_writeback+0x230/0x29c


[<ffff8000001b1fb8>] wb_workfn+0x20c/0x45c


[<[....] Starting MTA:xenbr0: port 1(eth0) entered forwarding state


[....] Starting system message bus: dbusStarting /usr/local/sbin/xenstored...


Setting domain 0 name, domid and JSON config...


[....] Starting OpenBSD Secure Shell server: sshdINFO: rcu_sched detected stalls on CPUs/tasks:


	6: (1 GPs behind) idle=abf/140000000000000/0 softirq=1602/1602 fqs=2094 


	(detected by 1, t=2102 jiffies, g=233, c=232, q=100)


Task dump for CPU 6:


kworker/u16:4   D ffff800000086bd8     0    96      0 0x00000000


Call trace:


[<ffff800000086bd8>] __switch_to+0x5c/0x68


INFO: rcu_bh detected stalls on CPUs/tasks:


	6: (1 GPs behind) idle=abf/140000000000000/0 softirq=0/1602 fqs=2102 


	(detected by 2, t=2102 jiffies, g=-299, c=-300, q=1)


Task dump for CPU 6:


kworker/u16:4   D ffff800000086bd8     0    96      0 0x00000000


Call trace:


[<ffff800000086bd8>] __switch_to+0x5c/0x68


INFO: rcu_sched detected stalls on CPUs/tasks:


	6: (1 GPs behind) idle=abf/140000000000000/0 softirq=1602/1602 fqs=8360 


	(detected by 5, t=8407 jiffies, g=233, c=232, q=228)


Task dump for CPU 6:


kworker/u16:4   D ffff800000086bd8     0    96      0 0x00000000


Call trace:


[<ffff800000086bd8>] __switch_to+0x5c/0x68



On 10/07/15 17:24, Catalin Marinas wrote:
> The ARMv8.1 architecture extensions introduce support for hardware
> updates of the access and dirty information in page table entries. With
> TCR_EL1.HA enabled, when the CPU accesses an address with the PTE_AF bit
> cleared in the page table, instead of raising an access flag fault the
> CPU sets the actual page table entry bit. To ensure that kernel
> modifications to the page tables do not inadvertently revert a change
> introduced by hardware updates, the exclusive monitor (ldxr/stxr) is
> adopted in the pte accessors.
> 
> When TCR_EL1.HD is enabled, a write access to a memory location with the
> DBM (Dirty Bit Management) bit set in the corresponding pte
> automatically clears the read-only bit (AP[2]). Such DBM bit maps onto
> the Linux PTE_WRITE bit and to check whether a writable (DBM set) page
> is dirty, the kernel tests the PTE_RDONLY bit. In order to allow
> read-only and dirty pages, the kernel needs to preserve the software
> dirty bit. The hardware dirty status is transferred to the software
> dirty bit in ptep_set_wrprotect() (using load/store exclusive loop) and
> pte_modify().
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> 
> This patch only covers stage 1 page table support. For stage 2 (KVM),
> talking to Marc Z it seems to be doable but it requires some more
> investigation (basically kvm_set_pfn_{accessed,dirty} would no longer be
> called via the abort path since the hardware toggles the bits
> automatically; we would have to call these functions explicitly via
> kvm_age_hva, kvm_unmap_hva, kvm_mmu_write_protect_pt_masked etc.).
> 
> I did not bother with alternatives for when the hardware feature is not
> present. I don't think there is a noticeable performance impact with
> this patch applied (but, well, benchmarking on a software model isn't
> useful).
> 
>  arch/arm64/Kconfig                     |  17 ++++
>  arch/arm64/include/asm/pgtable-hwdef.h |   3 +
>  arch/arm64/include/asm/pgtable.h       | 147 ++++++++++++++++++++++++++++++++-
>  arch/arm64/mm/proc.S                   |  13 +++
>  4 files changed, 178 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0f6edb14b7e4..20a1a968aecc 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -469,6 +469,23 @@ config ARM64_VA_BITS
>  	default 42 if ARM64_VA_BITS_42
>  	default 48 if ARM64_VA_BITS_48
>  
> +config ARM64_HW_AFDBM
> +	bool "Support for hardware updates of the Access and Dirty page flags"
> +	default y
> +	help
> +	  The ARMv8.1 architecture extensions introduce support for
> +	  hardware updates of the access and dirty information in page
> +	  table entries. When enabled in TCR_EL1 (HA and HD bits) on
> +	  capable processors, accesses to pages with PTE_AF cleared will
> +	  set this bit instead of raising an access flag fault.
> +	  Similarly, writes to read-only pages with the DBM bit set will
> +	  clear the read-only bit (AP[2]) instead of raising a
> +	  permission fault.
> +
> +	  Kernels built with this configuration option enabled continue
> +	  to work on pre-ARMv8.1 hardware and the performance impact is
> +	  minimal. If unsure, say Y.
> +
>  config CPU_BIG_ENDIAN
>         bool "Build big-endian kernel"
>         help
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 59bfae75dc98..24154b055835 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -104,6 +104,7 @@
>  #define PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
>  #define PTE_AF			(_AT(pteval_t, 1) << 10)	/* Access Flag */
>  #define PTE_NG			(_AT(pteval_t, 1) << 11)	/* nG */
> +#define PTE_DBM			(_AT(pteval_t, 1) << 51)	/* Dirty Bit Management */
>  #define PTE_PXN			(_AT(pteval_t, 1) << 53)	/* Privileged XN */
>  #define PTE_UXN			(_AT(pteval_t, 1) << 54)	/* User XN */
>  
> @@ -168,5 +169,7 @@
>  #define TCR_TG1_64K		(UL(3) << 30)
>  #define TCR_ASID16		(UL(1) << 36)
>  #define TCR_TBI0		(UL(1) << 37)
> +#define TCR_HA			(UL(1) << 39)
> +#define TCR_HD			(UL(1) << 40)
>  
>  #endif
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 56283f8a675c..599af27ed84d 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -16,6 +16,7 @@
>  #ifndef __ASM_PGTABLE_H
>  #define __ASM_PGTABLE_H
>  
> +#include <asm/bug.h>
>  #include <asm/proc-fns.h>
>  
>  #include <asm/memory.h>
> @@ -27,7 +28,11 @@
>  #define PTE_VALID		(_AT(pteval_t, 1) << 0)
>  #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
>  #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
> +#ifdef CONFIG_ARM64_HW_AFDBM
> +#define PTE_WRITE		(PTE_DBM)		 /* same as DBM */
> +#else
>  #define PTE_WRITE		(_AT(pteval_t, 1) << 57)
> +#endif
>  #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
>  
>  /*
> @@ -48,6 +53,9 @@
>  #define FIRST_USER_ADDRESS	0UL
>  
>  #ifndef __ASSEMBLY__
> +
> +#include <linux/mmdebug.h>
> +
>  extern void __pte_error(const char *file, int line, unsigned long val);
>  extern void __pmd_error(const char *file, int line, unsigned long val);
>  extern void __pud_error(const char *file, int line, unsigned long val);
> @@ -137,12 +145,20 @@ extern struct page *empty_zero_page;
>   * The following only work if pte_present(). Undefined behaviour otherwise.
>   */
>  #define pte_present(pte)	(!!(pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)))
> -#define pte_dirty(pte)		(!!(pte_val(pte) & PTE_DIRTY))
>  #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
>  #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
>  #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
>  #define pte_exec(pte)		(!(pte_val(pte) & PTE_UXN))
>  
> +#ifdef CONFIG_ARM64_HW_AFDBM
> +#define pte_hw_dirty(pte)	(!(pte_val(pte) & PTE_RDONLY))
> +#else
> +#define pte_hw_dirty(pte)	(0)
> +#endif
> +#define pte_sw_dirty(pte)	(!!(pte_val(pte) & PTE_DIRTY))
> +#define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
> +
> +#define pte_valid(pte)		(!!(pte_val(pte) && PTE_VALID))
>  #define pte_valid_user(pte) \
>  	((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER))
>  #define pte_valid_not_user(pte) \
> @@ -209,20 +225,49 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
>  	}
>  }
>  
> +struct mm_struct;
> +struct vm_area_struct;
> +
>  extern void __sync_icache_dcache(pte_t pteval, unsigned long addr);
>  
> +/*
> + * PTE bits configuration in the presence of hardware Dirty Bit Management
> + * (PTE_WRITE == PTE_DBM):
> + *
> + * Dirty  Writable | PTE_RDONLY  PTE_WRITE  PTE_DIRTY (sw)
> + *   0      0      |   1           0          0
> + *   0      1      |   1           1          0
> + *   1      0      |   1           0          1
> + *   1      1      |   0           1          x
> + *
> + * When hardware DBM is not present, the sofware PTE_DIRTY bit is updated via
> + * the page fault mechanism. Checking the dirty status of a pte becomes:
> + *
> + *   PTE_DIRTY || !PTE_RDONLY
> + */
>  static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  			      pte_t *ptep, pte_t pte)
>  {
>  	if (pte_valid_user(pte)) {
>  		if (!pte_special(pte) && pte_exec(pte))
>  			__sync_icache_dcache(pte, addr);
> -		if (pte_dirty(pte) && pte_write(pte))
> +		if (pte_sw_dirty(pte) && pte_write(pte))
>  			pte_val(pte) &= ~PTE_RDONLY;
>  		else
>  			pte_val(pte) |= PTE_RDONLY;
>  	}
>  
> +	/*
> +	 * If the existing pte is valid, check for potential race with
> +	 * hardware updates of the pte (ptep_set_access_flags safely changes
> +	 * valid ptes without going through an invalid entry).
> +	 */
> +	if (IS_ENABLED(CONFIG_DEBUG_VM) && IS_ENABLED(CONFIG_ARM64_HW_AFDBM) &&
> +	    pte_valid(*ptep)) {
> +		BUG_ON(!pte_young(pte));
> +		BUG_ON(pte_write(*ptep) && !pte_dirty(pte));
> +	}
> +
>  	set_pte(ptep, pte);
>  }
>  
> @@ -461,6 +506,9 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  {
>  	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
>  			      PTE_PROT_NONE | PTE_WRITE | PTE_TYPE_MASK;
> +	/* preserve the hardware dirty information */
> +	if (pte_hw_dirty(pte))
> +		newprot |= PTE_DIRTY;
>  	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
>  	return pte;
>  }
> @@ -470,6 +518,101 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>  	return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
>  }
>  
> +#ifdef CONFIG_ARM64_HW_AFDBM
> +/*
> + * Atomic pte/pmd modifications.
> + */
> +#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
> +static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
> +					    unsigned long address,
> +					    pte_t *ptep)
> +{
> +	pteval_t pteval;
> +	unsigned int tmp, res;
> +
> +	asm volatile("//	ptep_test_and_clear_young\n"
> +	"	prfm	pstl1strm, %2\n"
> +	"1:	ldxr	%0, %2\n"
> +	"	ubfx	%w3, %w0, %5, #1	// extract PTE_AF (young)\n"
> +	"	and	%0, %0, %4		// clear PTE_AF\n"
> +	"	stxr	%w1, %0, %2\n"
> +	"	cbnz	%w1, 1b\n"
> +	: "=&r" (pteval), "=&r" (tmp), "+Q" (pte_val(*ptep)), "=&r" (res)
> +	: "L" (~PTE_AF), "I" (ilog2(PTE_AF)));
> +
> +	return res;
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> +static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +					    unsigned long address,
> +					    pmd_t *pmdp)
> +{
> +	return ptep_test_and_clear_young(vma, address, (pte_t *)pmdp);
> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
> +static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> +				       unsigned long address, pte_t *ptep)
> +{
> +	pteval_t old_pteval;
> +	unsigned int tmp;
> +
> +	asm volatile("//	ptep_get_and_clear\n"
> +	"	prfm	pstl1strm, %2\n"
> +	"1:	ldxr	%0, %2\n"
> +	"	stxr	%w1, xzr, %2\n"
> +	"	cbnz	%w1, 1b\n"
> +	: "=&r" (old_pteval), "=&r" (tmp), "+Q" (pte_val(*ptep)));
> +
> +	return __pte(old_pteval);
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define __HAVE_ARCH_PMDP_GET_AND_CLEAR
> +static inline pmd_t pmdp_get_and_clear(struct mm_struct *mm,
> +				       unsigned long address, pmd_t *pmdp)
> +{
> +	return pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +/*
> + * ptep_set_wrprotect - mark read-only while trasferring potential hardware
> + * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
> + */
> +#define __HAVE_ARCH_PTEP_SET_WRPROTECT
> +static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
> +{
> +	pteval_t pteval;
> +	unsigned long tmp;
> +
> +	asm volatile("//	ptep_set_wrprotect\n"
> +	"	prfm	pstl1strm, %2\n"
> +	"1:	ldxr	%0, %2\n"
> +	"	tst	%0, %4			// check for hw dirty (!PTE_RDONLY)\n"
> +	"	csel	%1, %3, xzr, eq		// set PTE_DIRTY|PTE_RDONLY if dirty\n"
> +	"	orr	%0, %0, %1		// if !dirty, PTE_RDONLY is already set\n"
> +	"	and	%0, %0, %5		// clear PTE_WRITE/PTE_DBM\n"
> +	"	stxr	%w1, %0, %2\n"
> +	"	cbnz	%w1, 1b\n"
> +	: "=&r" (pteval), "=&r" (tmp), "+Q" (pte_val(*ptep))
> +	: "r" (PTE_DIRTY|PTE_RDONLY), "L" (PTE_RDONLY), "L" (~PTE_WRITE)
> +	: "cc");
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define __HAVE_ARCH_PMDP_SET_WRPROTECT
> +static inline void pmdp_set_wrprotect(struct mm_struct *mm,
> +				      unsigned long address, pmd_t *pmdp)
> +{
> +	ptep_set_wrprotect(mm, address, (pte_t *)pmdp);
> +}
> +#endif
> +#endif	/* CONFIG_ARM64_HW_AFDBM */
> +
>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>  extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
>  
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 39139a3aa16d..a8be513dff6f 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -196,6 +196,19 @@ ENTRY(__cpu_setup)
>  	 */
>  	mrs	x9, ID_AA64MMFR0_EL1
>  	bfi	x10, x9, #32, #3
> +#ifdef CONFIG_ARM64_HW_AFDBM
> +	/*
> +	 * Hardware update of the Access and Dirty bits.
> +	 */
> +	mrs	x9, ID_AA64MMFR1_EL1
> +	and	x9, x9, #0xf
> +	cbz	x9, 2f
> +	cmp	x9, #2
> +	b.lt	1f
> +	orr	x10, x10, #TCR_HD		// hardware Dirty flag update
> +1:	orr	x10, x10, #TCR_HA		// hardware Access flag update
> +2:
> +#endif	/* CONFIG_ARM64_HW_AFDBM */
>  	msr	tcr_el1, x10
>  	ret					// return to head.S
>  ENDPROC(__cpu_setup)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Julien Grall
