From: hiraku.toyooka.gu@hitachi.com (hiraku.toyooka.gu at hitachi.com)
Date: Tue, 2 Jun 2015 14:32:19 +0900
Subject: =?ISO-2022-JP?B?UmU6IFtQQVRDSF0gQVJNOiBzb2NmcGdh?=
 =?ISO-2022-JP?B?OiBhZGQgc21wX29wcy5jcHVfa2lsbCB0?=
 =?ISO-2022-JP?B?byBtYWtlIGtleGVjL2tkdW1wIGF2YWls?=
 =?ISO-2022-JP?B?YWJsZQ==?=
References: <20150529053844.31162.43927.stgit@arietta>
 <20150529083339.GG2067@n2100.arm.linux.org.uk>
Message-ID: <XNM1$3$0$0$$3$3$3$A$0000051U556d3fe3@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Russell,

Thank you for your reply.

On 2015/05/29 17:33, Russell King - ARM Linux wrote:
 > Please look at the kexec'd kernel's boot messages.  You will probably
 > notice that the kexec'd kernel is unable to start the secondary CPUs,
 > and probably causes them to crash.

No, as far as I can see, starting the secondary CPU succeeds.
Here is my console log.
(and I also added the full console log at the end of this mail.)

root at socfpga_cyclone5:~# ./kexec -l zImage --dtb=socfpga_cyclone5_socdk.dtb --command-line="console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait"
root at socfpga_cyclone5:~# ./kexec -e
[   89.545357] kexec: Starting new kernel
[   89.549100] Disabling non-boot CPUs ...
[   89.574067] CPU1: shutdown
[   89.577300] Bye!
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Linux version 4.1.0-rc5-00076-g597b491 (hiraku at arietta) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) ) #1 SMP Thu May 28 20:18:57 JST 2015
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: Altera SOCFPGA Cyclone V SoC Development Kit
...
[    0.040662] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
...
[    0.079845] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.079906] Brought up 2 CPUs
...
[    0.079928] CPU: All CPU(s) started in SVC mode.
...

(I confirmed that kdump also works fine and that the extracted dump
image is analyzable by latest crash-utility.)

 > As socfpga does not appear to be able to do anything with the secondary
 > CPUs other than park them in a WFI loop in the _existing_ kernel, when
 > that existing kernel gets overwritten by the kexec kernel and an interrupt
 > sent to the CPU, that secondary CPU could very well start executing code
 > it's not meant to.

Before kexec soft reboot, secondary CPU's IRQs except for per-cpu twd are
migrated from a CPU going offline to CPU0 by migrate_irqs(). The twd is
stopped by twd_timer_cpu_notify(). As a result, secondary CPU has no
interrupt source before entering WFI loop.
After staring kexec'd kernel, all interrupts are sent to CPU0 by default
and CPU0 resets the secondary CPUs in socfpga_boot_secondary().
I think it's the reason why kexec in socfpga succeeds.

Best regards,
Hiraku Toyooka

[full console log]
root at socfpga_cyclone5:~# dmesg | grep CPU
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] PERCPU: Embedded 12 pages/cpu @ef1df000 s19648 r8192 d21312 u49152
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000]  Additional per-CPU info printed with stalls.
[    0.090473] CPU: Testing write buffer coherency: ok
[    0.090657] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.129845] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.129907] Brought up 2 CPUs
[    0.129928] CPU: All CPU(s) started in SVC mode.
[    1.808749] ThumbEE CPU extension supported.
root at socfpga_cyclone5:~# 
root at socfpga_cyclone5:~# ./kexec -l zImage --dtb=socfpga_cyclone5_socdk.dtb --command-line="console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait"
root at socfpga_cyclone5:~# ./kexec -e
[   89.545357] kexec: Starting new kernel
[   89.549100] Disabling non-boot CPUs ...
[   89.574067] CPU1: shutdown
[   89.577300] Bye!
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Linux version 4.1.0-rc5-00076-g597b491 (hiraku at arietta) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) ) #1 SMP Thu May 28 20:18:57 JST 2015
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: Altera SOCFPGA Cyclone V SoC Development Kit
[    0.000000] Truncating RAM at 0x00000000-0x40000000 to -0x2f800000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] PERCPU: Embedded 12 pages/cpu @ef1df000 s19648 r8192 d21312 u49152
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 193040
[    0.000000] Kernel command line: console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 764396K/778240K available (4697K kernel code, 284K rwdata, 1324K rodata, 312K init, 135K bss, 13844K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05e9944   (6023 kB)
[    0.000000]       .init : 0xc05ea000 - 0xc0638000   ( 312 kB)
[    0.000000]       .data : 0xc0638000 - 0xc067f058   ( 285 kB)
[    0.000000]        .bss : 0xc067f058 - 0xc06a0e2c   ( 136 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Additional per-CPU info printed with stalls.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310: enabling full line of zeros but not enabled in Cortex-A9
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
[    0.000000] L2C-310: CACHE_ID 0x410030c9, AUX_CTRL 0x46060001
[    0.000000] clocksource timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.000006] sched_clock: 32 bits at 100MHz, resolution 10ns, wraps every 21474836475ns
[    0.000180] Console: colour dummy device 80x30
[    0.000199] Calibrating delay loop... 1594.16 BogoMIPS (lpj=7970816)
[    0.039853] pid_max: default: 32768 minimum: 301
[    0.039935] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.039946] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.040476] CPU: Testing write buffer coherency: ok
[    0.040662] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.040721] Setting up static identity map for 0x8280 - 0x82d8
[    0.079845] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.079906] Brought up 2 CPUs
[    0.079922] SMP: Total of 2 processors activated (3188.32 BogoMIPS).
[    0.079928] CPU: All CPU(s) started in SVC mode.
[    0.080335] devtmpfs: initialized
[    0.080895] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.081151] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.085533] NET: Registered protocol family 16
[    0.086424] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.090448] No ATAGs?
[    0.090484] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.090492] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.121823] SCSI subsystem initialized
[    0.122126] usbcore: registered new interface driver usbfs
[    0.122191] usbcore: registered new interface driver hub
[    0.122249] usbcore: registered new device driver usb
[    0.122947] pps_core: LinuxPPS API ver. 1 registered
[    0.122957] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.122991] PTP clock support registered
[    0.123853] Switched to clocksource timer1
[    0.152880] NET: Registered protocol family 2
[    0.153517] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.153597] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.153738] TCP: Hash tables configured (established 8192 bind 8192)
[    0.153815] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.153917] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.154094] NET: Registered protocol family 1
[    0.154412] RPC: Registered named UNIX socket transport module.
[    0.154423] RPC: Registered udp transport module.
[    0.154429] RPC: Registered tcp transport module.
[    0.154435] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.155554] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.166733] ntfs: driver 2.1.32 [Flags: R/W].
[    0.167413] io scheduler noop registered (default)
[    0.171716] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    0.172676] console [ttyS0] disabled
[    0.172712] ffc02000.serial0: ttyS0 at MMIO 0xffc02000 (irq = 34, base_baud = 6250000) is a 16550A
[    0.656017] console [ttyS0] enabled
[    0.661737] brd: module loaded
[    0.665346] CAN device driver interface
[    0.669581] stmmac - user ID: 0x10, Synopsys ID: 0x37
[    0.674651]  Ring mode enabled
[    0.677695]  DMA HW capability register supported
[    0.682204]  Enhanced/Alternate descriptors
[    0.686577]  Enabled extended descriptors
[    0.690570]  RX Checksum Offload Engine supported (type 2)
[    0.696048]  TX Checksum insertion supported
[    0.700299]  Enable RX Mitigation via HW Watchdog Timer
[    0.711628] libphy: stmmac: probed
[    0.715049] eth0: PHY ID 00221611 at 4 IRQ POLL (stmmac-0:04) active
[    1.013860] dwc2 ffb40000.usb: Mode Mismatch Interrupt: currently in Device mode
[    1.573966] dwc2 ffb40000.usb: DWC OTG Controller
[    1.578678] dwc2 ffb40000.usb: new USB bus registered, assigned bus number 1
[    1.585737] dwc2 ffb40000.usb: irq 36, io mem 0x00000000
[    1.591742] hub 1-0:1.0: USB hub found
[    1.595523] hub 1-0:1.0: 1 port detected
[    1.600108] mousedev: PS/2 mouse device common for all mice
[    1.605919] i2c /dev entries driver
[    1.609990] Synopsys Designware Multimedia Card Interface Driver
[    1.616245] dw_mmc ff704000.dwmmc0: IDMAC supports 32-bit address mode.
[    1.622862] dw_mmc ff704000.dwmmc0: Using PIO mode.
[    1.627737] dw_mmc ff704000.dwmmc0: Version ID is 240a
[    1.632891] dw_mmc ff704000.dwmmc0: DW MMC controller at irq 30, 32 bit host data width, 1024 deep fifo
[    1.642395] dw_mmc ff704000.dwmmc0: Got CD GPIO
[    1.683888] dw_mmc ff704000.dwmmc0: 1 slots initialized
[    1.689367] usbcore: registered new interface driver usbhid
[    1.694938] usbhid: USB HID core driver
[    1.698949] oprofile: no performance counters
[    1.703383] oprofile: using timer interrupt.
[    1.708651] NET: Registered protocol family 10
[    1.714047] sit: IPv6 over IPv4 tunneling driver
[    1.719262] NET: Registered protocol family 17
[    1.723713] NET: Registered protocol family 15
[    1.728166] can: controller area network core (rev 20120528 abi 9)
[    1.734384] NET: Registered protocol family 29
[    1.738818] can: raw protocol (rev 20120528)
[    1.743075] can: broadcast manager protocol (rev 20120528 t)
[    1.748731] can: netlink gateway (rev 20130117) max_hops=1
[    1.754385] 8021q: 802.1Q VLAN Support v1.8
[    1.758637] ThumbEE CPU extension supported.
[    1.762901] Registering SWP/SWPB emulation handler
[    1.766884] mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot req 50000000Hz, actual 50000000HZ div = 2)
[    1.766983] mmc0: new high speed SDHC card at address b368
[    1.767337] mmcblk0: mmc0:b368 43599 7.45 GiB 
[    1.775252]  mmcblk0: p1 p2 p3
[    1.793020] ttyS0 - failed to request DMA
[    3.982561] random: nonblocking pool is initialized
[    9.147418] kjournald starting.  Commit interval 5 seconds
[    9.661702] EXT3-fs (mmcblk0p2): using internal journal
[    9.669488] EXT3-fs (mmcblk0p2): recovery complete
[    9.674272] EXT3-fs (mmcblk0p2): mounted filesystem with ordered data mode
[    9.681146] VFS: Mounted root (ext3 filesystem) on device 179:2.
[    9.689650] devtmpfs: mounted
[    9.692862] Freeing unused kernel memory: 312K (c05ea000 - c0638000)
[   10.178818] systemd[1]: systemd 208 running in system mode. (+PAM +LIBWRAP -AUDIT -SELINUX +IMA +SYSVINIT -LIBCRYPTSETUP -GCRYPT +ACL +XZ)

Welcome to The ??.ngstr??m Distribution!

[   10.207650] systemd[1]: Failed to insert module 'autofs4'
[   10.214342] systemd[1]: Set hostname to <socfpga_cyclone5>.
[   10.262881] systemd-fstab-generator[526]: Checking was requested for "rootfs", but it is not a device.
[   10.536604] systemd[1]: Cannot add dependency job for unit display-manager.service, ignoring: Unit display-manager.service failed to load: No such file or directory.
[   10.552185] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[   10.560099] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   10.567710] systemd[1]: Expecting device dev-ttyS0.device...
         Expecting device dev-ttyS0.device...
[   10.593970] systemd[1]: Starting Syslog Socket.
[  OK  ] Listening on Syslog Socket.
[   10.613932] systemd[1]: Listening on Syslog Socket.
[   10.618849] systemd[1]: Starting Remote File Systems.
[  OK  ] Reached target Remote File Systems.
[   10.643927] systemd[1]: Reached target Remote File Systems.
[   10.649531] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
[   10.673929] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[   10.680909] systemd[1]: Starting Delayed Shutdown Socket.
[  OK  ] Listening on Delayed Shutdown Socket.
[   10.703926] systemd[1]: Listening on Delayed Shutdown Socket.
[   10.709725] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[   10.717878] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   10.725828] systemd[1]: Starting Paths.
[  OK  ] Reached target Paths.
[   10.743929] systemd[1]: Reached target Paths.
[   10.748330] systemd[1]: Starting Journal Socket.
[  OK  ] Listening on Journal Socket.
[   10.773926] systemd[1]: Listening on Journal Socket.
[   10.778954] systemd[1]: Started Create list of required static device nodes for the current kernel.
[   10.788048] systemd[1]: Mounting Debug File System...
         Mounting Debug File System...
[   10.818949] systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
[   10.870264] systemd[1]: Started Load Kernel Modules.
[   10.877739] systemd[1]: Starting Create static device nodes in /dev...
         Starting Create static device nodes in /dev...
[   10.905397] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[  OK  ] Started Journal Service.
[   10.944033] systemd[1]: Started Journal Service.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Listening on udev Control Socket.
         Starting udev Coldplug all Devices...
[   10.994183] systemd-journald[538]: Vacuuming done, freed 0 bytes
         Mounting Configuration File System...
[  OK  ] Reached target Swap.
         Starting Remount Root and Kernel File Systems...
[  OK  ] Created slice Root Slice.
[  OK  ] Created slice User and Session Slice.
[  OK  ] Created slice System Slice.
[  OK  ] Created slice system-getty.slice.
[  OK  ] Created slice system-serial\x2dgetty.slice.
[  OK  ] Reached target Slices.
[  OK  ] Mounted Debug File System.
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Started Create static device nodes in /dev.
[  OK  ] Mounted Configuration File System.
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Coldplug all Devices.
[   13.258892] systemd-udevd[836]: starting version 208
[  OK  ] Started udev Kernel Device Manager.
[  OK  ] Started Remount Root and Kernel File Systems.
[  OK  ] Reached target Local File Systems (Pre).
         Mounting /tmp...
         Starting Load/Save Random Seed...
[  OK  ] Mounted /tmp.
[  OK  ] Reached target Local File Systems.
         Starting Trigger Flushing of Journal to Persistent Storage...
         Starting Create Volatile Files and Directories...
[  OK  ] Found device /dev/ttyS0.
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started Create Volatile Files and Directories.
         Starting Update UTMP about System Reboot/Shutdown...
[   13.688134] systemd-journald[538]: Received request to flush runtime journal from PID 1
[  OK  ] Started Trigger Flushing of Journal to Persistent Storage.
[  OK  ] Started Update UTMP about System Reboot/Shutdown.
[  OK  ] Reached target System Initialization.
[  OK  ] Listening on Avahi mDNS/DNS-SD Stack Activation Socket.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Timers.
[   16.332383] systemd-journald[538]: File /var/log/journal/955ec35df1b24341b558c1c99c8c2850/system.journal corrupted or uncleanly shut down, renaming and replacing.
[  OK  ] Listening on sshd.socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
         Starting Connection service...
         Starting Lightning Fast Webserver With Light System Requirements...
         Starting Altera GSRD initialization...
         Starting Login Service...
         Starting Avahi mDNS/DNS-SD Stack...
         Starting D-Bus System Message Bus...
[  OK  ] Started D-Bus System Message Bus.
         Starting Kernel Logging Service...
[  OK  ] Started Kernel Logging Service.
         Starting System Logging Service...
[  OK  ] Started System Logging Service.
         Starting Timestamping service...
[  OK  ] Started Timestamping service.
         Starting Permit User Sessions...
[  OK  ] Started Lightning Fast Webserver With Light System Requirements.
[  OK  ] Started Permit User Sessions.
         Starting Getty on tty1...
[  OK  ] Started Getty on tty1.
         Starting Serial Getty on ttyS0...
[  OK  ] Started Serial Getty on ttyS0.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started Avahi mDNS/DNS-SD Stack.
[  OK  ] Started Login Service.
[  OK  ] Started Connection service.
         Starting WPA supplicant...
[   20.472563] eth0: device MAC address 02:5a:de:7e:10:58
[  OK  ] Started WPA supplicant.
[  OK  ] Started Altera GSRD initialization.
[  OK  ] Reached target Multi-User System.
[  OK  ] Reached target Graphical Interface.

.---O---.                                           
|       |                  .-.           o o        
|   |   |-----.-----.-----.| |   .----..-----.-----.
|       |     | __  |  ---'| '--.|  .-'|     |     |
|   |   |  |  |     |---  ||  --'|  |  |  '  | | | |
'---'---'--'--'--.  |-----''----''--'  '-----'-'-'-'
                -'  |
                '---'

The Angstrom Distribution socfpga_cyclone5 ttyS0

Angstrom v2013.12 - Kernel 4.1.0-rc5-00076-g597b491

socfpga_cyclone5 login: [   23.599238] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   25.554439] stmmaceth ff702000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[   25.563171] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
root
Last login: Wed May 27 19:29:10 UTC 2015 on ttyS0
root at socfpga_cyclone5:~# dmesg | grep CPU
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] PERCPU: Embedded 12 pages/cpu @ef1df000 s19648 r8192 d21312 u49152
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000]  Additional per-CPU info printed with stalls.
[    0.040476] CPU: Testing write buffer coherency: ok
[    0.040662] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.079845] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.079906] Brought up 2 CPUs
[    0.079928] CPU: All CPU(s) started in SVC mode.
[    1.758637] ThumbEE CPU extension supported.
root at socfpga_cyclone5:~# 
