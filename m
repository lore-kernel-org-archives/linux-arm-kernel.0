From: horms@verge.net.au (Simon Horman)
Date: Mon, 26 Oct 2015 12:20:39 +0900
Subject: Possible Regression due to c074fef5d36e ("of/platform: Defer probes
 of registered devices").
Message-ID: <20151026032039.GA1950@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have observed a possible regression in next-20151022
due to c074fef5d36e ("of/platform: Defer probes of registered devices").

The problem manifests on the r8a7791 based koelsch board.
With the above patch present booting the board using the shmobile_defconfig
results in no console output. While after reverting the above patch
the boot proceeds all the way to user-space.

With DEBUG_LL and EARLY_PRINTK enabled I was able to capture some console
output. I have included both that boot log, and a log of boot all the way to
userspace with the patch in question reverted.

The problem does not seem to manifiest on other boards for other
Renesas ARM  SoCs that I have access too. In particular the
r8a7790 based lager board; the r8a7790 and r8a7791 are both members
of the R-Car Gen2 family of SoCs.





Boot fail to boot to userspace:
  Tree: : next-20151022
  Config: shmobile_defconfig + DEBUG_LL, EARLY_PRINTK
  Modified dts: bootargs = "earlyprintk console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";

Booting Linux on physical CPU 0x0
Linux version 4.3.0-rc6-next-20151022-dirty (horms at ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #189 SMP Mon Oct 26 12:19:34 JST 2015
CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), cr=10c5307d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine model: Koelsch
Ignoring memory block 0x200000000 - 0x240000000
bootconsole [earlycon0] enabled
debug: ignoring loglevel setting.
Memory policy: Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c06c5080, node_mem_map ef7f8000
  Normal zone: 1536 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 196608 pages, LIFO batch:31
  HighMem zone: 65536 pages, LIFO batch:15
PERCPU: Embedded 10 pages/cpu @ef7c0000 s18048 r0 d22912 u40960
pcpu-alloc: s18048 r0 d22912 u40960 alloc=10*4096
pcpu-alloc: [0] 0 [0] 1 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260608
Kernel command line: earlyprintk console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032168K/1048576K available (4996K kernel code, 242K rwdata, 1360K rodata, 300K init, 204K bss, 16408K reserved, 0K cma-reserved, 262144K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc063e04c   (6361 kB)
      .init : 0xc063f000 - 0xc068a000   ( 300 kB)
      .data : 0xc068a000 - 0xc06c6900   ( 243 kB)
       .bss : 0xc06c9000 - 0xc06fc354   ( 205 kB)
Hierarchical RCU implementation.
        Build-time adjustment of leaf fanout to 32.
        RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
NR_IRQS:16 nr_irqs:16 16
Architected cp15 timer(s) running at 10.00MHz (virt).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 4398046511100ns
Switching to timer-based delay loop, resolution 100ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj=100000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: update cpu_capacity 1024
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x40009000 - 0x40009058
Unable to boot CPU1 when MD21 is set
CPU1: failed to boot: -524
Brought up 1 CPUs
SMP: Total of 1 processors activated (20.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
No ATAGs?
hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 8 bytes.
IRQ2 is asserted, installing da9063/da9210 regulator quirk
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
media: Linux media interface: v0.10
Linux video capture interface: v2.00
Advanced Linux Sound Architecture Driver Initialized.
clocksource: Switched to clocksource arch_sys_counter
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
futex hash table entries: 512 (order: 3, 32768 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
bounce: pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
SuperH (H)SCI(F) driver initialized
[drm] Initialized drm 1.1.0 20060810
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
Registering SWP/SWPB emulation handler
bootconsole [earlycon0] disabled





Boot to userspace:
  Tree: : next-20151022 with c074fef5d36e reverted.
  Config: shmobile_defconfig

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 4.3.0-rc6-next-20151022-00001-g4c1ad3d4d4ef (horms at ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #188 SMP Mon Oct 26 12:04:54 JST 2015
CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), cr=10c5307d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine model: Koelsch
Ignoring memory block 0x200000000 - 0x240000000
debug: ignoring loglevel setting.
Memory policy: Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c06c5080, node_mem_map ef7f9000
  Normal zone: 1536 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 196608 pages, LIFO batch:31
  HighMem zone: 65536 pages, LIFO batch:15
PERCPU: Embedded 10 pages/cpu @ef7c1000 s18048 r0 d22912 u40960
pcpu-alloc: s18048 r0 d22912 u40960 alloc=10*4096
pcpu-alloc: [0] 0 [0] 1 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260608
Kernel command line: ignore_loglevel rw root=/dev/nfs ip=dhcp
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032172K/1048576K available (4996K kernel code, 242K rwdata, 1360K rodata, 300K init, 204K bss, 16404K reserved, 0K cma-reserved, 262144K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc063e04c   (6361 kB)
      .init : 0xc063f000 - 0xc068a000   ( 300 kB)
      .data : 0xc068a000 - 0xc06c6900   ( 243 kB)
       .bss : 0xc06c9000 - 0xc06fc354   ( 205 kB)
Hierarchical RCU implementation.
        Build-time adjustment of leaf fanout to 32.
        RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
NR_IRQS:16 nr_irqs:16 16
Architected cp15 timer(s) running at 10.00MHz (virt).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 4398046511100ns
Switching to timer-based delay loop, resolution 100ns
Console: colour dummy device 80x30
console [tty0] enabled
Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj=100000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: update cpu_capacity 1024
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x40009000 - 0x40009058
Unable to boot CPU1 when MD21 is set
CPU1: failed to boot: -524
Brought up 1 CPUs
SMP: Total of 1 processors activated (20.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
renesas_irqc e61c0000.interrupt-controller: driving 10 irqs
sh-pfc e6060000.pfc: r8a77910_pfc support registered
No ATAGs?
hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 8 bytes.
IRQ2 is asserted, installing da9063/da9210 regulator quirk
gpio-regulator regulator at 1: Could not obtain regulator setting GPIOs: -517
gpio-regulator regulator at 3: Could not obtain regulator setting GPIOs: -517
gpio-regulator regulator at 5: Could not obtain regulator setting GPIOs: -517
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
i2c 6-0058: Masking da9063 interrupt sources
i2c 6-0068: Masking da9210 interrupt sources
i2c 6-0068: IRQ2 is not asserted, removing quirk
i2c-sh_mobile e60b0000.i2c: I2C adapter 6, bus speed 100000 Hz
media: Linux media interface: v0.10
Linux video capture interface: v2.00
Couldn't find a device for node '/clocks/mstp1_clks at e6150134'
Couldn't find a device for node '/clocks/mstp1_clks at e6150134'
sh_cmt ffca0000.timer: ch0: used for clock events
sh_cmt ffca0000.timer: ch1: used as clock source
clocksource: ffca0000.timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000000 ns
Advanced Linux Sound Architecture Driver Initialized.
clocksource: Switched to clocksource arch_sys_counter
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
futex hash table entries: 512 (order: 3, 32768 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
bounce: pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
gpio_rcar e6050000.gpio: driving 32 GPIOs
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
gpio_rcar e6051000.gpio: driving 32 GPIOs
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
gpio_rcar e6052000.gpio: driving 32 GPIOs
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
gpio_rcar e6053000.gpio: driving 32 GPIOs
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
gpio_rcar e6054000.gpio: driving 32 GPIOs
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
gpio_rcar e6055000.gpio: driving 32 GPIOs
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
gpio_rcar e6055400.gpio: driving 32 GPIOs
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
gpio_rcar e6055800.gpio: driving 26 GPIOs
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
pci 0000:00:01.0: supports D1 D2
pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
pci 0000:00:02.0: supports D1 D2
pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
PCI: bus0: Fast back to back transfers disabled
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
pci 0000:00:01.0: enabling device (0140 -> 0142)
pci 0000:00:02.0: enabling device (0140 -> 0142)
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
pci-rcar-gen2 ee0d0000.pci: PCI: bus0 revision 11
pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
pci_bus 0001:01: root bus resource [io  0xee0c0000-0xee0c10ff]
pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0c10ff]
pci_bus 0001:01: No busn resource found for root bus, will use [bus 01-ff]
pci 0001:01:00.0: [1033:0000] type 00 class 0x060000
pci 0001:01:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
pci 0001:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310
pci 0001:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
pci 0001:01:01.0: supports D1 D2
pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320
pci 0001:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
pci 0001:01:02.0: supports D1 D2
pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
PCI: bus1: Fast back to back transfers disabled
pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
pci 0001:01:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
pci 0001:01:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
pci 0001:01:01.0: enabling device (0140 -> 0142)
pci 0001:01:02.0: enabling device (0140 -> 0142)
Couldn't find a device for node '/clocks/mstp3_clks at e615013c'
Couldn't find a device for node '/clocks/mstp3_clks at e615013c'
Couldn't find a device for node '/clocks/pcie_bus_clk'
rcar-pcie fe000000.pcie: PCIe link down
Couldn't find a device for node '/clocks/mstp2_clks at e6150138'
Couldn't find a device for node '/clocks/mstp2_clks at e6150138'
Couldn't find a device for node '/clocks/mstp5_clks at e6150144'
Couldn't find a device for node '/clocks/mstp5_clks at e6150144'
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
SuperH (H)SCI(F) driver initialized
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
e6e60000.serial: ttySC0 at MMIO 0xe6e60000 (irq = 109, base_baud = 0) is a scif
console [ttySC0] enabled
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
e6e68000.serial: ttySC1 at MMIO 0xe6e68000 (irq = 110, base_baud = 0) is a scif
[drm] Initialized drm 1.1.0 20060810
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
da9063 6-0058: Device detected (chip-ID: 0x61, var-ID: 0x30)
Couldn't find a device for node '/clocks/mstp8_clks at e6150990'
Couldn't find a device for node '/clocks/mstp8_clks at e6150990'
scsi host0: sata_rcar
ata1: SATA max UDMA/133 irq 112
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
renesas_spi e6b10000.spi: DMA available
m25p80 spi0.0: unrecognized JEDEC id bytes: 01,  2, 20
renesas_spi e6b10000.spi: probed
Couldn't find a device for node '/clocks/mstp0_clks at e6150130'
Couldn't find a device for node '/clocks/mstp0_clks at e6150130'
spi_sh_msiof e6e20000.spi: DMA available
Couldn't find a device for node '/clocks/mstp8_clks at e6150990'
libphy: sh_mii: probed
sh-eth ee700000.ethernet eth0: Base address at 0xee700000, 2e:09:0a:00:6d:00, IRQ 111.
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-pci 0000:00:02.0: EHCI Host Controller
ehci-pci 0000:00:02.0: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:02.0: irq 123, io mem 0xee081000
ehci-pci 0000:00:02.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ehci-pci 0001:01:02.0: EHCI Host Controller
ehci-pci 0001:01:02.0: new USB bus registered, assigned bus number 2
ehci-pci 0001:01:02.0: irq 124, io mem 0xee0c1000
ehci-pci 0001:01:02.0: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-pci 0000:00:01.0: OHCI PCI host controller
ohci-pci 0000:00:01.0: new USB bus registered, assigned bus number 3
ohci-pci 0000:00:01.0: irq 123, io mem 0xee080000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 1 port detected
ohci-pci 0001:01:01.0: OHCI PCI host controller
ohci-pci 0001:01:01.0: new USB bus registered, assigned bus number 4
ohci-pci 0001:01:01.0: irq 124, io mem 0xee0c0000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 1 port detected
sh-pfc e6060000.pfc: pin GP_7_23 already requested by ee090000.pci; cannot claim for e6590000.usb
sh-pfc e6060000.pfc: pin-247 (e6590000.usb) status -22
sh-pfc e6060000.pfc: could not request pin 247 (GP_7_23) from group usb0  on device sh-pfc
renesas_usbhs e6590000.usb: Error applying setting, reverse things back
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
renesas_usbhs e6590000.usb: transceiver found
renesas_usbhs e6590000.usb: gadget probed
phy phy-e6590100.usb-phy.1: phy init failed --> -16
renesas_usbhs e6590000.usb: probed
using random self ethernet address
using random host ethernet address
usb0: HOST MAC f6:6e:8b:ce:92:82
usb0: MAC fe:cf:36:fc:5b:75
using random self ethernet address
using random host ethernet address
g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
g_ether gadget: g_ether ready
renesas_usbhs e6590000.usb: fifo select error
ata1: link resume succeeded after 1 retries
mousedev: PS/2 mouse device common for all mice
i2c /dev entries driver
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
at24 2-0050: 256 byte 24c02 EEPROM, writable, 16 bytes/write
i2c-rcar e6530000.i2c: probed
adv7180 2-0020: chip found @ 0x20 (e6530000.i2c)
Couldn't find a device for node '/clocks/mstp8_clks at e6150990'
soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
Couldn't find a device for node '/clocks/mstp1_clks at e6150134'
Couldn't find a device for node '/clocks/mstp1_clks at e6150134'
Couldn't find a device for node '/clocks/mstp1_clks at e6150134'
Couldn't find a device for node '/clocks/mstp1_clks at e6150134'
Couldn't find a device for node '/clocks/mstp1_clks at e6150134'
Couldn't find a device for node '/clocks/mstp1_clks at e6150134'
ata1: SATA link down (SStatus 0 SControl 300)
Couldn't find a device for node '/clocks/mstp5_clks at e6150144'
rcar_thermal e61f0000.thermal: 1 sensor probed
Couldn't find a device for node '/clocks/mstp3_clks at e615013c'
Couldn't find a device for node '/clocks/mstp3_clks at e615013c'
sh_mobile_sdhi ee100000.sd: Got CD GPIO
sh_mobile_sdhi ee100000.sd: Got WP GPIO
sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 97 MHz
Couldn't find a device for node '/clocks/mstp3_clks at e615013c'
Couldn't find a device for node '/clocks/mstp3_clks at e615013c'
sh_mobile_sdhi ee140000.sd: Got CD GPIO
sh_mobile_sdhi ee140000.sd: Got WP GPIO
sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 clock rate 48 MHz
Couldn't find a device for node '/clocks/mstp3_clks at e615013c'
Couldn't find a device for node '/clocks/mstp3_clks at e615013c'
sh_mobile_sdhi ee160000.sd: Got CD GPIO
sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 clock rate 48 MHz
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
Couldn't find a device for node '/clocks/audio_clk_a'
Couldn't find a device for node '/clocks/audio_clk_b'
Couldn't find a device for node '/clocks/audio_clk_c'
Couldn't find a device for node '/clocks/m2_clk'
rcar_sound ec500000.sound: probed
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
Couldn't find a device for node '/clocks/cpg_clocks at e6150000'
Couldn't find a device for node '/clocks/cpg_clocks at e6150000'
cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 1300000 KHz
cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed to: 1312500 KHz
Registering SWP/SWPB emulation handler
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
asoc-simple-card sound: ak4642-hifi <-> ec500000.sound mapping ok
mmc2: new high speed SDHC card at address b368
mmcblk0: mmc2:b368 SD08G 7.41 GiB 
 mmcblk0: p1
random: nonblocking pool is initialized
i2c-rcar e6530000.i2c: error -110 : 0
i2c-rcar e6530000.i2c: error -16 : 0
i2c-rcar e6530000.i2c: error -16 : 0
i2c-rcar e6530000.i2c: error -16 : 0
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
input: keyboard as /devices/platform/keyboard/input/input0
hctosys: unable to open rtc device (rtc0)
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
sh-eth ee700000.ethernet eth0: attached PHY 1 (IRQ 408) to driver Micrel KSZ8041RNLI
IPv6: ADDRCONF(NETDEV_UP): usb0: link is not ready
Sending DHCP requests .
sh-eth ee700000.ethernet eth0: Link is Up - 100Mbps/Full - flow control off
., OK
IP-Config: Got DHCP answer from 10.3.3.2, my address is 10.3.3.159
IP-Config: Complete:
     device=eth0, hwaddr=2e:09:0a:00:6d:00, ipaddr=10.3.3.159, mask=255.255.255.0, gw=10.3.3.2
     host=10.3.3.159, domain=isobedori.kobe.vergenet.net kanocho.kobe.vergenet.net vergenet., nis-domain=(none)
     bootserver=10.3.3.135, rootserver=10.3.3.135, rootpath=/srv/nfs/koelsch-armhf,rsize=1024,wsize=1024
     nameserver0=10.3.3.2, nameserver1=8.8.8.8
SDHI0 Vcc: disabling
SDHI0 VccQ: disabling
SDHI1 Vcc: disabling
SDHI1 VccQ: disabling
ALSA device list:
  #0: rsnd-dai.0-ak4642-hifi
VFS: Mounted root (nfs filesystem) on device 0:13.
devtmpfs: mounted
Freeing unused kernel memory: 300K (c063f000 - c068a000)
INIT: version 2.88 booting
Using makefile-style concurrent boot in runlevel S.
Starting the hotplug events dispatcher: udevdudevd[921]: starting version 175
.
Synthesizing the initial hotplug events...done.
i2c-rcar e6530000.i2c: error -16 : 0
Waiting for /dev to be fully populated...done.
Activating swap...done.
Activating lvm and md swap...done.
Checking file systems...fsck from util-linux 2.20.1
done.
Mounting local filesystems...done.
Activating swapfile swap...done.
Cleaning up temporary files....
Cleaning up ifupdown....
Setting up networking....
Configuring network interfaces...Internet Systems Consortium DHCP Client 4.2.2
Copyright 2004-2011 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth0/2e:09:0a:00:6d:00
Sending on   LPF/eth0/2e:09:0a:00:6d:00
Sending on   Socket/fallback
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPACK from 10.3.3.2
RTNETLINK answers: File exists
bound to 10.3.3.159 -- renewal in 280 seconds.
done.
Cleaning up temporary files....
Setting up ALSA...warning: 'alsactl restore' failed with error message 'No state is present for card rsnddai0ak4642h
Found hardware: "rsnd-dai_0-ak46" "" "" "" ""
Hardware is initialized using a generic method
No state is present for card rsnddai0ak4642h'...i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
i2c-rcar e6530000.i2c: error -16 : 0
amixer: Mixer hw:0 load error: Device or resource busy
done.
Setting kernel variables ...done.
INIT: Entering runlevel: 2
Using makefile-style concurrent boot in runlevel 2.
Starting enhanced syslogd: rsyslogd.
Starting periodic command scheduler: cron.
Starting system message bus: dbus.
Starting OpenBSD Secure Shell server: sshd.
---
Testing QSPI performance. Expect 1MB/s or more
dd: opening `/dev/mtd0': No such file or directory
da39a3ee5e6b4b0d3255bfef95601890afd80709  -
---
Testing CPU freq. Expect two or three different frequencies
1500000
1500000
750000
---

Debian GNU/Linux wheezy/sid debian ttySC0

debian login: 
