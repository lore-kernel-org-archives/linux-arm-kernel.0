From: sakar.arora@nxp.com (Sakar Arora)
Date: Fri, 18 Mar 2016 06:26:47 +0000
Subject: Linux kernel 4.1 boot on arm64 stuck in cpu_do_idle
Message-ID: <DB5PR04MB21663013F59C3F0DA1FBFB41F88C0@DB5PR04MB2166.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Trying to boot custom kernel 4.1 using UEFI bootloader. Using debugger it is seen the PC is in the cpu_do_idle function inside proc.S (the stack traces the call to rest_init() function)

It seems that the init process is not getting scheduled. Can somebody suggest a debug strategy for this?

Here are the logs for reference

[??? 0.000000] Booting Linux on physical CPU 0x0
[??? 0.000000] Initializing cgroup subsys cpu
[??? 0.000000] Linux version 4.1.8-00582-g8683bc6-dirty (b45370 at lvd5567) (gcc version 4.8.3 20131202 (prerelease) (crosstool-NG linaro-1.13.1-4.8-2013.12 - Linaro GCC 2013.11) ) #15 SMP PREEMPT Wed Feb 17 12:06:04 IST 2016
[??? 0.000000] CPU: AArch64 Processor [411fd071] revision 1
[??? 0.000000] Detected PIPT I-cache on CPU0
[??? 0.000000] alternatives: enabling workaround for ARM erratum 832075
[??? 0.000000] alternatives: enabling workaround for ARM erratum 834220
[??? 0.000000] earlycon: Early serial console at MMIO 0x21c0600 (options '')
[??? 0.000000] bootconsole [uart0] enabled
[??? 0.000000] efi: Getting EFI parameters from FDT:
[??? 0.000000] efi: UEFI not found.
[??? 0.000000] cma: Reserved 16 MiB at 0x00000000fe400000
[??? 0.000000] /cpus/cpu at 1: missing enable-method property
[??? 0.000000] /cpus/cpu at 100: missing enable-method property
[??? 0.000000] /cpus/cpu at 101: missing enable-method property
[??? 0.000000] /cpus/cpu at 200: missing enable-method property
[??? 0.000000] /cpus/cpu at 201: missing enable-method property
[??? 0.000000] /cpus/cpu at 300: missing enable-method property
[??? 0.000000] /cpus/cpu at 301: missing enable-method property
[??? 0.000000] PERCPU: Embedded 16 pages/cpu @ffff80007ffcd000 s27904 r8192 d29440 u65536
[??? 0.000000] Built 1 zonelists in Zone order, mobility grouping on.? Total pages: 516096
[??? 0.000000] Kernel command line: console=ttyS1,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256
[??? 0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[??? 0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[??? 0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[??? 0.000000] software IO TLB [mem 0xf8800000-0xfc800000] (64MB) mapped at [ffff800078800000-ffff80007c7fffff]
[??? 0.000000] Memory: 1806596K/2097152K available (5829K kernel code, 456K rwdata, 2512K rodata, 424K init, 205K bss, 274172K reserved, 16384K cma-reserved)
[??? 0.000000] Virtual kernel memory layout:
[??? 0.000000]???? vmalloc : 0xffff000000000000 - 0xffff7bffbfff0000?? (126974 GB)
[??? 0.000000]???? vmemmap : 0xffff7bffc0000000 - 0xffff7fffc0000000?? (? 4096 GB maximum)
[??? 0.000000]?????????????? 0xffff7bffc2000000 - 0xffff7bffc4000000?? (??? 32 MB actual)
[??? 0.000000]???? fixed?? : 0xffff7ffffabfd000 - 0xffff7ffffac00000?? (??? 12 KB)
[??? 0.000000]???? PCI I/O : 0xffff7ffffae00000 - 0xffff7ffffbe00000?? (??? 16 MB)
[??? 0.000000]???? modules : 0xffff7ffffc000000 - 0xffff800000000000?? (??? 64 MB)
[??? 0.000000]???? memory? : 0xffff800000000000 - 0xffff800080000000?? (? 2048 MB)
[??? 0.000000]?????? .init : 0xffff8000008a8000 - 0xffff800000912000?? (?? 424 KB)
[??? 0.000000]?????? .text : 0xffff800000080000 - 0xffff8000008a7674?? (? 8350 KB)
[??? 0.000000]?????? .data : 0xffff80000091b000 - 0xffff80000098d200?? (?? 457 KB)
[??? 0.000000] Preemptible hierarchical RCU implementation.
[??? 0.000000]? Additional per-CPU info printed with stalls.
[??? 0.000000]? RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
[??? 0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[??? 0.000000] NR_IRQS:64 nr_irqs:64 0
[??? 0.000000] ITS: /interrupt-controller at 6000000/gic-its at 6020000
[??? 0.000000] ITS: allocated 8192 Devices @f8420000 (psz 64K, shr 0)
[??? 0.000000] ITS: using cache flushing for cmd queue
[??? 0.000000] GIC: using LPI property table @0x00000000f8430000
[??? 0.000000] ITS: Allocated 1792 chunks for LPIs
[??? 0.000000] CPU0: found redistributor 0 region 0:0x0000000006100000
[??? 0.000000] CPU0: using LPI pending table @0x00000000f8440000
[??? 0.000000] GIC: using cache flushing for LPI property table
[??? 0.000000] Architected cp15 timer(s) running at 25.00MHz (phys).
[??? 0.000000] clocksource arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x5c40939b5, max_idle_ns: 440795202646 ns
[??? 0.000003] sched_clock: 56 bits at 25MHz, resolution 40ns, wraps every 4398046511100ns
[??? 0.010844] Console: colour dummy device 80x25
[??? 0.016787] Calibrating delay loop (skipped), value calculated using timer frequency.. 50.00 BogoMIPS (lpj=250000)
[??? 0.030633] pid_max: default: 32768 minimum: 301
[??? 0.036845] Security Framework initialized
[??? 0.042339] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[??? 0.051298] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[??? 0.061180] Initializing cgroup subsys memory
[??? 0.067017] Initializing cgroup subsys hugetlb
[??? 0.073083] hw perfevents: enabled with arm/armv8-pmuv3 PMU driver, 7 counters available
[??? 0.083926] EFI services will not be available.
[??? 0.143942] Brought up 1 CPUs
[??? 0.147902] SMP: Total of 1 processors activated.
[??? 0.154199] CPU: All CPU(s) started at EL2
[??? 0.159675] alternatives: patching kernel code
[??? 0.167602] devtmpfs: initialized
[??? 0.173701] DMI not present or invalid.
[??? 0.178998] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[??? 0.192482] pinctrl core: initialized pinctrl subsystem
[??? 0.200290] NET: Registered protocol family 16
[??? 0.236357] cpuidle: using governor ladder
[??? 0.266291] cpuidle: using governor menu
[??? 0.271604] fsl-mc bus type registered
[??? 0.276710] MC object device driver fsl_mc_dprc registered
[??? 0.284134] MC object device driver fsl_mc_allocator registered
[??? 0.292126] vdso: 2 pages (1 code @ ffff800000921000, 1 data @ ffff800000920000)
[??? 0.302065] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[??? 0.311697] DMA: preallocated 256 KiB pool for atomic allocations
[??? 0.319960] Serial: AMBA PL011 UART driver
[??? 0.329368] fsl_mc_bus 80c000000.fsl-mc: Root MC bus device probed
[??? 0.337743] fsl_mc_bus 80c000000.fsl-mc: Freescale Management Complex Firmware version: 0.0.0
[??? 0.349283] fsl_mc_dprc dprc.0: ERROR: DPRC version 0.0 not supported
[??? 0.357923] fsl_mc_dprc dprc.0: MC object device probe callback failed: -524
[??? 0.367523] fsl_mc_dprc: probe of dprc.0 failed with error -524
[??? 0.409501] arm-smmu 5000000.iommu: probing hardware configuration...
[??? 0.418262] arm-smmu 5000000.iommu: SMMUv2 with:
[??? 0.424451] arm-smmu 5000000.iommu:? stage 1 translation
[??? 0.431586] arm-smmu 5000000.iommu:? stage 2 translation
[??? 0.438705] arm-smmu 5000000.iommu:? nested translation
[??? 0.445827] arm-smmu 5000000.iommu:? coherent table walk
[??? 0.452948] arm-smmu 5000000.iommu:? stream matching with 128 register groups, mask 0x7fff
[??? 0.464045] arm-smmu 5000000.iommu:? 64 context banks (0 stage-2 only)
[??? 0.472799] arm-smmu 5000000.iommu:? Supported page sizes: 0x60211000
[??? 0.481444] arm-smmu 5000000.iommu:? Stage-1: 48-bit VA -> 48-bit IPA
[??? 0.490079] arm-smmu 5000000.iommu:? Stage-2: 48-bit IPA -> 48-bit PA
[??? 0.498735] arm-smmu 5000000.iommu: registered 1 master devices
[??? 0.507068] vgaarb: loaded
[??? 0.510902] SCSI subsystem initialized
[??? 0.516244] usbcore: registered new interface driver usbfs
[??? 0.523748] usbcore: registered new interface driver hub
[??? 0.530923] usbcore: registered new device driver usb
[??? 0.538060] i2c i2c-0: IMX I2C adapter registered
[??? 0.544355] i2c i2c-0: can't use DMA
[??? 0.549356] pps_core: LinuxPPS API ver. 1 registered
[??? 0.556010] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[??? 0.568333] PTP clock support registered
[??? 0.574074] Switched to clocksource arch_sys_counter
[??? 0.587143] NET: Registered protocol family 2
[??? 0.593623] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[??? 0.603381] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[??? 0.612732] TCP: Hash tables configured (established 16384 bind 16384)
[??? 0.621572] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[??? 0.629658] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[??? 0.638464] NET: Registered protocol family 1
[??? 0.644441] RPC: Registered named UNIX socket transport module.
[??? 0.652376] RPC: Registered udp transport module.
[??? 0.658692] RPC: Registered tcp transport module.
[??? 0.664998] RPC: Registered tcp NFSv4.1 backchannel transport module.
[??? 0.673741] Trying to unpack rootfs image as initramfs...
[??? 0.681197] rootfs image is not initramfs (no cpio magic); looks like an initrd
[??? 0.736225] Freeing initrd memory: 29692K (ffff800006300000 - ffff800007fff000)
[??? 0.746434] kvm [1]: interrupt-controller at c0e0000 IRQ6
[??? 0.753500] kvm [1]: timer IRQ3
[??? 0.757738] kvm [1]: Hyp mode initialized successfully
[??? 0.765892] futex hash table entries: 256 (order: 2, 16384 bytes)
[??? 0.774359] audit: initializing netlink subsys (disabled)
[??? 0.781624] audit: type=2000 audit(0.650:1): initialized
[??? 0.795544] HugeTLB registered 2 MB page size, pre-allocated 256 pages
[??? 0.804678] VFS: Disk quotas dquot_6.6.0
[??? 0.809960] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[??? 0.819520] NFS: Registering the id_resolver key type
[??? 0.826373] Key type id_resolver registered
[??? 0.831974] Key type id_legacy registered
[??? 0.837504] fuse init (API version 7.23)
[??? 0.842980] 9p: Installing v9fs 9p2000 file system support
[??? 0.850834] io scheduler noop registered
[??? 0.856144] io scheduler cfq registered (default)
[??? 0.863445] Freescale LS2 console driver
[??? 0.869129] fsl-ls2-console: device fsl_mc_console registered
[??? 0.876961] fsl-ls2-console: device fsl_aiop_console registered
[??? 0.887053] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[??? 0.897019] msm_serial: driver initialized
[??? 0.902853] 21c0500.serial: ttyS0 at MMIO 0x21c0500 (irq = 7, base_baud = 16666666) is a 16550A
[??? 0.914808] console [ttyS1] disabled
[??? 0.919645] 21c0600.serial: ttyS1 at MMIO 0x21c0600 (irq = 7, base_baud = 16666666) is a 16550A
[??? 0.950109] console [ttyS1] enabled
[??? 0.950109] console [ttyS1] enabled
[??? 0.959457] bootconsole [uart0] disabled
[??? 0.959457] bootconsole [uart0] disabled
[??? 0.970382] Unable to detect cache hierarcy from DT for CPU 0
[??? 0.982171] brd: module loaded
[??? 0.988798] loop: module loaded
[??? 0.994153] libphy: Fixed MDIO Bus: probed
[??? 0.999905] tun: Universal TUN/TAP device driver, 1.6
[??? 1.006906] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[??? 1.015473] libphy: Freescale XGMAC MDIO Bus: probed
[??? 1.022461] mdio_bus 8b96000: timeout waiting for operation to complete
[??? 1.031821] mdio_bus 8b96000: timeout waiting for bus to be free
[??? 1.040212] mdio_bus 8b96000: timeout waiting for bus to be free
[??? 1.048601] mdio_bus 8b96000: timeout waiting for bus to be free
[??? 1.056734] libphy: Freescale XGMAC MDIO Bus: probed
[??? 1.063720] mdio_bus 8b97000: timeout waiting for bus to be free
[??? 1.072130] mdio_bus 8b97000: timeout waiting for bus to be free
[??? 1.080522] mdio_bus 8b97000: timeout waiting for bus to be free
[??? 1.088909] mdio_bus 8b97000: timeout waiting for bus to be free
[??? 1.096987] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[??? 1.106421] e1000: Copyright (c) 1999-2006 Intel Corporation.
[??? 1.114155] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[??? 1.121935] e1000e: Copyright(c) 1999 - 2014 Intel Corporation.
[??? 1.129909] sky2: driver version 1.30
[??? 1.135077] VFIO - User Level meta-driver version: 0.3
[??? 1.142157] vfio_fsl_mc_driver_init: Driver registration fails as no fsl_mc_bus found
[??? 1.153073] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[??? 1.161929] ehci-pci: EHCI PCI platform driver
[??? 1.167944] ehci-platform: EHCI generic platform driver
[??? 1.175005] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[??? 1.183259] ohci-pci: OHCI PCI platform driver
[??? 1.189286] ohci-platform: OHCI generic platform driver
[??? 1.196392] usbcore: registered new interface driver usb-storage
[??? 1.204658] mousedev: PS/2 mouse device common for all mice
[??? 1.212450] i2c /dev entries driver
[??? 1.314113] pca954x 0-0075: probe failed
[??? 1.319732] MC object device driver fsl_dpaa2_caam registered
[??? 1.328034] usbcore: registered new interface driver usbhid
[??? 1.335691] usbhid: USB HID core driver
[??? 1.340891] fsl-mc bus not found, restool driver registration failed
[??? 1.349440] MC object device driver fsl_dpio_drv registered
[??? 1.357011] MC object device driver fsl_dpaa2_eth registered
[??? 1.364623] MC object device driver dpaa2_mac registered
[??? 1.371769] MC object device driver dpaa2_evb registered
[??? 1.378902] MC object device driver dpaa2_ethsw registered
[??? 1.386304] MC object device driver fsl_dce_api registered
[??? 1.393681] MC object device driver dpaa2_rtc registered
[??? 1.400911] Initializing XFRM netlink socket
[??? 1.406631] NET: Registered protocol family 17
[??? 1.412571] NET: Registered protocol family 15
[??? 1.418554] 8021q: 802.1Q VLAN Support v1.8
[??? 1.424173] 9pnet: Installing 9P2000 support
[??? 1.429925] Key type dns_resolver registered
[??? 1.436033] registered taskstats version 1
[??? 1.441670] hctosys: unable to open rtc device (rtc0)
[??? 1.467673] RAMDISK: gzip image found at block 0
[??? 2.086093] VFS: Mounted root (ext2 filesystem) readonly on device 1:0.
[??? 2.095098] devtmpfs: mounted
[??? 2.099336] Freeing unused kernel memory: 424K (ffff8000008a8000 - ffff800000912000)
[??? 2.109711] Freeing alternatives memory: 24K (ffff800000912000 - ffff800000918000)
[?? 92.276320] udevd[669]: starting version 182
[?? 92.556791] random: dd urandom read with 0 bits of entropy available


Thanks
Sakar
