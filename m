From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Jul 2014 17:54:32 +0900
Subject: [PATCH v5 8/8] ARM: shmobile: genmai-reference: Enable MTU2 in
 device tree
In-Reply-To: <20140710095430.GD2728@katana>
References: <1404911564-17380-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1404911564-17380-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140710095430.GD2728@katana>
Message-ID: <20140715085430.GB17806@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 11:54:30AM +0200, Wolfram Sang wrote:
> On Wed, Jul 09, 2014 at 03:12:44PM +0200, Laurent Pinchart wrote:
> > No more device needs to be added from platform code when booting the
> > reference platform, move MTU2 registration from setup-r7s72100.c to
> > board-genmai.c and remove the now empty r7s72100_add_dt_devices()
> > function.
> > 
> > As the genmai_add_standard_devices() function is now identical to the
> > default init_machine implementation, remove it as well.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Yay, tasty!
> 
> Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>

Hi Laurent,

I am having some trouble with this patch.
In particular the shmobile defconfig with an initrd added
(to compensate for the lack of ethernet and thus NFS) does
not seem to make it to userspace with this patch applied :(

I am dropping it for now, but could you look into it?

For the record it seems to stop right near the end.
A bad boot looks like this:

Booting Linux on physical CPU 0x0
Linux version 3.16.0-rc3-00750-g004c383-dirty (horms at ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #463 SMP Tue Jul 15 16:58:01 JST 2014
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5347d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: Genmai
debug: ignoring loglevel setting.
Memory policy: Data cache writeback
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c071f640, node_mem_map c7ef9000
  Normal zone: 256 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 32768 pages, LIFO batch:7
CPU: All CPU(s) started in SVC mode.
PERCPU: Embedded 5 pages/cpu @c7eea000 s7488 r0 d12992 u32768
pcpu-alloc: s7488 r0 d12992 u32768 alloc=8*4096
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttySC2,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 122388K/131072K available (4327K kernel code, 227K rwdata, 1016K rodata, 1691K init, 197K bss, 8684K reserved, 0K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
    vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc0540fc4   (5348 kB)
      .init : 0xc0541000 - 0xc06e7d40   (1692 kB)
      .data : 0xc06e8000 - 0xc0720dc0   ( 228 kB)
       .bss : 0xc0720dc8 - 0xc07521fc   ( 198 kB)
Hierarchical RCU implementation.
        RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
NR_IRQS:16 nr_irqs:16 16
clocksource_of_init: no matching clocksources found
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836480000000ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped) preset value.. 266.66 BogoMIPS (lpj=1333333)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x84405f8 - 0x8440650
Brought up 1 CPUs
SMP: Total of 1 processors activated.
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
No ATAGs?
hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 4 bytes.
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
media: Linux media interface: v0.10
Linux video capture interface: v2.00
sh_mtu2 fcff0000.timer: ch0: used for clock events
sh_mtu2 fcff0000.timer: ch0: used for periodic clock events
Advanced Linux Sound Architecture Driver Initialized.
NET: Registered protocol family 2
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP: reno registered
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
futex hash table entries: 256 (order: 2, 16384 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
msgmni has been set to 239
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
SuperH (H)SCI(F) driver initialized
e8008000.serial: ttySC2 at MMIO 0xe8008000 (irq = 231, base_baud = 0) is a scif
console [ttySC2] enabled
[drm] Initialized drm 1.1.0 20060810
renesas_spi e800e800.spi: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
mousedev: PS/2 mouse device common for all mice
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)


And a good one looks like this:


Booting Linux on physical CPU 0x0
Linux version 3.16.0-rc3-00751-gd14f001 (horms at ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #461 SMP Tue Jul 15 16:48:13 JST 2014
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5347d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: Genmai
debug: ignoring loglevel setting.
Memory policy: Data cache writeback
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c071f640, node_mem_map c7ef9000
  Normal zone: 256 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 32768 pages, LIFO batch:7
CPU: All CPU(s) started in SVC mode.
PERCPU: Embedded 5 pages/cpu @c7eea000 s7488 r0 d12992 u32768
pcpu-alloc: s7488 r0 d12992 u32768 alloc=8*4096
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttySC2,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 122388K/131072K available (4327K kernel code, 227K rwdata, 1016K rodata, 1691K init, 197K bss, 8684K reserved, 0K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
    vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc0540fc4   (5348 kB)
      .init : 0xc0541000 - 0xc06e7d40   (1692 kB)
      .data : 0xc06e8000 - 0xc0720dc0   ( 228 kB)
       .bss : 0xc0720dc8 - 0xc07521fc   ( 198 kB)
Hierarchical RCU implementation.
        RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
NR_IRQS:16 nr_irqs:16 16
clocksource_of_init: no matching clocksources found
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836480000000ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped) preset value.. 266.66 BogoMIPS (lpj=1333333)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x84405f8 - 0x8440650
Brought up 1 CPUs
SMP: Total of 1 processors activated.
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
No ATAGs?
hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 4 bytes.
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
media: Linux media interface: v0.10
Linux video capture interface: v2.00
sh_mtu2 sh-mtu2: ch0: used for clock events
sh_mtu2 sh-mtu2: ch0: used for periodic clock events
Advanced Linux Sound Architecture Driver Initialized.
NET: Registered protocol family 2
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP: reno registered
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
futex hash table entries: 256 (order: 2, 16384 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
msgmni has been set to 239
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
SuperH (H)SCI(F) driver initialized
e8008000.serial: ttySC2 at MMIO 0xe8008000 (irq = 231, base_baud = 0) is a scif
console [ttySC2] enabled
[drm] Initialized drm 1.1.0 20060810
renesas_spi e800e800.spi: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
mousedev: PS/2 mouse device common for all mice
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
ALSA device list:
  No soundcards found.
Freeing unused kernel memory: 1688K (c0541000 - c06e7000)


boot (Linux 3.16.0-rc3-00751-gd14f001, BusyBox v1.16.0.git, kexec-tools 2.0.1-git)
/ # 
