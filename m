From: linux@mniewoehner.de (Michael =?ISO-8859-1?Q?Niew=F6hner?=)
Date: Tue, 20 Sep 2016 23:19:27 +0200
Subject: PROBLEM: DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
In-Reply-To: <CANAwSgQMsK8YPxR==UXtR49kiJzYhkzvSCNwn8mDJfj-3wpa2w@mail.gmail.com>
References: <1472414695.3845.3.camel@mniewoehner.de>
 <87lgzgdof3.fsf@linux.intel.com> <57C41582.1030604@linux.intel.com>
 <1472468730.4925.3.camel@mniewoehner.de>
 <CANAwSgQMsK8YPxR==UXtR49kiJzYhkzvSCNwn8mDJfj-3wpa2w@mail.gmail.com>
Message-ID: <1474406366.1787.10.camel@mniewoehner.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,
On Di, 2016-08-30 at 10:32 +0530, Anand Moon wrote:
> Hi All
> 
> Adding Vivek Gautam.
> 
> On 29 August 2016 at 16:35, Michael Niew?hner <linux@mniewoehner.de>
> wrote:
> > 
> > Hi Mathias,
> > On Mo, 2016-08-29 at 13:59 +0300, Mathias Nyman wrote:
> > > 
> > > On 29.08.2016 10:28, Felipe Balbi wrote:
> > > > 
> > > > 
> > > > 
> > > > Hi,
> > > > 
> > > > Michael Niew?hner <linux@mniewoehner.de> writes:
> > > > > 
> > > > > 
> > > > > [1.] One line summary of the problem:
> > > > > DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
> > > > > 
> > > > > [2.] Full description of the problem/report:
> > > > > No usb 3.0 devices are being detected when attached while USB
> > > > > 2.0
> > > > > devices work on the same port.
> > > > > USB 3.0 works after applying patches [9.1] and [9.2], but
> > > > > seems
> > > > > to be
> > > > > buggy. The usb hub is redetected every time an usb device is
> > > > > attached.
> > > > 
> > > > dwc3 is host, which means it's actually XHCI :-)
> > > > 
> > > > Adding Mathias
> > > > 
> > > > > 
> > > > > 
> > > > > dmesg:
> > > > > [??192.287080] usb 3-1.2: USB disconnect, device number 7
> > > > > [??210.370699] hub 3-1:1.0: hub_ext_port_status failed (err =
> > > > > -71)
> > > 
> > > Looks like the hub GetPortStatus request fails with protocol
> > > error.
> > > 
> > > Reading xhci root hub port status is mostly just register reads
> > > and
> > > writes. It
> > > shouldn't include any actual transfers that could return -EPROTO
> > > 
> > > So this is not the root hub? but a external or integrated on your
> > > board, right?
> > > 
> > > The protocol error -71 is returned at transfer errors or if
> > > device
> > > stalled.
> > > 
> > > Adding more xhci debugging options could show something:
> > > echo -n 'module xhci_hcd =p' >
> > > /sys/kernel/debug/dynamic_debug/control
> > > 
> > > > 
> > > > 
> > > > > 
> > > > > 
> > > > > [9.] Other notes, patches, fixes, workarounds:
> > > > > [9.1] https://lkml.org/lkml/2014/4/28/234
> > > > > [9.2] https://lkml.org/lkml/2015/2/2/259
> > > 
> > > The additional patches that makes things somehow work involve
> > > tuning
> > > the PHY,
> > > this is an area I'm not familiar with
> > > 
> > > -Mathias
> > > 
> > 
> > 
> > I'm sorry, I should have said that this is the dmesg output with
> > the
> > patches applied. Without them there is no output at all when I
> > attach
> > an usb 3.0 device.
> > 
> > Michael
> 
> There are two dwc3 ports in the SoC : one for Gbit Ethernet another
> one for on-board GL3521 USB 3.0 hub controller.
> 
> 3.10.x kernel
> odroid at odroid:~$ lsusb -t
> /:??Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> ????|__ Port 1: Dev 2, If 0, Class=Vendor Specific Class,
> Driver=r8152, 5000M
> /:??Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
> /:??Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> ????|__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 5000M
> /:??Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
> ????|__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 480M
> /:??Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
> /:??Bus 01.Port 1: Dev 1, Class=root_hub, Driver=s5p-ehci/3p, 480M
> 
> 4.x kernel
> odroid at odroid:~$ lsusb -t
> /:??Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> /:??Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
> ????|__ Port 1: Dev 2, If 0, Class=Vendor Specific Class,
> Driver=r8152, 480M
> /:??Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> ????|__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 5000M
> ????????|__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-
> storage, 5000M
> ????????|__ Port 2: Dev 4, If 0, Class=Mass Storage, Driver=usb-
> storage, 5000M
> /:??Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
> ????|__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 480M
> /:??Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
> /:??Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M
> 
> I fell that Ethernet driver r8152 is not getting registered to
> xhci-hcd to bus port 06
> which lead to other ports to miss configure, some time the Ethernet
> port get register to bus port 04
> 
> Their is also a possibility that all the port are not getting proper
> power from the S2MPS11 PMIC
> and possible some reset of the phy is needed to reconfigure the
> exynos
> USB HSIC controller.
> 
> Best Regards
> -Anand Moon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at??http://vger.kernel.org/majordomo-info.html


Today I've tested v4.8-rc7 (without the patches above). The USB 3.0
ports have stopped working completely for me. Neither USB 2.0 nor USB
3.0 are being detected. The Ethernet port does not work, too. The USB-
2.0-only Port works.

There also a new problem: my XU4 does not reboot or poweroff anymore.
When I force-remove the dwc3 module reboot / poweroff works again.


There are some failures in the dmesg log, see below.

Best regards,
Michael





dmesg | grep -iE "usb|dwc|hci":
-------------------------------
[????0.326371] usbcore: registered new interface driver usbfs
[????0.326456] usbcore: registered new interface driver hub
[????0.326638] usbcore: registered new device driver usb
[????1.620326] usbcore: registered new interface driver usb-storage
[????1.790692] sdhci: Secure Digital Host Controller Interface driver
[????1.795382] sdhci: Copyright(c) Pierre Ossman
[????1.994062] sdhci-pltfm: SDHCI platform and OF driver helper
[????2.011265] usbcore: registered new interface driver usbhid
[????2.016419] usbhid: USB HID core driver
[???15.113203] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[???15.115802] ehci-exynos: EHCI EXYNOS driver
[???15.117544] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[???15.121099] ohci-exynos: OHCI EXYNOS driver
[???15.173098] exynos-ohci 12120000.usb: USB Host Controller
[???15.187949] exynos-ohci 12120000.usb: new USB bus registered, assigned bus number 1
[???15.195296] exynos-ohci 12120000.usb: irq 89, io mem 0x12120000
[???15.274045] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[???15.279360] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[???15.279366] usb usb1: Product: USB Host Controller
[???15.279371] usb usb1: Manufacturer: Linux 4.8.0-rc7+ ohci_hcd
[???15.279375] usb usb1: SerialNumber: 12120000.usb
[???15.280187] hub 1-0:1.0: USB hub found
[???15.281215] exynos-ehci 12110000.usb: EHCI Host Controller
[???15.281509] exynos-ehci 12110000.usb: new USB bus registered, assigned bus number 2
[???15.281656] exynos-ehci 12110000.usb: irq 89, io mem 0x12110000
[???15.309929] exynos-ehci 12110000.usb: USB 2.0 started, EHCI 1.00
[???15.310297] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[???15.310302] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[???15.310307] usb usb2: Product: EHCI Host Controller
[???15.310312] usb usb2: Manufacturer: Linux 4.8.0-rc7+ ehci_hcd
[???15.310317] usb usb2: SerialNumber: 12110000.usb
[???15.310928] hub 2-0:1.0: USB hub found
[???15.312172] exynos-dwc3 soc:usb3-0: no suspend clk specified
[???15.313613] usb_phy_generic.0.auto supply vcc not found, using dummy regulator
[???15.314033] usb_phy_generic.1.auto supply vcc not found, using dummy regulator
[???15.315395] exynos-dwc3 soc:usb3-1: no suspend clk specified
[???15.317108] usb_phy_generic.2.auto supply vcc not found, using dummy regulator
[???15.317436] usb_phy_generic.3.auto supply vcc not found, using dummy regulator
[???15.335605] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
[???15.335844] xhci-hcd xhci-hcd.4.auto: new USB bus registered, assigned bus number 3
[???15.336099] xhci-hcd xhci-hcd.4.auto: hcc params 0x0220f04c hci version 0x100 quirks 0x00010010
[???15.336149] xhci-hcd xhci-hcd.4.auto: irq 135, io mem 0x12000000
[???15.336489] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[???15.336496] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[???15.336501] usb usb3: Product: xHCI Host Controller
[???15.336506] usb usb3: Manufacturer: Linux 4.8.0-rc7+ xhci-hcd
[???15.336511] usb usb3: SerialNumber: xhci-hcd.4.auto
[???15.337095] hub 3-0:1.0: USB hub found
[???15.337596] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
[???15.337789] xhci-hcd xhci-hcd.4.auto: new USB bus registered, assigned bus number 4
[???15.337927] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[???15.338159] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[???15.338165] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[???15.338169] usb usb4: Product: xHCI Host Controller
[???15.338174] usb usb4: Manufacturer: Linux 4.8.0-rc7+ xhci-hcd
[???15.338179] usb usb4: SerialNumber: xhci-hcd.4.auto
[???15.338847] hub 4-0:1.0: USB hub found
[???15.339419] xhci-hcd xhci-hcd.5.auto: xHCI Host Controller
[???15.339649] xhci-hcd xhci-hcd.5.auto: new USB bus registered, assigned bus number 5
[???15.339990] xhci-hcd xhci-hcd.5.auto: hcc params 0x0220f04c hci version 0x100 quirks 0x00010010
[???15.340036] xhci-hcd xhci-hcd.5.auto: irq 136, io mem 0x12400000
[???15.340329] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[???15.340335] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[???15.340340] usb usb5: Product: xHCI Host Controller
[???15.340344] usb usb5: Manufacturer: Linux 4.8.0-rc7+ xhci-hcd
[???15.340349] usb usb5: SerialNumber: xhci-hcd.5.auto
[???15.340918] hub 5-0:1.0: USB hub found
[???15.341387] xhci-hcd xhci-hcd.5.auto: xHCI Host Controller
[???15.341618] xhci-hcd xhci-hcd.5.auto: new USB bus registered, assigned bus number 6
[???15.341758] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[???15.341993] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003
[???15.341998] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[???15.342003] usb usb6: Product: xHCI Host Controller
[???15.342008] usb usb6: Manufacturer: Linux 4.8.0-rc7+ xhci-hcd
[???15.342012] usb usb6: SerialNumber: xhci-hcd.5.auto
[???15.342662] hub 6-0:1.0: USB hub found
[???19.642578] usb usb5-port1: connect-debounce failed

#######################################################################

full dmesg:
-----------
[????0.000000] Booting Linux on physical CPU 0x100
[????0.000000] Linux version 4.8.0-rc7+ (c0d3 at z3r0) (gcc version 5.3.1 20160412 (Linaro GCC 5.3-2016.05) ) #1 SMP Tue Sep 20 22:24:41 CEST 2016
[????0.000000] CPU: ARMv7 Processor [410fc073] revision 3 (ARMv7), cr=10c5387d
[????0.000000] CPU: div instructions available: patching division code
[????0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[????0.000000] OF: fdt:Machine model: Hardkernel Odroid XU4
[????0.000000] Reserved memory: created DMA memory pool at 0xbe200000, size 8 MiB
[????0.000000] OF: reserved mem: initialized node region_mfc_right, compatible id shared-dma-pool
[????0.000000] Reserved memory: created DMA memory pool at 0xbd200000, size 16 MiB
[????0.000000] OF: reserved mem: initialized node region_mfc_left, compatible id shared-dma-pool
[????0.000000] Memory policy: Data cache writealloc
[????0.000000] Samsung CPU ID: 0xe5422001
[????0.000000] On node 0 totalpages: 512512
[????0.000000] free_area_init_node: node 0, pgdat c0c81dc0, node_mem_map eee52000
[????0.000000]???Normal zone: 1728 pages used for memmap
[????0.000000]???Normal zone: 0 pages reserved
[????0.000000]???Normal zone: 196608 pages, LIFO batch:31
[????0.000000]???HighMem zone: 315904 pages, LIFO batch:31
[????0.000000] Running under secure firmware.
[????0.000000] percpu: Embedded 15 pages/cpu @eeda1000 s30272 r8192 d22976 u61440
[????0.000000] pcpu-alloc: s30272 r8192 d22976 u61440 alloc=15*4096
[????0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7?
[????0.000000] Built 1 zonelists in Zone order, mobility grouping on.??Total pages: 510784
[????0.000000] Kernel command line: console=ttySAC2,115200n8 root=/dev/mmcblk1p2 rootfstype=ext4 rootwait earlyprintk debug
[????0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[????0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[????0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[????0.000000] Memory: 2018124K/2050048K available (7168K kernel code, 617K rwdata, 2052K rodata, 1024K init, 375K bss, 31924K reserved, 0K cma-reserved, 1263616K highmem)
[????0.000000] Virtual kernel memory layout:
????vector??: 0xffff0000 - 0xffff1000???(???4 kB)
????fixmap??: 0xffc00000 - 0xfff00000???(3072 kB)
????vmalloc : 0xf0800000 - 0xff800000???( 240 MB)
????lowmem??: 0xc0000000 - 0xf0000000???( 768 MB)
????pkmap???: 0xbfe00000 - 0xc0000000???(???2 MB)
????modules : 0xbf000000 - 0xbfe00000???(??14 MB)
??????.text : 0xc0008000 - 0xc0800000???(8160 kB)
??????.init : 0xc0b00000 - 0xc0c00000???(1024 kB)
??????.data : 0xc0c00000 - 0xc0c9a7cc???( 618 kB)
???????.bss : 0xc0c9c000 - 0xc0cf9d04???( 376 kB)
[????0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[????0.000000] Hierarchical RCU implementation.
[????0.000000]??Build-time adjustment of leaf fanout to 32.
[????0.000000]??RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=8.
[????0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=8
[????0.000000] NR_IRQS:16 nr_irqs:16 16
[????0.000000] genirq: Setting trigger mode 0 for irq 17 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 18 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 19 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 20 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 21 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 22 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 23 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 24 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 25 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 26 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 27 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 28 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 29 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 30 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 31 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 32 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 33 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 34 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 35 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 36 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 37 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 38 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 39 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 40 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 41 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 42 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 43 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 44 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 45 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 46 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 47 failed (gic_set_type+0x0/0x64)
[????0.000000] genirq: Setting trigger mode 0 for irq 48 failed (gic_set_type+0x0/0x64)
[????0.000000] Switching to timer-based delay loop, resolution 41ns
[????0.000000] clocksource: mct-frc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[????0.000007] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
[????0.001699] Console: colour dummy device 80x30
[????0.001743] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[????0.001762] pid_max: default: 32768 minimum: 301
[????0.002015] Security Framework initialized
[????0.002031] Yama: becoming mindful.
[????0.002063] AppArmor: AppArmor disabled by boot time parameter
[????0.002154] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[????0.002171] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[????0.003263] CPU: Testing write buffer coherency: ok
[????0.003312] ftrace: allocating 25419 entries in 75 pages
[????0.071511] CPU0: update cpu_capacity 448
[????0.071533] CPU0: thread -1, cpu 0, socket 1, mpidr 80000100
[????0.071713] Setting up static identity map for 0x40100000 - 0x40100058
[????0.072357] ARM CCI driver probed
[????0.072569] Exynos MCPM support installed
[????0.076960] CPU1: update cpu_capacity 448
[????0.076969] CPU1: thread -1, cpu 1, socket 1, mpidr 80000101
[????0.078015] CPU2: update cpu_capacity 448
[????0.078023] CPU2: thread -1, cpu 2, socket 1, mpidr 80000102
[????0.079093] CPU3: update cpu_capacity 448
[????0.079100] CPU3: thread -1, cpu 3, socket 1, mpidr 80000103
[????0.080042] CPU4: update cpu_capacity 1535
[????0.080050] CPU4: thread -1, cpu 0, socket 0, mpidr 80000000
[????0.081116] CPU5: update cpu_capacity 1535
[????0.081123] CPU5: thread -1, cpu 1, socket 0, mpidr 80000001
[????0.082117] CPU6: update cpu_capacity 1535
[????0.082124] CPU6: thread -1, cpu 2, socket 0, mpidr 80000002
[????0.083109] CPU7: update cpu_capacity 1535
[????0.083116] CPU7: thread -1, cpu 3, socket 0, mpidr 80000003
[????0.083257] Brought up 8 CPUs
[????0.083322] SMP: Total of 8 processors activated (384.00 BogoMIPS).
[????0.083333] CPU: WARNING: CPU(s) started in wrong/inconsistent modes (primary CPU mode 0x1a)
[????0.083341] CPU: This may indicate a broken bootloader or firmware.
[????0.085519] devtmpfs: initialized
[????0.111049] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 3
[????0.111544] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[????0.111848] pinctrl core: initialized pinctrl subsystem
[????0.114692] NET: Registered protocol family 16
[????0.115485] DMA: preallocated 256 KiB pool for atomic coherent allocations
[????0.159992] cpuidle: using governor ladder
[????0.199983] cpuidle: using governor menu
[????0.208731] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[????0.208746] hw-breakpoint: maximum watchpoint size is 8 bytes.
[????0.209125] Serial: AMBA PL011 UART driver
[????0.218768] iommu: Adding device 11000000.codec to group 0
[????0.224583] genirq: Setting trigger mode 0 for irq 110 failed (gic_set_type+0x0/0x64)
[????0.257244] iommu: Adding device 14450000.mixer to group 1
[????0.257794] iommu: Adding device 11c00000.rotator to group 2
[????0.267216] iommu: Adding device 13e00000.video-scaler to group 3
[????0.267742] iommu: Adding device 13e10000.video-scaler to group 4
[????0.268256] iommu: Adding device 11f50000.jpeg to group 5
[????0.268752] iommu: Adding device 11f60000.jpeg to group 6
[????0.269137] EXYNOS5420 PMU initialized
[????0.325992] SCSI subsystem initialized
[????0.326371] usbcore: registered new interface driver usbfs
[????0.326456] usbcore: registered new interface driver hub
[????0.326638] usbcore: registered new device driver usb
[????0.327614] media: Linux media interface: v0.10
[????0.327679] Linux video capture interface: v2.00
[????0.327775] pps_core: LinuxPPS API ver. 1 registered
[????0.327786] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[????0.327815] PTP clock support registered
[????0.329864] clocksource: Switched to clocksource mct-frc
[????0.400809] VFS: Disk quotas dquot_6.6.0
[????0.400890] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[????0.420200] NET: Registered protocol family 2
[????0.420933] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[????0.421015] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[????0.421174] TCP: Hash tables configured (established 8192 bind 8192)
[????0.421242] UDP hash table entries: 512 (order: 2, 16384 bytes)
[????0.421283] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[????0.421520] NET: Registered protocol family 1
[????0.427016] futex hash table entries: 2048 (order: 5, 131072 bytes)
[????0.427156] audit: initializing netlink subsys (disabled)
[????0.427216] audit: type=2000 audit(0.370:1): initialized
[????0.428268] workingset: timestamp_bits=14 max_order=19 bucket_order=5
[????0.439142] zbud: loaded
[????0.444748] bounce: pool size: 64 pages
[????0.445009] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[????0.445239] io scheduler noop registered
[????0.445253] io scheduler deadline registered (default)
[????0.445515] io scheduler cfq registered
[????0.455579] dma-pl330 121a0000.pdma: Loaded driver for PL330 DMAC-241330
[????0.455598] dma-pl330 121a0000.pdma:?????????DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[????0.460175] dma-pl330 121b0000.pdma: Loaded driver for PL330 DMAC-241330
[????0.460193] dma-pl330 121b0000.pdma:?????????DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[????0.461439] dma-pl330 10800000.mdma: Loaded driver for PL330 DMAC-241330
[????0.461456] dma-pl330 10800000.mdma:?????????DBUFF-64x8bytes Num_Chans-8 Num_Peri-1 Num_Events-32
[????0.462613] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[????0.465554] Serial: AMBA driver
[????0.465938] 12c00000.serial: ttySAC0 at MMIO 0x12c00000 (irq = 76, base_baud = 0) is a S3C6400/10
[????0.466473] 12c10000.serial: ttySAC1 at MMIO 0x12c10000 (irq = 77, base_baud = 0) is a S3C6400/10
[????0.467023] 12c20000.serial: ttySAC2 at MMIO 0x12c20000 (irq = 78, base_baud = 0) is a S3C6400/10
[????0.599414] random: fast init done
[????1.542942] console [ttySAC2] enabled
[????1.547070] 12c30000.serial: ttySAC3 at MMIO 0x12c30000 (irq = 79, base_baud = 0) is a S3C6400/10
[????1.556647] [drm] Initialized drm 1.1.0 20060810
[????1.562246] exynos-hdmi 14530000.hdmi: Failed to get supply 'vdd': -517
[????1.569034] exynos-rot 11c00000.rotator: The exynos rotator is probed successfully
[????1.575796] exynos-drm-gsc 13e00000.video-scaler: failed to get system register.
[????1.582802] exynos-drm-gsc 13e00000.video-scaler: drm gsc registered successfully.
[????1.590163] exynos-drm-gsc 13e10000.video-scaler: failed to get system register.
[????1.597624] exynos-drm-gsc 13e10000.video-scaler: drm gsc registered successfully.
[????1.605612] exynos-drm-ipp exynos-drm-ipp: drm ipp registered successfully.
[????1.617202] libphy: Fixed MDIO Bus: probed
[????1.620326] usbcore: registered new interface driver usb-storage
[????1.626314] mousedev: PS/2 mouse device common for all mice
[????1.649678] vdd_ldo9: Bringing 3300000uV into 3000000-3000000uV
[????1.662830] vddq_mmc2: Bringing 3300000uV into 2800000-2800000uV
[????1.672436] vdd_ldo15: Bringing 3300000uV into 3100000-3100000uV
[????1.685733] vdd_sd: Bringing 3300000uV into 2800000-2800000uV
[????1.745880] s5m-rtc s2mps14-rtc: rtc core: registered s5m-rtc as rtc0
[????1.758869] exynos-tmu 10060000.tmu: More trip points than supported by this TMU.
[????1.764911] exynos-tmu 10060000.tmu: 2 trip points should be configured in polling mode.
[????1.790692] sdhci: Secure Digital Host Controller Interface driver
[????1.795382] sdhci: Copyright(c) Pierre Ossman
[????1.799956] Synopsys Designware Multimedia Card Interface Driver
[????1.806290] dwmmc_exynos 12200000.mmc: IDMAC supports 32-bit address mode.
[????1.812577] dwmmc_exynos 12200000.mmc: Using internal DMA controller.
[????1.818958] dwmmc_exynos 12200000.mmc: Version ID is 250a
[????1.824373] dwmmc_exynos 12200000.mmc: DW MMC controller at irq 91,64 bit host data width,64 deep fifo
[????1.833763] dwmmc_exynos 12200000.mmc: Got CD GPIO
[????1.838412] dwmmc_exynos 12200000.mmc: allocated mmc-pwrseq
[????1.870520] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
[????1.900048] dwmmc_exynos 12200000.mmc: 1 slots initialized
[????1.904270] dwmmc_exynos 12220000.mmc: IDMAC supports 32-bit address mode.
[????1.910928] dwmmc_exynos 12220000.mmc: Using internal DMA controller.
[????1.917310] dwmmc_exynos 12220000.mmc: Version ID is 250a
[????1.922727] dwmmc_exynos 12220000.mmc: DW MMC controller at irq 92,64 bit host data width,64 deep fifo
[????1.960331] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
[????1.989895] dwmmc_exynos 12220000.mmc: 1 slots initialized
[????1.994062] sdhci-pltfm: SDHCI platform and OF driver helper
[????2.000612] ledtrig-cpu: registered to indicate activity on CPUs
[????2.005907] hidraw: raw HID events driver (C) Jiri Kosina
[????2.011265] usbcore: registered new interface driver usbhid
[????2.016419] usbhid: USB HID core driver
[????2.032699] exynos-nocp: new NoC Probe device registered: 10ca1000.nocp
[????2.038006] exynos-nocp: new NoC Probe device registered: 10ca1400.nocp
[????2.044648] exynos-nocp: new NoC Probe device registered: 10ca1800.nocp
[????2.051203] exynos-nocp: new NoC Probe device registered: 10ca1c00.nocp
[????2.060844] NET: Registered protocol family 10
[????2.064785] mip6: Mobile IPv6
[????2.066752] NET: Registered protocol family 17
[????2.071230] mpls_gso: MPLS GSO support
[????2.075529] ThumbEE CPU extension supported.
[????2.079164] Registering SWP/SWPB emulation handler
[????2.084499] registered taskstats version 1
[????2.088033] zswap: loaded using pool lzo/zbud
[????2.092445] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
[????2.105579] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[????2.112148] s3c-rtc 101e0000.rtc: rtc disabled, re-enabling
[????2.116601] s3c-rtc 101e0000.rtc: warning: invalid RTC value so initializing it
[????2.123908] rtc rtc1: invalid alarm value: 1900-1-2 0:0:0
[????2.129400] s3c-rtc 101e0000.rtc: rtc core: registered s3c as rtc1
[????2.136750] exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
[????2.144186] exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
[????2.152075] exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
[????2.160433] exynos-bus: new bus device registered: soc:bus_fsys (100000 KHz ~ 200000 KHz)
[????2.168742] exynos-bus: new bus device registered: soc:bus_fsys2 ( 75000 KHz ~ 150000 KHz)
[????2.177136] exynos-bus: new bus device registered: soc:bus_mfc ( 96000 KHz ~ 333000 KHz)
[????2.185125] exynos-bus: new bus device registered: soc:bus_gen ( 89000 KHz ~ 267000 KHz)
[????2.193013] exynos-bus: new bus device registered: soc:bus_peri ( 67000 KHz ~??67000 KHz)
[????2.195081] devfreq soc:bus_wcore: Couldn't update frequency transition information.
[????2.209087] exynos-bus: new bus device registered: soc:bus_g2d ( 84000 KHz ~ 333000 KHz)
[????2.217105] exynos-bus: new bus device registered: soc:bus_g2d_acp ( 67000 KHz ~ 267000 KHz)
[????2.225507] exynos-bus: new bus device registered: soc:bus_jpeg ( 75000 KHz ~ 300000 KHz)
[????2.233659] exynos-bus: new bus device registered: soc:bus_jpeg_apb ( 84000 KHz ~ 167000 KHz)
[????2.242025] exynos-bus: new bus device registered: soc:bus_disp1_fimd (120000 KHz ~ 200000 KHz)
[????2.250759] exynos-bus: new bus device registered: soc:bus_disp1 (120000 KHz ~ 300000 KHz)
[????2.258960] exynos-bus: new bus device registered: soc:bus_gscl_scaler (150000 KHz ~ 300000 KHz)
[????2.267872] exynos-bus: new bus device registered: soc:bus_mscl ( 84000 KHz ~ 400000 KHz)
[????2.275693] mmc_host mmc1: Bus speed (slot 0) = 200000000Hz (slot req 200000000Hz, actual 200000000HZ div = 0)
[????2.277158] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[????2.279370] Power domain power-domain at 10044120 disable failed
[????2.285341] s5m-rtc s2mps14-rtc: setting system clock to 2000-01-01 00:00:04 UTC (946684804)
[????2.308572] PM: Hibernation image not present or could not be loaded.
[????2.316247] Waiting for root device /dev/mmcblk1p2...
[????2.410857] mmc1: new ultra high speed SDR104 SDHC card at address 59b4
[????2.416596] mmcblk1: mmc1:59b4 USDU1 14.7 GiB?
[????2.421238]??mmcblk1: p1 p2
[????2.425615] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[????2.554682] EXT4-fs (mmcblk1p2): mounted filesystem with ordered data mode. Opts: (null)
[????2.561343] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
[????2.568683] Freeing unused kernel memory: 1024K (c0b00000 - c0c00000)
[????2.702417] systemd[1]: Mounting cgroup to /sys/fs/cgroup/cpuset of type cgroup with options cpuset.
[????2.781274] systemd[1]: Mounting cgroup to /sys/fs/cgroup/cpu,cpuacct of type cgroup with options cpu,cpuacct.
[????2.790379] systemd[1]: Mounting cgroup to /sys/fs/cgroup/blkio of type cgroup with options blkio.
[????2.800162] systemd[1]: Mounting cgroup to /sys/fs/cgroup/memory of type cgroup with options memory.
[????2.814356] systemd[1]: Mounting cgroup to /sys/fs/cgroup/devices of type cgroup with options devices.
[????2.822694] systemd[1]: Mounting cgroup to /sys/fs/cgroup/freezer of type cgroup with options freezer.
[????2.831941] systemd[1]: Mounting cgroup to /sys/fs/cgroup/net_cls,net_prio of type cgroup with options net_cls,net_prio.
[????2.842823] systemd[1]: Mounting cgroup to /sys/fs/cgroup/perf_event of type cgroup with options perf_event.
[????2.852911] systemd[1]: systemd 215 running in system mode. (+PAM +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ -SECCOMP -APPARMOR)
[????2.865511] systemd[1]: Detected architecture 'arm'.
[????2.955738] systemd-getty-generator[114]: Automatically adding serial getty for /dev/ttySAC2.
[????2.957079] systemd-fstab-generator[115]: Parsing /etc/fstab
[????2.963653] systemd-fstab-generator[115]: Found entry what=/dev/mmcblk1p2 where=/ type=ext4
[????2.966633] systemd-default-display-manager-generator[117]: No /etc/X11/default-display-manager file, nothing to generate
[????2.968300] systemd-rc-local-generator[123]: Automatically adding rc-local.service.
[????3.016153] systemd-gpt-auto-generator[120]: Root device /dev/mmcblk1.
[????3.016220] systemd-sysv-generator[119]: Looking for unit files in (higher priority first):
[????3.016228] systemd-sysv-generator[119]:?????/etc/systemd/system
[????3.016235] systemd-sysv-generator[119]:?????/run/systemd/system
[????3.016243] systemd-sysv-generator[119]:?????/usr/local/lib/systemd/system
[????3.016250] systemd-sysv-generator[119]:?????/lib/systemd/system
[????3.016259] systemd-sysv-generator[119]:?????/usr/lib/systemd/system
[????3.016285] systemd-sysv-generator[119]: Looking for SysV init scripts in:
[????3.016292] systemd-sysv-generator[119]:?????/etc/init.d
[????3.016302] systemd-sysv-generator[119]: Looking for SysV rcN.d links in:
[????3.016309] systemd-sysv-generator[119]:?????/etc
[????3.017000] systemd-fstab-generator[115]: Found entry what=/dev/mmcblk1p1 where=/boot type=vfat
[????3.019097] systemd-fstab-generator[115]: Checking was requested for /dev/mmcblk1p1, but fsck.vfat does not exist: No such file or directory
[????3.070298] systemd-sysv-ge: 77 output lines suppressed due to ratelimiting
[????3.144075] systemd-gpt-auto-generator[120]: Not a GPT partition table, ignoring.
[????5.381648] random: crng init done
[???13.969940] systemd-cgroups-agent[134]: Sent message type=signal sender=n/a destination=n/a object=/org/freedesktop/systemd1/agent interface=org.freedesktop.systemd1.Agent member=Releasea
[???13.969961] systemd-cgroups-agent[138]: Sent message type=signal sender=n/a destination=n/a object=/org/freedesktop/systemd1/agent interface=org.freedesktop.systemd1.Agent member=Releasea
[???13.969966] systemd-cgroups-agent[139]: Sent message type=signal sender=n/a destination=n/a object=/org/freedesktop/systemd1/agent interface=org.freedesktop.systemd1.Agent member=Releasea
[???13.969970] systemd-cgroups-agent[140]: Sent message type=signal sender=n/a destination=n/a object=/org/freedesktop/systemd1/agent interface=org.freedesktop.systemd1.Agent member=Releasea
[???14.099908] systemd[1]: Got disconnect on private connection.
[???14.119885] systemd[1]: Got disconnect on private connection.
[???14.139889] systemd[1]: Got disconnect on private connection.
[???14.159884] systemd[1]: Got disconnect on private connection.
[???14.632312] systemd-journald[146]: Fixed max_use=98.5M max_size=12.3M min_size=4.0M keep_free=147.8M
[???14.646230] systemd-journald[146]: Reserving 22435 entries in hash table.
[???14.649928] systemd[1]: Got notification message for unit systemd-journald.service
[???14.661340] systemd-journald[146]: Vacuuming...
[???14.664447] systemd-journald[146]: Vacuuming done, freed 0 bytes
[???14.669913] systemd[1]: systemd-journald.service: Got notification message from PID 146 (WATCHDOG=1...)
[???14.680525] systemd-journald[146]: Flushing /dev/kmsg...
[???14.689922] systemd[1]: systemd-journald.service: got WATCHDOG=1
[???14.695361] systemd-journald[146]: Compressed data object 537 -> 288
[???14.709901] systemd[1]: Got notification message for unit systemd-journald.service
[???14.729910] systemd[1]: systemd-journald.service: Got notification message from PID 146 (WATCHDOG=1...)
[???14.740561] systemd-journald[146]: systemd-journald running as pid 146
[???14.969604] systemd-udevd[151]: starting version 215
[???15.091498] s5p-secss 10830000.sss: s5p-sss driver registered
[???15.096251] 12100000.phy supply vbus not found, using dummy regulator
[???15.098979] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[???15.109611] 12100000.phy supply vbus-boost not found, using dummy regulator
[???15.113203] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[???15.115802] ehci-exynos: EHCI EXYNOS driver
[???15.117544] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[???15.121099] ohci-exynos: OHCI EXYNOS driver
[???15.138248] 12130000.phy supply vbus not found, using dummy regulator
[???15.140298] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[???15.152585] 12500000.phy supply vbus not found, using dummy regulator
[???15.154586] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[???15.164901] 12500000.phy supply vbus-boost not found, using dummy regulator
[???15.173098] exynos-ohci 12120000.usb: USB Host Controller
[???15.174726] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[???15.187949] exynos-ohci 12120000.usb: new USB bus registered, assigned bus number 1
[???15.195296] exynos-ohci 12120000.usb: irq 89, io mem 0x12120000
[???15.274045] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[???15.279360] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[???15.279366] usb usb1: Product: USB Host Controller
[???15.279371] usb usb1: Manufacturer: Linux 4.8.0-rc7+ ohci_hcd
[???15.279375] usb usb1: SerialNumber: 12120000.usb
[???15.280187] hub 1-0:1.0: USB hub found
[???15.280246] hub 1-0:1.0: 3 ports detected
[???15.281215] exynos-ehci 12110000.usb: EHCI Host Controller
[???15.281509] exynos-ehci 12110000.usb: new USB bus registered, assigned bus number 2
[???15.281656] exynos-ehci 12110000.usb: irq 89, io mem 0x12110000
[???15.283280] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[???15.309929] exynos-ehci 12110000.usb: USB 2.0 started, EHCI 1.00
[???15.310297] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[???15.310302] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[???15.310307] usb usb2: Product: EHCI Host Controller
[???15.310312] usb usb2: Manufacturer: Linux 4.8.0-rc7+ ehci_hcd
[???15.310317] usb usb2: SerialNumber: 12110000.usb
[???15.310928] hub 2-0:1.0: USB hub found
[???15.310980] hub 2-0:1.0: 3 ports detected
[???15.312172] exynos-dwc3 soc:usb3-0: no suspend clk specified
[???15.313613] usb_phy_generic.0.auto supply vcc not found, using dummy regulator
[???15.314033] usb_phy_generic.1.auto supply vcc not found, using dummy regulator
[???15.315099] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[???15.315395] exynos-dwc3 soc:usb3-1: no suspend clk specified
[???15.317108] usb_phy_generic.2.auto supply vcc not found, using dummy regulator
[???15.317436] usb_phy_generic.3.auto supply vcc not found, using dummy regulator
[???15.318895] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[???15.322074] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[???15.327912] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[???15.330946] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[???15.335605] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
[???15.335844] xhci-hcd xhci-hcd.4.auto: new USB bus registered, assigned bus number 3
[???15.336099] xhci-hcd xhci-hcd.4.auto: hcc params 0x0220f04c hci version 0x100 quirks 0x00010010
[???15.336149] xhci-hcd xhci-hcd.4.auto: irq 135, io mem 0x12000000
[???15.336489] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[???15.336496] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[???15.336501] usb usb3: Product: xHCI Host Controller
[???15.336506] usb usb3: Manufacturer: Linux 4.8.0-rc7+ xhci-hcd
[???15.336511] usb usb3: SerialNumber: xhci-hcd.4.auto
[???15.337095] hub 3-0:1.0: USB hub found
[???15.337142] hub 3-0:1.0: 1 port detected
[???15.337596] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
[???15.337789] xhci-hcd xhci-hcd.4.auto: new USB bus registered, assigned bus number 4
[???15.337927] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[???15.338159] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[???15.338165] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[???15.338169] usb usb4: Product: xHCI Host Controller
[???15.338174] usb usb4: Manufacturer: Linux 4.8.0-rc7+ xhci-hcd
[???15.338179] usb usb4: SerialNumber: xhci-hcd.4.auto
[???15.338847] hub 4-0:1.0: USB hub found
[???15.338896] hub 4-0:1.0: 1 port detected
[???15.339419] xhci-hcd xhci-hcd.5.auto: xHCI Host Controller
[???15.339649] xhci-hcd xhci-hcd.5.auto: new USB bus registered, assigned bus number 5
[???15.339990] xhci-hcd xhci-hcd.5.auto: hcc params 0x0220f04c hci version 0x100 quirks 0x00010010
[???15.340036] xhci-hcd xhci-hcd.5.auto: irq 136, io mem 0x12400000
[???15.340103] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[???15.340329] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[???15.340335] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[???15.340340] usb usb5: Product: xHCI Host Controller
[???15.340344] usb usb5: Manufacturer: Linux 4.8.0-rc7+ xhci-hcd
[???15.340349] usb usb5: SerialNumber: xhci-hcd.5.auto
[???15.340918] hub 5-0:1.0: USB hub found
[???15.340964] hub 5-0:1.0: 1 port detected
[???15.341387] xhci-hcd xhci-hcd.5.auto: xHCI Host Controller
[???15.341618] xhci-hcd xhci-hcd.5.auto: new USB bus registered, assigned bus number 6
[???15.341758] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[???15.341993] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003
[???15.341998] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[???15.342003] usb usb6: Product: xHCI Host Controller
[???15.342008] usb usb6: Manufacturer: Linux 4.8.0-rc7+ xhci-hcd
[???15.342012] usb usb6: SerialNumber: xhci-hcd.5.auto
[???15.342662] hub 6-0:1.0: USB hub found
[???15.342711] hub 6-0:1.0: 1 port detected
[???15.343005] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[???15.346251] [drm:hdmi_probe] *ERROR* Failed to get ddc i2c adapter by node
[???16.007600] EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
[???16.139262] FAT-fs (mmcblk1p1): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
[???16.162644] FAT-fs (mmcblk1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[???16.626154] systemd-journald[146]: Received request to flush runtime journal from PID 1
[???16.633782] systemd-journald[146]: Vacuuming...
[???16.637242] systemd-journald[146]: Vacuuming done, freed 0 bytes
[???17.640723] RPC: Registered named UNIX socket transport module.
[???17.645166] RPC: Registered udp transport module.
[???17.651236] RPC: Registered tcp transport module.
[???17.654524] RPC: Registered tcp NFSv4.1 backchannel transport module.
[???17.672346] FS-Cache: Loaded
[???17.693518] FS-Cache: Netfs 'nfs' registered for caching
[???17.725088] Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
[???19.642578] usb usb5-port1: connect-debounce failed
