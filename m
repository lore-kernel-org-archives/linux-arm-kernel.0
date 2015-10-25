From: lyu@micile.com (Lawrence Yu)
Date: Sun, 25 Oct 2015 13:34:16 -0700
Subject: [linux-sunxi] [PATCH v3 1/1] dts: sun6i: yones toptech bs1078 v2:
 Add AXP221 support to dts
In-Reply-To: <CAGb2v671N5Fq1y5S7QZG=b8QPmkzO=ZO6N64rndM2x8sqUXc9A@mail.gmail.com>
References: <1445578955-7984-1-git-send-email-lyu@micile.com>
 <CAGb2v671N5Fq1y5S7QZG=b8QPmkzO=ZO6N64rndM2x8sqUXc9A@mail.gmail.com>
Message-ID: <562D3CC8.2040102@micile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2015 8:24 PM, Chen-Yu Tsai wrote:
> Hi,
>
> On Fri, Oct 23, 2015 at 1:42 PM, Lawrence Yu <lyu@micile.com> wrote:
>> Enable the axp221 PMIC chip in the dts file.
>>
>> Allows board to power off correctly from the poweroff command
>>
>> This board requires dc1sw to be enabled in order to provide a power source
>> for the 5V DCDC converter that powers USB2.
>>
>> This board uses dldo1 for 3.3V wifi power
>>
>> This board requires dldo3 to be enabled at 2.8V in order to provide voltage
>> to the pullup resistors for the i2c0 bus.
>>
>> ---
>> Changes since v2
>>
>> - Rename regulator vcc-dc1sw to vcc-lcd-usb2
>> - Rename regulator vcc-csi to vddio-csi
>> - Remove regulator-always-on from dldo3
>> - Remove comment about LCD backlight and USB2 from reg_dc1sw
>> - Remove comment about dc1sw providing power to LCD backlight in patch
>>    description
>>
>> Changes since v1
>>
>> - Use axp22x.dtsi to standardize the register names
>> - Change wifi power regulator to dldo1 instead of incorrect aldo1
>> - Remove unnecessary gpio pin PH27 for wifi power, since this board uses
>>    the axp221 chip to control power to the wifi chip.
>>
>> Signed-off-by: Lawrence Yu <lyu@micile.com>
>> ---
>>   .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts     | 95 +++++++++++++++++++---
>>   1 file changed, 85 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
>> index b199020..f8873f1 100644
>> --- a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
>> +++ b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
>> @@ -113,22 +113,97 @@
>>          allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>>   };
>>
>> -&reg_usb1_vbus {
>> -       gpio = <&pio 7 27 GPIO_ACTIVE_HIGH>;
>> +&uart0 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&uart0_pins_a>;
>>          status = "okay";
>>   };
>>
>> -&usb1_vbus_pin_a {
>> -       allwinner,pins = "PH27";
>> +&p2wi {
>> +       status = "okay";
>> +
>> +       axp22x: pmic at 68 {
>> +               compatible = "x-powers,axp221";
>> +               reg = <0x68>;
>> +               interrupt-parent = <&nmi_intc>;
>> +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +       };
>>   };
>>
>> -&usbphy {
>> -       usb1_vbus-supply = <&reg_usb1_vbus>;
>> -       status = "okay";
>> +#include "axp22x.dtsi"
>> +
>> +&axp22x {
>> +       regulators {
>> +               reg_dc1sw: dc1sw {
>
> You do not need these extra bits. Just follow what you've
> done for the other regulators. Use the label references
> directly. And please keep the nodes alphabetically sorted.
> You are moving uart0 before all the regulators.
>

I will remove the extra bits for dc1sw and use the label reference for 
it directly.

I will move the uart0 node to after the regulator nodes.  It looks like 
the dts has the ehci0, ehci1, and pio nodes out of alphabetical order 
also.  My opinion is that a separate patch would be more appropriate for 
reordering those nodes since it is not related to the AXP221 support.

> Also, since we'll have regulator support for simplefb,
> you could consider adding them once you've figured out
> the connections.
>

My preference would be to try to add simplefb regulator support in a 
separate patch.

Thanks!

> Thanks
> ChenYu
>
>> +                       regulator-name = "vcc-lcd-usb2";
>> +                       regulator-min-microvolt = <3000000>;
>> +                       regulator-max-microvolt = <3000000>;
>> +               };
>> +       };
>>   };
>>
>> -&uart0 {
>> -       pinctrl-names = "default";
>> -       pinctrl-0 = <&uart0_pins_a>;
>> +&reg_aldo3 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <2700000>;
>> +       regulator-max-microvolt = <3300000>;
>> +       regulator-name = "avcc";
>> +};
>> +
>> +&reg_dc5ldo {
>> +       regulator-min-microvolt = <700000>;
>> +       regulator-max-microvolt = <1320000>;
>> +       regulator-name = "vdd-cpus";
>> +};
>> +
>> +&reg_dcdc1 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <3000000>;
>> +       regulator-max-microvolt = <3000000>;
>> +       regulator-name = "vcc-3v0";
>> +};
>> +
>> +&reg_dcdc2 {
>> +       regulator-min-microvolt = <700000>;
>> +       regulator-max-microvolt = <1320000>;
>> +       regulator-name = "vdd-gpu";
>> +};
>> +
>> +&reg_dcdc3 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <700000>;
>> +       regulator-max-microvolt = <1320000>;
>> +       regulator-name = "vdd-cpu";
>> +};
>> +
>> +&reg_dcdc4 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <700000>;
>> +       regulator-max-microvolt = <1320000>;
>> +       regulator-name = "vdd-sys-dll";
>> +};
>> +
>> +&reg_dcdc5 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <1500000>;
>> +       regulator-max-microvolt = <1500000>;
>> +       regulator-name = "vcc-dram";
>> +};
>> +
>> +&reg_dldo1 {
>> +       regulator-min-microvolt = <3300000>;
>> +       regulator-max-microvolt = <3300000>;
>> +       regulator-name = "vcc-wifi";
>> +};
>> +
>> +/* Voltage source for I2C pullup resistors for I2C Bus 0 */
>> +&reg_dldo3 {
>> +       regulator-min-microvolt = <2800000>;
>> +       regulator-max-microvolt = <2800000>;
>> +       regulator-name = "vddio-csi";
>> +};
>> +
>> +&usbphy {
>> +       usb1_vbus-supply = <&reg_dldo1>;
>> +       usb2_vbus-supply = <&reg_dc1sw>;
>>          status = "okay";
>>   };
>> --
>> 2.5.3
>>
>> --
>> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
