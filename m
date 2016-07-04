From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 04 Jul 2016 13:26:11 +0200
Subject: [BUG] Regression, usb-dwc3 not working, Odroid XU3, usb 3.0
Message-ID: <577A47D3.7020900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Since three recent next releases (first on 20160630), on Odroid XU3 board
the USB 3.0 host port (the only one) stopped working.

This is a "samsung,exynos5250-dwusb3" (drivers/usb/dwc3/dwc3-exynos.c).

Two issues here:
1. The port does not show up as USB 3.0 device.
This one device is missing:
	Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub

2. The port does not work even for 2.0 devices (I didn't test 1.0).


config: exynos_defconfig (ARM)
DTS: exynos5422-odroidxu3.dts


Bisect points to merge commit:
# first bad commit: [215db9481814bfae69cde49d82865c74189e435f] Merge tag 'usb-for-v4.8' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next

Bisect log:
# bad: [d936b5e461b9545fa9a8a3357a40eea17aea5e28] Add linux-next specific files for 20160701
# good: [1a0a02d1efa066001fd315c1b4df583d939fa2c4] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect start 'next/master' 'next/stable'
# good: [e3f87b945da70903776e67a549ab3df78c4d6389] Merge remote-tracking branch 'drm/drm-next'
git bisect good e3f87b945da70903776e67a549ab3df78c4d6389
# good: [d71ef0d1368d8d6054ef44765c0f1fe866f4b2e0] Merge remote-tracking branch 'clockevents/clockevents/next'
git bisect good d71ef0d1368d8d6054ef44765c0f1fe866f4b2e0
# bad: [9aff7978ef28c3eb5415c624049c189d48b13dff] Merge remote-tracking branch 'staging/staging-next'
git bisect bad 9aff7978ef28c3eb5415c624049c189d48b13dff
# good: [47feda95152a47aa15091c93ea7ad82869127278] Merge remote-tracking branch 'tty/tty-next'
git bisect good 47feda95152a47aa15091c93ea7ad82869127278
# good: [6f65aa8925f7a908eb4d08339c03c40a300ac461] staging/android: make sw_ioctl info internal to sw_sync.c
git bisect good 6f65aa8925f7a908eb4d08339c03c40a300ac461
# bad: [215db9481814bfae69cde49d82865c74189e435f] Merge tag 'usb-for-v4.8' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
git bisect bad 215db9481814bfae69cde49d82865c74189e435f
# good: [f2df679b6c556fd3b0b7ffafea170f1679086455] usb: dwc3: gadget: avoid while(1) in run_stop()
git bisect good f2df679b6c556fd3b0b7ffafea170f1679086455
# good: [0d7995031a8e7a34e5638d57a44a51aae39e321c] usb: renesas_usbhs: show error code when probe failed
git bisect good 0d7995031a8e7a34e5638d57a44a51aae39e321c
# good: [86065c2719a5685cef36945f09def3f0658c7860] xhci: don't rely on precalculated value of needed trbs in the enqueue loop
git bisect good 86065c2719a5685cef36945f09def3f0658c7860
# good: [95b57df45062d7005ff01ed956b69166b6b3481e] usb: dwc3: host: use build-in property instead of platform data
git bisect good 95b57df45062d7005ff01ed956b69166b6b3481e
# good: [4fdef698383db07d829da567e0e405fc41ff3a89] usb: renesas_usbhs: fix NULL pointer dereference in xfer_work()
git bisect good 4fdef698383db07d829da567e0e405fc41ff3a89
# good: [4e84e22195910b315b36eca149febd0a6b02f7c4] usb: early/ehci-dbgp: make it explicitly non-modular
git bisect good 4e84e22195910b315b36eca149febd0a6b02f7c4
# good: [107a4b535b7d1da4203a26949775d67173e96e04] usb: renesas_usbhs: make usbhs_write32() static
git bisect good 107a4b535b7d1da4203a26949775d67173e96e04
# good: [15e4292a2d21e9997fdb2b8c014cc461b3f268f0] usb: renesas_usbhs: protect the CFIFOSEL setting in usbhsg_ep_enable()
git bisect good 15e4292a2d21e9997fdb2b8c014cc461b3f268f0
# first bad commit: [215db9481814bfae69cde49d82865c74189e435f] Merge tag 'usb-for-v4.8' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next

Attached dmesg - good and bad.


Please let me know if you need more information.

Best regards,
Krzysztof
-------------- next part --------------
[    0.000000] Booting Linux on physical CPU 0x100
[    0.000000] Linux version 4.7.0-rc4-00069-gf2df679b6c55 (k.kozlowski at AMDC2174) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) ) #926 SMP PREEMPT Mon Jul 4 12:51:19 CEST 2016
[    0.000000] CPU: ARMv7 Processor [410fc073] revision 3 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: Hardkernel Odroid XU3
[    0.000000] cma: Reserved 64 MiB at 0xba800000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Samsung CPU ID: 0xe5422001
[    0.000000] On node 0 totalpages: 514560
[    0.000000] free_area_init_node: node 0, pgdat c0c4c4c0, node_mem_map ef020000
[    0.000000]   Normal zone: 1536 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 192512 pages, LIFO batch:31
[    0.000000]   HighMem zone: 322048 pages, LIFO batch:31
[    0.000000] Running under secure firmware.
[    0.000000] percpu: Embedded 13 pages/cpu @eef62000 s24000 r8192 d21056 u53248
[    0.000000] pcpu-alloc: s24000 r8192 d21056 u53248 alloc=13*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 513024
[    0.000000] Kernel command line: console=tty1 console=ttySAC2,115200n8 root=PARTUUID=836e953a-01 rootwait rw no_console_suspend smsc95xx.macaddr=00:1e:06:61:7a:93
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1955248K/2058240K available (7382K kernel code, 369K rwdata, 2480K rodata, 1024K init, 8079K bss, 37456K reserved, 65536K cma-reserved, 1222656K highmem)
[    0.000000] Virtual kernel memory layout:
                   vector  : 0xffff0000 - 0xffff1000   (   4 kB)
                   fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
                   vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
                   lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
                   pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
                   modules : 0xbf000000 - 0xbfe00000   (  14 MB)
                     .text : 0xc0008000 - 0xc0aa1934   (10855 kB)
                     .init : 0xc0b00000 - 0xc0c00000   (1024 kB)
                     .data : 0xc0c00000 - 0xc0c5c4d8   ( 370 kB)
                      .bss : 0xc0c5e000 - 0xc1441d74   (8080 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  RCU lockdep checking is enabled.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] GIC physical location is 0x10481000
[    0.000000] Switching to timer-based delay loop, resolution 41ns
[    0.000000] clocksource: mct-frc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.000008] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
[    0.001599] Console: colour dummy device 80x30
[    0.004489] console [tty1] enabled
[    0.004531] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.004596] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.004635] ... MAX_LOCK_DEPTH:          48
[    0.004675] ... MAX_LOCKDEP_KEYS:        8191
[    0.004714] ... CLASSHASH_SIZE:          4096
[    0.004754] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.004794] ... MAX_LOCKDEP_CHAINS:      65536
[    0.004834] ... CHAINHASH_SIZE:          32768
[    0.004874]  memory used by lock dependency info: 5167 kB
[    0.004917]  per task-struct memory footprint: 1536 bytes
[    0.005343] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=120000)
[    0.005431] pid_max: default: 32768 minimum: 301
[    0.005901] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.005961] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.009406] CPU: Testing write buffer coherency: ok
[    0.011727] CPU0: update cpu_capacity 448
[    0.011788] CPU0: thread -1, cpu 0, socket 1, mpidr 80000100
[    0.012039] Setting up static identity map for 0x40100000 - 0x40100058
[    0.012954] ARM CCI driver probed
[    0.013261] Exynos MCPM support installed
[    0.065483] CPU1: update cpu_capacity 448
[    0.065495] CPU1: thread -1, cpu 1, socket 1, mpidr 80000101
[    0.085398] CPU2: update cpu_capacity 448
[    0.085408] CPU2: thread -1, cpu 2, socket 1, mpidr 80000102
[    0.105391] CPU3: update cpu_capacity 448
[    0.105401] CPU3: thread -1, cpu 3, socket 1, mpidr 80000103
[    0.125395] CPU4: update cpu_capacity 1535
[    0.125404] CPU4: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.145373] CPU5: update cpu_capacity 1535
[    0.145381] CPU5: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.165372] CPU6: update cpu_capacity 1535
[    0.165381] CPU6: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.185396] CPU7: update cpu_capacity 1535
[    0.185404] CPU7: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.185712] Brought up 8 CPUs
[    0.186306] SMP: Total of 8 processors activated (384.00 BogoMIPS).
[    0.186362] CPU: WARNING: CPU(s) started in wrong/inconsistent modes (primary CPU mode 0x1a)
[    0.186436] CPU: This may indicate a broken bootloader or firmware.
[    0.190727] devtmpfs: initialized
[    0.278159] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 3
[    0.281160] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 9556302231375000 ns
[    0.285147] pinctrl core: initialized pinctrl subsystem
[    0.290787] NET: Registered protocol family 16
[    0.295078] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.310151] cpuidle: using governor menu
[    0.326608] exynos-audss-clk 3810000.audss-clock-controller: setup completed
[    0.337780] gpio gpiochip0: (gpy7): added GPIO chardev (254:0)
[    0.339494] gpiochip_setup_dev: registered GPIOs 0 to 7 on device: gpiochip0 (gpy7)
[    0.339574] gpio gpiochip1: (gpx0): added GPIO chardev (254:1)
[    0.340702] gpiochip_setup_dev: registered GPIOs 8 to 15 on device: gpiochip1 (gpx0)
[    0.340769] gpio gpiochip2: (gpx1): added GPIO chardev (254:2)
[    0.341820] gpiochip_setup_dev: registered GPIOs 16 to 23 on device: gpiochip2 (gpx1)
[    0.341886] gpio gpiochip3: (gpx2): added GPIO chardev (254:3)
[    0.342929] gpiochip_setup_dev: registered GPIOs 24 to 31 on device: gpiochip3 (gpx2)
[    0.342995] gpio gpiochip4: (gpx3): added GPIO chardev (254:4)
[    0.343999] gpiochip_setup_dev: registered GPIOs 32 to 39 on device: gpiochip4 (gpx3)
[    0.347339] gpio gpiochip5: (gpc0): added GPIO chardev (254:5)
[    0.348410] gpiochip_setup_dev: registered GPIOs 40 to 47 on device: gpiochip5 (gpc0)
[    0.348477] gpio gpiochip6: (gpc1): added GPIO chardev (254:6)
[    0.349483] gpiochip_setup_dev: registered GPIOs 48 to 55 on device: gpiochip6 (gpc1)
[    0.349548] gpio gpiochip7: (gpc2): added GPIO chardev (254:7)
[    0.350617] gpiochip_setup_dev: registered GPIOs 56 to 62 on device: gpiochip7 (gpc2)
[    0.350681] gpio gpiochip8: (gpc3): added GPIO chardev (254:8)
[    0.351688] gpiochip_setup_dev: registered GPIOs 63 to 66 on device: gpiochip8 (gpc3)
[    0.351754] gpio gpiochip9: (gpc4): added GPIO chardev (254:9)
[    0.352766] gpiochip_setup_dev: registered GPIOs 67 to 68 on device: gpiochip9 (gpc4)
[    0.352831] gpio gpiochip10: (gpd1): added GPIO chardev (254:10)
[    0.353832] gpiochip_setup_dev: registered GPIOs 69 to 76 on device: gpiochip10 (gpd1)
[    0.353896] gpio gpiochip11: (gpy0): added GPIO chardev (254:11)
[    0.354905] gpiochip_setup_dev: registered GPIOs 77 to 82 on device: gpiochip11 (gpy0)
[    0.355025] gpio gpiochip12: (gpy1): added GPIO chardev (254:12)
[    0.356070] gpiochip_setup_dev: registered GPIOs 83 to 86 on device: gpiochip12 (gpy1)
[    0.356135] gpio gpiochip13: (gpy2): added GPIO chardev (254:13)
[    0.357147] gpiochip_setup_dev: registered GPIOs 87 to 92 on device: gpiochip13 (gpy2)
[    0.357213] gpio gpiochip14: (gpy3): added GPIO chardev (254:14)
[    0.358226] gpiochip_setup_dev: registered GPIOs 93 to 100 on device: gpiochip14 (gpy3)
[    0.358292] gpio gpiochip15: (gpy4): added GPIO chardev (254:15)
[    0.359315] gpiochip_setup_dev: registered GPIOs 101 to 108 on device: gpiochip15 (gpy4)
[    0.359387] gpio gpiochip16: (gpy5): added GPIO chardev (254:16)
[    0.360449] gpiochip_setup_dev: registered GPIOs 109 to 116 on device: gpiochip16 (gpy5)
[    0.360514] gpio gpiochip17: (gpy6): added GPIO chardev (254:17)
[    0.361537] gpiochip_setup_dev: registered GPIOs 117 to 124 on device: gpiochip17 (gpy6)
[    0.364087] gpio gpiochip18: (gpe0): added GPIO chardev (254:18)
[    0.365225] gpiochip_setup_dev: registered GPIOs 125 to 132 on device: gpiochip18 (gpe0)
[    0.365292] gpio gpiochip19: (gpe1): added GPIO chardev (254:19)
[    0.366325] gpiochip_setup_dev: registered GPIOs 133 to 134 on device: gpiochip19 (gpe1)
[    0.366391] gpio gpiochip20: (gpf0): added GPIO chardev (254:20)
[    0.367421] gpiochip_setup_dev: registered GPIOs 135 to 140 on device: gpiochip20 (gpf0)
[    0.367485] gpio gpiochip21: (gpf1): added GPIO chardev (254:21)
[    0.368519] gpiochip_setup_dev: registered GPIOs 141 to 148 on device: gpiochip21 (gpf1)
[    0.368585] gpio gpiochip22: (gpg0): added GPIO chardev (254:22)
[    0.369611] gpiochip_setup_dev: registered GPIOs 149 to 156 on device: gpiochip22 (gpg0)
[    0.369676] gpio gpiochip23: (gpg1): added GPIO chardev (254:23)
[    0.370782] gpiochip_setup_dev: registered GPIOs 157 to 164 on device: gpiochip23 (gpg1)
[    0.370846] gpio gpiochip24: (gpg2): added GPIO chardev (254:24)
[    0.371879] gpiochip_setup_dev: registered GPIOs 165 to 166 on device: gpiochip24 (gpg2)
[    0.371943] gpio gpiochip25: (gpj4): added GPIO chardev (254:25)
[    0.373059] gpiochip_setup_dev: registered GPIOs 167 to 170 on device: gpiochip25 (gpj4)
[    0.375244] gpio gpiochip26: (gpa0): added GPIO chardev (254:26)
[    0.376336] gpiochip_setup_dev: registered GPIOs 171 to 178 on device: gpiochip26 (gpa0)
[    0.376402] gpio gpiochip27: (gpa1): added GPIO chardev (254:27)
[    0.377442] gpiochip_setup_dev: registered GPIOs 179 to 184 on device: gpiochip27 (gpa1)
[    0.377508] gpio gpiochip28: (gpa2): added GPIO chardev (254:28)
[    0.378536] gpiochip_setup_dev: registered GPIOs 185 to 192 on device: gpiochip28 (gpa2)
[    0.378601] gpio gpiochip29: (gpb0): added GPIO chardev (254:29)
[    0.379644] gpiochip_setup_dev: registered GPIOs 193 to 197 on device: gpiochip29 (gpb0)
[    0.379718] gpio gpiochip30: (gpb1): added GPIO chardev (254:30)
[    0.380807] gpiochip_setup_dev: registered GPIOs 198 to 202 on device: gpiochip30 (gpb1)
[    0.380872] gpio gpiochip31: (gpb2): added GPIO chardev (254:31)
[    0.381879] gpiochip_setup_dev: registered GPIOs 203 to 206 on device: gpiochip31 (gpb2)
[    0.381958] gpio gpiochip32: (gpb3): added GPIO chardev (254:32)
[    0.382972] gpiochip_setup_dev: registered GPIOs 207 to 214 on device: gpiochip32 (gpb3)
[    0.383036] gpio gpiochip33: (gpb4): added GPIO chardev (254:33)
[    0.384042] gpiochip_setup_dev: registered GPIOs 215 to 216 on device: gpiochip33 (gpb4)
[    0.384107] gpio gpiochip34: (gph0): added GPIO chardev (254:34)
[    0.385159] gpiochip_setup_dev: registered GPIOs 217 to 224 on device: gpiochip34 (gph0)
[    0.387520] gpio gpiochip35: (gpz): added GPIO chardev (254:35)
[    0.388576] gpiochip_setup_dev: registered GPIOs 225 to 231 on device: gpiochip35 (gpz)
[    0.403925] EXYNOS5420 PMU initialized
[    0.503832] SCSI subsystem initialized
[    0.505057] usbcore: registered new interface driver usbfs
[    0.505335] usbcore: registered new interface driver hub
[    0.505790] usbcore: registered new device driver usb
[    0.507978] s3c-i2c 12c60000.i2c: slave address 0x00
[    0.508050] s3c-i2c 12c60000.i2c: bus frequency set to 65 KHz
[    0.512860] s3c-i2c 12c60000.i2c: i2c-0: S3C I2C adapter
[    0.513367] s3c-i2c 12c80000.i2c: slave address 0x00
[    0.513431] s3c-i2c 12c80000.i2c: bus frequency set to 65 KHz
[    0.514879] s3c-i2c 12c80000.i2c: i2c-2: S3C I2C adapter
[    0.518264] Advanced Linux Sound Architecture Driver Initialized.
[    0.524756] clocksource: Switched to clocksource mct-frc
[    0.579384] NET: Registered protocol family 2
[    0.582141] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.582394] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.585565] TCP: Hash tables configured (established 8192 bind 8192)
[    0.585956] UDP hash table entries: 512 (order: 3, 40960 bytes)
[    0.586414] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
[    0.587844] NET: Registered protocol family 1
[    0.589553] RPC: Registered named UNIX socket transport module.
[    0.589619] RPC: Registered udp transport module.
[    0.589668] RPC: Registered tcp transport module.
[    0.589787] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.599298] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.601839] workingset: timestamp_bits=28 max_order=19 bucket_order=0
[    0.654965] NFS: Registering the id_resolver key type
[    0.655409] Key type id_resolver registered
[    0.655463] Key type id_legacy registered
[    0.655661] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    0.660188] bounce: pool size: 64 pages
[    0.661125] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.661278] io scheduler noop registered
[    0.661328] io scheduler deadline registered
[    0.661471] io scheduler cfq registered (default)
[    0.668542] 12130000.phy supply vbus not found, using dummy regulator
[    0.672378] 12100000.phy supply vbus not found, using dummy regulator
[    0.672814] 12100000.phy supply vbus-boost not found, using dummy regulator
[    0.674301] 12500000.phy supply vbus not found, using dummy regulator
[    0.674576] 12500000.phy supply vbus-boost not found, using dummy regulator
[    0.690371] dma-pl330 3880000.adma: Loaded driver for PL330 DMAC-241330
[    0.690450] dma-pl330 3880000.adma:  DBUFF-4x8bytes Num_Chans-6 Num_Peri-16 Num_Events-6
[    0.706367] dma-pl330 121a0000.pdma: Loaded driver for PL330 DMAC-241330
[    0.706445] dma-pl330 121a0000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    0.722430] dma-pl330 121b0000.pdma: Loaded driver for PL330 DMAC-241330
[    0.722507] dma-pl330 121b0000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    0.727153] dma-pl330 10800000.mdma: Loaded driver for PL330 DMAC-241330
[    0.727224] dma-pl330 10800000.mdma:         DBUFF-64x8bytes Num_Chans-8 Num_Peri-1 Num_Events-32
[    1.020434] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.029079] 12c00000.serial: ttySAC0 at MMIO 0x12c00000 (irq = 58, base_baud = 0) is a S3C6400/10
[    1.031238] 12c10000.serial: ttySAC1 at MMIO 0x12c10000 (irq = 59, base_baud = 0) is a S3C6400/10
[    1.032927] 12c20000.serial: ttySAC2 at MMIO 0x12c20000 (irq = 60, base_baud = 0) is a S3C6400/10
[    1.838628] console [ttySAC2] enabled
[    1.843498] 12c30000.serial: ttySAC3 at MMIO 0x12c30000 (irq = 61, base_baud = 0) is a S3C6400/10
[    1.855423] [drm] Initialized drm 1.1.0 20060810
[    1.865686] exynos-hdmi 14530000.hdmi: GPIO lookup for consumer hpd
[    1.865709] exynos-hdmi 14530000.hdmi: using device tree for GPIO lookup
[    1.865733] of_get_named_gpiod_flags: can't parse 'hpd-gpios' property of node '/hdmi at 14530000[0]'
[    1.865772] of_get_named_gpiod_flags: parsed 'hpd-gpio' property of node '/hdmi at 14530000[0]' - status (0)
[    1.866270] exynos-hdmi 14530000.hdmi: Failed to get supply 'vdd': -517
[    1.934874] brd: module loaded
[    1.976840] loop: module loaded
[    1.982826] usbcore: registered new interface driver r8152
[    1.987183] usbcore: registered new interface driver asix
[    1.992464] usbcore: registered new interface driver ax88179_178a
[    1.998514] usbcore: registered new interface driver cdc_ether
[    2.004393] usbcore: registered new interface driver smsc75xx
[    2.010116] usbcore: registered new interface driver smsc95xx
[    2.015755] usbcore: registered new interface driver net1080
[    2.021387] usbcore: registered new interface driver cdc_subset
[    2.027292] usbcore: registered new interface driver zaurus
[    2.032936] usbcore: registered new interface driver cdc_ncm
[    2.039648] exynos-dwc3 usb3-0: no suspend clk specified
[    2.043923] exynos-dwc3 usb3-1: no suspend clk specified
[    2.051144] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.056324] ehci-exynos: EHCI EXYNOS driver
[    2.060953] of_get_named_gpiod_flags: can't parse 'samsung,vbus-gpio' property of node '/usb at 12110000[0]'
[    2.061685] exynos-ehci 12110000.usb: EHCI Host Controller
[    2.066508] exynos-ehci 12110000.usb: new USB bus registered, assigned bus number 1
[    2.074370] exynos-ehci 12110000.usb: irq 114, io mem 0x12110000
[    2.084815] exynos-ehci 12110000.usb: USB 2.0 started, EHCI 1.00
[    2.090766] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.096204] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.103400] usb usb1: Product: EHCI Host Controller
[    2.108223] usb usb1: Manufacturer: Linux 4.7.0-rc4-00069-gf2df679b6c55 ehci_hcd
[    2.115611] usb usb1: SerialNumber: 12110000.usb
[    2.125062] hub 1-0:1.0: USB hub found
[    2.127610] hub 1-0:1.0: 3 ports detected
[    2.137435] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.142274] ohci-exynos: OHCI EXYNOS driver
[    2.147223] exynos-ohci 12120000.usb: USB Host Controller
[    2.151868] exynos-ohci 12120000.usb: new USB bus registered, assigned bus number 2
[    2.159844] exynos-ohci 12120000.usb: irq 114, io mem 0x12120000
[    2.224545] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    2.229954] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.238181] usb usb2: Product: USB Host Controller
[    2.241910] usb usb2: Manufacturer: Linux 4.7.0-rc4-00069-gf2df679b6c55 ohci_hcd
[    2.249277] usb usb2: SerialNumber: 12120000.usb
[    2.256592] hub 2-0:1.0: USB hub found
[    2.259002] hub 2-0:1.0: 3 ports detected
[    2.267760] usbcore: registered new interface driver usb-storage
[    2.274300] udc-core: couldn't find an available UDC - added [g_ether] to list of pending drivers
[    2.283511] mousedev: PS/2 mouse device common for all mice
[    2.293644] i2c /dev entries driver
[    2.326233] vdd_ldo9: Bringing 3300000uV into 3000000-3000000uV
[    2.345297] vddq_mmc2: Bringing 3300000uV into 2800000-2800000uV
[    2.355996] vdd_ldo15: Bringing 3300000uV into 3100000-3100000uV
[    2.374031] vdd_sd: Bringing 3300000uV into 2800000-2800000uV
[    2.444852] usb 1-1: new high-speed USB device number 2 using exynos-ehci
[    2.466691] s5m-rtc s2mps14-rtc: rtc core: registered s5m-rtc as rtc0
[    2.486691] ina2xx 0-0040: power monitor ina231 (Rshunt = 10000 uOhm)
[    2.494286] ina2xx 0-0041: power monitor ina231 (Rshunt = 10000 uOhm)
[    2.501906] ina2xx 0-0044: power monitor ina231 (Rshunt = 10000 uOhm)
[    2.509556] ina2xx 0-0045: power monitor ina231 (Rshunt = 10000 uOhm)
[    2.521778] exynos-tmu 10060000.tmu: More trip points than supported by this TMU.
[    2.527914] exynos-tmu 10060000.tmu: 2 trip points should be configured in polling mode.
[    2.547256] s3c2410-wdt 101d0000.watchdog: watchdog inactive, reset disabled, irq disabled
[    2.557507] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel at redhat.com
[    2.567922] pwrseq_emmc pwrseq: GPIO lookup for consumer reset
[    2.567943] pwrseq_emmc pwrseq: using device tree for GPIO lookup
[    2.567985] of_get_named_gpiod_flags: parsed 'reset-gpios' property of node '/pwrseq[0]' - status (0)
[    2.568440] sdhci: Secure Digital Host Controller Interface driver
[    2.573315] sdhci: Copyright(c) Pierre Ossman
[    2.578424] Synopsys Designware Multimedia Card Interface Driver
[    2.580637] usb 1-1: New USB device found, idVendor=0424, idProduct=9514
[    2.580649] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.584365] hub 1-1:1.0: USB hub found
[    2.584626] hub 1-1:1.0: 5 ports detected
[    2.607134] dwmmc_exynos 12200000.mmc: IDMAC supports 32-bit address mode.
[    2.612822] dwmmc_exynos 12200000.mmc: Using internal DMA controller.
[    2.619037] dwmmc_exynos 12200000.mmc: Version ID is 250a
[    2.624553] dwmmc_exynos 12200000.mmc: DW MMC controller at irq 65,64 bit host data width,64 deep fifo
[    2.635050] dwmmc_exynos 12200000.mmc: GPIO lookup for consumer cd
[    2.635073] dwmmc_exynos 12200000.mmc: using device tree for GPIO lookup
[    2.635113] of_get_named_gpiod_flags: parsed 'cd-gpios' property of node '/mmc at 12200000[0]' - status (0)
[    2.635170] dwmmc_exynos 12200000.mmc: Got CD GPIO
[    2.638531] dwmmc_exynos 12200000.mmc: GPIO lookup for consumer wp
[    2.638548] dwmmc_exynos 12200000.mmc: using device tree for GPIO lookup
[    2.638569] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/mmc at 12200000[0]'
[    2.638589] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/mmc at 12200000[0]'
[    2.638606] dwmmc_exynos 12200000.mmc: using lookup tables for GPIO lookup
[    2.638743] dwmmc_exynos 12200000.mmc: lookup for GPIO wp failed
[    2.638889] dwmmc_exynos 12200000.mmc: allocated mmc-pwrseq
[    2.675599] dwmmc_exynos 12200000.mmc: 1 slots initialized
[    2.680637] dwmmc_exynos 12220000.mmc: IDMAC supports 32-bit address mode.
[    2.686693] dwmmc_exynos 12220000.mmc: Using internal DMA controller.
[    2.692959] dwmmc_exynos 12220000.mmc: Version ID is 250a
[    2.698555] dwmmc_exynos 12220000.mmc: DW MMC controller at irq 66,64 bit host data width,64 deep fifo
[    2.708453] dwmmc_exynos 12220000.mmc: GPIO lookup for consumer cd
[    2.708473] dwmmc_exynos 12220000.mmc: using device tree for GPIO lookup
[    2.708495] of_get_named_gpiod_flags: can't parse 'cd-gpios' property of node '/mmc at 12220000[0]'
[    2.708516] of_get_named_gpiod_flags: can't parse 'cd-gpio' property of node '/mmc at 12220000[0]'
[    2.708533] dwmmc_exynos 12220000.mmc: using lookup tables for GPIO lookup
[    2.708555] dwmmc_exynos 12220000.mmc: lookup for GPIO cd failed
[    2.708578] dwmmc_exynos 12220000.mmc: GPIO lookup for consumer wp
[    2.708595] dwmmc_exynos 12220000.mmc: using device tree for GPIO lookup
[    2.708615] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/mmc at 12220000[0]'
[    2.708635] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/mmc at 12220000[0]'
[    2.708651] dwmmc_exynos 12220000.mmc: using lookup tables for GPIO lookup
[    2.708672] dwmmc_exynos 12220000.mmc: lookup for GPIO wp failed
[    2.740624] dwmmc_exynos 12220000.mmc: 1 slots initialized
[    2.748059] of_get_named_gpiod_flags: parsed 'gpios' property of node '/gpioleds/redled[0]' - status (0)
[    2.754928] s5p-secss 10830000.sss: s5p-sss driver registered
[    2.762074] usbcore: registered new interface driver usbhid
[    2.766323] usbhid: USB HID core driver
[    2.794496] NET: Registered protocol family 10
[    2.801159] sit: IPv6 over IPv4 tunneling driver
[    2.807823] NET: Registered protocol family 17
[    2.810967] NET: Registered protocol family 15
[    2.815731] Key type dns_resolver registered
[    2.821114] Registering SWP/SWPB emulation handler
[    2.824645] big.LITTLE switcher initializing
[    2.828780] CPU0 paired with CPU7
[    2.832038] CPU1 paired with CPU6
[    2.835336] CPU2 paired with CPU5
[    2.838586] CPU3 paired with CPU4
[    2.841915] GIC ID for CPU 0 cluster 1 is 4
[    2.846081] GIC ID for CPU 1 cluster 1 is 5
[    2.850235] GIC ID for CPU 2 cluster 1 is 6
[    2.854382] GIC ID for CPU 3 cluster 1 is 7
[    2.858554] GIC ID for CPU 0 cluster 0 is 0
[    2.874842] usb 1-1.1: new high-speed USB device number 3 using exynos-ehci
[    2.882748] IRQ54 no longer affine to CPU4
[    2.883540] CPU4: shutdown
[    2.938286] GIC ID for CPU 1 cluster 0 is 1
[    2.961590] IRQ55 no longer affine to CPU5
[    2.962220] CPU5: shutdown
[    2.985752] usb 1-1.1: New USB device found, idVendor=0424, idProduct=ec00
[    2.991256] usb 1-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.007574] smsc95xx v1.0.4
[    3.017208] GIC ID for CPU 2 cluster 0 is 2
[    3.041483] IRQ56 no longer affine to CPU6
[    3.042150] CPU6: shutdown
[    3.076220] GIC ID for CPU 3 cluster 0 is 3
[    3.080472] smsc95xx 1-1.1:1.0 eth0: register 'smsc95xx' at usb-12110000.usb-1.1, smsc95xx USB 2.0 Ethernet, fe:33:58:6e:47:09
[    3.100765] mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot req 200000000Hz, actual 200000000HZ div = 0)
[    3.109573] IRQ57 no longer affine to CPU7
[    3.113428] CPU7: shutdown
[    3.117412] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
[    3.133034] mmc_host mmc0: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    3.144907] mmc_host mmc0: Bus speed (slot 0) = 400000000Hz (slot req 200000000Hz, actual 200000000HZ div = 1)
[    3.154878] mmc0: new HS400 MMC card at address 0001
[    3.160946] big.LITTLE switcher initialized
[    3.168316] mmcblk0: mmc0:0001 SDW16G 14.7 GiB
[    3.170772] exynos-hdmi 14530000.hdmi: GPIO lookup for consumer hpd
[    3.170782] exynos-hdmi 14530000.hdmi: using device tree for GPIO lookup
[    3.170800] of_get_named_gpiod_flags: can't parse 'hpd-gpios' property of node '/hdmi at 14530000[0]'
[    3.170863] of_get_named_gpiod_flags: parsed 'hpd-gpio' property of node '/hdmi at 14530000[0]' - status (0)
[    3.172447] mmcblk0boot0: mmc0:0001 SDW16G partition 1 4.00 MiB
[    3.178346] mmcblk0boot1: mmc0:0001 SDW16G partition 2 4.00 MiB
[    3.184099] mmcblk0rpmb: mmc0:0001 SDW16G partition 3 4.00 MiB
[    3.186663] [drm] Exynos DRM: using 14450000.mixer device for DMA mapping operations
[    3.188553] exynos-drm exynos-drm: bound 14450000.mixer (ops mixer_component_ops)
[    3.190091] exynos-drm exynos-drm: bound 14530000.hdmi (ops hdmi_component_ops)
[    3.190105] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.190111] [drm] No driver support for vblank timestamp query.
[    3.190248] [drm] Initialized exynos 1.0.0 20110530 on minor 0
[    3.191776] exynos-dwc3 usb3-0: no suspend clk specified
[    3.199016] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[    3.199378] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned bus number 3
[    3.200671] xhci-hcd xhci-hcd.2.auto: hcc params 0x0220f04c hci version 0x100 quirks 0x00010010
[    3.200936] xhci-hcd xhci-hcd.2.auto: irq 138, io mem 0x12000000
[    3.201887] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    3.201898] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.201908] usb usb3: Product: xHCI Host Controller
[    3.201918] usb usb3: Manufacturer: Linux 4.7.0-rc4-00069-gf2df679b6c55 xhci-hcd
[    3.201927] usb usb3: SerialNumber: xhci-hcd.2.auto
[    3.206173] hub 3-0:1.0: USB hub found
[    3.206716] hub 3-0:1.0: 1 port detected
[    3.209969] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[    3.210045] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned bus number 4
[    3.210347] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.210837] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    3.210849] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.210858] usb usb4: Product: xHCI Host Controller
[    3.210868] usb usb4: Manufacturer: Linux 4.7.0-rc4-00069-gf2df679b6c55 xhci-hcd
[    3.210877] usb usb4: SerialNumber: xhci-hcd.2.auto
[    3.214283] hub 4-0:1.0: USB hub found
[    3.214418] hub 4-0:1.0: 1 port detected
[    3.217922] exynos-dwc3 usb3-1: no suspend clk specified
[    3.229322] using random self ethernet address
[    3.229340] using random host ethernet address
[    3.233726] usb0: HOST MAC b6:f5:d2:44:e7:76
[    3.235110] usb0: MAC 9e:2f:17:8a:43:df
[    3.235246] using random self ethernet address
[    3.235262] using random host ethernet address
[    3.236108] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[    3.236116] g_ether gadget: g_ether ready
[    3.257045] s3c-rtc 101e0000.rtc: rtc core: registered s3c as rtc1
[    3.258713] of_get_named_gpiod_flags: can't parse 'simple-audio-card,hp-det-gpio' property of node '/sound[0]'
[    3.258727] of_get_named_gpiod_flags: can't parse 'simple-audio-card,mic-det-gpio' property of node '/sound[0]'
[    3.280412] max98090 5-0010: MAX98090 REVID=0x43
[    3.282260] max98090 5-0010: use default 2.8v micbias
[    3.291742] asoc-simple-card sound: HiFi <-> 3830000.i2s mapping ok
[    3.337249] s5m-rtc s2mps14-rtc: setting system clock to 2016-07-04 10:52:41 UTC (1467629561)
[    3.440090]  mmcblk0: p1
[    3.447670] ALSA device list:
[    3.449206]   #0: Odroid-XU3
[    3.459340] EXT4-fs (mmcblk0p1): couldn't mount as ext3 due to feature incompatibilities
[    3.483912] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)
[    3.491056] VFS: Mounted root (ext4 filesystem) on device 179:1.
[    3.500229] devtmpfs: mounted
[    3.504574] Freeing unused kernel memory: 1024K (c0b00000 - c0c00000)
[    3.722041] random: systemd urandom read with 115 bits of entropy available
[    3.744470] systemd[1]: systemd 229 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    3.765300] systemd[1]: Detected architecture arm.
[    3.786661] systemd[1]: Set hostname to <odroidxu3>.
[    4.152760] random: nonblocking pool is initialized
[    4.247613] systemd[1]: Listening on Network Service Netlink Socket.
[    4.271452] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    4.307848] systemd[1]: Listening on Process Core Dump Socket.
[    4.326101] systemd[1]: Listening on Journal Socket.
[    4.345114] systemd[1]: Reached target Encrypted Volumes.
[    4.361050] systemd[1]: Created slice System Slice.
[    4.380882] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    4.420804] systemd[1]: Mounting Debug File System...
[    4.436687] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    4.460960] systemd[1]: Listening on udev Control Socket.
[    4.480569] systemd[1]: Listening on LVM2 metadata daemon socket.
[    4.520451] systemd[1]: Mounting Configuration File System...
[    4.550375] systemd[1]: Starting Setup Virtual Console...
[    4.570796] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    4.591600] systemd[1]: Created slice system-getty.slice.
[    4.610127] systemd[1]: Reached target Remote File Systems.
[    4.625412] systemd[1]: Listening on udev Kernel Socket.
[    4.645505] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.680780] systemd[1]: Starting Remount Root and Kernel File Systems...
[    4.706480] systemd[1]: Mounting Temporary Directory...
[    4.749518] systemd[1]: Starting Journal Service...
[    4.770531] systemd[1]: Starting Apply Kernel Variables...
[    4.790522] systemd[1]: Reached target Swap.
[    4.811164] systemd[1]: Created slice User and Session Slice.
[    4.835342] systemd[1]: Reached target Slices.
[    4.853158] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    4.876740] systemd[1]: Reached target Paths.
[    4.906374] systemd[1]: Mounted Configuration File System.
[    4.925448] systemd[1]: Mounted Debug File System.
[    4.945648] systemd[1]: Mounted Temporary Directory.
[    4.976137] systemd[1]: Started Setup Virtual Console.
[    4.995473] EXT4-fs (mmcblk0p1): re-mounted. Opts: errors=remount-ro
[    5.000425] systemd[1]: Started Apply Kernel Variables.
[    5.023859] systemd[1]: Started Remount Root and Kernel File Systems.
[    5.235940] systemd[1]: Starting Create Static Device Nodes in /dev...
[    5.265742] systemd[1]: Starting udev Coldplug all Devices...
[    5.291167] systemd[1]: Starting Load/Save Random Seed...
[    5.317278] systemd[1]: Started Create Static Device Nodes in /dev.
[    5.339956] systemd[1]: Started Load/Save Random Seed.
[    5.411117] systemd[1]: Starting udev Kernel Device Manager...
[    5.430376] systemd[1]: Reached target Local File Systems (Pre).
[    5.450636] systemd[1]: Reached target Local File Systems.
[    5.492682] systemd[1]: Started udev Kernel Device Manager.
[    5.619526] systemd[1]: Started Journal Service.
[    5.742353] systemd-journald[168]: Received request to flush runtime journal from PID 1
[   12.113229] smsc95xx 1-1.1:1.0 eth0: hardware isn't capable of remote wakeup
[   13.647862] smsc95xx 1-1.1:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
[   37.887457] usb 3-1: new high-speed USB device number 2 using xhci-hcd
[   38.019603] usb 3-1: New USB device found, idVendor=05e3, idProduct=0743
[   38.024916] usb 3-1: New USB device strings: Mfr=3, Product=4, SerialNumber=5
[   38.032022] usb 3-1: Product: USB Storage
[   38.035943] usb 3-1: Manufacturer: Generic
[   38.040063] usb 3-1: SerialNumber: 000000000821
[   38.051067] usb-storage 3-1:1.0: USB Mass Storage device detected
[   38.066129] scsi host0: usb-storage 3-1:1.0
[   38.896168] usb 3-1: USB disconnect, device number 2

-------------- next part --------------
[root at odroidxu3 ~]# dmesg
[    0.000000] Booting Linux on physical CPU 0x100
[    0.000000] Linux version 4.7.0-rc4-00139-g215db9481814 (k.kozlowski at AMDC2174) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) ) #925 SMP PREEMPT Mon Jul 4 12:45:41 CEST 2016
[    0.000000] CPU: ARMv7 Processor [410fc073] revision 3 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: Hardkernel Odroid XU3
[    0.000000] cma: Reserved 64 MiB at 0xba800000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Samsung CPU ID: 0xe5422001
[    0.000000] On node 0 totalpages: 514560
[    0.000000] free_area_init_node: node 0, pgdat c0c4c4c0, node_mem_map ef020000
[    0.000000]   Normal zone: 1536 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 192512 pages, LIFO batch:31
[    0.000000]   HighMem zone: 322048 pages, LIFO batch:31
[    0.000000] Running under secure firmware.
[    0.000000] percpu: Embedded 13 pages/cpu @eef62000 s24000 r8192 d21056 u53248
[    0.000000] pcpu-alloc: s24000 r8192 d21056 u53248 alloc=13*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 513024
[    0.000000] Kernel command line: console=tty1 console=ttySAC2,115200n8 root=PARTUUID=836e953a-01 rootwait rw no_console_suspend smsc95xx.macaddr=00:1e:06:61:7a:93
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1955248K/2058240K available (7382K kernel code, 369K rwdata, 2480K rodata, 1024K init, 8079K bss, 37456K reserved, 65536K cma-reserved, 1222656K highmem)
[    0.000000] Virtual kernel memory layout:
                   vector  : 0xffff0000 - 0xffff1000   (   4 kB)
                   fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
                   vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
                   lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
                   pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
                   modules : 0xbf000000 - 0xbfe00000   (  14 MB)
                     .text : 0xc0008000 - 0xc0aa197c   (10855 kB)
                     .init : 0xc0b00000 - 0xc0c00000   (1024 kB)
                     .data : 0xc0c00000 - 0xc0c5c580   ( 370 kB)
                      .bss : 0xc0c5e000 - 0xc1441d74   (8080 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  RCU lockdep checking is enabled.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] GIC physical location is 0x10481000
[    0.000000] Switching to timer-based delay loop, resolution 41ns
[    0.000000] clocksource: mct-frc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.000008] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
[    0.001598] Console: colour dummy device 80x30
[    0.004494] console [tty1] enabled
[    0.004535] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.004599] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.004638] ... MAX_LOCK_DEPTH:          48
[    0.004678] ... MAX_LOCKDEP_KEYS:        8191
[    0.004717] ... CLASSHASH_SIZE:          4096
[    0.004757] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.004796] ... MAX_LOCKDEP_CHAINS:      65536
[    0.004836] ... CHAINHASH_SIZE:          32768
[    0.004876]  memory used by lock dependency info: 5167 kB
[    0.004984]  per task-struct memory footprint: 1536 bytes
[    0.005083] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=120000)
[    0.005170] pid_max: default: 32768 minimum: 301
[    0.005639] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.005699] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.009130] CPU: Testing write buffer coherency: ok
[    0.011831] CPU0: update cpu_capacity 448
[    0.011891] CPU0: thread -1, cpu 0, socket 1, mpidr 80000100
[    0.012147] Setting up static identity map for 0x40100000 - 0x40100058
[    0.013056] ARM CCI driver probed
[    0.013363] Exynos MCPM support installed
[    0.065482] CPU1: update cpu_capacity 448
[    0.065493] CPU1: thread -1, cpu 1, socket 1, mpidr 80000101
[    0.085395] CPU2: update cpu_capacity 448
[    0.085405] CPU2: thread -1, cpu 2, socket 1, mpidr 80000102
[    0.105390] CPU3: update cpu_capacity 448
[    0.105399] CPU3: thread -1, cpu 3, socket 1, mpidr 80000103
[    0.125397] CPU4: update cpu_capacity 1535
[    0.125406] CPU4: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.145372] CPU5: update cpu_capacity 1535
[    0.145379] CPU5: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.165372] CPU6: update cpu_capacity 1535
[    0.165381] CPU6: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.185373] CPU7: update cpu_capacity 1535
[    0.185382] CPU7: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.185692] Brought up 8 CPUs
[    0.186287] SMP: Total of 8 processors activated (384.00 BogoMIPS).
[    0.186342] CPU: WARNING: CPU(s) started in wrong/inconsistent modes (primary CPU mode 0x1a)
[    0.186416] CPU: This may indicate a broken bootloader or firmware.
[    0.190693] devtmpfs: initialized
[    0.278039] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 3
[    0.281023] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 9556302231375000 ns
[    0.284916] pinctrl core: initialized pinctrl subsystem
[    0.290570] NET: Registered protocol family 16
[    0.294815] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.310152] cpuidle: using governor menu
[    0.326646] exynos-audss-clk 3810000.audss-clock-controller: setup completed
[    0.337765] gpio gpiochip0: (gpy7): added GPIO chardev (254:0)
[    0.339469] gpiochip_setup_dev: registered GPIOs 0 to 7 on device: gpiochip0 (gpy7)
[    0.339547] gpio gpiochip1: (gpx0): added GPIO chardev (254:1)
[    0.340666] gpiochip_setup_dev: registered GPIOs 8 to 15 on device: gpiochip1 (gpx0)
[    0.340733] gpio gpiochip2: (gpx1): added GPIO chardev (254:2)
[    0.341781] gpiochip_setup_dev: registered GPIOs 16 to 23 on device: gpiochip2 (gpx1)
[    0.341847] gpio gpiochip3: (gpx2): added GPIO chardev (254:3)
[    0.342888] gpiochip_setup_dev: registered GPIOs 24 to 31 on device: gpiochip3 (gpx2)
[    0.342953] gpio gpiochip4: (gpx3): added GPIO chardev (254:4)
[    0.343955] gpiochip_setup_dev: registered GPIOs 32 to 39 on device: gpiochip4 (gpx3)
[    0.347279] gpio gpiochip5: (gpc0): added GPIO chardev (254:5)
[    0.348352] gpiochip_setup_dev: registered GPIOs 40 to 47 on device: gpiochip5 (gpc0)
[    0.348419] gpio gpiochip6: (gpc1): added GPIO chardev (254:6)
[    0.349427] gpiochip_setup_dev: registered GPIOs 48 to 55 on device: gpiochip6 (gpc1)
[    0.349490] gpio gpiochip7: (gpc2): added GPIO chardev (254:7)
[    0.350500] gpiochip_setup_dev: registered GPIOs 56 to 62 on device: gpiochip7 (gpc2)
[    0.350564] gpio gpiochip8: (gpc3): added GPIO chardev (254:8)
[    0.351567] gpiochip_setup_dev: registered GPIOs 63 to 66 on device: gpiochip8 (gpc3)
[    0.351631] gpio gpiochip9: (gpc4): added GPIO chardev (254:9)
[    0.352640] gpiochip_setup_dev: registered GPIOs 67 to 68 on device: gpiochip9 (gpc4)
[    0.352704] gpio gpiochip10: (gpd1): added GPIO chardev (254:10)
[    0.353695] gpiochip_setup_dev: registered GPIOs 69 to 76 on device: gpiochip10 (gpd1)
[    0.353759] gpio gpiochip11: (gpy0): added GPIO chardev (254:11)
[    0.354766] gpiochip_setup_dev: registered GPIOs 77 to 82 on device: gpiochip11 (gpy0)
[    0.354829] gpio gpiochip12: (gpy1): added GPIO chardev (254:12)
[    0.355952] gpiochip_setup_dev: registered GPIOs 83 to 86 on device: gpiochip12 (gpy1)
[    0.356017] gpio gpiochip13: (gpy2): added GPIO chardev (254:13)
[    0.357022] gpiochip_setup_dev: registered GPIOs 87 to 92 on device: gpiochip13 (gpy2)
[    0.357087] gpio gpiochip14: (gpy3): added GPIO chardev (254:14)
[    0.358092] gpiochip_setup_dev: registered GPIOs 93 to 100 on device: gpiochip14 (gpy3)
[    0.358157] gpio gpiochip15: (gpy4): added GPIO chardev (254:15)
[    0.359172] gpiochip_setup_dev: registered GPIOs 101 to 108 on device: gpiochip15 (gpy4)
[    0.359245] gpio gpiochip16: (gpy5): added GPIO chardev (254:16)
[    0.360302] gpiochip_setup_dev: registered GPIOs 109 to 116 on device: gpiochip16 (gpy5)
[    0.360367] gpio gpiochip17: (gpy6): added GPIO chardev (254:17)
[    0.361383] gpiochip_setup_dev: registered GPIOs 117 to 124 on device: gpiochip17 (gpy6)
[    0.363921] gpio gpiochip18: (gpe0): added GPIO chardev (254:18)
[    0.365037] gpiochip_setup_dev: registered GPIOs 125 to 132 on device: gpiochip18 (gpe0)
[    0.365103] gpio gpiochip19: (gpe1): added GPIO chardev (254:19)
[    0.366131] gpiochip_setup_dev: registered GPIOs 133 to 134 on device: gpiochip19 (gpe1)
[    0.366196] gpio gpiochip20: (gpf0): added GPIO chardev (254:20)
[    0.367216] gpiochip_setup_dev: registered GPIOs 135 to 140 on device: gpiochip20 (gpf0)
[    0.367280] gpio gpiochip21: (gpf1): added GPIO chardev (254:21)
[    0.368310] gpiochip_setup_dev: registered GPIOs 141 to 148 on device: gpiochip21 (gpf1)
[    0.368374] gpio gpiochip22: (gpg0): added GPIO chardev (254:22)
[    0.369398] gpiochip_setup_dev: registered GPIOs 149 to 156 on device: gpiochip22 (gpg0)
[    0.369463] gpio gpiochip23: (gpg1): added GPIO chardev (254:23)
[    0.370526] gpiochip_setup_dev: registered GPIOs 157 to 164 on device: gpiochip23 (gpg1)
[    0.370593] gpio gpiochip24: (gpg2): added GPIO chardev (254:24)
[    0.371617] gpiochip_setup_dev: registered GPIOs 165 to 166 on device: gpiochip24 (gpg2)
[    0.371682] gpio gpiochip25: (gpj4): added GPIO chardev (254:25)
[    0.372797] gpiochip_setup_dev: registered GPIOs 167 to 170 on device: gpiochip25 (gpj4)
[    0.374900] gpio gpiochip26: (gpa0): added GPIO chardev (254:26)
[    0.376075] gpiochip_setup_dev: registered GPIOs 171 to 178 on device: gpiochip26 (gpa0)
[    0.376142] gpio gpiochip27: (gpa1): added GPIO chardev (254:27)
[    0.377179] gpiochip_setup_dev: registered GPIOs 179 to 184 on device: gpiochip27 (gpa1)
[    0.377244] gpio gpiochip28: (gpa2): added GPIO chardev (254:28)
[    0.378267] gpiochip_setup_dev: registered GPIOs 185 to 192 on device: gpiochip28 (gpa2)
[    0.378331] gpio gpiochip29: (gpb0): added GPIO chardev (254:29)
[    0.379366] gpiochip_setup_dev: registered GPIOs 193 to 197 on device: gpiochip29 (gpb0)
[    0.379439] gpio gpiochip30: (gpb1): added GPIO chardev (254:30)
[    0.380481] gpiochip_setup_dev: registered GPIOs 198 to 202 on device: gpiochip30 (gpb1)
[    0.380545] gpio gpiochip31: (gpb2): added GPIO chardev (254:31)
[    0.381550] gpiochip_setup_dev: registered GPIOs 203 to 206 on device: gpiochip31 (gpb2)
[    0.381630] gpio gpiochip32: (gpb3): added GPIO chardev (254:32)
[    0.382639] gpiochip_setup_dev: registered GPIOs 207 to 214 on device: gpiochip32 (gpb3)
[    0.382704] gpio gpiochip33: (gpb4): added GPIO chardev (254:33)
[    0.383707] gpiochip_setup_dev: registered GPIOs 215 to 216 on device: gpiochip33 (gpb4)
[    0.383771] gpio gpiochip34: (gph0): added GPIO chardev (254:34)
[    0.384760] gpiochip_setup_dev: registered GPIOs 217 to 224 on device: gpiochip34 (gph0)
[    0.387146] gpio gpiochip35: (gpz): added GPIO chardev (254:35)
[    0.388197] gpiochip_setup_dev: registered GPIOs 225 to 231 on device: gpiochip35 (gpz)
[    0.403435] EXYNOS5420 PMU initialized
[    0.503812] SCSI subsystem initialized
[    0.505011] usbcore: registered new interface driver usbfs
[    0.505285] usbcore: registered new interface driver hub
[    0.505739] usbcore: registered new device driver usb
[    0.507919] s3c-i2c 12c60000.i2c: slave address 0x00
[    0.507989] s3c-i2c 12c60000.i2c: bus frequency set to 65 KHz
[    0.512759] s3c-i2c 12c60000.i2c: i2c-0: S3C I2C adapter
[    0.513255] s3c-i2c 12c80000.i2c: slave address 0x00
[    0.513318] s3c-i2c 12c80000.i2c: bus frequency set to 65 KHz
[    0.514759] s3c-i2c 12c80000.i2c: i2c-2: S3C I2C adapter
[    0.518159] Advanced Linux Sound Architecture Driver Initialized.
[    0.524852] clocksource: Switched to clocksource mct-frc
[    0.578489] NET: Registered protocol family 2
[    0.581553] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.581810] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.585028] TCP: Hash tables configured (established 8192 bind 8192)
[    0.585422] UDP hash table entries: 512 (order: 3, 40960 bytes)
[    0.585879] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
[    0.587310] NET: Registered protocol family 1
[    0.593873] RPC: Registered named UNIX socket transport module.
[    0.593941] RPC: Registered udp transport module.
[    0.593990] RPC: Registered tcp transport module.
[    0.594038] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.603689] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.611392] workingset: timestamp_bits=28 max_order=19 bucket_order=0
[    0.663572] NFS: Registering the id_resolver key type
[    0.664011] Key type id_resolver registered
[    0.664065] Key type id_legacy registered
[    0.664264] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    0.668830] bounce: pool size: 64 pages
[    0.669836] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.669989] io scheduler noop registered
[    0.670039] io scheduler deadline registered
[    0.670183] io scheduler cfq registered (default)
[    0.677166] 12130000.phy supply vbus not found, using dummy regulator
[    0.680855] 12100000.phy supply vbus not found, using dummy regulator
[    0.681142] 12100000.phy supply vbus-boost not found, using dummy regulator
[    0.682639] 12500000.phy supply vbus not found, using dummy regulator
[    0.682914] 12500000.phy supply vbus-boost not found, using dummy regulator
[    0.698162] dma-pl330 3880000.adma: Loaded driver for PL330 DMAC-241330
[    0.698243] dma-pl330 3880000.adma:  DBUFF-4x8bytes Num_Chans-6 Num_Peri-16 Num_Events-6
[    0.714084] dma-pl330 121a0000.pdma: Loaded driver for PL330 DMAC-241330
[    0.714161] dma-pl330 121a0000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    0.730180] dma-pl330 121b0000.pdma: Loaded driver for PL330 DMAC-241330
[    0.730257] dma-pl330 121b0000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    0.734622] dma-pl330 10800000.mdma: Loaded driver for PL330 DMAC-241330
[    0.734766] dma-pl330 10800000.mdma:         DBUFF-64x8bytes Num_Chans-8 Num_Peri-1 Num_Events-32
[    1.022568] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.031239] 12c00000.serial: ttySAC0 at MMIO 0x12c00000 (irq = 58, base_baud = 0) is a S3C6400/10
[    1.033286] 12c10000.serial: ttySAC1 at MMIO 0x12c10000 (irq = 59, base_baud = 0) is a S3C6400/10
[    1.035024] 12c20000.serial: ttySAC2 at MMIO 0x12c20000 (irq = 60, base_baud = 0) is a S3C6400/10
[    1.840695] console [ttySAC2] enabled
[    1.845591] 12c30000.serial: ttySAC3 at MMIO 0x12c30000 (irq = 61, base_baud = 0) is a S3C6400/10
[    1.857490] [drm] Initialized drm 1.1.0 20060810
[    1.867577] exynos-hdmi 14530000.hdmi: GPIO lookup for consumer hpd
[    1.867599] exynos-hdmi 14530000.hdmi: using device tree for GPIO lookup
[    1.867623] of_get_named_gpiod_flags: can't parse 'hpd-gpios' property of node '/hdmi at 14530000[0]'
[    1.867661] of_get_named_gpiod_flags: parsed 'hpd-gpio' property of node '/hdmi at 14530000[0]' - status (0)
[    1.868135] exynos-hdmi 14530000.hdmi: Failed to get supply 'vdd': -517
[    1.941032] brd: module loaded
[    1.982391] loop: module loaded
[    1.988402] usbcore: registered new interface driver r8152
[    1.992773] usbcore: registered new interface driver asix
[    1.998031] usbcore: registered new interface driver ax88179_178a
[    2.004095] usbcore: registered new interface driver cdc_ether
[    2.009980] usbcore: registered new interface driver smsc75xx
[    2.015693] usbcore: registered new interface driver smsc95xx
[    2.021339] usbcore: registered new interface driver net1080
[    2.026979] usbcore: registered new interface driver cdc_subset
[    2.032863] usbcore: registered new interface driver zaurus
[    2.038515] usbcore: registered new interface driver cdc_ncm
[    2.045275] exynos-dwc3 usb3-0: no suspend clk specified
[    2.049472] exynos-dwc3 usb3-1: no suspend clk specified
[    2.056758] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.061940] ehci-exynos: EHCI EXYNOS driver
[    2.066584] of_get_named_gpiod_flags: can't parse 'samsung,vbus-gpio' property of node '/usb at 12110000[0]'
[    2.067308] exynos-ehci 12110000.usb: EHCI Host Controller
[    2.072125] exynos-ehci 12110000.usb: new USB bus registered, assigned bus number 1
[    2.080054] exynos-ehci 12110000.usb: irq 114, io mem 0x12110000
[    2.094880] exynos-ehci 12110000.usb: USB 2.0 started, EHCI 1.00
[    2.100831] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.106266] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.113457] usb usb1: Product: EHCI Host Controller
[    2.118289] usb usb1: Manufacturer: Linux 4.7.0-rc4-00139-g215db9481814 ehci_hcd
[    2.125674] usb usb1: SerialNumber: 12110000.usb
[    2.134998] hub 1-0:1.0: USB hub found
[    2.137544] hub 1-0:1.0: 3 ports detected
[    2.147057] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.151904] ohci-exynos: OHCI EXYNOS driver
[    2.156856] exynos-ohci 12120000.usb: USB Host Controller
[    2.161492] exynos-ohci 12120000.usb: new USB bus registered, assigned bus number 2
[    2.169393] exynos-ohci 12120000.usb: irq 114, io mem 0x12120000
[    2.234494] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    2.239902] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.248132] usb usb2: Product: USB Host Controller
[    2.251853] usb usb2: Manufacturer: Linux 4.7.0-rc4-00139-g215db9481814 ohci_hcd
[    2.259225] usb usb2: SerialNumber: 12120000.usb
[    2.266534] hub 2-0:1.0: USB hub found
[    2.268940] hub 2-0:1.0: 3 ports detected
[    2.277660] usbcore: registered new interface driver usb-storage
[    2.284179] udc-core: couldn't find an available UDC - added [g_ether] to list of pending drivers
[    2.293347] mousedev: PS/2 mouse device common for all mice
[    2.303507] i2c /dev entries driver
[    2.336918] vdd_ldo9: Bringing 3300000uV into 3000000-3000000uV
[    2.355900] vddq_mmc2: Bringing 3300000uV into 2800000-2800000uV
[    2.367096] vdd_ldo15: Bringing 3300000uV into 3100000-3100000uV
[    2.385566] vdd_sd: Bringing 3300000uV into 2800000-2800000uV
[    2.454858] usb 1-1: new high-speed USB device number 2 using exynos-ehci
[    2.482038] s5m-rtc s2mps14-rtc: rtc core: registered s5m-rtc as rtc0
[    2.501851] ina2xx 0-0040: power monitor ina231 (Rshunt = 10000 uOhm)
[    2.509452] ina2xx 0-0041: power monitor ina231 (Rshunt = 10000 uOhm)
[    2.517622] ina2xx 0-0044: power monitor ina231 (Rshunt = 10000 uOhm)
[    2.525192] ina2xx 0-0045: power monitor ina231 (Rshunt = 10000 uOhm)
[    2.537319] exynos-tmu 10060000.tmu: More trip points than supported by this TMU.
[    2.543462] exynos-tmu 10060000.tmu: 2 trip points should be configured in polling mode.
[    2.563034] s3c2410-wdt 101d0000.watchdog: watchdog inactive, reset disabled, irq disabled
[    2.573462] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel at redhat.com
[    2.583721] pwrseq_emmc pwrseq: GPIO lookup for consumer reset
[    2.583742] pwrseq_emmc pwrseq: using device tree for GPIO lookup
[    2.583783] of_get_named_gpiod_flags: parsed 'reset-gpios' property of node '/pwrseq[0]' - status (0)
[    2.584242] sdhci: Secure Digital Host Controller Interface driver
[    2.589057] sdhci: Copyright(c) Pierre Ossman
[    2.594167] Synopsys Designware Multimedia Card Interface Driver
[    2.600344] usb 1-1: New USB device found, idVendor=0424, idProduct=9514
[    2.606030] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.614956] dwmmc_exynos 12200000.mmc: IDMAC supports 32-bit address mode.
[    2.615141] dwmmc_exynos 12200000.mmc: Using internal DMA controller.
[    2.615157] dwmmc_exynos 12200000.mmc: Version ID is 250a
[    2.615333] dwmmc_exynos 12200000.mmc: DW MMC controller at irq 65,64 bit host data width,64 deep fifo
[    2.616394] dwmmc_exynos 12200000.mmc: GPIO lookup for consumer cd
[    2.616403] dwmmc_exynos 12200000.mmc: using device tree for GPIO lookup
[    2.616432] of_get_named_gpiod_flags: parsed 'cd-gpios' property of node '/mmc at 12200000[0]' - status (0)
[    2.616478] dwmmc_exynos 12200000.mmc: Got CD GPIO
[    2.616491] dwmmc_exynos 12200000.mmc: GPIO lookup for consumer wp
[    2.616499] dwmmc_exynos 12200000.mmc: using device tree for GPIO lookup
[    2.616511] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/mmc at 12200000[0]'
[    2.616523] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/mmc at 12200000[0]'
[    2.616532] dwmmc_exynos 12200000.mmc: using lookup tables for GPIO lookup
[    2.616649] dwmmc_exynos 12200000.mmc: lookup for GPIO wp failed
[    2.616780] dwmmc_exynos 12200000.mmc: allocated mmc-pwrseq
[    2.655868] dwmmc_exynos 12200000.mmc: 1 slots initialized
[    2.658540] hub 1-1:1.0: USB hub found
[    2.658754] hub 1-1:1.0: 5 ports detected
[    2.668700] dwmmc_exynos 12220000.mmc: IDMAC supports 32-bit address mode.
[    2.674884] dwmmc_exynos 12220000.mmc: Using internal DMA controller.
[    2.681062] dwmmc_exynos 12220000.mmc: Version ID is 250a
[    2.686576] dwmmc_exynos 12220000.mmc: DW MMC controller at irq 66,64 bit host data width,64 deep fifo
[    2.696572] dwmmc_exynos 12220000.mmc: GPIO lookup for consumer cd
[    2.696592] dwmmc_exynos 12220000.mmc: using device tree for GPIO lookup
[    2.696615] of_get_named_gpiod_flags: can't parse 'cd-gpios' property of node '/mmc at 12220000[0]'
[    2.696635] of_get_named_gpiod_flags: can't parse 'cd-gpio' property of node '/mmc at 12220000[0]'
[    2.696652] dwmmc_exynos 12220000.mmc: using lookup tables for GPIO lookup
[    2.696675] dwmmc_exynos 12220000.mmc: lookup for GPIO cd failed
[    2.696699] dwmmc_exynos 12220000.mmc: GPIO lookup for consumer wp
[    2.696715] dwmmc_exynos 12220000.mmc: using device tree for GPIO lookup
[    2.696735] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/mmc at 12220000[0]'
[    2.696754] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/mmc at 12220000[0]'
[    2.696770] dwmmc_exynos 12220000.mmc: using lookup tables for GPIO lookup
[    2.696791] dwmmc_exynos 12220000.mmc: lookup for GPIO wp failed
[    2.725508] dwmmc_exynos 12220000.mmc: 1 slots initialized
[    2.732925] of_get_named_gpiod_flags: parsed 'gpios' property of node '/gpioleds/redled[0]' - status (0)
[    2.739824] s5p-secss 10830000.sss: s5p-sss driver registered
[    2.746825] usbcore: registered new interface driver usbhid
[    2.751014] usbhid: USB HID core driver
[    2.779044] NET: Registered protocol family 10
[    2.785746] sit: IPv6 over IPv4 tunneling driver
[    2.792242] NET: Registered protocol family 17
[    2.795382] NET: Registered protocol family 15
[    2.800165] Key type dns_resolver registered
[    2.805561] Registering SWP/SWPB emulation handler
[    2.809080] big.LITTLE switcher initializing
[    2.813216] CPU0 paired with CPU7
[    2.816483] CPU1 paired with CPU6
[    2.819773] CPU2 paired with CPU5
[    2.823030] CPU3 paired with CPU4
[    2.826360] GIC ID for CPU 0 cluster 1 is 4
[    2.830523] GIC ID for CPU 1 cluster 1 is 5
[    2.834646] GIC ID for CPU 2 cluster 1 is 6
[    2.838840] GIC ID for CPU 3 cluster 1 is 7
[    2.843000] GIC ID for CPU 0 cluster 0 is 0
[    2.867557] IRQ54 no longer affine to CPU4
[    2.868479] CPU4: shutdown
[    2.917998] GIC ID for CPU 1 cluster 0 is 1
[    2.941528] IRQ55 no longer affine to CPU5
[    2.942159] CPU5: shutdown
[    2.944808] usb 1-1.1: new high-speed USB device number 3 using exynos-ehci
[    2.986285] GIC ID for CPU 2 cluster 0 is 2
[    3.001486] IRQ56 no longer affine to CPU6
[    3.002154] CPU6: shutdown
[    3.034207] GIC ID for CPU 3 cluster 0 is 3
[    3.046802] mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot req 200000000Hz, actual 200000000HZ div = 0)
[    3.055513] usb 1-1.1: New USB device found, idVendor=0424, idProduct=ec00
[    3.062413] IRQ57 no longer affine to CPU7
[    3.063133] CPU7: shutdown
[    3.063506] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
[    3.065008] mmc_host mmc0: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    3.065045] mmc_host mmc0: Bus speed (slot 0) = 400000000Hz (slot req 200000000Hz, actual 200000000HZ div = 1)
[    3.065598] mmc0: new HS400 MMC card at address 0001
[    3.069955] mmcblk0: mmc0:0001 SDW16G 14.7 GiB
[    3.070900] mmcblk0boot0: mmc0:0001 SDW16G partition 1 4.00 MiB
[    3.076978] mmcblk0boot1: mmc0:0001 SDW16G partition 2 4.00 MiB
[    3.077902] mmcblk0rpmb: mmc0:0001 SDW16G partition 3 4.00 MiB
[    3.082635]  mmcblk0: p1
[    3.127969] usb 1-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.140402] smsc95xx v1.0.4
[    3.164074] big.LITTLE switcher initialized
[    3.173410] exynos-hdmi 14530000.hdmi: GPIO lookup for consumer hpd
[    3.173437] exynos-hdmi 14530000.hdmi: using device tree for GPIO lookup
[    3.173461] of_get_named_gpiod_flags: can't parse 'hpd-gpios' property of node '/hdmi at 14530000[0]'
[    3.173530] of_get_named_gpiod_flags: parsed 'hpd-gpio' property of node '/hdmi at 14530000[0]' - status (0)
[    3.188329] [drm] Exynos DRM: using 14450000.mixer device for DMA mapping operations
[    3.196944] exynos-drm exynos-drm: bound 14450000.mixer (ops mixer_component_ops)
[    3.204650] exynos-drm exynos-drm: bound 14530000.hdmi (ops hdmi_component_ops)
[    3.210628] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.217178] [drm] No driver support for vblank timestamp query.
[    3.223188] [drm] Initialized exynos 1.0.0 20110530 on minor 0
[    3.230894] exynos-dwc3 usb3-0: no suspend clk specified
[    3.242530] smsc95xx 1-1.1:1.0 eth0: register 'smsc95xx' at usb-12110000.usb-1.1, smsc95xx USB 2.0 Ethernet, ae:fd:d3:4f:f8:46
[    3.245570] exynos-dwc3 usb3-1: no suspend clk specified
[    3.256936] using random self ethernet address
[    3.256954] using random host ethernet address
[    3.261312] usb0: HOST MAC 06:b2:36:88:d0:c4
[    3.263167] usb0: MAC fe:41:a2:95:1e:f9
[    3.263238] using random self ethernet address
[    3.263254] using random host ethernet address
[    3.264104] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[    3.264113] g_ether gadget: g_ether ready
[    3.280570] s3c-rtc 101e0000.rtc: rtc core: registered s3c as rtc1
[    3.282222] of_get_named_gpiod_flags: can't parse 'simple-audio-card,hp-det-gpio' property of node '/sound[0]'
[    3.282236] of_get_named_gpiod_flags: can't parse 'simple-audio-card,mic-det-gpio' property of node '/sound[0]'
[    3.305431] max98090 5-0010: MAX98090 REVID=0x43
[    3.311033] max98090 5-0010: use default 2.8v micbias
[    3.323865] asoc-simple-card sound: HiFi <-> 3830000.i2s mapping ok
[    3.346077] s5m-rtc s2mps14-rtc: setting system clock to 2016-07-04 10:50:35 UTC (1467629435)
[    3.463824] ALSA device list:
[    3.465446]   #0: Odroid-XU3
[    3.475969] EXT4-fs (mmcblk0p1): couldn't mount as ext3 due to feature incompatibilities
[    3.508523] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)
[    3.515405] VFS: Mounted root (ext4 filesystem) on device 179:1.
[    3.524630] devtmpfs: mounted
[    3.529084] Freeing unused kernel memory: 1024K (c0b00000 - c0c00000)
[    3.744479] random: systemd urandom read with 89 bits of entropy available
[    3.767110] systemd[1]: systemd 229 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    3.787929] systemd[1]: Detected architecture arm.
[    3.807152] systemd[1]: Set hostname to <odroidxu3>.
[    4.253911] systemd[1]: Listening on udev Kernel Socket.
[    4.302686] systemd[1]: Listening on Process Core Dump Socket.
[    4.320519] systemd[1]: Reached target Remote File Systems.
[    4.340983] systemd[1]: Created slice User and Session Slice.
[    4.361663] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    4.385684] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.406396] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    4.425537] systemd[1]: Listening on LVM2 metadata daemon socket.
[    4.445592] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    4.465555] systemd[1]: Listening on udev Control Socket.
[    4.485112] systemd[1]: Reached target Encrypted Volumes.
[    4.500587] systemd[1]: Listening on Journal Socket.
[    4.515735] systemd[1]: Listening on Network Service Netlink Socket.
[    4.535087] systemd[1]: Reached target Swap.
[    4.550713] systemd[1]: Created slice System Slice.
[    4.590679] systemd[1]: Mounting Temporary Directory...
[    4.610310] systemd[1]: Reached target Slices.
[    4.630327] systemd[1]: Starting Setup Virtual Console...
[    4.650550] systemd[1]: Starting Journal Service...
[    4.671430] systemd[1]: Starting Remount Root and Kernel File Systems...
[    4.698731] systemd[1]: Starting Apply Kernel Variables...
[    4.716161] systemd[1]: Mounting Debug File System...
[    4.740550] systemd[1]: Mounting Configuration File System...
[    4.762649] systemd[1]: Created slice system-getty.slice.
[    4.776874] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    4.801345] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    4.825283] systemd[1]: Reached target Paths.
[    4.854673] systemd[1]: Mounted Configuration File System.
[    4.866869] systemd[1]: Mounted Debug File System.
[    4.885384] systemd[1]: Mounted Temporary Directory.
[    4.914210] systemd[1]: Started Setup Virtual Console.
[    4.924236] random: nonblocking pool is initialized
[    4.939586] systemd[1]: Started Apply Kernel Variables.
[    4.970589] EXT4-fs (mmcblk0p1): re-mounted. Opts: errors=remount-ro
[    5.000137] systemd[1]: Started Remount Root and Kernel File Systems.
[    5.185976] systemd[1]: Starting udev Coldplug all Devices...
[    5.211857] systemd[1]: Starting Create Static Device Nodes in /dev...
[    5.236286] systemd[1]: Starting Load/Save Random Seed...
[    5.292125] systemd[1]: Started Load/Save Random Seed.
[    5.307645] systemd[1]: Started Create Static Device Nodes in /dev.
[    5.360063] systemd[1]: Reached target Local File Systems (Pre).
[    5.380587] systemd[1]: Reached target Local File Systems.
[    5.425947] systemd[1]: Starting udev Kernel Device Manager...
[    5.491839] systemd[1]: Started Journal Service.
[    5.599572] systemd-journald[159]: Received request to flush runtime journal from PID 1
[   11.933979] smsc95xx 1-1.1:1.0 eth0: hardware isn't capable of remote wakeup
[   13.637504] smsc95xx 1-1.1:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
