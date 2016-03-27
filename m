From: haas@computerlinguist.org (Michael Haas)
Date: Sun, 27 Mar 2016 10:08:01 +0200
Subject: [linux-sunxi] [PATCH 1/3] sunxi: A20-OLinuXino-LIME2: Fix
 ldo3/ldo4 in DTS
In-Reply-To: <56F64ED5.7030405@gmail.com>
References: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
 <56F5DEB9.7070207@gmail.com> <56F64ED5.7030405@gmail.com>
Message-ID: <56F794E1.4080108@computerlinguist.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2016 09:56 AM, Iain Paton wrote:
> Having reread the A20 datasheet yesterday, something in the back of my 
> mind was bothering me overnight so I took some time to check this morning.
>
> On the lime2 schematic we see the pins labeled as follows:
>
> F19 : VCC_CSI0
> E18 : VCC_CSI1
>
> However the A20 datasheet doesn't label them this way, instead using:
>
> F19 : VCC-PE : Port E Power Supply
> E18 : VCC-PG : Port G Power Supply
>
> no mention at all of CSI. CSI just happens to be a function that can be 
> multiplexed onto ports E & G.
>
> So lets assume for a moment we don't have a CSI device, or a CSI driver 
> and are not using those pins for CSI functions but are instead using 
> their default GPIO purpose, or in the case of PG perhaps for UART3 
> or UART4.
>
> What happens when you disable the regulator?  Hopefully from the above 
> you'll already have worked out that you lose ports E & G when you turn 
> their I/O power supply off and anything multiplexed onto those ports 
> becomes unuseable.
>

Hi Iain,

I took some time to go through the data sheets and your analysis is on
point.

I did raise an issue with Olimex via github [0]. Maybe they will update
their schematics.


I do have my breakout board connected to GPIO-1.. and it turns out that
mostly port G is exposed on GPIO-1. I'll be reverting Hans' patch locally
so I can toggle some pins today. I am sure he will contribute his own
thoughts on the matter.


> I've also just tested building u-boot with LDO3 & 4 voltages set to 
> 3.3v to be the same as CubieBoard, this works for lime2.
> So it's unlikely that the 2.8v & 2.3v settings from my previous patch 
> make sense. The crash is actually being caused by something else, 
> probably sequencing, due to unnecessarily turning the regulators off.
> Whatever the reason, we don't have enough information in the 
> datasheets to know for sure so we simply shouldn't turn them off to 
> begin with.


I just tried that on linux and axp20x-regulator.ko refuses to set the
voltage
on ldo4:

[   88.914653] at24 1-0050: 2048 byte 24c16 EEPROM, writable, 16 bytes/write
[   96.893312] axp20x-i2c 0-0034: AXP20x variant AXP209 found
[   96.910631] axp20x-i2c 0-0034: AXP20X driver loaded
[   96.955579] input: axp20x-pek as
/devices/platform/soc at 01c00000/1c2ac00.i2c/i2c-0/0-0034/axp20x-pek/input/input0
[   96.971734] ldo4: failed to apply 3300000uV constraint(-22)
[   96.990646] axp20x-regulator axp20x-regulator: Failed to register ldo4
[   97.012686] axp20x-regulator: probe of axp20x-regulator failed with
error -22

Perhaps this requires another patch [1], but unless there's a real need
for me to verify this,
I'll simply revert the u-boot patch and enjoy working GPIO.

Michael

[0] https://github.com/OLIMEX/OLINUXINO/issues/35
[1] https://www.spinics.net/lists/devicetree/msg118871.html
