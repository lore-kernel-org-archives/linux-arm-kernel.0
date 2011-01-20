From: bjorn.forsman@gmail.com (=?UTF-8?Q?Bj=C3=B8rn_Forsman?=)
Date: Thu, 20 Jan 2011 20:18:10 +0100
Subject: [Openpxa-users] Linux udelay() is way off
In-Reply-To: <20110120175551.GG6335@n2100.arm.linux.org.uk>
References: <AANLkTin_cCzNWhJnD=A2h1qiKpeUrnPrSZPs_Kmfjjd1@mail.gmail.com>
	<201101201800.04289.marek.vasut@gmail.com>
	<20110120175551.GG6335@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin8UR_1kU=+Dw-O9zHahquGJvBC560nByO=F6YV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2011 18:55, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jan 20, 2011 at 06:00:04PM +0100, Marek Vasut wrote:
>> On Thursday 20 January 2011 17:09:00 Bj?rn Forsman wrote:
>> > Hi,
>> >
>> > On my Colibri PXA310, I see that Linux udelay() is only 30 % of the
>> > length it's supposed to. This is way off and cause problems (e.g.
>> > 1-Wire device driver breaks). I'm running OpenPXA bootloaders (OBM2 +
>> > U-Boot) and mainline Linux 2.6.36.
>> >
>> > Any ideas how to fix this?
>> >
>> > Could it be that U-Boot sets up the system clock to something
>> > different than what Linux "expects" so that loops_per_jiffy becomes
>> > wrong? I see some clock setup in <u-boot-pxa>/arch/arm/cpu/pxa/start.S
>> > but I'm not sure what to do with it (yet). I'd like to try out
>> > different clock speeds to see if it helps. Any pointers?
>> >
>> > I also have a workaround in mind: Try out different lpj= settings on
>> > the kernel command line until a udelay(1000) actually is 1000 us. Is
>> > this a sane thing to do?
>>
>> CCing relevant people.
>>
>> And no, linux kernel should derive it's timing properly so it's a kernel bug.
>
> I recently looked into the udelay() timing accuracy, and I saw it only
> being reduced by .7% at boot time - due to the cycles stolen by the timer
> IRQ handler.
>
> The delay calibration algorithm shouldn't produce big errors due to the
> way it works. ?It first tries to find a delay longer than the timer tick.
> It then uses a successive approximation technique over about 9 bits of
> loops_per_jiffy value.
>
> So, I wouldn't expect the boot time lpj value to be significantly out.
>
> However, what might be happening is you boot at X MHz. ?You then use cpufreq
> and drop the frequency to Y MHz. ?You then suspend and resume. ?On resume,
> the boot loader starts the processor again at X MHz, but the kernel still
> assumes that you're running at Y MHz and has not adjusted the delay loop
> accordingly.
>
> This will result in a much shorter than expected delay.
>
> So, the first thing that needs doing is to ascertain when the delay
> becomes wrong.

I'm not doing any suspend/resume stuff.

But I did have cpufreq enabled (using default 'performance' governor).
Disabling cpufreq makes udelay() correct. Yay!

In order to try diagnosing the problem I re-enabled cpufreq and booted
with cpufreq.debug=7.

Here is dmesg | grep -E freq\|performance:

[    0.000000] Kernel command line: console=ttyS0,115200 root=/dev/nfs
nfsroot=10.1.11.41:/srv/nfs ip=dhcp video=pxafb:vmem:4M consoleblank=0
cpufreq.debug=7
[   11.422325] cpufreq-core: trying to register driver pxa3xx-cpufreq
[   11.422491] cpufreq-core: adding CPU 0
[   11.422636] freq-table: table entry 0: 104000 kHz, 0 index
[   11.422758] freq-table: table entry 1: 208000 kHz, 1 index
[   11.422876] freq-table: table entry 2: 416000 kHz, 2 index
[   11.422995] freq-table: table entry 3: 624000 kHz, 3 index
[   11.423630] cpufreq-core: setting new policy for CPU 0: 104000 - 624000 kHz
[   11.423777] freq-table: request for verification of policy (104000
- 624000 kHz) for cpu 0
[   11.423932] freq-table: verification lead to (104000 - 624000 kHz) for cpu 0
[   11.424074] freq-table: request for verification of policy (104000
- 624000 kHz) for cpu 0
[   11.424223] freq-table: verification lead to (104000 - 624000 kHz) for cpu 0
[   11.424356] cpufreq-core: new min and max freqs are 104000 - 624000 kHz
[   11.424464] cpufreq-core: governor switch
[   11.424567] cpufreq-core: __cpufreq_governor for CPU 0, event 1
[   11.424689] performance: setting to 624000 kHz because of event 1
[   11.424817] cpufreq-core: target for CPU 0: 624000 kHz, relation 1
[   11.424952] freq-table: request for target 624000 kHz (relation: 1) for cpu 0
[   11.425091] freq-table: target is 3 (624000 kHz, 3)
[   11.425207] cpufreq-core: notification 0 of frequency transition to
624000 kHz
[   11.425363] cpufreq-core: saving 518144 as reference value for
loops_per_jiffy; freq is 312000 kHz
[   11.425523] cpufreq-core: scaling loops_per_jiffy to 1036288 for
frequency 624000 kHz
[   11.425659] cpufreq-core: notification 1 of frequency transition to
624000 kHz
[   11.425681] cpufreq-core: FREQ: 624000 - CPU: 0
[   11.425698] cpufreq-core: governor: change or update limits
[   11.425717] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[   11.425738] performance: setting to 624000 kHz because of event 3
[   11.425760] cpufreq-core: target for CPU 0: 624000 kHz, relation 1
[   11.425781] freq-table: request for target 624000 kHz (relation: 1) for cpu 0
[   11.425804] freq-table: target is 3 (624000 kHz, 3)
[   11.426249] cpufreq-core: initialization complete
[   11.426285] cpufreq-core: driver pxa3xx-cpufreq up and running
[   13.177169] cpufreq-core: updating policy for CPU 0
[   13.177214] cpufreq-core: setting new policy for CPU 0: 104000 - 624000 kHz
[   13.177242] freq-table: request for verification of policy (104000
- 624000 kHz) for cpu 0
[   13.177271] freq-table: verification lead to (104000 - 624000 kHz) for cpu 0
[   13.177302] freq-table: request for verification of policy (104000
- 624000 kHz) for cpu 0
[   13.177328] freq-table: verification lead to (104000 - 624000 kHz) for cpu 0
[   13.177353] cpufreq-core: new min and max freqs are 104000 - 624000 kHz
[   13.177373] cpufreq-core: governor: change or update limits
[   13.177395] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[   13.177417] performance: setting to 624000 kHz because of event 3
[   13.177440] cpufreq-core: target for CPU 0: 624000 kHz, relation 1
[   13.177465] freq-table: request for target 624000 kHz (relation: 1) for cpu 0
[   13.177491] freq-table: target is 3 (624000 kHz, 3)

See attached dmesg.txt for full output.

The kernel ends up with

Calibrating delay loop... 103.62 BogoMIPS (lpj=518144)

in both cases (with/without cpufreq).

Best regards,
Bj?rn Forsman
-------------- next part --------------
[    0.000000] Linux version 2.6.36-00038-g92080b9 (bjornfor at bjornfor-desktop) (gcc version 4.3.5 (Buildroot 2010.11-git) ) #3 PREEMPT Thu Jan 20 19:41:51 CET 2011
[    0.000000] CPU: XScale-V3 based processor [69056892] revision 2 (ARMv5TE), cr=0000397f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Toradex Colibri PXA300
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] RO Mode clock: 60.00MHz (inactive)
[    0.000000] Run Mode clock: 312.00MHz (*24)
[    0.000000] Turbo Mode clock: 624.00MHz (*2, inactive)
[    0.000000] HSIO bus clock: 312.00MHz
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c03f1484, node_mem_map c0448000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32512 pages, LIFO batch:7
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: console=ttyS0,115200 root=/dev/nfs nfsroot=10.1.11.41:/srv/nfs ip=dhcp video=pxafb:vmem:4M consoleblank=0 cpufreq.debug=7
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 128MB = 128MB total
[    0.000000] Memory: 125568k/125568k available, 5504k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xc8800000 - 0xe8000000   ( 504 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0029000   ( 132 kB)
[    0.000000]       .text : 0xc0029000 - 0xc03ce000   (3732 kB)
[    0.000000]       .data : 0xc03ce000 - 0xc03f1ba0   ( 143 kB)
[    0.000000] SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Preemptable hierarchical RCU implementation.
[    0.000000] 	RCU-based detection of stalled CPUs is disabled.
[    0.000000] 	Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:288
[    0.000000] Console: colour dummy device 80x30
[   10.834173] Calibrating delay loop... 103.62 BogoMIPS (lpj=518144)
[   11.014293] pid_max: default: 32768 minimum: 301
[   11.014769] Mount-cache hash table entries: 512
[   11.016528] CPU: Testing write buffer coherency: ok
[   11.020107] devtmpfs: initialized
[   11.042976] NET: Registered protocol family 16
[   11.090264] colibri_pxa3xx_init_eth(): no valid serial boot tag found, taking MAC from device
[   11.092588] colibri_pxa3xx_init_eth(): no valid serial boot tag found, taking MAC from device
[   11.218487] bio: create slab <bio-0> at 0
[   11.229147] SCSI subsystem initialized
[   11.232169] usbcore: registered new interface driver usbfs
[   11.234980] usbcore: registered new interface driver hub
[   11.236852] usbcore: registered new device driver usb
[   11.244693] I2C: i2c-0: PXA I2C adapter
[   11.256367] Switching to clocksource oscr0
[   11.411734] NET: Registered protocol family 2
[   11.412437] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[   11.413961] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[   11.414750] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[   11.415257] TCP: Hash tables configured (established 4096 bind 4096)
[   11.415360] TCP reno registered
[   11.415462] UDP hash table entries: 256 (order: 0, 4096 bytes)
[   11.415663] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[   11.416416] NET: Registered protocol family 1
[   11.419072] RPC: Registered udp transport module.
[   11.419190] RPC: Registered tcp transport module.
[   11.419277] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   11.422325] cpufreq-core: trying to register driver pxa3xx-cpufreq
[   11.422491] cpufreq-core: adding CPU 0
[   11.422636] freq-table: table entry 0: 104000 kHz, 0 index
[   11.422758] freq-table: table entry 1: 208000 kHz, 1 index
[   11.422876] freq-table: table entry 2: 416000 kHz, 2 index
[   11.422995] freq-table: table entry 3: 624000 kHz, 3 index
[   11.423083] CPUFREQ support for PXA3xx initialized
[   11.423630] cpufreq-core: setting new policy for CPU 0: 104000 - 624000 kHz
[   11.423777] freq-table: request for verification of policy (104000 - 624000 kHz) for cpu 0
[   11.423932] freq-table: verification lead to (104000 - 624000 kHz) for cpu 0
[   11.424074] freq-table: request for verification of policy (104000 - 624000 kHz) for cpu 0
[   11.424223] freq-table: verification lead to (104000 - 624000 kHz) for cpu 0
[   11.424356] cpufreq-core: new min and max freqs are 104000 - 624000 kHz
[   11.424464] cpufreq-core: governor switch
[   11.424567] cpufreq-core: __cpufreq_governor for CPU 0, event 1
[   11.424689] performance: setting to 624000 kHz because of event 1
[   11.424817] cpufreq-core: target for CPU 0: 624000 kHz, relation 1
[   11.424952] freq-table: request for target 624000 kHz (relation: 1) for cpu 0
[   11.425091] freq-table: target is 3 (624000 kHz, 3)
[   11.425207] cpufreq-core: notification 0 of frequency transition to 624000 kHz
[   11.425363] cpufreq-core: saving 518144 as reference value for loops_per_jiffy; freq is 312000 kHz
[   11.425523] cpufreq-core: scaling loops_per_jiffy to 1036288 for frequency 624000 kHz
[   11.425659] cpufreq-core: notification 1 of frequency transition to 624000 kHz
[   11.425681] cpufreq-core: FREQ: 624000 - CPU: 0
[   11.425698] cpufreq-core: governor: change or update limits
[   11.425717] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[   11.425738] performance: setting to 624000 kHz because of event 3
[   11.425760] cpufreq-core: target for CPU 0: 624000 kHz, relation 1
[   11.425781] freq-table: request for target 624000 kHz (relation: 1) for cpu 0
[   11.425804] freq-table: target is 3 (624000 kHz, 3)
[   11.426249] cpufreq-core: initialization complete
[   11.426285] cpufreq-core: driver pxa3xx-cpufreq up and running
[   11.426306] NetWinder Floating Point Emulator V0.97 (double precision)
[   11.430543] JFFS2 version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
[   11.431042] msgmni has been set to 245
[   11.432666] io scheduler noop registered
[   11.432697] io scheduler deadline registered
[   11.432739] io scheduler cfq registered (default)
[   11.470434] Console: switching to colour frame buffer device 100x37
[   12.276781] pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq = 22) is a FFUART
[   12.657045] console [ttyS0] enabled
[   12.662430] pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 21) is a BTUART
[   12.671456] pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 20) is a STUART
[   12.716603] NAND device: Manufacturer ID: 0xec, Chip ID: 0xdc (Samsung NAND 512MiB 3,3V 8-bit)
[   12.725823] Bad block table found at page 262080, version 0x01
[   12.726664] Bad block table found at page 262016, version 0x01
[   12.727100] nand_read_bbt: Bad block at 0x000001480000
[   12.727119] nand_read_bbt: Bad block at 0x0000014a0000
[   12.727134] nand_read_bbt: Bad block at 0x0000014c0000
[   12.727149] nand_read_bbt: Bad block at 0x0000014e0000
[   12.727165] nand_read_bbt: Bad block at 0x000001500000
[   12.727180] nand_read_bbt: Bad block at 0x000001520000
[   12.727196] nand_read_bbt: Bad block at 0x000001540000
[   12.727211] nand_read_bbt: Bad block at 0x000001560000
[   12.727227] nand_read_bbt: Bad block at 0x000001580000
[   12.727243] nand_read_bbt: Bad block at 0x0000015a0000
[   12.727258] nand_read_bbt: Bad block at 0x0000015c0000
[   12.727274] nand_read_bbt: Bad block at 0x0000015e0000
[   12.727289] nand_read_bbt: Bad block at 0x000001600000
[   12.727305] nand_read_bbt: Bad block at 0x000001620000
[   12.727320] nand_read_bbt: Bad block at 0x000001640000
[   12.727336] nand_read_bbt: Bad block at 0x000001660000
[   12.727472] nand_read_bbt: Bad block at 0x00001e720000
[   12.727617] Creating 6 MTD partitions on "NAND 512MiB 3,3V 8-bit":
[   12.733793] 0x000000000000-0x000000100000 : "bootloader (read-only)"
[   12.744713] 0x000000100000-0x000001100000 : "kernel (read-only)"
[   12.755315] 0x000001100000-0x000002100000 : "kernel"
[   12.764900] 0x000002100000-0x000010700000 : "rootfs"
[   12.774960] 0x000010700000-0x00001ed00000 : "spare"
[   12.784986] 0x00001ed00000-0x000020000000 : "Bad Block Table"
[   12.798200] ax88796 ax88796.0: 16bit, irq 122, c887c000, MAC: 00:11:22:33:44:24
[   12.807141] ax88796 ax88796.1: 16bit, irq 210, c88b6000, MAC: 00:00:00:00:00:24
[   12.819055] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   12.825221] ohci_hcd: block sizes: ed 64 td 64
[   12.825381] In ohci_hcd_pxa27x_drv_probe
[   12.825581] pxa27x-ohci pxa27x-ohci: PXA27x OHCI
[   12.830620] drivers/usb/core/inode.c: creating file 'devices'
[   12.830669] drivers/usb/core/inode.c: creating file '001'
[   12.831981] pxa27x-ohci pxa27x-ohci: new USB bus registered, assigned bus number 1
[   12.839865] pxa27x-ohci pxa27x-ohci: irq 3, io mem 0x4c000000
[   12.845590] pxa27x-ohci pxa27x-ohci: ohci_pxa27x_start, ohci:c7a054dc
[   12.845720] pxa27x-ohci pxa27x-ohci: created debug files
[   12.899228] pxa27x-ohci pxa27x-ohci: OHCI controller state
[   12.899264] pxa27x-ohci pxa27x-ohci: OHCI 1.0, NO legacy support registers
[   12.899294] pxa27x-ohci pxa27x-ohci: control 0x083 HCFS=operational CBSR=3
[   12.899319] pxa27x-ohci pxa27x-ohci: cmdstatus 0x00000 SOC=0
[   12.899345] pxa27x-ohci pxa27x-ohci: intrstatus 0x00000004 SF
[   12.899370] pxa27x-ohci pxa27x-ohci: intrenable 0x8000005a MIE RHSC UE RD WDH
[   12.899393] pxa27x-ohci pxa27x-ohci: hcca frame #0003
[   12.899420] pxa27x-ohci pxa27x-ohci: roothub.a 04000202 POTPGT=4 NPS NDP=2(3)
[   12.899444] pxa27x-ohci pxa27x-ohci: roothub.b 00000000 PPCM=0000 DR=0000
[   12.899469] pxa27x-ohci pxa27x-ohci: roothub.status 00008000 DRWE
[   12.899500] pxa27x-ohci pxa27x-ohci: roothub.portstatus [0] 0x00000100 PPS
[   12.899527] pxa27x-ohci pxa27x-ohci: roothub.portstatus [1] 0x00000100 PPS
[   12.899555] pxa27x-ohci pxa27x-ohci: roothub.portstatus [2] 0x00000100 PPS
[   12.899686] usb usb1: default language 0x0409
[   12.899740] usb usb1: udev 1, busnum 1, minor = 0
[   12.899762] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[   12.906576] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.913749] usb usb1: Product: PXA27x OHCI
[   12.917853] usb usb1: Manufacturer: Linux 2.6.36-00038-g92080b9 ohci_hcd
[   12.924509] usb usb1: SerialNumber: pxa27x
[   12.930219] usb usb1: usb_probe_device
[   12.930262] usb usb1: configuration #1 chosen from 1 choice
[   12.930355] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[   12.931071] hub 1-0:1.0: usb_probe_interface
[   12.931109] hub 1-0:1.0: usb_probe_interface - got id
[   12.931130] hub 1-0:1.0: USB hub found
[   12.934910] hub 1-0:1.0: 3 ports detected
[   12.939107] hub 1-0:1.0: standalone hub
[   12.939130] hub 1-0:1.0: no power switching (usb 1.0)
[   12.939148] hub 1-0:1.0: global over-current protection
[   12.939168] hub 1-0:1.0: power on to power good time: 8ms
[   12.939225] hub 1-0:1.0: local power source is good
[   12.939245] hub 1-0:1.0: no over-current condition exists
[   12.939268] hub 1-0:1.0: trying to enable port power on non-switchable hub
[   12.940082] drivers/usb/core/inode.c: creating file '001'
[   12.941378] usbcore: registered new interface driver usblp
[   12.947093] Initializing USB Mass Storage driver...
[   12.952559] usbcore: registered new interface driver usb-storage
[   12.958787] USB Mass Storage support registered.
[   12.963387] pxa27x_udc: version 2008-04-18
[   12.968624] g_ether gadget: using random self ethernet address
[   12.974462] g_ether gadget: using random host ethernet address
[   12.981582] usb0: MAC 0e:86:76:80:dd:3e
[   12.985414] usb0: HOST MAC a2:8d:9a:ce:d5:15
[   12.989942] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[   12.996648] g_ether gadget: g_ether ready
[   13.036694] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[   13.109010] mice: PS/2 mouse device common for all mice
[   13.115691] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[   13.126971] pxa-rtc pxa-rtc: rtc core: registered pxa-rtc as rtc0
[   13.133585] i2c /dev entries driver
[   13.139495] Driver for 1-wire Dallas network protocol.
[   13.177169] cpufreq-core: updating policy for CPU 0
[   13.177214] cpufreq-core: setting new policy for CPU 0: 104000 - 624000 kHz
[   13.177242] freq-table: request for verification of policy (104000 - 624000 kHz) for cpu 0
[   13.177271] freq-table: verification lead to (104000 - 624000 kHz) for cpu 0
[   13.177302] freq-table: request for verification of policy (104000 - 624000 kHz) for cpu 0
[   13.177328] freq-table: verification lead to (104000 - 624000 kHz) for cpu 0
[   13.177353] cpufreq-core: new min and max freqs are 104000 - 624000 kHz
[   13.177373] cpufreq-core: governor: change or update limits
[   13.177395] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[   13.177417] performance: setting to 624000 kHz because of event 3
[   13.177440] cpufreq-core: target for CPU 0: 624000 kHz, relation 1
[   13.177465] freq-table: request for target 624000 kHz (relation: 1) for cpu 0
[   13.177491] freq-table: target is 3 (624000 kHz, 3)
[   13.181540] Registered led device: a
[   13.184429] usbcore: registered new interface driver usbhid
[   13.190197] usbhid: USB HID core driver
[   13.194452] TCP cubic registered
[   13.197939] XScale iWMMXt coprocessor detected.
[   13.208609] pxa-rtc pxa-rtc: setting system clock to 2000-01-01 00:00:14 UTC (946684814)
[   13.344919] mmc0: host does not support reading read-only switch. assuming write-enable.
[   13.353163] mmc0: new SD card at address 8c4f
[   13.358624] mmcblk0: mmc0:8c4f S016B 14.2 MiB 
[   13.365410]  mmcblk0: p1
[   14.736538] Sending DHCP requests .., OK
[   18.676544] IP-Config: Got DHCP answer from 0.0.0.0, my address is 10.1.11.70
[   18.717261] IP-Config: Complete:
[   18.720322]      device=eth0, addr=10.1.11.70, mask=255.255.128.0, gw=10.1.10.20,
[   18.727786]      host=10.1.11.70, domain=creo.dev, nis-domain=(none),
[   18.734182]      bootserver=0.0.0.0, rootserver=10.1.11.41, rootpath=
[   18.741328] Looking up port of RPC 100003/2 on 10.1.11.41
[   18.757623] Looking up port of RPC 100005/1 on 10.1.11.41
[   18.779602] VFS: Mounted root (nfs filesystem) on device 0:15.
[   18.786304] devtmpfs: mounted
[   18.789527] Freeing init memory: 132K
