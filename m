From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sun, 11 Dec 2016 18:40:28 +0530
Subject: [PATCH 0/2] ARM: v7-A !MMU fixes for fun (&fame)
Message-ID: <20161211131028.3019-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

ARM core fixes required to bring up !MMU Kernel on v7 Cortex-A.

This was done on top of Vladimir Murzin's !MMU multiplatform series[1].

Platform used was Cortex-A9, AM437x IDK.

Kernel reached the stage of invoking user space init & panicked, though
it could not reach till prompt for want of user space executables, it
went as much as Kernel can help by itself. But that is an issue
independent of the Kernel, hence posting the series (also thought of
at least posting the existing patches b'fore merge window starts).

So far i have not come across a toolchain (or a way to create toolchain)
to create !MMU user space executables for Cortex-A. It is being hoped
that Cortex-R toolchain might help here (Thanks Arnd). This is being
looked into.

multi_v7_defconfig was used & all platforms except TI OMAP/AM/DM/DRA &
Freescale i.MX family was deselected. ARM_MPU option was disabled as
Vladimir had given an early warning. DRAM_BASE was set to 0x80000000.
During the course of bringup, futex was causing issues, hence FUTEX was
removed. L1 & L2 caches were disabled in config. High vectors were
disabled & vectors were made to remap to base of RAM. An additional OMAP
specific change to avoid one ioremap was also required.

2/2th patch has been sticked with RFC label, as, though it works, it
might have to be made robust so as to not cause issue on other v7-A's
upon trying to do !MMU (this won't affect normal MMU boot), or
specifically where security extensions are not enabled. Also effect
of hypervisor extension also need to be considered. Please let know if
any better ways to handle this.

Boot logs at the end.


Afzal Mohammed (2):
  ARM: nommu: allow enabling REMAP_VECTORS_TO_RAM
  ARM: nommu: remap exception base address to RAM

 arch/arm/Kconfig-nommu       | 9 ++++-----
 arch/arm/kernel/head-nommu.S | 6 ++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

[1] "[RFC v2 PATCH 00/23] Allow NOMMU for MULTIPLATFORM",
    http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/470966.html
    (git://linux-arm.org/linux-vm.git nommu-rfc-v2)

[2] Boot log

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.0-rc7-00026-g7a142ca8231b (afzal at debian) (gcc version 6.2.0 (GCC) ) #23 Sun Dec 11 14:59:57 IST 2016
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=00c50478
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: TI AM437x Industrial Development Kit
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] AM437x ES1.2 (sgx neon)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
[    0.000000] Kernel command line: console=ttyO0,115200n8 root=/dev/ram0 rw initrd=0x81800000,8M earlyprintk
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1021276K/1048576K available (6558K kernel code, 523K rwdata, 2096K rodata, 444K init, 274K bss, 27300K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0x80000000 - 0x80001000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0x00000000 - 0xffffffff   (4095 MB)
[    0.000000]     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
[    0.000000]     modules : 0x80000000 - 0xc0000000   (1024 MB)
[    0.000000]       .text : 0x80008000 - 0x8066f948   (6559 kB)
[    0.000000]       .init : 0x8087d000 - 0x808ec000   ( 444 kB)
[    0.000000]       .data : 0x808ec000 - 0x8096ef60   ( 524 kB)
[    0.000000]        .bss : 0x8096ef60 - 0x809b3a9c   ( 275 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] OMAP clockevent source: timer1 at 32786 Hz
[    0.000255] sched_clock: 64 bits at 500MHz, resolution 2ns, wraps every 4398046511103ns
[    0.009514] clocksource: arm_global_timer: mask: 0xffffffffffffffff max_cycles: 0xe6a171a037, max_idle_ns: 881590485102 ns
[    0.021986] Switching to timer-based delay loop, resolution 2ns
[    0.140838] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
[    0.151820] OMAP clocksource: 32k_counter at 32768 Hz
[    0.230698] Console: colour dummy device 80x30
[    0.236205] Calibrating delay loop (skipped), value calculated using timer frequency.. 1000.00 BogoMIPS (lpj=5000000)
[    0.248268] pid_max: default: 32768 minimum: 301
[    0.255822] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.263618] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.322900] devtmpfs: initialized
[    0.936367] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.952252] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.964401] pinctrl core: initialized pinctrl subsystem
[    1.014271] NET: Registered protocol family 16
[    2.116314] cpuidle: using governor menu
[    2.185476] omap_l3_noc 44000000.ocp: L3 debug error: target 8 mod:0 (unclearable)
[    2.195318] omap_l3_noc 44000000.ocp: L3 application error: target 8 mod:0 (unclearable)
[    2.498901] OMAP GPIO hardware version 0.1
[    2.880457] platform 53701000.des: Cannot lookup hwmod 'des'
[    2.897229] platform 48310000.rng: Cannot lookup hwmod 'rng'
[    3.042436] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    3.051608] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    3.067955] omap4_sram_init:Unable to allocate sram needed to handle errata I688
[    3.076481] omap4_sram_init:Unable to get sram pool needed to handle errata I688
[    4.002793] edma 49000000.edma: TI EDMA DMA engine driver
[    4.028172] V3_3D: supplied by V24_0D
[    4.042678] VDD_COREREG: supplied by V24_0D
[    4.058179] VDD_CORE: supplied by VDD_COREREG
[    4.073926] V1_8DREG: supplied by V24_0D
[    4.089154] V1_8D: supplied by V1_8DREG
[    4.104080] V1_5DREG: supplied by V24_0D
[    4.119127] V1_5D: supplied by V1_5DREG
[    4.273112] vgaarb: loaded
[    4.310009] SCSI subsystem initialized
[    4.328627] usbcore: registered new interface driver usbfs
[    4.337597] usbcore: registered new interface driver hub
[    4.345367] usbcore: registered new device driver usb
[    4.366408] omap_i2c 44e0b000.i2c: could not find pctldev for node /ocp at 44000000/l4_wkup at 44c00000/scm at 210000/pinmux at 800/i2c0_pins_default, deferring probe
[    4.382947] omap_i2c 4819c000.i2c: could not find pctldev for node /ocp at 44000000/l4_wkup at 44c00000/scm at 210000/pinmux at 800/i2c2_pins_default, deferring probe
[    4.403752] pps_core: LinuxPPS API ver. 1 registered
[    4.409476] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    4.420441] PTP clock support registered
[    4.432462] EDAC MC: Ver: 3.0.0
[    4.493322] clocksource: Switched to clocksource arm_global_timer
[    4.869692] NET: Registered protocol family 2
[    4.898940] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    4.912636] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    4.925797] TCP: Hash tables configured (established 8192 bind 8192)
[    4.935378] UDP hash table entries: 512 (order: 1, 8192 bytes)
[    4.943318] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
[    4.954721] NET: Registered protocol family 1
[    4.966327] RPC: Registered named UNIX socket transport module.
[    4.973033] RPC: Registered udp transport module.
[    4.978697] RPC: Registered tcp transport module.
[    4.984370] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    5.001882] Trying to unpack rootfs image as initramfs...
[    5.034070] rootfs image is not initramfs (no cpio magic); looks like an initrd
[    6.359174] Freeing initrd memory: 8192K (81800000 - 82000000)
[    6.453302] workingset: timestamp_bits=30 max_order=18 bucket_order=0
[    6.910863] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    6.964046] NFS: Registering the id_resolver key type
[    6.970315] Key type id_resolver registered
[    6.975420] Key type id_legacy registered
[    6.981225] ntfs: driver 2.1.32 [Flags: R/O].
[    7.037313] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    7.045863] io scheduler noop registered
[    7.050452] io scheduler deadline registered
[    7.065425] io scheduler cfq registered (default)
[    7.161373] pinctrl-single 44e10800.pinmux: 199 pins at pa 44e10800 size 796
[    9.535089] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    9.644270] omap_uart 44e09000.serial: no wakeirq for uart0
[    9.650936] omap_uart 44e09000.serial: No clock speed specified: using default: 48000000
[    9.662676] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 29, base_baud = 3000000) is a OMAP UART0
[    9.673897] console [ttyO0] enabled
[    9.673897] console [ttyO0] enabled
[    9.682034] bootconsole [earlycon0] disabled
[    9.682034] bootconsole [earlycon0] disabled
[    9.708232] STMicroelectronics ASC driver initialized
[    9.754052] omap_rng 48310000.rng: _od_fail_runtime_resume: FIXME: missing hwmod/omap_dev info
[    9.764695] omap_rng 48310000.rng: Failed to runtime_get device: -19
[    9.772443] omap_rng 48310000.rng: initialization failed.
[   10.195514] brd: module loaded
[   10.422154] loop: module loaded
[   10.591936] libphy: Fixed MDIO Bus: probed
[   10.662542] CAN device driver interface
[   10.737391] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   10.744646] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   10.754902] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[   10.763205] igb: Copyright (c) 2007-2014 Intel Corporation.
[   10.973943] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6
[   10.981436] davinci_mdio 4a101000.mdio: detected phy mask fffffffe
[   10.999526] libphy: 4a101000.mdio: probed
[   11.004917] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver Micrel KSZ9031 Gigabit PHY
[   11.038793] cpsw 4a100000.ethernet: Detected MACID = c4:be:84:cc:f8:b2
[   11.095184] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
[   11.106034] usbcore: registered new interface driver pegasus
[   11.115479] usbcore: registered new interface driver asix
[   11.124060] usbcore: registered new interface driver ax88179_178a
[   11.133203] usbcore: registered new interface driver cdc_ether
[   11.142987] usbcore: registered new interface driver smsc75xx
[   11.152860] usbcore: registered new interface driver smsc95xx
[   11.161841] usbcore: registered new interface driver net1080
[   11.170867] usbcore: registered new interface driver cdc_subset
[   11.180063] usbcore: registered new interface driver zaurus
[   11.189712] usbcore: registered new interface driver cdc_ncm
[   11.260711] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   11.268771] ehci-pci: EHCI PCI platform driver
[   11.276303] ehci-platform: EHCI generic platform driver
[   11.292469] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   11.300232] ohci-pci: OHCI PCI platform driver
[   11.307765] ohci-platform: OHCI generic platform driver
[   11.320423] ohci-omap3: OHCI OMAP3 driver
[   11.361822] usbcore: registered new interface driver usb-storage
[   11.436768] mousedev: PS/2 mouse device common for all mice
[   11.483706] i2c /dev entries driver
[   11.651196] sdhci: Secure Digital Host Controller Interface driver
[   11.658834] sdhci: Copyright(c) Pierre Ossman
[   11.682975] omap_hsmmc 48060000.mmc: Got CD GPIO
[   11.760972] Synopsys Designware Multimedia Card Interface Driver
[   11.790084] sdhci-pltfm: SDHCI platform and OF driver helper
[   11.838871] ledtrig-cpu: registered to indicate activity on CPUs
[   11.853073] usbcore: registered new interface driver usbhid
[   11.860012] usbhid: USB HID core driver
[   11.907366] NET: Registered protocol family 10
[   11.958684] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   11.995847] NET: Registered protocol family 17
[   12.001416] can: controller area network core (rev 20120528 abi 9)
[   12.011131] NET: Registered protocol family 29
[   12.016810] can: raw protocol (rev 20120528)
[   12.022021] can: broadcast manager protocol (rev 20161123 t)
[   12.029239] can: netlink gateway (rev 20130117) max_hops=1
[   12.050005] Key type dns_resolver registered
[   12.064564] omap_voltage_late_init: Voltage driver support not added
[   12.077074] ThumbEE CPU extension supported.
[   12.308431] mmc0: host does not support reading read-only switch, assuming write-enable
[   12.321471] mmc0: new high speed SDHC card at address 0002
[   12.345989] at24 0-0050: 32768 byte 24c256 EEPROM, writable, 64 bytes/write
[   12.368663] mmcblk0: mmc0:0002 00000 3.66 GiB 
[   12.394788] omap_i2c 44e0b000.i2c: bus 0 rev0.12 at 400 kHz
[   12.421561]  mmcblk0: p1 p2
[   12.461994] omap_i2c 4819c000.i2c: bus 2 rev0.12 at 100 kHz
[   12.492765] input: gpio_keys as /devices/platform/gpio_keys/input/input0
[   12.507921] hctosys: unable to open rtc device (rtc0)
[   12.538496] RAMDISK: gzip image found at block 0
[   15.374579] EXT4-fs (ram0): couldn't mount as ext3 due to feature incompatibilities
[   15.385965] EXT4-fs (ram0): mounting ext2 file system using the ext4 subsystem
[   15.424025] EXT4-fs (ram0): mounted filesystem without journal. Opts: (null)
[   15.432741] VFS: Mounted root (ext2 filesystem) on device 1:0.
[   15.441488] devtmpfs: mounted
[   15.480818] Freeing unused kernel memory: 444K (8087d000 - 808ec000)
[   15.488676] This architecture does not have kernel memory protection.
[   15.502853] Starting init: /sbin/init exists but couldn't execute it (error -8)
[   15.515466] Starting init: /bin/sh exists but couldn't execute it (error -8)
[   15.524269] Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/init.txt for guidance.
[   15.539836] CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.0-rc7-00026-g7a142ca8231b #23
[   15.549157] Hardware name: Generic AM43 (Flattened Device Tree)
[   15.556400] ---[ end Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/init.txt for guidance.

-- 
2.11.0
