From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 31 Jul 2018 21:42:59 +0800
Subject: [PATCH] arm64: allwinner: h6: Add OrangePi One Plus initial
 support
In-Reply-To: <CAMty3ZBNM7mdtkBSq5BGuGoa5jKdSuuSVxkOoqPhDJZ-NM2THQ@mail.gmail.com>
References: <20180728182615.20845-1-jagan@amarulasolutions.com>
 <20180730090048.gl7fkduztjkxacqq@flea>
 <CAGb2v67wKFp2Fntm2O0xGXZjbyTZ_3YjRrD6b612jer1DDXxZw@mail.gmail.com>
 <CAMty3ZBNM7mdtkBSq5BGuGoa5jKdSuuSVxkOoqPhDJZ-NM2THQ@mail.gmail.com>
Message-ID: <CAGb2v66Br9-KB-AD+N9mqRQ7rhrzYqUAQDkiepf2+3=FOgWKLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 9:41 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> On Mon, Jul 30, 2018 at 2:47 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>> On Mon, Jul 30, 2018 at 5:00 PM, Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>>> Hi,
>>>
>>> On Sat, Jul 28, 2018 at 11:56:15PM +0530, Jagan Teki wrote:
>>>> OrangePi One Plus is Allwinner H6 based open-source SBC,
>>>> which support:
>>>> - Allwinner H6 Quad-core 64-bit ARM Cortex-A53
>>>> - GPU Mali-T720
>>>> - 1GB LPDDR3 RAM
>>>> - AXP805 PMIC
>>>> - 1Gbps GMAC via RTL8211
>>>> - USB 2.0 Host, OTG
>>>> - HDMI port
>>>> - 5V/2A DC power supply
>>>>
>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>> ---
>>>>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>>>>  .../allwinner/sun50i-h6-orangepi-one-plus.dts | 150 ++++++++++++++++++
>>>>  2 files changed, 151 insertions(+)
>>>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>>>>
>>>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
>>>> index 9ffa7a038791..c38f326e7fec 100644
>>>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>>>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>>>> @@ -15,4 +15,5 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
>>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
>>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
>>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
>>>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
>>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>>>> new file mode 100644
>>>> index 000000000000..0612c19cd994
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>>>> @@ -0,0 +1,150 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>>>> +/*
>>>> + * Copyright (C) 2018 Amarula Solutions
>>>> + * Author: Jagan Teki <jagan@amarulasolutions.com>
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "sun50i-h6.dtsi"
>>>> +
>>>> +#include <dt-bindings/gpio/gpio.h>
>>>> +
>>>> +/ {
>>>> +     model = "OrangePi One Plus";
>>>> +     compatible = "xunlong,orangepi-one-plus", "allwinner,sun50i-h6";
>>>> +
>>>> +     aliases {
>>>> +             serial0 = &uart0;
>>>> +     };
>>>> +
>>>> +     chosen {
>>>> +             stdout-path = "serial0:115200n8";
>>>> +     };
>>>> +};
>>>> +
>>>> +&mmc0 {
>>>> +     pinctrl-names = "default";
>>>> +     pinctrl-0 = <&mmc0_pins>;
>>>> +     vmmc-supply = <&reg_cldo1>;
>>>> +     cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
>>>> +     bus-width = <4>;
>>>> +     status = "okay";
>>>> +};
>>>> +
>>>> +&r_i2c {
>>>> +     status = "okay";
>>>> +
>>>> +     axp805: pmic at 36 {
>>>> +             compatible = "x-powers,axp805", "x-powers,axp806";
>>>> +             reg = <0x36>;
>>>> +             interrupt-parent = <&r_intc>;
>>>> +             interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>>>> +             interrupt-controller;
>>>> +             #interrupt-cells = <1>;
>>>> +             x-powers,self-working-mode;
>>>> +
>>>> +             regulators {
>>>> +                     reg_aldo1: aldo1 {
>>>> +                             regulator-always-on;
>>>> +                             regulator-min-microvolt = <3300000>;
>>>> +                             regulator-max-microvolt = <3300000>;
>>>> +                             regulator-name = "vcc-pl";
>>>> +                     };
>>>> +
>>>> +                     reg_aldo2: aldo2 {
>>>> +                             regulator-min-microvolt = <3300000>;
>>>> +                             regulator-max-microvolt = <3300000>;
>>>> +                             regulator-name = "vcc-ac200";
>>>> +                     };
>>>> +
>>>> +                     reg_aldo3: aldo3 {
>>>> +                             regulator-always-on;
>>>> +                             regulator-min-microvolt = <3300000>;
>>>> +                             regulator-max-microvolt = <3300000>;
>>>> +                             regulator-name = "vcc25-dram";
>>>> +                     };
>>>> +
>>>> +                     reg_bldo1: bldo1 {
>>>> +                             regulator-always-on;
>>>> +                             regulator-min-microvolt = <1800000>;
>>>> +                             regulator-max-microvolt = <1800000>;
>>>> +                             regulator-name = "vcc-bias-pll";
>>>> +                     };
>>>> +
>>>> +                     reg_bldo2: bldo2 {
>>>> +                             regulator-always-on;
>>>> +                             regulator-min-microvolt = <1800000>;
>>>> +                             regulator-max-microvolt = <1800000>;
>>>> +                             regulator-name = "vcc-efuse-pcie-hdmi-io";
>>>> +                     };
>>>> +
>>>> +                     reg_bldo3: bldo3 {
>>>> +                             regulator-always-on;
>>>> +                             regulator-min-microvolt = <1800000>;
>>>> +                             regulator-max-microvolt = <1800000>;
>>>> +                             regulator-name = "vcc-dcxoio";
>>>> +                     };
>>>> +
>>>> +                     bldo4 {
>>>> +                             /* unused */
>>>> +                     };
>>>> +
>>>> +                     reg_cldo1: cldo1 {
>>>> +                             regulator-always-on;
>>>> +                             regulator-min-microvolt = <3300000>;
>>>> +                             regulator-max-microvolt = <3300000>;
>>>> +                             regulator-name = "vcc-3v3";
>>>> +                     };
>>>> +
>>>> +                     reg_cldo2: cldo2 {
>>>> +                             regulator-min-microvolt = <3300000>;
>>>> +                             regulator-max-microvolt = <3300000>;
>>>> +                             regulator-name = "vcc-wifi-1";
>>>> +                     };
>>>> +
>>>> +                     reg_cldo3: cldo3 {
>>>> +                             regulator-min-microvolt = <3300000>;
>>>> +                             regulator-max-microvolt = <3300000>;
>>>> +                             regulator-name = "vcc-wifi-2";
>>>> +                     };
>>>> +
>>>> +                     reg_dcdca: dcdca {
>>>> +                             regulator-always-on;
>>>> +                             regulator-min-microvolt = <810000>;
>>>> +                             regulator-max-microvolt = <1080000>;
>>>> +                             regulator-name = "vdd-cpu";
>>>> +                     };
>>>> +
>>>> +                     reg_dcdcc: dcdcc {
>>>> +                             regulator-min-microvolt = <810000>;
>>>> +                             regulator-max-microvolt = <1080000>;
>>>> +                             regulator-name = "vdd-gpu";
>>>> +                     };
>>>> +
>>>> +                     reg_dcdcd: dcdcd {
>>>> +                             regulator-always-on;
>>>> +                             regulator-min-microvolt = <960000>;
>>>> +                             regulator-max-microvolt = <960000>;
>>>> +                             regulator-name = "vdd-sys";
>>>> +                     };
>>>> +
>>>> +                     reg_dcdce: dcdce {
>>>> +                             regulator-always-on;
>>>> +                             regulator-min-microvolt = <1200000>;
>>>> +                             regulator-max-microvolt = <1200000>;
>>>> +                             regulator-name = "vcc-dram";
>>>> +                     };
>>>> +
>>>> +                     sw {
>>>> +                             /* unused */
>>>> +                     };
>>>
>>> Can't we have a DTSI for this PMIC too?
>>
>> Back when we started adding the regulators, Mark wasn't too happy with
>> all the placeholders we put in the dtsi. I think we got away with it
>> because we had other things in there as well. That's not true for this
>> particular PMIC.
>
> So we need separate dtsi for this PMIC as well?

I don't think we do. We don't gain much.

ChenYu
