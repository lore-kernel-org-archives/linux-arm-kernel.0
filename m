From: horms@verge.net.au (Simon Horman)
Date: Mon, 24 Sep 2018 14:48:46 +0200
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990: Add Audio-DMAC and
 Sound device nodes
In-Reply-To: <1534492401-17801-1-git-send-email-ykaneko0929@gmail.com>
References: <1534492401-17801-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <20180924124845.tviosix5qlbo2rcj@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2018 at 04:53:21PM +0900, Yoshihiro Kaneko wrote:
> This patch adds Audio-DMAC0 device node and Sound device node
> for the R8A77990 SoC.
> 
> The following patches were squashed into this patch:
> * Takeshi Kihara <takeshi.kihara.df@renesas.com>
>   arm64: dts: r8a77990: Add Audio-DMAC device nodes
>   arm64: dts: r8a77990: Add Sound device node and SSI support
>   arm64: dts: r8a77990: Add Sound SRC support
>   arm64: dts: r8a77990: Add Sound DVC device nodes
>   arm64: dts: r8a77990: Add Sound CTU support
>   arm64: dts: r8a77990: Add Sound MIX support
> * Hai Nguyen Pham <hai.pham.ud@renesas.com>
>   arm64: dts: r8a77990: Tie Audio-DMAC to IPMMU-MP
> 
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
> 
> This patch is based on the devel branch of Simon Horman's renesas tree.

Unfortunately this patch does not seem to result in a working
sound device on the Ebisu board.

I have tried adding backports of the following patches:

* 42b35c5991cc ("pinctrl: sh-pfc: r8a77990: Add Audio SSI pins, groups and functions")
* 42b35c5991cc ("pinctrl: sh-pfc: r8a77990: Add Audio SSI pins, groups and functions")
* 42b35c5991cc ("pinctrl: sh-pfc: r8a77990: Add Audio SSI pins, groups and functions")

However, although the rcar-snd driver appears to be probed successfully
it does not result in an alsa sound device being registered. This also
appears to be the case with BSP v3.7.2.rc2.

Probably I am missing something obvious here...

Build log taken with the following debug patch applied:

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index d23c2bbff0cf..cbba1c6a9ab7 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -98,6 +98,9 @@
  * #define RSND_DEBUG_NO_DAI_CALL 1
  */
 
+#define DEBUG 1
+#define RSND_DEBUG_NO_DAI_CALL 1
+
 #include <linux/pm_runtime.h>
 #include "rsnd.h"
 
* This patch + backports noted above + debug patch above
  On top of renesas-drivers-2018-09-11-v4.19-rc3 + renesas-devel-20180919-v4.19-rc4
  Build using renesas_defconfig

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 4.19.0-rc4-arm64-renesas-01580-g306feb97f8fe-dirty (horms at reginn.horms.nl) (gcc version 7.3.0 (GCC)) #36 SMP PREEMPT Mon Sep 24 14:38:05 CEST 2018
[    0.000000] Machine model: Renesas Ebisu board based on r8a77990
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 128 MiB at 0x0000000078000000
[    0.000000] On node 0 totalpages: 229376
[    0.000000]   DMA32 zone: 3584 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 229376 pages, LIFO batch:63
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS resident on physical CPU 0x0
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] random: get_random_bytes called from start_kernel+0xac/0x480 with crng_init=0
[    0.000000] percpu: Embedded 23 pages/cpu @(____ptrval____) s64968 r0 d29240 u94208
[    0.000000] pcpu-alloc: s64968 r0 d29240 u94208 alloc=23*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 225792
[    0.000000] Kernel command line: ignore_loglevel rw root=/dev/nfs ip=dhcp
[    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.000000] Memory: 740856K/917504K available (9852K kernel code, 1172K rwdata, 2968K rodata, 768K init, 12242K bss, 45576K reserved, 131072K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU lockdep checking is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
[    0.000000]  Tasks RCU enabled.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000007] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.000253] Console: colour dummy device 80x25
[    0.002023] console [tty0] enabled
[    0.002063] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.002127] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.002166] ... MAX_LOCK_DEPTH:          48
[    0.002207] ... MAX_LOCKDEP_KEYS:        8191
[    0.002248] ... CLASSHASH_SIZE:          4096
[    0.002289] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.002331] ... MAX_LOCKDEP_CHAINS:      65536
[    0.002372] ... CHAINHASH_SIZE:          32768
[    0.002414]  memory used by lock dependency info: 7391 kB
[    0.002461]  per task-struct memory footprint: 1920 bytes
[    0.002577] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.002670] pid_max: default: 32768 minimum: 301
[    0.003024] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.003089] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.028401] ASID allocator initialised with 32768 entries
[    0.036348] rcu: Hierarchical SRCU implementation.
[    0.045077] Detected Renesas R-Car Gen3 r8a77990 ES1.0
[    0.045992] EFI services will not be available.
[    0.052538] smp: Bringing up secondary CPUs ...
[    0.085092] Detected VIPT I-cache on CPU1
[    0.085210] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.085743] smp: Brought up 1 node, 2 CPUs
[    0.085918] SMP: Total of 2 processors activated.
[    0.085975] CPU features: detected: 32-bit EL0 Support
[    0.090085] CPU: All CPU(s) started at EL1
[    0.090175] alternatives: patching kernel code
[    0.092781] devtmpfs: initialized
[    0.114667] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.114830] futex hash table entries: 512 (order: 4, 65536 bytes)
[    0.119328] pinctrl core: initialized pinctrl subsystem
[    0.121740] DMI not present or invalid.
[    0.122849] NET: Registered protocol family 16
[    0.123971] audit: initializing netlink subsys (disabled)
[    0.124585] audit: type=2000 audit(0.120:1): state=initialized audit_enabled=0 res=1
[    0.126123] cpuidle: using governor menu
[    0.126529] vdso: 2 pages (1 code @ (____ptrval____), 1 data @ (____ptrval____))
[    0.126617] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.129728] DMA: preallocated 256 KiB pool for atomic allocations
[    0.136397] sh-pfc e6060000.pin-controller: r8a77990_pfc support registered
[    0.173932] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.175772] cryptd: max_cpu_qlen set to 1000
[    0.183412] vgaarb: loaded
[    0.184159] SCSI subsystem initialized
[    0.184984] libata version 3.00 loaded.
[    0.185448] usbcore: registered new interface driver usbfs
[    0.185610] usbcore: registered new interface driver hub
[    0.185862] usbcore: registered new device driver usb
[    0.187207] media: Linux media interface: v0.10
[    0.187330] videodev: Linux video capture interface: v2.00
[    0.187578] pps_core: LinuxPPS API ver. 1 registered
[    0.187633] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.187743] PTP clock support registered
[    0.187833] EDAC MC: Ver: 3.0.0
[    0.190030] Advanced Linux Sound Architecture Driver Initialized.
[    0.192678] clocksource: Switched to clocksource arch_sys_counter
[    0.335175] VFS: Disk quotas dquot_6.6.0
[    0.335394] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.354051] NET: Registered protocol family 2
[    0.355963] tcp_listen_portaddr_hash hash table entries: 512 (order: 3, 36864 bytes)
[    0.356150] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.356290] TCP bind hash table entries: 8192 (order: 7, 524288 bytes)
[    0.357321] TCP: Hash tables configured (established 8192 bind 8192)
[    0.358115] UDP hash table entries: 512 (order: 4, 81920 bytes)
[    0.358320] UDP-Lite hash table entries: 512 (order: 4, 81920 bytes)
[    0.358898] NET: Registered protocol family 1
[    0.361555] RPC: Registered named UNIX socket transport module.
[    0.361676] RPC: Registered udp transport module.
[    0.361728] RPC: Registered tcp transport module.
[    0.361781] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.361865] PCI: CLS 0 bytes, default 64
[    0.363964] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
[    0.364601] kvm [1]: HYP mode not available
[    0.375217] workingset: timestamp_bits=46 max_order=18 bucket_order=0
[    0.394832] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.396898] NFS: Registering the id_resolver key type
[    0.397282] Key type id_resolver registered
[    0.397360] Key type id_legacy registered
[    0.397446] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.397539] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    0.406333] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.406686] io scheduler noop registered
[    0.407158] io scheduler cfq registered (default)
[    0.407218] io scheduler mq-deadline registered
[    0.407270] io scheduler kyber registered
[    0.413858] gpio_rcar e6050000.gpio: driving 18 GPIOs
[    0.415148] gpio_rcar e6051000.gpio: driving 23 GPIOs
[    0.416193] gpio_rcar e6052000.gpio: driving 26 GPIOs
[    0.417570] gpio_rcar e6053000.gpio: driving 16 GPIOs
[    0.418666] gpio_rcar e6054000.gpio: driving 11 GPIOs
[    0.419650] gpio_rcar e6055000.gpio: driving 20 GPIOs
[    0.420773] gpio_rcar e6055400.gpio: driving 18 GPIOs
[    0.530078] SuperH (H)SCI(F) driver initialized
[    0.531877] e6e88000.serial: ttySC0 at MMIO 0xe6e88000 (irq = 95, base_baud = 0) is a scif
[    1.287274] console [ttySC0] enabled
[    1.319946] loop: module loaded
[    1.327166] libphy: Fixed MDIO Bus: probed
[    1.332088] tun: Universal TUN/TAP device driver, 1.6
[    1.338005] CAN device driver interface
[    1.345961] libphy: ravb_mii: probed
[    1.352400] ravb e6800000.ethernet eth0: Base address at 0xe6800000, 2e:09:0a:03:85:38, IRQ 92.
[    1.362260] VFIO - User Level meta-driver version: 0.3
[    1.368070] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.374755] ehci-pci: EHCI PCI platform driver
[    1.379350] ehci-platform: EHCI generic platform driver
[    1.386212] ehci-platform ee080100.usb: EHCI Host Controller
[    1.392358] ehci-platform ee080100.usb: new USB bus registered, assigned bus number 1
[    1.401161] ehci-platform ee080100.usb: irq 115, io mem 0xee080100
[    1.420767] ehci-platform ee080100.usb: USB 2.0 started, EHCI 1.10
[    1.430292] hub 1-0:1.0: USB hub found
[    1.434472] hub 1-0:1.0: 1 port detected
[    1.440402] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.446905] ohci-pci: OHCI PCI platform driver
[    1.451565] ohci-platform: OHCI generic platform driver
[    1.457692] ohci-platform ee080000.usb: Generic Platform OHCI controller
[    1.464567] ohci-platform ee080000.usb: new USB bus registered, assigned bus number 2
[    1.473400] ohci-platform ee080000.usb: irq 115, io mem 0xee080000
[    1.569637] hub 2-0:1.0: USB hub found
[    1.573620] hub 2-0:1.0: 1 port detected
[    1.580085] xhci-hcd ee000000.usb: xHCI Host Controller
[    1.585552] xhci-hcd ee000000.usb: new USB bus registered, assigned bus number 3
[    1.593785] xhci-hcd ee000000.usb: Direct firmware load for r8a779x_usb3_v3.dlmem failed with error -2
[    1.603899] xhci-hcd ee000000.usb: can't setup: -2
[    1.608846] xhci-hcd ee000000.usb: USB bus 3 deregistered
[    1.614867] xhci-hcd: probe of ee000000.usb failed with error -2
[    1.621362] usbcore: registered new interface driver usb-storage
[    1.629110] i2c /dev entries driver
[    1.635823] i2c-rcar e6500000.i2c: probed
[    1.649787] cs2000-cp 3-004f: revision - C1
[    1.654455] i2c-rcar e66d0000.i2c: probed
[    1.659520] adv748x 0-0070: Endpoint /soc/i2c at e6500000/video-receiver at 70/port at 7/endpoint on port 7
[    1.668687] adv748x 0-0070: Endpoint /soc/i2c at e6500000/video-receiver at 70/port at 8/endpoint on port 8
[    1.677798] adv748x 0-0070: Endpoint /soc/i2c at e6500000/video-receiver at 70/port at a/endpoint on port 10
[    1.688788] adv748x 0-0070: chip found @ 0xe0 revision 2143
[    1.729197] random: fast init done
[    1.842387] adv748x 0-0070: No endpoint found for txb
[    1.847611] adv748x 0-0070: Failed to probe TXB
[    1.863998] ledtrig-cpu: registered to indicate activity on CPUs
[    1.871666] usbcore: registered new interface driver usbhid
[    1.877846] usbhid: USB HID core driver
[    1.900825] rcar_sound ec500000.sound: ssi[0] is connected to io (Playback)
[    1.907968] rcar_sound ec500000.sound: ssi[1] is connected to io (Capture)
[    1.915087] rcar_sound ec500000.sound: src[0] is connected to io (Playback)
[    1.922160] rcar_sound ec500000.sound: src[1] is connected to io (Capture)
[    1.929278] rcar_sound ec500000.sound: dvc[0] is connected to io (Playback)
[    1.936350] rcar_sound ec500000.sound: dvc[1] is connected to io (Capture)
[    1.943349] rcar_sound ec500000.sound: rsnd-dai.0 (play/capture)
[    1.949462] rcar_sound ec500000.sound: ssiu[0] is connected to io (Playback)
[    1.956782] rcar_sound ec500000.sound: audmac-pp[0] is connected to io (Playback)
[    1.964386] rcar_sound ec500000.sound: cmd[0] is connected to io (Playback)
[    1.979628] NET: Registered protocol family 17
[    1.984386] can: controller area network core (rev 20170425 abi 9)
[    1.990951] NET: Registered protocol family 29
[    1.995530] can: raw protocol (rev 20170425)
[    2.000215] can: broadcast manager protocol (rev 20170425 t)
[    2.006019] can: netlink gateway (rev 20170425) max_hops=1
[    2.012464] Key type dns_resolver registered
[    2.018489] registered taskstats version 1
[    2.077756] rcar_sound ec500000.sound: ssi[0] is connected to io (Playback)
[    2.084956] rcar_sound ec500000.sound: ssi[1] is connected to io (Capture)
[    2.092093] rcar_sound ec500000.sound: src[0] is connected to io (Playback)
[    2.099169] rcar_sound ec500000.sound: src[1] is connected to io (Capture)
[    2.106304] rcar_sound ec500000.sound: dvc[0] is connected to io (Playback)
[    2.113381] rcar_sound ec500000.sound: dvc[1] is connected to io (Capture)
[    2.120398] rcar_sound ec500000.sound: rsnd-dai.0 (play/capture)
[    2.126514] rcar_sound ec500000.sound: ssiu[0] is connected to io (Playback)
[    2.133822] rcar_sound ec500000.sound: audmac-pp[0] is connected to io (Playback)
[    2.141428] rcar_sound ec500000.sound: cmd[0] is connected to io (Playback)
[    2.156761] rcar-dmac e6700000.dma-controller: ignoring dependency for device, assuming no driver
[    2.176236] rcar-dmac e7300000.dma-controller: ignoring dependency for device, assuming no driver
[    2.194084] rcar-dmac e7310000.dma-controller: ignoring dependency for device, assuming no driver
[    2.211937] rcar-dmac ec700000.dma-controller: ignoring dependency for device, assuming no driver
[    2.242558] rcar_sound ec500000.sound: ssi[0] is connected to io (Playback)
[    2.249746] rcar_sound ec500000.sound: ssi[1] is connected to io (Capture)
[    2.256888] rcar_sound ec500000.sound: src[0] is connected to io (Playback)
[    2.263973] rcar_sound ec500000.sound: src[1] is connected to io (Capture)
[    2.271116] rcar_sound ec500000.sound: dvc[0] is connected to io (Playback)
[    2.278199] rcar_sound ec500000.sound: dvc[1] is connected to io (Capture)
[    2.285208] rcar_sound ec500000.sound: rsnd-dai.0 (play/capture)
[    2.291333] rcar_sound ec500000.sound: ssiu[0] is connected to io (Playback)
[    2.298587] rcar_sound ec500000.sound: audmac-pp[0] is connected to io (Playback)
[    2.306220] rcar_sound ec500000.sound: cmd[0] is connected to io (Playback)
[    2.314036] rcar_sound ec500000.sound: audmac[0] is connected to io (Playback)
[    2.321412] rcar_sound ec500000.sound: cmd[1] is connected to io (Capture)
[    2.328620] rcar_sound ec500000.sound: audmac[1] is connected to io (Capture)
[    2.335930] rcar_sound ec500000.sound: ssiu[1] is connected to io (Capture)
[    2.343091] rcar_sound ec500000.sound: audmac-pp[1] is connected to io (Capture)
[    2.350760] rcar_sound ec500000.sound: probed
[    2.358019] hctosys: unable to open rtc device (rtc0)
[    2.445199] Micrel KSZ9031 Gigabit PHY e6800000.ethernet-ffffffff:00: attached PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=e6800000.ethernet-ffffffff:00, irq=117)
[    8.154333] ravb e6800000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
[    8.180792] Sending DHCP requests .., OK
[   10.936881] IP-Config: Got DHCP answer from 10.7.3.2, my address is 10.7.3.177
[   10.944252] IP-Config: Complete:
[   10.947565]      device=eth0, hwaddr=2e:09:0a:03:85:38, ipaddr=10.7.3.177, mask=255.255.255.0, gw=10.7.3.2
[   10.957355]      host=10.7.3.177, domain=horms.nl horms.jp vergenet.net, nis-domain=(none)
[   10.965739]      bootserver=10.7.3.162, rootserver=10.7.3.162, rootpath=/srv/nfs/arm64,nfsvers=3,rsize=1024,wsize=1024
[   10.965749]      nameserver0=10.7.3.2, nameserver1=8.8.8.8
[   10.983958] ALSA device list:
[   10.987170]   No soundcards found.
...
