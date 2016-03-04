From: martin@sperl.org (Martin Sperl)
Date: Fri, 4 Mar 2016 10:27:49 +0100
Subject: [PATCH 1/5] ARM: bcm2835: Define standard pinctrl groups in the
 gpio node.
In-Reply-To: <56D8AAA2.60907@wwwdotorg.org>
References: <1456510756-15337-1-git-send-email-eric@anholt.net>
 <1456510756-15337-2-git-send-email-eric@anholt.net>
 <56D8AAA2.60907@wwwdotorg.org>
Message-ID: <6D770203-ED53-413D-AC28-B89A5C48DA8C@sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 03.03.2016, at 22:20, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
> On 02/26/2016 11:19 AM, Eric Anholt wrote:
>> The BCM2835-ARM-Peripherals.pdf documentation specifies what the
>> function selects do for the pins, and there are a bunch of obvious
>> groupings to be made.  With these created, we'll be able to replace
>> bcm2835-rpi.dtsi's main "set all of these pins to alt0" with
>> references to specific groups we want enabled.
> 
>> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> 
>> +			spi0_gpio7: spi0_gpio7 {
>> +				brcm,pins = <7 8 9 10 11>;
>> +				brcm,function = <BCM2835_FSEL_ALT0>;
>> +			};
> 
> This is too many pins.
> 
> - It includes both MOSI and MISO, although a particular use-case may only use 1 of those.
> 
> - It includes both chip-select signals, whereas a particular use-case may use 0, 1, or 2 of those. This is especially true since IIRC the mainline bcm283x SPI driver wants to only use GPIOs for chip-selects, not SPI-controller-generated chip-select signals, to avoid some issues with the HW generation of these signals.
That is true: the spi-bcm2835 driver requires GPIO usage for chip-select
to make all those latency optimizations work (but also to avoid some
spi-dma issues).
The reason behind it is that there are observed short term ?glitches?
on native CS whenever the SPI control register is touched - even with 
identical values.
And GPIO controlled CS solves this issue (and Mark Brown said that
the GPIO-cs interface is now preferred anyway - hence the auxiliary
spi only implement gpio-cs and requires the CS set as OUTPUT, but
unlike the main spi this does not have ?remapping? support for
legacy device-trees (as there never was a driver-version that supported
native-cs).

Maybe split the SPI-portion into 2 sections:
* the SCK, MOSI, MISO (pin 9 to 11) with ALT_0
* the CS GPIOs (standard pins are 7 and 8) with OUTPUT.

That way it is easy to override only this section (plus the gpio-cs property inside the spi node) to extend the number of chip selects or use different mappings.

> 
> I believe a similar comment applies to other SPI nodes too.
I guess the same ?splitting? approach should be taken here as well...
