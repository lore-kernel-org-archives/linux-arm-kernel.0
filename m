From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Mon, 12 Dec 2016 23:45:48 +0530
Subject: [RFC v3 PATCH 00/25] Allow NOMMU for MULTIPLATFORM
In-Reply-To: <be4002b0-d4e8-bb3a-dff0-8050f680f5ae@st.com>
 <584E6DA3.5070009@arm.com>
 <238a0185-db3a-fa43-cd7d-91baebdb82d4@st.com>
 <87fulus094.fsf@dell.be.48ers.dk>
Message-ID: <20161212181548.GA3641@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Dec 11, 2016 at 09:01:59PM +0100, Peter Korsgaard wrote:

> When you select a cortex-A variant, then we enable MMU support by
> default, but you can disable it under toolchain options (Enable MMU) and
> then the flat binary option is available.

Thank You Peter Korsgaard, that did the trick, able to boot to
prompt!, logs at the end.

> Hmm, I'm not sure why a cortex-M toolchain wouldn't work on cortex-A, I
> thought the 'M' instruction set was a pure subset of the 'A'.

On Mon, Dec 12, 2016 at 09:28:03AM +0000, Vladimir Murzin wrote:

> M-class toolchain should just work with A-class; you don't even need to
> disable MMU to try it out after d782e42 ("ARM: 8594/1: enable binfmt_flat on
> systems with an MMU").

Earlier, there was a nonsense done by me in not enabling flat binary
support in Kernel.

But even after that, it didn't work, dunno why, upon enabling flat
binary support in Kernel, it ended up instead with,

Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004

The exit code probably refers to interrupted system call

On Mon, Dec 12, 2016 at 08:07:16AM +0100, mickael guene wrote:

>  You can find an R toolchain here:
> https://github.com/mickael-guene/fdpic_manifest/releases/download/v7-r-1.0.1/toolset-v7-r-1.0.1-0-gbdcc6a7c-armv7-r.tgz
> 
>  It's an fdpic toolset for cortex-r cpu class. gcc version is
> quite old (4.7).
> 
>  Note also that generated code may crash on class A cpu due to
> generation of udiv/sdiv which is optional for class A.
> (cortex a15 is ok but not a9).
> 
> Hope it helps

On Mon, Dec 12, 2016 at 10:44:45AM +0100, mickael guene wrote:

>  At the end of https://github.com/mickael-guene/fdpic_manifest you can
> find a set of patch to apply for kernel fdpic support. Unfortunately
> they are quite old ... But I have done some test on May for
> stm32f469-disco platform and I have attached patches against more
> recent kernel.

Thanks Mickael.

Earlier had tried syncing the repo, download was getting interrupted
frequently, though persisting on it would have fetched it fully. But
seeing the Kernel patches parallely, pushed the plan aside for the
time being as context of the changes was very much different with the
version of Kernel (4.9-rc7) used here.

But the attached patches seems can be applied w/o any/much difficulty.

As already reached the prompt, will keep note of these details, might
help later.

And Vladimir, Thanks.

Regards
afzal


[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.0-rc7-00026-g7a142ca8231b (afzal at debian) (gcc version 6.2.0 (GCC) ) #26 Mon Dec 12 22:32:33 IST 2016
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=00c50478
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: TI AM437x Industrial Development Kit
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] AM437x ES1.2 (sgx neon)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
[    0.000000] Kernel command line: console=ttyO0,115200n8 earlyprintk
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1029196K/1048576K available (6562K kernel code, 523K rwdata, 2096K rodata, 712K init, 274K bss, 19380K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0x80000000 - 0x80001000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0x00000000 - 0xffffffff   (4095 MB)
[    0.000000]     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
[    0.000000]     modules : 0x80000000 - 0xc0000000   (1024 MB)
[    0.000000]       .text : 0x80008000 - 0x80670b88   (6563 kB)
[    0.000000]       .init : 0x8087e000 - 0x80930000   ( 712 kB)
[    0.000000]       .data : 0x80930000 - 0x809b2f60   ( 524 kB)
[    0.000000]        .bss : 0x809b2f60 - 0x809f7a9c   ( 275 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] OMAP clockevent source: timer1 at 32786 Hz
[    0.000259] sched_clock: 64 bits at 500MHz, resolution 2ns, wraps every 4398046511103ns
[    0.009660] clocksource: arm_global_timer: mask: 0xffffffffffffffff max_cycles: 0xe6a171a037, max_idle_ns: 881590485102 ns
[    0.022315] Switching to timer-based delay loop, resolution 2ns
[    0.141364] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
[    0.152415] OMAP clocksource: 32k_counter at 32768 Hz
[    0.231362] Console: colour dummy device 80x30
[    0.236920] Calibrating delay loop (skipped), value calculated using timer frequency.. 1000.00 BogoMIPS (lpj=5000000)
[    0.249062] pid_max: default: 32768 minimum: 301
[    0.256668] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.264524] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.323801] devtmpfs: initialized
[    0.935615] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.951495] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.963940] pinctrl core: initialized pinctrl subsystem
[    1.014378] NET: Registered protocol family 16
[    2.111659] cpuidle: using governor menu
[    2.176928] omap_l3_noc 44000000.ocp: L3 debug error: target 8 mod:0 (unclearable)
[    2.186840] omap_l3_noc 44000000.ocp: L3 application error: target 8 mod:0 (unclearable)
[    2.494565] OMAP GPIO hardware version 0.1
[    2.883468] platform 53701000.des: Cannot lookup hwmod 'des'
[    2.900195] platform 48310000.rng: Cannot lookup hwmod 'rng'
[    3.046777] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    3.055998] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    3.072570] omap4_sram_init:Unable to allocate sram needed to handle errata I688
[    3.080942] omap4_sram_init:Unable to get sram pool needed to handle errata I688
[    4.016395] edma 49000000.edma: TI EDMA DMA engine driver
[    4.042166] V3_3D: supplied by V24_0D
[    4.056616] VDD_COREREG: supplied by V24_0D
[    4.072516] VDD_CORE: supplied by VDD_COREREG
[    4.088252] V1_8DREG: supplied by V24_0D
[    4.103897] V1_8D: supplied by V1_8DREG
[    4.118796] V1_5DREG: supplied by V24_0D
[    4.134236] V1_5D: supplied by V1_5DREG
[    4.288700] vgaarb: loaded
[    4.326444] SCSI subsystem initialized
[    4.345255] usbcore: registered new interface driver usbfs
[    4.354345] usbcore: registered new interface driver hub
[    4.362195] usbcore: registered new device driver usb
[    4.383412] omap_i2c 44e0b000.i2c: could not find pctldev for node /ocp at 44000000/l4_wkup at 44c00000/scm at 210000/pinmux at 800/i2c0_pins_default, deferring probe
[    4.400047] omap_i2c 4819c000.i2c: could not find pctldev for node /ocp at 44000000/l4_wkup at 44c00000/scm at 210000/pinmux at 800/i2c2_pins_default, deferring probe
[    4.420788] pps_core: LinuxPPS API ver. 1 registered
[    4.426744] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    4.437776] PTP clock support registered
[    4.449669] EDAC MC: Ver: 3.0.0
[    4.507254] clocksource: Switched to clocksource arm_global_timer
[    4.891236] NET: Registered protocol family 2
[    4.920504] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    4.934239] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    4.947220] TCP: Hash tables configured (established 8192 bind 8192)
[    4.956856] UDP hash table entries: 512 (order: 1, 8192 bytes)
[    4.965035] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
[    4.976320] NET: Registered protocol family 1
[    4.988215] RPC: Registered named UNIX socket transport module.
[    4.994956] RPC: Registered udp transport module.
[    5.000656] RPC: Registered tcp transport module.
[    5.006103] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    6.371750] workingset: timestamp_bits=30 max_order=18 bucket_order=0
[    6.835038] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    6.888403] NFS: Registering the id_resolver key type
[    6.894459] Key type id_resolver registered
[    6.899596] Key type id_legacy registered
[    6.905432] ntfs: driver 2.1.32 [Flags: R/O].
[    6.961089] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    6.969706] io scheduler noop registered
[    6.974328] io scheduler deadline registered
[    6.989359] io scheduler cfq registered (default)
[    7.085244] pinctrl-single 44e10800.pinmux: 199 pins at pa 44e10800 size 796
[    9.483420] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    9.593419] omap_uart 44e09000.serial: no wakeirq for uart0
[    9.600384] omap_uart 44e09000.serial: No clock speed specified: using default: 48000000
[    9.612215] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 29, base_baud = 3000000) is a OMAP UART0
[    9.623241] console [ttyO0] enabled
[    9.623241] console [ttyO0] enabled
[    9.631603] bootconsole [earlycon0] disabled
[    9.631603] bootconsole [earlycon0] disabled
[    9.657952] STMicroelectronics ASC driver initialized
[    9.703627] omap_rng 48310000.rng: _od_fail_runtime_resume: FIXME: missing hwmod/omap_dev info
[    9.714158] omap_rng 48310000.rng: Failed to runtime_get device: -19
[    9.722078] omap_rng 48310000.rng: initialization failed.
[   10.149265] brd: module loaded
[   10.379026] loop: module loaded
[   10.549954] libphy: Fixed MDIO Bus: probed
[   10.621367] CAN device driver interface
[   10.696022] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   10.703201] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   10.713426] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[   10.721901] igb: Copyright (c) 2007-2014 Intel Corporation.
[   10.937883] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6
[   10.945298] davinci_mdio 4a101000.mdio: detected phy mask fffffffe
[   10.963397] libphy: 4a101000.mdio: probed
[   10.968744] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver Micrel KSZ9031 Gigabit PHY
[   11.002569] cpsw 4a100000.ethernet: Detected MACID = c4:be:84:cc:f8:b2
[   11.059455] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
[   11.070237] usbcore: registered new interface driver pegasus
[   11.079659] usbcore: registered new interface driver asix
[   11.088196] usbcore: registered new interface driver ax88179_178a
[   11.097524] usbcore: registered new interface driver cdc_ether
[   11.107046] usbcore: registered new interface driver smsc75xx
[   11.116880] usbcore: registered new interface driver smsc95xx
[   11.125813] usbcore: registered new interface driver net1080
[   11.134794] usbcore: registered new interface driver cdc_subset
[   11.143940] usbcore: registered new interface driver zaurus
[   11.153558] usbcore: registered new interface driver cdc_ncm
[   11.224727] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   11.232713] ehci-pci: EHCI PCI platform driver
[   11.240224] ehci-platform: EHCI generic platform driver
[   11.256349] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   11.264046] ohci-pci: OHCI PCI platform driver
[   11.271558] ohci-platform: OHCI generic platform driver
[   11.284180] ohci-omap3: OHCI OMAP3 driver
[   11.325702] usbcore: registered new interface driver usb-storage
[   11.400750] mousedev: PS/2 mouse device common for all mice
[   11.447930] i2c /dev entries driver
[   11.615616] sdhci: Secure Digital Host Controller Interface driver
[   11.623170] sdhci: Copyright(c) Pierre Ossman
[   11.647533] omap_hsmmc 48060000.mmc: Got CD GPIO
[   11.734930] Synopsys Designware Multimedia Card Interface Driver
[   11.764020] sdhci-pltfm: SDHCI platform and OF driver helper
[   11.812878] ledtrig-cpu: registered to indicate activity on CPUs
[   11.827153] usbcore: registered new interface driver usbhid
[   11.834026] usbhid: USB HID core driver
[   11.882277] NET: Registered protocol family 10
[   11.934153] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   11.971848] NET: Registered protocol family 17
[   11.977629] can: controller area network core (rev 20120528 abi 9)
[   11.987031] NET: Registered protocol family 29
[   11.992658] can: raw protocol (rev 20120528)
[   11.998072] can: broadcast manager protocol (rev 20161123 t)
[   12.004962] can: netlink gateway (rev 20130117) max_hops=1
[   12.025921] Key type dns_resolver registered
[   12.035682] omap_voltage_late_init: Voltage driver support not added
[   12.048436] ThumbEE CPU extension supported.
[   12.280999] mmc0: host does not support reading read-only switch, assuming write-enable
[   12.293776] mmc0: new high speed SDHC card at address 0002
[   12.318060] at24 0-0050: 32768 byte 24c256 EEPROM, writable, 64 bytes/write
[   12.340744] mmcblk0: mmc0:0002 00000 3.66 GiB 
[   12.366577] omap_i2c 44e0b000.i2c: bus 0 rev0.12 at 400 kHz
[   12.393428]  mmcblk0: p1 p2
[   12.433995] omap_i2c 4819c000.i2c: bus 2 rev0.12 at 100 kHz
[   12.464867] input: gpio_keys as /devices/platform/gpio_keys/input/input0
[   12.479679] hctosys: unable to open rtc device (rtc0)
[   12.564936] Freeing unused kernel memory: 712K (8087e000 - 80930000)
[   12.572725] This architecture does not have kernel memory protection.
Initializing random number generator... [   14.422674] random: dd: uninitialized urandom read (512 bytes read)
done.

Welcome to Buildroot
buildroot login: root
Jan  1 00:00:16 login[81]: root login on 'ttyO0'
~ # uname -a
Linux buildroot 4.9.0-rc7-00026-g7a142ca8231b #26 Mon Dec 12 22:32:33 IST 2016 armv7l GNU/Linux
~ # 
