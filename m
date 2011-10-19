From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 19 Oct 2011 20:24:01 +0530
Subject: Getting random Kernel Crash with v3.1-rc8 kernel
Message-ID: <19F8576C6E063C45BE387C64729E739406C100F885@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am getting random kernel crash, and it always crashes with "Internal
 error: Oops - undefined instruction: 0 [#1]".
There could be some stack corruption or race condition in the kernel,
which I am currently debugging on (running out of options).

The funny part is,
        - If I add some line of code (totally unrelated to this crash) and crash goes away.
        - With filesystem on NFS, MMC card (non HS card) and NAND, the crash
is very well reproducible (almost 60% success).
        - With ramdisk, the kernel crash is not observed.
        - The default CPU is freq is 600MHz, if I reduce it to 500Mhz, crash
goes away.


Until now, I could able to find, kernel crashes due to the code execution
jumps to data/bss section from run_timer_softirq function, where it executes
"blx" instruction (for timer callback funtion).
Somehow, the function pointer is getting corrupted and code execution jumps
to invalid section.

The current status is,
The PC is consistently pointing to bss address space, where
"boot_tvec_bases" is located.

I have attached boot-log and assembler output of the function
 "run_timer_softirq", I would appreciate any help of pointers here...


Assembler output of "run_timer_softirq" -
========================================

http://pastebin.com/UcXqEqGs


Boot Log (http://pastebin.com/Ddip5pJj) -
=========================================

## Booting kernel from Legacy Image at 80000000 ...
   Image Name:   Linux-3.1.0-rc8-11589-gbb7fe4f-d
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2884668 Bytes = 2.8 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 3.1.0-rc8-11589-gbb7fe4f-dirty (a0393758 at psplinux060) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #4 Wed Oct 19 13:44:28 IST 2011
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: am335xevm
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] AM335X ES1.0 (neon )
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: console=ttyO0,115200n8 root=/dev/nfs nfsroot=172.24.191.70:/srv/nfs/ti81xx,nolock rw mem=128M ip=dhcp earlyprintk vram=50M
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Memory: 123956k/123956k available, 7116k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffa00000 - 0xffe00000   (   4 MB)
[    0.000000]     vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0523000   (5228 kB)
[    0.000000]       .init : 0xc0523000 - 0xc0559000   ( 216 kB)
[    0.000000]       .data : 0xc055a000 - 0xc05a4640   ( 298 kB)
[    0.000000]        .bss : 0xc05a4664 - 0xc05d07c0   ( 177 kB)
[    0.000000] NR_IRQS:396
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts
[    0.000000] Total of 128 interrupts on 1 active controller
[    0.000000] omap_hwmod: timer1: _wait_target_disable failed
[    0.000000] OMAP clockevent source: GPTIMER1 at 24000000 Hz
[    0.000000] OMAP clocksource: GPTIMER2 at 24000000 Hz
[    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
[    0.000000] Console: colour dummy device 80x30
[    0.000215] Calibrating delay loop... 597.60 BogoMIPS (lpj=2988032)
[    0.058837] pid_max: default: 32768 minimum: 301
[    0.058979] Security Framework initialized
[    0.059049] Mount-cache hash table entries: 512
[    0.059452] CPU: Testing write buffer coherency: ok
[    0.063732] print_constraints: dummy:
[    0.063973] NET: Registered protocol family 16
[    0.064157] GPMC revision 6.0
[    0.065142] OMAP GPIO hardware version 0.1
[    0.065945] omap_l3_smx omap_l3_smx.0: couldn't find resource
[    0.066044] omap_mux_init: Add partition: #1: core, flags: 0
[    0.068248] platform omap_i2c.1: alias fck already exists
[    0.068925] platform omap2_mcspi.1: alias fck already exists
[    0.069031] platform omap2_mcspi.2: alias fck already exists
[    0.076598] bio: create slab <bio-0> at 0
[    0.077502] SCSI subsystem initialized
[    0.078306] usbcore: registered new interface driver usbfs
[    0.078429] usbcore: registered new interface driver hub
[    0.078572] usbcore: registered new device driver usb
[    0.078956] registerd cppi-dma Intr @ IRQ 17
[    0.078972] Cppi41 Init Done Qmgr-base(c883a000) dma-base(c8838000)
[    0.078984] Cppi41 Init Done
[    0.098904] omap_i2c omap_i2c.1: bus 1 rev4.0 at 100 kHz
[    0.099652] Advanced Linux Sound Architecture Driver Version 1.0.24.
[    0.100150] Bluetooth: Core ver 2.16
[    0.100228] NET: Registered protocol family 31
[    0.100240] Bluetooth: HCI device and connection manager initialized
[    0.100259] Bluetooth: HCI socket layer initialized
[    0.100272] Bluetooth: L2CAP socket layer initialized
[    0.100302] Bluetooth: SCO socket layer initialized
[    0.100472] Switching to clocksource gp timer
[    0.107899] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
[    0.108070] musb-hdrc musb-hdrc.0: dma type: dma-cppi41
[    0.108933] Switched to NOHz mode on CPU #0
[    0.109099] musb-hdrc musb-hdrc.0: USB OTG mode controller at c880a000 using DMA, IRQ 18
[    0.109341] musb-hdrc musb-hdrc.1: dma type: dma-cppi41
[    0.110176] musb-hdrc musb-hdrc.1: USB OTG mode controller at c880c800 using DMA, IRQ 19
[    0.110540] NET: Registered protocol family 2
[    0.110747] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.111074] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.111178] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.111244] TCP: Hash tables configured (established 4096 bind 4096)
[    0.111259] TCP reno registered
[    0.111273] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.111301] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.111502] NET: Registered protocol family 1
[    0.111805] RPC: Registered named UNIX socket transport module.
[    0.111822] RPC: Registered udp transport module.
[    0.111832] RPC: Registered tcp transport module.
[    0.111843] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.112098] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.112177] omap_init_opp_table: no hwmod or odev for iva, [8] cannot add OPPs.
[    0.118175] VFS: Disk quotas dquot_6.5.2
[    0.118254] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.118858] JFFS2 version 2.2. (NAND) (SUMMARY)  (c) 2001-2006 Red Hat, Inc.
[    0.119188] msgmni has been set to 242
[    0.120008] io scheduler noop registered
[    0.120024] io scheduler deadline registered
[    0.120102] io scheduler cfq registered (default)
[    0.122664] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.123647] omap_uart.0: ttyO0 at MMIO 0x44e09000 (irq = 72) is a OMAP UART0
[    0.663052] console [ttyO0] enabled
[    0.667025] omap_uart.1: ttyO1 at MMIO 0x48022000 (irq = 73) is a OMAP UART1
[    0.674649] omap_uart.2: ttyO2 at MMIO 0x48024000 (irq = 74) is a OMAP UART2
[    0.682251] omap_uart.3: ttyO3 at MMIO 0x481a6000 (irq = 44) is a OMAP UART3
[    0.689819] omap_uart.4: ttyO4 at MMIO 0x481a8000 (irq = 45) is a OMAP UART4
[    0.697406] omap_uart.5: ttyO5 at MMIO 0x481aa000 (irq = 46) is a OMAP UART5
[    0.710718] brd: module loaded
[    0.717050] loop: module loaded
[    0.720407] at24 1-0051: 32768 byte 24c256 EEPROM, writable, 64 bytes/write
[    0.728351] Detected a daughter card on AM335x EVM..
[    0.733422] at24 1-0050: 32768 byte 24c256 EEPROM, writable, 64 bytes/write
[    0.746758] Board name: A33515B
[    0.750039] SKU: SKU#01
[    0.752754] The board is general purpose EVM in profile 0
[    0.759087] da8xx_lcdc da8xx_lcdc.0: GLCD: Found TFC_S9700RTWV35TR_01B panel
[    0.781319] Console: switching to colour frame buffer device 100x30
[    0.810574] omap_i2c omap_i2c.2: bus 2 rev4.0 at 100 kHz
[    0.816406] omap_i2c omap_i2c.2: alias fck already exists
[    0.822566] platform omap_hsmmc.0: alias fck already exists
[    0.828528] platform omap_hsmmc.2: alias fck already exists
[    0.834422] Enable bluetooth...
[    0.851628] mtdoops: mtd device (mtddev=name/number) must be supplied
[    0.858425] omap2-nand driver initializing
[    0.863118] ONFI flash detected
[    0.866520] ONFI param page 0 valid
[    0.870171] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron MT29F2G08ABAEAWP)
[    0.878580] Creating 8 MTD partitions on "omap2-nand.0":
[    0.884151] 0x000000000000-0x000000020000 : "SPL"
[    0.890194] 0x000000020000-0x000000040000 : "SPL.backup1"
[    0.896790] 0x000000040000-0x000000060000 : "SPL.backup2"
[    0.903342] 0x000000060000-0x000000080000 : "SPL.backup3"
[    0.909877] 0x000000080000-0x000000260000 : "U-Boot"
[    0.916736] 0x000000260000-0x000000280000 : "U-Boot Env"
[    0.923232] 0x000000280000-0x000000780000 : "Kernel"
[    0.931327] 0x000000780000-0x000010000000 : "File System"
[    1.040048] OneNAND driver initializing
[    1.090548] davinci_mdio davinci_mdio.0: davinci mdio revision 1.6
[    1.097013] davinci_mdio davinci_mdio.0: detected phy mask fffffffe
[    1.103958] davinci_mdio90] usbcore: registered new interface driver cdc_ether
[    1.121367] usbcore: registered new interface driver cdc_subset
[    1.127600] Initializing USB Mass Storage driver...
[    1.132793] usbcore: registered new interface driver usb-storage
[    1.139071] USB Mass Storage support registered.
[    1.143988]  gadget: using random self ethernet address
[    1.149456]  gadget: using random host ethernet address
[    1.155422] usb0: MAC d2:16:6c:b9:23:e0
[    1.159430] usb0: HOST MAC ae:1f:2e:83:1e:59
[    1.163985]  gadget: Ethernet Gadget, version: Memorial Day 2008
[    1.170282]  gadget: g_ether ready
[    1.173887] musb-hdrc musb-hdrc.0: MUSB HDRC host driver
[    1.179548] musb-hdrc musb-hdrc.0: new USB bus registered, assigned bus number 1
[    1.187438] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.194548] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.202101] usb usb1: Product: MUSB HDRC host driver
[    1.207287] usb usb1: Manufacturer: Linux 3.1.0-rc8-11589-gbb7fe4f-dirty musb-hcd
[    1.215118] usb usb1: SerialNumber: musb-hdrc.0
[    1.220401] hub 1-0:1.0: USB hub found
[    1.224366] hub 1-0:1.0: 1 port detected
[    1.229089] mousedev: PS/2 mouse device common for all mice
[    1.235760] input: ti-tsc-adcc as /devices/platform/tsc/input/input0
[    1.243399] omap_rtc omap_rtc: rtc core: registered omap_rtc as rtc0
[    1.250133] i2c /dev entries driver
[    1.254771] OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[    1.261161] Bluetooth: HCI UART driver ver 2.2
[    1.265810] Bluetooth: HCI H4 protocol initialized
[    1.270831] Bluetooth: HCILL protocol initialized
[    1.277381] usbcore: registered new interface driver usbhid
[    1.283258] usbhid: USB HID core driver
[    1.287647] usbcore: registered new interface driver snd-usb-audio
[    1.295184] _regulator_get: 2-001b supply IOVDD not found, using dummy regulator
[    1.303034] _regulator_get: 2-001b supply DVDD not found, using dummy regulator
[    1.310729] _regulator_get: 2-001b supply AVDD not found, using dummy regulator
[    1.318410] _regulator_get: 2-001b supply DRVDD not found, using dummy regulator
[    1.421856] mmc0: new SDHC card at address b239
[    1.427150] mmcblk0: mmc0:b239 SU04G 3.69 GiB
[    1.434074]  mmcblk0: p1 p2
[    1.468020] asoc: tlv320aic3x-hifi <-> davinci-mcasp.1 mapping ok
[    1.475099] ALSA device list:
[    1.478208]   #0: AM335X EVM
[    1.481250] nf_conntrack version 0.5.0 (1936 buckets, 7744 max)
[    1.487961] ip_tables: (C) 2000-2006 Netfilter Core Team
[    1.493681] TCP cubic registered
[    1.497057] NET: Registered protocol family 17
[    1.501936] Bluetooth: RFCOMM TTY layer initialized
[    1.507097] Bluetooth: RFCOMM socket layer initialized
[    1.512491] Bluetooth: RFCOMM ver 1.11
[    1.516413] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    1.521982] Bluetooth: BNEP filters: protocol multicast
[    1.527449] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    1.533848] Registering the dns_resolver key type
[    1.538844] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
[    1.546891] ThumbEE CPU extension supported.
[    1.552185] omap2_set_init_voltage: unable to get clk dpll1_ck
[    1.558296] omap2_set_init_voltage: unable to set vdd_mpu_iva
[    1.564333] omap2_set_init_voltage: unable to get clk l3_ick
[    1.570244] omap2_set_init_voltage: unable to set vdd_core
[    1.577381] Detected MACID=40:5f:c2:3e:16:83
[    1.582732] omap_rtc omap_rtc: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
[    1.594588]
[    1.594594] CPSW phy found : id is : 0x4dd074
[    1.601482] PHY 0:01 not found
[    2.130539] Internal error: Oops - undefined instruction: 0 [#1]
[    2.136818] Modules linked in:
[    2.140017] CPU: 0    Not tainted  (3.1.0-rc8-11589-gbb7fe4f-dirty #4)
[    2.146838] PC is at 0xc05b71e8
[    2.150134] LR is at run_timer_softirq+0xf8/0x208
[    2.155050] pc : [<c05b71e8>]    lr : [<c0040980>]    psr: a0000113
[    2.155059] sp : c055be68  ip : c05c96f4  fp : c055beac
[    2.167049] r10: c05b680c  r9 : 00000100  r8 : 00200200
[    2.172506] r7 : c055a000  r6 : ba8c4f60  r5 : c05b6000  r4 : c055be78
[    2.179325] r3 : c05b637c  r2 : c05b636c  r1 : 00000000  r0 : c05b637c
[    2.186146] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    2.193785] Control: 10c5387d  Table: 80004019  DAC: 00000015
[    2.199779] Process swapper (pid: 0, stack limit = 0xc055a2f0)
[    2.205863] Stack: (0xc055be68 to 0xc055c000)
[    2.210414] be60:                   00000000 00000000 c05b637c c05b7ff8 c05c96f4 c781de70
[    2.218958] be80: c05b7ff4 00000001 c05b5e88 c055a000 00000100 c05b5e40 c0576f48 c05b5e84
[    2.227503] bea0: c055bef4 c055beb0 c003ad54 c0040894 c055bf74 80004059 413fc082 00000001
[    2.236059] bec0: c0577154 0000000a c0069360 c055a000 00000043 00000000 c055bf74 80004059
[    2.244611] bee0: 413fc082 00000000 c055bf0c c055bef8 c003b1c4 c003acb4 c006ac78 c0588aa4
[    2.253162] bf00: c055bf2c c055bf10 c00145c8 c003b144 c0014714 c0014718 60000013 fa200000
[    2.261714] bf20: c055bf3c c055bf30 c0008190 c0014590 c055bf94 c055bf40 c00132f4 c000818c
[    2.270270] bf40: 7d2bcf2e 00000000 c055bf88 00000000 c055a000 c05a4744 c056021c c0560214
[    2.278825] bf60: 80004059 413fc082 00000000 c055bf94 c055bf98 c055bf88 c0014714 c0014718
[    2.287378] bf80: 60000013 ffffffff c055bfb4 c055bf98 c00148d8 c00146f8 00000000 c055c0ac
[    2.295933] bfa0: c054bbec c06d1500 c055bfc4 c055bfb8 c03e07c4 c0014870 c055bff4 c055bfc8
[    2.304483] bfc0: c05237d8 c03e075c c05231ac 00000000 00000000 c054bbec 00000000 10c53c7d
[    2.313029] bfe0: c055c040 c054bbe8 00000000 c055bff8 8000803c c0523520 00000000 00000000
[    2.321567] Backtrace:
[    2.324146] [<c0040888>] (run_timer_softirq+0x0/0x208) from [<c003ad54>] (__do_softirq+0xac/0x134)
[    2.333524] [<c003aca8>] (__do_softirq+0x0/0x134) from [<c003b1c4>] (irq_exit+0x8c/0xa4)
[    2.342004] [<c003b138>] (irq_exit+0x0/0xa4) from [<c00145c8>] (handle_IRQ+0x44/0x8c)
[    2.350184]  r4:c0588aa4 r3:c006ac78
[    2.353936] [<c0014584>] (handle_IRQ+0x0/0x8c) from [<c0008190>] (asm_do_IRQ+0x10/0x14)
[    2.362294]  r6:fa200000 r5:60000013 r4:c0014718 r3:c0014714
[    2.368234] [<c0008180>] (asm_do_IRQ+0x0/0x14) from [<c00132f4>] (__irq_svc+0x34/0x80)
[    2.376507] Exception stack(0xc055bf40 to 0xc055bf88)
[    2.381789] bf40: 7d2bcf2e 00000000 c055bf88 00000000 c055a000 c05a4744 c056021c c0560214
[    2.390339] bf60: 80004059 413fc082 00000000 c055bf94 c055bf98 c055bf88 c0014714 c0014718
[    2.398874] bf80: 60000013 ffffffff
[    2.402522] [<c00146ec>] (default_idle+0x0/0x30) from [<c00148d8>] (cpu_idle+0x74/0xa0)
[    2.410905] [<c0014864>] (cpu_idle+0x0/0xa0) from [<c03e07c4>] (rest_init+0x74/0x78)
[    2.418997]  r6:c06d1500 r5:c054bbec r4:c055c0ac r3:00000000
[    2.424950] [<c03e0750>] (rest_init+0x0/0x78) from [<c05237d8>] (start_kernel+0x2c4/0x2d0)
[    2.433592] [<c0523514>] (start_kernel+0x0/0x2d0) from [<8000803c>] (0x8000803c)
[    2.441315]  r6:c054bbe8 r5:c055c040 r4:10c53c7d
[    2.446156] Code: 00000100 c05b6001 c0049608 c05b70b0 (ffffffff)
[    2.452552] ---[ end trace 010eec470f78ac9d ]---
[    2.457377] Kernel panic - not syncing: Fatal exception in interrupt
[    2.464023] Backtrace:
[    2.466602] [<c0016e40>] (dump_backtrace+0x0/0x110) from [<c03e8d88>] (dump_stack+0x18/0x1c)
[    2.475434]  r6:00000001 r5:00000000 r4:c05a5508 r3:c05770c8
[    2.481384] [<c03e8d70>] (dump_stack+0x0/0x1c) from [<c03e8df8>] (panic+0x6c/0x1a0)
[    2.489397] [<c03e8d8c>] (panic+0x0/0x1a0) from [<c0017270>] (die+0x268/0x2bc)
[    2.496953]  r3:00000100 r2:00000000 r1:00000000 r0:c04aba68
[    2.502895]  r7:c055bd32
[    2.505548] [<c0017008>] (die+0x0/0x2bc) from [<c00172e4>] (arm_notify_die+0x20/0x58)
[    2.513749] [<c00172c4>] (arm_notify_die+0x0/0x58) from [<c00082d0>] (do_undefinstr+0x13c/0x154)
[    2.522950] [<c0008194>] (do_undefinstr+0x0/0x154) from [<c0013388>] (__und_svc+0x48/0x60)
[    2.531602] Exception stack(0xc055be20 to 0xc055be68)
[    2.536888] be20: c05b637c 00000000 c05b636c c05b637c c055be78 c05b6000 ba8c4f60 c055a000
[    2.545452] be40: 00200200 00000100 c05b680c c055beac c05c96f4 c055be68 c0040980 c05b71e8
[    2.554009] be60: a0000113 ffffffff
[    2.557651]  r7:00000001 r6:c055a050 r5:a0000113 r4:c05b71ec
[    2.563607] [<c0040888>] (run_timer_softirq+0x0/0x208) from [<c003ad54>] (__do_softirq+0xac/0x134)
[    2.572992] [<c003aca8>] (__do_softirq+0x0/0x134) from [<c003b1c4>] (irq_exit+0x8c/0xa4)
[    2.581466] [<c003b138>] (irq_exit+0x0/0xa4) from [<c00145c8>] (handle_IRQ+0x44/0x8c)
[    2.589645]  r4:c0588aa4 r3:c006ac78
[    2.593404] [<c0014584>] (handle_IRQ+0x0/0x8c) from [<c0008190>] (asm_do_IRQ+0x10/0x14)
[    2.601780]  r6:fa200000 r5:60000013 r4:c0014718 r3:c0014714
[    2.607727] [<c0008180>] (asm_do_IRQ+0x0/0x14) from [<c00132f4>] (__irq_svc+0x34/0x80)
[    2.616014] Exception stack(0xc055bf40 to 0xc055bf88)
[    2.621297] bf40: 7d2bcf2e 00000000 c055bf88 00000000 c055a000 c05a4744 c056021c c0560214
[    2.629833] bf60: 80004059 413fc082 00000000 c055bf94 c055bf98 c055bf88 c0014714 c0014718
[    2.638390] bf80: 60000013 ffffffff
[    2.642054] [<c00146ec>] (default_idle+0x0/0x30) from [<c00148d8>] (cpu_idle+0x74/0xa0)
[    2.650432] [<c0014864>] (cpu_idle+0x0/0xa0) from [<c03e07c4>] (rest_init+0x74/0x78)
[    2.658541]  r6:c06d1500 r5:c054bbec r4:c055c0ac r3:00000000
[    2.664502] [<c03e0750>] (rest_init+0x0/0x78) from [<c05237d8>] (start_kernel+0x2c4/0x2d0)
[    2.673164] [<c0523514>] (start_kernel+0x0/0x2d0) from [<8000803c>] (0x8000803c)
[    2.680909]  r6:c054bbe8 r5:c055c040 r4:10c53c7d


Thanks,
Vaibhav
