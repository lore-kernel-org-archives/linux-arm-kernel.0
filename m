From: kim.phillips@linaro.org (Kim Phillips)
Date: Wed, 4 Dec 2013 19:06:40 +0000
Subject: [PATCH][STABLE v3.10.x] clockevents: Prefer CPU local devices over
 global devices
In-Reply-To: <20131204170237.GB14367@kroah.com>
References: <20131204123650.313b1818f201842ad043eba5@linaro.org>
 <20131204170237.GB14367@kroah.com>
Message-ID: <20131204190640.706f98b371b43bf6b39bfd61@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 70e5975d3a04be5479a28eec4a2fb10f98ad2785 upstream.

From: Stephen Boyd <sboyd@codeaurora.org>

On an SMP system with only one global clockevent and a dummy
clockevent per CPU we run into problems. We want the dummy
clockevents to be registered as the per CPU tick devices, but
we can only achieve that if we register the dummy clockevents
before the global clockevent or if we artificially inflate the
rating of the dummy clockevents to be higher than the rating
of the global clockevent. Failure to do so leads to boot
hangs when the dummy timers are registered on all other CPUs
besides the CPU that accepted the global clockevent as its tick
device and there is no broadcast timer to poke the dummy
devices.

If we're registering multiple clockevents and one clockevent is
global and the other is local to a particular CPU we should
choose to use the local clockevent regardless of the rating of
the device. This way, if the clockevent is a dummy it will take
the tick device duty as long as there isn't a higher rated tick
device and any global clockevent will be bumped out into
broadcast mode, fixing the problem described above.

Reported-and-tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Tested-by: soren.brinkmann at xilinx.com
Cc: John Stultz <john.stultz@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: John Stultz <john.stultz@linaro.org>
Link: http://lkml.kernel.org/r/20130613183950.GA32061 at codeaurora.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org> # 3.10.x : 7172a28 clockevents: Get rid of the notifier chain
Cc: <stable@vger.kernel.org> # 3.10.x : ccf33d6 clockevents: Add module refcount
Cc: <stable@vger.kernel.org> # 3.10.x : 45cb8e0 clockevents: Split out selection logic
Cc: <stable@vger.kernel.org> # 3.10.x
---
v2 stable submission:
- removed a couple of prerequisites that really weren't needed.

- cc'd everyone originally involved in each commit.

- providing description of problem the patch fixes below (btw, if this
needs to be part of the commit text, it's not clear how to do it from
kernel_stable_rules.txt):

Fixes booting dual-cpu ARM vexpress under qemu:

BEFORE:

$ qemu-system-arm -machine type=vexpress-a15 -cpu cortex-a15 -m 2048 -nographic -append "root=/dev/vda rw mem=512M console=ttyAMA0 rootwait earlyprintk" -kernel $KERNELPATH/zImage -dtb $KERNELPATH/dts/vexpress-v2p-ca15-tc1.dtb -drive if=none,file=$HOME/arm-wheezy.img,id=foo -device virtio-blk-device,drive=foo -smp cpus=2 
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Linux version 3.10.21 (kim at ntel) (gcc version 4.8.1 (Ubuntu/Linaro 4.8.1-10ubuntu7) ) #8 SMP Wed Dec 4 17:44:36 GMT 2013
[    0.000000] CPU: ARMv7 Processor [412fc0f1] revision 1 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine: ARM-Versatile Express, model: V2P-CA15
[    0.000000] Truncating memory at 0x80000000 to fit in 32-bit physical address space
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] PERCPU: Embedded 9 pages/cpu @80d2d000 s13056 r8192 d15616 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
[    0.000000] Kernel command line: root=/dev/vda rw mem=512M console=ttyAMA0 rootwait earlyprintk
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 512MB = 512MB total
[    0.000000] Memory: 510280k/510280k available, 14008k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xa0800000 - 0xff000000   (1512 MB)
[    0.000000]     lowmem  : 0x80000000 - 0xa0000000   ( 512 MB)
[    0.000000]     modules : 0x7f000000 - 0x80000000   (  16 MB)
[    0.000000]       .text : 0x80008000 - 0x8080b67c   (8206 kB)
[    0.000000]       .init : 0x8080c000 - 0x80874300   ( 417 kB)
[    0.000000]       .data : 0x80876000 - 0x808ba520   ( 274 kB)
[    0.000000]        .bss : 0x808ba520 - 0x809246b4   ( 425 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 4294967ms
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
[    0.000000] Console: colour dummy device 80x30
[    0.004633] Calibrating delay loop... 626.68 BogoMIPS (lpj=3133440)
[    0.157977] pid_max: default: 32768 minimum: 301
[    0.159076] Security Framework initialized
[    0.160621] AppArmor: AppArmor initialized
[    0.161201] Mount-cache hash table entries: 512
[    0.175438] CPU: Testing write buffer coherency: ok
[    0.176469] ftrace: allocating 21674 entries in 64 pages
[    0.266098] /cpus/cpu at 0 missing clock-frequency property
[    0.266562] /cpus/cpu at 1 missing clock-frequency property
[    0.267122] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.268252] Setting up static identity map for 0x805f7518 - 0x805f7570
[    0.287951] CPU1: Booted secondary processor
[    0.577816] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.579540] Brought up 2 CPUs
[    0.580297] SMP: Total of 2 processors activated (1255.83 BogoMIPS).
[    0.580616] CPU: All CPU(s) started in SVC mode.
[    0.595499] devtmpfs: initialized
[    0.618026] xor: measuring software checksum speed
[    0.717873]    arm4regs  :   660.000 MB/sec
[    0.817870]    8regs     :   736.800 MB/sec
[    0.917715]    32regs    :   616.800 MB/sec
[    0.918066] xor: using function: 8regs (736.800 MB/sec)
[    0.952221] NET: Registered protocol family 16
[    0.960030] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    1.044957] hw-breakpoint: debug architecture 0x0 unsupported.
[    1.045369] Serial: AMBA PL011 UART driver
[    1.047157] 1c090000.uart: ttyAMA0 at MMIO 0x1c090000 (irq = 37) is a PL011 rev1
[    1.048784] console [ttyAMA0] enabled, bootconsole disabled
[    1.048784] console [ttyAMA0] enabled, bootconsole disabled
[    1.053226] 1c0a0000.uart: ttyAMA1 at MMIO 0x1c0a0000 (irq = 38) is a PL011 rev1
[    1.054785] 1c0b0000.uart: ttyAMA2 at MMIO 0x1c0b0000 (irq = 39) is a PL011 rev1
[    1.056458] 1c0c0000.uart: ttyAMA3 at MMIO 0x1c0c0000 (irq = 40) is a PL011 rev1
[    1.227703] bio: create slab <bio-0> at 0
[    1.447822] raid6: int32x1    361 MB/s
[    1.617707] raid6: int32x2    474 MB/s
[    1.787844] raid6: int32x4    187 MB/s
[    1.957680] raid6: int32x8    196 MB/s
[    1.957948] raid6: using algorithm int32x2 (474 MB/s)
[    1.958277] raid6: using intx1 recovery algorithm
[    2.019897] SCSI subsystem initialized
[    2.025019] usbcore: registered new interface driver usbfs
[    2.025968] usbcore: registered new interface driver hub
[    2.027025] usbcore: registered new device driver usb
[    2.033163] Advanced Linux Sound Architecture Driver Initialized.
[    2.041958] NetLabel: Initializing
[    2.042182] NetLabel:  domain hash size = 128
[    2.258427] NET: Registered protocol family 2
[    2.328398] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    2.328967] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    2.329532] TCP: Hash tables configured (established 4096 bind 4096)
[    2.330135] TCP: reno registered
[    2.330446] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    2.330886] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    2.348492] NET: Registered protocol family 1
[    2.378568] RPC: Registered named UNIX socket transport module.
[    2.378937] RPC: Registered udp transport module.
[    2.379182] RPC: Registered tcp transport module.
[    2.379440] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.388515] hw perfevents: enabled with ARMv7 Cortex-A15 PMU driver, 1 counters available
[    2.411959] audit: initializing netlink socket (disabled)
[    2.412823] type=2000 audit(2.340:1): initialized
[    2.488424] VFS: Disk quotas dquot_6.5.2
[    2.498556] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    2.888643] NFS: Registering the id_resolver key type
[    2.889628] Key type id_resolver registered
[    2.889890] Key type id_legacy registered
[    2.890430] jffs2: version 2.2. (NAND) (SUMMARY)  ? 2001-2006 Red Hat, Inc.
[    2.989644] 9p: Installing v9fs 9p2000 file system support
[    3.088408] bio: create slab <bio-1> at 1
[    3.169689] Btrfs loaded
[    3.170097] msgmni has been set to 996
[    3.182262] io scheduler noop registered (default)
[    3.184634] clcd-pl11x: probe of 1c1f0000.clcd failed with error -22
[    3.215506] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.253827] brd: module loaded
[    3.265943]  vda: unknown partition table
[    3.281767] mtdoops: mtd device (mtddev=name/number) must be supplied
[    3.283176] smsc911x: Driver version 2008-10-21
[    3.284056] smsc911x 1a000000.ethernet (unregistered net_device): couldn't get clock -2
[    3.294637] libphy: smsc911x-mdio: probed
[    3.295561] smsc911x 1a000000.ethernet eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=1a000000.etherne:01, irq=-1)
[    3.296997] smsc911x 1a000000.ethernet eth0: MAC Address: 52:54:00:12:34:56
[    3.330170] nxp-isp1760 1b000000.usb: NXP ISP1760 USB Host Controller
[    3.331868] nxp-isp1760 1b000000.usb: new USB bus registered, assigned bus number 1
[    3.332609] nxp-isp1760 1b000000.usb: Scratch test failed.
[    3.332937] nxp-isp1760 1b000000.usb: can't setup
[    3.333379] nxp-isp1760 1b000000.usb: USB bus 1 deregistered
[    3.338994] usbcore: registered new interface driver usb-storage
[    3.342937] mousedev: PS/2 mouse device common for all mice
[    3.347169] rtc-pl031 1c170000.rtc: rtc core: registered pl031 as rtc0
[    3.389520] device-mapper: ioctl: 4.24.0-ioctl (2013-01-15) initialised: dm-devel at redhat.com
[    3.390180] cpuidle: using governor ladder
[    3.390511] cpuidle: using governor menu
[    3.392685] mmci-pl18x 1c050000.mmci: mmc0: PL181 manf 41 rev0 at 0x1c050000 irq 41,42 (pio)
[    3.460189] input: AT Raw Set 2 keyboard as /devices/smb.14/motherboard.15/iofpga.16/1c060000.kmi/serio0/input/input0
[    5.076279] input: ImExPS/2 Generic Explorer Mouse as /devices/smb.14/motherboard.15/iofpga.16/1c070000.kmi/serio1/input/input1
[   23.078774] INFO: rcu_sched detected stalls on CPUs/tasks: { 1} (detected by 0, t=2102 jiffies, g=4294967000, c=4294966999, q=2970)
[   23.080191] Task dump for CPU 1:
[   23.080664] swapper/1       R running      0     0      1 0x00000000
[   44.098439] INFO: rcu_sched detected stalls on CPUs/tasks: { 1} (detected by 0, t=2102 jiffies, g=4294967001, c=4294967000, q=2950)
[   44.098968] Task dump for CPU 1:
[   44.099090] swapper/1       R running      0     0      1 0x00000000
<hang>

AFTER:

$ qemu-system-arm -machine type=vexpress-a15 -cpu cortex-a15 -m 2048 -nographic -append "root=/dev/vda rw mem=512M console=ttyAMA0 rootwait earlyprintk" -kernel $KERNELPATH/zImage -dtb $KERNELPATH/dts/vexpress-v2p-ca15-tc1.dtb -drive if=none,file=$HOME/arm-wheezy.img,id=foo -device virtio-blk-device,drive=foo -smp cpus=2 
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Linux version 3.10.21+ (kim at ntel) (gcc version 4.8.1 (Ubuntu/Linaro 4.8.1-10ubuntu7) ) #9 SMP Wed Dec 4 18:30:31 GMT 2013
[    0.000000] CPU: ARMv7 Processor [412fc0f1] revision 1 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine: ARM-Versatile Express, model: V2P-CA15
[    0.000000] Truncating memory at 0x80000000 to fit in 32-bit physical address space
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] PERCPU: Embedded 9 pages/cpu @80d2d000 s13056 r8192 d15616 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
[    0.000000] Kernel command line: root=/dev/vda rw mem=512M console=ttyAMA0 rootwait earlyprintk
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 512MB = 512MB total
[    0.000000] Memory: 510280k/510280k available, 14008k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xa0800000 - 0xff000000   (1512 MB)
[    0.000000]     lowmem  : 0x80000000 - 0xa0000000   ( 512 MB)
[    0.000000]     modules : 0x7f000000 - 0x80000000   (  16 MB)
[    0.000000]       .text : 0x80008000 - 0x8080b67c   (8206 kB)
[    0.000000]       .init : 0x8080c000 - 0x80874300   ( 417 kB)
[    0.000000]       .data : 0x80876000 - 0x808ba4e0   ( 274 kB)
[    0.000000]        .bss : 0x808ba4e0 - 0x809245b4   ( 425 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 4294967ms
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
[    0.000000] Console: colour dummy device 80x30
[    0.004768] Calibrating delay loop... 626.68 BogoMIPS (lpj=3133440)
[    0.158299] pid_max: default: 32768 minimum: 301
[    0.159410] Security Framework initialized
[    0.160937] AppArmor: AppArmor initialized
[    0.161494] Mount-cache hash table entries: 512
[    0.175491] CPU: Testing write buffer coherency: ok
[    0.176540] ftrace: allocating 21674 entries in 64 pages
[    0.265860] /cpus/cpu at 0 missing clock-frequency property
[    0.266328] /cpus/cpu at 1 missing clock-frequency property
[    0.266887] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.268133] Setting up static identity map for 0x805f7518 - 0x805f7570
[    0.287985] CPU1: Booted secondary processor
[    0.407414] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.409492] Brought up 2 CPUs
[    0.410245] SMP: Total of 2 processors activated (1238.63 BogoMIPS).
[    0.410594] CPU: All CPU(s) started in SVC mode.
[    0.426269] devtmpfs: initialized
[    0.458588] xor: measuring software checksum speed
[    0.557906]    arm4regs  :   663.200 MB/sec
[    0.658103]    8regs     :   735.200 MB/sec
[    0.757854]    32regs    :   614.000 MB/sec
[    0.758226] xor: using function: 8regs (735.200 MB/sec)
[    0.789546] NET: Registered protocol family 16
[    0.791926] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.849716] hw-breakpoint: debug architecture 0x0 unsupported.
[    0.850185] Serial: AMBA PL011 UART driver
[    0.851799] 1c090000.uart: ttyAMA0 at MMIO 0x1c090000 (irq = 37) is a PL011 rev1
[    0.852949] console [ttyAMA0] enabled, bootconsole disabled
[    0.852949] console [ttyAMA0] enabled, bootconsole disabled
[    0.857224] 1c0a0000.uart: ttyAMA1 at MMIO 0x1c0a0000 (irq = 38) is a PL011 rev1
[    0.859404] 1c0b0000.uart: ttyAMA2 at MMIO 0x1c0b0000 (irq = 39) is a PL011 rev1
[    0.861174] 1c0c0000.uart: ttyAMA3 at MMIO 0x1c0c0000 (irq = 40) is a PL011 rev1
[    0.987941] bio: create slab <bio-0> at 0
[    1.208083] raid6: int32x1    214 MB/s
[    1.378264] raid6: int32x2    321 MB/s
[    1.548004] raid6: int32x4    157 MB/s
[    1.718144] raid6: int32x8    184 MB/s
[    1.718414] raid6: using algorithm int32x2 (321 MB/s)
[    1.718696] raid6: using intx1 recovery algorithm
[    1.780042] SCSI subsystem initialized
[    1.785067] usbcore: registered new interface driver usbfs
[    1.786049] usbcore: registered new interface driver hub
[    1.787134] usbcore: registered new device driver usb
[    1.792145] Advanced Linux Sound Architecture Driver Initialized.
[    1.800569] NetLabel: Initializing
[    1.800794] NetLabel:  domain hash size = 128
[    1.801012] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.802129] NetLabel:  unlabeled traffic allowed by default
[    1.802941] Switching to clocksource arm,sp804
[    1.838028] Clockevents: could not switch to one-shot mode: dummy_timer is not functional.
[    1.838548] Could not switch to high resolution mode on CPU 0
[    1.839043] Clockevents: could not switch to one-shot mode: dummy_timer is not functional.
[    1.839362] Could not switch to high resolution mode on CPU 1
[    1.898828] AppArmor: AppArmor Filesystem Enabled
[    2.008001] NET: Registered protocol family 2
[    2.078196] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    2.078745] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    2.079349] TCP: Hash tables configured (established 4096 bind 4096)
[    2.079953] TCP: reno registered
[    2.080272] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    2.080724] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    2.098238] NET: Registered protocol family 1
[    2.128576] RPC: Registered named UNIX socket transport module.
[    2.128945] RPC: Registered udp transport module.
[    2.129207] RPC: Registered tcp transport module.
[    2.129464] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.137943] hw perfevents: enabled with ARMv7 Cortex-A15 PMU driver, 1 counters available
[    2.161544] audit: initializing netlink socket (disabled)
[    2.162414] type=2000 audit(2.120:1): initialized
[    2.238420] VFS: Disk quotas dquot_6.5.2
[    2.248332] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    2.638199] NFS: Registering the id_resolver key type
[    2.639106] Key type id_resolver registered
[    2.639366] Key type id_legacy registered
[    2.639902] jffs2: version 2.2. (NAND) (SUMMARY)  ? 2001-2006 Red Hat, Inc.
[    2.739100] 9p: Installing v9fs 9p2000 file system support
[    2.838178] bio: create slab <bio-1> at 1
[    2.918978] Btrfs loaded
[    2.919447] msgmni has been set to 996
[    2.932275] io scheduler noop registered (default)
[    2.934606] clcd-pl11x: probe of 1c1f0000.clcd failed with error -22
[    2.964272] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.002221] brd: module loaded
[    3.021298]  vda: unknown partition table
[    3.031418] mtdoops: mtd device (mtddev=name/number) must be supplied
[    3.032774] smsc911x: Driver version 2008-10-21
[    3.033689] smsc911x 1a000000.ethernet (unregistered net_device): couldn't get clock -2
[    3.043550] libphy: smsc911x-mdio: probed
[    3.044367] smsc911x 1a000000.ethernet eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=1a000000.etherne:01, irq=-1)
[    3.049785] smsc911x 1a000000.ethernet eth0: MAC Address: 52:54:00:12:34:56
[    3.090096] nxp-isp1760 1b000000.usb: NXP ISP1760 USB Host Controller
[    3.091821] nxp-isp1760 1b000000.usb: new USB bus registered, assigned bus number 1
[    3.092585] nxp-isp1760 1b000000.usb: Scratch test failed.
[    3.092918] nxp-isp1760 1b000000.usb: can't setup
[    3.093347] nxp-isp1760 1b000000.usb: USB bus 1 deregistered
[    3.099036] usbcore: registered new interface driver usb-storage
[    3.104094] mousedev: PS/2 mouse device common for all mice
[    3.112145] rtc-pl031 1c170000.rtc: rtc core: registered pl031 as rtc0
[    3.149267] device-mapper: ioctl: 4.24.0-ioctl (2013-01-15) initialised: dm-devel at redhat.com
[    3.149923] cpuidle: using governor ladder
[    3.150252] cpuidle: using governor menu
[    3.152390] mmci-pl18x 1c050000.mmci: mmc0: PL181 manf 41 rev0 at 0x1c050000 irq 41,42 (pio)
[    3.204839] usbcore: registered new interface driver usbhid
[    3.205192] usbhid: USB HID core driver
[    3.227885] input: AT Raw Set 2 keyboard as /devices/smb.14/motherboard.15/iofpga.16/1c060000.kmi/serio0/input/input0
[    3.256961] aaci-pl041 1c040000.aaci: ARM AC'97 Interface PL041 rev0 at 0x1c040000, irq 43
[    3.257437] aaci-pl041 1c040000.aaci: FIFO 512 entries
[    3.262037] oprofile: using timer interrupt.
[    3.270355] TCP: cubic registered
[    3.270610] Initializing XFRM netlink socket
[    3.328195] NET: Registered protocol family 10
[    3.351298] sit: IPv6 over IPv4 tunneling driver
[    3.355274] NET: Registered protocol family 17
[    3.355686] NET: Registered protocol family 15
[    3.356881] 9pnet: Installing 9P2000 support
[    3.422605]   #0: ARM AC'97 Interface PL041 rev0 at 0x1c040000, irq 43
[    3.905733] input: ImExPS/2 Generic Explorer Mouse as /devices/smb.14/motherboard.15/iofpga.16/1c070000.kmi/serio1/input/input1
[    3.989003] kjournald starting.  Commit interval 5 seconds
[    3.999855] EXT3-fs (vda): using internal journal
[    4.002265] EXT3-fs (vda): recovery complete
[    4.002621] EXT3-fs (vda): mounted filesystem with writeback data mode
[    4.004618] VFS: Mounted root (ext3 filesystem) on device 254:0.
[    4.008901] devtmpfs: mounted
[    4.010679] Freeing unused kernel memory: 416K (8080c000 - 80874000)
INIT: version 2.88 booting
[info] Using makefile-style concurrent boot in runlevel S.
[....] Starting the hotplug events dispatcher: udevd[    7.704098] udevd[686]: starting version 175
. ok 
[ ok ] Synthesizing the initial hotplug events...done.
[ ok ] Waiting for /dev to be fully populated...done.
[ ok ] Activating swap...done.
[ ok ] Cleaning up temporary files... /tmp.
[ ok ] Activating lvm and md swap...done.
[....] Checking file systems...fsck from util-linux 2.20.1
done.
[ ok ] Mounting local filesystems...done.
[ ok ] Activating swapfile swap...done.
[ ok ] Cleaning up temporary files....
[ ok ] Setting kernel variables ...done.
[ ok ] Configuring network interfaces...done.
[ ok ] Cleaning up temporary files....
INIT: Entering runlevel: 2
[info] Using makefile-style concurrent boot in runlevel 2.
[ ok ] Starting enhanced syslogd: rsyslogd.
[ ok ] Starting periodic command scheduler: cron.

Debian GNU/Linux 7 ntel ttyAMA0

ntel login:

 kernel/time/tick-common.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index e91f101..086216c 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -234,8 +234,13 @@ static bool tick_check_preferred(struct clock_event_device *curdev,
 			return false;
 	}
 
-	/* Use the higher rated one */
-	return !curdev || newdev->rating > curdev->rating;
+	/*
+	 * Use the higher rated one, but prefer a CPU local device with a lower
+	 * rating than a non-CPU local device
+	 */
+	return !curdev ||
+		newdev->rating > curdev->rating ||
+	       !cpumask_equal(curdev->cpumask, newdev->cpumask);
 }
 
 /*
-- 
1.8.5
