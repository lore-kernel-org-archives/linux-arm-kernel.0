From: rah@settrans.net (Bob Ham)
Date: Sat, 11 Feb 2017 12:08:40 +0000
Subject: Allwinner A31 framebuffer fails with new CCU clock bindings
Message-ID: <1486814920.7145.19.camel@settrans.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there,

I have a Mele A1000G Quad top set box with an Allwinner A31 chip.
Unfortunately, the framebuffer is failing on recent kernels.  I have a
1080p monitor connected to the HDMI output.  During boot, the monitor
goes blank and reports "No Signal".

I've done a git bisect and determined that this is the offending commit:

# first bad commit: [78a9f0dbcd6015cdd1114dc7d78554fd5bb28010] ARM: dts: sun6i: switch A31/A31s to new CCU clock bindings


On IRC, MoeIcenowy requested the contents
of /sys/kernel/debug/clk/clk_summary.  I don't know how useful it will
be but I've put up two versions, one from the bad commit and another
from the previous, good commit in the bisect:

http://settrans.net/~rah/misc/sun6i-a31-bad-fb-clk_summary-good.txt
http://settrans.net/~rah/misc/sun6i-a31-bad-fb-clk_summary-bad.txt


I videoed the monitor during boot using a webcam, twice.  On both
occasions, before the monitor went blank the last frame showed the same
point during boot:

[    2.295630] vcc3v0: disabling
[    2.306822] vcc3v3: disabling
[    2.317821] vcc5v0: disabling

and curiously, this is the next line of output that wasn't seen on the
monitor:

[    2.328737] vdd-gpu: disabling

Here's one of the last frames:

http://settrans.net/~rah/misc/sun6i-a31-bad-fb-last-console-frame.jpg


Kernel output is below.  Any assistance would be appreciated.

Thanks,

Bob


[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.8.0-rc1-linux-sunxi-cedrus-27-armmp (rah at rue) (gcc version 6.2.1 20161124 (Debian 6.2.1-5) ) #25 SMP Thu Feb 9 10:44:40 GMT 2017
[    0.000000] CPU: ARMv7 Processor [410fc073] revision 3 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: Mele A1000G Quad top set box
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: Using PSCI v0.1 Function IDs from DT
[    0.000000] percpu: Embedded 15 pages/cpu @eefab000 s28684 r8192 d24564 u61440
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 520727
[    0.000000] Kernel command line: console=ttyS0,115200 console=tty0 console=ttyS0,115200 hdmi.audio=EDID:0 disp.screen0_output_mode=EDID:1280x1024p60 root=UUID=2e19b245-bf21-4c0d-abfe-944d52ca136c rootwait
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 2057700K/2089052K available (6144K kernel code, 516K rwdata, 1360K rodata, 1024K init, 283K bss, 31352K reserved, 0K cma-reserved, 1302620K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0700000   (7136 kB)
[    0.000000]       .init : 0xc0900000 - 0xc0a00000   (1024 kB)
[    0.000000]       .data : 0xc0a00000 - 0xc0a81104   ( 517 kB)
[    0.000000]        .bss : 0xc0a83000 - 0xc0ac9d44   ( 284 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=4
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] Architected cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000006] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.000019] Switching to timer-based delay loop, resolution 41ns
[    0.000218] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.000368] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 9556302233 ns
[    0.000664] Console: colour dummy device 80x30
[    0.001344] console [tty0] enabled
[    0.001389] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.001436] pid_max: default: 32768 minimum: 301
[    0.001555] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001583] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002299] CPU: Testing write buffer coherency: ok
[    0.002359] ftrace: allocating 21606 entries in 64 pages
[    0.035304] /cpus/cpu at 0 missing clock-frequency property
[    0.035358] /cpus/cpu at 1 missing clock-frequency property
[    0.035384] /cpus/cpu at 2 missing clock-frequency property
[    0.035411] /cpus/cpu at 3 missing clock-frequency property
[    0.035437] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.035488] Setting up static identity map for 0x40100000 - 0x40100058
[    0.047176] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.057837] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.068453] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.068516] Brought up 4 CPUs
[    0.068595] SMP: Total of 4 processors activated (192.00 BogoMIPS).
[    0.068616] CPU: All CPU(s) started in HYP mode.
[    0.068633] CPU: Virtualization extensions available.
[    0.069602] devtmpfs: initialized
[    0.075552] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 3
[    0.075807] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.075938] pinctrl core: initialized pinctrl subsystem
[    0.076851] NET: Registered protocol family 16
[    0.077188] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.077694] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.077728] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.090035] reg-fixed-voltage usb1-vbus: could not find pctldev for node /soc at 01c00000/pinctrl at 01c20800/usb1_vbus_pin at 0, deferring probe
[    0.091059] SCSI subsystem initialized
[    0.091496] usbcore: registered new interface driver usbfs
[    0.091569] usbcore: registered new interface driver hub
[    0.091637] usbcore: registered new device driver usb
[    0.091855] pps_core: LinuxPPS API ver. 1 registered
[    0.091877] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.091927] PTP clock support registered
[    0.092140] Advanced Linux Sound Architecture Driver Initialized.
[    0.093012] clocksource: Switched to clocksource arch_sys_counter
[    0.117580] simple-framebuffer bf817000.framebuffer: framebuffer at 0xbf817000, 0x7e9000 bytes, mapped to 0xf0880000
[    0.117639] simple-framebuffer bf817000.framebuffer: format=x8r8g8b8, mode=1920x1080x32, linelength=7680
[    0.150621] Console: switching to colour frame buffer device 240x67
[    0.182881] simple-framebuffer bf817000.framebuffer: fb0: simplefb registered!
[    0.192366] NET: Registered protocol family 2
[    0.193113] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.193375] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.193652] TCP: Hash tables configured (established 8192 bind 8192)
[    0.193884] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.194092] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.194445] NET: Registered protocol family 1
[    0.194964] RPC: Registered named UNIX socket transport module.
[    0.195127] RPC: Registered udp transport module.
[    0.195251] RPC: Registered tcp transport module.
[    0.195374] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.195783] Unpacking initramfs...
[    0.387150] Freeing initrd memory: 3780K (c9c4f000 - ca000000)
[    0.387712] hw perfevents: /pmu: failed to probe PMU!
[    0.387854] hw perfevents: /pmu: failed to register PMU devices!
[    0.388033] armv7-pmu: probe of pmu failed with error -22
[    0.389356] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.390289] workingset: timestamp_bits=30 max_order=19 bucket_order=0
[    0.400191] NFS: Registering the id_resolver key type
[    0.400375] Key type id_resolver registered
[    0.400489] Key type id_legacy registered
[    0.401692] bounce: pool size: 64 pages
[    0.402011] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.402206] io scheduler noop registered
[    0.402313] io scheduler deadline registered
[    0.402594] io scheduler cfq registered (default)
[    0.405711] sun6i-a31-pinctrl 1c20800.pinctrl: initialized sunXi PIO driver
[    0.406129] sun6i-a31-r-pinctrl 1f02c00.pinctrl: Reset controller missing
[    0.465900] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    0.469079] console [ttyS0] disabled
[    0.488457] 1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq = 42, base_baud = 1500000) is a U6_16550A
[    1.192908] console [ttyS0] enabled
[    1.198716] libphy: Fixed MDIO Bus: probed
[    1.203053] CAN device driver interface
[    1.207750] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.214455] ehci-platform: EHCI generic platform driver
[    1.228162] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.242550] ohci-platform: OHCI generic platform driver
[    1.256135] usbcore: registered new interface driver usb-storage
[    1.271480] sun6i-rtc 1f00000.rtc: rtc core: registered rtc-sun6i as rtc0
[    1.286488] sun6i-rtc 1f00000.rtc: RTC enabled
[    1.299055] i2c /dev entries driver
[    1.310747] i2c-sunxi-p2wi 1f03400.i2c: could not find pctldev for node /soc at 01c00000/pinctrl at 01f02c00/p2wi, deferring probe
[    1.330316] IR NEC protocol handler initialized
[    1.343082] IR RC5(x/sz) protocol handler initialized
[    1.356331] IR RC6 protocol handler initialized
[    1.368998] IR JVC protocol handler initialized
[    1.381541] IR Sony protocol handler initialized
[    1.394126] IR SANYO protocol handler initialized
[    1.406738] IR Sharp protocol handler initialized
[    1.419222] IR MCE Keyboard/mouse protocol handler initialized
[    1.432850] IR XMP protocol handler initialized
[    1.445235] sunxi-ir 1f02000.ir: could not find pctldev for node /soc at 01c00000/pinctrl at 01f02c00/ir at 0, deferring probe
[    1.464494] sunxi-wdt 1c20ca0.watchdog: Watchdog enabled (timeout=16 sec, nowayout=0)
[    1.482052] sun4i-ss 1c15000.crypto-engine: Die ID 4
[    1.496543] usbcore: registered new interface driver usbhid
[    1.510334] usbhid: USB HID core driver
[    1.525298] NET: Registered protocol family 10
[    1.538761] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.553564] NET: Registered protocol family 17
[    1.566132] can: controller area network core (rev 20120528 abi 9)
[    1.580474] NET: Registered protocol family 29
[    1.592936] can: raw protocol (rev 20120528)
[    1.605142] can: broadcast manager protocol (rev 20160617 t)
[    1.618716] can: netlink gateway (rev 20130117) max_hops=1
[    1.632327] Key type dns_resolver registered
[    1.644549] Registering SWP/SWPB emulation handler
[    1.660018] sun6i-a31-r-pinctrl 1f02c00.pinctrl: initialized sunXi PIO driver
[    1.676739] axp20x-i2c 0-0068: AXP20x variant AXP221 found
[    1.709186] input: axp20x-pek as /devices/platform/soc at 01c00000/1f03400.i2c/i2c-0/0-0068/axp20x-pek/input/input0
[    1.732570] dc1sw: supplied by vcc-3v3
[    1.745065] dc5ldo: supplied by vcc-dram
[    1.768668] axp20x-i2c 0-0068: AXP20X driver loaded
[    1.781802] Registered IR keymap rc-empty
[    1.793995] input: sunxi-ir as /devices/platform/soc at 01c00000/1f02000.ir/rc/rc0/input1
[    1.810122] rc rc0: sunxi-ir as /devices/platform/soc at 01c00000/1f02000.ir/rc/rc0
[    1.826847] input: MCE IR Keyboard/Mouse (sunxi-ir) as /devices/virtual/input/input2
[    1.843267] sunxi-ir 1f02000.ir: initialized sunXi IR driver
[    1.859024] sunxi-mmc 1c0f000.mmc: Got CD GPIO
[    1.923045] sunxi-mmc 1c0f000.mmc: base:0xf106c000 irq:29
[    1.937786]  Ring mode enabled
[    1.949023]  DMA HW capability register supported Normal descriptors
[    1.970052] libphy: stmmac: probed
[    1.981716] eth0: PHY ID 00008201 at 1 IRQ POLL (stmmac-0:01) active
[    1.996614] ehci-platform 1c1a000.usb: EHCI Host Controller
[    2.010451] ehci-platform 1c1a000.usb: new USB bus registered, assigned bus number 1
[    2.014132] mmc0: host does not support reading read-only switch, assuming write-enable
[    2.016887] mmc0: new high speed SDHC card at address aaaa
[    2.017409] mmcblk0: mmc0:aaaa SL16G 14.8 GiB
[    2.031318]  mmcblk0: p1
[    2.080522] ehci-platform 1c1a000.usb: irq 31, io mem 0x01c1a000
[    2.123019] ehci-platform 1c1a000.usb: USB 2.0 started, EHCI 1.00
[    2.138388] hub 1-0:1.0: USB hub found
[    2.150529] hub 1-0:1.0: 1 port detected
[    2.163354] ehci-platform 1c1b000.usb: EHCI Host Controller
[    2.177232] ehci-platform 1c1b000.usb: new USB bus registered, assigned bus number 2
[    2.193367] ehci-platform 1c1b000.usb: irq 32, io mem 0x01c1b000
[    2.233020] ehci-platform 1c1b000.usb: USB 2.0 started, EHCI 1.00
[    2.247887] hub 2-0:1.0: USB hub found
[    2.259743] hub 2-0:1.0: 1 port detected
[    2.272364] sun6i-rtc 1f00000.rtc: setting system clock to 2016-11-03 17:29:23 UTC (1478194163)
[    2.295630] vcc3v0: disabling
[    2.306822] vcc3v3: disabling
[    2.317821] vcc5v0: disabling
[    2.328737] vdd-gpu: disabling
[    2.340276] dc1sw: disabling
[    2.351693] ALSA device list:
[    2.362406]   No soundcards found.
[    2.375259] Freeing unused kernel memory: 1024K (c0900000 - c0a00000)
Loading, please wait...
starting version 232
[    2.430144] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    2.435304] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.436944] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.437325] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.437744] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.438129] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.438504] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.438896] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.439341] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.440113] random: udevadm: uninitialized urandom read (16 bytes read)
[    2.633082] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    2.703069] usb 2-1: new high-speed USB device number 2 using ehci-platform
[    2.836081] hub 1-1:1.0: USB hub found
[    2.849887] hub 1-1:1.0: 4 ports detected
[    3.193048] usb 1-1.2: new low-speed USB device number 3 using ehci-platform
[    3.364493] input: NOVATEK USB NETVISTA FULL WIDTH KEYBOARD as /devices/platform/soc at 01c00000/1c1a000.usb/usb1/1-1/1-1.2/1-1.2:1.0/0003:0461:4E04.0001/input/input3
[    3.453607] hid-generic 0003:0461:4E04.0001: input: USB HID v1.10 Keyboard [NOVATEK USB NETVISTA FULL WIDTH KEYBOARD] on usb-1c1a000.usb-1.2/input0
[    3.480735] input: NOVATEK USB NETVISTA FULL WIDTH KEYBOARD as /devices/platform/soc at 01c00000/1c1a000.usb/usb1/1-1/1-1.2/1-1.2:1.1/0003:0461:4E04.0002/input/input4
[    3.573244] hid-generic 0003:0461:4E04.0002: input: USB HID v1.10 Device [NOVATEK USB NETVISTA FULL WIDTH KEYBOARD] on usb-1c1a000.usb-1.2/input1
[    3.693027] usb 1-1.3: new low-speed USB device number 4 using ehci-platform
[    3.861222] input: USB OPTICAL MOUSE  as /devices/platform/soc at 01c00000/1c1a000.usb/usb1/1-1/1-1.3/1-1.3:1.0/0003:18F8:0F99.0003/input/input5
[    3.882270] hid-generic 0003:18F8:0F99.0003: input: USB HID v1.10 Mouse [USB OPTICAL MOUSE ] on usb-1c1a000.usb-1.3/input0
[    3.907043] input: USB OPTICAL MOUSE  as /devices/platform/soc at 01c00000/1c1a000.usb/usb1/1-1/1-1.3/1-1.3:1.1/0003:18F8:0F99.0004/input/input6
[    3.993221] hid-generic 0003:18F8:0F99.0004: input: USB HID v1.10 Keyboard [USB OPTICAL MOUSE ] on usb-1c1a000.usb-1.3/input1


-- 
Bob Ham <rah@settrans.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170211/f48d60bd/attachment.sig>
