From: horms@verge.net.au (Simon Horman)
Date: Fri, 3 Jul 2015 11:40:44 +0900
Subject: Possible regression due to "tick: broadcast: Prevent livelock from
 event handler"
Message-ID: <20150703024044.GB24695@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

I have observed what appears to be a regression while testing next-20150702
which seems to be caused by 2951d5c031a3 ("tick: broadcast: Prevent
livelock from event handler").

The problem manifests on the emev2/kzm9d board as per the boot log below.

The problem manifests when booting using the shmobile_defconfig,
which uses multiplatform and enables all devices using DT.

The problem does not appear to always manifest but anecdotally it
seems to manifest more often of late (yes, I know that is vague).

This problem was reported to me by Geert Uytterhoeven.
Kevin Hillman has also reported problems reliably booting the emev2/kzm9d board.


Please note that in order to boot 2951d5c031a3 on the emev2/kzm9d board
using the shmobile_defconfig the following is required:
6b442bc81337 ("nohz: Fix !HIGH_RES_TIMERS hang").


Booting Linux on physical CPU 0x0
Linux version 4.1.0-next-20150702 (horms at ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #4556 SMP Fri Jul 3 11:31:38 JST 2015
CPU: ARMv7 Processor [411fc093] revision 3 (ARMv7), cr=10c5307d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: EMEV2 KZM9D Board
debug: ignoring loglevel setting.
Memory policy: Data cache writealloc
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c0817500, node_mem_map c7ef9000
  Normal zone: 256 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 32768 pages, LIFO batch:7
PERCPU: Embedded 9 pages/cpu @c7ee0000 s13824 r0 d23040 u36864
pcpu-alloc: s13824 r0 d23040 u36864 alloc=9*4096
pcpu-alloc: [0] 0 [0] 1 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 121328K/131072K available (4888K kernel code, 283K rwdata, 1352K rodata, 1728K init, 204K bss, 9744K reserved, 0K cma-reserved, 0K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc0621044   (6245 kB)
      .init : 0xc0622000 - 0xc07d2000   (1728 kB)
      .data : 0xc07d2000 - 0xc0818e40   ( 284 kB)
       .bss : 0xc081b000 - 0xc084e24c   ( 205 kB)
Hierarchical RCU implementation.
        Additional per-CPU info printed with stalls.
        Build-time adjustment of leaf fanout to 32.
        RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
NR_IRQS:16 nr_irqs:16 16
clocksource_of_init: no matching clocksources found
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped) preset value.. 355.33 BogoMIPS (lpj=1776666)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x40009000 - 0x40009058
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
Brought up 2 CPUs
SMP: Total of 2 processors activated (710.66 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 1
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
sh-pfc e0140200.pfc: emev2_pfc support registered
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
em_sti e0180000.timer: used for clock events
em_sti e0180000.timer: used for oneshot clock events
em_sti e0180000.timer: used as clock source
clocksource: e0180000.timer: mask: 0xffffffffffff max_cycles: 0x1ef4687b1, max_idle_ns: 3697658158765000000 ns
Advanced Linux Sound Architecture Driver Initialized.
clocksource: e0180000.timer: mask: 0xffffffffffff max_cycles: 0x1ef4687b1, max_idle_ns: 112843571739654 ns
clocksource: Switched to clocksource e0180000.timer
NET: Registered protocol family 2
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 1024 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
Clockevents: could not switch to one-shot mode: dummy_timer is not functional.
Clockevents: could not switch to one-shot mode: dummy_timer is not functional.
hw perfevents: Failed to parse /pmu/interrupt-affinity[0]
hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
futex hash table entries: 512 (order: 3, 32768 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
jitterentropy: Initialization failed with host not compliant with requirements: 2
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
e1020000.serial: ttyS0 at MMIO 0xe1020000 (irq = 19, base_baud = 796444) is a 16550A
console [ttyS1] disabled
e1030000.serial: ttyS1 at MMIO 0xe1030000 (irq = 20, base_baud = 7168000) is a 16550A
console [ttyS1] enabled
e1040000.serial: ttyS2 at MMIO 0xe1040000 (irq = 21, base_baud = 14336000) is a 16550A
e1050000.serial: ttyS3 at MMIO 0xe1050000 (irq = 22, base_baud = 2389333) is a 16550A
SuperH (H)SCI(F) driver initialized
[drm] Initialized drm 1.1.0 20060810
libphy: smsc911x-mdio: probed
smsc911x 20000000.ethernet eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=20000000.etherne:01, irq=-1)
smsc911x 20000000.ethernet eth0: MAC Address: 00:01:9b:04:03:cf
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
mousedev: PS/2 mouse device common for all mice
i2c /dev entries driver
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
cpu cpu0: failed to get cpu0 clock: -2
cpufreq-dt: probe of cpufreq-dt failed with error -2
Registering SWP/SWPB emulation handler
input: gpio_keys as /devices/platform/gpio_keys/input/input0
hctosys: unable to open rtc device (rtc0)

The boot hangs here.
The next line should be:

smsc911x 20000000.ethernet eth0: SMSC911x/921x identified at 0xc8880000, IRQ: 33
