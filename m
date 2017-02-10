From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 10 Feb 2017 17:22:21 +0800
Subject: [PATCH v6 5/5] ARM: dts: sun9i: Initial support for the Sunchip
 CX-A99 board
In-Reply-To: <20170210085920.7l7gswm6yjuqgdfx@lukather>
References: <cover.1486592470.git.rask@formelder.dk>
 <d4211c5d57f80b0281d7d332edc7d69e66202d3d.1486592471.git.rask@formelder.dk>
 <20170210085920.7l7gswm6yjuqgdfx@lukather>
Message-ID: <CAGb2v64AfBW+CHHkFvvNzCGBG09UK-sPcAZi2QgCR9wM=jguxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 4:59 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Feb 09, 2017 at 12:34:06AM +0100, Rask Ingemann Lambertsen wrote:
>> The Suncip CX-A99 board is found in at least four brands of media players.
>> It features an Allwinner A80 ARM SoC and is found in two models:
>>
>> 1) 2 GiB DDR3 DRAM and 16 GB eMMC
>> 2) 4 GiB DDR3 DRAM and 32 GB eMMC
>>
>> For details of the board, see the linux-sunxi page
>> <URL:https://linux-sunxi.org/Sunchip_CX-A99>.
>
> Please don't put URLs in commit logs (and the DT).
>
>>
>> Supported features (+ means tested):
>> + One Cortex-A7 CPU core (or four with experimental U-Boot PSCI patches)
>> + AXP808 power management chip
>> + OZ80120 voltage regulator
>> + Serial console port (internal)
>> + eMMC and SD card slot
>> + USB 2.0 host ports on on-board USB hub
>> + SATA port on on-board SATA-to-USB bridge *
>> + IEEE 802.11 a/b/g/n/ac SDIO Wifi
>> + Real-time clock
>> + LEDs
>> - IR receiver for remote control
>>
>> * Only shows up when a SATA device is connected. Also, if a power source
>>   is connected to the USB 3.0 connector across power cycles (e.g. FEL
>>   boot), the bridge may not properly reset and not show up on the USB bus.
>>   The vendor U-Boot performs some unknown magic which resets the bridge.
>
> Is that magic at the USB level, or specific to the bridge itself?
>
>> So far unsupported features:
>> - Using any of the Cortex-A15 CPU cores
>> - USB 3.0 port (except for supplying 5 V power)
>> - IEEE 802.3 10/100/1000 megabit Ethernet
>> - HDMI connector
>> - S/PDIF audio output
>> - Jack socket with composite video and analog stereo audio
>> - Bluetooth
>> - FM radio receiver (assuming it is even wired on the board)
>
> I guess that should be in your cover letter.
>
> This is not found in your DT, so no one really expects it to work :)
>
>> Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
>> ---
>>
>> Changes in v6:
>> - Updated commit message description of SATA-to-USB bridge quirk and added
>>   note about experimental U-Boot PSCI support for up to four CPU cores.
>> - The blue LED is no longer on by default as its meaning is not documented.
>> - Removed "regulator-boot-on" from regulators having "regulator-always-on".
>> - Removed misleading mention of "OTG connector" which the device doesn't have.
>> - More detailed explanation for the need for "broken-cd" on mmc0.
>> - Several regulators have had their voltage range relaxed a little to match
>>   the permissible range according to the data sheets of the consumers. This
>>   is similar to what is used for the Cubieboard4 and Merrii A80 Optimus.
>> - Shortened regulator dcdce name as per v5 comments. A comment now lists the
>>   pin groups supplied by dcdce.
>>
>> Changes in v5:
>> - Switched pinmux modes to generic properties and dropped
>>   #include <dt-bindings/pinctrl/sun4i-a10.h> as a consequence.
>> - Dropped pinctrl properties from GPIO nodes and dropped the pinmux
>>   nodes for them.
>> - AXP808 regulators added.
>> - Dropped the now unused #include <sunxi-common-regulators.dtsi>.
>> - Ampak AP6335 SDIO-Wifi added.
>> - USB Vbus changes as per v4 comments.
>> - Added "broken-cd" to mmc0 because GPIO interrupts don't work.
>>
>> Changes in v4:
>> - Node names had underscores changed to hyphens.
>> - Changed formatting of the ac100/rtc node's clock output name list to match
>>  that of the same node in the cubieboard4 and a80-optimus device trees.
>>
>> Changes in v3:
>> None.
>>
>> Changes in v2:
>> - Fixed formatting and style issues found by scripts/checkpatch.pl.
>>
>>  arch/arm/boot/dts/Makefile             |   3 +-
>>  arch/arm/boot/dts/sun9i-a80-cx-a99.dts | 409 +++++++++++++++++++++++++++++++++
>>  2 files changed, 411 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/boot/dts/sun9i-a80-cx-a99.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 8553bd7..40546fa 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -862,7 +862,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>>       sun8i-v3s-licheepi-zero.dtb
>>  dtb-$(CONFIG_MACH_SUN9I) += \
>>       sun9i-a80-optimus.dtb \
>> -     sun9i-a80-cubieboard4.dtb
>> +     sun9i-a80-cubieboard4.dtb \
>> +     sun9i-a80-cx-a99.dtb
>>  dtb-$(CONFIG_ARCH_TANGO) += \
>>       tango4-vantage-1172.dtb
>>  dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
>> diff --git a/arch/arm/boot/dts/sun9i-a80-cx-a99.dts b/arch/arm/boot/dts/sun9i-a80-cx-a99.dts
>> new file mode 100644
>> index 0000000..f5496d2
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun9i-a80-cx-a99.dts
>> @@ -0,0 +1,409 @@
>> +/*
>> + * sun9i-a80-cx-a99.dts - Device Tree file for the Sunchip CX-A99 board.
>> + *
>> + * Copyright (C) 2017 Rask Ingemann Lambertsen <rask@formelder.dk>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +/*
>> + * The Sunchip CX-A99 board is found in several similar Android media
>> + * players, such as:
>> + *
>> + * Instabox Fantasy A8 (no external antenna)
>> + * Jesurun CS-Q8 (ships with larger remote control)
>> + * Jesurun Maxone
>> + * Rikomagic (RKM) MK80/MK80LE
>> + * Tronsmart Draco AW80 Meta/Telos
>> + *
>> + * See <URL:https://linux-sunxi.org/Sunchip_CX-A99> for more information.
>> + */
>> +
>> +/dts-v1/;
>> +#include "sun9i-a80.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +     model = "Sunchip CX-A99";
>> +     compatible = "sunchip,cx-a99", "allwinner,sun9i-a80";
>> +
>> +     aliases {
>> +             serial0 = &uart0;
>> +     };
>> +
>> +     chosen {
>> +             stdout-path = "serial0:115200n8";
>> +     };
>> +
>> +     leds {
>> +             compatible = "gpio-leds";
>> +
>> +             blue {
>> +                     gpios = <&pio 6 10 GPIO_ACTIVE_HIGH>;   /* PG10 */
>> +                     label = "cx-a99:blue:status";
>> +             };
>> +
>> +             red {
>> +                     gpios = <&pio 6 11 GPIO_ACTIVE_HIGH>;   /* PG11 */
>> +                     label = "cx-a99:red:status";
>> +             };
>> +     };
>> +
>> +     powerseq_wifi: powerseq-wifi {
>> +             compatible = "mmc-pwrseq-simple";
>> +             clocks = <&ac100_rtc 1>;
>> +             clock-names = "ext_clock";
>> +             reset-gpios = <&r_pio 1 0 GPIO_ACTIVE_LOW>;     /* PM0 */
>> +             post-power-on-delay-ms = <1>;   /* Minimum 2 cycles. */
>> +     };
>> +
>> +     /* USB 3.0 standard-A receptacle. For now, only Vbus is supported. */
>
> I'm not sure what you mean by "only VBUS is supported"? Is there any
> other signal?
>
>> +     reg_usb0_vbus: regulator-usb0-vbus {
>> +             compatible = "regulator-fixed";
>> +             regulator-name = "usb0-vbus";
>> +             regulator-min-microvolt = <5000000>;
>> +             regulator-max-microvolt = <5000000>;
>> +             gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>;    /* PH15 */
>> +             enable-active-high;
>
> This is redundant with the GPIO flag
>
>> +             regulator-always-on;
>
> And it shouldn't be always on. The USB driver will enable it if needs
> be.
>
>> +     };
>> +
>> +     /*
>> +      * A GL850G hub with two external USB connectors is connected
>> +      * to ehci0. Each has a Vbus regulator controlled by a GPIO:
>> +      * PL7 for port 1, closest to the 12 V power connector, and
>> +      * PL8 for port 2, next to the SD card slot.
>> +      * Because regulator-fixed doesn't support a GPIO list, and
>> +      * allwinner,sun9i-a80-usb-phy doesn't support more than one
>> +      * supply, we have to use regulator-always-on on usb1-2-vbus.
>> +      * Note that the GPIO pins also need cldo1 to be enabled.
>> +      */
>
> What is the source of those regulators connected then? Some PMIC
> regulator? AC-IN?
>
>> +     reg_usb1_1_vbus: regulator-usb1-1-vbus {
>> +             compatible = "regulator-fixed";
>> +             regulator-name = "usb1-1-vbus";
>> +             regulator-min-microvolt = <5000000>;
>> +             regulator-max-microvolt = <5000000>;
>> +             gpio = <&r_pio 0 7 GPIO_ACTIVE_HIGH>;   /* PL7 */
>> +             enable-active-high;
>> +     };
>> +
>> +     reg_usb1_2_vbus: regulator-usb1-2-vbus {
>> +             compatible = "regulator-fixed";
>> +             regulator-name = "usb1-2-vbus";
>> +             regulator-min-microvolt = <5000000>;
>> +             regulator-max-microvolt = <5000000>;
>> +             gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>;   /* PL8 */
>> +             enable-active-high;
>> +             regulator-always-on;
>
> Same comment about always on. If the driver needs fixing to grab an
> additional regulator, fix it, but this shouldn't be left that way.
>
>> +     };
>> +
>> +     /* OZ80120 voltage regulator for the four Cortex-A15 cores. */
>> +     reg_vdd_cpub: regulator-vdd-cpub {
>> +             compatible = "regulator-gpio";
>> +
>> +             regulator-always-on;
>> +             regulator-min-microvolt = < 800000>;
>> +             regulator-max-microvolt = <1100000>;
>> +             regulator-name = "vdd-cpub";
>> +
>> +             enable-gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>;    /* PL2 */
>> +             enable-active-high;
>> +             gpios = <&r_pio 0 3 GPIO_ACTIVE_HIGH>,          /* PL3 */
>> +                     <&r_pio 0 4 GPIO_ACTIVE_HIGH>,          /* PL4 */
>> +                     <&r_pio 0 5 GPIO_ACTIVE_HIGH>;          /* PL5 */
>> +
>> +             gpios-states = <1 0 0>;
>> +             states = <       750000 0x7
>> +                              800000 0x3
>> +                              850000 0x5
>> +                              900000 0x1
>> +                              950000 0x6
>> +                             1000000 0x2
>> +                             1100000 0x4
>> +                             1200000 0x0>;
>
> You're listing a minimum state of 750mv, yet your minimum voltage is
> 800mV.
>
>> +     };
>> +};
>> +
>> +&ehci0 {
>> +     status = "okay";
>> +};
>> +
>> +&ehci2 {
>> +     status = "okay";
>> +};
>> +
>> +/*
>> + * SD card slot. Although the GPIO pin for card detection is listed as capable
>> + * of generating interrupts in the "A80 User Manual", this doesn't work for
>> + * some unknown reason, so poll the GPIO for card detection. This is also what
>> + * the vendor sys_config.fex file specifies.
>> + */
>> +&mmc0 {
>> +     bus-width = <4>;
>> +     cd-gpios = <&pio 7 17 GPIO_ACTIVE_LOW>; /* PH17 */
>> +     broken-cd;                              /* Poll. */
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&mmc0_pins>;
>> +     vmmc-supply = <&reg_dcdce>;
>> +     status = "okay";
>> +};
>> +
>> +/* Ampak AP6335 IEEE 802.11 a/b/g/n/ac "Wifi". */
>
> Why "wifi" ? It's not implementing true wifi?
>
>> +&mmc1 {
>> +     bus-width = <4>;
>> +     non-removable;
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&mmc1_pins>;
>> +     vmmc-supply = <&reg_cldo3>;     /* See cldo2,cldo3 note. */
>> +     vqmmc-supply = <&reg_aldo2>;
>
> So it's able to support 1.2 or 1.8V IO modes? Surely you want to
> enable those modes here to.
>
>> +     mmc-pwrseq = <&powerseq_wifi>;
>> +     status = "okay";
>> +};
>> +
>> +/* On-board eMMC card. */
>> +&mmc2 {
>> +     bus-width = <8>;
>> +     non-removable;
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&mmc2_8bit_pins>;
>> +     vmmc-supply = <&reg_dcdce>;
>> +     status = "okay";
>> +};
>> +
>> +&osc32k {
>> +     clocks = <&ac100_rtc 0>;
>> +};
>> +
>> +&r_ir {
>> +     status = "okay";
>> +};
>> +
>> +&r_rsb {
>> +     status = "okay";
>> +
>> +     ac100: codec at e89 {
>> +             compatible = "x-powers,ac100";
>> +             reg = <0xe89>;
>> +
>> +             ac100_codec: codec {
>> +                     compatible = "x-powers,ac100-codec";
>> +                     interrupt-parent = <&r_pio>;
>> +                     interrupts = <0 9 IRQ_TYPE_LEVEL_LOW>;  /* PL9 */
>> +                     #clock-cells = <0>;
>> +                     clock-output-names = "4M_adda";
>> +             };
>> +
>> +             ac100_rtc: rtc {
>> +                     compatible = "x-powers,ac100-rtc";
>> +                     interrupt-parent = <&nmi_intc>;
>> +                     interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +                     clocks = <&ac100_codec>;
>> +                     #clock-cells = <1>;
>> +                     clock-output-names = "cko1_rtc",
>> +                                          "cko2_rtc",
>> +                                          "cko3_rtc";
>> +             };
>> +     };
>> +
>> +     pmic at 745 {
>> +             compatible = "x-powers,axp808", "x-powers,axp806";

As you mentioned elsewhere, they are not really compatible.
You should drop the latter compatible.

>> +             reg = <0x745>;
>> +             interrupt-parent = <&nmi_intc>;
>> +             interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +             interrupt-controller;
>> +             #interrupt-cells = <1>;
>> +
>> +             swin-supply = <&reg_dcdce>;
>
> Please use an incude for that PMIC.

Hmm, there isn't one for the AXP806 either.

Some more info about the regulator names:

>> +
>> +             /* In comments: Initial setup from vendor sys_config.fex. */
>> +             regulators {
>> +                     /* 3.0 V (enabled). */
>
> This might be disabled though.
>
>> +                     reg_aldo1: aldo1 {
>> +                             regulator-boot-on;
>> +                             regulator-min-microvolt = <3000000>;
>> +                             regulator-max-microvolt = <3000000>;
>> +                             regulator-name = "vcc-3v0";
>> +                     };
>> +
>> +                     /* 1.8 V (enabled). */
>> +                     reg_aldo2: aldo2 {
>> +                             regulator-boot-on;
>> +                             regulator-min-microvolt = <1800000>;
>> +                             regulator-max-microvolt = <3600000>;
>> +                             regulator-name = "vcc-pg-pm-wifi+btio-audio";
>
> Usually, there is simpler names available on the schematics, or at
> least simpler names we can come up with.
>
> Something like vcc-wifi would be enough her.

It should be vddio-wifi. Looking at the pin groups it names, it likely
just drives the I/O pins on both ends.

>
>> +                     };
>> +
>> +                     /* 2.5 V (enabled). */
>> +                     reg_aldo3: aldo3 {
>> +                             regulator-boot-on;
>> +                             regulator-min-microvolt = <2500000>;
>> +                             regulator-max-microvolt = <2500000>;
>> +                             regulator-name = "vcc-pa-gmac2v5";
>
> vcc-gmac

vcc-pa or vddio-gmac. 2.5V is for RGMII I/O. vcc-gmac is the "sw"
regulator @ 3.3V.

>
>> +                     };
>> +
>> +                     /* 1.8 V (enabled). */
>> +                     reg_bldo1: bldo1 {
>> +                             regulator-always-on;    /* Hang if disabled */
>> +                             regulator-min-microvolt = <1700000>;
>> +                             regulator-max-microvolt = <1900000>;
>> +                             regulator-name = "vdd18-dll-vcc18-pll";
>
> vdd-dll

PLLs and DLLs are different though. Maybe vcc-pll-dll?

>
>> +                     };
>> +
>> +                     /* 0.9 V (enabled). */
>> +                     reg_bldo2: bldo2 {
>> +                             regulator-always-on;    /* Hang if disabled */
>> +                             regulator-min-microvolt = < 800000>;
>> +                             regulator-max-microvolt = <1100000>;
>> +                             regulator-name = "vdd-cpus";
>> +                     };
>> +
>> +                     /* 1.2 V (disabled). */
>> +                     reg_bldo3: bldo3 {
>> +                             regulator-min-microvolt = <1100000>;
>> +                             regulator-max-microvolt = <1300000>;
>> +                             regulator-name = "vcc12-hsic";
>
> vcc-hsic

vcc12-hsic is actually the name listed in the SoC datasheet.

>
>> +                     };
>> +
>> +                     /* 1.1 V (enabled). */
>> +                     reg_bldo4: bldo4 {
>> +                             regulator-boot-on;
>> +                             regulator-min-microvolt = < 800000>;
>> +                             regulator-max-microvolt = <1100000>;
>> +                             regulator-name = "vdd09-hdmi";
>
> vdd-hdmi

vdd09-hdmi is actually the name listed in the SoC datasheet.

>
>> +                     };
>> +
>> +                     /* 3.3 V (enabled). PLx pins control some regulators. */
>> +                     reg_cldo1: cldo1 {
>> +                             regulator-always-on;
>> +                             regulator-min-microvolt = <3300000>;
>> +                             regulator-max-microvolt = <3300000>;
>> +                             regulator-name = "vcc-pl-led";
>
> vcc-led, etc...

vcc-pl is probably better... One can figure out the LEDs are connected to the
PL group and maybe realize they are powered this way. Not that easy the other
way around.

I used really long names for the other 2 A80 boards though.


Regards
ChenYu

>
> Thanks,
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
