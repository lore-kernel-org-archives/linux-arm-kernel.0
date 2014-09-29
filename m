From: ipaton0@gmail.com (Iain Paton)
Date: Mon, 29 Sep 2014 15:32:43 +0100
Subject: [PATCH] ARM: sun7i: add support for A20-OLinuXino-Lime2
In-Reply-To: <20140929132543.GC4081@lukather>
References: <54280AA7.1090401@gmail.com> <20140928164337.GB15315@lukather>
 <54295711.9010901@gmail.com> <20140929132543.GC4081@lukather>
Message-ID: <54296D8B.3080304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/09/14 14:25, Maxime Ripard wrote:
> On Mon, Sep 29, 2014 at 01:56:49PM +0100, Iain Paton wrote:

>> What additional patches are we talking about?  The following:
>> regulator: axp20x: Use parent device as regulator configuration device
>> i2c: mv64xxx: continue probe when clock-frequency is missing
>> or are there others I'd need to pick out of linux-next?
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/288901.html

Ok, I'll pull those on top of something not quite as bleeding edge as linux-next

> Leave it out then. If you have no way to test it, it's going to be
> very bug prone, and we can always add it later.

I moved my root disk to a SATA drive, so only a minor inconvenience.

dmesg shows the following with the regulators node as in the v2 patch, 
the bottom half being mostly what I'd expect

[    0.868607] sunxi-rtc 1c20d00.rtc: RTC enabled
[    0.877062] Adding alias for supply acin,(null) -> acin,0-0034
[    0.882948] Adding alias for supply vin2,(null) -> vin2,0-0034
[    0.888775] Adding alias for supply vin3,(null) -> vin3,0-0034
[    0.894612] Adding alias for supply ldo24in,(null) -> ldo24in,0-0034
[    0.900956] Adding alias for supply ldo3in,(null) -> ldo3in,0-0034
[    0.907160] Adding alias for supply ldo5in,(null) -> ldo5in,0-0034
[    0.914029] LDO1: 1300 mV 
[    0.917428] LDO2: 1800 <--> 3300 mV at 3000 mV 
[    0.922483] LDO3: 700 <--> 3500 mV at 2275 mV 
[    0.927136] LDO4: 1250 <--> 3300 mV at 2800 mV 
[    0.932334] LDO5: 1800 <--> 3300 mV at 2800 mV 
[    0.937308] DCDC2: 1400 mV 
[    0.940552] DCDC3: 1250 mV 
[    0.943474] axp20x 0-0034: AXP20X driver loaded


> The SD card issue is more troublesome. We'll have to look into it.

dmesg shows the mmc driver loading:

[    0.957716] sdhci: Secure Digital Host Controller Interface driver
[    0.963963] sdhci: Copyright(c) Pierre Ossman
[    0.968843] sunxi-mmc 1c0f000.mmc: No vqmmc regulator found
[    0.974918] sunxi-mmc 1c0f000.mmc: Got CD GPIO
[    1.012036] sunxi-mmc 1c0f000.mmc: base:0xf00ac000 irq:64
[    1.017623] sdhci-pltfm: SDHCI platform and OF driver helper

however on an older, working, kernel I get a number on the end of 
the 'Got CD GPIO' line like this:

[    0.896271] sunxi-mmc 1c0f000.mmc: Got CD GPIO #225.

when I remove the SD card I see:

[   20.147667] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 8, RTO !!
[   20.157319] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 55, RTO !!
[   20.163796] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 55, RTO !!
[   20.170268] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 55, RTO !!
[   20.176743] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 55, RTO !!
[   20.183250] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 1, RTO !!

Which gives the impression that it's seeing CD inverted, however I 
tried taking the cd-inverted; line out of the dts with no change.
No messages at all on card insertion.

I'll try the same kernel on an A10-lime later, if it has the same 
problem it'll rule out something in this new dts.

Iain
