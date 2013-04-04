From: horms@verge.net.au (Simon Horman)
Date: Thu, 4 Apr 2013 12:54:26 +0900
Subject: [PATCH/RFC 0/2] ARM: shmobile: DT irqpin for r8a7779 and
 marzen-reference
In-Reply-To: <Pine.LNX.4.64.1304031103590.10531@axis700.grange>
References: <Pine.LNX.4.64.1304031103590.10531@axis700.grange>
Message-ID: <20130404035426.GC28297@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 11:18:57AM +0200, Guennadi Liakhovetski wrote:
> Hi
> 
> This 2 patches add DT irqpin support on marzen-reference. Only 
> compile-tested due to the lack of hardware. The patches can go 
> independently via their respective trees. irqpin on marzen will not work 
> if patch 2 is applied before patch 1, but as long as there are no devices, 
> using irqpin interrupts, no breakage will be caused.

I have applied both patches and the dependency I mention below.
I have also applied the small patch, inlined below, to hook-up
the LAN controller. Unfortunately it doesn't seem to be receiving
any interrupts. Perhaps I am missing something?


> 
> Guennadi Liakhovetski (2):
>       irqchip: renesas-intc-irqpin: DT binding for sense bitfield width

The above patch depends on "[1/3] ARM: shmobile: irqpin: fix handling of
spurious interrupts in DT case", right? Has there been any progress in your
discussions with Magnus about what to do about that patch?

>       ARM: shmobile: marzen-reference: add irqpin support in DT

LAN patch:

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index 72be4c8..3d98833 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -38,8 +38,8 @@
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x18000000 0x100>;
 		phy-mode = "mii";
-		interrupt-parent = <&gic>;
-		interrupts = <0 28 0x4>;
+		interrupt-parent = <&irqpin0>;
+		interrupts = <28 0>;
 		reg-io-width = <4>;
 		vddvario-supply = <&fixedregulator3v3>;
 		vdd33a-supply = <&fixedregulator3v3>;


Boot log and /proc/interrupts with LAN patch (version without LAN patch is below):

Booting Linux on physical CPU 0x0
Linux version 3.9.0-rc2-00003-gd779a6cb-dirty (horms at ayumi.isobedori.kobe.vergenet.net) (gcc version 4.5.2 (Sourcery G++ Lite 2011.03-41) ) #1433 SMP Thu Apr 4 12:43:06 JST 2013
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: marzen, model: marzen
debug: ignoring loglevel setting.
Memory policy: ECC disabled, Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c03cdb00, node_mem_map c055a000
  Normal zone: 1520 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 194560 pages, LIFO batch:31
  HighMem zone: 528 pages used for memmap
  HighMem zone: 67584 pages, LIFO batch:15
PERCPU: Embedded 5 pages/cpu @c0d62000 s6848 r0 d13632 u32768
pcpu-alloc: s6848 r0 d13632 u32768 alloc=8*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
Kernel command line: console=ttySC2,115200 earlyprintk=sh-sci.2,115200 ignore_loglevel root=/dev/nfs ip=on
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
__ex_table already sorted, skipping sort
Memory: 1024MB = 1024MB total
Memory: 1035404k/1035404k available, 13172k reserved, 270336K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc0380d20   (3556 kB)
      .init : 0xc0381000 - 0xc03a8ac0   ( 159 kB)
      .data : 0xc03aa000 - 0xc03ce6c0   ( 146 kB)
       .bss : 0xc03ce6c0 - 0xc03f9134   ( 171 kB)
Hierarchical RCU implementation.
NR_IRQS:16 nr_irqs:16 16
sched_clock: 32 bits at 1kHz, resolution 976562ns, wraps every 4194303999ms
Calibrating delay loop (skipped) preset value.. 1000.00 BogoMIPS (lpj=488000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0xc02dc328 - 0xc02dc380
CPU1: Booted secondary processor
CPU2: Booted secondary processor
CPU3: Booted secondary processor
Brought up 4 CPUs
SMP: Total of 4 processors activated (4000.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
sh-pfc pfc-r8a7779: r8a7779_pfc support registered
renesas_intc_irqpin fe78001c.irqpin: driving 4 irqs
------------[ cut here ]------------
WARNING: at kernel/irq/irqdomain.c:766 irq_linear_revmap+0x3c/0x44()
[<c000edc0>] (unwind_backtrace+0x0/0xf8) from [<c0017628>] (warn_slowpath_common+0x50/0x64)
[<c0017628>] (warn_slowpath_common+0x50/0x64) from [<c00176f0>] (warn_slowpath_null+0x1c/0x24)
[<c00176f0>] (warn_slowpath_null+0x1c/0x24) from [<c006356c>] (irq_linear_revmap+0x3c/0x44)
[<c006356c>] (irq_linear_revmap+0x3c/0x44) from [<c0063658>] (irq_create_mapping+0x20/0x118)
[<c0063658>] (irq_create_mapping+0x20/0x118) from [<c00637cc>] (irq_create_of_mapping+0x7c/0x100)
[<c00637cc>] (irq_create_of_mapping+0x7c/0x100) from [<c0224c00>] (irq_of_parse_and_map+0x30/0x38)
[<c0224c00>] (irq_of_parse_and_map+0x30/0x38) from [<c0224c20>] (of_irq_to_resource+0x18/0x74)
[<c0224c20>] (of_irq_to_resource+0x18/0x74) from [<c0224ca0>] (of_irq_count+0x24/0x34)
[<c0224ca0>] (of_irq_count+0x24/0x34) from [<c0225508>] (of_device_alloc+0x1b8/0x248)
[<c0225508>] (of_device_alloc+0x1b8/0x248) from [<c02255d4>] (of_platform_device_create_pdata+0x3c/0x80)
[<c02255d4>] (of_platform_device_create_pdata+0x3c/0x80) from [<c02256ec>] (of_platform_bus_create+0xd4/0x178)
[<c02256ec>] (of_platform_bus_create+0xd4/0x178) from [<c02258cc>] (of_platform_populate+0x60/0x98)
[<c02258cc>] (of_platform_populate+0x60/0x98) from [<c0382854>] (customize_machine+0x20/0x28)
[<c0382854>] (customize_machine+0x20/0x28) from [<c0381834>] (do_one_initcall+0xa0/0x16c)
[<c0381834>] (do_one_initcall+0xa0/0x16c) from [<c0381a2c>] (kernel_init_freeable+0x12c/0x1d0)
[<c0381a2c>] (kernel_init_freeable+0x12c/0x1d0) from [<c02cfd6c>] (kernel_init+0x8/0xe8)
[<c02cfd6c>] (kernel_init+0x8/0xe8) from [<c0009e18>] (ret_from_fork+0x14/0x3c)
---[ end trace a30592ddc9049899 ]---
------------[ cut here ]------------
WARNING: at kernel/irq/irqdomain.c:766 irq_linear_revmap+0x3c/0x44()
[<c000edc0>] (unwind_backtrace+0x0/0xf8) from [<c0017628>] (warn_slowpath_common+0x50/0x64)
[<c0017628>] (warn_slowpath_common+0x50/0x64) from [<c00176f0>] (warn_slowpath_null+0x1c/0x24)
[<c00176f0>] (warn_slowpath_null+0x1c/0x24) from [<c006356c>] (irq_linear_revmap+0x3c/0x44)
[<c006356c>] (irq_linear_revmap+0x3c/0x44) from [<c0063658>] (irq_create_mapping+0x20/0x118)
[<c0063658>] (irq_create_mapping+0x20/0x118) from [<c00637cc>] (irq_create_of_mapping+0x7c/0x100)
[<c00637cc>] (irq_create_of_mapping+0x7c/0x100) from [<c0224c00>] (irq_of_parse_and_map+0x30/0x38)
[<c0224c00>] (irq_of_parse_and_map+0x30/0x38) from [<c0224c20>] (of_irq_to_resource+0x18/0x74)
[<c0224c20>] (of_irq_to_resource+0x18/0x74) from [<c0224d28>] (of_irq_to_resource_table+0x78/0x94)
[<c0224d28>] (of_irq_to_resource_table+0x78/0x94) from [<c02254a4>] (of_device_alloc+0x154/0x248)
[<c02254a4>] (of_device_alloc+0x154/0x248) from [<c02255d4>] (of_platform_device_create_pdata+0x3c/0x80)
[<c02255d4>] (of_platform_device_create_pdata+0x3c/0x80) from [<c02256ec>] (of_platform_bus_create+0xd4/0x178)
[<c02256ec>] (of_platform_bus_create+0xd4/0x178) from [<c02258cc>] (of_platform_populate+0x60/0x98)
[<c02258cc>] (of_platform_populate+0x60/0x98) from [<c0382854>] (customize_machine+0x20/0x28)
[<c0382854>] (customize_machine+0x20/0x28) from [<c0381834>] (do_one_initcall+0xa0/0x16c)
[<c0381834>] (do_one_initcall+0xa0/0x16c) from [<c0381a2c>] (kernel_init_freeable+0x12c/0x1d0)
[<c0381a2c>] (kernel_init_freeable+0x12c/0x1d0) from [<c02cfd6c>] (kernel_init+0x8/0xe8)
[<c02cfd6c>] (kernel_init+0x8/0xe8) from [<c0009e18>] (ret_from_fork+0x14/0x3c)
---[ end trace a30592ddc904989a ]---
No ATAGs?
[<c0229260>] (of_platform_device_create_pdata+0x3c/0x80) from [<c0229378>] (of_platform_bus_create+0xd4/0x178)
[<c0229378>] (of_platform_bus_create+0xd4/0x178) from [<c0229558>] (of_platform_populate+0x60/0x98)
[<c0229558>] (of_platform_populate+0x60/0x98) from [<c0387714>] (customize_machine+0x20/0x28)
[<c0387714>] (customize_machine+0x20/0x28) from [<c0385888>] (do_one_initcall+0xa0/0x16c)
[<c0385888>] (do_one_initcall+0xa0/0x16c) from [<c0385a80>] (kernel_init_freeable+0x12c/0x1d0)
[<c0385a80>] (kernel_init_freeable+0x12c/0x1d0) from [<c02d39f8>] (kernel_init+0x8/0xe8)
[<c02d39f8>] (kernel_init+0x8/0xe8) from [<c0009e98>] (ret_from_fork+0x14/0x3c)
---[ end trace a30592ddc9049899 ]---
------------[ cut here ]------------
WARNING: at kernel/irq/irqdomain.c:766 irq_linear_revmap+0x3c/0x44()
[<c000ee40>] (unwind_backtrace+0x0/0xf8) from [<c0017888>] (warn_slowpath_common+0x50/0x64)
[<c0017888>] (warn_slowpath_common+0x50/0x64) from [<c0017950>] (warn_slowpath_null+0x1c/0x24)
[<c0017950>] (warn_slowpath_null+0x1c/0x24) from [<c00637cc>] (irq_linear_revmap+0x3c/0x44)
[<c00637cc>] (irq_linear_revmap+0x3c/0x44) from [<c00638b8>] (irq_create_mapping+0x20/0x118)
[<c00638b8>] (irq_create_mapping+0x20/0x118) from [<c0063a2c>] (irq_create_of_mapping+0x7c/0x100)
[<c0063a2c>] (irq_create_of_mapping+0x7c/0x100) from [<c022888c>] (irq_of_parse_and_map+0x30/0x38)
[<c022888c>] (irq_of_parse_and_map+0x30/0x38) from [<c02288ac>] (of_irq_to_resource+0x18/0x74)
[<c02288ac>] (of_irq_to_resource+0x18/0x74) from [<c02289b4>] (of_irq_to_resource_table+0x78/0x94)
[<c02289b4>] (of_irq_to_resource_table+0x78/0x94) from [<c0229130>] (of_device_alloc+0x154/0x248)
[<c0229130>] (of_device_alloc+0x154/0x248) from [<c0229260>] (of_platform_device_create_pdata+0x3c/0x80)
[<c0229260>] (of_platform_device_create_pdata+0x3c/0x80) from [<c0229378>] (of_platform_bus_create+0xd4/0x178)
[<c0229378>] (of_platform_bus_create+0xd4/0x178) from [<c0229558>] (of_platform_populate+0x60/0x98)
[<c0229558>] (of_platform_populate+0x60/0x98) from [<c0387714>] (customize_machine+0x20/0x28)
[<c0387714>] (customize_machine+0x20/0x28) from [<c0385888>] (do_one_initcall+0xa0/0x16c)
[<c0385888>] (do_one_initcall+0xa0/0x16c) from [<c0385a80>] (kernel_init_freeable+0x12c/0x1d0)
[<c0385a80>] (kernel_init_freeable+0x12c/0x1d0) from [<c02d39f8>] (kernel_init+0x8/0xe8)
[<c02d39f8>] (kernel_init+0x8/0xe8) from [<c0009e98>] (ret_from_fork+0x14/0x3c)
---[ end trace a30592ddc904989a ]---
No ATAGs?
bio: create slab <bio-0> at 0
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
sh_tmu sh_tmu.0: used for clock events
sh_tmu sh_tmu.0: used for periodic clock events
sh_tmu sh_tmu.1: used as clock source
Switching to clocksource sh_tmu.1
Clockevents: could not switch to one-shot mode:
Clockevents: could not switch to one-shot mode:
Clockevents: could not switch to one-shot mode:
 dummy_timer is not functional.
 dummy_timer is not functional.
Clockevents: could not switch to one-shot mode: dummy_timer is not functional.
 dummy_timer is not functional.
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
bounce pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler deadline registered (default)
gpio_rcar gpio_rcar.0: driving 32 GPIOs
gpio_rcar gpio_rcar.1: driving 32 GPIOs
gpio_rcar gpio_rcar.2: driving 32 GPIOs
gpio_rcar gpio_rcar.3: driving 32 GPIOs
gpio_rcar gpio_rcar.4: driving 32 GPIOs
gpio_rcar gpio_rcar.5: driving 32 GPIOs
gpio_rcar gpio_rcar.6: driving 9 GPIOs
SuperH SCI(F) driver initialized
sh-sci.0: ttySC0 at MMIO 0xffe40000 (irq = 120) is a scif
sh-sci.1: ttySC1 at MMIO 0xffe41000 (irq = 121) is a scif
sh-sci.2: ttySC2 at MMIO 0xffe42000 (irq = 122) is a scif
console [ttySC2] enabled
sh-sci.3: ttySC3 at MMIO 0xffe43000 (irq = 123) is a scif
sh-sci.4: ttySC4 at MMIO 0xffe44000 (irq = 124) is a scif
sh-sci.5: ttySC5 at MMIO 0xffe45000 (irq = 125) is a scif
scsi0 : sata_rcar
ata1: SATA max UDMA/133 irq 132
smsc911x: Driver version 2008-10-21
libphy: smsc911x-mdio: probed
smsc911x 18000000.lan0 eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=18000000.lan0-ff:01, irq=-1)
smsc911x 18000000.lan0 eth0: MAC Address: 2e:09:0a:00:3c:de
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-platform: EHCI generic platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
rcar_thermal ffc48000.thermal: 1 sensor proved
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
ata1: link resume succeeded after 1 retries
ata1: SATA link down (SStatus 0 SControl 300)
smsc911x 18000000.lan0 eth0: ISR failed signaling test (IRQ 257)
IP-Config: Failed to open eth0
IP-Config: No network devices available

Freeing init memory: 2916K


boot (Linux 3.9.0-rc2-00003-gd779a6cb-dirty, BusyBox v1.16.0.git, kexec-tools 2.0.1-git)
/ # 
/ # cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
 59:          0          0          0          0       GIC  fe78001c.irqpin
 60:          0          0          0          0       GIC  fe78001c.irqpin
 61:          0          0          0          0       GIC  fe78001c.irqpin
 62:          0          0          0          0       GIC  fe78001c.irqpin
 64:       8493          0          0          0       GIC  sh_tmu.0
122:         48          0          0          0       GIC  sh-sci.2:mux
132:          0          0          0          0       GIC  sata_rcar
173:          0          0          0          0       GIC  gpio_rcar.0
174:          0          0          0          0       GIC  gpio_rcar.1
175:          0          0          0          0       GIC  gpio_rcar.2
176:          0          0          0          0       GIC  gpio_rcar.3
177:          0          0          0          0       GIC  gpio_rcar.4
178:          0          0          0          0       GIC  gpio_rcar.5
179:          0          0          0          0       GIC  gpio_rcar.6
257:          0          0          0          0  fe78001c.irqpin  eth0
IPI0:          0          0          0          0  CPU wakeup interrupts
IPI1:          0       7869       8493       8487  Timer broadcast interrupts
IPI2:        446        503         73         46  Rescheduling interrupts
IPI3:         21         37         54         56  Function call interrupts
IPI4:          0          0          0          0  Single function call interrupts
IPI5:          0          0          0          0  CPU stop interrupts
Err:          0
/ # 

Boot log and /proc/interrupts with LAN patch (version without LAN patch is below):

Booting Linux on physical CPU 0x0
Linux version 3.9.0-rc2-00003-gd779a6cb (horms at ayumi.isobedori.kobe.vergenet.net) (gcc version 4.5.2 (Sourcery G++ Lite 2011.03-41) ) #1435 SMP Thu Apr 4 12:51:52 JST 2013
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: marzen, model: marzen
debug: ignoring loglevel setting.
Memory policy: ECC disabled, Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c0683b00, node_mem_map c08fb000
  Normal zone: 1520 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 194560 pages, LIFO batch:31
  HighMem zone: 528 pages used for memmap
  HighMem zone: 67584 pages, LIFO batch:15
PERCPU: Embedded 5 pages/cpu @c1103000 s6848 r0 d13632 u32768
pcpu-alloc: s6848 r0 d13632 u32768 alloc=8*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
Kernel command line: console=ttySC2,115200 earlyprintk=sh-sci.2,115200 ignore_loglevel root=/dev/nfs ip=on
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
__ex_table already sorted, skipping sort
Memory: 1024MB = 1024MB total
Memory: 1032628k/1032628k available, 15948k reserved, 270336K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc0384e4c   (3572 kB)
      .init : 0xc0385000 - 0xc065eac0   (2919 kB)
      .data : 0xc0660000 - 0xc06846c0   ( 146 kB)
       .bss : 0xc06846c0 - 0xc06af174   ( 171 kB)
Hierarchical RCU implementation.
NR_IRQS:16 nr_irqs:16 16
sched_clock: 32 bits at 1kHz, resolution 976562ns, wraps every 4194303999ms
Calibrating delay loop (skipped) preset value.. 1000.00 BogoMIPS (lpj=488000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0xc02df328 - 0xc02df380
CPU1: Booted secondary processor
CPU2: Booted secondary processor
CPU3: Booted secondary processor
Brought up 4 CPUs
SMP: Total of 4 processors activated (4000.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
sh-pfc pfc-r8a7779: r8a7779_pfc support registered
renesas_intc_irqpin fe78001c.irqpin: driving 4 irqs
No ATAGs?
bio: create slab <bio-0> at 0
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
sh_tmu sh_tmu.0: used for clock events
sh_tmu sh_tmu.0: used for periodic clock events
sh_tmu sh_tmu.1: used as clock source
Switching to clocksource sh_tmu.1
Clockevents: could not switch to one-shot mode:
Clockevents: could not switch to one-shot mode:
Clockevents: could not switch to one-shot mode:
 dummy_timer is not functional.
 dummy_timer is not functional.
Clockevents: could not switch to one-shot mode: dummy_timer is not functional.
 dummy_timer is not functional.
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
bounce pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler deadline registered (default)
gpio_rcar gpio_rcar.0: driving 32 GPIOs
gpio_rcar gpio_rcar.1: driving 32 GPIOs
gpio_rcar gpio_rcar.2: driving 32 GPIOs
gpio_rcar gpio_rcar.3: driving 32 GPIOs
gpio_rcar gpio_rcar.4: driving 32 GPIOs
gpio_rcar gpio_rcar.5: driving 32 GPIOs
gpio_rcar gpio_rcar.6: driving 9 GPIOs
SuperH SCI(F) driver initialized
sh-sci.0: ttySC0 at MMIO 0xffe40000 (irq = 120) is a scif
sh-sci.1: ttySC1 at MMIO 0xffe41000 (irq = 121) is a scif
sh-sci.2: ttySC2 at MMIO 0xffe42000 (irq = 122) is a scif
console [ttySC2] enabled
sh-sci.3: ttySC3 at MMIO 0xffe43000 (irq = 123) is a scif
sh-sci.4: ttySC4 at MMIO 0xffe44000 (irq = 124) is a scif
sh-sci.5: ttySC5 at MMIO 0xffe45000 (irq = 125) is a scif
scsi0 : sata_rcar
ata1: SATA max UDMA/133 irq 132
smsc911x: Driver version 2008-10-21
genirq: Flags mismatch irq 60. 00000080 (eth%d) vs. 00000000 (fe78001c.irqpin)
smsc911x: probe of 18000000.lan0 failed with error -16
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-platform: EHCI generic platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
rcar_thermal ffc48000.thermal: 1 sensor proved
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
ata1: link resume succeeded after 1 retries
ata1: SATA link down (SStatus 0 SControl 300)
Freeing init memory: 2916K


boot (Linux 3.9.0-rc2-00003-gd779a6cb, BusyBox v1.16.0.git, kexec-tools 2.0.1-git)
/ # cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
 59:          0          0          0          0       GIC  fe78001c.irqpin
 60:          0          0          0          0       GIC  fe78001c.irqpin
 61:          0          0          0          0       GIC  fe78001c.irqpin
 62:          0          0          0          0       GIC  fe78001c.irqpin
 64:      49198          0          0          0       GIC  sh_tmu.0
122:         45          0          0          0       GIC  sh-sci.2:mux
132:          0          0          0          0       GIC  sata_rcar
173:          0          0          0          0       GIC  gpio_rcar.0
174:          0          0          0          0       GIC  gpio_rcar.1
175:          0          0          0          0       GIC  gpio_rcar.2
176:          0          0          0          0       GIC  gpio_rcar.3
177:          0          0          0          0       GIC  gpio_rcar.4
178:          0          0          0          0       GIC  gpio_rcar.5
179:          0          0          0          0       GIC  gpio_rcar.6
IPI0:          0          0          0          0  CPU wakeup interrupts
IPI1:          0      49192      49198      48802  Timer broadcast interrupts
IPI2:        437        478         87         88  Rescheduling interrupts
IPI3:         56         37         36         39  Function call interrupts
IPI4:          0          0          0          0  Single function call interrupts
IPI5:          0          0          0          0  CPU stop interrupts
Err:  
