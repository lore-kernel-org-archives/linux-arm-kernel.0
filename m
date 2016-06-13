From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 13 Jun 2016 11:37:53 +0200
Subject: [PATCH] ARM: dts: sun8i: Add dts file for inet86dz board
In-Reply-To: <CAGb2v66cbx0jta1unrKeYm1t9JKO9Unw8z75rXbW3JSi2=NuMw@mail.gmail.com>
References: <1465754150-16753-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v66cbx0jta1unrKeYm1t9JKO9Unw8z75rXbW3JSi2=NuMw@mail.gmail.com>
Message-ID: <fdfd3d11-3ded-07d6-a7e4-5588b1d30558@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

And to also answer another question I missed before:

On 13-06-16 05:16, Chen-Yu Tsai wrote:

<snip>

>> +&i2c0 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&i2c0_pins_a>;
>> +       status = "okay";
>> +       /*
>> +        * The gsl1680 is rated at 400KHz and it will not work reliable at
>> +        * 100KHz, this has been confirmed on multiple different tablets.
>> +        * The gsl1680 is the only device on this bus.
>> +        */
>> +       clock-frequency = <400000>;
>> +
>> +       gsl1680: touchscreen at 40 {
>> +               compatible = "silead,gsl1680";
>
> Do we already have a driver for this? I don't see one in linux-next.

I've a bunch of students form the local university working on a driver
for this, they should submit it real soon now. That does mean that
including this node is a bit premature as the bindings my change, sorry
I overlooked this.

Regards,

Hans



>
>> +               reg = <0x40>;
>> +               interrupt-parent = <&pio>;
>> +               interrupts = <1 5 IRQ_TYPE_EDGE_FALLING>; /* PB5 */
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&ts_power_pin_inet86dz>;
>> +               power-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
>> +               touchscreen-size-x = <960>;
>> +               touchscreen-size-y = <640>;
>> +               touchscreen-max-fingers = <5>;
>> +               touchscreen-fw-name = "silead/gsl1680-inet86dz.fw";
>> +       };
>> +};
>> +
>> +&i2c1 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&i2c1_pins_a>;
>> +       status = "okay";
>> +};
>> +
>> +&lradc {
>> +       vref-supply = <&reg_vcc3v0>;
>> +       status = "okay";
>> +
>> +       button at 200 {
>> +               label = "Volume Up";
>> +               linux,code = <KEY_VOLUMEUP>;
>> +               channel = <0>;
>> +               voltage = <200000>;
>> +       };
>> +
>> +       button at 400 {
>> +               label = "Volume Down";
>> +               linux,code = <KEY_VOLUMEDOWN>;
>> +               channel = <0>;
>> +               voltage = <400000>;
>> +       };
>> +};
>> +
>> +&mmc0 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_inet86dz>;
>> +       vmmc-supply = <&reg_dcdc1>;
>> +       bus-width = <4>;
>> +       cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
>> +       cd-inverted;
>> +       status = "okay";
>> +};
>> +
>> +&pio {
>> +       bl_en_pin_inet86dz: bl_en_pin at 0 {
>> +               allwinner,pins = "PH6";
>> +               allwinner,function = "gpio_in";
>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +       };
>> +
>> +       mmc0_cd_pin_inet86dz: mmc0_cd_pin at 0 {
>> +               allwinner,pins = "PB4";
>> +               allwinner,function = "gpio_in";
>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +               allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>> +       };
>> +
>> +       ts_power_pin_inet86dz: ts_power_pin at 0 {
>> +               allwinner,pins = "PH1";
>> +               allwinner,function = "gpio_out";
>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +       };
>> +
>> +       usb0_id_detect_pin: usb0_id_detect_pin at 0 {
>> +               allwinner,pins = "PH8";
>> +               allwinner,function = "gpio_in";
>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +               allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>> +       };
>> +};
>> +
>> +&pwm {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pwm0_pins>;
>> +       status = "okay";
>> +};
>> +
>> +&r_rsb {
>> +       status = "okay";
>> +
>> +       axp22x: pmic at 3a3 {
>> +               compatible = "x-powers,axp223";
>> +               reg = <0x3a3>;
>> +               interrupt-parent = <&nmi_intc>;
>> +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +               eldoin-supply = <&reg_dcdc1>;
>
> Adding a drivevbus-supply referencing vcc_5v0 so it doesn't
> show 0V would be nice.
>
> ChenYu
>
>> +               x-powers,drive-vbus-en;
>> +       };
>> +};
>> +
>> +&r_uart {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&r_uart_pins_a>;
>> +       status = "okay";
>> +};
>> +
>> +#include "axp22x.dtsi"
>> +
>> +&reg_aldo1 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <3000000>;
>> +       regulator-max-microvolt = <3000000>;
>> +       regulator-name = "vcc-io";
>> +};
>> +
>> +&reg_aldo2 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <2350000>;
>> +       regulator-max-microvolt = <2650000>;
>> +       regulator-name = "vdd-dll";
>> +};
>> +
>> +&reg_aldo3 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <2700000>;
>> +       regulator-max-microvolt = <3300000>;
>> +       regulator-name = "vcc-pll-avcc";
>> +};
>> +
>> +&reg_dc1sw {
>> +       regulator-name = "vcc-lcd";
>> +};
>> +
>> +&reg_dc5ldo {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <900000>;
>> +       regulator-max-microvolt = <1400000>;
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
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <900000>;
>> +       regulator-max-microvolt = <1400000>;
>> +       regulator-name = "vdd-sys";
>> +};
>> +
>> +&reg_dcdc3 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <900000>;
>> +       regulator-max-microvolt = <1400000>;
>> +       regulator-name = "vdd-cpu";
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
>> +&reg_drivevbus {
>> +       regulator-name = "usb0-vbus";
>> +       status = "okay";
>> +};
>> +
>> +&reg_rtc_ldo {
>> +       regulator-name = "vcc-rtc";
>> +};
>> +
>> +&simplefb_lcd {
>> +       vcc-lcd-supply = <&reg_dc1sw>;
>> +};
>> +
>> +&usb_otg {
>> +       dr_mode = "otg";
>> +       status = "okay";
>> +};
>> +
>> +&usb_power_supply {
>> +       status = "okay";
>> +};
>> +
>> +&usbphy {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&usb0_id_detect_pin>;
>> +       usb0_id_det-gpio = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
>> +       usb0_vbus_power-supply = <&usb_power_supply>;
>> +       usb0_vbus-supply = <&reg_drivevbus>;
>> +       usb1_vbus-supply = <&reg_dldo1>;
>> +       status = "okay";
>> +};
>> --
>> 2.7.4
>>
