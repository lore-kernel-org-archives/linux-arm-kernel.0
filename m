From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 30 Jul 2013 21:42:44 +0200
Subject: NSA310 + DT
In-Reply-To: <51F814A0.2050403@uni-bremen.de>
References: <51F6A0DC.3020501@uni-bremen.de>
 <20130729192112.GY29916@titan.lakedaemon.net>
 <20130729204315.GK24782@lunn.ch> <51F78DA6.8010307@uni-bremen.de>
 <20130730144752.GR24782@lunn.ch> <20130730172407.3aab15c6@skate>
 <51F7EBB9.7000504@uni-bremen.de> <20130730191943.49f8070c@skate>
 <20130730183610.GT24782@lunn.ch> <51F814A0.2050403@uni-bremen.de>
Message-ID: <20130730194244.GV24782@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 09:31:44PM +0200, Finn Hoffmann wrote:
> 
> Am 30.07.2013 20:36, schrieb Andrew Lunn:
> >On Tue, Jul 30, 2013 at 07:19:43PM +0200, Thomas Petazzoni wrote:
> >>Dear Finn Hoffmann,
> >>
> >>BTW, any reason why this discussion is not taking place on LAKML ?
> >Ah, sorry, did not look at the CC: list. Now one list...
> >
> >     Andrew
> >
> >>On Tue, 30 Jul 2013 18:37:13 +0200, Finn Hoffmann wrote:
> >>
> >>>$ lspci -v
> >>>00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (prog-if
> >>>00 [Normal decode])
> >>>          Flags: bus master, fast devsel, latency 0
> >>>          Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> >>>          I/O behind bridge: 00010000-00010fff
> >>>          Prefetchable memory behind bridge: e0000000-e00fffff
> >>Ok, so there should be one mem window from e0000000 to e0100000...
> >>
> >>># cat /sys/kernel/debug/mvebu-mbus/devices
> >>>[00] 00000000e8010000 - 00000000e8020000 : pcie0.0 (remap 0000000000010000)
> >>>[01] disabled
> >>>[02] disabled
> >>>[03] disabled
> >>>[04] 00000000f4000000 - 00000000f4010000 : nand
> >>>[05] 00000000f5000000 - 00000000f5010000 : sram
> >>>[06] disabled
> >>>[07] disabled
> >>... but there's none here.
> >>
> >>Seems like your device is using a prefetchable memory window, and our
> >>emulated PCI-to-PCI bridge isn't taking this into account.
> >>
> >>Can you test the below (completely untested) patch? Regardless of
> >>whether it works or not, I'm interested in seeing the "PCI MVEBU"
> >>debug messages that I've added, as well as the output
> >>of /sys/kernel/debug/mvebu-mbus/devices.
> >>
> >>Thanks a lot!
> >>
> >>Thomas
> # cat /sys/kernel/debug/mvebu-mbus/devices
> [00] 00000000e8010000 - 00000000e8020000 : pcie0.0 (remap 0000000000010000)
> [01] disabled
> [02] disabled
> [03] disabled
> [04] 00000000f4000000 - 00000000f4010000 : nand
> [05] 00000000f5000000 - 00000000f5010000 : sram
> [06] 00000000fff00000 - 0000000100000000 : pcie0.0
> [07] disabled
> 
> 
> # lspci -v
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
> (prog-if 00 [Normal decode])
> Flags: bus master, fast devsel, latency 0
> Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> I/O behind bridge: 00010000-00010fff
> Prefetchable memory behind bridge: e0000000-e00fffff
> 
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168B PCI Express Gigabit Ethernet controller (rev
> 03)
> Subsystem: Realtek Semiconductor Co., Ltd. TEG-ECTX Gigabit PCI-E
> Adapter [Trendnet]
> Flags: bus master, fast devsel, latency 0, IRQ 9
> I/O ports at 10000 [size=256]
> Memory at e0014000 (64-bit, prefetchable) [size=4K]
> Memory at e0010000 (64-bit, prefetchable) [size=16K]
> [virtual] Expansion ROM at e0000000 [disabled] [size=64K]
> Capabilities: [40] Power Management version 3
> Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
> Capabilities: [70] Express Endpoint, MSI 01
> Capabilities: [ac] MSI-X: Enable- Count=4 Masked-
> Capabilities: [cc] Vital Product Data
> Capabilities: [100] Advanced Error Reporting
> Capabilities: [140] Virtual Channel
> Capabilities: [160] Device Serial Number 00-00-00-00-00-00-00-00
> Kernel driver in use: r8169
> 
> 
> 
> 
> 3122350 bytes read
> ## Booting image at 00800000 ...
> Image Name: Linux-3.11.0-rc3
> Created: 2013-07-30 18:56:55 UTC
> Image Type: ARM Linux Kernel Image (uncompressed)
> Data Size: 3122286 Bytes = 3 MB
> Load Address: 00008000
> Entry Point: 00008000
> Verifying Checksum ... OK
> OK
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0
> Linux version 3.11.0-rc3 (finn at T400) (gcc version 4.7.3
> (Ubuntu/Linaro 4.7.3-1ubuntu1) ) #2 PREEMPT Tue Jul 30
> 20:56:41 CEST 2013
> CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
> CPU: VIVT data cache, VIVT instruction cache
> Machine: Marvell Kirkwood (Flattened Device Tree), model: ZyXEL NSA310
> Memory policy: ECC disabled, Data cache writeback
> Built 1 zonelists in Zone order, mobility grouping on. Total pages: 65024
> Kernel command line: console=ttyS0,115200 root=/dev/sda2
> PID hash table entries: 1024 (order: 0, 4096 bytes)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 253156K/262144K available (4404K kernel code, 243K rwdata,
> 1216K rodata, 151K init, 615K bss, 8988K reserved)
> Virtual kernel memory layout:
> vector : 0xffff0000 - 0xffff1000 ( 4 kB)
> fixmap : 0xfff00000 - 0xfffe0000 ( 896 kB)
> vmalloc : 0xd0800000 - 0xff000000 ( 744 MB)
> lowmem : 0xc0000000 - 0xd0000000 ( 256 MB)
> modules : 0xbf000000 - 0xc0000000 ( 16 MB)
> .text : 0xc0008000 - 0xc0585248 (5621 kB)
> .init : 0xc0586000 - 0xc05abcc4 ( 152 kB)
> .data : 0xc05ac000 - 0xc05e8fe0 ( 244 kB)
> .bss : 0xc05e8fe0 - 0xc0682d60 ( 616 kB)
> SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> Preemptible hierarchical RCU implementation.
> NR_IRQS:114
> sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474ms
> Console: colour dummy device 80x30
> Calibrating delay loop... 1196.85 BogoMIPS (lpj=5984256)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> Setting up static identity map for 0xc042fe08 - 0xc042fe44
> pinctrl core: initialized pinctrl subsystem
> regulator-dummy: no parameters
> NET: Registered protocol family 16
> DMA: preallocated 256 KiB pool for atomic coherent allocations
> Kirkwood: MV88F6281-A1, TCLK=200000000.
> Feroceon L2: Enabling L2
> Feroceon L2: Cache support initialised.
> bio: create slab <bio-0> at 0
> mvebu-pcie pcie-controller.1: PCIe0.0: link up
> mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io 0x1000-0xfffff]
> pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> pci_bus 0000:00: root bus resource [bus 00-ff]
> PCI: bus0: Fast back to back transfers disabled
> pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> PCI: bus1: Fast back to back transfers disabled
> MVEBU PCI 0.0: new pref mem, base 0xfff0, limit 0xfff0
> MVEBU PCI 0.0: new pref mem, base 0x0, limit 0x0
> mvebu_mbus: cannot add window 'pcie0.0', conflicts with another window

Hi Thomas

That does not look good, does it?

     Andrew

> pci 0000:00:01.0: BAR 9: assigned [mem 0xe0000000-0xe00fffff pref]
> pci 0000:00:01.0: BAR 7: assigned [io 0x10000-0x10fff]
> pci 0000:01:00.0: BAR 6: assigned [mem 0xe0000000-0xe000ffff pref]
> pci 0000:01:00.0: BAR 4: assigned [mem 0xe0010000-0xe0013fff 64bit pref]
> pci 0000:01:00.0: BAR 2: assigned [mem 0xe0014000-0xe0014fff 64bit pref]
> pci 0000:01:00.0: BAR 0: assigned [io 0x10000-0x100ff]
> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:00:01.0: bridge window [io 0x10000-0x10fff]
> MVEBU PCI 0.0: new io, base 0x1, limit 0x1
> MVEBU PCI 0.0: new mem, base 0xfff0, limit 0x0
> pci 0000:00:01.0: bridge window [mem 0xe0000000-0xe00fffff pref]
> MVEBU PCI 0.0: new pref mem, base 0xe000, limit 0xe000
> mvebu_mbus: cannot add window 'pcie0.0', conflicts with another window
> PCI: enabling device 0000:00:01.0 (0140 -> 0143)
> USB Power Off: Failed to request enable GPIO21: -517
> reg-fixed-voltage 1.regulator: Failed to register regulator: -517
> platform 1.regulator: Driver reg-fixed-voltage requests probe deferral
> vgaarb: loaded
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> cfg80211: Calling CRDA to update world regulatory domain
> Switched to clocksource orion_clocksource
> NET: Registered protocol family 2
> TCP established hash table entries: 2048 (order: 2, 16384 bytes)
> TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> TCP: Hash tables configured (established 2048 bind 2048)
> TCP: reno registered
> UDP hash table entries: 256 (order: 0, 4096 bytes)
> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> NET: Registered protocol family 1
> RPC: Registered named UNIX socket transport module.
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
> msgmni has been set to 494
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> kirkwood-pinctrl f1010000.pinctrl: registered pinctrl driver
> mv_xor f1060800.xor: Marvell shared XOR driver
> mv_xor f1060800.xor: Marvell XOR: ( xor cpy )
> mv_xor f1060800.xor: Marvell XOR: ( xor cpy )
> mv_xor f1060900.xor: Marvell shared XOR driver
> mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
> mv_xor f1060900.xor: Marvell XOR: ( xor cpy )
> Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
> f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
> console [ttyS0] enabled
> loop: module loaded
> sata_mv f1080000.sata: slots 32 ports 2
> scsi0 : sata_mv
> scsi1 : sata_mv
> ata1: SATA max UDMA/133 irq 21
> ata2: SATA max UDMA/133 irq 21
> NAND device: Manufacturer ID: 0xec, Chip ID: 0xf1 (Samsung NAND
> 128MiB 3,3V 8-bit), 128MiB, page size: 2048, OOB size: 6
> 4
> Scanning device for bad blocks
> Bad eraseblock 249 at 0x000001f20000
> 9 ofpart partitions found on MTD device orion_nand
> Creating 9 MTD partitions on "orion_nand":
> 0x000000000000-0x000000100000 : "uboot"
> 0x000000100000-0x000000180000 : "uboot_env"
> 0x000000180000-0x000000200000 : "key_store"
> 0x000000200000-0x000000280000 : "info"
> 0x000000280000-0x000000c80000 : "etc"
> 0x000000c80000-0x000001680000 : "kernel_1"
> 0x000001680000-0x000004640000 : "rootfs1"
> 0x000004640000-0x000005040000 : "kernel_2"
> 0x000005040000-0x000008000000 : "rootfs2"
> r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> r8169 0000:01:00.0 eth0: RTL8169 at 0xd092e000, 00:00:00:00:00:00,
> XID 00000000 IRQ 9
> r8169 0000:01:00.0 eth0: jumbo features [frames: 7152 bytes, tx
> checksumming: ok]
> libertas_sdio: Libertas SDIO driver
> libertas_sdio: Copyright Pierre Ossman
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-pci: EHCI PCI platform driver
> ehci-orion: EHCI orion driver
> orion-ehci f1050000.ehci: EHCI Host Controller
> orion-ehci f1050000.ehci: new USB bus registered, assigned bus number 1
> orion-ehci f1050000.ehci: irq 19, io mem 0xf1050000
> orion-ehci f1050000.ehci: USB 2.0 started, EHCI 1.00
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> usbcore: registered new interface driver usb-storage
> usbcore: registered new interface driver ums-datafab
> usbcore: registered new interface driver ums-freecom
> usbcore: registered new interface driver ums-jumpshot
> usbcore: registered new interface driver ums-sddr09
> usbcore: registered new interface driver ums-sddr55
> mousedev: PS/2 mouse device common for all mice
> rtc-mv f1010300.rtc: rtc core: registered f1010300.rtc as rtc0
> i2c /dev entries driver
> orion_wdt: Initial timeout 21 sec
> cpuidle: using governor ladder
> cpuidle: using governor menu
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> oprofile: no performance counters
> oprofile: using timer interrupt.
> TCP: cubic registered
> NET: Registered protocol family 17
> lib80211: common routines for IEEE802.11 drivers
> USB Power Off: 5000 mV
> input: gpio_keys.2 as /devices/gpio_keys.2/input/input0
> rtc-mv f1010300.rtc: setting system clock to 2013-07-30 19:25:09 UTC
> (1375212309)
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
> ata1.00: ATA-8: ST31500541AS, CC32, max UDMA/133
> ata1.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> usb 1-1: new high-speed USB device number 2 using orion-ehci
> ata1.00: configured for UDMA/133
> scsi 0:0:0:0: Direct-Access ATA ST31500541AS CC32 PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> hub 1-1:1.0: USB hub found
> hub 1-1:1.0: 4 ports detected
> sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
> sd 0:0:0:0: [sda] Attached SCSI disk
> ata2: SATA link down (SStatus 0 SControl F300)
> EXT3-fs (sda2): error: couldn't mount because of unsupported
> optional features (240)
> EXT2-fs (sda2): error: couldn't mount because of unsupported
> optional features (240)
> EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
> VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
> Freeing unused kernel memory: 148K (c0586000 - c05ab000)
> INIT: version 2.88 booting
> 
> >>diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> >>index 13a633b..641dd3d 100644
> >>--- a/drivers/pci/host/pci-mvebu.c
> >>+++ b/drivers/pci/host/pci-mvebu.c
> >>@@ -129,6 +129,8 @@ struct mvebu_pcie_port {
> >>  	struct mvebu_pcie *pcie;
> >>  	phys_addr_t memwin_base;
> >>  	size_t memwin_size;
> >>+	phys_addr_t prefmemwin_base;
> >>+	size_t prefmemwin_size;
> >>  	phys_addr_t iowin_base;
> >>  	size_t iowin_size;
> >>  };
> >>@@ -348,6 +350,39 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
> >>  					  MVEBU_MBUS_PCI_MEM);
> >>  }
> >>+static void mvebu_pcie_handle_prefmembase_change(struct mvebu_pcie_port *port)
> >>+{
> >>+	/* Are the new membase/memlimit values invalid? */
> >>+	if (port->bridge.prefmemlimit < port->bridge.prefmembase) {
> >>+
> >>+		/* If a window was configured, remove it */
> >>+		if (port->prefmemwin_base) {
> >>+			mvebu_mbus_del_window(port->prefmemwin_base,
> >>+					      port->prefmemwin_size);
> >>+			port->prefmemwin_base = 0;
> >>+			port->prefmemwin_size = 0;
> >>+		}
> >>+
> >>+		return;
> >>+	}
> >>+
> >>+	/*
> >>+	 * We read the PCI-to-PCI bridge emulated registers, and
> >>+	 * calculate the base address and size of the address decoding
> >>+	 * window to setup, according to the PCI-to-PCI bridge
> >>+	 * specifications.
> >>+	 */
> >>+	port->prefmemwin_base  = ((port->bridge.prefmembase & 0xFFF0) << 16);
> >>+	port->prefmemwin_size  =
> >>+		(((port->bridge.prefmemlimit & 0xFFF0) << 16) | 0xFFFFF) -
> >>+		port->prefmemwin_base;
> >>+
> >>+	mvebu_mbus_add_window_remap_flags(port->name, port->prefmemwin_base,
> >>+					  port->prefmemwin_size,
> >>+					  MVEBU_MBUS_NO_REMAP,
> >>+					  MVEBU_MBUS_PCI_MEM);
> >>+}
> >>+
> >>  /*
> >>   * Initialize the configuration space of the PCI-to-PCI bridge
> >>   * associated with the given PCIe interface.
> >>@@ -492,18 +527,28 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
> >>  		bridge->iobase = (value & 0xff) | PCI_IO_RANGE_TYPE_32;
> >>  		bridge->iolimit = ((value >> 8) & 0xff) | PCI_IO_RANGE_TYPE_32;
> >>  		bridge->secondary_status = value >> 16;
> >>+		pr_info("MVEBU PCI %d.%d: new io, base 0x%x, limit 0x%x\n",
> >>+			port->port, port->lane,
> >>+			bridge->iobase, bridge->iolimit);
> >>  		mvebu_pcie_handle_iobase_change(port);
> >>  		break;
> >>  	case PCI_MEMORY_BASE:
> >>  		bridge->membase = value & 0xffff;
> >>  		bridge->memlimit = value >> 16;
> >>+		pr_info("MVEBU PCI %d.%d: new mem, base 0x%x, limit 0x%x\n",
> >>+			port->port, port->lane,
> >>+			bridge->membase, bridge->memlimit);
> >>  		mvebu_pcie_handle_membase_change(port);
> >>  		break;
> >>  	case PCI_PREF_MEMORY_BASE:
> >>  		bridge->prefmembase = value & 0xffff;
> >>  		bridge->prefmemlimit = value >> 16;
> >>+		pr_info("MVEBU PCI %d.%d: new pref mem, base 0x%x, limit 0x%x\n",
> >>+			port->port, port->lane,
> >>+			bridge->prefmembase, bridge->prefmemlimit);
> >>+		mvebu_pcie_handle_prefmembase_change(port);
> >>  		break;
> >>  	case PCI_PREF_BASE_UPPER32:
> >>
> >>
> >>-- 
> >>Thomas Petazzoni, Free Electrons
> >>Kernel, drivers, real-time and embedded Linux
> >>development, consulting, training and support.
> >>http://free-electrons.com
> >_______________________________________________
> >linux-arm-kernel mailing list
> >linux-arm-kernel at lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
