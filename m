From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Oct 2015 14:24:31 +0200
Subject: [PATCH 1/2] ARM: ux500: add an SMP enablement type and move cpu
 nodes
In-Reply-To: <CAMAWPa_nVyyhXfBm3HvPyVGpodJe_dfM0kX0kO+rPtO9mfkG=w@mail.gmail.com>
References: <1438586801-30115-1-git-send-email-linus.walleij@linaro.org>
 <CAMAWPa_nVyyhXfBm3HvPyVGpodJe_dfM0kX0kO+rPtO9mfkG=w@mail.gmail.com>
Message-ID: <CACRpkdb5eLWZKmbnuPJ1bBrQPqyH0wvh7SjJdVNN7XEiXkKf-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 6:52 AM, Kevin Hilman <khilman@kernel.org> wrote:
> On Mon, Aug 3, 2015 at 12:26 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> The "cpus" node cannot be inside the "soc" node, while this
>> works for the CoreSight blocks, the early boot code will look
>> for "cpus" directly under the root node, so this is a hard
>> convention. So move the CPU nodes.
>>
>> Augment the "reg" property to match what is actually in the
>> hardware: 0x300 and 0x301 respectively.
>>
>> Then add an SMP enablement type to be used by the SMP init
>> code, "ste,dbx500-smp".
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Hi ARM SoC people: please apply this as a fix for v4.2
>> as it is prerequisite for 2/2 which is a more proper fix
>> for the secondary CPU boot regression addressed by the
>> fixed remappings patch.
>
> kernelci.org has had the ste-snowall failing in v4.2 stable[1] for
> awhile, so I finally bisected[2] it down to this patch, which is in
> mainline in the form of commit bf64dd262eaa (ARM: ux500: add an SMP
> enablement type and move cpu nodes).  I confirmed that reverting that
> commit on top of v4.2 gets the snowball booting again.
>
> Kevin
>
> [1] http://kernelci.org/boot/all/job/stable/kernel/v4.2.3/
> [2] https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/102/console

OK I tested the u8500_defconfig and it still works fine on
Snowball. So I have no clue what is causing this :(
(See below for my bootlog.)

- I first thought it was a multiplatform issue but it seems
  not AFAICT from the logs.

- Is the CI boot is using the latest device tree from
  arch/arm/boot/dts/ste-snowball.dts?

Yours,
Linus Walleij

5070] starting kernel at 0x00008000, machine 3293
[    0.000000] Booting Linux on physical CPU 0x300
[    0.000000] Linux version 4.3.0-rc6-00001-gdff502ea54cb
(linus at localhost.localdomain) (gcc version 4.9.3 20150113 (prerelease)
(Linaro GCC 4.95
[    0.000000] CPU: ARMv7 Processor [412fc091] revision 1 (ARMv7), cr=10c5787d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: ST-Ericsson HREF (v60+) and TVK1281618 UIB
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] DB8500 v2.1 [0x008500b1]
[    0.000000] PERCPU: Embedded 11 pages/cpu @dfbb2000 s14464 r8192
d22400 u45056
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 82944
[    0.000000] Kernel command line: cachepolicy=writealloc noinitrd
rdinit=init init=init board_id=1 crashkernel=1M at 0x5600000
logo=logo.nologo st
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 318980K/335872K available (5053K kernel code,
203K rwdata, 1564K rodata, 6420K init, 253K bss, 16892K reserved, 0K
cma-res)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc067e990   (6619 kB)
[    0.000000]       .init : 0xc067f000 - 0xc0cc4000   (6420 kB)
[    0.000000]       .data : 0xc0cc4000 - 0xc0cf6f40   ( 204 kB)
[    0.000000]        .bss : 0xc0cf6f40 - 0xc0d366c4   ( 254 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,
wraps every 65535999984741ns
[    0.000030] clocksource: dbx500-prcmu-timer: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
[    0.000305] clocksource: mtu_0: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 796358519366 ns
[    0.000335] Switching to timer-based delay loop, resolution 416ns
[    0.001495] Console: colour dummy device 80x30
[    0.001525] Calibrating delay loop (skipped), value calculated
using timer frequency.. 4.80 BogoMIPS (lpj=24000)
[    0.001525] pid_max: default: 32768 minimum: 301
[    0.001678] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.001708] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.002380] CPU: Testing write buffer coherency: ok
[    0.002777] CPU0: thread -1, cpu 0, socket 3, mpidr 80000300
[    0.002960] Setting up static identity map for 0x8280 - 0x82d8
[    0.003265] L2C-310 erratum 753970 enabled
[    0.003295] L2C-310 cache controller enabled, 8 ways, 512 kB
[    0.003295] L2C-310: CACHE_ID 0x410000c5, AUX_CTRL 0x7ec60800
[    0.081024] CPU1: thread -1, cpu 1, socket 3, mpidr 80000301
[    0.081085] Brought up 2 CPUs
[    0.081085] SMP: Total of 2 processors activated (9.60 BogoMIPS).
[    0.081085] CPU: All CPU(s) started in SVC mode.
[    0.081756] devtmpfs: initialized
[    0.092559] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 2
[    0.093048] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.093231] pinctrl core: initialized pinctrl subsystem
[    0.094604] NET: Registered protocol family 16
[    0.095489] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.120483] cpuidle: using governor ladder
[    0.150482] cpuidle: using governor menu
[    0.156188] pinctrl-nomadik soc:pinctrl: populate NMK GPIO 0 "gpio"
[    0.156280] pinctrl-nomadik soc:pinctrl: populate NMK GPIO 1 "gpio"
[    0.156311] pinctrl-nomadik soc:pinctrl: populate NMK GPIO 2 "gpio"
[    0.156341] pinctrl-nomadik soc:pinctrl: populate NMK GPIO 3 "gpio"
[    0.156372] pinctrl-nomadik soc:pinctrl: populate NMK GPIO 4 "gpio"
[    0.156402] pinctrl-nomadik soc:pinctrl: populate NMK GPIO 5 "gpio"
[    0.156402] pinctrl-nomadik soc:pinctrl: populate NMK GPIO 6 "gpio"
[    0.156433] pinctrl-nomadik soc:pinctrl: populate NMK GPIO 7 "gpio"
[    0.156463] pinctrl-nomadik soc:pinctrl: populate NMK GPIO 8 "gpio"
[    0.157806] pinctrl-nomadik soc:pinctrl: initialized Nomadik pin
control driver
[    0.158630] PRCMU firmware: U8500(2), version 3.6.1
[    0.159851] ab8500-core ab8500-core.0: detected chip, AB8500 rev. 3.0
[    0.159881] ab8500-core ab8500-core.0: switch off cause(s) (0x4):
[    0.159881]  "Vbat lower then BattOk falling threshold"
[    0.159912] ab8500-core ab8500-core.0: turn on reason(s) (0x20):
[    0.159942] "Vbus Detect (USB)"
[    0.162963] abx500-gpio pinctrl-ab8500.0: added gpiochip
[    0.167572] abx500-gpio pinctrl-ab8500.0: registered pin controller
[    0.167572] abx500-gpio pinctrl-ab8500.0: initialized abx500 pinctrl driver
[    0.168884] DB8500 PRCMU initialized
[    0.175048] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.175048] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.179107] Serial: AMBA PL011 UART driver
[    0.179962] 80120000.uart: ttyAMA0 at MMIO 0x80120000 (irq = 112,
base_baud = 0) is a PL011 rev3
[    0.180908] 80007000.uart: ttyAMA2 at MMIO 0x80007000 (irq = 113,
base_baud = 0) is a PL011 rev3
[    0.733032] console [ttyAMA2] enabled
[    0.737426] abx500-clk abx500-clk.0: register clocks for ab850x
[    0.820983] gpio 8012e000.gpio: at address e08fa000
[    0.826141] gpio 8012e080.gpio: at address e08fc080
[    0.831359] gpio 8000e000.gpio: at address e08fe000
[    0.836486] gpio 8000e080.gpio: at address e0900080
[    0.841674] gpio 8000e100.gpio: at address e0902100
[    0.846832] gpio 8000e180.gpio: at address e0904180
[    0.852050] gpio 8011e000.gpio: at address e0906000
[    0.857208] gpio 8011e080.gpio: at address e0908080
[    0.862365] gpio a03fe000.gpio: at address e090a000
[    0.867889] dma40 801c0000.dma-controller: hardware rev: 3 @
0x801c0000 with 8 physical and 256 logical channels
[    0.878173] dma40 801c0000.dma-controller: 7 of 8 physical DMA
channels available
[    0.885681] dma40 801c0000.dma-controller: [d40_phy_res_init] INFO:
channel 4 is misconfigured (0)
[    0.894653] dma40 801c0000.dma-controller: [d40_phy_res_init] INFO:
channel 5 is misconfigured (0)
[    0.903625] dma40 801c0000.dma-controller: [d40_phy_res_init] INFO:
channel 6 is misconfigured (0)
[    0.943267] dma40 801c0000.dma-controller: initialized
[    0.949249] regulator regulator.21: regulator constraints null pointer
[    0.956207] regulator regulator.22: regulator constraints null pointer
[    0.963226] regulator regulator.23: regulator constraints null pointer
[    0.982208] V-CSI/DSI: Failed to create debugfs directory
[    0.988677] ssp-pl022 80002000.ssp: ARM PL022 driver, device ID: 0x01080022
[    0.996185] ssp-pl022 80002000.ssp: probe: no chip select defined
[    1.002502] ssp-pl022 80003000.ssp: ARM PL022 driver, device ID: 0x01080022
[    1.009460] ssp-pl022 80003000.ssp: probe: no chip select defined
[    1.015686] ssp-pl022 8011a000.spi: ARM PL022 driver, device ID: 0x00080023
[    1.022705] ssp-pl022 8011a000.spi: probe: no chip select defined
[    1.028900] ssp-pl022 80112000.spi: ARM PL022 driver, device ID: 0x00080023
[    1.035858] ssp-pl022 80112000.spi: probe: no chip select defined
[    1.042053] ssp-pl022 80111000.spi: ARM PL022 driver, device ID: 0x00080023
[    1.049011] ssp-pl022 80111000.spi: probe: no chip select defined
[    1.055206] ssp-pl022 80129000.spi: ARM PL022 driver, device ID: 0x00080023
[    1.062164] ssp-pl022 80129000.spi: probe: no chip select defined
[    1.068634] usbcore: registered new interface driver usbfs
[    1.074218] usbcore: registered new interface driver hub
[    1.079620] usbcore: registered new device driver usb
[    1.086120] abx5x0-usb ab8500-usb.0: could not get/set default pinstate
[    1.096282] V-INTCORE: operation not allowed
[    1.100555] abx5x0-usb ab8500-usb.0: Failed to set the Vintcore to
1.3V, ret=-1
[    1.107940] abx5x0-usb ab8500-usb.0: Vintcore is not set to 1.3V volt=1250000
[    1.115142] abx5x0-usb ab8500-usb.0: revision 0x30 driver initialized
[    1.122283] nmk-i2c 80004000.i2c: initialize Nomadik I2C at [mem
0x80004000-0x80004fff] on virtual base e0942000
[    1.133300] tc3589x 0-0044: manufacturer: 0x3, version: 0x80
[    1.139892] tc3589x 0-0044: added gpio block
[    1.144348] tc3589x 0-0044: added keypad block
[    1.149261] nmk-i2c 80122000.i2c: initialize Nomadik I2C at [mem
0x80122000-0x80122fff] on virtual base e0944000
[    1.160003] nmk-i2c 80128000.i2c: initialize Nomadik I2C at [mem
0x80128000-0x80128fff] on virtual base e0946000
[    1.171539] nmk-i2c 80110000.i2c: initialize Nomadik I2C at [mem
0x80110000-0x80110fff] on virtual base e0948000
[    1.182067] nmk-i2c 8012a000.i2c: initialize Nomadik I2C at [mem
0x8012a000-0x8012afff] on virtual base e094a000
[    1.192840] Advanced Linux Sound Architecture Driver Initialized.
[    1.211181] clocksource: Switched to clocksource dbx500-prcmu-timer
[    1.226898] NET: Registered protocol family 2
[    1.231903] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    1.238983] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    1.245574] TCP: Hash tables configured (established 4096 bind 4096)
[    1.252136] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    1.257995] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    1.264465] NET: Registered protocol family 1
[    1.269073] RPC: Registered named UNIX socket transport module.
[    1.275054] RPC: Registered udp transport module.
[    1.279754] RPC: Registered tcp transport module.
[    1.284484] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.630401] Trying to unpack rootfs image as initramfs...
[    1.986999] rootfs image is not initramfs (junk in compressed
archive); looks like an initrd
[    1.995605] Freeing initrd memory: 4K (c1000000 - c1001000)
[    2.002044] hw perfevents: enabled with armv7_cortex_a9 PMU driver,
7 counters available
[    2.011474] futex hash table entries: 512 (order: 3, 32768 bytes)
[    2.029296] io scheduler noop registered
[    2.033325] io scheduler deadline registered
[    2.037628] io scheduler cfq registered (default)
[    2.072479] brd: module loaded
[    2.075866] bh1780 2-0029: Ambient Light Sensor, Rev : 1
[    2.081390] HSI/SSI char device loaded
[    2.087158] musb-hdrc musb-hdrc.0.auto: MUSB HDRC host driver
[    2.093078] musb-hdrc musb-hdrc.0.auto: new USB bus registered,
assigned bus number 1
[    2.101654] hub 1-0:1.0: USB hub found
[    2.105438] hub 1-0:1.0: 1 port detected
[    2.131866] mousedev: PS/2 mouse device common for all mice
[    2.139160] input: tc3589x-keypad as
/devices/soc0/soc/80004000.i2c/i2c-0/0-0044/tc3589x-keypad/input/input0
[    2.152526] input: AB8500 POn(PowerOn) Key as
/devices/soc0/soc/db8500-prcmu/ab8500-core.0/ab8500-poweron-key.0/input/input1
[    2.176818] ab8500-rtc ab8500-rtc.0: rtc core: registered ab8500-rtc as rtc0
[    2.184448] rtc-pl031 80154000.rtc: rtc core: registered pl031 as rtc1
[    2.191772] db8500-thermal db8500-thermal.0: Thermal zone device registered.
[    2.199462] ux500_wdt ux500_wdt: initialized
[    2.204101] dbx500-cpufreq: Available frequencies:
[    2.208892]   200 Mhz
[    2.211151]   400 Mhz
[    2.213439]   800 Mhz
[    2.215728]   1000 Mhz
[    2.218170] cpufreq: cpufreq_online: CPU0: Running at unlisted
freq: 998400 KHz
[    2.225952] cpufreq: cpufreq_online: CPU0: Unlisted initial
frequency changed to: 1000000 KHz
[    2.239410] mmci-pl18x 80126000.sdi0_per1: Got CD GPIO
[    2.245361] V-MMC-SD: supplied by VEXTSUPPLY3
[    2.250610] mmci-pl18x 80126000.sdi0_per1: mmc0: PL180 manf 80 rev4
at 0x80126000 irq 114,0 (pio)
[    2.260223] mmci-pl18x 80126000.sdi0_per1: DMA channels RX
dma0chan0, TX dma0chan1
[    2.305084] mmci-pl18x 80118000.sdi1_per2: No vmmc regulator found
[    2.311492] mmci-pl18x 80118000.sdi1_per2: No vqmmc regulator found
[    2.317901] mmci-pl18x 80118000.sdi1_per2: mmc1: PL180 manf 80 rev4
at 0x80118000 irq 115,0 (pio)
[    2.326904] mmci-pl18x 80118000.sdi1_per2: DMA channels RX
dma0chan2, TX dma0chan3
[    2.375091] mmci-pl18x 80005000.sdi2_per3: No vqmmc regulator found
[    2.381744] mmci-pl18x 80005000.sdi2_per3: mmc2: PL180 manf 80 rev4
at 0x80005000 irq 116,0 (pio)
[    2.391143] mmci-pl18x 80005000.sdi2_per3: DMA channels RX
dma0chan4, TX dma0chan5
[    2.435485] V-eMMC1: supplied by VEXTSUPPLY3
[    2.440277] mmci-pl18x 80114000.sdi4_per2: No vqmmc regulator found
[    2.446899] mmci-pl18x 80114000.sdi4_per2: mmc3: PL180 manf 80 rev4
at 0x80114000 irq 117,0 (pio)
[    2.455963] mmci-pl18x 80114000.sdi4_per2: DMA channels RX
dma0chan6, TX dma0chan7
[    2.473876] mmc0: host does not support reading read-only switch,
assuming write-enable
[    2.482360] mmc0: new SD card at address 8001
[    2.487335] mmcblk0: mmc0:8001 SU512 483 MiB
[    2.493621]  mmcblk0: p1
[    2.507720] mmci-pl18x 80118000.sdi1_per2: card claims to support
voltages below defined range
[    2.516479] mmci-pl18x 80118000.sdi1_per2: no support for card's volts
[    2.523071] mmc1: error -22 whilst initialising MMC card
[    2.542175] lp5521 2-0033: internal clock used
[    2.551757] lp5521 2-0033: lp5521 programmable led chip found
[    2.576232] mmci-pl18x 80118000.sdi1_per2: card claims to support
voltages below defined range
[    2.584869] mmci-pl18x 80118000.sdi1_per2: no support for card's volts
[    2.591522] mmc1: error -22 whilst initialising MMC card
[    2.596862] lp5521 2-0034: internal clock used
[    2.604370] lp5521 2-0034: lp5521 programmable led chip found
[    2.613342] hash1 hash1: successfully registered
[    2.619415] cryp1 cryp1: successfully registered
[    2.625061] usbcore: registered new interface driver usbhid
[    2.630706] usbhid: USB HID core driver
[    2.635223] V-DISPLAY: supplied by VEXTSUPPLY3
[    2.642059] iio iio:device0: registered accelerometer lsm303dlh_accel
[    2.650970] iio iio:device1: registered gyroscope l3g4200d
[    2.658905] iio iio:device2: registered magnetometer lsm303dlh_magn
[    2.666229] iio iio:device3: Full-scale not possible
[    2.672302] iio iio:device3: registered pressure sensor lps001wp
[    2.678771] coresight-tpiu 80190000.tpiu: TPIU initialized
[    2.684875] coresight-etb10 801a4000.etb: ETB initialized
[    2.690673] coresight-funnel 801a6000.funnel: FUNNEL initialized
[    2.697204] coresight-replicator soc:replicator: REPLICATOR initialized
[    2.704467] coresight-etm3x 801ae000.ptm: PTM 1.0 initialized
[    2.710784] coresight-etm3x 801af000.ptm: PTM 1.0 initialized
[    2.717315] mmc2: new high speed MMC card at address 0001
[    2.724121] ux500-msp-i2s ux500-msp-i2s.1: Failed to get DMA
channel capabilities, falling back to period counting: -6
[    2.734893] snd-soc-mop500 snd-soc-mop500.0: ab8500-codec-dai.0 <->
ux500-msp-i2s.1 mapping ok
[    2.743591] mmcblk1: mmc2:0001 002G03 1.84 GiB
[    2.746795] ux500-msp-i2s ux500-msp-i2s.3: Failed to get DMA
channel capabilities, falling back to period counting: -6
[    2.746795] snd-soc-mop500 snd-soc-mop500.0: ab8500-codec-dai.1 <->
ux500-msp-i2s.3 mapping ok
[    2.767944] mmcblk1boot0: mmc2:0001 002G03 partition 1 512 KiB
[    2.774047] mmcblk1boot1: mmc2:0001 002G03 partition 2 512 KiB
[    2.781738] NET: Registered protocol family 10
[    2.786926] sit: IPv6 over IPv4 tunneling driver
[    2.790313] mmcblk1rpmb: mmc2:0001 002G03 partition 3 128 KiB
[    2.798187] NET: Registered protocol family 17
[    2.803527] NET: Registered protocol family 35
[    2.808135] NET: Registered protocol family 37
[    2.813079] Registering SWP/SWPB emulation handler
[    2.830352] input: gpio_keys as /devices/soc0/gpio_keys/input/input2
[    2.838226] ab8500-rtc ab8500-rtc.0: setting system clock to
2000-01-01 01:08:47 UTC (946688927)
[    2.854370] db8500-esram12: disabling
[    2.858123] db8500-esram34: disabling
[    2.862030] V-CSI/DSI: disabling
[    2.865478] ALSA device list:
[    2.868438]   #0: MOP500-card
[    2.871887] uart-pl011 80007000.uart: DMA channel TX dma0chan12
[    2.877807] uart-pl011 80007000.uart: DMA channel RX dma0chan13
[    2.889587] Freeing unused kernel memory: 6420K (c067f000 - c0cc4000)
preparing networking...
[    2.912109] mmc3: new high speed MMC card at address 0001
[    2.921295] mmcblk2: mmc3:0001 008G03 7.37 GiB
[    2.936279] mmcblk2boot0: mmc3:0001 008G03 partition 1 2.00 MiB
ip: SIOCGIFFLAGS: No such device
running rc.d services...
[    2.952728] mmcblk2boot1: mmc3:0001 008G03 partition 2 2.00 MiB
mounting tmpfs at /dev ...done
mounting pts at /dev/pts ...[    2.970336] mmcblk2rpmb: mmc3:0001
008G03 partition 3 128 KiB
[    2.977752]  mmcblk2: p1
