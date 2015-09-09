From: holler@ahsoftware.de (Alexander Holler)
Date: Wed,  9 Sep 2015 20:35:23 +0200
Subject: [PATCH 0/2] deps: parallel initialization of (device-)drivers
In-Reply-To: <55E961DA.5040009@ahsoftware.de>
References: <55E961DA.5040009@ahsoftware.de>
Message-ID: <1441823725-8869-1-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

as already mentioned, I've implemented the stuff to initialize drivers
in parallel. What follows are two patches to be used on top of my
already posted series (for 4.2) which implements annotated initcalls
and DT based dependencies.

But be warned: many drivers which are in the same initcall level
still depend on the link order given by the Makefile and directoy
(-name) and therefor will fail. That means without moving them to other
initcall levels or explicit dependencies (which are a TODO) for these
drivers, the whole stuff currently works only for some configurations
and you likely will need to add several patches for your board.

I've already posted two patches to move two drivers into another
initcall level. While playing with the stuff, I've found several
more drivers which are suffering under the same problem and need
the same modification:

block/noop-iosched.c
crypto/hmac.c
cryoto/sha_generic.c
drivers/mtd/ofpart.c
drivers/tty/serial/8250/8250_core.c

To offer an impression how this patch series might work in action,
below is the relevant part from the kernel log for a configuration
I'm using successfully on an imx6q.

Maybe someone has interest in that stuff.

Regards,

Alexander Holler

-----------
(...)
[    2.628325] Thread 0 calling (ordered) initcall for driver reg-fixed-voltage (regulator-fixed)
[    2.629196] Thread 3 calling (ordered) initcall for driver imx6q-pinctrl (fsl,imx6q-iomuxc)
[    2.629331] Thread 0 calling (ordered) initcall for driver gpio-mxc (fsl,imx1-gpio)
[    2.630276] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    2.632543] Thread 0 calling (ordered) initcall for driver anatop_regulator (fsl,anatop-regulator)
[    2.632556] Thread 1 calling (ordered) initcall for driver imx-sdma (fsl,imx6q-sdma)
[    2.632563] Thread 2 calling (ordered) initcall for driver mxs-dma (fsl,imx23-dma-apbh)
[    2.632598] Thread 3 calling (ordered) initcall for driver sram (mmio-sram)
[    2.634502] mxs-dma 110000.dma-apbh: initialized
[    2.634848] Thread 3 calling (ordered) initcall for driver mxs_phy (fsl,imx6sx-usbphy)
[    2.635165] Thread 0 calling (ordered) initcall for driver imx2-wdt (fsl,imx21-wdt)
[    2.635181] Thread 2 calling (ordered) initcall for driver snvs_rtc (fsl,sec-v4.0-mon-rtc-lp)
[    2.635493] snvs_rtc 20cc034.snvs-rtc-lp: rtc core: setting system clock to 2015-09-09 16:37:09 UTC (1441816629)
[    2.635813] snvs_rtc 20cc034.snvs-rtc-lp: rtc core: registered 20cc034.snvs-rtc-lp as rtc0
[    2.635978] Thread 2 calling (ordered) initcall for driver ahci-imx (fsl,imx53-ahci)
[    2.636317] imx-sdma 20ec000.sdma: initialized
[    2.636322] ahci-imx 2200000.sata: fsl,transmit-level-mV not specified, using 00000024
[    2.636332] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not specified, using 00000480
[    2.636338] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not specified, using 00002000
[    2.636347] ahci-imx 2200000.sata: fsl,receive-eq-mdB not specified, using 05000000
[    2.636690] Thread 1 calling (ordered) initcall for driver wandboard-rfkill (wand,imx6q-wandboard-rfkill)
[    2.637160] imx-sdma 20ec000.sdma: loaded firmware 1.1
[    2.637166] imx2-wdt 20bc000.wdog: timeout 60 sec (nowayout=0)
[    2.637283] wandboard-rfkill rfkill: Wandboard rfkill initialization
[    2.637402] Thread 0 calling (ordered) initcall for driver leds-gpio (gpio-leds)
[    2.637422] wandboard-rfkill rfkill: Turning of power
[    2.639193] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disabled
[    2.639253] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x1 impl platform mode
[    2.639299] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo only pmp pio slum part ccc apst
[    2.640579] scsi host0: ahci-imx
[    2.640902] ata1: SATA max UDMA/133 mmio [mem 0x02200000-0x02203fff] port 0x100 irq 67
[    2.663463] wandboard-rfkill rfkill: initialize wifi chip
[    2.663642] wandboard-rfkill rfkill: wifi-rfkill registered.
[    2.663720] wandboard-rfkill rfkill: initialize bluetooth chip
[    2.663919] wandboard-rfkill rfkill: bluetooth-rfkill registered.
[    2.664289] Thread 1 calling (ordered) initcall for driver imx-gpc (fsl,imx6q-gpc)
[    2.664335] Thread 3 calling (ordered) initcall for driver imx-uart (fsl,imx6q-uart)
[    2.664769] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq = 23, base_baud = 5000000) is a IMX
[    2.983471] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.984610] ata1.00: ATA-8: Hitachi HTS542525K9SA00, BBFOC31P, max UDMA/133
[    2.984620] ata1.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    2.985793] ata1.00: configured for UDMA/133
[    2.985912] Default I/O scheduler not found. Using noop.
[    2.986213] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54252 C31P PQ: 0 ANSI: 5
[    2.986776] scsi 0:0:0:0: Failed to register bsg queue, errno=-19
[    3.734832] console [ttymxc0] enabled
[    3.739241] 21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq = 64, base_baud = 5000000) is a IMX
[    3.748368] Thread 3 calling (ordered) initcall for driver imx-i2c (fsl,imx1-i2c)
[    3.748396] Thread 2 calling (ordered) initcall for driver imx-mmdc (fsl,imx6q-mmdc)
[    3.748413] Thread 1 calling (ordered) initcall for driver fec (fsl,imx25-fec)
[    3.748424] Thread 0 calling (ordered) initcall for driver sdhci-esdhc-imx (fsl,imx25-esdhc)
[    3.749226] 2188000.ethernet supply phy not found, using dummy regulator
[    3.763882] pps pps0: new PPS source ptp0
[    3.776095] libphy: fec_enet_mii_bus: probed
[    3.776656] fec 2188000.ethernet eth0: registered PHC device 0
[    3.776854] Thread 1 calling (ordered) initcall for driver imx-weim (fsl,imx1-weim)
[    3.777206] /soc/aips-bus at 02100000/usdhc at 02190000: voltage-ranges unspecified
[    3.777216] sdhci-esdhc-imx 2190000.usdhc: could not get ultra high speed state, work on normal mode
[    3.777239] sdhci-esdhc-imx 2190000.usdhc: Got CD GPIO
[    3.778409] sdhci-esdhc-imx 2190000.usdhc: No vmmc regulator found
[    3.778415] sdhci-esdhc-imx 2190000.usdhc: No vqmmc regulator found
[    3.823587] mmc0: SDHCI controller on 2190000.usdhc [2190000.usdhc] using ADMA
[    3.823687] imx-weim 21b8000.weim: Driver registered.
[    3.824015] /soc/aips-bus at 02100000/usdhc at 02194000: voltage-ranges unspecified
[    3.824024] sdhci-esdhc-imx 2194000.usdhc: could not get ultra high speed state, work on normal mode
[    3.825203] sdhci-esdhc-imx 2194000.usdhc: No vmmc regulator found
[    3.825209] sdhci-esdhc-imx 2194000.usdhc: No vqmmc regulator found
[    3.873515] mmc1: SDHCI controller on 2194000.usdhc [2194000.usdhc] using ADMA
[    3.873884] /soc/aips-bus at 02100000/usdhc at 02198000: voltage-ranges unspecified
[    3.873894] sdhci-esdhc-imx 2198000.usdhc: could not get ultra high speed state, work on normal mode
[    3.873917] sdhci-esdhc-imx 2198000.usdhc: Got CD GPIO
[    3.875982] sdhci-esdhc-imx 2198000.usdhc: No vmmc regulator found
[    3.875988] sdhci-esdhc-imx 2198000.usdhc: No vqmmc regulator found
[    3.896409] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    3.898115] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    3.899819] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    3.902883] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    3.907303] mmc1: queuing unknown CIS tuple 0x80 (11 bytes)
[    3.913585] mmc2: SDHCI controller on 2198000.usdhc [2198000.usdhc] using ADMA
[    3.957288] mmc1: new high speed SDIO card at address 0001
[    3.965448] i2c i2c-0: IMX I2C adapter registered
[    3.970194] i2c i2c-0: can't use DMA
[    3.974279] i2c i2c-1: IMX I2C adapter registered
[    3.979026] i2c i2c-1: can't use DMA
[    3.983582] Thread 2 calling (unordered) initcall for driver imx-pwm (fsl,imx1-pwm)
[    3.983589] Thread 3 calling (unordered) initcall for driver ahci (generic-ahci)
[    3.983595] Thread 1 calling (unordered) initcall for driver spi_imx (fsl,imx1-cspi)
[    3.983601] Thread 0 calling (unordered) initcall for driver usb_phy_generic (usb-nop-xceiv)
[    3.984137] Thread 3 calling (unordered) initcall for driver mxc_rtc ()
[    3.984142] Thread 1 calling (unordered) initcall for driver ir-kbd-i2c ()
[    3.984147] Thread 0 calling (unordered) initcall for driver imx-snvs-poweroff (fsl,sec-v4.0-poweroff)
[    3.984200] Thread 1 calling (unordered) initcall for driver imx6q-cpufreq ()
[    3.984239] Thread 3 calling (unordered) initcall for driver hdmi-audio-codec (linux,hdmi-audio)
[    3.984289] Thread 1 calling (unordered) initcall for driver rfkill_gpio ()
(...)
-----------
