From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 7 Apr 2015 12:34:30 +0900
Subject: not syncing: Attempted to kill init! exitcode=0x00000004 ?
Message-ID: <CAK7LNATT8cJoQh+7ZEyUXgMtL0OSYg+69t8wcuNSk+SN+Rwf2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello experts,
I hope this is the correct ML to ask this question.

I am struggling to port Linux-4.0-rc7 onto my SoC/board,
based on ARM cortex-A9 (single CPU), but the kernel fails to boot
with the error:
"not syncing: Attempted to kill init! exitcode=0x00000004"


I want to use NS16550-compatible UART, Global Timer, and GIC.
I wrote a simple device tree source for my own board like this:

------------------>8------------------------------
/dts-v1/;
/include/ "skeleton.dtsi"

/ {
        compatible = "socionext,ph1-ld4";

        memory {
                device_type = "memory";
                reg = <0x80000000 0x20000000>;
        };

        chosen {
                bootargs = "root=/dev/ram0 console=ttyS0,115200";
        };

        aliases {
                serial0 = &uart0;
        };

        cpus {
                #size-cells = <0>;
                #address-cells = <1>;

                cpu at 0 {
                        device_type = "cpu";
                        compatible = "arm,cortex-a9";
                        reg = <0>;
                };
        };

        clocks {
                #address-cells = <1>;
                #size-cells = <0>;

                arm_timer_clk: arm_timer_clk {
                        #clock-cells = <0>;
                        compatible = "fixed-clock";
                        clock-frequency = <50000000>;
                };
        };

        soc: soc {
                compatible = "simple-bus";
                #address-cells = <1>;
                #size-cells = <1>;
                interrupt-parent = <&intc>;
                ranges;


                uart0: uart at 03fb0000 {
                        compatible = "ns16550";
                        reg = <0x03fb0000 0x100>;
                        clock-frequency = <12288000>;
                        interrupts = <0 81 4>;
                        reg-shift = <1>;
                        fifo-size = <16>;
                };

                intc: interrupt-controller at 60001000 {
                        compatible = "arm,cortex-a9-gic";
                        #interrupt-cells = <3>;
                        #address-cells = <1>;
                        interrupt-controller;
                        reg = <0x60001000 0x1000>,
                              <0x60000100 0x100>;
                };

                global_timer: timer at 60000200 {
                        compatible = "arm,cortex-a9-global-timer";
                        reg = <0x60000200 0x20>;
                        interrupts = <1 11 0x104>;
                        interrupt-parent = <&intc>;
                        clocks = <&arm_timer_clk>;
                };

        };
};
-----------------8<--------------------------------


The Kernel configuration is based on multi_v7_defconfig.
The diffconfig against it is like this:
(ARCH_UNIPHIER is intended to enable my SoC)

------------------>8------------------------------
CONFIG_ARCH_UNIPHIER=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=16384
-----------------8<-------------------------------



I passed the kernel image, the device tree, and the initramdisk from U-Boot.

I guess I am almost there, but it looks like the kernel failed to run init.
The kernel log is as follows:


------------------>8------------------------------
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.0.0-rc7-00032-g8c5ce71-dirty
(yamada at beagle) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) )
#7 SMP Tue Apr 7 12:20:19 JST 2015
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: socionext,ph1-ld4
[    0.000000] cma: Reserved 64 MiB at 0x9b000000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] PERCPU: Embedded 11 pages/cpu @dfbc9000 s12480 r8192
d24384 u45056
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 130048
[    0.000000] Kernel command line: root=/dev/ram0 console=ttyS0,115200
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 435456K/524288K available (7830K kernel code,
1015K rwdata, 3412K rodata, 808K init, 316K bss, 23296K reserved,
65536K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0208000 - 0xc0d03b7c   (11247 kB)
[    0.000000]       .init : 0xc0d04000 - 0xc0dce000   ( 808 kB)
[    0.000000]       .data : 0xc0dce000 - 0xc0ecbde0   (1016 kB)
[    0.000000]        .bss : 0xc0ecbde0 - 0xc0f1aee8   ( 317 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Additional per-CPU info printed with stalls.
[    0.000000]  RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] GIC CPU mask not found - kernel will fail to boot.
[    0.000000] GIC CPU mask not found - kernel will fail to boot.
[    0.000025] sched_clock: 64 bits at 50MHz, resolution 20ns, wraps
every 2748779069440ns
[    0.000303] Console: colour dummy device 80x30
[    0.000352] Calibrating delay loop... 1590.88 BogoMIPS (lpj=3977216)
[    0.045071] pid_max: default: 32768 minimum: 301
[    0.045294] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.045314] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.046389] CPU: Testing write buffer coherency: ok
[    0.046870] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.046994] Setting up static identity map for 0x80967f58 - 0x80967ff0
[    0.049163] Brought up 1 CPUs
[    0.049190] SMP: Total of 1 processors activated (1590.88 BogoMIPS).
[    0.049199] CPU: All CPU(s) started in SVC mode.
[    0.050419] devtmpfs: initialized
[    0.051301] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.061250] pinctrl core: initialized pinctrl subsystem
[    0.063944] NET: Registered protocol family 16
[    0.067148] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.069554] cpuidle: using governor ladder
[    0.069590] cpuidle: using governor menu
[    0.071442] No ATAGs?
[    0.071498] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.071514] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.073095] Serial: AMBA PL011 UART driver
[    0.087932] vgaarb: loaded
[    0.089003] SCSI subsystem initialized
[    0.089987] usbcore: registered new interface driver usbfs
[    0.090226] usbcore: registered new interface driver hub
[    0.090365] usbcore: registered new device driver usb
[    0.091406] media: Linux media interface: v0.10
[    0.091507] Linux video capture interface: v2.00
[    0.091592] pps_core: LinuxPPS API ver. 1 registered
[    0.091603] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.091647] PTP clock support registered
[    0.091910] EDAC MC: Ver: 3.0.0
[    0.093456] Advanced Linux Sound Architecture Driver Initialized.
[    0.095220] Switched to clocksource arm_global_timer
[    0.118023] NET: Registered protocol family 2
[    0.119057] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.119124] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.119204] TCP: Hash tables configured (established 4096 bind 4096)
[    0.119319] TCP: reno registered
[    0.119348] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.119401] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.119759] NET: Registered protocol family 1
[    0.120619] RPC: Registered named UNIX socket transport module.
[    0.120644] RPC: Registered udp transport module.
[    0.120652] RPC: Registered tcp transport module.
[    0.120659] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.121342] Trying to unpack rootfs image as initramfs...
[    0.122644] rootfs image is not initramfs (no cpio magic); looks
like an initrd
[    0.167223] Freeing initrd memory: 5188K (df63c000 - dfb4d000)
[    0.169261] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.182066] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.183547] NFS: Registering the id_resolver key type
[    0.183627] Key type id_resolver registered
[    0.183642] Key type id_legacy registered
[    0.183794] ntfs: driver 2.1.31 [Flags: R/O].
[    0.186793] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 248)
[    0.186844] io scheduler noop registered
[    0.186866] io scheduler deadline registered
[    0.187154] io scheduler cfq registered (default)
[    0.333525] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.336695] SuperH (H)SCI(F) driver initialized
[    0.337457] msm_serial: driver initialized
[    0.338486] console [ttyS0] disabled
[    0.338591] 3fb0000.uart: ttyS0 at MMIO 0x3fb0000 (irq = 17,
base_baud = 768000) is a 16550
[    0.929781] console [ttyS0] enabled
[    0.934393] STMicroelectronics ASC driver initialized
[    0.941496] [drm] Initialized drm 1.1.0 20060810
[    0.968284] brd: module loaded
[    0.980523] loop: module loaded
[    0.991125] CAN device driver interface
[    0.996281] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.2.15-k
[    1.003788] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.011641] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB
Ethernet driver
[    1.019633] usbcore: registered new interface driver pegasus
[    1.025809] usbcore: registered new interface driver asix
[    1.031685] usbcore: registered new interface driver ax88179_178a
[    1.038264] usbcore: registered new interface driver cdc_ether
[    1.044590] usbcore: registered new interface driver smsc75xx
[    1.050860] usbcore: registered new interface driver smsc95xx
[    1.057091] usbcore: registered new interface driver net1080
[    1.063240] usbcore: registered new interface driver cdc_subset
[    1.069645] usbcore: registered new interface driver zaurus
[    1.075751] usbcore: registered new interface driver cdc_ncm
[    1.083045] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.090023] ehci-pci: EHCI PCI platform driver
[    1.094893] ehci-platform: EHCI generic platform driver
[    1.100677] ehci-omap: OMAP-EHCI Host Controller driver
[    1.106442] ehci-orion: EHCI orion driver
[    1.110929] SPEAr-ehci: EHCI SPEAr driver
[    1.115419] ehci-st: EHCI STMicroelectronics driver
[    1.120811] ehci-exynos: EHCI EXYNOS driver
[    1.125474] tegra-ehci: Tegra EHCI driver
[    1.129903] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.136537] ohci-pci: OHCI PCI platform driver
[    1.141427] ohci-platform: OHCI generic platform driver
[    1.147208] ohci-omap3: OHCI OMAP3 driver
[    1.151713] SPEAr-ohci: OHCI SPEAr driver
[    1.156205] ohci-st: OHCI STMicroelectronics driver
[    1.161730] usbcore: registered new interface driver usb-storage
[    1.170760] mousedev: PS/2 mouse device common for all mice
[    1.181703] i2c /dev entries driver
[    1.187615] usbcore: registered new interface driver uvcvideo
[    1.193756] USB Video Class driver (1.1.1)
[    1.198133] gspca_main: v2.14.0 registered
[    1.207576] Driver 'mmcblk' needs updating - please use bus_type methods
[    1.214919] sdhci: Secure Digital Host Controller Interface driver
[    1.221490] sdhci: Copyright(c) Pierre Ossman
[    1.227276] Synopsys Designware Multimedia Card Interface Driver
[    1.234878] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.242508] ledtrig-cpu: registered to indicate activity on CPUs
[    1.249360] usbcore: registered new interface driver usbhid
[    1.255312] usbhid: USB HID core driver
[    1.264587] usbcore: registered new interface driver snd-usb-audio
[    1.275364] TCP: cubic registered
[    1.278886] NET: Registered protocol family 17
[    1.283664] can: controller area network core (rev 20120528 abi 9)
[    1.290362] NET: Registered protocol family 29
[    1.295068] can: raw protocol (rev 20120528)
[    1.299648] can: broadcast manager protocol (rev 20120528 t)
[    1.305690] can: netlink gateway (rev 20130117) max_hops=1
[    1.312188] Key type dns_resolver registered
[    1.316955] ThumbEE CPU extension supported.
[    1.321557] Registering SWP/SWPB emulation handler
[    1.331219] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    1.338635] ALSA device list:
[    1.341868]   No soundcards found.
[    1.346495] RAMDISK: gzip image found at block 0
[    2.190565] EXT4-fs (ram0): couldn't mount as ext3 due to feature
incompatibilities
[    2.199105] EXT4-fs (ram0): mounting ext2 file system using the
ext4 subsystem
[    2.208302] EXT4-fs (ram0): mounted filesystem without journal. Opts: (null)
[    2.215918] VFS: Mounted root (ext2 filesystem) readonly on device 1:0.
[    2.223625] devtmpfs: mounted
[    2.228582] Freeing unused kernel memory: 808K (c0d04000 - c0dce000)
[    2.240080] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00000004
[    2.240080]
[    2.249688] CPU: 0 PID: 1 Comm: init Not tainted
4.0.0-rc7-00032-g8c5ce71-dirty #7
[    2.257629] Hardware name: Socionext UniPhier
[    2.262261] [<c02168e8>] (unwind_backtrace) from [<c0212394>]
(show_stack+0x10/0x14)
[    2.270409] [<c0212394>] (show_stack) from [<c0962e4c>]
(dump_stack+0x78/0x94)
[    2.278016] [<c0962e4c>] (dump_stack) from [<c0960694>] (panic+0x90/0x21c)
[    2.285245] [<c0960694>] (panic) from [<c024ea30>] (do_exit+0x838/0x900)
[    2.292281] [<c024ea30>] (do_exit) from [<c024ebc4>]
(do_group_exit+0x3c/0xd0)
[    2.299874] [<c024ebc4>] (do_group_exit) from [<c0257890>]
(get_signal+0x184/0x67c)
[    2.307922] [<c0257890>] (get_signal) from [<c095fb64>]
(do_signal+0x84/0x344)
[    2.315506] [<c095fb64>] (do_signal) from [<c0211fd0>]
(do_work_pending+0xa4/0xb4)
[    2.323456] [<c0211fd0>] (do_work_pending) from [<c020f6e4>]
(work_pending+0xc/0x20)
[    2.331589] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x00000004
[    2.331589]
-----------------8<-------------------------------



What is the cause of the kernel panic?  How to fix it?
Any hint is very appreciated.

Thanks in advance!

-- 
Best Regards
Masahiro Yamada
