From: holgerschurig@gmail.com (Holger Schurig)
Date: Tue, 31 May 2016 12:51:03 +0200
Subject: [BUG] CONFIG_UNINLINE_SPIN_UNLOCK important for Cortex-A9
In-Reply-To: <4854518.jvbplH0SM0@wuerfel>
References: <874m9eoetu.fsf@gmail.com> <4854518.jvbplH0SM0@wuerfel>
Message-ID: <871t4io608.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Have you tried multi_v7_defconfig? That also does not set 
> CONFIG_UNINLINE_SPIN_UNLOCK, but it is generally assumed to work.

Not yet, will try this (see below).



> Just to be sure: If you just enable UNINLINE_SPIN_UNLOCK (e.g. using
> a 'select' from arch/arm/mach-imx/Kconfig) without selecting PROVE_RCU,
> you say the bug is gone too?

Currently I select it indirectly. One person that tried to help me
turned on 29 different kernel debug options and the bug was gone. Then I
reduced this step by step to find out which of them was needed
minimally.

Still I don't think that it's an RCU issue. But it could of course be a
"Heisenbug".



> - Specific kernel version, and full list of patches applied (if any).
>   Have you reproduced this with a plain unpatched linux-4.6 kernel?

I'm not in love with vendor-kernels, so I use kernels from kernel.org.
When I started to chase the oops happened in 4.4.4, but the behavior was
also present in 4.5, 4.5.1 ... 4.5.4 and 4.6.

I have some patches applied, e.g. aufs4, one patch in the i.MX6Q FEC
ethernet driver and stuff to program the eMMC firmware. Nothing that
plays with rcu, spinlocks etc, e.g. no preempt or Linux-RT patches.

However, a vanilla kernel boots on my device (isn't device tree
nice?!?!?) and here I had the same behavior. I think that vanilla kernel
was 4.5.3, but I'm unsure.



> - Specific gcc version you used for building the kernel. Does this
>   happen with both old and new compilers, e.g. 4.7 and 6.1?

I don't have yet a gcc 6.1 armhf cross compiler.

My gcc used to be
http://releases.linaro.org/14.04/components/toolchain/binaries/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux.tar.xz
but during the bug chase I switched to Debian's cross-gcc. It says it is
"arm-linux-gnueabihf-gcc ( 4.9.2-10) 4.9.2".

A kernel compiled by someone else with some "gcc-4.8
4.8.4-2ubuntu1~14.04" also had the same oopsing-behavior.



> - If it happens with an unpatched linux-4.6 and all gcc versions
>   with multi_v7_defconfig, we should try reproducing it on some
>   other quad-core Cortex-A9 (non-imx) platform with the same kernel
>   binary.

I will try to reproduce it, as said it can take between 3 to 24 hours.

I'll be using

- vanilla 4.6 without any patch
- ... and without any device-specific kernel module
- multi_v7_defconfig
- Debian 4.9.2 cross-compiler







BTW, here is one of the older oopses:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.5.4 (linux at localhost) (gcc version 4.9.2 (Debian 4.9.2-10) ) #1 SMP Fri May 20 14:08:13 CEST 2016
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: PTX-C
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] PERCPU: Embedded 12 pages/cpu @ef7aa000 s17024 r8192 d23936 u49152
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260608
[    0.000000] Kernel command line:  console=ttymxc0,115200n8 skb_cpu=-1 printk.time=1  root=/dev/sdblk0p1 rootwait ro
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1032768K/1048576K available (4451K kernel code, 140K rwdata, 1336K rodata, 228K init, 256K bss, 15808K reserved, 0K cma-reserved, 262144K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05aefbc   (5788 kB)
[    0.000000]       .init : 0xc05af000 - 0xc05e8000   ( 228 kB)
[    0.000000]       .data : 0xc05e8000 - 0xc060b340   ( 141 kB)
[    0.000000]        .bss : 0xc060e000 - 0xc064e364   ( 257 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C-310 erratum 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000007] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 715827882841ns
[    0.000023] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 637086815595 ns
[    0.000981] Console: colour dummy device 80x30
[    0.001000] Calibrating delay loop (skipped), value calculated using timer frequency.. 6.00 BogoMIPS (lpj=30000)
[    0.001014] pid_max: default: 32768 minimum: 301
[    0.001102] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001113] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001667] CPU: Testing write buffer coherency: ok
[    0.001920] Setting up static identity map for 0x10008200 - 0x10008258
[    0.004711] Brought up 4 CPUs
[    0.004723] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.004731] CPU: All CPU(s) started in SVC mode.
[    0.005185] devtmpfs: initialized
[    0.012919] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.013222] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.013385] pinctrl core: initialized pinctrl subsystem
[    0.014308] NET: Registered protocol family 16
[    0.016024] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.016712] CPU identified as i.MX6Q, silicon rev 1.5
[    0.036432] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.071626] SCSI subsystem initialized
[    0.071885] usbcore: registered new interface driver usbfs
[    0.071949] usbcore: registered new interface driver hub
[    0.072052] usbcore: registered new device driver usb
[    0.072859] i2c i2c-0: IMX I2C adapter registered
[    0.072877] i2c i2c-0: can't use DMA, using PIO instead.
[    0.073678] i2c i2c-2: IMX I2C adapter registered
[    0.073696] i2c i2c-2: can't use DMA, using PIO instead.
[    0.073848] pps_core: LinuxPPS API ver. 1 registered
[    0.073857] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.073894] PTP clock support registered
[    0.074897] clocksource: Switched to clocksource mxc_timer1
[    0.085009] NET: Registered protocol family 2
[    0.085568] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.085662] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.085808] TCP: Hash tables configured (established 8192 bind 8192)
[    0.085969] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.086014] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.086214] NET: Registered protocol family 1
[    0.086560] RPC: Registered named UNIX socket transport module.
[    0.086571] RPC: Registered udp transport module.
[    0.086578] RPC: Registered tcp transport module.
[    0.086585] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.087730] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.095320] aufs 4.x-rcN-20160301
[    0.096395] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.096415] io scheduler noop registered (default)
[    0.096845] imx-weim 21b8000.weim: Driver registered.
[    0.098054] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq = 24, base_baud = 5000000) is a IMX
[    0.610190] console [ttymxc0] enabled
[    0.614540] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq = 293, base_baud = 5000000) is a IMX
[    0.623709] 21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq = 294, base_baud = 5000000) is a IMX
[    0.632917] 21f0000.serial: ttymxc3 at MMIO 0x21f0000 (irq = 295, base_baud = 5000000) is a IMX
[    0.642143] 21f4000.serial: ttymxc4 at MMIO 0x21f4000 (irq = 296, base_baud = 5000000) is a IMX
[    0.651203] [drm] Initialized drm 1.1.0 20060810
[    0.657567] imx-ipuv3 2400000.ipu: IPUv3H probed
[    0.663542] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    0.670190] [drm] No driver support for vblank timestamp query.
[    0.676227] imx-drm display-subsystem: bound imx-ipuv3-crtc.2 (ops ipu_crtc_ops)
[    0.683689] imx-drm display-subsystem: bound imx-ipuv3-crtc.3 (ops ipu_crtc_ops)
[    0.691191] imx-drm display-subsystem: bound imx-ipuv3-crtc.6 (ops ipu_crtc_ops)
[    0.698682] imx-drm display-subsystem: bound imx-ipuv3-crtc.7 (ops ipu_crtc_ops)
[    0.706398] imx-drm display-subsystem: bound 2000000.aips-bus:ldb at 020e0008 (ops imx_ldb_ops)
[    0.725252] Console: switching to colour frame buffer device 100x37
[    0.734687] imx-drm display-subsystem: fb0:  frame buffer device
[    0.764913] [drm] Initialized imx-drm 1.0.0 20120507 on minor 0
[    0.770853] imx-ipuv3 2800000.ipu: IPUv3H probed
[    0.777626] loop: module loaded
[    0.780892] at24 2-0050: 256 byte 24c02 EEPROM, writable, 16 bytes/write
[    0.789037] CAN device driver interface
[    0.805354] pps pps0: new PPS source ptp0
[    0.813339] libphy: fec_enet_mii_bus: probed
[    0.818188] fec 2188000.ethernet eth0: registered PHC device 0
[    0.824239] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.830800] ehci-mxc: Freescale On-Chip EHCI Host driver
[    0.836311] usbcore: registered new interface driver usb-storage
[    0.847175] ci_hdrc ci_hdrc.0: EHCI Host Controller
[    0.852084] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
[    0.874919] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
[    0.880486] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.887310] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.894551] usb usb1: Product: EHCI Host Controller
[    0.899454] usb usb1: Manufacturer: Linux 4.5.4 ehci_hcd
[    0.904783] usb usb1: SerialNumber: ci_hdrc.0
[    0.909733] hub 1-0:1.0: USB hub found
[    0.913519] hub 1-0:1.0: 1 port detected
[    0.921374] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    0.926301] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 2
[    0.944924] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    0.950482] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    0.957300] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.964542] usb usb2: Product: EHCI Host Controller
[    0.969439] usb usb2: Manufacturer: Linux 4.5.4 ehci_hcd
[    0.974768] usb usb2: SerialNumber: ci_hdrc.1
[    0.979653] hub 2-0:1.0: USB hub found
[    0.983438] hub 2-0:1.0: 1 port detected
[    0.992564] rtc-ds1307 2-0068: rtc core: registered ds1337 as rtc0
[    0.998843] i2c /dev entries driver
[    1.003552] imx2-wdt 20bc000.wdog: timeout 60 sec (nowayout=0)
[    1.009662] sdhci: Secure Digital Host Controller Interface driver
[    1.015886] sdhci: Copyright(c) Pierre Ossman
[    1.021215] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.027564] /soc/aips-bus at 02100000/usdhc at 02194000: voltage-ranges unspecified
[    1.034728] sdhci-esdhc-imx 2194000.usdhc: Got CD GPIO
[    1.039901] sdhci-esdhc-imx 2194000.usdhc: Got WP GPIO
[    1.085110] mmc0: SDHCI controller on 2194000.usdhc [2194000.usdhc] using ADMA
[    1.095006] /soc/aips-bus at 02100000/usdhc at 0219c000: voltage-ranges unspecified
[    1.144917] mmc1: SDHCI controller on 219c000.usdhc [219c000.usdhc] using ADMA
[    1.163030] Netfilter messages via NETLINK v0.30.
[    1.170075] NET: Registered protocol family 17
[    1.176638] can: controller area network core (rev 20120528 abi 9)
[    1.184998] NET: Registered protocol family 29
[    1.189463] can: raw protocol (rev 20120528)
[    1.193744] can: broadcast manager protocol (rev 20120528 t)
[    1.199437] can: netlink gateway (rev 20130117) max_hops=1
[    1.207433] mmc0: new high speed SD card at address 0007
[    1.207453] Registering SWP/SWPB emulation handler
[    1.215948] imx_thermal 2000000.aips-bus:tempmon: Automotive CPU temperature grade - max:125C critical:120C passive:115C
[    1.229447] rtc-ds1307 2-0068: setting system clock to 2014-06-07 10:17:52 UTC (1402136272)
[    1.238198] sdblk0: mmc0:0007 SD01G 972 MiB 
[    1.244374]  sdblk0: p1 p4
[    1.255477] EXT4-fs (sdblk0p1): mounted filesystem with ordered data mode. Opts: (null)
[    1.263514] VFS: Mounted root (ext4 filesystem) readonly on device 179:1.
[    1.274643] devtmpfs: mounted
[    1.286615] Freeing unused kernel memory: 228K (c05af000 - c05e8000)
[    1.300598] mmc1: MAN_BKOPS_EN bit is not set
[    1.305029] usb 2-1: new high-speed USB device number 2 using ci_hdrc
[    1.325380] mmc1: new DDR MMC card at address 0001
[    1.330726] mmcblk0: mmc1:0001 W11016 7.13 GiB 
[    1.335546] mmcblk0boot0: mmc1:0001 W11016 partition 1 4.00 MiB
[    1.341690] mmcblk0boot1: mmc1:0001 W11016 partition 2 4.00 MiB
[    1.347877] mmcblk0rpmb: mmc1:0001 W11016 partition 3 4.00 MiB
[    1.355422]  mmcblk0: p1 p2 p3 p4
[    1.455412] usb 2-1: New USB device found, idVendor=0424, idProduct=2514
[    1.462162] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.470008] hub 2-1:1.0: USB hub found
[    1.473895] hub 2-1:1.0: 3 ports detected
[    1.519832] random: systemd urandom read with 10 bits of entropy available
[    1.531714] systemd[1]: systemd 217 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR -SMACK -SYSVINIT -UTMP -LIBCRYPTSETUP -GCRYPT -GNUTLS +ACL -XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN )
[    1.550031] systemd[1]: Detected architecture 'arm'.
[    1.565955] systemd[1]: Set hostname to <ptxc>.
[    1.579164] systemd[1]: Initializing machine ID from random generator.
[    1.754933] usb 2-1.1: new full-speed USB device number 3 using ci_hdrc
[    1.810850] systemd[1]: Expecting device dev-ttymxc0.device...
[    1.816795] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[    1.824757] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    1.832482] systemd[1]: Starting Network.
[    1.836681] systemd[1]: Reached target Network.
[    1.841283] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[    1.849524] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    1.857523] systemd[1]: Starting -Paths.
[    1.861473] systemd[1]: Reached target -Paths.
[    1.865998] systemd[1]: Starting -Swap.
[    1.869870] systemd[1]: Reached target -Swap.
[    1.874281] systemd[1]: Starting Root Slice.
[    1.878694] systemd[1]: Created slice Root Slice.
[    1.883458] systemd[1]: Starting User and Session Slice.
[    1.888980] systemd[1]: Created slice User and Session Slice.
[    1.894769] systemd[1]: Starting Delayed Shutdown Socket.
[    1.900323] systemd[1]: Listening on Delayed Shutdown Socket.
[    1.902531] usb 2-1.1: New USB device found, idVendor=0a12, idProduct=0001
[    1.902539] usb 2-1.1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    1.902544] usb 2-1.1: Product: CSR8510 A10
[    1.924561] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[    1.931393] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    1.938415] systemd[1]: Starting Journal Socket (/dev/log).
[    1.944144] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.950171] systemd[1]: Starting udev Control Socket.
[    1.955390] systemd[1]: Listening on udev Control Socket.
[    1.960870] systemd[1]: Starting udev Kernel Socket.
[    1.965927] systemd[1]: Listening on udev Kernel Socket.
[    1.971295] systemd[1]: Starting Journal Socket.
[    1.976079] systemd[1]: Listening on Journal Socket.
[    1.981132] systemd[1]: Starting System Slice.
[    1.985766] systemd[1]: Created slice System Slice.
[    1.994921] usb 2-1.2: new high-speed USB device number 4 using ci_hdrc
[    2.001678] systemd[1]: Starting loadkeys...
[    2.035385] systemd[1]: Starting system-getty.slice.
[    2.040626] systemd[1]: Created slice system-getty.slice.
[    2.046165] systemd[1]: Starting system-serial\x2dgetty.slice.
[    2.052301] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    2.058937] systemd[1]: Starting Remount /media/realroot writable...
[    2.067349] systemd[1]: Mounting Debug File System...
[    2.088733] systemd[1]: Starting Load Kernel Modules...
[    2.095797] systemd[1]: Mounted POSIX Message Queue File System.
[    2.102065] systemd[1]: Starting udev Coldplug all Devices...
[    2.110104] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    2.121877] systemd[1]: Mounted Huge Pages File System.
[    2.130883] systemd[1]: Starting Journal Service...
[    2.135409] usb 2-1.2: New USB device found, idVendor=0424, idProduct=9e00
[    2.135416] usb 2-1.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.151838] systemd[1]: Started Journal Service.
[    2.155238] input: beep as /devices/virtual/input/input0
[    2.161069] EXT4-fs (sdblk0p1): re-mounted. Opts: data=ordered
[    2.472678] systemd-journald[80]: Received request to flush runtime journal from PID 1
[    2.565712] smsc95xx v1.0.4
[    2.642784] smsc95xx 2-1.2:1.0 eth1: register 'smsc95xx' at usb-ci_hdrc.1-1.2, smsc95xx USB 2.0 Ethernet, 00:80:07:00:d6:aa
[    2.655791] usbcore: registered new interface driver smsc95xx
[    2.692008] flexcan 2090000.flexcan: device registered (reg_base=f0ba0000, irq=29)
[    2.708295] flexcan 2094000.flexcan: device registered (reg_base=f0bb0000, irq=30)
[    2.824757] Bluetooth: Core ver 2.21
[    2.828589] NET: Registered protocol family 31
[    2.833073] Bluetooth: HCI device and connection manager initialized
[    2.839512] Bluetooth: HCI socket layer initialized
[    2.844408] Bluetooth: L2CAP socket layer initialized
[    2.849514] Bluetooth: SCO socket layer initialized
[    2.895099] usbcore: registered new interface driver btusb
[    3.257897] SMSC LAN8710/LAN8720 2188000.ethernet:00: attached PHY driver [SMSC LAN8710/LAN8720] (mii_bus:phy_addr=2188000.ethernet:00, irq=-1)
[17827.758966] Unable to handle kernel paging request at virtual address 00001014
[17827.766279] pgd = ee09c000
[17827.769003] [00001014] *pgd=3eba3831, *pte=00000000, *ppte=00000000
[17827.775383] Internal error: Oops: 17 [#1] SMP ARM
[17827.780108] Modules linked in: usbhid btusb btrtl btbcm btintel bluetooth flexcan smsc95xx usbnet mii ptxc(O)
[17827.790242] CPU: 1 PID: 372 Comm: stress-ng-socke Tainted: G           O    4.5.4 #1
[17827.797995] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[17827.804536] task: ed614780 ti: eebba000 task.ti: eebba000
[17827.809977] PC is at __netif_receive_skb_core+0x328/0xa9c
[17827.815390] LR is at __netif_receive_skb+0x30/0x8c
[17827.820190] pc : [<c03a7634>]    lr : [<c03a9b60>]    psr: 60030013
[17827.820190] sp : eebbba10  ip : 00001014  fp : eebbba84
[17827.831672] r10: 00001000  r9 : c05eac94  r8 : c05eac8c
[17827.836900] r7 : 00000001  r6 : ef7b9840  r5 : ef7ba148  r4 : ee05ba30
[17827.843432] r3 : ef7b9894  r2 : 00001000  r1 : 2f1d4000  r0 : 00000001
[17827.849964] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[17827.857101] Control: 10c5387d  Table: 3e09c04a  DAC: 00000055
[17827.862857] Process stress-ng-socke (pid: 372, stack limit = 0xeebba210)
[17827.869561] Stack: (0xeebbba10 to 0xeebbc000)
[17827.873923] ba00:                                     eebbba44 eebbba20 c0606280 00000000
[17827.882107] ba20: ee164780 ef7b9840 a0030193 ee05ba30 f4000100 f4001100 eebbba5c eebbba48
[17827.890291] ba40: c003fa50 c003f8d4 00000000 ef7b9840 c05e5840 c05ea5d4 eebbba7c ef7ba1b8
[17827.898475] ba60: ef7ba148 00000040 ef7ba1a4 ef7ba1b0 00000000 00000001 eebbba9c eebbba88
[17827.906658] ba80: c03a9b60 c03a7318 ef7ba148 ef7ba1b8 eebbbacc eebbbaa0 c03aaac4 c03a9b3c
[17827.914840] baa0: eebbbaf0 ef7ba1b8 c03aaa30 001abec9 0000012c c05ea100 00000040 eebbbaf0
[17827.923023] bac0: eebbbb2c eebbbad0 c03aa2cc c03aaa3c c05e9640 c057d614 c05eac8c c05eac8c
[17827.931206] bae0: c060b2e5 2f1d4000 c05e6140 ef7ba140 eebbbaf0 eebbbaf0 eebbbaf8 eebbbaf8
[17827.939391] bb00: 00000000 00000000 00000003 c05ea08c eebba000 00000101 40000003 c05ea080
[17827.947573] bb20: eebbbb8c eebbbb30 c0022444 c03aa0dc c03ac244 c03abeb0 00400040 c05ea100
[17827.955758] bb40: 001abec8 c0460bb8 0000000a c060e980 c05e2250 c05ea080 eebbbb30 eebba030
[17827.963941] bb60: c03acb9c 60030013 ee05ba30 eeb1c200 00000000 0000000e ef06a800 00000006
[17827.972124] bb80: eebbbba4 eebbbb90 c0022624 c002231c 00000008 00000200 eebbbbbc eebbbba8
[17827.980308] bba0: c00226e8 c00225c8 00000000 ee05ba30 eebbbbec eebbbbc0 c03e0360 c0022638
[17827.988492] bbc0: ee164780 0100007f a0030193 ee05ba30 0000ffff c0606280 ee2d2c00 ee2d2c00
[17827.996676] bbe0: eebbbc24 eebbbbf0 c03e1ed4 c03e01b8 c05e5840 c05ea5d4 eebbbc1c ee05ba30
[17828.004861] bc00: c0606280 0971f1b9 00000000 ee2d2c00 ef06a800 00000006 eebbbc74 eebbbc28
[17828.013043] bc20: c03e2a34 c03e1d94 c03e2060 c03e014c eebbbc5c eebbbc40 c0014c34 c0041be8
[17828.021225] bc40: c05f6fb0 c05ea740 f400010c eebbbc88 ee05ba30 ee2d2c00 c0606280 00000000
[17828.029407] bc60: ee3e5000 0000ab00 eebbbc94 eebbbc78 c03e2110 c03e291c 00000000 ee05ba30
[17828.037588] bc80: ee2d2c00 ee2d2e20 eebbbcd4 eebbbc98 c03e23fc c03e20dc eebbbcbc eebbbca8
[17828.045770] bca0: c03980bc c0397f94 ee2d2c00 ee2d2c00 ee05ba30 00000000 00000000 0000ab00
[17828.053953] bcc0: 0000ab00 00000006 eebbbd1c eebbbcd8 c03f9d08 c03e22cc 00000002 00000000
[17828.062134] bce0: 00000000 001abec7 001abec7 00000000 00000015 ee05b980 ee2d2c00 00040000
[17828.070317] bd00: 00000000 0000ffcb 000014b0 c05ec068 eebbbd84 eebbbd20 c03fa354 c03f9908
[17828.078500] bd20: c0013740 c00093b4 ed6b10a0 bebf9d4c 00000090 000346db c05ea100 00000000
[17828.086683] bd40: 00000002 ee2d2f94 00000005 00000000 00000000 0000ffcb 024000c0 ee2d2c00
[17828.094865] bd60: ee05b980 0000ffcb 00000000 9274572f eebbbe84 00000000 eebbbda4 eebbbd88
[17828.103047] bd80: c03fb2a4 c03fa168 02080020 ed6b0000 00000e50 ee2d2c00 eebbbdcc eebbbda8
[17828.111229] bda0: c03ea2e8 c03fb274 ee2d2c00 00000e50 000014b0 ee2d2c00 00000e50 0000ffcb
[17828.119413] bdc0: eebbbe4c eebbbdd0 c03edd44 c03ea1e4 0000ffcb c003ced8 00000002 00000660
[17828.127595] bde0: 00000000 eebbbe8c c05eac4c eebba000 00000001 00000000 ed614cb4 00000000
[17828.135777] be00: 00000000 ee2d2cb8 0000ffcb 000014b0 eebbbe8c 0000ffcb 7fffffff c0204128
[17828.143957] be20: c0046e40 ee2d2c00 00000000 00000000 00000000 eeb31840 eebba000 00000000
[17828.152138] be40: eebbbe6c eebbbe50 c0414204 c03ed628 d93a496c 00001036 eebbbeec 00000000
[17828.160321] be60: eebbbe7c eebbbe70 c0391600 c041417c eebbbed4 eebbbe80 c039169c c03915f0
[17828.168504] be80: eebbbf34 00000000 00000000 00000001 00000000 00000000 eebbbeec 00000000
[17828.176686] bea0: 00000000 00000000 00000000 eebbbf00 00000000 eeb31840 eebbbf80 00000000
[17828.184870] bec0: 00000000 c000f9c4 eebbbf3c eebbbed8 c00cc698 c039161c 000014b0 00000004
[17828.193052] bee0: eebda018 bebf89ac 000014b0 00000001 00000000 000014b0 eebbbee4 00000001
[17828.201237] bf00: eeb31840 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[17828.209420] bf20: eeb31840 000014b0 bebf89ac eebbbf80 eebbbf4c eebbbf40 c00cc6f0 c00cc61c
[17828.217603] bf40: eebbbf7c eebbbf50 c00cd3a0 c00cc6c8 c000f9c4 eebbbfb0 eebbbf7c eeb31840
[17828.225786] bf60: eeb31840 000014b0 bebf89ac c000f9c4 eebbbfa4 eebbbf80 c00cdea8 c00cd314
[17828.233968] bf80: 00000000 00000000 00000004 0002a1e8 b6fd2140 00000004 00000000 eebbbfa8
[17828.242150] bfa0: c000f820 c00cde68 00000004 0002a1e8 00000004 bebf89ac 000014b0 bebfa9ac
[17828.250332] bfc0: 00000004 0002a1e8 b6fd2140 00000004 000014b0 00000177 0002a1f0 00000003
[17828.258514] bfe0: 00000000 bebf88e4 00014a57 b6f0d4d6 40030030 00000004 80488d08 2125c40e
[17828.266690] Backtrace: 
[17828.269173] [<c03a730c>] (__netif_receive_skb_core) from [<c03a9b60>] (__netif_receive_skb+0x30/0x8c)
[17828.278397]  r10:00000001 r9:00000000 r8:ef7ba1b0 r7:ef7ba1a4 r6:00000040 r5:ef7ba148
[17828.286301]  r4:ef7ba1b8
[17828.288863] [<c03a9b30>] (__netif_receive_skb) from [<c03aaac4>] (process_backlog+0x94/0x140)
[17828.297390]  r4:ef7ba1b8 r3:ef7ba148
[17828.301008] [<c03aaa30>] (process_backlog) from [<c03aa2cc>] (net_rx_action+0x1fc/0x2f0)
[17828.309101]  r10:eebbbaf0 r9:00000040 r8:c05ea100 r7:0000012c r6:001abec9 r5:c03aaa30
[17828.317014]  r4:ef7ba1b8 r3:eebbbaf0
[17828.320637] [<c03aa0d0>] (net_rx_action) from [<c0022444>] (__do_softirq+0x134/0x254)
[17828.328470]  r10:c05ea080 r9:40000003 r8:00000101 r7:eebba000 r6:c05ea08c r5:00000003
[17828.336381]  r4:00000000
[17828.338937] [<c0022310>] (__do_softirq) from [<c0022624>] (do_softirq+0x68/0x70)
[17828.346334]  r10:00000006 r9:ef06a800 r8:0000000e r7:00000000 r6:eeb1c200 r5:ee05ba30
[17828.354238]  r4:60030013
[17828.356797] [<c00225bc>] (do_softirq) from [<c00226e8>] (__local_bh_enable_ip+0xbc/0xd0)
[17828.364890]  r4:00000200 r3:00000008
[17828.368520] [<c002262c>] (__local_bh_enable_ip) from [<c03e0360>] (ip_finish_output2+0x1b4/0x3b8)
[17828.377395]  r5:ee05ba30 r4:00000000
[17828.381005] [<c03e01ac>] (ip_finish_output2) from [<c03e1ed4>] (ip_finish_output+0x14c/0x20c)
[17828.389531]  r8:ee2d2c00 r7:ee2d2c00 r6:c0606280 r5:0000ffff r4:ee05ba30
[17828.396321] [<c03e1d88>] (ip_finish_output) from [<c03e2a34>] (ip_output+0x124/0x130)
[17828.404153]  r10:00000006 r9:ef06a800 r8:ee2d2c00 r7:00000000 r6:0971f1b9 r5:c0606280
[17828.412061]  r4:ee05ba30
[17828.414617] [<c03e2910>] (ip_output) from [<c03e2110>] (ip_local_out+0x40/0x44)
[17828.421927]  r9:0000ab00 r8:ee3e5000 r7:00000000 r6:c0606280 r5:ee2d2c00 r4:ee05ba30
[17828.429753] [<c03e20d0>] (ip_local_out) from [<c03e23fc>] (ip_queue_xmit+0x13c/0x3a4)
[17828.437586]  r6:ee2d2e20 r5:ee2d2c00 r4:ee05ba30 r3:00000000
[17828.443317] [<c03e22c0>] (ip_queue_xmit) from [<c03f9d08>] (tcp_transmit_skb+0x40c/0x860)
[17828.451496]  r10:00000006 r9:0000ab00 r8:0000ab00 r7:00000000 r6:00000000 r5:ee05ba30
[17828.459412]  r4:ee2d2c00
[17828.461965] [<c03f98fc>] (tcp_transmit_skb) from [<c03fa354>] (tcp_write_xmit+0x1f8/0xe80)
[17828.470231]  r10:c05ec068 r9:000014b0 r8:0000ffcb r7:00000000 r6:00040000 r5:ee2d2c00
[17828.478131]  r4:ee05b980
[17828.480686] [<c03fa15c>] (tcp_write_xmit) from [<c03fb2a4>] (__tcp_push_pending_frames+0x3c/0xa4)
[17828.489559]  r10:00000000 r9:eebbbe84 r8:9274572f r7:00000000 r6:0000ffcb r5:ee05b980
[17828.497464]  r4:ee2d2c00
[17828.500027] [<c03fb268>] (__tcp_push_pending_frames) from [<c03ea2e8>] (tcp_push+0x110/0x134)
[17828.508552]  r4:ee2d2c00
[17828.511114] [<c03ea1d8>] (tcp_push) from [<c03edd44>] (tcp_sendmsg+0x728/0xa7c)
[17828.518425]  r7:0000ffcb r6:00000e50 r5:ee2d2c00 r4:000014b0
[17828.524157] [<c03ed61c>] (tcp_sendmsg) from [<c0414204>] (inet_sendmsg+0x94/0xc8)
[17828.531640]  r10:00000000 r9:eebba000 r8:eeb31840 r7:00000000 r6:00000000 r5:00000000
[17828.539540]  r4:ee2d2c00
[17828.542117] [<c0414170>] (inet_sendmsg) from [<c0391600>] (sock_sendmsg+0x1c/0x2c)
[17828.549688]  r5:00000000 r4:eebbbeec
[17828.553299] [<c03915e4>] (sock_sendmsg) from [<c039169c>] (sock_write_iter+0x8c/0xc0)
[17828.561164] [<c0391610>] (sock_write_iter) from [<c00cc698>] (new_sync_write+0x88/0xac)
[17828.569169]  r8:c000f9c4 r7:00000000 r6:00000000 r5:eebbbf80 r4:eeb31840
[17828.575947] [<c00cc610>] (new_sync_write) from [<c00cc6f0>] (__vfs_write+0x34/0x40)
[17828.583605]  r7:eebbbf80 r6:bebf89ac r5:000014b0 r4:eeb31840
[17828.589335] [<c00cc6bc>] (__vfs_write) from [<c00cd3a0>] (vfs_write+0x98/0x16c)
[17828.596652] [<c00cd308>] (vfs_write) from [<c00cdea8>] (SyS_write+0x4c/0xa8)
[17828.603702]  r8:c000f9c4 r7:bebf89ac r6:000014b0 r5:eeb31840 r4:eeb31840
[17828.610494] [<c00cde5c>] (SyS_write) from [<c000f820>] (ret_fast_syscall+0x0/0x34)
[17828.618064]  r7:00000004 r6:b6fd2140 r5:0002a1e8 r4:00000004
[17828.623787] Code: e1a03006 e12fff3c e51b4058 e1a0200a (e59a3014) 
[17828.633464] ---[ end trace 292e54b4b334809b ]---
[17828.638144] Kernel panic - not syncing: Fatal exception in interrupt
[17828.644528] CPU0: stopping
[17828.647267] CPU: 0 PID: 380 Comm: stress-ng-socke Tainted: G      D    O    4.5.4 #1
[17828.655012] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[17828.661542] Backtrace: 
[17828.664032] [<c0012a24>] (dump_backtrace) from [<c0012c20>] (show_stack+0x18/0x1c)
[17828.671604]  r6:60030193 r5:c05f6f00 r4:00000000 r3:00000000
[17828.677331] [<c0012c08>] (show_stack) from [<c01fe6ac>] (dump_stack+0x9c/0xb0)
[17828.684561] [<c01fe610>] (dump_stack) from [<c0014c80>] (handle_IPI+0x170/0x190)
[17828.691957]  r6:00000000 r5:00000000 r4:c060e2d8 r3:c05e2da4
[17828.697678] [<c0014b10>] (handle_IPI) from [<c0009434>] (gic_handle_irq+0x8c/0x90)
[17828.705248]  r7:eebd5cf8 r6:f400010c r5:c05ea740 r4:c05f6fb0
[17828.710969] [<c00093a8>] (gic_handle_irq) from [<c0013740>] (__irq_svc+0x40/0x54)
[17828.718454] Exception stack(0xeebd5cf8 to 0xeebd5d40)
[17828.723508] 5ce0:                                                       bebf992c ed69bc50
[17828.731689] 5d00: 00001000 43434343 43434343 43434343 43434343 43434343 43434343 ed69b310
[17828.739870] 5d20: bebf900c eebd5dac 43434343 eebd5d4c 43434343 c01fb6d0 20030013 ffffffff
[17828.748047]  r9:ed69b310 r8:43434343 r7:eebd5d2c r6:ffffffff r5:20030013 r4:c01fb6d0
[17828.755883] [<c020ff58>] (copy_page_to_iter) from [<c039e984>] (skb_copy_datagram_iter+0xdc/0x1b8)
[17828.764842]  r10:eea24e30 r9:00000001 r8:00000660 r7:00000660 r6:00005350 r5:000019a0
[17828.772743]  r4:000019a0
[17828.775304] [<c039e8a8>] (skb_copy_datagram_iter) from [<c03eb0fc>] (tcp_recvmsg+0x518/0x9d4)
[17828.783828]  r10:00000000 r9:ee2d6bd8 r8:00000000 r7:ee2d6880 r6:00002000 r5:00000000
[17828.791729]  r4:eea24e30
[17828.794286] [<c03eabe4>] (tcp_recvmsg) from [<c0413b78>] (inet_recvmsg+0x9c/0xb0)
[17828.801768]  r10:00000000 r9:eebd4000 r8:c000f9c4 r7:ec909480 r6:eebd5f00 r5:00000000
[17828.809669]  r4:eebd5e8c
[17828.812227] [<c0413adc>] (inet_recvmsg) from [<c0390458>] (sock_read_iter+0x94/0xc0)
[17828.819971]  r6:eebd5f00 r5:00000000 r4:eebd5eec
[17828.824644] [<c03903c4>] (sock_read_iter) from [<c00cc5b0>] (new_sync_read+0x88/0xa8)
[17828.832474]  r7:00000000 r6:00000000 r5:eebd5f80 r4:ec909480
[17828.838196] [<c00cc528>] (new_sync_read) from [<c00cc604>] (__vfs_read+0x34/0x40)
[17828.845679]  r7:bebf89ac r6:eebd5f80 r5:ec909480 r4:bebf89ac
[17828.851401] [<c00cc5d0>] (__vfs_read) from [<c00cd280>] (vfs_read+0x84/0x10c)
[17828.858541] [<c00cd1fc>] (vfs_read) from [<c00cde00>] (SyS_read+0x4c/0xa8)
[17828.865417]  r9:eebd4000 r8:c000f9c4 r7:bebf89ac r6:00002000 r5:ec909480 r4:ec909480
[17828.873238] [<c00cddb4>] (SyS_read) from [<c000f820>] (ret_fast_syscall+0x0/0x34)
[17828.880721]  r7:00000003 r6:00000003 r5:00000065 r4:bebf8920
[17828.886441] CPU3: stopping
[17828.889157] CPU: 3 PID: 378 Comm: stress-ng-socke Tainted: G      D    O    4.5.4 #1
[17828.896903] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[17828.903431] Backtrace: 
[17828.905902] [<c0012a24>] (dump_backtrace) from [<c0012c20>] (show_stack+0x18/0x1c)
[17828.913472]  r6:60030193 r5:c05f6f00 r4:00000000 r3:00000000
[17828.919195] [<c0012c08>] (show_stack) from [<c01fe6ac>] (dump_stack+0x9c/0xb0)
[17828.926424] [<c01fe610>] (dump_stack) from [<c0014c80>] (handle_IPI+0x170/0x190)
[17828.933820]  r6:00000000 r5:00000003 r4:c060e2d8 r3:c05e2da4
[17828.939539] [<c0014b10>] (handle_IPI) from [<c0009434>] (gic_handle_irq+0x8c/0x90)
[17828.947109]  r7:eea2dd60 r6:f400010c r5:c05ea740 r4:c05f6fb0
[17828.952829] [<c00093a8>] (gic_handle_irq) from [<c0013740>] (__irq_svc+0x40/0x54)
[17828.960314] Exception stack(0xeea2dd60 to 0xeea2dda8)
[17828.965370] dd60: ee2d0b00 eea24300 00000000 00000000 ee2d0b00 eea24300 00001700 0000ffcb
[17828.973552] dd80: 61cc4f57 eea2de84 00000000 eea2ddcc eea2ddd0 eea2ddb0 c03edfac c03ea444
[17828.981730] dda0: 60030013 ffffffff
[17828.985220]  r9:eea2de84 r8:61cc4f57 r7:eea2dd94 r6:ffffffff r5:60030013 r4:c03ea444
[17828.993044] [<c03ea424>] (tcp_tx_timestamp) from [<c03edfac>] (tcp_sendmsg+0x990/0xa7c)
[17829.001048]  r6:00001700 r5:ee2d0b00 r4:00001d60 r3:00001d60
[17829.006769] [<c03ed61c>] (tcp_sendmsg) from [<c0414204>] (inet_sendmsg+0x94/0xc8)
[17829.014252]  r10:00000000 r9:eea2c000 r8:ed6469c0 r7:00000000 r6:00000000 r5:00000000
[17829.022154]  r4:ee2d0b00
[17829.024709] [<c0414170>] (inet_sendmsg) from [<c0391600>] (sock_sendmsg+0x1c/0x2c)
[17829.032278]  r5:00000000 r4:eea2deec
[17829.035888] [<c03915e4>] (sock_sendmsg) from [<c039169c>] (sock_write_iter+0x8c/0xc0)
[17829.043727] [<c0391610>] (sock_write_iter) from [<c00cc698>] (new_sync_write+0x88/0xac)
[17829.051730]  r8:c000f9c4 r7:00000000 r6:00000000 r5:eea2df80 r4:ed6469c0
[17829.058509] [<c00cc610>] (new_sync_write) from [<c00cc6f0>] (__vfs_write+0x34/0x40)
[17829.066165]  r7:eea2df80 r6:bebf89ac r5:00001d60 r4:ed6469c0
[17829.071885] [<c00cc6bc>] (__vfs_write) from [<c00cd3a0>] (vfs_write+0x98/0x16c)
[17829.079199] [<c00cd308>] (vfs_write) from [<c00cdea8>] (SyS_write+0x4c/0xa8)
[17829.086247]  r8:c000f9c4 r7:bebf89ac r6:00001d60 r5:ed6469c0 r4:ed6469c0
[17829.093023] [<c00cde5c>] (SyS_write) from [<c000f820>] (ret_fast_syscall+0x0/0x34)
[17829.100593]  r7:00000004 r6:b6fd2160 r5:0002a1e8 r4:00000004
[17829.106311] CPU2: stopping
[17829.109027] CPU: 2 PID: 376 Comm: stress-ng-socke Tainted: G      D    O    4.5.4 #1
[17829.116772] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[17829.123300] Backtrace: 
[17829.125772] [<c0012a24>] (dump_backtrace) from [<c0012c20>] (show_stack+0x18/0x1c)
[17829.133342]  r6:60030193 r5:c05f6f00 r4:00000000 r3:00000000
[17829.139065] [<c0012c08>] (show_stack) from [<c01fe6ac>] (dump_stack+0x9c/0xb0)
[17829.146293] [<c01fe610>] (dump_stack) from [<c0014c80>] (handle_IPI+0x170/0x190)
[17829.153689]  r6:00000000 r5:00000002 r4:c060e2d8 r3:c05e2da4
[17829.159409] [<c0014b10>] (handle_IPI) from [<c0009434>] (gic_handle_irq+0x8c/0x90)
[17829.166979]  r7:ee3ddd28 r6:f400010c r5:c05ea740 r4:c05f6fb0
[17829.172699] [<c00093a8>] (gic_handle_irq) from [<c0013740>] (__irq_svc+0x40/0x54)
[17829.180183] Exception stack(0xee3ddd28 to 0xee3ddd70)
[17829.185240] dd20:                   ecac7cd0 bebf976c 00000030 5a5a5a5a 5a5a5a5a 5a5a5a5a
[17829.193422] dd40: 5a5a5a5a 5a5a5a5a 5a5a5a5a ecac7d80 00000000 ee3dddcc 5a5a5a5a ee3ddd7c
[17829.201601] dd60: 5a5a5a5a c01fb2c0 20030013 ffffffff
[17829.206653]  r9:ecac7d80 r8:5a5a5a5a r7:ee3ddd5c r6:ffffffff r5:20030013 r4:c01fb2c0
[17829.214477] [<c020e03c>] (copy_from_iter) from [<c03ede00>] (tcp_sendmsg+0x7e4/0xa7c)
[17829.222307]  r10:00000000 r9:ee3dde84 r8:00006f30 r7:00005580 r6:00000e50 r5:ee36ac00
[17829.230209]  r4:ee2d9680 r3:00000000
[17829.233819] [<c03ed61c>] (tcp_sendmsg) from [<c0414204>] (inet_sendmsg+0x94/0xc8)
[17829.241302]  r10:00000000 r9:ee3dc000 r8:ee9b6c00 r7:00000000 r6:00000000 r5:00000000
[17829.249204]  r4:ee36ac00
[17829.251759] [<c0414170>] (inet_sendmsg) from [<c0391600>] (sock_sendmsg+0x1c/0x2c)
[17829.259328]  r5:00000000 r4:ee3ddeec
[17829.262939] [<c03915e4>] (sock_sendmsg) from [<c039169c>] (sock_write_iter+0x8c/0xc0)
[17829.270778] [<c0391610>] (sock_write_iter) from [<c00cc698>] (new_sync_write+0x88/0xac)
[17829.278781]  r8:c000f9c4 r7:00000000 r6:00000000 r5:ee3ddf80 r4:ee9b6c00
[17829.285559] [<c00cc610>] (new_sync_write) from [<c00cc6f0>] (__vfs_write+0x34/0x40)
[17829.293216]  r7:ee3ddf80 r6:bebf89ac r5:00001c80 r4:ee9b6c00
[17829.298936] [<c00cc6bc>] (__vfs_write) from [<c00cd3a0>] (vfs_write+0x98/0x16c)
[17829.306250] [<c00cd308>] (vfs_write) from [<c00cdea8>] (SyS_write+0x4c/0xa8)
[17829.313299]  r8:c000f9c4 r7:bebf89ac r6:00001c80 r5:ee9b6c00 r4:ee9b6c00
[17829.320077] [<c00cde5c>] (SyS_write) from [<c000f820>] (ret_fast_syscall+0x0/0x34)
[17829.327646]  r7:00000004 r6:b6fd2158 r5:0002a1e8 r4:00000004
[17829.333369] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
