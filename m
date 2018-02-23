From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 23 Feb 2018 12:27:55 +0000
Subject: [PATCH 2/3] arm64: dts: rockchip: add rk3328 display nodes
In-Reply-To: <51423eea-c127-4922-bd90-5b05bb5aef48@arm.com>
References: <20180216223817.2821-1-heiko@sntech.de> <2712253.IuLOJ454Fc@phil>
 <ca7e8c5d-55e3-0dc9-1132-f542cb577693@arm.com>
 <2909171.GCRVT3W7gj@phil>
 <51423eea-c127-4922-bd90-5b05bb5aef48@arm.com>
Message-ID: <318d8cd4-7da5-929a-fc01-41558aa12040@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 22/02/18 13:01, Robin Murphy wrote:
> On 21/02/18 21:57, Heiko Stuebner wrote:
> [...]
>>> I guess it might just be a case of the VOP and/or HDMI clocks struggling
>>> to attain an appropriate pixel clock, but the failure mode is really
>>> non-obvious - if the monitor is plugged in at boot I get 4 or 5 of the
>>> DRM_WARNs at various points, about 160 VOP interrupts somewhere along
>>> the line, and HDMI interrupts at a constant rate of around two per
>>> second; plugging it in after boot, however, just seems to silently do
>>> nothing (IIRC hotplugging the TV similarly did work as expected). If I
>>> find the time I might go back and try forcing a 60Hz mode to narrow
>>> things down a bit more.
>>
>> As I only have a standard 1080p display it's hard to check those edge 
>> cases,
>> but the struggle for display frequencies follows us for quite some time
>> already.
>>
>> The current default is to source the display clock from the hdmi-phy
>> which contains its own pll, so I guess first order of business should
>> probably be to determine which rate gets requested for your display
>> and which rate gets set - as I'm guessing that we're missing rates.
>>
>> DRM_WARNS would be interesting I guess, can you post them?
>> As for your hdmi-interrupts, from the dw-hdmi or the hdmi-phy?
> 
> Oops, my mistake, it's just a regular WARN() at 
> drivers/gpu/drm/drm_atomic_helper.c:1348 - the IRQs I'm 99% sure were 
> from dw-hdmi (I really should stop doing this way past bedtime then 
> trying to remember the details days later...)
> 
> I'll turn on all the debug options and do some more digging over the 
> weekend (and actually save some logs this time!)

OK, I found time to do some quick testing last night (verbose log 
attached) - it does indeed look like pretty much all the modes are being 
rejected. Of all the various overrides I tried, "video=800x600 at 60" does 
actually work, but it's the only one (not even plain old 640x480 VGA!)

Interestingly, the vblank timeouts only happen for 1280x1024 modes - 
lower resolutions (e.g. 1024x768) still don't produce an output signal, 
but don't provoke the warning either.

FWIW, the above behaviours also seem reproducible with 
"drm.edid_firmware=edid/{1024x768,1280x1024}.bin" if that helps with 
testing. Otherwise, let me know where to start hacking on drivers ;)

Robin.
-------------- next part --------------
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 4.16.0-rc1-01570-gfe442b615ed0 (robin at m750) (gcc version 7.3.0 (GCC)) #55 SMP PREEMPT Wed Feb 21 00:58:49 GMT 2018
[    0.000000] Machine model: Beelink A1
[    0.000000] earlycon: uart8250 at MMIO32 0x00000000ff130000 (options '')
[    0.000000] bootconsole [uart8250] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 16 MiB at 0x00000000fe000000
[    0.000000] On node 0 totalpages: 1043968
[    0.000000]   DMA32 zone: 16312 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 1043968 pages, LIFO batch:31
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] random: fast init done
[    0.000000] percpu: Embedded 23 pages/cpu @        (ptrval) s55832 r8192 d30184 u94208
[    0.000000] pcpu-alloc: s55832 r8192 d30184 u94208 alloc=23*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1027656
[    0.000000] Kernel command line: earlycon=uart8250,mmio32,0xff130000 root=LABEL=linux-root rootwait rootfstype=ext4 rw drm.debug=0x3f loglevel=9 clk_ignore_unused pd_ignore_unused
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] Memory: 4069936K/4175872K available (7868K kernel code, 578K rwdata, 2832K rodata, 704K init, 332K bss, 89552K reserved, 16384K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000007] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.001379] Console: colour dummy device 80x25
[    0.001806] console [tty0] enabled
[    0.002141] bootconsole [uart8250] disabled
[    0.002570] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.002605] pid_max: default: 32768 minimum: 301
[    0.002744] Security Framework initialized
[    0.002840] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.002892] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.038295] ASID allocator initialised with 32768 entries
[    0.058282] Hierarchical SRCU implementation.
[    0.078731] EFI services will not be available.
[    0.098353] smp: Bringing up secondary CPUs ...
[    0.168564] Detected VIPT I-cache on CPU1
[    0.168642] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.238645] Detected VIPT I-cache on CPU2
[    0.238707] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.308737] Detected VIPT I-cache on CPU3
[    0.308794] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.308907] smp: Brought up 1 node, 4 CPUs
[    0.309012] SMP: Total of 4 processors activated.
[    0.309032] CPU features: detected feature: 32-bit EL0 Support
[    0.309052] CPU features: detected feature: Kernel page table isolation (KPTI)
[    0.312557] CPU: All CPU(s) started at EL2
[    0.312593] alternatives: patching kernel code
[    0.315003] devtmpfs: initialized
[    0.324361] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.324426] futex hash table entries: 1024 (order: 5, 131072 bytes)
[    0.325360] pinctrl core: initialized pinctrl subsystem
[    0.326085] DMI not present or invalid.
[    0.326517] NET: Registered protocol family 16
[    0.327164] audit: initializing netlink subsys (disabled)
[    0.327409] audit: type=2000 audit(0.320:1): state=initialized audit_enabled=0 res=1
[    0.328187] cpuidle: using governor ladder
[    0.328376] cpuidle: using governor menu
[    0.328694] vdso: 2 pages (1 code @ 00000000f44c6ca6, 1 data @ 00000000c356e382)
[    0.328735] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.339734] DMA: preallocated 256 KiB pool for atomic allocations
[    0.339889] Serial: AMBA PL011 UART driver
[    0.367560] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.368073] cryptd: max_cpu_qlen set to 1000
[    0.369281] iommu: Adding device ff370000.vop to group 0
[    0.370120] SCSI subsystem initialized
[    0.370476] libata version 3.00 loaded.
[    0.370769] usbcore: registered new interface driver usbfs
[    0.370838] usbcore: registered new interface driver hub
[    0.370952] usbcore: registered new device driver usb
[    0.371263] media: Linux media interface: v0.10
[    0.371317] Linux video capture interface: v2.00
[    0.371431] pps_core: LinuxPPS API ver. 1 registered
[    0.371452] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.371495] PTP clock support registered
[    0.371762] Advanced Linux Sound Architecture Driver Initialized.
[    0.372846] clocksource: Switched to clocksource arch_sys_counter
[    0.373050] VFS: Disk quotas dquot_6.6.0
[    0.373145] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.381554] NET: Registered protocol family 2
[    0.382210] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes)
[    0.382330] TCP established hash table entries: 32768 (order: 6, 262144 bytes)
[    0.382755] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
[    0.383697] TCP: Hash tables configured (established 32768 bind 32768)
[    0.383975] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.384138] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.384523] NET: Registered protocol family 1
[    0.385154] RPC: Registered named UNIX socket transport module.
[    0.385184] RPC: Registered udp transport module.
[    0.385202] RPC: Registered tcp transport module.
[    0.385220] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.385491] Unpacking initramfs...
[    0.755810] Freeing initrd memory: 4844K
[    0.756996] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
[    0.757304] kvm [1]: 8-bit VMID
[    0.757323] kvm [1]: IDMAP page: 2822000
[    0.757341] kvm [1]: HYP VA range: 4000000000:7fffffffff
[    0.758073] kvm [1]: vgic-v2 at ff814000
[    0.758191] kvm [1]: vgic interrupt IRQ1
[    0.758226] kvm [1]: virtual timer IRQ4
[    0.758352] kvm [1]: Hyp mode initialized successfully
[    0.762161] Initialise system trusted keyrings
[    0.762401] workingset: timestamp_bits=62 max_order=20 bucket_order=0
[    0.771640] NFS: Registering the id_resolver key type
[    0.771706] Key type id_resolver registered
[    0.771725] Key type id_legacy registered
[    0.771753] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.772019] 9p: Installing v9fs 9p2000 file system support
[    0.773869] Key type asymmetric registered
[    0.773907] Asymmetric key parser 'x509' registered
[    0.774181] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.774215] io scheduler noop registered (default)
[    0.774489] io scheduler cfq registered
[    0.774511] io scheduler mq-deadline registered
[    0.774530] io scheduler kyber registered
[    0.780009] dma-pl330 ff1f0000.dmac: Loaded driver for PL330 DMAC-241330
[    0.780058] dma-pl330 ff1f0000.dmac: 	DBUFF-128x8bytes Num_Chans-8 Num_Peri-20 Num_Events-16
[    0.783949] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.785726] ff130000.serial: ttyS2 at MMIO 0xff130000 (irq = 12, base_baud = 1500000) is a 16550A
[    0.850040] console [ttyS2] enabled
[    0.851224] [drm:drm_core_init] Initialized
[    0.853167] [drm:rockchip_drm_bind] IOMMU context initialized (aperture: 0x0-0xffffffff)
[    0.854980] rockchip-vop ff370000.vop: [drm:vop_reg_set] Warning: not support gate
[    0.855676] rockchip-vop ff370000.vop: [drm:vop_reg_set] Warning: not support gate
[    0.856361] rockchip-vop ff370000.vop: [drm:vop_reg_set] Warning: not support gate
[    0.857133] rockchip-drm display-subsystem: bound ff370000.vop (ops vop_component_ops)
[    0.857917] rockchip-drm display-subsystem: failed to bind ff3c0000.hdmi (ops dw_hdmi_rockchip_ops): -517
[    0.859118] rockchip-drm display-subsystem: master bind failed: -517
[    0.869964] loop: module loaded
[    0.871350] libphy: Fixed MDIO Bus: probed
[    0.872233] tun: Universal TUN/TAP device driver, 1.6
[    0.874075] rk_gmac-dwmac ff540000.ethernet: PTP uses main clock
[    0.874677] rk_gmac-dwmac ff540000.ethernet: phy regulator is not available yet, deferred probing
[    0.876063] VFIO - User Level meta-driver version: 0.3
[    0.877713] dwc3 ff600000.dwc3: couldn't register cable notifier
[    0.878275] dwc3 ff600000.dwc3: failed to initialize dual-role
[    0.878880] dwc3: probe of ff600000.dwc3 failed with error -22
[    0.879881] rockchip-usb2phy ff450000.syscon:usb2-phy at 100: Requested PHY is disabled
[    0.880621] dwc2 ff580000.usb: ff580000.usb supply vusb_d not found, using dummy regulator
[    0.881442] dwc2 ff580000.usb: ff580000.usb supply vusb_a not found, using dummy regulator
[    0.892711] dwc2 ff580000.usb: DWC OTG Controller
[    0.893218] dwc2 ff580000.usb: new USB bus registered, assigned bus number 1
[    0.893898] dwc2 ff580000.usb: irq 30, io mem 0xff580000
[    0.895285] hub 1-0:1.0: USB hub found
[    0.895673] hub 1-0:1.0: 1 port detected
[    0.896637] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.897231] ehci-platform: EHCI generic platform driver
[    0.900143] ehci-platform ff5c0000.usb: EHCI Host Controller
[    0.900683] ehci-platform ff5c0000.usb: new USB bus registered, assigned bus number 2
[    0.901796] ehci-platform ff5c0000.usb: irq 31, io mem 0xff5c0000
[    0.922902] ehci-platform ff5c0000.usb: USB 2.0 started, EHCI 1.00
[    0.924286] hub 2-0:1.0: USB hub found
[    0.924669] hub 2-0:1.0: 1 port detected
[    0.925503] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.926090] ohci-platform: OHCI generic platform driver
[    0.926949] ohci-platform ff5d0000.usb: Generic Platform OHCI controller
[    0.927578] ohci-platform ff5d0000.usb: new USB bus registered, assigned bus number 3
[    0.928580] ohci-platform ff5d0000.usb: irq 32, io mem 0xff5d0000
[    0.997689] hub 3-0:1.0: USB hub found
[    0.998077] hub 3-0:1.0: 1 port detected
[    0.999313] usbcore: registered new interface driver usb-storage
[    1.001069] i2c /dev entries driver
[    1.002893] rk808 1-0018: chip id: 0x8050
[    1.004883] rk808-regulator rk808-regulator: there is no dvs0 gpio
[    1.005469] rk808-regulator rk808-regulator: there is no dvs1 gpio
[    1.006087] DCDC_REG1: supplied by regulator-dummy
[    1.007131] DCDC_REG2: supplied by regulator-dummy
[    1.007941] DCDC_REG3: supplied by regulator-dummy
[    1.008576] DCDC_REG4: supplied by regulator-dummy
[    1.009407] LDO_REG1: supplied by regulator-dummy
[    1.010994] LDO_REG2: supplied by regulator-dummy
[    1.012566] LDO_REG3: supplied by regulator-dummy
[    1.014637] rk3x-i2c ff160000.i2c: Initialized RK3xxx I2C bus at 00000000000ddb74
[    1.017106] sdhci: Secure Digital Host Controller Interface driver
[    1.017676] sdhci: Copyright(c) Pierre Ossman
[    1.018103] Synopsys Designware Multimedia Card Interface Driver
[    1.019647] dwmmc_rockchip ff500000.dwmmc: IDMAC supports 32-bit address mode.
[    1.020517] dwmmc_rockchip ff500000.dwmmc: Using internal DMA controller.
[    1.021144] dwmmc_rockchip ff500000.dwmmc: Version ID is 270a
[    1.021741] dwmmc_rockchip ff500000.dwmmc: DW MMC controller at irq 27,32 bit host data width,256 deep fifo
[    1.035584] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
[    1.049951] dwmmc_rockchip ff520000.dwmmc: IDMAC supports 32-bit address mode.
[    1.051073] dwmmc_rockchip ff520000.dwmmc: Using internal DMA controller.
[    1.051709] dwmmc_rockchip ff520000.dwmmc: Version ID is 270a
[    1.052307] dwmmc_rockchip ff520000.dwmmc: DW MMC controller at irq 28,32 bit host data width,256 deep fifo
[    1.053648] mmc_host mmc1: card is non-removable.
[    1.066837] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
[    1.080437] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.082392] ledtrig-cpu: registered to indicate activity on CPUs
[    1.083759] usbcore: registered new interface driver usbhid
[    1.084322] usbhid: USB HID core driver
[    1.086500] NET: Registered protocol family 17
[    1.087027] 9pnet: Installing 9P2000 support
[    1.087549] Key type dns_resolver registered
[    1.088834] registered taskstats version 1
[    1.089218] Loading compiled-in X.509 certificates
[    1.105826] [drm:rockchip_drm_bind] IOMMU context initialized (aperture: 0x0-0xffffffff)
[    1.107639] rockchip-vop ff370000.vop: [drm:vop_reg_set] Warning: not support gate
[    1.108335] rockchip-vop ff370000.vop: [drm:vop_reg_set] Warning: not support gate
[    1.109020] rockchip-vop ff370000.vop: [drm:vop_reg_set] Warning: not support gate
[    1.109805] rockchip-drm display-subsystem: bound ff370000.vop (ops vop_component_ops)
[    1.110792] dwhdmi-rockchip ff3c0000.hdmi: Detected HDMI TX controller v2.11a with HDCP (inno_dw_hdmi_phy2)
[    1.112332] dwhdmi-rockchip ff3c0000.hdmi: registered DesignWare HDMI I2C bus driver
[    1.114255] rockchip-drm display-subsystem: bound ff3c0000.hdmi (ops dw_hdmi_rockchip_ops)
[    1.115023] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.115618] [drm] No driver support for vblank timestamp query.
[    1.115734] mmc_host mmc0: Bus speed (slot 0) = 37500000Hz (slot req 37500000Hz, actual 37500000HZ div = 0)
[    1.116184] [drm:drm_mode_object_get] OBJ ID: 33 (2)
[    1.117104] mmc0: new high speed SDHC card at address aaaa
[    1.117482] [drm:drm_setup_crtcs] 
[    1.118306] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:HDMI-A-1]
[    1.119047] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:HDMI-A-1] status updated from unknown to connected
[    1.119381] mmcblk0: mmc0:aaaa AGGCD 29.7 GiB 
[    1.136844] mmc_host mmc1: Bus speed (slot 0) = 200000000Hz (slot req 200000000Hz, actual 200000000HZ div = 0)
[    1.140697]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
[    1.155731] dwmmc_rockchip ff520000.dwmmc: All phases work, using default phase 0.
[    1.156710] mmc1: new HS200 MMC card at address 0001
[    1.158642] mmcblk1: mmc1:0001 NCard  14.5 GiB 
[    1.160201] mmcblk1boot0: mmc1:0001 NCard  partition 1 4.00 MiB
[    1.161874] mmcblk1boot1: mmc1:0001 NCard  partition 2 4.00 MiB
[    1.162683] mmcblk1rpmb: mmc1:0001 NCard  partition 3 4.00 MiB, chardev (243:0)
[    1.175572] [drm:drm_add_display_info] non_desktop set to 0
[    1.176121] [drm:drm_add_edid_modes] ELD: no CEA Extension found
[    1.176671] [drm:drm_add_display_info] non_desktop set to 0
[    1.177457] [drm:drm_mode_debug_printmodeline] Modeline 35:"1280x1024" 75 135000 1280 1296 1440 1688 1024 1025 1028 1066 0x48 0x5
[    1.178509] [drm:drm_mode_prune_invalid] Not using 1280x1024 mode: BAD
[    1.179114] [drm:drm_mode_debug_printmodeline] Modeline 40:"640x480" 0 31500 640 656 720 840 480 481 484 500 0x40 0xa
[    1.180066] [drm:drm_mode_prune_invalid] Not using 640x480 mode: BAD
[    1.180651] [drm:drm_mode_debug_printmodeline] Modeline 41:"640x480" 0 31500 640 664 704 832 480 489 492 520 0x40 0xa
[    1.181605] [drm:drm_mode_prune_invalid] Not using 640x480 mode: BAD
[    1.182190] [drm:drm_mode_debug_printmodeline] Modeline 42:"640x480" 0 30240 640 704 768 864 480 483 486 525 0x40 0xa
[    1.183174] [drm:drm_mode_prune_invalid] Not using 640x480 mode: BAD
[    1.183763] [drm:drm_mode_debug_printmodeline] Modeline 43:"640x480" 0 25175 640 656 752 800 480 490 492 525 0x40 0xa
[    1.184715] [drm:drm_mode_prune_invalid] Not using 640x480 mode: BAD
[    1.185300] [drm:drm_mode_debug_printmodeline] Modeline 44:"720x400" 0 28320 720 738 846 900 400 412 414 449 0x40 0x6
[    1.186252] [drm:drm_mode_prune_invalid] Not using 720x400 mode: BAD
[    1.186837] [drm:drm_mode_debug_printmodeline] Modeline 46:"1024x768" 0 78750 1024 1040 1136 1312 768 769 772 800 0x40 0x5
[    1.187827] [drm:drm_mode_prune_invalid] Not using 1024x768 mode: BAD
[    1.188420] [drm:drm_mode_debug_printmodeline] Modeline 47:"1024x768" 0 75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
[    1.189411] [drm:drm_mode_prune_invalid] Not using 1024x768 mode: BAD
[    1.190004] [drm:drm_mode_debug_printmodeline] Modeline 49:"832x624" 0 57284 832 864 928 1152 624 625 628 667 0x40 0xa
[    1.190964] [drm:drm_mode_prune_invalid] Not using 832x624 mode: BAD
[    1.191550] [drm:drm_mode_debug_printmodeline] Modeline 50:"800x600" 0 49500 800 816 896 1056 600 601 604 625 0x40 0x5
[    1.192510] [drm:drm_mode_prune_invalid] Not using 800x600 mode: BAD
[    1.193119] [drm:drm_mode_debug_printmodeline] Modeline 51:"800x600" 0 50000 800 856 976 1040 600 637 643 666 0x40 0x5
[    1.194080] [drm:drm_mode_prune_invalid] Not using 800x600 mode: BAD
[    1.194670] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:HDMI-A-1] probed modes :
[    1.195473] [drm:drm_mode_debug_printmodeline] Modeline 36:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
[    1.196524] [drm:drm_mode_debug_printmodeline] Modeline 37:"1152x864" 75 108000 1152 1216 1344 1600 864 865 868 900 0x40 0x5
[    1.197538] [drm:drm_mode_debug_printmodeline] Modeline 48:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[    1.198546] [drm:drm_mode_debug_printmodeline] Modeline 38:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
[    1.199521] [drm:drm_mode_debug_printmodeline] Modeline 39:"800x600" 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
[    1.200495] [drm:drm_setup_crtcs] connector 33 enabled? yes
[    1.201006] [drm:drm_setup_crtcs] looking for cmdline mode on connector 33
[    1.201628] [drm:drm_setup_crtcs] looking for preferred mode on connector 33 0
[    1.202283] [drm:drm_setup_crtcs] found mode 1280x1024
[    1.202753] [drm:drm_setup_crtcs] picking CRTCs for 4096x4096 config
[    1.203355] [drm:drm_setup_crtcs] desired mode 1280x1024 set on crtc 30 (0,0)
[    1.204009] [drm:drm_mode_object_get] OBJ ID: 33 (2)
[    1.213174] [drm:rockchip_drm_fbdev_create] FB [1280x1024]-24 kvaddr=0000000075eecd92 offset=0 size=5242880
[    1.214696] [drm:drm_atomic_state_init] Allocated atomic state 00000000b0f7bedf
[    1.214715] [drm:drm_atomic_get_plane_state] Added [PLANE:28:plane-0] 000000009cacd807 state to 00000000b0f7bedf
[    1.214728] [drm:drm_atomic_get_plane_state] Added [PLANE:29:plane-1] 00000000af4c526d state to 00000000b0f7bedf
[    1.214737] [drm:drm_atomic_set_crtc_for_plane] Link plane state 00000000af4c526d to [NOCRTC]
[    1.214747] [drm:drm_atomic_set_fb_for_plane] Set [NOFB] for plane state 00000000af4c526d
[    1.214760] [drm:drm_atomic_get_plane_state] Added [PLANE:31:plane-2] 00000000522397e4 state to 00000000b0f7bedf
[    1.214768] [drm:drm_atomic_set_crtc_for_plane] Link plane state 00000000522397e4 to [NOCRTC]
[    1.214776] [drm:drm_atomic_set_fb_for_plane] Set [NOFB] for plane state 00000000522397e4
[    1.214792] [drm:drm_atomic_get_crtc_state] Added [CRTC:30:crtc-0] 00000000a52ed97b state to 00000000b0f7bedf
[    1.214810] [drm:drm_atomic_set_mode_for_crtc] Set [MODE:1280x1024] for CRTC state 00000000a52ed97b
[    1.214820] [drm:drm_atomic_set_crtc_for_plane] Link plane state 000000009cacd807 to [CRTC:30:crtc-0]
[    1.214831] [drm:drm_atomic_set_fb_for_plane] Set [FB:40] for plane state 000000009cacd807
[    1.214842] [drm:drm_mode_object_get] OBJ ID: 40 (1)
[    1.214856] [drm:drm_atomic_add_affected_connectors] Adding all current connectors for [CRTC:30:crtc-0] to 00000000b0f7bedf
[    1.214872] [drm:drm_mode_object_get] OBJ ID: 33 (3)
[    1.214882] [drm:drm_atomic_get_connector_state] Added [CONNECTOR:33:HDMI-A-1] 0000000017fcdffb state to 00000000b0f7bedf
[    1.214893] [drm:drm_mode_object_get] OBJ ID: 33 (4)
[    1.214902] [drm:drm_atomic_set_crtc_for_connector] Link connector state 0000000017fcdffb to [CRTC:30:crtc-0]
[    1.214910] [drm:drm_atomic_check_only] checking 00000000b0f7bedf
[    1.214926] [drm:drm_atomic_helper_check_modeset] [CRTC:30:crtc-0] mode changed
[    1.214935] [drm:drm_atomic_helper_check_modeset] [CRTC:30:crtc-0] enable changed
[    1.214943] [drm:drm_atomic_helper_check_modeset] [CRTC:30:crtc-0] active changed
[    1.214957] [drm:drm_atomic_helper_check_modeset] Updating routing for [CONNECTOR:33:HDMI-A-1]
[    1.214969] [drm:drm_atomic_helper_check_modeset] [CONNECTOR:33:HDMI-A-1] using [ENCODER:32:TMDS-32] on [CRTC:30:crtc-0]
[    1.214980] [drm:drm_atomic_helper_check_modeset] [CRTC:30:crtc-0] needs all connectors, enable: y, active: y
[    1.214990] [drm:drm_atomic_add_affected_connectors] Adding all current connectors for [CRTC:30:crtc-0] to 00000000b0f7bedf
[    1.215037] [drm:drm_atomic_commit] committing 00000000b0f7bedf
[    1.215066] [drm:drm_calc_timestamping_constants] crtc 30: hwmode: htotal 1688, vtotal 1066, vdisplay 1024
[    1.215076] [drm:drm_calc_timestamping_constants] crtc 30: clock 108000 kHz framedur 16661185 linedur 15629
[    1.215085] [drm:drm_atomic_helper_commit_modeset_disables] modeset on [ENCODER:32:TMDS-32]
[    1.215098] [drm:drm_atomic_helper_commit_modeset_enables] enabling [CRTC:30:crtc-0]
[    1.215588] [drm:drm_crtc_vblank_on] crtc 0, vblank enabled 0, inmodeset 0
[    1.215605] rockchip-vop ff370000.vop: [drm:vop_reg_set] Warning: not support pin_pol
[    1.215624] [drm:drm_atomic_helper_commit_modeset_enables] enabling [ENCODER:32:TMDS-32]
[    1.215856] [drm:drm_vblank_enable] enabling vblank on crtc 0, ret: 0
[    1.215868] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=1, diff=0, hw=0 hw_last=0
[    1.216361] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=1, diff=1, hw=0 hw_last=0
[    1.216404] [drm:drm_mode_object_get] OBJ ID: 40 (2)
[    1.216415] [drm:drm_atomic_state_default_clear] Clearing atomic state 00000000b0f7bedf
[    1.216429] [drm:drm_mode_object_put.part.0] OBJ ID: 33 (5)
[    1.216442] [drm:__drm_atomic_state_free] Freeing atomic state 00000000b0f7bedf
[    1.216554] [drm:drm_atomic_state_init] Allocated atomic state 00000000197d29df
[    1.216566] [drm:drm_mode_object_get] OBJ ID: 40 (3)
[    1.216577] [drm:drm_atomic_get_plane_state] Added [PLANE:28:plane-0] 000000009d5a21bd state to 00000000197d29df
[    1.216588] [drm:drm_mode_object_get] OBJ ID: 41 (1)
[    1.216598] [drm:drm_atomic_get_crtc_state] Added [CRTC:30:crtc-0] 0000000029be798e state to 00000000197d29df
[    1.216609] [drm:drm_atomic_get_plane_state] Added [PLANE:29:plane-1] 00000000e0ea9681 state to 00000000197d29df
[    1.216618] [drm:drm_atomic_set_crtc_for_plane] Link plane state 00000000e0ea9681 to [NOCRTC]
[    1.216626] [drm:drm_atomic_set_fb_for_plane] Set [NOFB] for plane state 00000000e0ea9681
[    1.216637] [drm:drm_atomic_get_plane_state] Added [PLANE:31:plane-2] 000000000be16b62 state to 00000000197d29df
[    1.216645] [drm:drm_atomic_set_crtc_for_plane] Link plane state 000000000be16b62 to [NOCRTC]
[    1.216654] [drm:drm_atomic_set_fb_for_plane] Set [NOFB] for plane state 000000000be16b62
[    1.216665] [drm:drm_mode_object_put.part.0] OBJ ID: 41 (2)
[    1.216683] [drm:drm_atomic_set_mode_for_crtc] Set [MODE:1280x1024] for CRTC state 0000000029be798e
[    1.216692] [drm:drm_atomic_set_crtc_for_plane] Link plane state 000000009d5a21bd to [CRTC:30:crtc-0]
[    1.216701] [drm:drm_atomic_set_fb_for_plane] Set [FB:40] for plane state 000000009d5a21bd
[    1.216710] [drm:drm_mode_object_get] OBJ ID: 40 (4)
[    1.216719] [drm:drm_mode_object_put.part.0] OBJ ID: 40 (5)
[    1.216730] [drm:drm_atomic_add_affected_connectors] Adding all current connectors for [CRTC:30:crtc-0] to 00000000197d29df
[    1.216742] [drm:drm_mode_object_get] OBJ ID: 33 (5)
[    1.216751] [drm:drm_mode_object_get] OBJ ID: 33 (6)
[    1.216761] [drm:drm_atomic_get_connector_state] Added [CONNECTOR:33:HDMI-A-1] 00000000ef486e14 state to 00000000197d29df
[    1.216772] [drm:drm_mode_object_put.part.0] OBJ ID: 33 (6)
[    1.216781] [drm:drm_atomic_set_crtc_for_connector] Link connector state 00000000ef486e14 to [NOCRTC]
[    1.216790] [drm:drm_mode_object_get] OBJ ID: 33 (5)
[    1.216800] [drm:drm_atomic_set_crtc_for_connector] Link connector state 00000000ef486e14 to [CRTC:30:crtc-0]
[    1.216807] [drm:drm_atomic_check_only] checking 00000000197d29df
[    1.216823] [drm:drm_atomic_helper_check_modeset] Updating routing for [CONNECTOR:33:HDMI-A-1]
[    1.216836] [drm:drm_atomic_helper_check_modeset] [CONNECTOR:33:HDMI-A-1] keeps [ENCODER:32:TMDS-32], now on [CRTC:30:crtc-0]
[    1.216850] [drm:drm_atomic_commit] committing 00000000197d29df
[    1.216873] [drm:drm_calc_timestamping_constants] crtc 30: hwmode: htotal 1688, vtotal 1066, vdisplay 1024
[    1.216883] [drm:drm_calc_timestamping_constants] crtc 30: clock 108000 kHz framedur 16661185 linedur 15629
[    1.272872] ------------[ cut here ]------------
[    1.272877] [CRTC:30:crtc-0] vblank wait timed out
[    1.272937] WARNING: CPU: 1 PID: 35 at drivers/gpu/drm/drm_atomic_helper.c:1349 drm_atomic_helper_wait_for_vblanks.part.8+0x2a0/0x2a8
[    1.272940] Modules linked in:
[    1.272954] CPU: 1 PID: 35 Comm: kworker/1:1 Not tainted 4.16.0-rc1-01570-gfe442b615ed0 #55
[    1.272958] Hardware name: Beelink A1 (DT)
[    1.272973] Workqueue: events deferred_probe_work_func
[    1.272983] pstate: 40000005 (nZcv daif -PAN -UAO)
[    1.272991] pc : drm_atomic_helper_wait_for_vblanks.part.8+0x2a0/0x2a8
[    1.272998] lr : drm_atomic_helper_wait_for_vblanks.part.8+0x2a0/0x2a8
[    1.273001] sp : ffffff8008d73220
[    1.273005] x29: ffffff8008d73220 x28: 0000000000000000 
[    1.273014] x27: 0000000000000002 x26: ffffffc0f8412000 
[    1.273023] x25: 0000000000000001 x24: 0000000000000000 
[    1.273031] x23: 0000000000000030 x22: 0000000000000001 
[    1.273039] x21: ffffffc0f75d1280 x20: ffffffc0f8da1018 
[    1.273047] x19: 0000000000000000 x18: 0000000000020000 
[    1.273055] x17: 0000000000000008 x16: ffffff8008c2bc80 
[    1.273064] x15: 00000000fffffff0 x14: ffffff8008bcfc20 
[    1.273072] x13: ffffff8008c490f0 x12: ffffff8008bcf000 
[    1.273080] x11: 0000000000000000 x10: ffffff8008c48000 
[    1.273088] x9 : 0000000000000000 x8 : ffffff8008c526cc 
[    1.273096] x7 : 0000000000000000 x6 : 0000000008d5a9c9 
[    1.273104] x5 : 0000000000000000 x4 : 0000000000000000 
[    1.273112] x3 : ffffffffffffffff x2 : 00000040f53eb000 
[    1.273120] x1 : 8c20204912c27300 x0 : 0000000000000000 
[    1.273128] Call trace:
[    1.273137]  drm_atomic_helper_wait_for_vblanks.part.8+0x2a0/0x2a8
[    1.273144]  drm_atomic_helper_commit_tail_rpm+0x58/0x70
[    1.273150]  commit_tail+0x44/0x78
[    1.273156]  drm_atomic_helper_commit+0xec/0x178
[    1.273163]  drm_atomic_commit+0x50/0x60
[    1.273171]  restore_fbdev_mode_atomic+0x1b4/0x248
[    1.273178]  drm_fb_helper_pan_display+0xa4/0x1d0
[    1.273188]  fb_pan_display+0x94/0x118
[    1.273197]  bit_update_start+0x1c/0x40
[    1.273205]  fbcon_switch+0x34c/0x5a8
[    1.273215]  redraw_screen+0x170/0x280
[    1.273222]  fbcon_prepare_logo+0x318/0x398
[    1.273229]  fbcon_init+0x390/0x5a8
[    1.273237]  visual_init+0xb4/0x108
[    1.273245]  do_bind_con_driver+0x1bc/0x3c8
[    1.273253]  do_take_over_console+0xa4/0x210
[    1.273261]  do_fbcon_takeover+0x6c/0xf0
[    1.273269]  fbcon_event_notify+0x9d0/0xa48
[    1.273278]  notifier_call_chain+0x50/0x90
[    1.273285]  blocking_notifier_call_chain+0x48/0x70
[    1.273291]  fb_notifier_call_chain+0x1c/0x28
[    1.273297]  register_framebuffer+0x22c/0x338
[    1.273308]  __drm_fb_helper_initial_config_and_unlock+0x214/0x428
[    1.273316]  drm_fb_helper_initial_config+0x40/0x50
[    1.273325]  rockchip_drm_fbdev_init+0x78/0x170
[    1.273333]  rockchip_drm_bind+0xbc/0x1d8
[    1.273341]  try_to_bring_up_master+0x178/0x1d8
[    1.273348]  component_master_add_with_match+0xc0/0x118
[    1.273355]  rockchip_drm_platform_probe+0x18c/0x2a0
[    1.273362]  platform_drv_probe+0x58/0xb8
[    1.273371]  driver_probe_device+0x23c/0x310
[    1.273379]  __device_attach_driver+0x9c/0xf8
[    1.273387]  bus_for_each_drv+0x68/0xd0
[    1.273395]  __device_attach+0xd8/0x138
[    1.273403]  device_initial_probe+0x10/0x18
[    1.273411]  bus_probe_device+0x94/0xa0
[    1.273418]  deferred_probe_work_func+0xa0/0x148
[    1.273427]  process_one_work+0x1d4/0x330
[    1.273433]  worker_thread+0x244/0x470
[    1.273442]  kthread+0x128/0x130
[    1.273451]  ret_from_fork+0x10/0x18
[    1.273456] ---[ end trace 68a2b16ad2774692 ]---
[    1.273472] [drm:drm_mode_object_get] OBJ ID: 40 (4)
[    1.273482] [drm:drm_mode_object_put.part.0] OBJ ID: 40 (5)
[    1.273493] [drm:drm_atomic_state_default_clear] Clearing atomic state 00000000197d29df
[    1.273502] [drm:drm_mode_object_put.part.0] OBJ ID: 33 (6)
[    1.273512] [drm:drm_mode_object_put.part.0] OBJ ID: 33 (5)
[    1.273522] [drm:drm_mode_object_put.part.0] OBJ ID: 41 (1)
[    1.273538] [drm:drm_mode_object_put.part.0] OBJ ID: 40 (4)
[    1.273549] [drm:__drm_atomic_state_free] Freeing atomic state 00000000197d29df
[    1.291326] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=2, diff=1, hw=0 hw_last=0
[    1.304862] Console: switching to colour frame buffer device 160x64
[    1.304900] [drm:drm_atomic_state_init] Allocated atomic state 00000000705f1bde
[    1.304912] [drm:drm_mode_object_get] OBJ ID: 40 (3)
[    1.304923] [drm:drm_atomic_get_plane_state] Added [PLANE:28:plane-0] 000000001fb7e1dd state to 00000000705f1bde
[    1.304935] [drm:drm_mode_object_get] OBJ ID: 42 (1)
[    1.304945] [drm:drm_atomic_get_crtc_state] Added [CRTC:30:crtc-0] 00000000a52ed97b state to 00000000705f1bde
[    1.304957] [drm:drm_atomic_get_plane_state] Added [PLANE:29:plane-1] 00000000522397e4 state to 00000000705f1bde
[    1.304965] [drm:drm_atomic_set_crtc_for_plane] Link plane state 00000000522397e4 to [NOCRTC]
[    1.304973] [drm:drm_atomic_set_fb_for_plane] Set [NOFB] for plane state 00000000522397e4
[    1.304984] [drm:drm_atomic_get_plane_state] Added [PLANE:31:plane-2] 00000000af4c526d state to 00000000705f1bde
[    1.304992] [drm:drm_atomic_set_crtc_for_plane] Link plane state 00000000af4c526d to [NOCRTC]
[    1.305000] [drm:drm_atomic_set_fb_for_plane] Set [NOFB] for plane state 00000000af4c526d
[    1.305012] [drm:drm_mode_object_put.part.0] OBJ ID: 42 (2)
[    1.305028] [drm:drm_atomic_set_mode_for_crtc] Set [MODE:1280x1024] for CRTC state 00000000a52ed97b
[    1.305038] [drm:drm_atomic_set_crtc_for_plane] Link plane state 000000001fb7e1dd to [CRTC:30:crtc-0]
[    1.305048] [drm:drm_atomic_set_fb_for_plane] Set [FB:40] for plane state 000000001fb7e1dd
[    1.305056] [drm:drm_mode_object_get] OBJ ID: 40 (4)
[    1.305066] [drm:drm_mode_object_put.part.0] OBJ ID: 40 (5)
[    1.305078] [drm:drm_atomic_add_affected_connectors] Adding all current connectors for [CRTC:30:crtc-0] to 00000000705f1bde
[    1.305091] [drm:drm_mode_object_get] OBJ ID: 33 (5)
[    1.305100] [drm:drm_mode_object_get] OBJ ID: 33 (6)
[    1.305110] [drm:drm_atomic_get_connector_state] Added [CONNECTOR:33:HDMI-A-1] 0000000017fcdffb state to 00000000705f1bde
[    1.305120] [drm:drm_mode_object_put.part.0] OBJ ID: 33 (6)
[    1.305129] [drm:drm_atomic_set_crtc_for_connector] Link connector state 0000000017fcdffb to [NOCRTC]
[    1.305138] [drm:drm_mode_object_get] OBJ ID: 33 (5)
[    1.305148] [drm:drm_atomic_set_crtc_for_connector] Link connector state 0000000017fcdffb to [CRTC:30:crtc-0]
[    1.305156] [drm:drm_atomic_check_only] checking 00000000705f1bde
[    1.305171] [drm:drm_atomic_helper_check_modeset] Updating routing for [CONNECTOR:33:HDMI-A-1]
[    1.305184] [drm:drm_atomic_helper_check_modeset] [CONNECTOR:33:HDMI-A-1] keeps [ENCODER:32:TMDS-32], now on [CRTC:30:crtc-0]
[    1.305201] [drm:drm_atomic_commit] committing 00000000705f1bde
[    1.305225] [drm:drm_calc_timestamping_constants] crtc 30: hwmode: htotal 1688, vtotal 1066, vdisplay 1024
[    1.305235] [drm:drm_calc_timestamping_constants] crtc 30: clock 108000 kHz framedur 16661185 linedur 15629
[    1.332870] usb 1-1: new full-speed USB device number 2 using dwc2
[    1.362862] ------------[ cut here ]------------
[    1.362867] [CRTC:30:crtc-0] vblank wait timed out
[    1.362924] WARNING: CPU: 1 PID: 35 at drivers/gpu/drm/drm_atomic_helper.c:1349 drm_atomic_helper_wait_for_vblanks.part.8+0x2a0/0x2a8
[    1.362927] Modules linked in:
[    1.362942] CPU: 1 PID: 35 Comm: kworker/1:1 Tainted: G        W        4.16.0-rc1-01570-gfe442b615ed0 #55
[    1.362945] Hardware name: Beelink A1 (DT)
[    1.362959] Workqueue: events deferred_probe_work_func
[    1.362968] pstate: 40000005 (nZcv daif -PAN -UAO)
[    1.362975] pc : drm_atomic_helper_wait_for_vblanks.part.8+0x2a0/0x2a8
[    1.362983] lr : drm_atomic_helper_wait_for_vblanks.part.8+0x2a0/0x2a8
[    1.362986] sp : ffffff8008d73350
[    1.362989] x29: ffffff8008d73350 x28: 0000000000000000 
[    1.362998] x27: 0000000000000003 x26: ffffffc0f8412000 
[    1.363006] x25: 0000000000000001 x24: 0000000000000000 
[    1.363014] x23: 0000000000000030 x22: 0000000000000001 
[    1.363022] x21: ffffffc0f75d1080 x20: ffffffc0f8da1018 
[    1.363030] x19: 0000000000000000 x18: 0000000000020000 
[    1.363039] x17: 0000000000000008 x16: ffffff8008c2bc80 
[    1.363047] x15: 00000000fffffff0 x14: ffffff8008bcfc20 
[    1.363055] x13: ffffff8008c490f0 x12: ffffff8008bcf000 
[    1.363063] x11: 0000000000000000 x10: ffffff8008c48000 
[    1.363071] x9 : 0000000000000000 x8 : ffffff8008c543d0 
[    1.363079] x7 : 0000000000000000 x6 : 0000000008d5a9c9 
[    1.363087] x5 : 0000000000000000 x4 : 0000000000000000 
[    1.363095] x3 : ffffffffffffffff x2 : 00000040f53eb000 
[    1.363102] x1 : 8c20204912c27300 x0 : 0000000000000000 
[    1.363110] Call trace:
[    1.363119]  drm_atomic_helper_wait_for_vblanks.part.8+0x2a0/0x2a8
[    1.363126]  drm_atomic_helper_commit_tail_rpm+0x58/0x70
[    1.363133]  commit_tail+0x44/0x78
[    1.363139]  drm_atomic_helper_commit+0xec/0x178
[    1.363145]  drm_atomic_commit+0x50/0x60
[    1.363153]  restore_fbdev_mode_atomic+0x1b4/0x248
[    1.363161]  drm_fb_helper_pan_display+0xa4/0x1d0
[    1.363169]  fb_pan_display+0x94/0x118
[    1.363178]  bit_update_start+0x1c/0x40
[    1.363186]  fbcon_switch+0x34c/0x5a8
[    1.363195]  redraw_screen+0x170/0x280
[    1.363204]  do_bind_con_driver+0x3b8/0x3c8
[    1.363212]  do_take_over_console+0xa4/0x210
[    1.363219]  do_fbcon_takeover+0x6c/0xf0
[    1.363227]  fbcon_event_notify+0x9d0/0xa48
[    1.363235]  notifier_call_chain+0x50/0x90
[    1.363241]  blocking_notifier_call_chain+0x48/0x70
[    1.363247]  fb_notifier_call_chain+0x1c/0x28
[    1.363254]  register_framebuffer+0x22c/0x338
[    1.363263]  __drm_fb_helper_initial_config_and_unlock+0x214/0x428
[    1.363271]  drm_fb_helper_initial_config+0x40/0x50
[    1.363280]  rockchip_drm_fbdev_init+0x78/0x170
[    1.363288]  rockchip_drm_bind+0xbc/0x1d8
[    1.363296]  try_to_bring_up_master+0x178/0x1d8
[    1.363302]  component_master_add_with_match+0xc0/0x118
[    1.363310]  rockchip_drm_platform_probe+0x18c/0x2a0
[    1.363317]  platform_drv_probe+0x58/0xb8
[    1.363326]  driver_probe_device+0x23c/0x310
[    1.363334]  __device_attach_driver+0x9c/0xf8
[    1.363342]  bus_for_each_drv+0x68/0xd0
[    1.363350]  __device_attach+0xd8/0x138
[    1.363358]  device_initial_probe+0x10/0x18
[    1.363366]  bus_probe_device+0x94/0xa0
[    1.363373]  deferred_probe_work_func+0xa0/0x148
[    1.363381]  process_one_work+0x1d4/0x330
[    1.363388]  worker_thread+0x244/0x470
[    1.363396]  kthread+0x128/0x130
[    1.363405]  ret_from_fork+0x10/0x18
[    1.363409] ---[ end trace 68a2b16ad2774693 ]---
[    1.363425] [drm:drm_mode_object_get] OBJ ID: 40 (4)
[    1.363435] [drm:drm_mode_object_put.part.0] OBJ ID: 40 (5)
[    1.363445] [drm:drm_atomic_state_default_clear] Clearing atomic state 00000000705f1bde
[    1.363455] [drm:drm_mode_object_put.part.0] OBJ ID: 33 (6)
[    1.363465] [drm:drm_mode_object_put.part.0] OBJ ID: 33 (5)
[    1.363475] [drm:drm_mode_object_put.part.0] OBJ ID: 42 (1)
[    1.363491] [drm:drm_mode_object_put.part.0] OBJ ID: 40 (4)
[    1.363502] [drm:__drm_atomic_state_free] Freeing atomic state 00000000705f1bde
[    1.366299] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=3, diff=1, hw=0 hw_last=0
[    1.441273] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=4, diff=1, hw=0 hw_last=0
[    1.442114] rockchip-drm display-subsystem: fb0:  frame buffer device
[    1.516251] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=5, diff=1, hw=0 hw_last=0
[    3.805498] [drm:drm_minor_register] 
[    3.805513] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=6, diff=1, hw=0 hw_last=0
[    3.821498] [drm:drm_minor_register] 
[    3.829428] [drm:drm_minor_register] 
[    3.838147] [drm:drm_minor_register] new minor registered 0
[    3.840506] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=7, diff=1, hw=0 hw_last=0
[    3.846623] [drm:drm_sysfs_connector_add] adding "HDMI-A-1" to sysfs
[    3.863767] [drm:drm_sysfs_hotplug_event] generating hotplug event
[    3.872286] [drm] Initialized rockchip 1.0.0 20140818 for display-subsystem on minor 0
[    3.882196] rk_gmac-dwmac ff540000.ethernet: PTP uses main clock
[    3.891059] rk_gmac-dwmac ff540000.ethernet: clock input or output? (input).
[    3.899882] rk_gmac-dwmac ff540000.ethernet: TX delay(0x26).
[    3.908533] rk_gmac-dwmac ff540000.ethernet: RX delay(0x11).
[    3.915485] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=8, diff=1, hw=0 hw_last=0
[    3.917094] rk_gmac-dwmac ff540000.ethernet: integrated PHY? (no).
[    3.935430] rk_gmac-dwmac ff540000.ethernet: clock input from PHY
[    3.949435] rk_gmac-dwmac ff540000.ethernet: init for RGMII
[    3.958394] stmmac - user ID: 0x10, Synopsys ID: 0x35
[    3.967290] rk_gmac-dwmac ff540000.ethernet: Ring mode enabled
[    3.976341] rk_gmac-dwmac ff540000.ethernet: DMA HW capability register supported
[    3.985624] rk_gmac-dwmac ff540000.ethernet: Normal descriptors
[    3.990445] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=9, diff=1, hw=0 hw_last=0
[    3.994758] rk_gmac-dwmac ff540000.ethernet: RX Checksum Offload Engine supported
[    4.014242] rk_gmac-dwmac ff540000.ethernet: COE Type 2
[    4.023692] rk_gmac-dwmac ff540000.ethernet: TX Checksum insertion supported
[    4.033349] rk_gmac-dwmac ff540000.ethernet: Wake-Up On Lan supported
[    4.042996] rk_gmac-dwmac ff540000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[    4.053659] input: Logitech USB Receiver as /devices/platform/ff580000.usb/usb1/1-1/1-1:1.0/0003:046D:C52B.0001/input/input0
[    4.065436] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=10, diff=1, hw=0 hw_last=0
[    4.133669] hid-generic 0003:046D:C52B.0001: input: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-ff580000.usb-1/input0
[    4.140412] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=11, diff=1, hw=0 hw_last=0
[    4.161162] input: Logitech USB Receiver as /devices/platform/ff580000.usb/usb1/1-1/1-1:1.1/0003:046D:C52B.0002/input/input1
[    4.178242] libphy: stmmac: probed
[    4.188905] RTL8211F Gigabit Ethernet stmmac-0:00: attached PHY driver [RTL8211F Gigabit Ethernet] (mii_bus:phy_addr=stmmac-0:00, irq=POLL)
[    4.200906] RTL8211F Gigabit Ethernet stmmac-0:01: attached PHY driver [RTL8211F Gigabit Ethernet] (mii_bus:phy_addr=stmmac-0:01, irq=POLL)
[    4.213732] hctosys: unable to open rtc device (rtc0)
[    4.215389] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=12, diff=1, hw=0 hw_last=0
[    4.225335] clk: Not disabling unused clocks
[    4.248908] ALSA device list:
[    4.260435] hid-generic 0003:046D:C52B.0002: input: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-ff580000.usb-1/input1
[    4.272876]   No soundcards found.
[    4.277975] hid-generic 0003:046D:C52B.0003: device has no listeners, quitting
[    4.290368] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=13, diff=1, hw=0 hw_last=0
[    4.311171] ttyS2 - failed to request DMA
[    4.324395] Freeing unused kernel memory: 704K
[    4.365362] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=14, diff=1, hw=0 hw_last=0
[    4.440324] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=15, diff=1, hw=0 hw_last=0
[    4.515313] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=16, diff=1, hw=0 hw_last=0
[    4.590301] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=17, diff=1, hw=0 hw_last=0
[    4.665267] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=18, diff=1, hw=0 hw_last=0
[    4.740228] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=19, diff=1, hw=0 hw_last=0
[    4.815200] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=20, diff=1, hw=0 hw_last=0
[    4.883005] [drm:drm_sysfs_hotplug_event] generating hotplug event
[    4.890182] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=21, diff=1, hw=0 hw_last=0
[    4.903075] [drm:drm_fb_helper_hotplug_event.part.28] 
[    4.922928] [drm:drm_setup_crtcs] 
[    4.935887] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:HDMI-A-1]
[    4.965209] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=22, diff=1, hw=0 hw_last=0
[    5.024648] [drm:drm_add_display_info] non_desktop set to 0
[    5.038487] [drm:drm_mode_object_put.part.0] OBJ ID: 34 (1)
[    5.040193] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=23, diff=1, hw=0 hw_last=0
[    5.051400] [drm:drm_add_edid_modes] ELD: no CEA Extension found
[    5.078135] [drm:drm_add_display_info] non_desktop set to 0
[    5.091897] [drm:drm_mode_debug_printmodeline] Modeline 34:"1280x1024" 75 135000 1280 1296 1440 1688 1024 1025 1028 1066 0x48 0x5
[    5.106219] [drm:drm_mode_prune_invalid] Not using 1280x1024 mode: BAD
[    5.115142] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=24, diff=1, hw=0 hw_last=0
[    5.119751] [drm:drm_mode_debug_printmodeline] Modeline 47:"640x480" 0 31500 640 656 720 840 480 481 484 500 0x40 0xa
[    5.148006] [drm:drm_mode_prune_invalid] Not using 640x480 mode: BAD
[    5.161972] [drm:drm_mode_debug_printmodeline] Modeline 49:"640x480" 0 31500 640 664 704 832 480 489 492 520 0x40 0xa
[    5.176564] [drm:drm_mode_prune_invalid] Not using 640x480 mode: BAD
[    5.190139] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=25, diff=1, hw=0 hw_last=0
[    5.190691] [drm:drm_mode_debug_printmodeline] Modeline 50:"640x480" 0 30240 640 704 768 864 480 483 486 525 0x40 0xa
[    5.220155] [drm:drm_mode_prune_invalid] Not using 640x480 mode: BAD
[    5.234644] [drm:drm_mode_debug_printmodeline] Modeline 51:"640x480" 0 25175 640 656 752 800 480 490 492 525 0x40 0xa
[    5.249633] [drm:drm_mode_prune_invalid] Not using 640x480 mode: BAD
[    5.264187] [drm:drm_mode_debug_printmodeline] Modeline 52:"720x400" 0 28320 720 738 846 900 400 412 414 449 0x40 0x6
[    5.265034] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=26, diff=1, hw=0 hw_last=0
[    5.279198] [drm:drm_mode_prune_invalid] Not using 720x400 mode: BAD
[    5.309069] [drm:drm_mode_debug_printmodeline] Modeline 54:"1024x768" 0 78750 1024 1040 1136 1312 768 769 772 800 0x40 0x5
[    5.324819] [drm:drm_mode_prune_invalid] Not using 1024x768 mode: BAD
[    5.339840] [drm:drm_mode_debug_printmodeline] Modeline 55:"1024x768" 0 75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
[    5.340014] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=27, diff=1, hw=0 hw_last=0
[    5.355318] [drm:drm_mode_prune_invalid] Not using 1024x768 mode: BAD
[    5.386355] [drm:drm_mode_debug_printmodeline] Modeline 57:"832x624" 0 57284 832 864 928 1152 624 625 628 667 0x40 0xa
[    5.402804] [drm:drm_mode_prune_invalid] Not using 832x624 mode: BAD
[    5.415008] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=28, diff=1, hw=0 hw_last=0
[    5.418455] [drm:drm_mode_debug_printmodeline] Modeline 58:"800x600" 0 49500 800 816 896 1056 600 601 604 625 0x40 0x5
[    5.450479] [drm:drm_mode_prune_invalid] Not using 800x600 mode: BAD
[    5.450510] [drm:drm_mode_debug_printmodeline] Modeline 59:"800x600" 0 50000 800 856 976 1040 600 637 643 666 0x40 0x5
[    5.481812] [drm:drm_mode_prune_invalid] Not using 800x600 mode: BAD
[    5.489997] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=29, diff=1, hw=0 hw_last=0
[    5.497075] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:33:HDMI-A-1] probed modes :
[    5.527892] [drm:drm_mode_debug_printmodeline] Modeline 36:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
[    5.543935] [drm:drm_mode_debug_printmodeline] Modeline 37:"1152x864" 75 108000 1152 1216 1344 1600 864 865 868 900 0x40 0x5
[    5.559937] [drm:drm_mode_debug_printmodeline] Modeline 48:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
[    5.564960] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=30, diff=1, hw=0 hw_last=0
[    5.575664] [drm:drm_mode_debug_printmodeline] Modeline 38:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
[    5.606926] [drm:drm_mode_debug_printmodeline] Modeline 39:"800x600" 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
[    5.622606] [drm:drm_setup_crtcs] connector 33 enabled? yes
[    5.628267] EXT4-fs (mmcblk0p7): mounted filesystem with ordered data mode. Opts: (null)
[    5.637743] [drm:drm_setup_crtcs] looking for cmdline mode on connector 33
[    5.639918] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=31, diff=1, hw=0 hw_last=0
[    5.683522] [drm:drm_setup_crtcs] looking for preferred mode on connector 33 0
[    5.698977] [drm:drm_setup_crtcs] found mode 1280x1024
[    5.713885] [drm:drm_setup_crtcs] picking CRTCs for 1280x1024 config
[    5.714925] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=32, diff=1, hw=0 hw_last=0
[    5.729010] [drm:drm_mode_object_put.part.0] OBJ ID: 33 (4)
[    5.760113] [drm:drm_setup_crtcs] desired mode 1280x1024 set on crtc 30 (0,0)
[    5.775925] [drm:drm_mode_object_get] OBJ ID: 33 (3)
[    5.789909] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=33, diff=1, hw=0 hw_last=0
[    5.791716] [drm:drm_atomic_state_init] Allocated atomic state 000000009c98915c
[    5.824337] [drm:drm_mode_object_get] OBJ ID: 40 (3)
[    5.840259] [drm:drm_atomic_get_plane_state] Added [PLANE:28:plane-0] 000000001770cb34 state to 000000009c98915c
[    5.856840] [drm:drm_mode_object_get] OBJ ID: 41 (1)
[    5.864858] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=34, diff=1, hw=0 hw_last=0
[    5.872899] [drm:drm_atomic_get_crtc_state] Added [CRTC:30:crtc-0] 0000000040e39674 state to 000000009c98915c
[    5.906148] [drm:drm_atomic_get_plane_state] Added [PLANE:29:plane-1] 0000000044cf8362 state to 000000009c98915c
[    5.922907] [drm:drm_atomic_set_crtc_for_plane] Link plane state 0000000044cf8362 to [NOCRTC]
[    5.939572] [drm:drm_atomic_set_fb_for_plane] Set [NOFB] for plane state 0000000044cf8362
[    5.939809] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=35, diff=1, hw=0 hw_last=0
[    5.956022] [drm:drm_atomic_get_plane_state] Added [PLANE:31:plane-2] 0000000013865618 state to 000000009c98915c
[    5.989502] [drm:drm_atomic_set_crtc_for_plane] Link plane state 0000000013865618 to [NOCRTC]
[    6.006211] [drm:drm_atomic_set_fb_for_plane] Set [NOFB] for plane state 0000000013865618
[    6.014830] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=36, diff=1, hw=0 hw_last=0
[    6.022752] [drm:drm_mode_object_put.part.0] OBJ ID: 41 (2)
[    6.055445] [drm:drm_atomic_set_mode_for_crtc] Set [MODE:1280x1024] for CRTC state 0000000040e39674
[    6.072044] [drm:drm_atomic_set_crtc_for_plane] Link plane state 000000001770cb34 to [CRTC:30:crtc-0]
[    6.088653] [drm:drm_atomic_set_fb_for_plane] Set [FB:40] for plane state 000000001770cb34
[    6.089762] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=37, diff=1, hw=0 hw_last=0
[    6.104909] [drm:drm_mode_object_get] OBJ ID: 40 (4)
[    6.137220] [drm:drm_mode_object_put.part.0] OBJ ID: 40 (5)
[    6.153075] [drm:drm_atomic_add_affected_connectors] Adding all current connectors for [CRTC:30:crtc-0] to 000000009c98915c
[    6.164769] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=38, diff=1, hw=0 hw_last=0
[    6.169622] [drm:drm_mode_object_get] OBJ ID: 33 (5)
[    6.201715] [drm:drm_mode_object_get] OBJ ID: 33 (6)
[    6.217327] [drm:drm_atomic_get_connector_state] Added [CONNECTOR:33:HDMI-A-1] 00000000272e9dc4 state to 000000009c98915c
[    6.233690] [drm:drm_mode_object_put.part.0] OBJ ID: 33 (6)
[    6.239743] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=39, diff=1, hw=0 hw_last=0
[    6.249373] [drm:drm_atomic_set_crtc_for_connector] Link connector state 00000000272e9dc4 to [NOCRTC]
[    6.281513] [drm:drm_mode_object_get] OBJ ID: 33 (5)
[    6.297062] [drm:drm_atomic_set_crtc_for_connector] Link connector state 00000000272e9dc4 to [CRTC:30:crtc-0]
[    6.313228] [drm:drm_atomic_check_only] checking 000000009c98915c
[    6.314690] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=40, diff=1, hw=0 hw_last=0
[    6.328783] [drm:drm_atomic_helper_check_modeset] Updating routing for [CONNECTOR:33:HDMI-A-1]
[    6.360612] [drm:drm_atomic_helper_check_modeset] [CONNECTOR:33:HDMI-A-1] keeps [ENCODER:32:TMDS-32], now on [CRTC:30:crtc-0]
[    6.376931] [drm:drm_atomic_commit] committing 000000009c98915c
[    6.389666] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=41, diff=1, hw=0 hw_last=0
[    6.392441] [drm:drm_calc_timestamping_constants] crtc 30: hwmode: htotal 1688, vtotal 1066, vdisplay 1024
[    6.408321] [drm:vblank_disable_fn] disabling vblank on crtc 0
[    6.408334] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=42, diff=0, hw=0 hw_last=0
[    6.455941] [drm:drm_calc_timestamping_constants] crtc 30: clock 108000 kHz framedur 16661185 linedur 15629
[    6.471990] [drm:drm_vblank_enable] enabling vblank on crtc 0, ret: 0
[    6.487701] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=42, diff=0, hw=0 hw_last=0
[    6.539643] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=42, diff=1, hw=0 hw_last=0
[    6.555497] [drm:drm_mode_object_get] OBJ ID: 40 (4)
[    6.570725] [drm:drm_mode_object_put.part.0] OBJ ID: 40 (5)
[    6.586182] [drm:drm_atomic_state_default_clear] Clearing atomic state 000000009c98915c
[    6.601731] [drm:drm_mode_object_put.part.0] OBJ ID: 33 (6)
[    6.614615] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=43, diff=1, hw=0 hw_last=0
[    6.616932] [drm:drm_mode_object_put.part.0] OBJ ID: 33 (5)
[    6.647759] [drm:drm_mode_object_put.part.0] OBJ ID: 41 (1)
[    6.662799] [drm:drm_mode_object_put.part.0] OBJ ID: 40 (4)
[    6.677678] [drm:__drm_atomic_state_free] Freeing atomic state 000000009c98915c
[    6.681763] systemd[1]: System time before build time, advancing clock.
[    6.689570] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=44, diff=1, hw=0 hw_last=0
[    6.764559] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=45, diff=1, hw=0 hw_last=0
[    6.796006] systemd[1]: systemd 237 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN +PCRE2 default-hierarchy=hybrid)
[    6.828193] systemd[1]: Detected architecture arm64.
[    6.839531] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=46, diff=1, hw=0 hw_last=0
[    6.876164] systemd[1]: Set hostname to <nemulon-9>.
[    6.914523] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=47, diff=1, hw=0 hw_last=0
[    6.989494] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=48, diff=1, hw=0 hw_last=0
[    7.064471] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=49, diff=1, hw=0 hw_last=0
[    7.139444] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=50, diff=1, hw=0 hw_last=0
[    7.214440] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=51, diff=1, hw=0 hw_last=0
[    7.289397] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=52, diff=1, hw=0 hw_last=0
[    7.364372] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=53, diff=1, hw=0 hw_last=0
[    7.439350] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=54, diff=1, hw=0 hw_last=0
[    7.474241] systemd[1]: File /usr/lib/systemd/system/systemd-journald.service:35 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
[    7.503449] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[    7.514312] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=55, diff=1, hw=0 hw_last=0
[    7.589298] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=56, diff=1, hw=0 hw_last=0
[    7.664275] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=57, diff=1, hw=0 hw_last=0
[    7.739249] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=58, diff=1, hw=0 hw_last=0
[    7.805592] systemd[1]: Created slice System Slice.
[    7.814214] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=59, diff=1, hw=0 hw_last=0
[    7.863612] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    7.889182] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=60, diff=1, hw=0 hw_last=0
[    7.903529] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    7.943603] systemd[1]: Listening on LVM2 metadata daemon socket.
[    7.964173] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=61, diff=1, hw=0 hw_last=0
[    7.970160] systemd[1]: Listening on Process Core Dump Socket.
[    8.039134] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=62, diff=1, hw=0 hw_last=0
[    8.114124] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=63, diff=1, hw=0 hw_last=0
[    8.189086] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=64, diff=1, hw=0 hw_last=0
[    8.264059] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=65, diff=1, hw=0 hw_last=0
[    8.339036] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=66, diff=1, hw=0 hw_last=0
[    8.414034] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=67, diff=1, hw=0 hw_last=0
[    8.489013] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=68, diff=1, hw=0 hw_last=0
[    8.563980] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=69, diff=1, hw=0 hw_last=0
[    8.569724] EXT4-fs (mmcblk0p7): re-mounted. Opts: discard,data=ordered
[    8.638939] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=70, diff=1, hw=0 hw_last=0
[    8.713967] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=71, diff=1, hw=0 hw_last=0
[    8.788903] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=72, diff=1, hw=0 hw_last=0
[    8.863870] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=73, diff=1, hw=0 hw_last=0
[    8.938846] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=74, diff=1, hw=0 hw_last=0
[    9.013827] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=75, diff=1, hw=0 hw_last=0
[    9.088820] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=76, diff=1, hw=0 hw_last=0
[    9.163786] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=77, diff=1, hw=0 hw_last=0
[    9.238754] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=78, diff=1, hw=0 hw_last=0
[    9.313739] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=79, diff=1, hw=0 hw_last=0
[    9.388709] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=80, diff=1, hw=0 hw_last=0
[    9.395960] systemd-journald[179]: Received request to flush runtime journal from PID 1
[    9.432744] systemd-journald[179]: File /var/log/journal/95d06aefb7284deeaceaebd2f8f8c4b1/system.journal corrupted or uncleanly shut down, renaming and replacing.
[    9.463680] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=81, diff=1, hw=0 hw_last=0
[    9.538658] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=82, diff=1, hw=0 hw_last=0
[    9.613630] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=83, diff=1, hw=0 hw_last=0
[    9.688606] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=84, diff=1, hw=0 hw_last=0
[    9.763578] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=85, diff=1, hw=0 hw_last=0
[    9.838560] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=86, diff=1, hw=0 hw_last=0
[    9.913529] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=87, diff=1, hw=0 hw_last=0
[    9.988515] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=88, diff=1, hw=0 hw_last=0
[   10.063534] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=89, diff=1, hw=0 hw_last=0
[   10.115056] random: crng init done
[   10.138517] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=90, diff=1, hw=0 hw_last=0
[   10.213476] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=91, diff=1, hw=0 hw_last=0
[   10.288426] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=92, diff=1, hw=0 hw_last=0
[   10.363435] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=93, diff=1, hw=0 hw_last=0
[   10.438380] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=94, diff=1, hw=0 hw_last=0
[   10.513344] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=95, diff=1, hw=0 hw_last=0
[   10.574381] RTL8211F Gigabit Ethernet stmmac-0:00: attached PHY driver [RTL8211F Gigabit Ethernet] (mii_bus:phy_addr=stmmac-0:00, irq=POLL)
[   10.588372] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=96, diff=1, hw=0 hw_last=0
[   10.593046] rk_gmac-dwmac ff540000.ethernet eth0: PTP not supported by HW
[   10.663288] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=97, diff=1, hw=0 hw_last=0
[   10.738263] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=98, diff=1, hw=0 hw_last=0
[   10.813263] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=99, diff=1, hw=0 hw_last=0
[   10.832304] FAT-fs (mmcblk0p6): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   10.888209] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=100, diff=1, hw=0 hw_last=0
[   10.963202] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=101, diff=1, hw=0 hw_last=0
[   11.038169] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=102, diff=1, hw=0 hw_last=0
[   11.113186] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=103, diff=1, hw=0 hw_last=0
[   11.188115] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=104, diff=1, hw=0 hw_last=0
[   11.263109] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=105, diff=1, hw=0 hw_last=0
[   11.338062] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=106, diff=1, hw=0 hw_last=0
[   11.413051] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=107, diff=1, hw=0 hw_last=0
[   11.488008] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=108, diff=1, hw=0 hw_last=0
[   11.562991] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=109, diff=1, hw=0 hw_last=0
[   11.602882] [drm:vblank_disable_fn] disabling vblank on crtc 0
[   11.610639] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=110, diff=0, hw=0 hw_last=0
[   12.647059] [drm:drm_atomic_state_init] Allocated atomic state 00000000e7bc325a
[   12.647082] [drm:drm_mode_object_get] OBJ ID: 40 (3)
[   12.647095] [drm:drm_atomic_get_plane_state] Added [PLANE:28:plane-0] 00000000d219b671 state to 00000000e7bc325a
[   12.647110] [drm:drm_mode_object_get] OBJ ID: 35 (1)
[   12.647121] [drm:drm_atomic_get_crtc_state] Added [CRTC:30:crtc-0] 000000001ed3b088 state to 00000000e7bc325a
[   12.647135] [drm:drm_atomic_get_plane_state] Added [PLANE:29:plane-1] 0000000032afc56f state to 00000000e7bc325a
[   12.647143] [drm:drm_atomic_set_crtc_for_plane] Link plane state 0000000032afc56f to [NOCRTC]
[   12.647153] [drm:drm_atomic_set_fb_for_plane] Set [NOFB] for plane state 0000000032afc56f
[   12.647166] [drm:drm_atomic_get_plane_state] Added [PLANE:31:plane-2] 000000005e3b775b state to 00000000e7bc325a
[   12.647175] [drm:drm_atomic_set_crtc_for_plane] Link plane state 000000005e3b775b to [NOCRTC]
[   12.647183] [drm:drm_atomic_set_fb_for_plane] Set [NOFB] for plane state 000000005e3b775b
[   12.647198] [drm:drm_mode_object_put.part.0] OBJ ID: 35 (2)
[   12.647228] [drm:drm_atomic_set_mode_for_crtc] Set [MODE:1280x1024] for CRTC state 000000001ed3b088
[   12.647240] [drm:drm_atomic_set_crtc_for_plane] Link plane state 00000000d219b671 to [CRTC:30:crtc-0]
[   12.647252] [drm:drm_atomic_set_fb_for_plane] Set [FB:40] for plane state 00000000d219b671
[   12.647262] [drm:drm_mode_object_get] OBJ ID: 40 (4)
[   12.647271] [drm:drm_mode_object_put.part.0] OBJ ID: 40 (5)
[   12.647285] [drm:drm_atomic_add_affected_connectors] Adding all current connectors for [CRTC:30:crtc-0] to 00000000e7bc325a
[   12.647303] [drm:drm_mode_object_get] OBJ ID: 33 (5)
[   12.647312] [drm:drm_mode_object_get] OBJ ID: 33 (6)
[   12.647322] [drm:drm_atomic_get_connector_state] Added [CONNECTOR:33:HDMI-A-1] 000000000355ed0b state to 00000000e7bc325a
[   12.647333] [drm:drm_mode_object_put.part.0] OBJ ID: 33 (6)
[   12.647342] [drm:drm_atomic_set_crtc_for_connector] Link connector state 000000000355ed0b to [NOCRTC]
[   12.647352] [drm:drm_mode_object_get] OBJ ID: 33 (5)
[   12.647362] [drm:drm_atomic_set_crtc_for_connector] Link connector state 000000000355ed0b to [CRTC:30:crtc-0]
[   12.647371] [drm:drm_atomic_check_only] checking 00000000e7bc325a
[   12.647397] [drm:drm_atomic_helper_check_modeset] Updating routing for [CONNECTOR:33:HDMI-A-1]
[   12.647411] [drm:drm_atomic_helper_check_modeset] [CONNECTOR:33:HDMI-A-1] keeps [ENCODER:32:TMDS-32], now on [CRTC:30:crtc-0]
[   12.647436] [drm:drm_atomic_commit] committing 00000000e7bc325a
[   12.647474] [drm:drm_calc_timestamping_constants] crtc 30: hwmode: htotal 1688, vtotal 1066, vdisplay 1024
[   12.647484] [drm:drm_calc_timestamping_constants] crtc 30: clock 108000 kHz framedur 16661185 linedur 15629
[   12.647530] [drm:drm_vblank_enable] enabling vblank on crtc 0, ret: 0
[   12.647544] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=110, diff=0, hw=0 hw_last=0
[   12.687608] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=110, diff=1, hw=0 hw_last=0
[   12.687663] [drm:drm_mode_object_get] OBJ ID: 40 (4)
[   12.687674] [drm:drm_mode_object_put.part.0] OBJ ID: 40 (5)
[   12.687688] [drm:drm_atomic_state_default_clear] Clearing atomic state 00000000e7bc325a
[   12.687699] [drm:drm_mode_object_put.part.0] OBJ ID: 33 (6)
[   12.687710] [drm:drm_mode_object_put.part.0] OBJ ID: 33 (5)
[   12.687721] [drm:drm_mode_object_put.part.0] OBJ ID: 35 (1)
[   12.687741] [drm:drm_mode_object_put.part.0] OBJ ID: 40 (4)
[   12.687753] [drm:__drm_atomic_state_free] Freeing atomic state 00000000e7bc325a
[   12.762562] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=111, diff=1, hw=0 hw_last=0
[   12.837567] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=112, diff=1, hw=0 hw_last=0
[   12.912525] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=113, diff=1, hw=0 hw_last=0
[   12.987492] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=114, diff=1, hw=0 hw_last=0
[   13.062466] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=115, diff=1, hw=0 hw_last=0
[   13.137440] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=116, diff=1, hw=0 hw_last=0
[   13.212412] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=117, diff=1, hw=0 hw_last=0
[   13.287393] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=118, diff=1, hw=0 hw_last=0
[   13.362366] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=119, diff=1, hw=0 hw_last=0
[   13.437341] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=120, diff=1, hw=0 hw_last=0
[   13.512315] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=121, diff=1, hw=0 hw_last=0
[   13.587292] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=122, diff=1, hw=0 hw_last=0
[   13.662272] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=123, diff=1, hw=0 hw_last=0
[   13.737256] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=124, diff=1, hw=0 hw_last=0
[   13.764668] rk_gmac-dwmac ff540000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[   13.812237] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=125, diff=1, hw=0 hw_last=0
[   13.887224] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=126, diff=1, hw=0 hw_last=0
[   13.962185] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=127, diff=1, hw=0 hw_last=0
[   14.037155] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=128, diff=1, hw=0 hw_last=0
[   14.112138] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=129, diff=1, hw=0 hw_last=0
[   14.187126] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=130, diff=1, hw=0 hw_last=0
[   14.262088] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=131, diff=1, hw=0 hw_last=0
[   14.337071] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=132, diff=1, hw=0 hw_last=0
[   14.412034] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=133, diff=1, hw=0 hw_last=0
[   14.487014] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=134, diff=1, hw=0 hw_last=0
[   14.561989] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=135, diff=1, hw=0 hw_last=0
[   14.636961] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=136, diff=1, hw=0 hw_last=0
[   14.711948] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=137, diff=1, hw=0 hw_last=0
[   14.786923] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=138, diff=1, hw=0 hw_last=0
[   14.861890] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=139, diff=1, hw=0 hw_last=0
[   14.936861] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=140, diff=1, hw=0 hw_last=0
[   15.011837] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=141, diff=1, hw=0 hw_last=0
[   15.086828] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=142, diff=1, hw=0 hw_last=0
[   15.161795] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=143, diff=1, hw=0 hw_last=0
[   15.236764] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=144, diff=1, hw=0 hw_last=0
[   15.311735] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=145, diff=1, hw=0 hw_last=0
[   15.386714] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=146, diff=1, hw=0 hw_last=0
[   15.461685] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=147, diff=1, hw=0 hw_last=0
[   15.536660] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=148, diff=1, hw=0 hw_last=0
[   15.611643] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=149, diff=1, hw=0 hw_last=0
[   15.686615] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=150, diff=1, hw=0 hw_last=0
[   15.761587] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=151, diff=1, hw=0 hw_last=0
[   15.836562] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=152, diff=1, hw=0 hw_last=0
[   15.911529] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=153, diff=1, hw=0 hw_last=0
[   15.986517] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=154, diff=1, hw=0 hw_last=0
[   16.061485] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=155, diff=1, hw=0 hw_last=0
[   16.136456] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=156, diff=1, hw=0 hw_last=0
[   16.211437] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=157, diff=1, hw=0 hw_last=0
[   16.286412] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=158, diff=1, hw=0 hw_last=0
[   16.361390] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=159, diff=1, hw=0 hw_last=0
[   16.436367] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=160, diff=1, hw=0 hw_last=0
[   16.511340] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=161, diff=1, hw=0 hw_last=0
[   16.586309] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=162, diff=1, hw=0 hw_last=0
[   16.661291] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=163, diff=1, hw=0 hw_last=0
[   16.736267] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=164, diff=1, hw=0 hw_last=0
[   16.811241] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=165, diff=1, hw=0 hw_last=0
[   16.886215] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=166, diff=1, hw=0 hw_last=0
[   16.961189] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=167, diff=1, hw=0 hw_last=0
[   17.036169] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=168, diff=1, hw=0 hw_last=0
[   17.111147] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=169, diff=1, hw=0 hw_last=0
[   17.186124] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=170, diff=1, hw=0 hw_last=0
[   17.261095] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=171, diff=1, hw=0 hw_last=0
[   17.336063] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=172, diff=1, hw=0 hw_last=0
[   17.411039] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=173, diff=1, hw=0 hw_last=0
[   17.486023] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=174, diff=1, hw=0 hw_last=0
[   17.560999] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=175, diff=1, hw=0 hw_last=0
[   17.635968] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=176, diff=1, hw=0 hw_last=0
[   17.710946] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=177, diff=1, hw=0 hw_last=0
[   17.762863] [drm:vblank_disable_fn] disabling vblank on crtc 0
[   17.766398] [drm:drm_update_vblank_count] updating vblank count on crtc 0: current=178, diff=0, hw=0 hw_last=0
[   36.774025] audit: type=1006 audit(1519338363.140:2): pid=256 uid=0 old-auid=4294967295 auid=0 tty=ttyS2 old-ses=4294967295 ses=1 res=1
[   36.868213] audit: type=1006 audit(1519338363.230:3): pid=265 uid=0 old-auid=4294967295 auid=0 tty=(none) old-ses=4294967295 ses=2 res=1
