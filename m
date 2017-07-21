From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 21 Jul 2017 15:44:07 +0800
Subject: [linux-sunxi] [PATCH 2/3] arm64: allwinner: a64: enable AXP803
 for Banana Pi M64
In-Reply-To: <CAGb2v67Ntz_Qr0ek5sb-RRPnb0W-vEjx4_XC+SzHJDcr7ZLrkg@mail.gmail.com>
References: <20170720230717.58255-1-icenowy@aosc.io>
 <20170720230717.58255-2-icenowy@aosc.io>
 <CAGb2v67Ntz_Qr0ek5sb-RRPnb0W-vEjx4_XC+SzHJDcr7ZLrkg@mail.gmail.com>
Message-ID: <DA3547F4-D0C7-46A9-8C7F-3F1AD7CBCB11@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?7?21? GMT+08:00 ??3:42:07, Chen-Yu Tsai <wens@csie.org> ??:
>On Fri, Jul 21, 2017 at 7:07 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> Banana Pi M64 board uses an AXP803 PMIC.
>>
>> Enable the PMIC and its regulators.
>>
>> As we have now proper regulators support, missing or dummy regulators
>> are changed to the correct ones.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 116
>+++++++++++++++++++--
>>  1 file changed, 106 insertions(+), 10 deletions(-)
>>
>> diff --git
>a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
>b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
>> index 829922d077fb..51d67c0a0edf 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
>> @@ -58,13 +58,6 @@
>>         chosen {
>>                 stdout-path = "serial0:115200n8";
>>         };
>> -
>> -       reg_vcc3v3: vcc3v3 {
>> -               compatible = "regulator-fixed";
>> -               regulator-name = "vcc3v3";
>> -               regulator-min-microvolt = <3300000>;
>> -               regulator-max-microvolt = <3300000>;
>> -       };
>>  };
>>
>>  &ehci1 {
>> @@ -76,6 +69,7 @@
>>         pinctrl-0 = <&rgmii_pins>;
>>         phy-mode = "rgmii";
>>         phy-handle = <&ext_rgmii_phy>;
>> +       phy-supply = <&reg_dc1sw>;
>>         status = "okay";
>>  };
>>
>> @@ -99,7 +93,7 @@
>>  &mmc0 {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&mmc0_pins>;
>> -       vmmc-supply = <&reg_vcc3v3>;
>> +       vmmc-supply = <&reg_dcdc1>;
>>         cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
>>         cd-inverted;
>>         disable-wp;
>> @@ -110,7 +104,8 @@
>>  &mmc1 {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&mmc1_pins>;
>> -       vmmc-supply = <&reg_vcc3v3>;
>> +       vmmc-supply = <&reg_dldo2>;
>> +       vqmmc-supply = <&reg_dldo4>;
>>         bus-width = <4>;
>>         non-removable;
>>         status = "okay";
>> @@ -119,7 +114,7 @@
>>  &mmc2 {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&mmc2_pins>;
>> -       vmmc-supply = <&reg_vcc3v3>;
>> +       vmmc-supply = <&reg_dcdc1>;
>>         bus-width = <8>;
>>         non-removable;
>>         cap-mmc-hw-reset;
>> @@ -130,6 +125,107 @@
>>         status = "okay";
>>  };
>>
>> +&r_rsb {
>> +       status = "okay";
>> +
>> +       axp803: pmic at 3a3 {
>> +               compatible = "x-powers,axp803";
>> +               reg = <0x3a3>;
>> +               interrupt-parent = <&r_intc>;
>> +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +       };
>> +};
>> +
>> +#include "axp803.dtsi"
>> +
>> +&reg_aldo2 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <1800000>;
>> +       regulator-max-microvolt = <3300000>;
>> +       regulator-name = "vcc-pl";
>> +};
>> +
>> +&reg_aldo3 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <3000000>;
>> +       regulator-max-microvolt = <3000000>;
>> +       regulator-name = "vcc-pll-avcc";
>> +};
>> +
>> +&reg_dc1sw {
>> +       regulator-name = "vcc-phy";
>> +};
>> +
>> +&reg_dcdc1 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <3300000>;
>> +       regulator-max-microvolt = <3300000>;
>> +       regulator-name = "vcc-3v3";
>> +};
>> +
>> +&reg_dcdc2 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <1000000>;
>
>The datasheet says the minimum voltage is 1.04V.

A64 datasheet?

Maybe I need to fix all A64 AXP patches.

>
>> +       regulator-max-microvolt = <1300000>;
>> +       regulator-name = "vdd-cpux";
>> +};
>> +
>> +/* DCDC3 is polyphased with DCDC2 */
>> +
>> +&reg_dcdc5 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <1500000>;
>> +       regulator-max-microvolt = <1500000>;
>> +       regulator-name = "vcc-dram";
>> +};
>> +
>> +&reg_dcdc6 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <1100000>;
>> +       regulator-max-microvolt = <1100000>;
>> +       regulator-name = "vdd-sys";
>> +};
>> +
>> +&reg_dldo1 {
>> +       regulator-min-microvolt = <3300000>;
>> +       regulator-max-microvolt = <3300000>;
>> +       regulator-name = "vcc-hdmi-dsi";
>> +};
>> +
>> +&reg_dldo2 {
>> +       regulator-min-microvolt = <3300000>;
>> +       regulator-max-microvolt = <3300000>;
>> +       regulator-name = "vcc-wifi";
>> +};
>> +
>> +&reg_dldo4 {
>> +       regulator-min-microvolt = <1800000>;
>> +       regulator-max-microvolt = <3300000>;
>> +       regulator-name = "vcc-wifi-io";
>> +};
>> +
>> +&reg_eldo1 {
>> +       regulator-min-microvolt = <1800000>;
>> +       regulator-max-microvolt = <1800000>;
>> +       regulator-name = "cpvdd";
>> +};
>> +
>
>It looks like you are missing a few regulators? I assume you
>would add them once the peripherals that use them are added?

Yes.

I mainly dropped CSI part, as it seems so complicate.

>
>Otherwise this patch looks good.
>
>ChenYu
>
>> +/*
>> + * The A64 chip cannot work without this regulator off, although
>> + * it seems to be only driving the AR100 core.
>> + * Maybe we don't still know well about CPUs domain.
>> + */
>> +&reg_fldo2 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <1100000>;
>> +       regulator-max-microvolt = <1100000>;
>> +       regulator-name = "vdd-cpus";
>> +};
>> +
>> +&reg_rtc_ldo {
>> +       regulator-name = "vcc-rtc";
>> +};
>> +
>>  &uart0 {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&uart0_pins_a>;
>> --
>> 2.13.0
>>
>> --
>> You received this message because you are subscribed to the Google
>Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it,
>send an email to linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
