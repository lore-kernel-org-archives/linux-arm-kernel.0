From: frank.li@nxp.com (Frank Li)
Date: Wed, 8 Feb 2017 17:00:27 +0000
Subject: i.MX7 clock support broken
In-Reply-To: <DB5PR04MB1431EB280E8B9BA929FF006D80420@DB5PR04MB1431.eurprd04.prod.outlook.com>
References: <20170207142225.zitac2r7g3kvowjw@pengutronix.de>
 <DB5PR04MB1431EB280E8B9BA929FF006D80420@DB5PR04MB1431.eurprd04.prod.outlook.com>
Message-ID: <AMSPR04MB2639F8DB2861487540D191B88420@AMSPR04MB263.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Sascha,
>
> > Hi All,
> >
> > I recently adopted the i.MX7 clock tree from Linux to barebox and
> > wondered why ethernet doesn't work.
> 
> I just reproduced the issue on MX7D SDB board with latest upstream kernel
> That kernel NULL point crash during boot on fec_enet_open->..-
> >phy_attach_direct.
> 

I think 7D clock tree is early version. 
7D clock requirement is difference with mx6.  
7D require enable parent clock to change div or mux. 
But MX6 require gate parent clock to change div or MUX.  

I remember Aisheng have some follow up clock patch. I am not sure the latest state yet. 
Anyway, I think Aisheng will flow up this problem. 

Best regards
Frank Li

> Not sure if the same as yours.
> (Paste log at last)
> 
> Andy,
> Can you help check it?
> 
> > I found out that the clock tree in Linux is quite different from what
> > the reference manual describes and also quite different from the
> > hardware I have on my desk. There are several clocks that only exist
> > in the driver, but not in the actual hardware and also several clocks
> > which are in hardware, but not in the driver.
> >
> > These clocks exist in the driver only, but not in the hardware:
> >
> 
> Please refer to secion 5.2.5 in RM.
> They're LPCG gates.
> 
> But I did notice some of them seem not find in RM.
> e.g. IMX7D_ARM_A7_ROOT_CLK, IMX7D_ARM_M0_ROOT_CLK,
> IMX7D_SPDIF_ROOT_CLK ...
> 
> It might be true that not all listed in RM as I see a Note " Not all CCGRs are
> mapped " right upon Table 5-19.
> 
> I will double check with our IC guys tomorrow if the RM missed something.
> 
> > clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate4("arm_a7_root_clk",
> > "arm_a7_div", base + 0x4000, 0); clks[IMX7D_ARM_M4_ROOT_CLK] =
> > imx_clk_gate4("arm_m4_root_clk", "arm_m4_div", base + 0x4010, 0);
> > clks[IMX7D_ARM_M0_ROOT_CLK] = imx_clk_gate4("arm_m0_root_clk",
> > "arm_m0_div", base + 0x4020, 0); clks[IMX7D_USB_HSIC_ROOT_CLK] =
> > imx_clk_gate4("usb_hsic_root_clk", "usb_hsic_post_div", base + 0x4420,
> > 0); clks[IMX7D_PCIE_PHY_ROOT_CLK] =
> imx_clk_gate4("pcie_phy_root_clk",
> > "pcie_phy_post_div", base + 0x4600, 0); clks[IMX7D_SPDIF_ROOT_CLK] =
> > imx_clk_gate4("spdif_root_clk", "spdif_post_div", base + 0x44d0, 0);
> > clks[IMX7D_ENET1_REF_ROOT_CLK] =
> imx_clk_gate4("enet1_ref_root_clk",
> > "enet1_ref_post_div", base + 0x44e0, 0);
> > clks[IMX7D_ENET1_TIME_ROOT_CLK] =
> imx_clk_gate4("enet1_time_root_clk",
> > "enet1_time_post_div", base + 0x44f0, 0);
> > clks[IMX7D_ENET2_REF_ROOT_CLK] =
> imx_clk_gate4("enet2_ref_root_clk",
> > "enet2_ref_post_div", base + 0x4500, 0);
> > clks[IMX7D_ENET2_TIME_ROOT_CLK] =
> imx_clk_gate4("enet2_time_root_clk",
> > "enet2_time_post_div", base + 0x4510, 0);
> > clks[IMX7D_ENET_PHY_REF_ROOT_CLK] =
> > imx_clk_gate4("enet_phy_ref_root_clk", "enet_phy_ref_post_div", base
> +
> > 0x4520, 0); clks[IMX7D_AUDIO_MCLK_ROOT_CLK] =
> > imx_clk_gate4("audio_mclk_root_clk", "audio_mclk_post_div", base +
> > 0x4790, 0); clks[IMX7D_WRCLK_ROOT_CLK] =
> > imx_clk_gate4("wrclk_root_clk", "wrclk_post_div", base + 0x47a0, 0);
> > clks[IMX7D_ADC_ROOT_CLK] = imx_clk_gate4("adc_root_clk",
> > "ipg_root_clk", base + 0x4200, 0);
> >
> > And these clocks are described in the reference manual, but not
> > handled in the driver:
> >
> 
> Yes, some of they are missed.
> 
> > CCM_CCGR7 sim_m 0x4070
> > CCM_CCGR8 sim_s 0x4080
> > CCM_CCGR9 sim_wakeup 0x4090
> > CCM_CCGR10 ipmux1 0x40A0
> > CCM_CCGR11 ipmux2 0x40B0
> > CCM_CCGR12 ipmux3 0x40C0
> > CCM_CCGR16 rom 0x4100
> > CCM_CCGR33 anatop 0x4210
> > CCM_CCGR34 sctr 0x4220
> > CCM_CCGR35 ocotp 0x4230
> > CCM_CCGR36 caam 0x4240
> > CCM_CCGR37 snvs 0x4250
> > CCM_CCGR38 rdc 0x4260
> > CCM_CCGR39 mu 0x4270
> > CCM_CCGR40 hs 0x4280
> > CCM_CCGR41 dvfs 0x4290
> > CCM_CCGR42 qos 0x42A0
> > CCM_CCGR43 qos_dispmix 0x42B0
> > CCM_CCGR44 qos_megamix 0x42C0
> > CCM_CCGR45 csu 0x42D0
> > CCM_CCGR46 dbgmon 0x42E0
> > CCM_CCGR47 debug 0x42F0
> > CCM_CCGR49 sec_debug 0x4310
> > CCM_CCGR64 sema1 0x4400
> > CCM_CCGR65 sema2 0x4410
> > CCM_CCGR68 perfmon1 0x4440
> > CCM_CCGR69 perfmon2 0x4450
> > CCM_CCGR76 pxp 0x44C0
> > CCM_CCGR104 usb_ctrl 0x4680
> > CCM_CCGR105 usb_hsic 0x4690
> > CCM_CCGR106 usb_phy1 0x46A0
> > CCM_CCGR107 usb_phy2 0x46B0
> > CCM_CCGR112 enet1 0x4700
> > CCM_CCGR113 enet2 0x4710
> > CCM_CCGR160 gpio1 0x4A00
> > CCM_CCGR161 gpio2 0x4A10
> > CCM_CCGR162 gpio3 0x4A20
> > CCM_CCGR163 gpio4 0x4A30
> > CCM_CCGR164 gpio5 0x4A40
> > CCM_CCGR165 gpio6 0x4A50
> > CCM_CCGR166 gpio7 0x4A60
> > CCM_CCGR168 iomux 0x4A80
> > CCM_CCGR169 iomux_lpsr 0x4A90
> > CCM_CCGR170 kpp 0x4AA0
> >
> > It seems most stuff works in the Kernel when the clocks are left
> > enabled in the bootloader, but for example the real ethernet clocks
> > are never handled in the kernel.
> >
> > Also I stumbled upon the gate at offset 0x4130. The same gate is
> > registered as 5 different gates in the kernel without being handled as
> > a shared gate:
> >
> > clks[IMX7D_NAND_USDHC_BUS_ROOT_CLK] =
> > imx_clk_gate4("nand_usdhc_root_clk",
> > "nand_usdhc_post_div", base + 0x4130, 0); clks[IMX7D_DRAM_ROOT_CLK]
> =
> > imx_clk_gate4("dram_root_clk", "dram_post_div", base + 0x4130, 0);
> > clks[IMX7D_DRAM_PHYM_ROOT_CLK] =
> imx_clk_gate4("dram_phym_root_clk",
> > "dram_phym_cg", base + 0x4130, 0);
> clks[IMX7D_DRAM_PHYM_ALT_ROOT_CLK]
> > = imx_clk_gate4("dram_phym_alt_root_clk", "dram_phym_alt_post_div",
> > base + 0x4130, 0); clks[IMX7D_DRAM_ALT_ROOT_CLK] =
> > imx_clk_gate4("dram_alt_root_clk", "dram_alt_post_div", base + 0x4130,
> > 0);
> >
> 
> Thanks for report.
> Your concern seems reasonable.
> Will double check it then.
> 
> > I don't have a patch for this, just hope that somebody @NXP has a
> > better clue what's going on and maybe there already is a fix somewhere
> > floating around.
> >
> 
> Overally the current imx7d clk driver in upstream seems intend to be an initial
> version and may miss many local fix patches.
> 
> You can also refer to:
> http://git.freescale.com/git/cgit.cgi/imx/linux-
> imx.git/?h=imx_4.1.15_2.0.0_ga
> 
> It might help if there's local fixes.
> 
> > Sascha
> >
> > --
> > Pengutronix e.K.                           |                             |
> > Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> Kernel Crash Log as follows:
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.10.0-rc7-00065-g926af627 (b29396 at b29396-
> OptiPlex-7040) (gcc version 4.9.1 (GCC) ) #1106 SMP Thu Feb 9 14:44:54 CST
> 2017
> [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7),
> cr=10c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction
> cache
> [    0.000000] OF: fdt:Machine model: Freescale i.MX7 SabreSD Board
> [    0.000000] cma: Reserved 64 MiB at 0xbc000000
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] percpu: Embedded 14 pages/cpu @ef7c4000 s26816 r8192
> d22336 u57344
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
> 260608
> [    0.000000] Kernel command line: console=ttymxc0,115200 root=/dev/nfs
> ip=dhcp nfsroot=10.192.242.182:/data/rootfs_home/b29396/L4.1.X-2.0.0-
> RC4-mx6ul7d,v3,tcp printk.time=1 trace_event=clk
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Memory: 951748K/1048576K available (9216K kernel code, 476K
> rwdata, 2868K rodata, 1024K init, 8236K bss, 31292K reserved, 65536K cma-
> reserved, 196608K highmem)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc0a00000   (10208 kB)
> [    0.000000]       .init : 0xc0d00000 - 0xc0e00000   (1024 kB)
> [    0.000000]       .data : 0xc0e00000 - 0xc0e77380   ( 477 kB)
> [    0.000000]        .bss : 0xc0e79000 - 0xc16843c4   (8237 kB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> [    0.000000] Running RCU self tests
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000]  RCU lockdep checking is enabled.
> [    0.000000]  Build-time adjustment of leaf fanout to 32.
> [    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 8.00MHz
> (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles:
> 0x1d854df40, max_idle_ns: 440795202120 ns
> [    0.000008] sched_clock: 56 bits at 8MHz, resolution 125ns, wraps every
> 2199023255500ns
> [    0.000024] Switching to timer-based delay loop, resolution 125ns
> [    0.000407] Switching to timer-based delay loop, resolution 41ns
> [    0.000428] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every
> 89478484971ns
> [    0.000446] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff,
> max_idle_ns: 79635851949 ns
> [    0.001792] Console: colour dummy device 80x30
> [    0.001823] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,
> Ingo Molnar
> [    0.001833] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.001842] ... MAX_LOCK_DEPTH:          48
> [    0.001851] ... MAX_LOCKDEP_KEYS:        8191
> [    0.001859] ... CLASSHASH_SIZE:          4096
> [    0.001868] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.001876] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.001885] ... CHAINHASH_SIZE:          32768
> [    0.001894]  memory used by lock dependency info: 5167 kB
> [    0.001902]  per task-struct memory footprint: 1536 bytes
> [    0.001941] Calibrating delay loop (skipped), value calculated using timer
> frequency.. 48.00 BogoMIPS (lpj=240000)
> [    0.001961] pid_max: default: 32768 minimum: 301
> [    0.002241] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.002260] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.004370] CPU: Testing write buffer coherency: ok
> [    0.005229] CPU0: update cpu_capacity 1024
> [    0.005246] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.006103] Setting up static identity map for 0x80100000 - 0x80100070
> [    0.008205] smp: Bringing up secondary CPUs ...
> [    0.010128] smp: Brought up 1 node, 1 CPU
> [    0.010144] SMP: Total of 1 processors activated (48.00 BogoMIPS).
> [    0.010154] CPU: All CPU(s) started in SVC mode.
> [    0.012158] devtmpfs: initialized
> [    0.024554] OF: Duplicate name in lcdif at 30730000, renamed to "display#1"
> [    0.035359] VFP support v0.3: implementor 41 architecture 2 part 30 variant
> 7 rev 5
> [    0.036252] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
> max_idle_ns: 19112604462750000 ns
> [    0.039136] pinctrl core: initialized pinctrl subsystem
> [    0.042908] NET: Registered protocol family 16
> [    0.045638] DMA: preallocated 256 KiB pool for atomic coherent allocations
> [    0.049853] cpuidle: using governor menu
> [    0.050813] No ATAGs?
> [    0.050989] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4
> watchpoint registers.
> [    0.051008] hw-breakpoint: maximum watchpoint size is 8 bytes.
> [    0.061802] imx7d-pinctrl 302c0000.iomuxc-lpsr: no groups defined in
> /soc/aips-bus at 30000000/iomuxc-lpsr at 302c0000
> [    0.062123] imx7d-pinctrl 302c0000.iomuxc-lpsr: initialized IMX pinctrl driver
> [    0.064389] imx7d-pinctrl 30330000.iomuxc: initialized IMX pinctrl driver
> [    0.066365] vdd1p0d: Bringing 0uV into 800000-800000uV
> [    0.161012] vgaarb: loaded
> [    0.161950] SCSI subsystem initialized
> [    0.163192] usbcore: registered new interface driver usbfs
> [    0.163367] usbcore: registered new interface driver hub
> [    0.163633] usbcore: registered new device driver usb
> [    0.164069] 30800000.aips-bus:usbphynop1 supply vcc not found, using
> dummy regulator
> [    0.164552] 30800000.aips-bus:usbphynop3 supply vcc not found, using
> dummy regulator
> [    0.164999] 30800000.aips-bus:usbphynop2 supply vcc not found, using
> dummy regulator
> [    0.167606] i2c i2c-0: IMX I2C adapter registered
> [    0.167668] i2c i2c-0: can't use DMA, using PIO instead.
> [    0.169245] i2c i2c-1: IMX I2C adapter registered
> [    0.169274] i2c i2c-1: can't use DMA, using PIO instead.
> [    0.170155] i2c i2c-2: IMX I2C adapter registered
> [    0.170181] i2c i2c-2: can't use DMA, using PIO instead.
> [    0.171475] i2c i2c-3: IMX I2C adapter registered
> [    0.171503] i2c i2c-3: can't use DMA, using PIO instead.
> [    0.171767] Linux video capture interface: v2.00
> [    0.171998] pps_core: LinuxPPS API ver. 1 registered
> [    0.172010] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo
> Giometti <giometti@linux.it>
> [    0.172060] PTP clock support registered
> [    0.172933] Advanced Linux Sound Architecture Driver Initialized.
> [    0.175522] Bluetooth: Core ver 2.22
> [    0.175616] NET: Registered protocol family 31
> [    0.175628] Bluetooth: HCI device and connection manager initialized
> [    0.175686] Bluetooth: HCI socket layer initialized
> [    0.175715] Bluetooth: L2CAP socket layer initialized
> [    0.175842] Bluetooth: SCO socket layer initialized
> [    0.178541] clocksource: Switched to clocksource arch_sys_counter
> [    0.179127] VFS: Disk quotas dquot_6.6.0
> [    0.179258] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> [    0.207626] NET: Registered protocol family 2
> [    0.209530] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
> [    0.209708] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
> [    0.213338] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.213552] UDP hash table entries: 512 (order: 3, 40960 bytes)
> [    0.214057] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
> [    0.215330] NET: Registered protocol family 1
> [    0.216653] RPC: Registered named UNIX socket transport module.
> [    0.216671] RPC: Registered udp transport module.
> [    0.216682] RPC: Registered tcp transport module.
> [    0.216693] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.221439] futex hash table entries: 512 (order: 3, 32768 bytes)
> [    0.223370] workingset: timestamp_bits=30 max_order=18 bucket_order=0
> [    0.247614] NFS: Registering the id_resolver key type
> [    0.247812] Key type id_resolver registered
> [    0.247827] Key type id_legacy registered
> [    0.247952] jffs2: version 2.2. (NAND) c 2001-2006 Red Hat, Inc.
> [    0.249881] fuse init (API version 7.26)
> [    0.261344] bounce: pool size: 64 pages
> [    0.261432] io scheduler noop registered
> [    0.261446] io scheduler deadline registered
> [    0.261884] io scheduler cfq registered (default)
> [    0.267847] 30730000.lcdif supply lcd not found, using dummy regulator
> [    0.276818] Console: switching to colour frame buffer device 60x34
> [    0.281688] mxsfb 30730000.lcdif: initialized
> [    0.284648] imx-sdma 30bd0000.sdma: Direct firmware load for
> imx/sdma/sdma-imx7d.bin failed with error -2
> [    0.284677] imx-sdma 30bd0000.sdma: external firmware not found, using
> ROM firmware
> [    0.295696] pfuze100-regulator 0-0008: Full layer: 1, Metal layer: 1
> [    0.296512] pfuze100-regulator 0-0008: FAB: 0, FIN: 0
> [    0.296528] pfuze100-regulator 0-0008: pfuze3000 found.
> [    0.322500] 30860000.serial: ttymxc0 at MMIO 0x30860000 (irq = 48,
> base_baud = 15000000) is a IMX
> [    1.157051] console [ttymxc0] enabled
> [    1.163408] [drm] Initialized
> [    1.203254] brd: module loaded
> [    1.225488] loop: module loaded
> [    1.234534] spi_imx 30840000.ecspi: dma setup error -19, use pio
> [    1.242842] spi_imx 30840000.ecspi: probed
> [    1.248271] libphy: Fixed MDIO Bus: probed
> [    1.253553] CAN device driver interface
> [    1.261039] 30be0000.ethernet supply phy not found, using dummy
> regulator
> [    1.269705] pps pps0: new PPS source ptp0
> [    1.275905] libphy: fec_enet_mii_bus: probed
> [    1.286848] fec 30be0000.ethernet eth0: registered PHC device 0
> [    1.295568] 30bf0000.ethernet supply phy not found, using dummy
> regulator
> [    1.303732] pps pps1: new PPS source ptp1
> [    1.308667] fec 30bf0000.ethernet (unnamed net_device) (uninitialized):
> Invalid MAC address: 00:00:00:00:00:00
> [    1.318728] fec 30bf0000.ethernet (unnamed net_device) (uninitialized):
> Using random MAC address: 4a:b0:bf:d1:ea:95
> [    1.357434] libphy: fec_enet_mii_bus: probed
> [    1.364546] fec 30bf0000.ethernet eth1: registered PHC device 1
> [    1.372174] usbcore: registered new interface driver asix
> [    1.377707] usbcore: registered new interface driver ax88179_178a
> [    1.384040] usbcore: registered new interface driver cdc_ether
> [    1.390092] usbcore: registered new interface driver net1080
> [    1.395871] usbcore: registered new interface driver cdc_subset
> [    1.402009] usbcore: registered new interface driver zaurus
> [    1.407773] usbcore: registered new interface driver cdc_ncm
> [    1.413470] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.420028] ehci-pci: EHCI PCI platform driver
> [    1.424599] ehci-mxc: Freescale On-Chip EHCI Host driver
> [    1.430617] usbcore: registered new interface driver usb-storage
> [    1.450973] ci_hdrc ci_hdrc.1: EHCI Host Controller
> [    1.456066] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number
> 1
> [    1.488565] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
> [    1.497911] hub 1-0:1.0: USB hub found
> [    1.502000] hub 1-0:1.0: 1 port detected
> [    1.510167] mousedev: PS/2 mouse device common for all mice
> [    1.517757] input: 30370000.snvs:snvs-powerkey as
> /devices/platform/soc/30000000.aips-
> bus/30370000.snvs/30370000.snvs:snvs-powerkey/input/input0
> [    1.532589] spi2.0 supply vcc not found, using dummy regulator
> [    1.540513] ads7846 spi2.0: touchscreen, irq 125
> [    1.547256] input: ADS7846 Touchscreen as
> /devices/platform/soc/30800000.aips-
> bus/30840000.ecspi/spi_master/spi2/spi2.0/input/input1
> [    1.564931] snvs_rtc 30370000.snvs:snvs-rtc-lp: rtc core: registered
> 30370000.snvs:snvs- as rtc0
> [    1.574029] i2c /dev entries driver
> [    1.580631] IR NEC protocol handler initialized
> [    1.585179] IR RC5(x/sz) protocol handler initialized
> [    1.590283] IR RC6 protocol handler initialized
> [    1.594824] IR JVC protocol handler initialized
> [    1.599389] IR Sony protocol handler initialized
> [    1.604017] IR SANYO protocol handler initialized
> [    1.610600] IR Sharp protocol handler initialized
> [    1.615322] IR MCE Keyboard/mouse protocol handler initialized
> [    1.621201] IR XMP protocol handler initialized
> [    1.631500] imx2-wdt 30280000.wdog: timeout 60 sec (nowayout=0)
> [    1.637696] Bluetooth: HCI UART driver ver 2.3
> [    1.642202] Bluetooth: HCI UART protocol H4 registered
> [    1.647348] Bluetooth: HCI UART protocol LL registered
> [    1.653393] sdhci: Secure Digital Host Controller Interface driver
> [    1.659611] sdhci: Copyright(c) Pierre Ossman
> [    1.663976] sdhci-pltfm: SDHCI platform and OF driver helper
> [    1.670937] sdhci-esdhc-imx 30b40000.usdhc: could not get ultra high speed
> state, work on normal mode
> [    1.680273] sdhci-esdhc-imx 30b40000.usdhc: Got CD GPIO
> [    1.685545] sdhci-esdhc-imx 30b40000.usdhc: Got WP GPIO
> [    1.758947] mmc0: SDHCI controller on 30b40000.usdhc [30b40000.usdhc]
> using ADMA
> [    1.838569] mmc1: SDHCI controller on 30b60000.usdhc [30b60000.usdhc]
> using ADMA
> [    1.850293] mmc0: new high speed SDHC card at address e624
> [    1.860698] usbcore: registered new interface driver usbhid
> [    1.866286] usbhid: USB HID core driver
> [    1.877648] mmcblk0: mmc0:e624 SP32G 29.7 GiB
> [    1.913790]  mmcblk0: p1 p2 p3
> [    1.939158] NET: Registered protocol family 10
> [    1.946884] Segment Routing with IPv6
> [    1.951100] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [    1.959268] NET: Registered protocol family 17
> [    1.963761] can: controller area network core (rev 20120528 abi 9)
> [    1.970659] NET: Registered protocol family 29
> [    1.975123] can: raw protocol (rev 20120528)
> [    1.979640] can: broadcast manager protocol (rev 20161123 t)
> [    1.985322] random: fast init done
> [    1.988865] can: netlink gateway (rev 20130117) max_hops=1
> [    1.996238] Key type dns_resolver registered
> [    2.000811] Registering SWP/SWPB emulation handler
> [    2.044154] mmc1: Tuning failed, falling back to fixed sampling clock
> [    2.280559] mmc1: new HS400 MMC card at address 0001
> [    2.288546] snvs_rtc 30370000.snvs:snvs-rtc-lp: setting system clock to 2016-
> 09-17 01:55:14 UTC (1474077314)
> [    2.299217] mmcblk1: mmc1:0001 R1J55A 7.28 GiB
> [    2.304478] mmcblk1boot0: mmc1:0001 R1J55A partition 1 2.00 MiB
> [    2.317943] Unable to handle kernel NULL pointer dereference at virtual
> address 00000008
> [    2.326160] pgd = c0004000
> [    2.328925] [00000008] *pgd=00000000
> [    2.332523] Internal error: Oops: 5 [#1] SMP ARM
> [    2.337148] Modules linked in:
> [    2.340219] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.10.0-rc7-00065-
> g926af627 #1106
> [    2.348140] Hardware name: Freescale i.MX7 Dual (Device Tree)
> [    2.353893] task: ef078000 task.stack: ef06a000
> [    2.358439] PC is at phy_attach_direct+0x48/0x1a0
> [    2.363152] LR is at phy_connect_direct+0x1c/0x54
> [    2.367865] pc : [<c05dc10c>]    lr : [<c05dc34c>]    psr: 60000013
> [    2.367865] sp : ef06bcd8  ip : ef06bd08  fp : ef06bd04
> [    2.379349] r10: 00000000  r9 : 00000007  r8 : ee92d000
> [    2.384581] r7 : 00000000  r6 : ef047000  r5 : c05e4ef8  r4 : ee92d400
> [    2.391115] r3 : 00000000  r2 : c0e42694  r1 : ef154810  r0 : 00000000
> [    2.397650] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment
> none
> [    2.404792] Control: 10c5387d  Table: 8000406a  DAC: 00000051
> [    2.410544] Process swapper/0 (pid: 1, stack limit = 0xef06a210)
> [    2.416557] Stack: (0xef06bcd8 to 0xef06c000)
> [    2.420923] bcc0:                                                       00000007 ee92d400
> [    2.429111] bce0: c05e4ef8 c05e4ef8 00000000 ef038818 00000200 ef038000
> ef06bd24 ef06bd08
> [    2.437300] bd00: c05dc34c c05dc0d0 00000007 ee92d400 c05e4ef8 ef047000
> ef06bd44 ef06bd28
> [    2.445489] bd20: c0703764 c05dc33c f0e9bfe0 ef047000 00000000 c164bc1c
> ef06bdac ef06bd48
> [    2.453678] bd40: c05e6be8 c0703730 00000007 c07828dc 00000003 ef047634
> 0000000d ef047000
> [    2.461867] bd60: 00001002 00000000 ef06bd8c ef06bd78 c0149490 c014930c
> 00000000 c0171868
> [    2.470055] bd80: ef06bdac ef047000 00000000 c0a67700 ef047030 00000000
> c0d6bb54 c0d6bb54
> [    2.478244] bda0: ef06bdd4 ef06bdb0 c0779550 c05e694c ef06bdd4 ef047000
> ef047000 00000001
> [    2.486433] bdc0: 00001003 00001002 ef06bdfc ef06bdd8 c0779808 c07794ac
> 00000000 ef047000
> [    2.494621] bde0: ef047138 00001002 c0d6bb64 00000000 ef06be24 ef06be00
> c07798ec c0779784
> [    2.502810] be00: 00000000 ef047000 00000001 00001002 c0d6bb64 c0d6bb54
> ef06bedc ef06be28
> [    2.510998] be20: c0d54e5c c07798d8 00000000 00000000 00000000 00000000
> ef078000 c0e6fdd0
> [    2.519186] be40: ef06be9c ef06be50 c0173c68 00000002 c0e6d240 c0171dc0
> 00000001 00000000
> [    2.527375] be60: 00000000 c07dded4 c07ddf20 60000013 00000000 c0e6fdc0
> 00000000 00000000
> [    2.535564] be80: c0e79000 c0d5f854 60000013 c0e6fdc0 ef06beb4 ef06bea0
> c0983ce0 c017694c
> [    2.543753] bea0: c0e09cf0 c0e6fdc0 ef06becc ef06beb8 c07ddf20 00000007
> c0d54c9c 00000000
> [    2.551941] bec0: c0e79000 c0d5f854 c0d5f858 c0d00608 ef06bf4c ef06bee0
> c010194c c0d54ca8
> [    2.560130] bee0: c0d00624 c04056e0 00000000 c0cccac4 c0a2214c 000000ed
> ef06bf4c ef06bf08
> [    2.568318] bf00: c01472b8 c0d00614 00000007 00000007 00000000 c0ccb840
> c0bcda7c 00000000
> [    2.576507] bf20: 600000d3 00000007 c0e79000 00000007 c0e79000 c0d72d50
> c0d5f854 c0d5f858
> [    2.584695] bf40: ef06bf94 ef06bf50 c0d00e48 c0101914 00000007 00000007
> 00000000 c0d00608
> [    2.592884] bf60: 7d7f9eeb 000000ed c097adfc 00000000 c097adfc 00000000
> 00000000 00000000
> [    2.601072] bf80: 00000000 00000000 ef06bfac ef06bf98 c097ae0c c0d00d24
> ef06a000 00000000
> [    2.609260] bfa0: 00000000 ef06bfb0 c0107f30 c097ae08 00000000 00000000
> 00000000 00000000
> [    2.617448] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000
> [    2.625636] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 7bffaa1f ffdbaebe
> [    2.633816] Backtrace:
> [    2.636282] [<c05dc0c4>] (phy_attach_direct) from [<c05dc34c>]
> (phy_connect_direct+0x1c/0x54)
> [    2.644819]  r10:ef038000 r9:00000200 r8:ef038818 r7:00000000 r6:c05e4ef8
> r5:c05e4ef8
> [    2.652656]  r4:ee92d400 r3:00000007
> [    2.656246] [<c05dc330>] (phy_connect_direct) from [<c0703764>]
> (of_phy_connect+0x40/0x64)
> [    2.664519]  r6:ef047000 r5:c05e4ef8 r4:ee92d400 r3:00000007
> [    2.670193] [<c0703724>] (of_phy_connect) from [<c05e6be8>]
> (fec_enet_open+0x2a8/0x49c)
> [    2.678207]  r7:c164bc1c r6:00000000 r5:ef047000 r4:f0e9bfe0
> [    2.683882] [<c05e6940>] (fec_enet_open) from [<c0779550>]
> (__dev_open+0xb0/0x118)
> [    2.691464]  r10:c0d6bb54 r9:c0d6bb54 r8:00000000 r7:ef047030 r6:c0a67700
> r5:00000000
> [    2.699298]  r4:ef047000
> [    2.701844] [<c07794a0>] (__dev_open) from [<c0779808>]
> (__dev_change_flags+0x90/0x154)
> [    2.709858]  r7:00001002 r6:00001003 r5:00000001 r4:ef047000
> [    2.715529] [<c0779778>] (__dev_change_flags) from [<c07798ec>]
> (dev_change_flags+0x20/0x50)
> [    2.723979]  r8:00000000 r7:c0d6bb64 r6:00001002 r5:ef047138 r4:ef047000
> r3:00000000
> [    2.731737] [<c07798cc>] (dev_change_flags) from [<c0d54e5c>]
> (ip_auto_config+0x1c0/0x1038)
> [    2.740100]  r8:c0d6bb54 r7:c0d6bb64 r6:00001002 r5:00000001 r4:ef047000
> r3:00000000
> [    2.747857] [<c0d54c9c>] (ip_auto_config) from [<c010194c>]
> (do_one_initcall+0x44/0x17c)
> [    2.755960]  r10:c0d00608 r9:c0d5f858 r8:c0d5f854 r7:c0e79000 r6:00000000
> r5:c0d54c9c
> [    2.763795]  r4:00000007
> [    2.766344] [<c0101908>] (do_one_initcall) from [<c0d00e48>]
> (kernel_init_freeable+0x130/0x1f8)
> [    2.775053]  r9:c0d5f858 r8:c0d5f854 r6:c0d72d50 r5:c0e79000 r4:00000007
> [    2.781769] [<c0d00d18>] (kernel_init_freeable) from [<c097ae0c>]
> (kernel_init+0x10/0x120)
> [    2.790044]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000
> r5:c097adfc
> [    2.797879]  r4:00000000
> [    2.800428] [<c097adfc>] (kernel_init) from [<c0107f30>]
> (ret_from_fork+0x14/0x24)
> [    2.808005]  r4:00000000 r3:ef06a000
> [    2.811592] Code: ebef38e7 e3500000 0a00004c e594307c (e5930008)
> [    2.817775] ---[ end trace dc93a7888190508a ]---
> [    2.822872] mmcblk1boot1: mmc1:0001 R1J55A partition 2 2.00 MiB
> [    2.829281] mmcblk1rpmb: mmc1:0001 R1J55A partition 3 128 KiB
> [    2.839166] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    2.839166]
> [    2.848329] ---[ end Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> 
> Regards
> Dong Aisheng
